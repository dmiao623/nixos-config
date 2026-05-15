{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.kanata ];
    
  xdg.configFile."kanata/kanata.kbd".text = ''
    (defcfg
      process-unmapped-keys yes
    )
    (defsrc
      caps bspc rsft
    )
    (deflayer default
      bspc caps esc
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