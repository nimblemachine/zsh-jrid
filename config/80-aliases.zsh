# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------


# Note on precommand modifiers
# builtin			The command word is taken to be the name of a builtin
#					command, rather than a shell function or external command.
# command [-pvV]	The command word is an external command and not a shell 
#					builtin or function
# nocorrect			No spelling correction made on any word
# noglob			File name generation is not performed on any of the words

alias n=noglob

alias du='du -hcs'
alias df='df -h'
alias rh='sync;rehash;sync'
alias h='history | more'
alias rpurge='find . \( -name ".*~" -o -name "*%" -o -name "*.aux" -o -name "*.clz" -o -name "*.toc" -o -name ".nfs*" -o -name ".*%" -o -name "core" -o -name "*.bak" -o -name "*.old" -o -name "*.OLD" -o -name "*~" -o -name "#*" \) -print -exec rm -f {} \;'
alias purge='rm -f .*~ "#"* "#".* *~ *% .*% *.pdfsync *.bbl *.log *.blg *.aux *.clz *.toc *.o *.bak .nfs* core >& /dev/null'
alias j='jobs -l'
alias c='clear'
alias bc='bc -q -l'
alias gdb='gdb -q'
alias tf='tail -f'

alias cp='nocorrect cp -piv'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -iv'


# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Super user
alias _='sudo'

# Show history
alias history='history -f'

