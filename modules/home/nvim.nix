{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      updatetime = 250;
      signcolumn = "yes";
    };

    clipboard.register = "unnamedplus";

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      treesitter.settings.highlight.enable = true;
      gitsigns.enable = true;

      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          pyright.enable = true;
          r_language_server.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            go = [ "gofmt" ];
            python = [ "black" ];
            r = [ "styler" ];
          };
        };
      };
    };

    extraPackages = with pkgs; [
      black
      rPackages.styler
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
      }
    ];
  };
}
