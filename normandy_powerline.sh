#!/bin/sh

# global
NORMANDY_PL_BG_COLOR=""

NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B0') # right arrow
NORMANDY_PL_LEFT_SEPERATOR_GLYPH=$(echo -ne '\uE0B1')
NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B2') # left arrow
NORMANDY_PL_RIGHT_SEPERATOR_GLYPH=$(echo -ne '\uE0B3')

# shell status segment
NORMANDY_PL_SHELL_STATUS_SEG_BG=255 # white
NORMANDY_PL_EXIT_STATUS_GLYPH="! "
NORMANDY_PL_EXIT_STATUS_FG=1 # red
NORMANDY_PL_JOB_STATUS_GLYPH="% "
NORMANDY_PL_JOB_STATUS_FG=24 # dark blue
NORMANDY_PL_IS_ROOT_GLYPH="\$ "
NORMANDY_PL_IS_ROOT_FG=2 # green

# user host segment
NORMANDY_PL_USER_HOST_BG=250 # grey
NORMANDY_PL_USER_FG=24 # white
NORMANDY_PL_HOST_FG=24 # white
NORMANDY_PL_AT_HOSTNAME_GLYPH="@"
NORMANDY_PL_SHOW_USER="ssh" # null (never), ssh, or other (always)
NORMANDY_PL_SHOW_HOST="ssh" # null (never), ssh, or other (always)


# path segments
NORMANDY_PL_PATH_ELLIPSES_GLYPH=$(echo -ne '\u2026') # …
# NORMANDY_PL_PATH_ELLIPSES_GLYPH="..."

NORMANDY_PL_WRITABLE_DIR_BG=236 # dark grey
NORMANDY_PL_NON_WRITABLE_DIR_BG=52 # dark red
NORMANDY_PL_PATH_FG=246 # grey
NORMANDY_PL_PROJECT_DIR_FG=255 # white


# git segment

# NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH='\u2B07 ' #⬇
# NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH='-'
NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH=$(echo -ne '\uF0DD')
# NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH='\u2B06 ' #⬆
# NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH='+'
NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH=$(echo -ne '\uF0DE')
# NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH='\u2B0D ' #⬍
# NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH='±'
NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH=$(echo -ne '\uF0DC')
NORMANDY_PL_GIT_BRANCH_GLYPH=$(echo -ne '\uF418')
NORMANDY_PL_GIT_DETATCHED_GLYPH=$(echo -ne '\uF417')
# NORMANDY_PL_GIT_TAG_GLYPH='\u2302' # ⌂
NORMANDY_PL_GIT_TAG_GLYPH=$(echo -ne '\uF412')
NORMANDY_PL_GIT_UNSTAGED_CHANGES_GLYPH=$(echo -ne '\uF448')
NORMANDY_PL_GIT_STAGED_CHANGES_GLYPH=$(echo -ne '\uF0C7')
NORMANDY_PL_GIT_STASHED_CHANGES_GLYPH=$(echo -ne '\uF0C6')
NORMANDY_PL_GIT_UNTRACKED_FILES_GLYPH=$(echo -ne '\uF128')

NORMANDY_PL_CLEAN_GIT_BG=76
NORMANDY_PL_CLEAN_GIT_FG=236
NORMANDY_PL_UNSTAGED_GIT_BG=124
NORMANDY_PL_UNSTAGED_GIT_FG=246
NORMANDY_PL_STAGED_GIT_BG=172
NORMANDY_PL_STAGED_GIT_FG=236



__normandy_pl_set_fg () {
	if [ $1 ]; then
		echo -ne "\001\e[38;5;${1}m\002"
	else
		echo -ne "\001\e[39m\002" # default fg
	fi
}

__normandy_pl_set_bold () {
	echo -ne "\001\e[1m\002"
}

__normandy_pl_unset_bold () {
	echo -ne "\001\e[22m\002"
}

