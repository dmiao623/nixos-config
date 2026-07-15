{ ... }:

{
  programs.fastfetch = {
    enable = true;

    # Configuration written to ~/.config/fastfetch/config.jsonc
    # Schema: https://github.com/fastfetch-cli/fastfetch/wiki/Json-Schema
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          top = 0;
          right = 2;
        };
      };

      display = {
        separator = "  ";
      };

      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "uptime"
        "packages"
        "memory"
      ];
    };
  };
}
