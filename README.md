BASH SCRIPTS
============

Description
-----------

This repository contains all bash scripts I use everyday made by myself.

+ **list_projects.sh** : Scan a specific folder with all your programming projects and tell you for each one its name, size, date of last modification and if it is versionned with Git (if it is, output information about the last commit) in a `tree` command manner.

+ **gog.sh** : Move you into a specific folder where all your programming projects are located. If you provide a parameter such it respects a sub-directory name, move you in this sub-directory.

+ **resize.sh** : Resize all pictures (jpg, jpeg, gif, png, bmp, tiff) from a folder given as first parameter (the script does not consider sub-folder). The script takes also a second parameter which is the ratio (or percentage) you want to apply. Resized pictures are located in a sub-folder called *resized* and they have the same filename as the original picture.

+ **.bash_aliases** :  All alias I used.

Requirements
------------

Be sure to have :

+ Bash v.4.3.11
+ Git v.2.6.4 or higher
+ `tput` installed

Contribution
------------

Feel free to make a pull-request: any help is welcome ;)

Next Update
-----------
Apart from knowing which script(s) I will version later, these are all updates that I'm sure to do :

+ **For all scripts**
  + Provide a better Bash code

+ **README.md**
  + Improve the quality of this file

+ **list_projects.sh**
  + Justify the git commit message better
  + As Github, output which programming languages used in a project
  + Align folder's information from the same column for all each one
  + Provide an environment variable instead of using a hardcoded path stored in the script

+ **gog.sh**
  + Provide an environment variable instead of using a hardcoded path stored in the script

+ **resize.sh**
  + Parallelize the script in order two perform several resizing in the same time (as an option to use when you call the script)
  + Add a verbose option to see how long the process have to work before the script finishes. 

+ **.bash_aliases**
  + Add new alias

+ **New file ?**
  + Create a setup script (maybe *setup.sh* :p) installing all dependencies and setting up my working environment I need on a new operating system
  + Add several alias (or a script with options) to get info about my vim configuration

NOTES
-----

I add comments in my code only if it is necessary. Also, I only use bash, not dash & co., so be aware if scripts stop unexpectedly, it maybe the cause: I don't design them to be portable. Moreover, I list at the beginning of each script all tests they went through before pushed them in Git history.

Finally, (and currently) I don't think to append unit tests in order to check if they work for all possible context/cases.
