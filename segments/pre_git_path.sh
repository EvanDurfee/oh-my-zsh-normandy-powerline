#!/bin/sh

__normandy_pl_dirname () {
	# variation on dirname that returns the last element of a path
	# eg '~/foo/bar' -> 'bar', and '~' -> '~'
	echo -n $1 | sed -E "s#^.*/##"
}

__normandy_pl_basename () {
	# variation on basename that returns the path preceding the final entry, or nothing
	# eg '~/foo/bar' -> '~/foo/', and '~' -> ''
	echo -n $1 | sed -E "s#[^/]+\$##"
}

__normandy_pl_swap_home () {
	# replaces $HOME in a path with ~
	echo -n $1 | sed -E "s#^$HOME($|(/))#~\2#"
}

__normandy_pl_git_dir () {
	# path to the git root or nothing if not in a git tree
	echo -n $(git rev-parse --show-toplevel 2>/dev/null)
}

__normandy_pl_pre_git_seg () {
	local PARENT_DIR_FG="90"
	local CURRENT_DIR_FG="97"

	local WORKING_PATH="$(__normandy_pl_git_dir)"
	if [ "$WORKING_PATH" = "" ]; then
		local WORKING_PATH="$(pwd)"
	fi
	local WORKING_PATH=$(__normandy_pl_swap_home "$WORKING_PATH")
	local PARENT_DIR=$(__normandy_pl_basename "$WORKING_PATH")
	local CURRENT_DIR=$(__normandy_pl_dirname "$WORKING_PATH")

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
