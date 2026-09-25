{ pkgs, hostName, ... }:

let
  wallpaperDir = ../../../assets/wallpapers + "/${hostName}";

  wallpaperControl = pkgs.writeShellApplication {
    name = "wallpaper-control";

    runtimeInputs = with pkgs; [
      coreutils
      findutils
      hyprland
    ];

    text = ''
      wallpaper_dir="${wallpaperDir}"

      state_dir="$HOME/.local/state/hyprpaper"
      state_file="$state_dir/current"

      mkdir -p "$state_dir"

      mapfile -t wallpapers < <(
        find "$wallpaper_dir" \
          -maxdepth 1 \
          -type f \
          \( \
            -iname '*.jpg' \
            -o -iname '*.jpeg' \
            -o -iname '*.png' \
            -o -iname '*.webp' \
          \) \
          ! -name 'lock.jpg' \
          | sort
      )

      count="''${#wallpapers[@]}"

      if (( count == 0 )); then
        echo "No wallpapers found in $wallpaper_dir" >&2
        exit 1
      fi

      # Wait until hyprpaper's IPC socket is available.
      ready=0

      for _ in $(seq 1 30); do
        if hyprctl hyprpaper listactive >/dev/null 2>&1; then
          ready=1
          break
        fi

        sleep 0.1
      done

      if (( ready == 0 )); then
        echo "hyprpaper is not running" >&2
        exit 1
      fi

      current_name=""

      if [[ -f "$state_file" ]]; then
        current_name="$(cat "$state_file")"
      fi

      current_index=-1

      for i in "''${!wallpapers[@]}"; do
        if [[ "''${wallpapers[$i]##*/}" == "$current_name" ]]; then
          current_index="$i"
          break
        fi
      done

      action="''${1:-restore}"

      case "$action" in
        restore)
          if (( current_index >= 0 )); then
            target="''${wallpapers[$current_index]}"
          else
            target="''${wallpapers[0]}"
          fi
          ;;

        next)
          if (( current_index >= 0 )); then
            index=$(( (current_index + 1) % count ))
          else
            index=0
          fi

          target="''${wallpapers[$index]}"
          ;;

        previous|prev)
          if (( current_index >= 0 )); then
            index=$(( (current_index - 1 + count) % count ))
          else
            index=$(( count - 1 ))
          fi

          target="''${wallpapers[$index]}"
          ;;

        random)
          if (( count == 1 )); then
            index=0
          else
            while true; do
              index="$(shuf -i 0-$((count - 1)) -n 1)"

              if (( index != current_index )); then
                break
              fi
            done
          fi

          target="''${wallpapers[$index]}"
          ;;

        *)
          echo "Usage: wallpaper-control {next|previous|random|restore}" >&2
          exit 1
          ;;
      esac

      hyprctl hyprpaper wallpaper ", $target, cover"

      printf '%s\n' "''${target##*/}" > "$state_file"
    '';
  };
in
{
  home.packages = [
    pkgs.hyprpaper
    wallpaperControl
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    splash = false
    ipc = true
  '';
}
