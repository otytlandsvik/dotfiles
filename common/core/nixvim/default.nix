{ pkgs, ... }:
{

  programs.nixvim = {
    enable = true;
    enableMan = true;
    defaultEditor = true;

    clipboard.register = "unnamedplus"; # Use system clipboard

    colorschemes.tokyonight.enable = true;

    opts = {
      number = true; # Absolute line number on current line
      relativenumber = true; # Relative line numbers
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily
      wrap = false; # Don't wrap lines by default

      # Indentation
      # autoindent = true;
      cindent = true; # Automatically indent braces
      # smartindent = true;
      # smarttab = true;
      shiftwidth = 2;
      # softtabstop = 2;
      # tabstop = 2;
      # expandtab = true;
    };

    # Set leader key to space
    globals.mapleader = " ";

    ############### Plugins ###############
    plugins = {

      # Language service providers
      lsp = {
        enable = true;
        servers = {
          # Nix
          nil_ls.enable = true;

          # F#
          fsautocomplete.enable = true;

          # Dockerfile
          dockerls.enable = true;

          # js/ts
          tsserver.enable = true;

          # CSS
          cssls.enable = true;

          # golang
          gopls.enable = true;

          # C/C++
          ccls.enable = true;

          # Python
          pylsp.enable = true;

          # Typst
          typst-lsp.enable = true;
        };
      };

      # Handy code snippets
      luasnip = {
        enable = true;
        fromVscode = [ { } ];
      };

      friendly-snippets.enable = true;

      # Completion engine
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp_luasnip.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Up>" = builtins.readFile ./lua/cmp/up.lua;
            "<Down>" = builtins.readFile ./lua/cmp/down.lua;
            "<Tab>" = builtins.readFile ./lua/cmp/tab.lua;
          };
        };
      };

      # Status bar
      lualine.enable = true;

      # Bufferline (showing open buffers)
      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp"; # Show lsp warnings
      };

      # Filetree viewer
      neo-tree = {
        enable = true;
      };

      # File search
      telescope = {
        enable = true;
        extensions.fzy-native.enable = true;
        # NOTE: Keymaps are simply remapped to "<cmd>Telescope <action><CR>"
        keymaps = {
          "<leader>ff" = {
            options.desc = "Find files";
            action = "find_files";
          };
          "<leader>fg" = {
            options.desc = "Find with grep";
            action = "live_grep";
          };
          "<leader>fb" = {
            options.desc = "Find buffers";
            action = "buffers";
          };
        };
      };

      # Treesitter
      treesitter.enable = true;

      # Leader popup suggestions
      which-key.enable = true;

      # Show indentation lines and highlight scope
      indent-blankline = {
        enable = true;
        settings.scope = {
          show_start = false; # Disable scope start underline
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;

        formatOnSave = builtins.readFile ./lua/formatOnSave.lua;

        formattersByFt = {
          nix = [ "nixfmt" ];
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          javascriptreact = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          css = [ "prettierd" ];
          html = [ "prettierd" ];
          json = [ "prettierd" ];
          yaml = [ "prettierd" ];
          markdown = [ "prettierd" ];
          go = [
            "goimports-reviser"
            "gofumpt"
          ];
        };
      };

      # Display color code colors
      nvim-colorizer = {
        enable = true;
        fileTypes = [ "*" ];
      };

      # Notification UI
      fidget.enable = true;

      # Comment utilities
      comment.enable = true;

      # Highlight todo comments
      todo-comments.enable = true;

      # Automatically close braces
      autoclose = {
        enable = true;
        options.pairSpaces = true;
      };
    };

    # Plugins that aren't exposed through nixvim
    #    extraPlugins = builtins.attrValues {
    #      inherit (pkgs.vimPlugins)
    #        friendly-snippets; # Snippets for luasnip
    #    };

    # Packages that are required by plugins, like formatters
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      prettierd
      stylua
      isort
      black
      goimports-reviser
      gofumpt
    ];

    # Keep lua config in lua file for syntax highlights and formatting
    extraConfigLua = builtins.readFile ./lua/extraConfig.lua;

    # Keymaps
    keymaps = [
      # Neo-tree
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle neo-tree";
      }
      # Buffers
      {
        mode = [ "n" ];
        key = "H";
        action = "<cmd>bprev<CR>";
      }
      {
        mode = [ "n" ];
        key = "L";
        action = "<cmd>bnext<CR>";
      }
      {
        key = "<leader>bd";
        action = "<cmd>bd<CR>";
        options.desc = "Delete current buffer";
      }
      # Windows
      {
        mode = [ "n" ];
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = [ "n" ];
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = [ "n" ];
        key = "<C-k>";
        action = "<C-w>k";
      }
      {
        mode = [ "n" ];
        key = "<C-l>";
        action = "<C-w>l";
      }
      {
        key = "<leader>wc";
        action = "<cmd>close<CR>";
        options.desc = "Close current window";
      }
      {
        key = "<leader>|";
        action = "<cmd>vsplit<CR>";
        options.desc = "Create new window, vertical split";
      }
      {
        key = "<leader>-";
        action = "<cmd>hsplit<CR>";
        options.desc = "Create new window, horizontal split";
      }
      # Comment 
      {
        mode = [ "n" ];
        key = "<C-/>";
        action = "gcc";
        options.remap = true; # Needed for recursive keymap
      }
      {
        mode = [ "v" ];
        key = "<C-/>";
        action = "gc";
        options.remap = true;
      }
      # Autoformat on save
      {
        key = "<leader>ad";
        action = "<cmd>FormatDisable<CR>";
        options.desc = "Disable autoformat on save globally";
      }
      {
        key = "<leader>aD";
        action = "<cmd>FormatDisable!<CR>";
        options.desc = "Disable autoformat on save for buffer";
      }
      {
        key = "<leader>ae";
        action = "<cmd>FormatEnable<CR>";
        options.desc = "Enable autoformat on save globally";
      }
      {
        key = "<leader>aE";
        action = "<cmd>FormatEnable!<CR>";
        options.desc = "Enable autoformat on save for buffer";
      }
      # Disable highlight
      {
        key = "<leader>h";
        action = "<cmd>noh<CR>";
        options.desc = "Turn off highlights";
      }
    ];
  };
}
