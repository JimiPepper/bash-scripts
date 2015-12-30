#!/bin/bash 

###############
# DESCRIPTION #
###############

# List all folders from a path given as a parameter. Theses folders are supposed to store programming projects.
# So the script outputs for each folder its name, whole size, date of last modification, programming languages used. 
# If a folder is versionned with Git tool, the script also outputs the last commit information and the current branch
# used to store any new revision.

#########
# TESTS #
#########

# 1. List a folder with one project
# 2. List a folder with two projects
# 3. List a folder with projects having space characters in their name
# 4. List a folder with projects versionned or not

########
# CODE #
########

### SUB-FUNCTIONS

# Output one of the shell box character
# $1 -> an integer between 0 and 10
_box_drawing() {
	char=( 6a 6b 6c 6d 6e 71 74 75 76 77 78 )
	#      ┘  ┐  ┌  └  ┼  ─  ├  ┤  ┴  ┬  │  

	[ $1 -ge 0 ] && [ $1 -lt 11 ] && printf "\e(0\x${char[$1]}\e(B"
}

# Output a special character
# $1 -> an integer between 0 and 3
_special_character() {
	char=( "\xE2\x9C\x93" "\xE2\x9C\x97" "\xE0\xBF\x94" "\xe2\x97\x89" )
	#           ✓             ✗                 ࿔              ◉

	[ $1 -ge 0 ] && [ $1 -lt 4 ] && echo -ne ${char[$1]}
}

# Tell if a folder, provided as parameter, contains a git repository
# $1 -> An absolute path
_is_git_initialized() {
	if [ -d "$1/.git" ] ; then
		return 0
	else
		return 1
	fi
}

# Give the selected branch name or "unitialized" if there are no commit for the selected branch
# $1 -> An absolute path
_get_git_branch_name() {
	branch_name=$(git --git-dir "$1/.git" branch)
	branch_name=${branch_name[@]:3} # delete the star and space characters at the beginning

	if [ -n "$branch_name" ] ; then
		echo -n  "$branch_name"
	else
		echo -n  "unitialized" # no commit push in the current branch
	fi
}

#knuth_plass_justify_alogorithm() {
#	echo "TEST"
#}

# Split a line into several lines which are displayed in order to be store as an array
# $1 -> text to split
# $2 -> split's size
_split() {
        start=0
		interval=$2
		text_size=${#1}

		#echo "Taille du texte : $text_size"

		while [ $start -lt $text_size ] ; do
				echo ${1:start:interval}
				start=`expr $start + $2`
		done
}

##############
#  MAIN CODE #
##############
lp() {
		### GET INFORMATIONS ABOUT PROGRAMMING PROJECTS
		# 1. Get list of directory with for each one its disk usage and clean it
		# 2. Sort by YYYY:MM:DD
		# 3. Sort by HH:MM
		# 4. Reverse display
		# 5. Remove first line (infos about ~/Git itself which we don't care)
		IFS=$'\n' # change IFS to get an array -- easiest to manipulate
		projects_info=($(du -d 1 -h --time ~/Git | tr '\t' ' ' | sort -s -t ' ' -k 2.1,2.4n -k 2.6,2.7n -k 2.9,2.10n | sort -s -t ' ' -k 5.1,5.2n -k 5.4,5.5n | tac | tail -n +2))
		unset IFS

		counter=0

		### DISPLAYING PART
		tput setaf 3
		_special_character 3 ; echo -n " "
		tput smul
		echo "Programming projects in ~/Git"
		tput sgr0
		_box_drawing 9 ; echo
		for project in "${projects_info[@]}" ; do
			let counter=counter+1 # to know when code reaches the last project to outuput on terminal
			project_array=($(echo "$project"))
			# Details about project_array's variable
			# Index 0 -> Project's size
			# Index 1 -> Date, format YYYY-MM-DD
			# Index 2 -> Time, format HH:MM (min : 00:00, max : 23:59)
			# Index 3 -> Project's absolute path  
			project_array[3]=${project_array[@]:3} # -- allow to print folder names composed of spaces
				
			_box_drawing 6 ; _box_drawing 5 ; tput bold ; echo -n " $(basename "${project_array[3]}") "
			if _is_git_initialized "${project_array[3]}" ; then
				tput setaf 2
				_special_character 0
				tput sgr0
				echo -n " - "
				tput setaf 6
				_get_git_branch_name "${project_array[3]}"
			else
				tput setaf 1 
				_special_character 1
			fi
			tput sgr0
			echo -ne  "\t\t${project_array[0]} - " ; echo -n  ${project_array[1]} | sed -r 's/([[:digit:]]{4}):([[:digit:]]{2}):([[:digit:]]{2})/\3:\2:\1/' ; echo ", ${project_array[2]}"
			
			if _is_git_initialized "${project_array[3]}" ; then
				if [ $(_get_git_branch_name "${project_array[3]}") != "unitialized" ] ;  then
						commit_info[0]=$(git --git-dir "${project_array[3]}/.git" log -n 1 --format=%ci | \
						sed -r 's/^([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}) ([[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}) \+[[:digit:]]+$/\4 the \3-\2-\1/' ) 		# commit date
						commit_info[1]=$(git --git-dir "${project_array[3]}/.git" log -n 1 --format=%an)	 																	# author name
						commit_info[2]=$(git --git-dir "${project_array[3]}/.git" log -n 1 --format=%ae) 																		# author email address
						commit_info[3]=$(git --git-dir "${project_array[3]}/.git" log -n 1 --format=%s) 																		# commit message

						_box_drawing 10 ; echo -n "  "
						tput bold ; tput setaf 3
						_special_character 2
						tput sgr0
						echo " Last commit at ${commit_info[0]} by ${commit_info[1]} (${commit_info[2]})"
						
						size=90 # commit message can have lines of 90 characters maximum
						IFS=$'\n'
						lines=(`_split "${commit_info[3]}" $size`)
						unset IFS

						TO=`expr ${#lines[@]} - 1`

						for index in `seq 0 $TO` ; do
							_box_drawing 10 ; echo "  ${lines[$index]}" ;
						done

				fi
			fi
		
			[ $counter -lt ${#projects_info[@]} ] && _box_drawing 10  && echo 
		done
		_box_drawing 8 ; echo ""
}
