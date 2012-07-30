# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------

# Should be sourced early on since other configs may rely on it.
# Give priority to exotic locations over the default ones.
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/pkg/bin

PATH=''

if [[ -d "$HOME/bin" ]]; then
	# Push my bin dir first to override stupid Apple broken utils
	PATH+=$HOME/bin
fi

if [[ -d "/sw/bin" ]]; then
	PATH+=:/sw/bin
fi

if [[ -d "/usr/texbin/" ]]; then
	PATH+=:/usr/texbin
fi

if [[ -d "/usr/local/texbin/" ]]; then
	PATH+=:/usr/local/texbin
fi

if [[ -d "/opt/local/libexec/gnubin/" ]]; then
	PATH+=:/opt/local/libexec/gnubin
fi

if [[ -d "/opt/local/bin/" ]]; then
	PATH+=:/opt/local/bin
fi

if [[ -d "/usr/lib/distcc" ]]; then
	PATH+=:/usr/lib/distcc
fi

# GIT completion
if [[ -d "/usr/local/git/libexec/git-core" ]]; then
	PATH+=:/usr/local/git/libexec/git-core
fi

# GIT binaries
if [[ -d "/usr/local/git/bin" ]]; then
	PATH+=:/usr/local/git/bin
fi


# Standard paths at the end

if [[ -d '/bin' ]]; then 
	PATH+=:/bin
fi

if [[ -d '/sbin' ]]; then 
	PATH+=:/sbin
fi

if [[ -d '/usr/bin' ]]; then 
	PATH+=:/usr/bin
fi

if [[ -d '/usr/local/bin' ]]; then 
	PATH+=:/usr/local/bin
fi

if [[ -d '/usr/local/sbin' ]]; then 
	PATH+=:/usr/local/sbin
fi

