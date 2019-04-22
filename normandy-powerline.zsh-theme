#!/bin/zsh

# global
NORMANDY_PL_BG_COLOR=""

NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B0') # right arrow
NORMANDY_PL_LEFT_SEPERATOR_GLYPH=$(echo -ne '\uE0B1')
NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B2') # left arrow
NORMANDY_PL_RIGHT_SEPERATOR_GLYPH=$(echo -ne '\uE0B3')

# NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B4') # )
# NORMANDY_PL_LEFT_SEPERATOR_GLYPH=$(echo -ne '\uE0B5')
# NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0B6') # (
# NORMANDY_PL_RIGHT_SEPERATOR_GLYPH=$(echo -ne '\uE0B7')
#
# NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0Bc') # /
# NORMANDY_PL_LEFT_SEPERATOR_GLYPH=$(echo -ne '\uE0Bd')
# NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0Be') # \
# NORMANDY_PL_RIGHT_SEPERATOR_GLYPH=$(echo -ne '\uE0Bf')

# NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0b8') # \
# NORMANDY_PL_LEFT_SEPERATOR_GLYPH=$(echo -ne '\uE0b9')
# NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH=$(echo -ne '\uE0ba') # /
# NORMANDY_PL_RIGHT_SEPERATOR_GLYPH=$(echo -ne '\uE0bb')

# shell status segment
NORMANDY_PL_SHELL_STATUS_SEG_BG=231 # white
NORMANDY_PL_EXIT_STATUS_GLYPH="! "
NORMANDY_PL_EXIT_STATUS_FG=1 # red
NORMANDY_PL_JOB_STATUS_GLYPH="%% " # Need second % to escape for zsh
NORMANDY_PL_JOB_STATUS_FG=24 # dark blue
NORMANDY_PL_IS_ROOT_GLYPH="\$ "
NORMANDY_PL_IS_ROOT_FG=2 # green

# user host segment
# NORMANDY_PL_USER_HOST_BG=254 # light grey
# NORMANDY_PL_USER_FG=22 # dark green
# NORMANDY_PL_HOST_FG=22 # dark green
NORMANDY_PL_USER_HOST_BG=237 # dark grey
NORMANDY_PL_USER_FG=12 # green
NORMANDY_PL_HOST_FG=12 # green
# NORMANDY_PL_USER_FG=12 # blue
# NORMANDY_PL_HOST_FG=12 # blue
NORMANDY_PL_AT_HOSTNAME_GLYPH="@"
NORMANDY_PL_SHOW_USER="always" # null (never), ssh, or other (always)
NORMANDY_PL_SHOW_HOST="ssh" # null (never), ssh, or other (always)


# path segments
NORMANDY_PL_PRE_GIT_BASENAME_SEGMENTS=0
NORMANDY_PL_POST_GIT_BASENAME_SEGMENTS=2
NORMANDY_PL_PATH_ELLIPSES_GLYPH=$(echo -ne '\u2026') # …
# NORMANDY_PL_PATH_ELLIPSES_GLYPH="..."

NORMANDY_PL_WRITABLE_DIR_BG=237 # dark grey
NORMANDY_PL_WRITABLE_BASENAME_FG=249 # grey
NORMANDY_PL_NON_WRITABLE_DIR_BG=52 # dark red
NORMANDY_PL_NON_WRITABLE_BASENAME_FG=249 # grey
NORMANDY_PL_PROJECT_DIR_FG=231 # white


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

NORMANDY_PL_GIT_CLEAN_BG=148 # light green
# NORMANDY_PL_GIT_CLEAN_BG=190 # light green
# NORMANDY_PL_GIT_CLEAN_FG=236 # dark grey
NORMANDY_PL_GIT_CLEAN_FG=22 # dark green
# NORMANDY_PL_GIT_UNSTAGED_BG=124 # dark red
# NORMANDY_PL_GIT_UNSTAGED_FG=231 # white
# NORMANDY_PL_GIT_UNSTAGED_BG=172 # dark orange
# NORMANDY_PL_GIT_UNSTAGED_FG=236 # dark grey
NORMANDY_PL_GIT_UNSTAGED_BG=220 # yellow-orange
# NORMANDY_PL_GIT_UNSTAGED_BG=3 # dull-yellow
NORMANDY_PL_GIT_UNSTAGED_FG=236 # dark grey
NORMANDY_PL_GIT_STAGED_BG=5 # a pale, dark-ish purple
NORMANDY_PL_GIT_STAGED_FG=255 # very light grey

NORMANDY_PL_GIT_SHOW_HEAD="1"
NORMANDY_PL_GIT_SHOW_STASHED="1"
NORMANDY_PL_GIT_SHOW_UNSTAGED=""
NORMANDY_PL_GIT_SHOW_STAGED="1"
NORMANDY_PL_GIT_SHOW_UNTRACKED="1"

# timestamp segment
NORMANDY_PL_TIMESTAMP_FG=239
NORMANDY_PL_TIMESTAMP_FORMAT="+%F %T"

# ZSH:
# %B %b - bold
# %F{number} %f - foreground color
# %K{number} %k - background color

