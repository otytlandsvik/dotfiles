{
  description = "Home manager config for ole";

  inputs = {

    ############### Official nixos/hm sources ###############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ############### External sources  ###############

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";

    nix-colors.url = "github:misterio77/nix-colors";

    stylix.url = "github:danth/stylix/release-25.11";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Dell laptop
      homeConfigurations."ole@xps" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/xps.nix ];
      };
      # Old work machine
      homeConfigurations."ole@donkeykong" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/donkeykong.nix ];
      };
      # New work machine
      homeConfigurations."ole@jzargo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/jzargo.nix ];
      };
      # Ocenbox desktop
      homeConfigurations."ole@haddock" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/haddock.nix ];
      };
      # Ekman server
      homeConfigurations."ole@ekman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/ekman.nix ];
      };
    };
}
