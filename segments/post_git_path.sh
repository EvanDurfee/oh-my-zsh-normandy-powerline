#!/bin/sh

__normandy_pl_post_git_seg () {
	local PARENT_DIR_FG="90"
	local CURRENT_DIR_FG="97"
	# local CURRENT_DIR=$(pwd | sed -E "s#^$HOME($|(/.*))#~\2#") # assumes no # are in the path... this seems reasonable
	local GIT_DIR=$(git rev-parse --show-toplevel 2>/dev/null)
	local CONTENT=""
	if [ "$GIT_DIR" = "" ]; then : ; else
		local WORKING_PATH=$(pwd | sed -E "s#^${GIT_DIR}/?##")
		# TODO: format the path (also pre-git)
		local PARENT_DIR=$(echo $WORKING_PATH | sed -E "s#[^/]+\$##")
		local CURRENT_DIR=$(echo $WORKING_PATH | sed -E "s#^.*/##")
		local CONTENT=""
	fi
}

__normandy_pl_post_git_seg_color () {
	# check if the dir is writable for the current user
	if [ -w $(pwd) ]; then
		echo -n "236" # dark grey
	else
		echo -n "52" # dark red
	fi
}
