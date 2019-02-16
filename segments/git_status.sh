#!/bin/sh

__normandy_pl_git_dir () {
	# path to the git root or nothing if not in a git tree
	git rev-parse --show-toplevel 2>/dev/null
}

__normandy_pl_git_ref () {
	# current branch or ref (master if the repo is empty) Retuns nothing (and non-zero return code) if the head is detached
	git symbolic-ref --short HEAD 2>/dev/null
}

__normandy_pl_git_short_hash () {
	# short hash of the current commit
	git rev-parse --short HEAD 2>/dev/null
}

__normandy_pl_git_has_upstream () {
	# upstream commit if one exists, else nothing
	git rev-parse @{upstream} 2>/dev/null
}

__normandy_pl_git_commits_ahead () {
	# commits ahead of upstream for head
	git rev-list --count @{upstream}..HEAD
}

__normandy_pl_git_commits_behind () {
	# commits behind upstream for head
	git rev-list --count HEAD..@{upstream}
}

__normandy_pl_git_refresh () {
	git update-index -q --ignore-submodules --refresh
}

__normandy_pl_git_uncommited_changes_in_index () {
	# changes are staged but not commited
	git diff-index --cached --quiet HEAD --ignore-submodules --
	echo $?
}

__normandy_pl_git_changes_in_working_tree () {
	# changes have been made to tracked files but are not staged
	git diff-files --quiet --ignore-submodules --
	echo $?
}

__normandy_pl_git_untracked_files () {
	# the number of untracked non-ignored files
	git ls-files --exclude-standard --others $(__normandy_pl_git_dir) | wc -l
}


__normandy_pl_git_seg () {
	# local NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH='\u2B07 ' #⬇
	# local NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH='-'
	local NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH='\uF0DD'
	# local NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH='\u2B06 ' #⬆
	# local NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH='+'
	local NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH='\uF0DE'
	# local NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH='\u2B0D ' #⬍
	# local NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH='±'
	local NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH='\uF0DC'
	local NORMANDY_PL_GIT_BRANCH_GLYPH='\uF418'
	local NORMANDY_PL_GIT_DETATCHED_GLYPH='\uF417'
	# local NORMANDY_PL_GIT_TAG_GLYPH='\u2302' # ⌂
	local NORMANDY_PL_GIT_TAG_GLYPH='\uF412'
	local NORMANDY_PL_GIT_UNSTAGED_EDITS_GLYPH='\uF448'
	local NORMANDY_PL_GIT_STAGED_EDITS_GLYPH='\uF0C7'
	local NORMANDY_PL_GIT_STASHED_EDITS_GLYPH='\uF0C6'
	local NORMANDY_PL_GIT_UNTRACKED_GLYPH='\uF128'

	# TODO: colors
	local CLEAN_FG=97
	local STAGED_FG=97
	local DIRTY_FG=90

	local CONTENT=""
	local GIT_DIR="$(__normandy_pl_git_dir)"
	if [ "$GIT_DIR" = "" ]; then : ; else
		# refresh the index
		git update-index -q --ignore-submodules --refresh
		# label ahead / behind / both relative to upstream
		if [ "$(__normandy_pl_git_has_upstream)" = "" ]; then : ; else
			if [ $(git rev-list --count @{upstream}..HEAD) -ne 0 ]; then
				if [ $(git rev-list --count HEAD..@{upstream}) -ne 0 ]; then
					local CONTENT="$NORMANDY_PL_GIT_AHEAD_AND_BEHIND_UPSTREAM_GLYPH"
				else
					local CONTENT="$NORMANDY_PL_GIT_AHEAD_OF_UPSTREAM_GLYPH"
				fi
			elif [ $(git rev-list --count HEAD..@{upstream}) -ne 0 ]; then
				local CONTENT="$NORMANDY_PL_GIT_BEHIND_UPSTREAM_GLYPH"
			fi
		fi
		# check if HEAD is a ref
		local GIT_REF="$(git symbolic-ref --short HEAD 2>/dev/null)"
		if [ "$GIT_REF" = "" ]; then
			local GIT_TAG="$(git describe --tags --no-long 2>/dev/null)"
			if [ $? -eq 0 ]; then
				# latest tag name
				local CONTENT="$CONTENT$NORMANDY_PL_GIT_TAG_GLYPH $GIT_TAG "
			else
				# short hash
				local CONTENT="$CONTENT$NORMANDY_PL_GIT_DETATCHED_GLYPH $(__normandy_pl_git_short_hash) "
			fi
		else
			# branch name
			local CONTENT="$CONTENT$NORMANDY_PL_GIT_BRANCH_GLYPH $GIT_REF "
		fi
		# stashed edits
		# if [ $(git stash list | wc -l) -ne 0 ]; then
		if [ $(git rev-parse --verify --quiet refs/stash) = "" ]; then : ; else
			local CONTENT="$CONTENT$NORMANDY_PL_GIT_STASHED_EDITS_GLYPH "
		fi
		# unstaged edits
		git diff-files --quiet --ignore-submodules --
		if [ $? -ne 0 ]; then
			local CONTENT="$CONTENT$NORMANDY_PL_GIT_UNSTAGED_EDITS_GLYPH "
		fi
		# staged edits
		git diff-index --cached --quiet HEAD --ignore-submodules --
		if [ $? -ne 0 ]; then
			local CONTENT="$CONTENT$NORMANDY_PL_GIT_STAGED_EDITS_GLYPH "
		fi
		# untracked files
		if [ $(git ls-files --exclude-standard --others $GIT_DIR | wc -l) -ne 0 ]; then
			local CONTENT="$CONTENT$NORMANDY_PL_GIT_UNTRACKED_GLYPH "
		fi
	fi
	echo -n "$CONTENT"
}

__normandy_pl_git_seg_color () {
	# TODO: colors
	echo -n ""
}
