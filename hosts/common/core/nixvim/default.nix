{ pkgs, config, ... }:
{
  imports = [ ./keymaps.nix ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    defaultEditor = true;

    clipboard.register = "unnamedplus"; # Use system clipboard

    colorschemes.catppuccin.enable = true;

    opts = {
      number = true; # Absolute line number on current line
      relativenumber = true; # Relative line numbers
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily
      wrap = false; # Don't wrap lines by default
      scrolloff = 5; # Show a few lines of context around cursor
      swapfile = false;

      # Indentation
      # autoindent = true;
      # cindent = true; # Automatically indent braces
      smartindent = true; # Insert indents automatically
      # smarttab = true;
      shiftwidth = 2; # Size of an indent
      shiftround = true; # Round indent to multiple of shitfwidth
      softtabstop = 2; # Number of spaces to insert on <Tab>
      expandtab = true; # Use spaces instead of tabs
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
          nixd.enable = true;

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
          tinymist.enable = true;

          # Rust
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
        keymaps.lspBuf = {
          K = "hover";
          gd = "definition";
          gr = "references";
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
        settings.options.diagnostics = "nvim_lsp"; # Show lsp warnings
      };

      # Welcome screen
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val =
              let
                mkButton = val: cmd: shortcut: {
                  type = "button";
                  inherit val;
                  opts = {
                    inherit shortcut;
                    hl = "Operator";
                    keymap = [
                      "n"
                      shortcut
                      cmd
                      { }
                    ];
                    position = "center";
                    cursor = 2;
                    width = 40;
                    align_shortcut = "right";
                    hl_shortcut = "Keyword";
                  };
                };
              in
              [
                (mkButton " New File" "<CMD>ene<CR>" "n")
                (mkButton " Find File" "<CMD>lua require('telescope.builtin').find_files()<CR>" "f")
                (mkButton " Quit Neovim" "<CMD>qa<CR>" "q")
              ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "String";
              position = "center";
            };
            type = "text";
            val = "Sweet nixified neovim 󰓠";
          }
        ];
      };

      # Filetree viewer
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        # TODO: This should be enabled on default, and it should work...
        buffers.followCurrentFile.enabled = true;
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
          "<leader>fh" = {
            options.desc = "Find hidden files";
            action = "find_files hidden=true";
          };
          "<leader>fg" = {
            options.desc = "Find with grep";
            action = "live_grep";
          };
          "<leader>fb" = {
            options.desc = "Find buffers";
            action = "buffers";
          };
          "<leader>fc" = {
            options.desc = "Find commands";
            action = "commands";
          };
          "<leader>fj" = {
            options.desc = "Find in jumplist";
            action = "jumplist";
          };
          "<leader>fk" = {
            options.desc = "Find keymap";
            action = "keymaps";
          };
        };
        extensions = {
          fzf-native.enable = true;
          media-files.enable = true;
        };
      };

      # Treesitter
      treesitter =
        let
          fsharp-grammar = pkgs.tree-sitter.buildGrammar {
            language = "fsharp";
            version = "0.0.0+rev=d939b3a";
            src = pkgs.fetchFromGitHub {
              owner = "ionide";
              repo = "tree-sitter-fsharp";
              rev = "d939b3a1db56820f6b810f764e9163f514cb833a";
              hash = "sha256-MQg7cZDsSXlcmfPfwgWcY/N66iBuCQf2yjzbg10WcsA=";
            };
            generate = false;
            meta.homepage = "https://github.com/ionide/tree-sitter-fsharp";
          };
        in
        {
          enable = true;
          settings = {
            indent.enable = true;
            highlight.enable = true;
          };
          nixvimInjections = true;
          languageRegister.fsharp = "fsharp";

          grammarPackages =
            with config.programs.nixvim.plugins.treesitter.package.builtGrammars;
            [
              bash
              bibtex
              c_sharp
              cue
              cpp
              css
              csv
              dockerfile
              fish
              git_rebase
              gitattributes
              gitignore
              go
              haskell
              html
              javascript
              json
              latex
              lua
              make
              markdown
              markdown_inline
              nix
              python
              rust
              toml
              typescript
              typst
              yaml
              zig
            ]
            ++ [ fsharp-grammar ];
        };

      # Sticky function signatures / scope context
      treesitter-context.enable = true;

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
      # fidget.enable = true;

      # Comment utilities
      comment.enable = true;

      # Highlight todo comments
      todo-comments.enable = true;

      # Automatically close braces
      # TODO: Maybe switch to nvim-autopairs?
      autoclose = {
        enable = true;
        options.pairSpaces = true;
      };

      # Git diff signs on sidebar
      gitsigns.enable = true;

      # Highlight other uses of word under cursor
      illuminate.enable = true;

      # Surround words/lines with brackets
      surround.enable = true;

      # Preview markdown in the browser
      markdown-preview.enable = true;
    };

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

    # Autocommands
    autoCmd =
      let
        mkFileTypeCmd = pattern: command: {
          event = [
            "BufEnter"
            "BufWinEnter"
          ];
          pattern = pattern;
          command = command;
        };
      in
      [
        # Set wrapping and spell checking for typst files
        (mkFileTypeCmd [ "*.typ" ] "setlocal wrap linebreak spell spelllang=en_us")
        # Set 4 spaces to default for F#
        (mkFileTypeCmd [
          "*.fs"
          "*.fsi"
          "*.fsx"
        ] "setlocal shiftwidth=4 softtabstop=4")
      ];

    # Keep lua config in lua file for syntax highlights and formatting
    extraConfigLua = builtins.readFile ./lua/extraConfig.lua;
  };
}
