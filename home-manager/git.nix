{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "nemo7745";
    userEmail = "8908728+nemo7745@users.noreply.github.com";
    signing = {
      signByDefault = false;
      key = "9668873AA83A560F!";
    };
  };
}