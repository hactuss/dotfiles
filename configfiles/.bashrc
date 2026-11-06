#PS1='\n[\u@\h] '
#PS1='\n[\u@\h>\w] '
# PS1='\n\[\e[97m\]\[\e[0m\][\u@\h()\w $(git branch --show-current 2>/dev/null)] '
alias ga='git add .';
alias gc='alejandra $HOME/dotfiles ; git commit -am'
alias gs='git status'
alias gps='git push'
alias gpl='git pull --rebase'
alias switch='pushd $HOME/dotfiles; ga ; sudo nixos-rebuild switch --flake $HOME/dotfiles --impure; popd;'
alias cp='cp -r'
alias ls='lsd'

if [[ "$(uname -n)" == "opal" ]]; then
    PS1='#\[\e[38;5;105m\]\h\[\e[0m\] \[\e[3m\]<\u>\[\e[0m\] \[\e[1m\]\w\[\e[0m\] \\$ '
elfi [[ "$(uname -n)" == "emerald" ]]; then
    PS1='#\[\e[38;5;121m\]\h\[\e[0m\] \[\e[3m\]<\u>\[\e[0m\] \[\e[1m\]\w\[\e[0m\] \\$ '
fi

# Blue hostname IRC
# PS1='#\[\e[38;5;105m\]\h\[\e[0m\] \[\e[3m\]<\u>\[\e[0m\] \[\e[1m\]\w\[\e[0m\] \\$'

# light green hostname IRC
# PS1='#\[\e[38;5;121m\]\h\[\e[0m\] \[\e[3m\]<\u>\[\e[0m\] \[\e[1m\]\w\[\e[0m\] \\$'
