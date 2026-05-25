{ pkgs, ... }:

{
  systemd.user.services.rclone-bisync = {
    Unit = {
      Description = "Rclone bisync with Google Drive";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rclone}/bin/rclone bisync gdrive: %h/gdrive --drive-skip-shortcuts --verbose";
    };
  };

  systemd.user.timers.rclone-bisync = {
    Unit.Description = "Run rclone bisync periodically";
    Timer = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
