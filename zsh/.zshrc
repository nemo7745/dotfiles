autoload colors compinit promptinit
colors
compinit
promptinit
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt share_history
setopt correct
PROMPT="[%n@%m]%#"
RPROMPT="[%d]"
SPROMPT="%{%}%{$suggest%}%B%r%b%{%}?[nyae]"
export GPG_TTY=$(tty)