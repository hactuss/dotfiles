#PS1='\n[\u@\h] '
#PS1='\n[\u@\h>\w] '
PS1='\n\[\e[97m\]\[\e[0m\][\u@\h()\w $(git branch --show-current 2>/dev/null)] '
alias ga='git add .';
alias gc='alejandra $HOME/dotfiles ; git commit -am'
alias gs='git status'
alias gps='git push'
alias gpl='git pull'
alias switch='pushd $HOME/dotfiles; ga ; sudo nixos-rebuild switch --flake $HOME/dotfiles --impure; popd;'
alias cp='cp -r'
alias ls='lsd'

#if [[$- == *i* ]]; then
##	cal
#fi
