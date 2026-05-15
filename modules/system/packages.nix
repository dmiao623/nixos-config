{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    claude-code
    curl
    git
    htop
    kitty
    neofetch
    qutebrowser
    ripgrep
    tree
    unzip
    uv
    vim
    vscode
    wget
  ];
}
