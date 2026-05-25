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
    docker-client
    eza
    gcc
    git
    htop
    jq
    kitty
    lf
    neofetch
    nixfmt-classic
    nixfmt-tree
    osu-lazer
    qutebrowser
    ripdrag
    slack
    ripgrep
    spotify
    unzip
    uv
    wget
    wl-clipboard
    yazi
    zotero
    zoom-us
  ];
}
