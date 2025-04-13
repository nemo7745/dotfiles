{ config, ... }:

{
  home.username = "nemo";
  home.homeDirectory = "/home/nemo";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}