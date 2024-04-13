{ config, pkgs, ... }:

{
  users.users.nemo = {
    isNormalUser = true;
    initialPassword = "CHANGE_IT";
    home = "/home/nemo";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "tor" ];
  };
}