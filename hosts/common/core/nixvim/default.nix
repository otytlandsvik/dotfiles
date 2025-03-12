{ pkgs, config, ... }:
{
  imports = [ ./keymaps.nix ];

  # Set colorscheme through nixvim instead
  stylix.targets.nixvim.enable = false;

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
      swapfile = false; # Don't create a swapfile if closed without saving
      cursorline = true; # Highlight the current line

      # Indentation
      # autoindent = true;
      smartindent = true; # Insert indents automatically
      # smarttab = true;
      shiftwidth = 4; # Size of an indent
      shiftround = true; # Round indent to multiple of shitfwidth
      softtabstop = 4; # Number of spaces to insert on <Tab>
      expandtab = true; # Use spaces instead of tabs
    };

    # Set leader key to space
    globals.mapleader = " ";

    ############### Plugins ###############
    plugins = {

      # Language service providers
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          # Nix
          nixd.enable = true;

          # F#
          fsautocomplete.enable = true;

          # Dockerfile
          dockerls.enable = true;

          # js/ts
          ts_ls.enable = true;

          # CSS
          cssls.enable = true;

          # golang
          gopls.enable = true;

          # C/C++
          clangd.enable = true;

          # Python
          pyright.enable = true;

          # Typst
          tinymist.enable = true;

          # Rust
          rust_analyzer = {
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
            "<CR>" = builtins.readFile ./lua/cmp/cr.lua;
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
                (mkButton " Live Grep" "<CMD>lua require('telescope.builtin').live_grep()<CR>" "g")
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
          fsharp-grammar =
            (pkgs.tree-sitter.buildGrammar {
              language = "fsharp";
              location = "fsharp";
              version = "0.1.0+rev=971da5f";
              src = pkgs.fetchFromGitHub {
                owner = "ionide";
                repo = "tree-sitter-fsharp";
                rev = "971da5ff0266bfe4a6ecfb94616548032d6d1ba0";
                hash = "sha256-0jrbznAXcjXrbJ5jnxWMzPKxRopxKCtoQXGl80R1M0M=";
              };
              meta.homepage = "https://github.com/ionide/tree-sitter-fsharp";
            }).overrideAttrs
              {
                # Override installPhase to fetch queries from correct directory
                installPhase = ''
                  runHook preInstall
                  mkdir $out
                  mv parser $out/
                  if [[ -d ../queries ]]; then
                    cp -r ../queries $out
                  fi
                  runHook postInstall
                '';
              };
        in
        {
          enable = true;
          settings = {
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

      # Keymap popup suggestions
      which-key.enable = true;

      # Show indentation lines and highlight scope
      indent-blankline = {
        enable = true;
        settings.scope = {
          # Disable undelines for scope start and end
          show_start = false;
          show_end = false;
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;

        settings = {

          format_on_save = builtins.readFile ./lua/formatOnSave.lua;

          formatters_by_ft = {
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
      };

      # Display color code colors
      nvim-colorizer = {
        enable = true;
        fileTypes = [ "*" ];
      };

      # Various QOL improvement plugins
      # FIXME: Only a handful of plugins in this collection are working...
      snacks = {
        enable = true;
        settings = {
          # Prevent LSP and Treesitter from attaching when opening very large files
          bigfile.enabled = true;
          # Delete buffers without affecting window layout
          bufdelete.enabled = true;
          # Git utilities (git blame line)
          git.enabled = true;
          # Go to commit in browser
          gitbrowse.enabled = true;
          # Show indent lines and scopes using treesitter
          # indent.enabled = true;
          # Draw file before loading plugins
          quickfile.enabled = true;
          # scope.enabled = true;
          # Smooth scrolling
          # scroll.enabled = true;
        };
      };

      # Notification UI
      # fidget.enable = true;

      # Comment utilities
      comment.enable = true;

      # Highlight todo comments
      todo-comments.enable = true;

      # Automatically pair braces, etc
      # TODO: Add rules to properly handle pairing braces composed
      # with multiple characters, like ```...```
      nvim-autopairs = {
        enable = true;
      };

      # Git diff signs on sidebar
      gitsigns.enable = true;

      # Highlight other uses of word under cursor
      illuminate.enable = true;

      # Surround words/lines with brackets
      vim-surround.enable = true;

      # Icons
      web-devicons.enable = true;

      # Preview markdown in the browser
      markdown-preview.enable = true;

      # Synchronize pane navigation with tmux
      tmux-navigator.enable = true;

      # vimium-like jumping
      leap.enable = true;

      # Typst plugin
      typst-vim = {
        enable = true;
        settings = {
          pdf_viewer = "evince";
        };
      };
    };

    extraPlugins =
      let
        nvim-ghost = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-ghost.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "subnut";
            repo = "nvim-ghost.nvim";
            rev = "67cc8f38c69d271af1c2430ff5099766f3550eb8";
            hash = "sha256-XldDgPqVeIfUjaRLVUMp88eHBHLzoVgOmT3gupPs+ao=";
          };
        };
      in
      [
        nvim-ghost
      ];

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
        (mkFileTypeCmd [ "*.nix" ] "setlocal shiftwidth=2 softtabstop=2")
        # Set wrapping and spell checking for typst files
        (mkFileTypeCmd [ "*.typ" ] "setlocal wrap linebreak spell spelllang=en_us")
      ];

    # Keep lua config in lua file for syntax highlights and formatting
    extraConfigLua = builtins.readFile ./lua/extraConfig.lua;

    # Fsharp indentation config from ionide-vim
    extraFiles."indent/fsharp.vim".source = ./vimscript/indentFsharp.vim;
  };
}
