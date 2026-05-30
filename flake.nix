{
  description = "milisaur dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mars-mips = pkgs.callPackage ./pkgs/mars-mips.nix {
      jre = pkgs.jdk21;
    };

    asm-simulator = pkgs.callPackage ./pkgs/asm-simulator.nix {
      jdk21 = pkgs.jdk21;
    };

    hades = pkgs.callPackage ./pkgs/hades.nix {
      jdk8 = pkgs.jdk8;
    };

    mkHost = hostName:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostName mars-mips asm-simulator hades;
        };

        modules = [
          ./hosts/${hostName}/nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs hostName mars-mips asm-simulator hades;
            };

            home-manager.users.mili =
              import ./hosts/${hostName}/home-manager/home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      ankylosaurus = mkHost "ankylosaurus";
      spinosaurus = mkHost "spinosaurus";
      uniraptor = mkHost "uniraptor";
    };
  };
}
