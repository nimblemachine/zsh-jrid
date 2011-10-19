# ------------------------------------------------------------------------------
# Generic Options for ZSH
# ------------------------------------------------------------------------------


# Remember that 'correct' and '_Co__rRe_cT_' are the same
# TODO:
# 	- describe what they do after reading the manual, maybe group them by theme
#	- what about login shells?
#
# See man zshoptions
# Using setopt
# setopt without arguments lists options set to non-default values.
# (this is true if ksh_option_print is not set)
#
# options is an associative array containing all options and their (on|off) values.
# can print that on screen with a bit of zsh magic:
# for key in ${(k)options}; do print $key = $options[$key]; done
#
# This sets most of the options, but some are set in specific configs (eg. dvorak)
#
# Tried to document the options as I was cleaning some historical files. Kept that here
# even if it is a bit redundant with the ZSH manual (there is an entire chapter describing
# options there).
# TODO: clean up to only show departure from default option values?
#


# Input / Output 
# correct:		propose correction for erroneous commands
# correct_all:	propose correction for entire line
# rm_star_silent: disable protection against crazy rm *
setopt \
	clobber \
	correct \
	correct_all \
	NO_flow_control \
	NO_ignore_eof \
	interactive_comments \
	hash_cmds \
	mail_warning \
	path_dirs \
	NO_print_exit_value \
	rc_quotes \
	NO_rm_star_silent \
	short_loops \


# Initialisation Options
setopt \
	all_export \



# Jobs Control Options
# bgnice: nice background jobs
# hup: sends hup to background jobs when shell exits (usually don't want that)
# notify: message indicating background job has finished
setopt \
	bgnice \
	NO_hup \
	long_list_jobs \
	monitor \
	notify \



# Scripts and Functions Options
setopt \
	c_bases \
	NO_err_exit \


# Shell Emulation Options
# csh_junkie_history:	
# csh_junkie_loops:		
# csh_null_glob:		
# csh_junkie_quotes:	
# ksh_option_print:	TODO
setopt \
	NO_cshjunkiequotes \
	NO_ksh_option_print \


# ZLE Options
# beep: beep when not happy
setopt \
	NO_beep \


# Expansion and Globbing Options 
setopt \
	brace_ccl \
	extended_glob \
	NO_glob_dots \
	mark_dirs \
	NO_nomatch \
	numeric_globsort \


