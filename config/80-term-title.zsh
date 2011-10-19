# ------------------------------------------------------------------------------
# Terminal Title
# ------------------------------------------------------------------------------


# For xterm and similar
# Some infos there: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Credits to magic gus2


H=`echo $HOST | cut -d '.' -f 1`

title_precmd() {
	local CMD
	if [[ "$TERM" == "screen" ]]; then
		CMD=$(basename $SHELL)
		print -Pn "\ek$CMD:%1~ |\e\\"
	elif [[ $TERM = "xterm" ]] || [[ $TERM = "xterm-color" ]]; then
		echo -ne "\033]0; < $USERNAME@$H >\007"
	fi
}

title_preexec() {
	if [[ "$TERM" == "screen" ]]; then
		local CMD=${1[(wr)^(*=*|sudo|-*)]}
		case $CMD in
			vi*)
				echo -ne "\ek$1 |\e\\"
			;;
			*)
				echo -ne "\ek$CMD |\e\\"
			;;
		esac
	fi
	if [[ "$TERM" == "*xterm*" ]]; then	
		echo -ne "\033]0; < $1 on $H >\007"
	fi
}


# Add hooks to precmd and preexec
# Hooks when user has the prompt
add-zsh-hook precmd title_precmd

# Hooks before and during command execution
add-zsh-hook preexec title_preexec
