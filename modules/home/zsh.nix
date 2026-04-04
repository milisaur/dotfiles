{ ... }:

{
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
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#spinosaurus";
    };

    initContent = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
