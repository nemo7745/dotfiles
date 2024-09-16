{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "/home/nemo/Pictures/wallpaper/01.jpg"
      ];
      wallpaper = [
        ",/home/nemo/Pictures/wallpaper/01.jpg"
      ];
    };
  };
}
