# ------------------------------------------------------------------------------
# Vim
# ------------------------------------------------------------------------------

# Need to have custom mvim script in your path for it to be detected
# My version is an edited version of the one shipped with MacVim.
# I may merged it in here one day

function _my_vim()
{
	local my_vi

	my_vi=$(which mvim)
	err=$?
	if [[ $err -eq 1 ]]; then
		my_vi=$(which vim)	
		err=$?
	fi
	if [[ $err -eq 1 ]]; then
		my_vi=$(which vi)	
	fi

	EDITOR=$my_vi
	VISUAL=$my_vi
	alias vi=$my_vi
	alias vim=$my_vi
}

_my_vim