__normandy_pl_start_segment_l () {
	local NEW_BG_COLOR=$1
	echo -ne "\001\e[48;5;${NEW_BG_COLOR}m\002"
	case $NORMANDY_PL_BG_COLOR in
		"")
			echo -n " "
			;;
		$NEW_BG_COLOR)
			echo -ne "$NORMANDY_PL_LEFT_SEPERATOR_GLYPH "
			;;
		*)
			__normandy_pl_set_fg $NORMANDY_PL_BG_COLOR
			echo -ne "$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH "
			;;
	esac
	NORMANDY_PL_BG_COLOR=$NEW_BG_COLOR
}

__normandy_pl_end_prompt_l () {
	echo -ne "\001\e[49m\002"
	case $NORMANDY_PL_BG_COLOR in
		"")
			__normandy_pl_set_fg 1 # default color ?
			echo -n " $NORMANDY_PL_LEFT_SEPERATOR_GLYPH "
			;;
		*)
			__normandy_pl_set_fg $NORMANDY_PL_BG_COLOR
			echo -n "$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH "
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
		__normandy_pl_set_bold
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
		__normandy_pl_unset_bold
	fi
}

__normandy_pl_user_host_seg () {
	local SHOW_USER="$NORMANDY_PL_SHOW_USER"
	local SHOW_HOST="$NORMANDY_PL_SHOW_HOST"
	[ "$NORMANDY_PL_SHOW_USER" = "ssh" -a "$SSH_CONNECTION" = "" ] && local SHOW_USER=""
	[ "$NORMANDY_PL_SHOW_HOST" = "ssh" -a "$SSH_CONNECTION" = "" ] && local SHOW_HOST=""

	if [ "$SHOW_USER" -o "$SHOW_HOST" ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_USER_HOST_BG
		__normandy_pl_set_bold
		if [ "$SHOW_USER" ]; then
			__normandy_pl_set_fg $NORMANDY_PL_USER_FG
			echo -n "$(whoami)"
		fi
		if [ "$SHOW_HOST" ]; then
			__normandy_pl_set_fg $NORMANDY_PL_HOST_FG
			[ "$SHOW_USER" ] && echo -n "$NORMANDY_PL_AT_HOSTNAME_GLYPH"
			echo -n "$(hostname)"
		fi
		echo -n " "
		__normandy_pl_unset_bold
	fi
}

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

__normandy_pl_shorten_path_ellipses () {
	# swaps all but the last ($2 + 1) path elements defined as (/.+) with ellipses
	local SHORTENED=$(echo -n $1 | sed -E "s#^.*(/([^/]+/){$2}[^/]+)\$#\1#")
	if [ "$SHORTENED" != "$1" ]; then
		echo -n "$NORMANDY_PL_PATH_ELLIPSES_GLYPH$SHORTENED"
	else
		echo -n $SHORTENED
	fi
}

__normandy_pl_pre_git_path_seg () {
	local WORKING_PATH="$(__normandy_pl_git_dir)"
	if [ "$WORKING_PATH" = "" ]; then
		local WORKING_PATH="$(pwd)"
	fi
	local WORKING_PATH=$(__normandy_pl_swap_home "$WORKING_PATH")
	local WORKING_PATH=$(__normandy_pl_shorten_path_ellipses "$WORKING_PATH" 2)

	if [ -w $(pwd) ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_WRITABLE_DIR_BG
		__normandy_pl_set_fg $NORMANDY_PL_PATH_FG
		__normandy_pl_basename "$WORKING_PATH"
		__normandy_pl_set_bold
		__normandy_pl_set_fg $NORMANDY_PL_PROJECT_DIR_FG
		__normandy_pl_dirname "$WORKING_PATH"
	else
		__normandy_pl_start_segment_l $NORMANDY_PL_NON_WRITABLE_DIR_BG
		__normandy_pl_set_fg $NORMANDY_PL_PATH_FG
		__normandy_pl_basename "$WORKING_PATH"
		__normandy_pl_set_bold
		__normandy_pl_dirname "$WORKING_PATH"
	fi
	__normandy_pl_unset_bold
	echo -n " "
}

__normandy_pl_git_seg () {
	local GIT_DIR="$(__normandy_pl_git_dir)"
	if [ "$GIT_DIR" ]; then
		local STASHED_CHANGES=""
		local UNSTAGED_CHANGES=""
		local STAGED_CHANGES=""
		local UNTRACKED_FILES=""

		# refresh the index
		git update-index -q --ignore-submodules --refresh

		# stashed changes
		[ "$(git rev-parse --verify --quiet refs/stash)" != "" ] && local STASHED_CHANGES=1
		# unstaged changes
		git diff-files --quiet --ignore-submodules --
		[ $? -ne 0 ] && local UNSTAGED_CHANGES=1
		# staged changes
		git diff-index --cached --quiet HEAD --ignore-submodules --
		[ $? -ne 0 ] && local STAGED_CHANGES=1
		 # untracked files
		[ "$(git ls-files --exclude-standard --others $GIT_DIR)" ] && local UNTRACKED_FILES=1

		# set colors
		if [ "$UNSTAGED_CHANGES" ]; then
			__normandy_pl_start_segment_l $NORMANDY_PL_UNSTAGED_GIT_BG
			__normandy_pl_set_fg $NORMANDY_PL_UNSTAGED_GIT_FG
		elif [ "$STAGED_CHANGES" ]; then
			__normandy_pl_start_segment_l $NORMANDY_PL_STAGED_GIT_BG
			__normandy_pl_set_fg $NORMANDY_PL_STAGED_GIT_FG
		else
			__normandy_pl_start_segment_l $NORMANDY_PL_CLEAN_GIT_BG
			__normandy_pl_set_fg $NORMANDY_PL_CLEAN_GIT_FG
		fi

		# ahead / behind upstream (if set)
		local DOWNSTREAM_COMMITS="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
		local UPSTREAM_COMMITS="$(git rev-list --count HEAD..@{upstream} 2>/dev/null)"

		if [ "$DOWNSTREAM_COMMITS" ]; then
			if [ "$UPSTREAM_COMMITS" ]; then
				echo -n "$NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH"
			else
				echo -n "$NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH"
			fi
		elif [ "$UPSTREAM_COMMITS" ]; then
			echo -n "$NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH"
		fi

		# current branch / tag / hash
		local GIT_REF="$(git symbolic-ref --short HEAD 2>/dev/null)"
		if [ "$GIT_REF" ]; then
			# branch name
			echo -n "$NORMANDY_PL_GIT_BRANCH_GLYPH $GIT_REF "
		else
			local GIT_TAG="$(git describe --tags --no-long 2>/dev/null)"
			if [ $? -eq 0 ]; then
				# latest tag name
				echo -n "$NORMANDY_PL_GIT_TAG_GLYPH $GIT_TAG "
			else
				# short hash
				echo -n "$NORMANDY_PL_GIT_DETATCHED_GLYPH $(git rev-parse --short HEAD 2>/dev/null) "
			fi
		fi

		[ "$STASHED_CHANGES" ] && echo -n "$NORMANDY_PL_GIT_STASHED_CHANGES_GLYPH "
		[ "$UNSTAGED_CHANGES" ] && echo -n "$NORMANDY_PL_GIT_UNSTAGED_CHANGES_GLYPH "
		[ "$STAGED_CHANGES" ] && echo -n "$NORMANDY_PL_GIT_STAGED_CHANGES_GLYPH "
		[ "$UNTRACKED_FILES" ] && echo -n "$NORMANDY_PL_GIT_UNTRACKED_FILES_GLYPH "
	fi
}


__normandy_pl_prompt_left () {
	NORMANDY_PL_BG_COLOR=""
	echo "BEGIN"
	__normandy_pl_shell_status_seg
	__normandy_pl_user_host_seg
	__normandy_pl_pre_git_path_seg
	__normandy_pl_git_seg
	__normandy_pl_end_prompt_l
	echo ""
	echo "END"
}
