SESSION="HACTUSS"
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
	tmux new-session -d -s $SESSION -n "fm"
fi
tmux attach-session -t $SESSION
