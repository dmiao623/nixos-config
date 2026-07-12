{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };
  users.users.dustinm.extraGroups = [ "docker" ];
}
