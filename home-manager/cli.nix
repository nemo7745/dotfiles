{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ./dotfiles.nix ];
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
  programs.git = {
    enable = true;
    userName = "nemo7745";
    userEmail = "8908728+nemo7745@users.noreply.github.com";
    signing = {
      signByDefault = true;
      key = "358BE32FBD8E939E";
    };
  };
}