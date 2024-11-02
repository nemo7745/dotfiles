{ config, ... }:

{
  services.hypridle ={
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        lock_cmd = "pidof hyprlock || hyprlock --immediate";
      };
      listener = [
        {
          on-resume = "hyprctl dispatch dpms on"
          on-timeout = "hyprctl dispatch dpms off";
          timeout = 600;
        }
        {
          on-resume = "hyprctl dispatch dpms on";
          on-timeout = "loginctl lock-session";
          timeout = 660;
        }
        {
          on-timeout = "systemctl suspend-then-hibernate";
          timeout = 3600;
        }
      ];
    };
  };
}