# -----------------------------------------------------------------------------
# Some ZSH stuff for the dvorak keyboard 



if [[ "$ZSH_DVORAK_KB" == "true" ]]
then

setopt dvorak


if [ ! $DISPLAY ]; then
	# We are on a virtual console ... yes?
	case `uname` in
		FreeBSD)
			alias aoeu='echo "Changing to us.iso";kbdcontrol -l us.iso'
			alias asdf='echo "Changing to us.dvorak";kbdcontrol -l us.dvorak'
			;;

		Linux)
			# Need console-common?
			alias aoeu='sudo loadkeys us'
			alias asdf='sudo loadkeys dvorak'
			;;
	esac
else
	case `uname` in
		FreeBSD | Linux)
			alias aoeu='echo "Changing to us";setxkbmap us'
			alias asdf='echo "Changing to us.dvorak";setxkbmap us -variant dvorak'

		;;
	esac
fi


# End of test on Dvorak config
fi

