{ config, pkgs, ... }:

{
  home = {
    file = {
    ".local/share/icons/Papirus" = {
      source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
      };
    };
  };
  gtk = {
    enable = true;
    iconTheme.name = "Papirus";
  };
}
