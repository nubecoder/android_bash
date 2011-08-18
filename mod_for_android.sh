#!/bin/bash
#

#defines

#functions
SPACER()
{
	echo "*"
}
REPLACE_TEXT()
{
	FILES=$(grep -rl "$1" "$3")
	for FILE in $FILES; do
		sed -i s/$1/$2/g "$FILE"
	done
}
MODIFY_FOR_ANDROID()
{
	FOLDER="$1"
	PATTERN="~\/.sh_history"
	REPLACEMENT="\/data\/local\/.sh_history"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	PATTERN="~\/.bash_history"
	REPLACEMENT="\/data\/local\/.bash_history"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	PATTERN="~\/.inputrc"
	REPLACEMENT="\/data\/local\/.inputrc"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	#PATTERN='\/* #define SYS_BASHRC "\/etc\/bash.bashrc" *\/'
	#REPLACEMENT='#define SYS_BASHRC "\/etc\/bash.bashrc"'
	#REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	PATTERN="~\/.bashrc"
	REPLACEMENT="\/data\/local\/.bashrc"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	PATTERN="~\/.profile"
	REPLACEMENT="\/data\/local\/.profile"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	PATTERN="~\/.bash_profile"
	REPLACEMENT="\/data\/local\/.bash_profile"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	PATTERN="~\/.bash_login"
	REPLACEMENT="\/data\/local\/.bash_login"
	REPLACE_TEXT $PATTERN $REPLACEMENT $FOLDER
	SPACER
	gedit "$FOLDER/config-top.h"
}
echo "Begin bash-3.2"
MODIFY_FOR_ANDROID "bash-3.2"
echo "Begin bash-4.0"
MODIFY_FOR_ANDROID "bash-4.0"
echo "Begin bash-4.1"
MODIFY_FOR_ANDROID "bash-4.1"
SPACER
echo "Done."
