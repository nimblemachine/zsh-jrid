# ------------------------------------------------------------------------------
# Directory moves
# ------------------------------------------------------------------------------


# Changing Directory Options
# --------------------------
# auto_cd:			tries to cd to command line word (if that word is a directory)
# auto_name_dirs:	TODO
# auto_pushd:		make cd push the old directory onto the directory stack
# cdable_vars:		tries to expand unmatch args to cd as ~/args
# chase_dots:		TODO
# chase_links:		TODO
# posix_cd:			TODO
# pushd_ignore_dups: don’t push duplicates of the same directory onto the directory stack
# pushd_minus:		TODO
# pushd_silent:		Do not print the directory stack after pushd or popd
# pushd_to_home:	TODO
setopt \
	NO_auto_cd \
	auto_name_dirs \
	auto_pushd \
	cdable_vars \
	pushd_ignore_dups \
	pushd_silent \

# Changing/making/removing directory

# Moving on up
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

# Moving up, but with a blank space
cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../..
  else
    builtin cd "$@"
  fi
}


# Directory stack
alias -- -='cd -'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

