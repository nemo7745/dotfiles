{ config, ... }:

{
  home.username = "nemo";
  home.homeDirectory = "/home/nemo";
  home.stateVersion = "24.11";
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}