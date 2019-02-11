#!/bin/sh

__normandy_pl_pre_git_seg () {
	local PARENT_DIR_FG="90"
	local CURRENT_DIR_FG="15"
	# local CURRENT_DIR=$(pwd | sed -E "s#^$HOME($|(/.*))#~\2#") # assumes no # are in the path... this seems reasonable
	local GIT_DIR=$(git rev-parse --show-toplevel 2>/dev/null)
	local WORKING_PATH=""
	if [ "$GIT_DIR" = "" ]; then
		local WORKING_PATH="$GIT_DIR"
	else
		local WORKING_PATH="$(pwd)"
	fi
	local WORKING_PATH=$(echo $WORKING_PATH | sed -E "s#^$HOME($|(/.*))#~\2#") # replace leading $HOME with ~
	local PARENT_DIR=$(echo $WORKING_PATH | sed -E "s#[^/]+\$##")
	local CURRENT_DIR=$(echo $WORKING_PATH | sed -E "s#^.*/##")

	local CONTENT=""
	if [ "$PARENT_DIR" = "" ]; then : ; else
		local CONTENT="\001\e[${PARENT_DIR_FG}m\002${PARENT_DIR}"
	fi
	local CONTENT="${CONTENT}\001\e[${CURRENT_DIR_FG};1m\002${CURRENT_DIR}\001\e[21m\002"
	echo -n "$CONTENT"
}

__normandy_pl_pre_git_seg_color () {
	# check if the dir is writable for the current user
	if [ -w $(pwd) ]; then
		echo -n "236" # dark grey
	else
		echo -n "52" # dark red
	fi
}
