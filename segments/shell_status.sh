#!/bin/sh

__normandy_pl_shell_status_seg () {
	local EXIT_STATUS=$?
	local CONTENT=""
	local EXIT_STATUS_FG="31" # red
	local IS_ROOT_FG="32" # green
	local JOB_STATUS_FG="36" # cyan

	if [ $EXIT_STATUS -ne 0 ]; then
		local CONTENT="\001\e[${EXIT_STATUS_FG};1m\002! \001\e[21m\002"
	fi

	if [ $(id -u) -eq 0 ]; then
		local CONTENT="$CONTENT\001\e[${IS_ROOT_FG}m\002\$ "
	fi

	if [ "$(jobs)" = "" ]; then : ; else
		local CONTENT="$CONTENT\001\e[${JOB_STATUS_FG}m\002% "
	fi

	echo -n "$CONTENT"
}

__normandy_pl_shell_status_seg_color () {
	echo -n "15" # white
}
