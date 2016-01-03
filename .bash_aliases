## SHORTCUTS FOR COMMON COMMANDS
alias c="cd .."
alias rm='rm -i'
alias mv="mv -i"

## INFORMATION ABOUT ENVIRONMENT
alias bash-reload="source ~/.bashrc"
path="echo -e ${PATH//:/\\n}"

## HANDLE OS LIFECYCLE
alias pend='sudo pm-suspend'
alias nate='sudo pm-hibernate'
alias brid='sudo pm-hybrid'
alias down='sudo poweroff'
alias boot='sudo reboot'

## APITUTDE SHORTCUTS
alias apu='sudo aptitude update'
alias appg='sudo aptitude upgrade'
alias apd='sudo aptitude dist-upgrade'
alias api='sudo aptitude install'
alias apr='sudo aptitude remove'
alias app='sudo aptitude purge'
alias apar='sudo aptitude autoremove'
alias apcc='sudo aptitude clean && sudo aptitude autoclean'
alias apsearch='apt-cache search'
alias aps='apt-cache search'
alias apshow='apt-cache showpkg'

## JAVA
alias jar='java -jar'

## RUBY
alias rb='ruby'
alias rbv="ruby -v"

## RUBYGEMNS
alias gbuild='gem build'
alias ginstall='gem install'
alias guninstall='gem uninstall'

## GIT
alias gclone='git clone'
alias gcheckout='git checkout'
alias gpull='git pull'
alias gadd='git add --all'
alias grm='git rm'
alias gremote='git remote add origin'
alias gpush='git push'
alias gstatus='git status'
alias gcommit='git commit -m'
alias gbranch="git branch"
#alias gforget='git update-index --assume-unchanged'
#alias gtrack='git update-index --no-assume-unchanged'
#alias gclean='git clean -idx'
