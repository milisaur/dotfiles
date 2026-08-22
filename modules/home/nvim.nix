{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;

    nixpkgs.source = inputs.nixvim.inputs.nixpkgs;

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
      toggleterm = {
        enable = true;
        settings = {
          size = 20; # Höhe des Terminals
          direction = "vertical"; # Split nach rechts/unten
          open_mapping = {
            __raw = "'<c-t>'";
          };
          hide_numbers = true;
          shade_filetypes = {};
          shade_terminals = true;
          shading_factor = 2;
          start_in_insert = true;
          insert_mappings = true;
          persist_size = true;
          persist_mode = true;
          close_on_exit = true;
          shell = "${pkgs.zsh}/bin/zsh"; # Nutzt deine ZSH
        };
      };

      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;

          ensure_installed = [
            "markdown"
            "markdown_inline"
            "r"
            "python"
            "yaml"
            "bash"
            "go"
          ];
        };
      };
      quarto.enable = true;
      otter.enable = true;

      gitsigns.enable = true;

      lsp = {
        enable = true;
        servers = {
          gopls = {
            enable = true;
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true;
                  compositeLiteralFields = true;
                  constantValues = true;
                  functionTypeParameters = true;
                  parameterNames = true;
                  rangeVariableTypes = true;
                };
              };
            };
          };

          pyright.enable = true;
          r_language_server = {
            enable = true;
            package = null;
            extraOptions = {
              settings = {
                r.lsp.diagnostics = false;
              };
            };
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
            "<C-Space>" = {
              __raw = "cmp.mapping.complete()";
            };
            "<CR>" = {
              __raw = "cmp.mapping.confirm({ select = true })";
            };
            "<Tab>" = {
              __raw = "cmp.mapping.select_next_item()";
            };
            "<S-Tab>" = {
              __raw = "cmp.mapping.select_prev_item()";
            };
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

    extraConfigLua = ''
       -- Öffnet Terminal im rechten Split und wechselt sofort hinein
       vim.api.nvim_set_keymap('n', '<leader>t', ':vsplit | terminal<CR>', { noremap = true, silent = true })

      -- Fenster-Navigation mit Ctrl + hjkl
       vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Fenster nach links' })
       vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Fenster nach unten' })
       vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Fenster nach oben' })
       vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Fenster nach rechts' })
    '';

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
