{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    claude-code
    curl
    eza
    git
    htop
    kitty
    lf
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
