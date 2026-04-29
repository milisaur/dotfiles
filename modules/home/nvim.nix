{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";
        transparent_background = true;
        integrations = {
          treesitter = true;
          gitsigns = true;
          cmp = true;
          telescope.enabled = true;
          native_lsp.enabled = true;
        };
      };
    };

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
      cursorline = true;
      updatetime = 250;
      signcolumn = "yes";
    };

    clipboard.register = "unnamedplus";

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
    };

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      gitsigns.enable = true;

      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          pyright.enable = true;
          r_language_server = {
            enable = true;
            package = null;
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        autoLoad = true;

        settings = {
          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };

          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            go = ["gofmt"];
            python = ["black"];
            r = ["styler"];
            nix = ["alejandra"];
          };
        };
      };
    };

    extraPackages = with pkgs; [
      black
      alejandra
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
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      }
    ];

    autoCmd = [
      {
        event = ["BufWritePre"];
        callback = {
          __raw = ''
            function()
              require("conform").format({ async = false })
            end
          '';
        };
      }
    ];
  };
}
