# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------

# Should be sourced early on since other configs may rely on it

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/pkg/bin

if [[ -d "$HOME/bin" ]]; then
	# Push my bin dir first to override stupid Apple broken utils
	PATH=$HOME/bin:$PATH
fi

if [[ -d "/sw/bin" ]]; then
	PATH+=:/sw/bin
fi

if [[ -d "/usr/local/teTeX/bin/powerpc-apple-darwin-current/" ]]; then
	PATH+=:/usr/local/teTeX/bin/powerpc-apple-darwin-current
fi
if [[ -d "/usr/texbin/" ]]; then
	PATH+=:/usr/texbin
fi
if [[ -d "/usr/local/texbin/" ]]; then
	PATH+=:/usr/local/texbin
fi
if [[ -d "/opt/local/bin/" ]]; then
	PATH+=:/opt/local/bin
fi

if [[ -d "/usr/lib/distcc" ]]; then
	PATH=/usr/lib/distcc:${PATH}
fi

# GIT completion
if [[ -d "/usr/local/git/libexec/git-core" ]]; then
	PATH+=:/usr/local/git/libexec/git-core
fi

# GIT binaries
if [[ -d "/usr/local/git/bin" ]]; then
	PATH+=:/usr/local/git/bin
fi

