#!/bin/sh

export NORMANDY_PL_USER_HOST_ALWAYS_SHOW=true

__normandy_pl_user_host_seg () {
	local CONTENT=""
	local FG_COLOR=37 # light grey
	local DO_ADD_HOSTNAME=false
	# if there's an ssh connection OR if ALWAYS_SHOW
	# TODO: is SSH_CONNECTION always set?
	if [ $SSH_CONNECTION = ""]; then : ; else
		local DO_ADD_HOSTNAME=true
	fi
	if [ $NORMANDY_PL_USER_HOST_ALWAYS_SHOW = true ]; then
		local DO_ADD_HOSTNAME=true
	fi
	if [ $DO_ADD_HOSTNAME = true ]; then
		local CONTENT="\001\e[${FG_COLOR}m\002$(whoami)@$(hostname)"
	fi
	echo -n "$CONTENT"
}

__normandy_pl_user_host_seg_color () {
	echo -n "236" # a dark grey (maybe 237 would be better?)
}
