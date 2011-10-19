# ------------------------------------------------------------------------------
# Completion Configuration
# ------------------------------------------------------------------------------

# Completion Options
# ------------------
# always_last_prompt: TODO
# always_to_end:	cursor moved to end of word when completed
# auto_list:		automatically list choices on an ambiguous completion
# auto_menu:		use menu completion after the second consecutive completion request
# auto_name_dirs:	TODO
# auto_param_keys:	clean extra auto completed character (space) if next input requires it
# auto_param_slash:	TODO
# auto_remove_slash: remove auto completed slash if next input requires it 
# bash_auto_list:	TODO
# complete_aliases:	complete aliases before internal substitution TODO (on or off?)
# complete_in_word:	keep cursor in word and complete from both ends
# glob_complete:	don't insert all words of glob pattern but propose menu completion
# hash_list_all:	hash entire command path first
# list_ambiguous:	TODO
# list_beep:		beep on ambiguous completion
# list_packed:		print completion matches in columns to save space
# list_rows_first:	sort matches horizontally instead of vertically
# list_types:		show types of completion candidates with trailing characters
# menu_complete:	TODO
setopt \
	always_to_end \
	auto_list \
	auto_menu \
	auto_param_keys \
	auto_remove_slash \
	NO_complete_aliases \
	complete_in_word \
	glob_complete \
	hash_list_all \
	NO_list_beep \
	list_packed \
	NO_list_rows_first \
	list_types \
	NO_menu_complete \


# -----------------------------------------------------------------------------
# Users for completion 
# -----------------------------------------------------------------------------

users=($ZSH_USERS)

if [[ -f "$HOME/.ssh/config" ]]; then
	users_config=(`sed -e 's/#.*//' -e '/User[ \t].*/!d' -e's/\w*[Uu]ser\w*\([A-Za-z]*\)/\1/' ~/.ssh/config`)
fi

for user in ${users_config}
do
	in_list=`echo ${users} | grep ${user}`
	if [ ! ${in_list} ]; then
		users+=($user)
	fi
done


# -----------------------------------------------------------------------------
# Hosts for completion 
# -----------------------------------------------------------------------------

if [[ -f "$HOME/.ssh/config" ]]; then
	hosts_config=(`sed -e 's/#.*//' -e '/Host[ \t].*/!d' -e '/\*/d' -e's/[Hh]ost\w*\([A-Za-z]*\)/\1/' ~/.ssh/config`)
fi

if [[ -f "$HOME/.ssh/known_hosts" ]]; then
	hosts_known=(`sed -e '/^[.*,]/d' -e '/^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/d' -e 's/,.*//' -e 's/ .*//' ~/.ssh/known_hosts`)
fi

hosts=($ZSH_HOSTS)
hosts+=($hosts_config)
#hosts+=($hosts_known)
hosts+=`hostname`
hosts+='localhost'



zstyle ':completion:*' completer _expand _complete _correct _approximate _list _prefix _match

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
	zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
	unset CASE_SENSITIVE
else
	zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi


zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' verbose yes

# Need at least 2 matches to enable menu completion
zstyle ':completion:*' menu select=2

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE

# Should ignore most ZSH functions? TODO check that
zstyle ':completion:*:functions' ignored-patterns '_*'

# Processes and Kill command
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' command 'ps -axco pid,user,command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}---- No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}---- %d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B---- %d%b'

zstyle ':completion:*' hosts $hosts
zstyle ':completion:*' users $users

# TODO: this needs to be fixed
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:*:mail:*' users-hosts $my_mail


# Waiting dots when completing 
if [[ "$COMPLETION_WAITING_DOTS" = "true" ]]; then
	expand-or-complete-with-dots() {
		echo -n "\e[31m......\e[0m"
		zle expand-or-complete
		zle redisplay
	}
	zle -N expand-or-complete-with-dots
	bindkey "^I" expand-or-complete-with-dots
fi

