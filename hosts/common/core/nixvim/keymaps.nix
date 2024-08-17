{ ... }:
{
  programs.nixvim.keymaps = [

    # Neo-tree
    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle reveal<CR>";
      options.desc = "Toggle neo-tree (reveal)";
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
}
