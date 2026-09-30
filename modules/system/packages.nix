{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
    "electron-39.8.10"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    bat
    bitwarden-desktop
    btop
    claude-code
    codex
    curl
    discord
    docker-client
    eza
    gcc
    git
    glow
    google-chrome
    inputs.grok-bot-flake.packages.${pkgs.system}.grok-bot
    imv
    jq
    kitty
    lf
    nixfmt
    nixfmt-tree
    osu-lazer
    proton-vpn
    qutebrowser
    ripdrag
    slack
    ripgrep
    spotify
    texlive.combined.scheme-medium
    unzip
    uv
    wget
    wl-clipboard
    yazi
    zathura
    zotero
    zoom-us
  ];
}
