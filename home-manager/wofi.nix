{ config, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      prompt = "Search";
      allow_images = true;
      allow_markup = true;
      sort_order = "alphabetical";
      location = 2;
      yoffset = 100;
    };
    style = 
    ''
      #window {background-color: #303030; border-radius: 8px;}
      #outer-box {background-color: #303030; border-radius: 8px; margin: 6px;}
      #input {background-color: #404040;}
      #inner-box {border-radius: 16px; padding: 4px;}
      #entry:selected {background-color: #505050; border-radius: 16px;}
    '';
  };
}