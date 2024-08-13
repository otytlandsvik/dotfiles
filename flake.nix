{
  description = "Home manager config for ole";

  inputs = {

    ############### Official nixos/hm sources ###############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ############### External sources  ###############

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      homeConfigurations."ole@xps" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/xps.nix ];
      };
      homeConfigurations."ole@donkeykong" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/donkeykong.nix ];
      };
      homeConfigurations."oty@ekman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/ekman.nix ];
      };
    };
}
