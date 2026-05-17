{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  console.keyMap = "dvorak-programmer";

  services.xserver.xkb = {
    layout = "us";
    variant = "dvp";
  };

  services.printing.enable = true;

  # Audio via PipeWire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
