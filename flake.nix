{
  description = "Dustin's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };
    oil-tree-nvim = {
      url = "github:dmiao623/oil-tree.nvim";
    };
    cilantro-nvim = {
      url = "github:dmiao623/cilantro.nvim";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    {
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
              oilTreeNvim = inputs.oil-tree-nvim;
              cilantroNvim = inputs.cilantro-nvim;
            };
            home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
            home-manager.users.dustinm = import ./modules/home/dustinm.nix;
          }
        ];
      };
    };
}
