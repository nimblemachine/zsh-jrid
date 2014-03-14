#!/bin/sh

# Check we can actually do a fair bit of automation
branch=$(git symbolic-ref HEAD 2> /dev/null | xargs basename)

if [[ "$branch" != "master" ]]; then
	echo " Zsh: branch master not checked out, not sure what you are doing."
	echo " Zsh: Aborting update."
	exit
fi

# First of all update top level vim scripts
echo ""
echo " Zsh: Updating zsh master branch"
git pull > /dev/null

