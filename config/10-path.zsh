# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------

# Should be sourced early on since other configs may rely on it.
# Give priority to exotic locations over the default ones.

function testpath() {
	dir=$1
	sep=':'
	if [[ $PATH = '' ]]; then sep=''
	fi

	if [[ -d $dir ]]; then 
		if [[ -x $dir ]]; then
			PATH+=$sep$dir
		fi
	fi
}

PATH=''

# Override with own utils
testpath "$HOME/bin"
testpath "$HOME/sbin"

testpath "/sw/bin"
testpath "/usr/texbin/"							# TexLive on Mac (symlink)
testpath "/usr/local/texbin/"					# TexLive
testpath "/opt/local/libexec/gnubin/"			# Macports
testpath "/opt/local/bin/"						# Macports
testpath "/usr/lib/distcc"						# Distcc
testpath "/usr/local/git/libexec/git-core"		# GIT completion
testpath "/usr/local/git/bin"					# GIT binaries

# Standard paths at the end
testpath '/bin'
testpath '/sbin'
testpath '/usr/bin'
testpath '/usr/sbin'
testpath '/usr/local/bin'
testpath '/usr/local/sbin'

if [[ -d /opt/local/share/man ]]
then
	export MANPATH=/opt/local/share/man:$MANPATH
fi

