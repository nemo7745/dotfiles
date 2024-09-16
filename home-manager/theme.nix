{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 24;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark-compact";
    };
  };
}