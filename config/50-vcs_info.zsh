#
# Version Control Systems
#


# Get the module up
autoload -Uz vcs_info


# Git Hackery for ZSH_VERSION < 4.3.10
# Inspired by oh-my-zsh

git_prompt_status()
{
	INDEX=$(git status --porcelain 2> /dev/null)
	STATUS=""
	if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
		STATUS="$VCS_UNTRACKED_STRING$STATUS"
	fi
	if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
		STATUS="$VCS_MODIFIED_STRING$STATUS"
	elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
		STATUS="$VCS_MODIFIED_STRING$STATUS"
	elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
		STATUS="$VCS_MODIFIED_STRING$STATUS"
	fi
	if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
		STATUS="$VCS_STAGED_STRING$STATUS"
	elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
		STATUS="$VCS_STAGED_STRING$STATUS"
	fi

	echo "$STATUS"
}

# Need a global associative array we can access from format 
typeset -xA my_hook_com


# Do not want to dray all values behind, if the user changes
# directories, we may change from one VCS to another
function +vi-clear-hook-array()
{
	my_hook_com=()
}

# Useful to test values outside the hooks 
function +vi-init-hook-array()
{
	my_hook_com=("${(@kv)hook_com}")
}

function +vi-show-hook-array()
{
	for key in ${(k)my_hook_com}
	do
		print -- "  $key : ${my_hook_com[$key]}"
	done
}


# git: Show remote branch name for remote-tracking branches
# git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
function +vi-git-remotebranch()
{
	local remote
	local ahead behind
	local -a gitstatus

	# Are we on a remote-tracking branch?
	remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
		--symbolic-full-name 2>/dev/null)/refs\/remotes\/}

	if [[ -z ${remote} ]] ; then
		return
	fi

	# for git prior to 1.7
	ahead=$(git rev-list ${remote}..HEAD | wc -l)
	# ahead=$(git rev-list origin/${hook_com[branch_orig]}..HEAD | wc -l)
	# ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
	(( $ahead )) && gitstatus+=( "+${ahead}" ) || gitstatus+=( "+0" )

	# for git prior to 1.7
	behind=$(git rev-list HEAD..${remote} | wc -l)
	# behind=$(git rev-list HEAD..origin/${hook_com[branch_orig]} | wc -l)
	# behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
	(( $behind )) && gitstatus+=( "-${behind}" ) || gitstatus+=( "-0" )

	# Joins the words using '/'
	my_hook_com[remote_branch]=${(j:/:)gitstatus}
	my_hook_com[remote_branch]+=" $remote"
}

# git: look for untracked files
# git: this is not provided by vcs_info, but is useful (true?)
function +vi-git-untracked-files()
{
	if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]
	then 
		my_hook_com[untracked]="$VCS_UNTRACKED_STRING"
	fi
}


# ============================================================================
# General options 
# ============================================================================

# Syntax reminder:
# zstyle ':vcs_info:<vcs-string>:<user-context>:<repo-root-name>' blabla

# Hooks debugging. Useful.
# Can also 'set -x' to see more output in the terminal
# zstyle ':vcs_info:*+*:*' debug true 

# Enable different VCS as specified in config files
zstyle ':vcs_info:*' enable ${enabled_vcs}

# Need zsh >= 4.3.10, to have correct %c and %u, otherwise, git hackery
# TODO May have to test with other VCS to see how this behaves
zstyle ':vcs_info:*' check-for-changes true

# To get SHA in git, since the revision number does not make sense.
# This is said to be expensive on large projects (Linux kernel)
# TODO: could enable it on some specific <repo-root-name> passed from .zshrc
zstyle ':vcs_info:*' get-revision true

# Should be larger than the number of messages we export (vcs_info_msg_X_)
zstyle ':vcs_info:*' max-exports 5



# ============================================================================
# Hooks
# ============================================================================
# Some silly things to remember:
# All vcs_info hooks need the '+vi-' prefix in there definition
# Repetitive calls to 'hooks' overwrite each other. List all hook functions for ai
# hook in one call (I wasted time with that one).
# Also, vcs_info_hookadd can be used the register the hooks statically (independent
# from context). This HAS to be called after vcs_info and not here.
# 	vcs_info_hookadd set-message git-st git-remotebranch

