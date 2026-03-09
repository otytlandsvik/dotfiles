{ pkgs, ... } :
{
  # NOTE: uv needed for serena mcp server
  home.packages = [ pkgs.uv ];
  programs.claude-code = {
    enable = true;
    mcpServers = {
      serena = {
        command = "uvx";
        type = "stdio";
        args = [
          "--from"
          "git+https://github.com/oraios/serena"
          "serena"
          "start-mcp-server"
          "--context=claude-code"
          "--project-from-cwd"
        ];
      };
    };
  };
}
