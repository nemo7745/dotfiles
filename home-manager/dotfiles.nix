{ config, ... }:

{
  home.file = {
    ".zshrc" = {
      source = ../zsh/.zshrc;
    };
    ".zshenv" = {
      source = ../zsh/.zshenv;
    };
    ".vimrc" = {
      source = ../vim/.vimrc;
    };
  };
}