{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.kanata ];

  # ThinkPad internal keyboard
  xdg.configFile."kanata/thinkpad.kbd".text = ''
    (defcfg
      process-unmapped-keys yes
      linux-dev-names-include ("AT Translated Set 2 keyboard")
    )
    (defsrc
      caps bspc rsft lmet lalt
    )
    (deflayer default
      bspc caps esc lalt lmet
    )
    (defoverrides
      (lmet c) (lctl c)
      (lmet v) (lctl v)
      (lmet a) (lctl a)
      (lmet z) (lctl z)
    )
  '';

  xdg.configFile."kanata/external.kbd".text = ''
    (defcfg
      process-unmapped-keys yes
      linux-dev-names-include ("DasKeyboard")
    )
    (defsrc
      caps bspc rsft
    )
    (deflayer default
      bspc caps esc
    )
    (defoverrides
      (lmet c) (lctl c)
      (lmet v) (lctl v)
      (lmet a) (lctl a)
      (lmet z) (lctl z)
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

  systemd.user.services.kanata-external = {
    Unit = {
      Description = "Kanata keyboard remapper (external)";
    };
    Service = {
      Environment = "PATH=${pkgs.kanata}/bin";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg %h/.config/kanata/external.kbd";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
