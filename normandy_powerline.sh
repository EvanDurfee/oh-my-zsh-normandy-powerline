#!/bin/sh

# global
NORMANDY_PL_BG_COLOR=""

NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH='\uE0B0' # right arrow
NORMANDY_PL_LEFT_SEPERATOR_GLYPH='\uE0B1'
NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH='\uE0B2' # left arrow
NORMANDY_PL_RIGHT_SEPERATOR_GLYPH='\uE0B3'

# shell status segment
NORMANDY_PL_SHELL_STATUS_SEG_BG=15 # white
NORMANDY_PL_EXIT_STATUS_GLYPH="! "
NORMANDY_PL_EXIT_STATUS_FG=1 # red
NORMANDY_PL_JOB_STATUS_GLYPH="% "
NORMANDY_PL_JOB_STATUS_FG=6 # cyan
NORMANDY_PL_IS_ROOT_GLYPH="\$ "
NORMANDY_PL_IS_ROOT_FG=2 # green


__normandy_pl_set_fg () {
	if [ $1 ]; then
		echo -ne "\001\e[38;5;${1}m\002"
	else
		echo -ne "\001\e[39m\002" # default fg
	fi
}

__normandy_pl_start_segment_l () {
	local NEW_BG_COLOR=$1
	echo -ne "\001\e[48;5;${NEW_BG_COLOR}m\002"
	case $NORMANDY_PL_BG_COLOR in
		"")
			echo -n " "
			;;
		$NEW_BG_COLOR)
			echo -n "$NORMANDY_PL_LEFT_SEPERATOR_GLYPH "
			;;
		*)
			__normandy_pl_set_fg $NORMANDY_PL_BG_COLOR
			echo -n "$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH "
			;;
	esac
	NORMANDY_PL_BG_COLOR=$NEW_BG_COLOR
}

__normandy_pl_end_prompt_l () {
	echo -ne "\001\e[49m\002"
	case $NORMANDY_PL_BG_COLOR in
		"")
			__normandy_pl_set_fg 1 # default color ?
			echo -ne " $NORMANDY_PL_LEFT_SEPERATOR_GLYPH "
			;;
		*)
			__normandy_pl_set_fg $NORMANDY_PL_BG_COLOR
			echo -ne "$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH "
			;;
	esac
	echo -ne "\001\e[0m\002"
}

__normandy_pl_shell_status_seg () {
	EXIT_STATUS=$?
	local NON_ZERO_EXIT_STATUS=""
	local IS_ROOT=""
	local JOBS=""

	[ $EXIT_STATUS -ne 0 ] && local NON_ZERO_EXIT_STATUS=$EXIT_STATUS
	[ $(id -u) -eq 0 ] && local IS_ROOT=1
	[ "$(jobs)" ] && local JOBS=1

	if [ "$NON_ZERO_EXIT_STATUS" -o "$IS_ROOT" -o "$JOBS" ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_SHELL_STATUS_SEG_BG
		echo -ne "\001\e[1m\002" # set bold
		if [ $NON_ZERO_EXIT_STATUS ]; then
			__normandy_pl_set_fg $NORMANDY_PL_EXIT_STATUS_FG
			# echo -ne "\001\e[1m\002${NORMANDY_PL_EXIT_STATUS_GLYPH}\001\e[21m\002"
			echo -n "${NORMANDY_PL_EXIT_STATUS_GLYPH}"
		fi
		if [ $JOBS ]; then
			__normandy_pl_set_fg $NORMANDY_PL_JOB_STATUS_FG
			echo -n "${NORMANDY_PL_JOB_STATUS_GLYPH}"
		fi
		if [ $IS_ROOT ]; then
			__normandy_pl_set_fg $NORMANDY_PL_IS_ROOT_FG
			echo -n "${NORMANDY_PL_IS_ROOT_GLYPH}"
		fi
		echo -ne "\001\e[22m\002" # unset bold
	fi
}

__normandy_pl_pre_git_path_seg () {

}

__normandy_pl_prompt_left () {
	echo "BEGIN"
	__normandy_pl_shell_status_seg
	__normandy_pl_end_prompt_l
	echo ""
	echo "END"
}
