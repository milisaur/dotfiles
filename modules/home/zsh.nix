{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      nosleep = "systemd-inhibit --what=idle:sleep --why='manual override' sleep";
    };

    initContent = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
