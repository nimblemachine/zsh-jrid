# ZSH loader
#
if [[ ! -o interactive ]]; then
	return 0;
fi

# Useful to make sure which version we are running
print -- " Zsh $ZSH_VERSION loading theme $ZSH_THEME."

# First things first, make sure cache directories exist
# TODO slow start with zcompdump and NFS ... many, many files?
ZSH_CACHE=$ZSH_CACHE/$(hostname -s)
mkdir -p $ZSH_CACHE

# To test ZSH_VERSION
autoload -U is-at-least

# For config parts that do some fancy stuff with predefined functions
autoload -U add-zsh-hook

# Need this beforo loading config files
zmodload -i zsh/complist

# Load all of the config files in ~/.zsh/conf ending in .zsh
for config_file ($ZSH/config/*.zsh) source $config_file

# Add all defined plugins to fpath
plugin=${plugin:=()}
for plugin ($plugins) fpath=($ZSH/plugins/$plugin $fpath)

# Load and run compinit

autoload -U compinit
compinit -i -d $ZSH_CACHE/zcompdump

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
done

# # Load all of your custom configurations from custom/
# for config_file ($ZSH_CUSTOM/*.zsh) source $config_file

# Load the theme
if [ "$ZSH_THEME" = "random" ]
then
	themes=($ZSH/themes/*zsh-theme)
	N=${#themes[@]}
	((N=(RANDOM%N)+1))
	RANDOM_THEME=${themes[$N]}
	source "$RANDOM_THEME"
else
	if [ ! "$ZSH_THEME" = ""  ]
	then
		source "$ZSH/themes/$ZSH_THEME.zsh-theme"
	fi
fi

