{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.keyboard.variant = lib.mkOption {
    type = lib.types.enum [
      "dvp"
      "dvorak"
      "qwerty"
    ];
    # Choose "dvp", "dvorak", or "qwerty", then rebuild.
    default = "dvp";
    description = "ThinkPad keyboard variant shared by Sway and Kanata.";
  };

  config = {
    home.packages = [ pkgs.kanata ];

    # ThinkPad internal keyboard
    xdg.configFile."kanata/thinkpad.kbd".text = ''
      (defcfg
        process-unmapped-keys yes
        linux-dev /dev/input/by-path/platform-i8042-serio-0-event-kbd
      )
      (defsrc
        caps bspc rsft lmet lalt
      )
      (deflayer default
        ${if config.keyboard.variant == "dvp" then "bspc caps esc" else "caps bspc rsft"} lalt lmet
      )
    '';

    systemd.user.services.kanata-thinkpad = {
      Unit = {
        Description = "Kanata keyboard remapper (ThinkPad)";
      };
      Service = {
        Environment = "PATH=${pkgs.kanata}/bin";
        ExecStart = "${pkgs.kanata}/bin/kanata --cfg %h/.config/kanata/thinkpad.kbd";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # xdg.configFile."kanata/external.kbd".text = ''
    #   (defcfg
    #     process-unmapped-keys yes
    #     linux-dev-names-include ("DasKeyboard")
    #   )
    #   (defsrc
    #     caps bspc rsft
    #   )
    #   (deflayer default
    #     bspc caps esc
    #   )
    # '';

    # systemd.user.services.kanata-external = {
    #   Unit = {
    #     Description = "Kanata keyboard remapper (external)";
    #   };
    #   Service = {
    #     Environment = "PATH=${pkgs.kanata}/bin";
    #     ExecStart = "${pkgs.kanata}/bin/kanata --cfg %h/.config/kanata/external.kbd";
    #     Restart = "always";
    #   };
    #   Install = {
    #     WantedBy = [ "default.target" ];
    #   };
    # };
  };
}
