{ ... }:
{
  programs.nixvim.keymaps = [

    # Neo-tree
    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle reveal position=float<CR>";
      options.desc = "Toggle neo-tree (floating window)";
    }
    {
      key = "<leader>E";
      action = "<cmd>Neotree toggle reveal position=left<CR>";
      options.desc = "Toggle neo-tree (left window)";
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
    # Snacks bufdelete
    {
      mode = [ "n" ];
      key = "<leader>bc";
      action = "<cmd>lua Snacks.bufdelete.delete()<CR>";
      options.desc = "Close current buffer";
    }
    {
      mode = [ "n" ];
      key = "<leader>bo";
      action = "<cmd>lua Snacks.bufdelete.other()<CR>";
      options.desc = "Close all buffers but current";
    }
    {
      mode = [ "n" ];
      key = "<leader>ba";
      action = "<cmd>lua Snacks.bufdelete.all()<CR>";
      options.desc = "Close all buffers";
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
      key = "<leader>w-";
      action = "<C-w>_";
      options.desc = "Maximize window vertically";
    }
    {
      key = "<leader>w|";
      action = "<C-w>|";
      options.desc = "Maximize window horizontally";
    }
    {
      key = "<leader>w=";
      action = "<C-w>=";
      options.desc = "Space window splits evenly";
    }
    {
      key = "<leader>|";
      action = "<cmd>vsplit<CR>";
      options.desc = "Create new window, vertical split";
    }
    {
      key = "<leader>-";
      action = "<cmd>split<CR>";
      options.desc = "Create new window, horizontal split";
    }
    # Better paste
    {
      key = "<leader>p";
      action = "\"_dP";
      options.desc = "Paste without overwriting yank buffer";
    }
    # Git
    {
      mode = [ "n" ];
      key = "<leader>gb";
      action = "<cmd>lua Snacks.git.blame_line()<CR>";
      options.desc = "Open git blame for current line";
    }
    {
      mode = [ "n" ];
      key = "<leader>go";
      action = "<cmd>lua Snacks.gitbrowse()<CR>";
      options.desc = "Open git repository in browser";
    }
    # Leap nvim
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = "<Plug>(leap-forward)";
      options.desc = "Leap forward to";
    }
    {
      mode = [ "n" "x" "o" ];
      key = "S";
      action = "<Plug>(leap-backward)";
      options.desc = "Leap backward to";
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
    # NOTE: not needed as long as format on save is disabled
    # Write without formatting
    # {
    #   key = "<leader>wn";
    #   action = "<cmd>noa w<CR>";
    #   options.desc = "Write without formatting";
    # }
    # Run refactor/format with LSP
    {
      key = "<leader>r";
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
      options.desc = "Refactor/format with LSP";
    }
    # Disable inlay hints
    {
      key = "<leader>ih";
      action = "<cmd>lua vim.lsp.inlay_hint.enable(false)<CR>";
      options.desc = "Disable inlay hints";
    }
  ];
}
