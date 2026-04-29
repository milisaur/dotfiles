{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    shellAliases = {
      nosleep = "systemd-inhibit --what=idle:sleep --why='manual override' sleep";
    };

    initContent = ''
            # ----- prompt -----
      autoload -U colors && colors
      autoload -Uz vcs_info

      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' formats ' %F{#a6e3a1} %b%f'
      zstyle ':vcs_info:git:*' actionformats ' %F{#f9e2af} %b|%a%f'

      precmd() {
        vcs_info
      }

      setopt PROMPT_SUBST

      PROMPT='%F{#a6e3a1}%n@%m%f %F{#89b4fa}%~%f''${vcs_info_msg_0_}
      %F{#6c7086}❯%f '


            setopt AUTO_CD
            setopt AUTO_PUSHD
            setopt PUSHD_IGNORE_DUPS
            setopt PUSHD_SILENT

            setopt HIST_IGNORE_DUPS
            setopt HIST_IGNORE_ALL_DUPS
            setopt HIST_FIND_NO_DUPS
            setopt HIST_REDUCE_BLANKS
            setopt SHARE_HISTORY

            setopt INTERACTIVE_COMMENTS
            setopt NO_BEEP

            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
            zstyle ':completion:*' verbose yes
            zstyle ':completion:*:descriptions' format '%F{244}-- %d --%f'
            zstyle ':completion:*:messages' format '%F{244}-- %d --%f'
            zstyle ':completion:*:warnings' format '%F{244}No matches found%f'
            zstyle ':completion:*' group-name ""

            bindkey -e
            bindkey '^[[1;5C' forward-word
            bindkey '^[[1;5D' backward-word
            bindkey '^H' backward-kill-word
            bindkey '^[[3~' delete-char

            if command -v fzf >/dev/null 2>&1; then
              source <(${pkgs.fzf}/bin/fzf --zsh)
            fi
    '';
  };

  home.packages = with pkgs; [
    fzf
  ];
}
