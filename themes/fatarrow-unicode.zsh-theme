# -----------------------------------------------------------------------------
# Theme minima-unicode 
#
# A more compact theme with unicode support 
# -----------------------------------------------------------------------------

# vcs_info_msg_0_: vcs name 
# vcs_info_msg_1_: branch name and revision (for bzr, svn, svk and hg)
# vcs_info_msg_2_: revision number or sha
# vcs_info_msg_3_: staged, unstaged and untracked status
# vcs_info_msg_4_: name of remote branch tracked and commit status (need to be fetched) 

VCS_THEME_PREFIX_0=' %F{bold}%F{green}'
VCS_THEME_SUFFIX_0=''
VCS_THEME_PREFIX_1='%F{bold}%F{green}(%F{normal}%F{white}'
VCS_THEME_SUFFIX_1='%F{bold}%F{green})'
VCS_THEME_PREFIX_2=''
VCS_THEME_SUFFIX_2=''
VCS_THEME_PREFIX_3=' '
VCS_THEME_SUFFIX_3='%F{none}'
VCS_THEME_PREFIX_4='%F{bold}%F{green}[%F{normal}%F{white}'
VCS_THEME_SUFFIX_4='%F{bold}%F{green}]'


VCS_BRANCH_FORMAT='%b'
VCS_STAGED_STRING='%F{green}●'
VCS_MODIFIED_STRING='%F{yellow}●'
VCS_UNTRACKED_STRING='%F{red}●'


PROMPT='%{$fg_bold[red]%}➜ %b%{$fg[cyan]%}%1~${vcs_info_msg_0_}${vcs_info_msg_1_}${vcs_info_msg_3_} %F{green}$%F{white}%b '

RPROMPT=$'${vcs_info_msg_4_} %F{bold}%F{magenta}[%n@%m %*]%b'

# Format of the output of time command
TIMEFMT="[1;36m %J [0;36m: CPU=%P TIME=%E USER=%U KERNEL=%S[37m"

# Prompt used for spelling correction
SPROMPT="%{[36m%}Oups... do you mean %U%r%u [36minstead? (y/n/e) %{[37m%}"

# The format of login/logout reports if the watch parameter is set.
WATCHFMT="%B->%b %n just %a %(l:line %l:%U-Ghmst-%u)%(m: from %m:)"



