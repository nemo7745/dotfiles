{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#404040ff";
    textColor = "#f0f0f0ff";
    height = 500;
    borderSize = 0;
    borderRadius = 8;
    defaultTimeout = 10000;
    iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    extraConfig =
      ''
      on-button-right=exec makoctl menu -n "$id" wofi -d && makoctl dismiss -n "$id"
      '';
  };
}