__normandy_pl_start_segment_l () {
	case "$NORMANDY_PL_BG_COLOR" in
		"")
			echo -n "%K{$1} "
			;;
		"$1")
			echo -n "$NORMANDY_PL_LEFT_SEPERATOR_GLYPH "
			;;
		*)
		  echo -n "%K{$1}%F{$NORMANDY_PL_BG_COLOR}$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH "
			;;
	esac
	NORMANDY_PL_BG_COLOR=$1
}

__normandy_pl_end_prompt_l () {
	[ "$NORMANDY_PL_BG_COLOR" = "" ] && NORMANDY_PL_BG_COLOR=1
	echo -n "%k%F{$NORMANDY_PL_BG_COLOR}$NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH%f "
}

__normandy_pl_shell_status_seg () {
	EXIT_STATUS=$1
	local NON_ZERO_EXIT_STATUS=""
	local IS_ROOT=""
	local JOBS=""

	[ $EXIT_STATUS -ne 0 ] && local NON_ZERO_EXIT_STATUS=$EXIT_STATUS
	[ $(id -u) -eq 0 ] && local IS_ROOT=1
	[ "$(jobs)" ] && local JOBS=1

	if [ "$NON_ZERO_EXIT_STATUS" -o "$IS_ROOT" -o "$JOBS" ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_SHELL_STATUS_SEG_BG
		if [ $NON_ZERO_EXIT_STATUS ]; then
			echo -n "%B%F{$NORMANDY_PL_EXIT_STATUS_FG}${NORMANDY_PL_EXIT_STATUS_GLYPH}%b"
		fi
		if [ $JOBS ]; then
			echo -n "%B%F{$NORMANDY_PL_JOB_STATUS_FG}${NORMANDY_PL_JOB_STATUS_GLYPH}%b"
		fi
		if [ $IS_ROOT ]; then
			echo -n "%B%F{$NORMANDY_PL_IS_ROOT_FG}${NORMANDY_PL_IS_ROOT_GLYPH}%b"
		fi
	fi
}

__normandy_pl_user_host_seg () {
	local SHOW_USER="$NORMANDY_PL_SHOW_USER"
	local SHOW_HOST="$NORMANDY_PL_SHOW_HOST"
	[ "$NORMANDY_PL_SHOW_USER" = "ssh" -a "$SSH_CONNECTION" = "" ] && local SHOW_USER=""
	[ "$NORMANDY_PL_SHOW_HOST" = "ssh" -a "$SSH_CONNECTION" = "" ] && local SHOW_HOST=""

	if [ "$SHOW_USER" -o "$SHOW_HOST" ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_USER_HOST_BG
		if [ "$SHOW_USER" ]; then
			echo -n "%B%F{$NORMANDY_PL_USER_FG}$(whoami)%b"
		fi
		if [ "$SHOW_HOST" ]; then
			if [ "$SHOW_USER" ]; then
				echo -n "%B%F{$NORMANDY_PL_HOST_FG}$NORMANDY_PL_AT_HOSTNAME_GLYPH$(hostname)%b"
			else
				echo -n "%B%F{$NORMANDY_PL_HOST_FG}$(hostname)%b"
			fi
		fi
		echo -n " "
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

__normandy_pl_shorten_path () {
	# swap home for ~ and replace all but the last $BASENAME_SEGMENTS + 1 path segments with a glyph
	echo -n $1 | sed -E "s#^$HOME($|(/))#~\2#; s#^.*(/([^/]+/){$2}[^/]+)\$#$NORMANDY_PL_PATH_ELLIPSES_GLYPH\1#"
}

__normandy_pl_pre_git_path_seg () {
	local WORKING_PATH=$1
	local BASENAME_SEGMENTS=$NORMANDY_PL_PRE_GIT_BASENAME_SEGMENTS
	if [ "$WORKING_PATH" = "" ]; then
		local WORKING_PATH="$(pwd)"
		local BASENAME_SEGMENTS=$NORMANDY_PL_POST_GIT_BASENAME_SEGMENTS
	fi
	if [ -w $WORKING_PATH ]; then
		local WRITABLE_DIR=1
	else
		local WRITABLE_DIR=0
	fi

	local WORKING_PATH=$(__normandy_pl_shorten_path $WORKING_PATH $BASENAME_SEGMENTS)

	if [ $WRITABLE_DIR -eq 1 ]; then
		__normandy_pl_start_segment_l $NORMANDY_PL_WRITABLE_DIR_BG
		echo -n "%F{$NORMANDY_PL_WRITABLE_BASENAME_FG}$(__normandy_pl_basename $WORKING_PATH)%F{$NORMANDY_PL_PROJECT_DIR_FG}%B$(__normandy_pl_dirname $WORKING_PATH)"
	else
		__normandy_pl_start_segment_l $NORMANDY_PL_NON_WRITABLE_DIR_BG
		echo -n "%F{$NORMANDY_PL_NON_WRITABLE_BASENAME_FG}$(__normandy_pl_basename $WORKING_PATH)%B$(__normandy_pl_dirname $WORKING_PATH)"
	fi
}

__normandy_pl_git_seg () {
	local GIT_DIR=$1
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
			__normandy_pl_start_segment_l $NORMANDY_PL_GIT_UNSTAGED_BG
			echo -n "%F{$NORMANDY_PL_GIT_UNSTAGED_FG}"
		elif [ "$STAGED_CHANGES" ]; then
			__normandy_pl_start_segment_l $NORMANDY_PL_GIT_STAGED_BG
			echo -n "%F{$NORMANDY_PL_GIT_STAGED_FG}"
		else
			__normandy_pl_start_segment_l $NORMANDY_PL_GIT_CLEAN_BG
			echo -n "%F{$NORMANDY_PL_GIT_CLEAN_FG}"
		fi

		# ahead / behind upstream (if set)
		local DOWNSTREAM_COMMITS="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
		local UPSTREAM_COMMITS="$(git rev-list --count HEAD..@{upstream} 2>/dev/null)"

		if [ "$DOWNSTREAM_COMMITS" -a $DOWNSTREAM_COMMITS -gt 0 ]; then
			if [ "$UPSTREAM_COMMITS" -a $UPSTREAM_COMMITS -gt 0 ]; then
				echo -n "$NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH"
			else
				echo -n "$NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH"
			fi
		elif [ "$UPSTREAM_COMMITS" -a $UPSTREAM_COMMITS -gt 0 ]; then
			echo -n "$NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH"
		fi

		# current branch / tag / hash
		local HEAD_NAME="$(git symbolic-ref --short HEAD 2>/dev/null)"
		if [ "$HEAD_NAME" ]; then
			# branch name
			echo -n "$NORMANDY_PL_GIT_BRANCH_GLYPH "
		else
			local HEAD_NAME="$(git describe --tags --no-long 2>/dev/null)"
			if [ $? -eq 0 ]; then
				# latest tag name
				echo -n "$NORMANDY_PL_GIT_TAG_GLYPH "
			else
				# short hash
				local HEAD_NAME="$(git rev-parse --short HEAD 2>/dev/null)"
				echo -n "$NORMANDY_PL_GIT_DETATCHED_GLYPH "
			fi
		fi
		[ "$NORMANDY_PL_GIT_SHOW_HEAD" ] && echo -n "$HEAD_NAME "

		[ "$STASHED_CHANGES" -a "$NORMANDY_PL_GIT_SHOW_STASHED" ] && echo -n "$NORMANDY_PL_GIT_STASHED_CHANGES_GLYPH "
		[ "$UNSTAGED_CHANGES" -a "$NORMANDY_PL_GIT_SHOW_UNSTAGED" ] && echo -n "$NORMANDY_PL_GIT_UNSTAGED_CHANGES_GLYPH "
		[ "$STAGED_CHANGES" -a "$NORMANDY_PL_GIT_SHOW_STAGED" ] && echo -n "$NORMANDY_PL_GIT_STAGED_CHANGES_GLYPH "
		[ "$UNTRACKED_FILES" -a "$NORMANDY_PL_GIT_SHOW_UNTRACKED" ] && echo -n "$NORMANDY_PL_GIT_UNTRACKED_FILES_GLYPH "
	fi
}


__normandy_pl_post_git_seg () {
	local GIT_DIR=$1
	local WORKING_PATH=""
	[ "$GIT_DIR" ] && local WORKING_PATH=$(pwd | sed -E "s#^${GIT_DIR}/?##")
	if [ "$WORKING_PATH" ]; then
		if [ -w $(pwd) ]; then
			__normandy_pl_start_segment_l $NORMANDY_PL_WRITABLE_DIR_BG
			echo -n "%F{$NORMANDY_PL_WRITABLE_BASENAME_FG}"
		else
			__normandy_pl_start_segment_l $NORMANDY_PL_NON_WRITABLE_DIR_BG
			echo -n "%F{$NORMANDY_PL_NON_WRITABLE_BASENAME_FG}"
		fi
		__normandy_pl_shorten_path "$WORKING_PATH" $NORMANDY_PL_POST_GIT_BASENAME_SEGMENTS
		echo -n " "
	fi
}


__normandy_pl_prompt_left () {
	local EXIT_STATUS=$?
	# local START=$(date "+%S%N")
	NORMANDY_PL_BG_COLOR=""
	local GIT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)"
	__normandy_pl_shell_status_seg $EXIT_STATUS
	__normandy_pl_user_host_seg
	__normandy_pl_pre_git_path_seg $GIT_DIR
	__normandy_pl_git_seg $GIT_DIR
	__normandy_pl_post_git_seg $GIT_DIR
	__normandy_pl_end_prompt_l
	# local END=$(date "+%S%N")
	# echo -n "$(expr $END - $START)"
}

__normandy_pl_prompt_right () {
	echo -n "%F{$NORMANDY_PL_TIMESTAMP_FG}$(date $NORMANDY_PL_TIMESTAMP_FORMAT)"
}

PROMPT='$(__normandy_pl_prompt_left)'
RPROMPT='$(__normandy_pl_prompt_right)'
