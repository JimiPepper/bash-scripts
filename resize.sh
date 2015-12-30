 #! /bin/bash

###############
# DESCRIPTION #
###############

# Resize pictures according to its relative dimension
# Supported extension : jpg, jpeg, png, gif, bmp, tiff

## Parameters :
# $1 -> pictures path location (sub-folders are ignored)
# $2 -> new dimension (integer value expected)

#########
# TESTS #
#########

# 1. Test all supported extension resizing

########
# CODE #
########

resizimg() {
    if [[ -d "$1" && $2 =~ ^[0-9]+$ && $2 ]] ; then                                                                                         # test if $1 is a valid path and if $2 is an integer value greater or equal to 0
        last_char=$1                                                                                                                        # for conveniency
        last_char=${last_char: -1}
        [ $last_char == '/' ] && resized_folder_path="$1"resized || resized_folder_path="$1/resized"

        # CREATE RESIZED FOLDER #
        [ ! -d "$resized_folder_path" ] &&  mkdir "$resized_folder_path"                                                                    # create sub-folder to store resized pictures

        # RESIZE PICTURES #
        for picture in $(find "$1" -maxdepth 1 -type f | sed 's!.*/!!' | sort | grep -iE ".+\.(jpg|jpeg|png|gif|bmp|tiff)") ; do            # easier to manage than brace expansion and more compatible
            convert "$1/$picture" -resize "$2%" "$resized_folder_path/$picture"
        done
    fi
}
