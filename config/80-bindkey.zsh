#
# Bindkey magic

# TODO see what could be make common to both and defined only once when the
# active bindkey is selected
# Did steal a few of them from oh-my-zsh ... but they are for emacs fools


# ---------------------------------------------------------------------------
# Emacs bindkey


# Arrows give a clean history 
bindkey -e "^[[A" history-search-backward
bindkey -e "^[[B" history-search-forward

bindkey -e '\ew' kill-region
bindkey -e '^r' history-incremental-search-backward
bindkey -e "^[[5~" up-line-or-history
bindkey -e "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey -e '^[[A' up-line-or-search
bindkey -e '^[[B' down-line-or-search

bindkey -e "^[[H" beginning-of-line
bindkey -e "^[[1~" beginning-of-line
bindkey -e "^[OH" beginning-of-line
bindkey -e "^[[F"  end-of-line
bindkey -e "^[[4~" end-of-line
bindkey -e "^[OF" end-of-line
bindkey -e ' ' magic-space    # also do history expansion on space

bindkey -e "^[[1;5C" forward-word
bindkey -e "^[[1;5D" backward-word

bindkey -e '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey -e '^?' backward-delete-char
bindkey -e "^[[3~" delete-char
bindkey -e "^[3;5~" delete-char
bindkey -e "\e[3~" delete-char





# ---------------------------------------------------------------------------
# vi bindkey (effectively viins and not vicmd)
# Need much less crap than emacs ?
# Arrows
bindkey -v "^[[A" history-search-backward
bindkey -v "^[[B" history-search-forward
bindkey -v "^B" history-incremental-search-backward
bindkey -v "^Q" push-line 





# ---------------------------------------------------------------------------
# Select favorite bindkey
#
# Make emacs default bindkey, if none selected
# This overwrites auto dectection based on VISUAL or EDITOR
# Also note that all bindkey below will then be defined for the bindkey
# selected here

ZLE_BINDKEYS=${ZLE_BINDKEYS:=emacs}

case "$ZLE_BINDKEYS" in

	# EMACS style 
	[eE][mM][aA][cC][sS])
		bindkey -e
	;;

	# VI style 
	[vV][iI])
		bindkey -v 
	;;
esac



# What does this do, and what is the -M option?
bindkey -M menuselect '^o' accept-and-infer-next-history

