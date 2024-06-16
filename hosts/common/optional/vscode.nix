{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-dotnettools.csharp
      ionide.ionide-fsharp
      ms-python.python
      ms-python.vscode-pylance
      esbenp.prettier-vscode
      golang.go
    ];
  };
}
