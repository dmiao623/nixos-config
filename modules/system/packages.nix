{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    bat
    bitwarden-desktop
    claude-code
    curl
    discord
    eza
    gcc
    git
    htop
    kitty
    lf
    neofetch
    osu-lazer
    qutebrowser
    ripgrep
    spotify
    tree
    unzip
    uv
    wget
  ];
}
