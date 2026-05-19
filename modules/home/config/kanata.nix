{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.kanata ];
    
  xdg.configFile."kanata/kanata.kbd".text = ''
    (defcfg
      process-unmapped-keys yes
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

  systemd.user.services.kanata = {
    Unit = { Description = "Kanata keyboard remapper"; };
    Service = {
      Environment = "PATH=${pkgs.kanata}/bin";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg %h/.config/kanata/kanata.kbd";
      Restart = "always";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}