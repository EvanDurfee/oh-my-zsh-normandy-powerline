#!/bin/sh

__normandy_pl_git_dir () {
	# path to the git root or nothing if not in a git tree
	echo -n $(git rev-parse --show-toplevel 2>/dev/null)
}

__normandy_pl_shorten_path_ellipses () {
	# swaps all but the last ($2 + 1) path elements defined as (/.+) with ellipses
	# local ELLIPSES_GLYPH="..."
	local ELLIPSES_GLYPH="\u2026" # …
	local SHORTENED=$(echo -n $1 | sed -E "s#^.*(/([^/]+/){$2}[^/]+)\$#\1#")
	if [ "$SHORTENED" = "$1" ]; then : ; else
		local SHORTENED="$ELLIPSES_GLYPH$SHORTENED"
	fi
	echo -n $SHORTENED
}

__normandy_pl_post_git_seg () {
	local DIR_FG="90"
	local GIT_DIR=$(__normandy_pl_git_dir)
	local CONTENT=""
	if [ "$GIT_DIR" = "" ]; then : ; else
		local WORKING_PATH=$(pwd | sed -E "s#^${GIT_DIR}/?##")
		if [ "$WORKING_PATH" = "" ]; then : ; else
			local WORKING_PATH=$(__normandy_pl_shorten_path_ellipses "$WORKING_PATH" 2)
			local CONTENT="\001\e[${DIR_FG}m$WORKING_PATH\002"
		fi
	fi
	echo -n "$CONTENT"
}

__normandy_pl_post_git_seg_color () {
	# check if the dir is writable for the current user
	if [ -w $(pwd) ]; then
		echo -n "236" # dark grey
	else
		echo -n "52" # dark red
	fi
}
