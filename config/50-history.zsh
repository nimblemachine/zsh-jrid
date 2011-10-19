# ----------------------------------------------------------------------------
# History
# ----------------------------------------------------------------------------

HISTFILE="$ZSH_CACHE/history"
HISTSIZE=10000
SAVEHIST=10000


# History Options 
# append_history:		append to existing history instead of overwrite
# bang_hist:			enable history via `!` and the like
# extended_history:		add time and duration of commands to history (try
# 						history -d, -f or -D)
# hist_beep:			beep when reach end of history
# hist_expire_dups_first: remove duplicate first when history full
# hist_find_no_dups:	don't show duplicates if they have been stored
# hist_ignore_all_dups:	remove all duplicate commands
# hist_ignore_dups:		don't store identical consecutive commands, keep new ones
# hist_ignore_space:	don't include lines that start with space in history
# hist_no_functions:	don't store commands that are functions definition
# hist_no_store:		don't store 'history' or 'fc' commands in history
# hist_reduce_blanks:	cleans up history
# hist_save_no_dups: 	don't save duplicate lines
# inc_append_history:	append history on the fly, and not when shell exits
# share_history: 		share history across different shells (with same $HOME)
setopt \
	append_history \
	bang_hist \
	extended_history \
	NO_hist_beep \
	hist_expire_dups_first \
	hist_find_no_dups \
	NO_hist_ignore_all_dups \
	hist_ignore_dups \
	NO_hist_ignore_space \
	hist_no_functions \
	hist_no_store \
	hist_reduce_blanks \
	NO_hist_save_no_dups \
	inc_append_history \
	share_history


