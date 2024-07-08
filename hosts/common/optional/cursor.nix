{
  pkgs,
  lib,
  config,
  ...
}:
{
  # NOTE: Better to just move all of cursor config to per host?
  options.cursor = {
    size = lib.mkOption {
      type = lib.types.int;
      default = 24;
      description = "Cursor size passed to stylix";
    };
  };
  config = {
    stylix.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = config.cursor.size;
    };
  };
}
