#PS1='\n[\u@\h] '
#PS1='\n[\u@\h>\w] '
PS1='\n\[\e[97m\]\[\e[0m\][\u@\h()\w] '

alias ga='git add .';
alias gc='git commit -am'
alias gs='git status'
alias gp='git push'
alias switch='sudo nixos-rebuild switch --flake $HOME/dotfiles --impure'

cal
