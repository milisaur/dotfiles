{pkgs, ...}: let
  version = "1.11.1";

  robocodeDist = pkgs.stdenvNoCC.mkDerivation {
    pname = "robocode";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://downloads.sourceforge.net/project/robocode/robocode/${version}/robocode-${version}-setup.jar";
      hash = "sha256-dOJt4TgXDyf//tniNwc+8hO8bgzbv9rnGlcwz2DVCmw=";
    };

    nativeBuildInputs = [
      pkgs.jdk25
    ];

    dontUnpack = true;

    installPhase = ''
      export HOME="$TMPDIR"

      mkdir -p "$out/share/robocode"

      ${pkgs.jdk25}/bin/java \
        -jar "$src" \
        "$out/share/robocode" \
        silent
    '';
  };

  robocode = pkgs.writeShellApplication {
    name = "robocode";

    runtimeInputs = [
      pkgs.coreutils
      pkgs.jdk25
    ];

    text = ''
      root="''${XDG_DATA_HOME:-$HOME/.local/share}/robocode"
      app="$root/app-${version}"
      robots="$root/robots"
      battles="$root/battles"

      if [ ! -e "$app/.installed" ]; then
        mkdir -p "$app"

        cp -a \
          "${robocodeDist}/share/robocode/." \
          "$app/"

        chmod -R u+w "$app"

        if [ ! -e "$robots" ]; then
          cp -a "$app/robots" "$robots"
        fi

        if [ ! -e "$battles" ]; then
          cp -a "$app/battles" "$battles"
        fi

        touch "$app/.installed"
      fi

      mkdir -p "$robots" "$battles"

      export JAVA_HOME="${pkgs.jdk25}"

      cd "$app"

      exec "${pkgs.jdk25}/bin/java" \
        -Dsun.awt.disablegrab=true \
        "-DROBOTPATH=$robots" \
        "-DBATTLEPATH=$battles" \
        -jar libs/robocode.jar \
        "$@"
    '';
  };
in {
  home.packages = [
    robocode
  ];

  xdg.desktopEntries.robocode = {
    name = "Robocode";
    genericName = "Java Programming Game";
    comment = "Program battle tanks in Java";
    exec = "${robocode}/bin/robocode";
    terminal = false;

    categories = [
      "Development"
      "Education"
      "Game"
    ];
  };
}
