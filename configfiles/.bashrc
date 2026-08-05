#PS1='\n[\u@\h] '
#PS1='\n[\u@\h>\w] '
PS1='\n\[\e[97m\]\[\e[0m\][\u@\h()\w] '

alias ga='git add .';
alias gc='git commit -am'
alias gs='git status'
alias gps='git push'
alias gpl='git pull'
alias switch='sudo nixos-rebuild switch --flake $HOME/dotfiles --impure'

#if [[$- == *i* ]]; then
##	cal
#fi