#	zstyle ':vcs_info:git*+set-message:*' hooks \
#		init-hook-array \
#		git-remotebranch \
#		show-hook-array

# Post-backend is called once, whereas set-message is called on every
# message vcs_info_msg_X_. So save a few resources
zstyle ':vcs_info:*+pre-get-data:*' hooks \
	clear-hook-array

zstyle ':vcs_info:git*+post-backend:*' hooks \
	init-hook-array \
	git-remotebranch \
	git-untracked-files


# Disable patterns
# TODO: make this more generic and driven from the zsh config file
zstyle ':vcs_info:*' disable-patterns "$HOME/projects/linux(*|*/*)"


# vcs_info defines quite a few defaults (see manual) 
# TODO See what we could extract from that precmd function to save resources
vcs_precmd()
{
	# TODO Can we avoid having to set these one in every call to *_precmd ?
	if [[ -n "$VCS_BRANCH_FORMAT" ]]; then
		zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat "${VCS_BRANCH_FORMAT}"
	fi

	if [[ -n "$VCS_STAGED_STRING" ]]; then
		zstyle ':vcs_info:*' stagedstr ${VCS_STAGED_STRING}
	fi

	if [[ -n "$VCS_MODIFIED_STRING" ]]; then
		zstyle ':vcs_info:*' unstagedstr ${VCS_MODIFIED_STRING}
	fi


	# XXX For a reason I don't understand, I need to run vcs_info before and after 
	# the call to formats. The hooks do populate my_hook_com on the first call to
	# vcs_info, but for some reason it is not taken into account by the formats call.
	# Only thing that works so far is to call vcs_info twice.
	# I don't get it, its as if zformat is called before the hooks, and so th?
	vcs_info

	# Do not print fancy stuff if the content is empty. 
	if [[ -n "${my_hook_com[remote_branch]}" ]]; then
		rbranch_p="$VCS_THEME_PREFIX_4"
		rbranch_s="$VCS_THEME_SUFFIX_4"
	else
		rbranch_p=""
		rbranch_s=""
	fi

	if [[ 	-n "${my_hook_com[staged]}" || 
			-n "${my_hook_com[unstaged]}" || 
			-n "${my_hook_com[untracked]}" ]]; then
		status_p="$VCS_THEME_PREFIX_3"
		status_s="$VCS_THEME_SUFFIX_3"
	else
		status_p=""
		status_s=""
	fi

	# Make sure that the vcs_info_msg_X_ are not empty by suffixing with
	# a color reset. That will make zformat happy.
	is-at-least 4.3.10 $ZSH_VERSION
	err=$?
	if [[ $err -eq 0 ]]; then
	zstyle ':vcs_info:*' formats \
		"${VCS_THEME_PREFIX_0}%s${VCS_THEME_SUFFIX_0}%F{none}" \
		"${VCS_THEME_PREFIX_1}%b${VCS_THEME_SUFFIX_1}%F{none}" \
		"${VCS_THEME_PREFIX_2}%0.8i${VCS_THEME_SUFFIX_2}%F{none}" \
		"${status_p}%c%u${my_hook_com[untracked]}${status_s}%F{none}" \
		"${rbranch_p}${my_hook_com[remote_branch]}${rbranch_s}%F{none}"
	else
	zstyle ':vcs_info:*' formats \
		"${VCS_THEME_PREFIX_0}%s${VCS_THEME_SUFFIX_0}" \
		"${VCS_THEME_PREFIX_1}%b${VCS_THEME_SUFFIX_1}" \
		"${VCS_THEME_PREFIX_2}%0.8i${VCS_THEME_SUFFIX_2}" \
		"${VCS_THEME_PREFIX_3}$(git_prompt_status)${VCS_THEME_SUFFIX_3}%F{none}" \
		"${rbranch_p}${my_hook_com[remote_branch]}${rbranch_s}%F{none}"
	fi


	zstyle ':vcs_info:*' actionformats \
		'%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

	
	# Second call to vcs_info
    vcs_info
}

if [[ ! "$DISABLE_VCS_INFO" = "true" ]]
then
	add-zsh-hook precmd	vcs_precmd
fi

