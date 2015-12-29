###############
# DESCRIPTION #
###############

# Move you in your programming project's folder or if a parameter is provided move you in the
# the sub-solder if it exists

# $1 : the folder's name

#########
# TESTS #
#########

# 1. Without parameter provided
# 2. With a parameter provided - the folder exists
# 3 With a parameter provided - the folder doesn't exist

## NOTE -> To put in your $HOME/.profile

########
# CODE #
########

#! /bin/env bash

goproj() {
	[ -d "$HOME/Git/$1" ] && cd "$HOME/Git/$1" || cd "$HOME/Git"
}
