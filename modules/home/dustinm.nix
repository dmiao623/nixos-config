{
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./config/secrets.nix

    ./config/bat.nix
    ./config/claude.nix
    ./config/direnv.nix
    ./config/fastfetch.nix

    ./config/fzf.nix
    ./config/git.nix
    ./config/qutebrowser.nix
    ./config/kitty.nix
    ./config/sway.nix
    ./config/kanata.nix
    ./config/vscode.nix
    ./config/yazi.nix
    ./config/zsh.nix
    ./config/nixvim.nix
    ./config/rclone.nix
    ./config/starship.nix
  ];

  home.username = "dustinm";
  home.homeDirectory = "/home/dustinm";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
