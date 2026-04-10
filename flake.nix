{
  description = "milisaur dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
   
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, ... }:
    let 
      system = "x86_64-linux";

      mkHost = hostName: nixpkgs.lib.nixosSystem { 
        inherit system;
        specialArgs = { inherit inputs hostName; };
       
        modules = [
          ./hosts/${hostName}/nixos/configuration.nix
          
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs hostName; };

            home-manager.users.mili = import ./hosts/${hostName}/home-manager/home.nix;
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
