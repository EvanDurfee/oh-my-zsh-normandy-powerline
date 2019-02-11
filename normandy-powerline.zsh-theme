NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH='\uE0B0'
NORMANDY_PL_RIGHT_SEPERATOR_GLYPH='\uE0B1'
NORMANDY_PL_LEFT_SEPERATOR_FILLED_GLYPH='\uE0B2'
NORMANDY_PL_LEFT_SEPERATOR_GLYPH='\uE0B3'

NORMANDY_PL_GIT_GLYPH='\uE0A0'

# Nerd Fonts
NORMANDY_PL_GIT_BRANCH_GLYPH='\uF418'
NORMANDY_PL_GIT_DETATCHED_GLYPH='\uF417'

__set_fg () {
	echo -n "\e[38;5;$1m"
}

__unset_fg () {
	echo -n "\e[39m"
}

__set_bg () {
	echo -n "\e[48;5;$1m"
}

__unset_bg () {
	echo -n "\e[49m"
}

__set_bold () {
	echo -n "\e[1m"
}

__unset_bold () {
	echo -n "\e[21"
}

__normandy_pl_unset_styling () {
	echo -n "\e[39;21;24;25;27;28m"
}

__normandy_pl_exit_status () {
	if [ $? -ne 0 ]; then
		__set_fg 1 # red
		__set_bold
		echo -n "! "
		__unset_bold
	fi
}

__normandy_pl_job_status () {
	if [ "$(jobs)" != "" ]; then
		__set_fg 6 # cyan
		echo -n "% "
	fi
}

__normandy_pl_status_segment () {
	if [ "$(jobs)" != "" ]; then
		__set_fg 6 # cyan
		echo -n "% "
	fi
}

PREV_SEGMENT_L_COLOR=""
__add_segment_seperator_l () {
	PREV_SEGMENT_L_COLOR=""
	NEW_SEGMENT_L_COLOR="$1"
	if [ "$PREV_SEGMENT_L_COLOR" = "" ]; then
		__set_bg $NEW_SEGMENT_L_COLOR
		echo -n " "
	elif [ "$PREV_SEGMENT_L_COLOR" = "$NEW_SEGMENT_L_COLOR" ]; then
		echo "TODO"
	else
		__set_bg $NEW_SEGMENT_L_COLOR
		__set_fg $PREV_SEGMENT_L_COLOR
		echo -n "$NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH "
	fi
	PREV_SEGMENT_L_COLOR=$NEW_SEGMENT_L_COLOR
}

__normandy_pl_add_segment_l () {
	CONTENT=$1
	BG_COLOR=$2
	if [ "$CONTENT" != "" ]; then
		__add_segment_seperator_l $BG_COLOR
		echo -n $CONTENT
	fi
}







normandy_pl_prompt () {
	__normandy_pl_add_segment_l $(__normandy_pl_status_segment_content) 15 # white

	__unset_bg
	__set_fg 15
	echo -n "$NORMANDY_PL_RIGHT_SEPERATOR_FILLED_GLYPH "
	__unset_fg
}
