{
  description = "Dustin's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oil-tree-nvim = {
      url = "github:dmiao623/oil-tree.nvim/d73e9a571dd2250dbc51d461bf78d50c06b8eab0";
      flake = false;
    };
    cilantro-nvim = {
      url = "github:dmiao623/cilantro.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            oilTreeNvim  = inputs.oil-tree-nvim;
            cilantroNvim = inputs.cilantro-nvim;
          };
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
          home-manager.users.dustinm = import ./modules/home/dustinm.nix;
        }
      ];
    };
  };
}
