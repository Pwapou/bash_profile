# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export CLICOLOR=1
export EDITOR=vim
export LSCOLORS=ExFxBxDxCxegedabagacad
export PATH="$PATH:$HOME/.tgenv/bin"
export AWS_DEFAULT_REGION="eu-west-1"
export AWS_REGION="eu-west-1"
export AWS_PROFILE=""

# .bashrc (or .bash_profile)

# declares an array with the emojis we want to support
EMOJIS=(🙄 🤔 😍 😘 🦆 😡 🐻 🐶 🦊 )

# function that selects and return a random element from the EMOJIS set
RANDOM_EMOJI() {
  SELECTED_EMOJI=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]};
  echo $SELECTED_EMOJI;
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function aws_profile() {
  [ -n "$AWS_PROFILE" ] && {
    if [[ "$AWS_PROFILE" =~ pmd-prd|pme-prod ]]; then
      echo -n "[${AWS_PROFILE^^}]"
    else
      echo "[${AWS_PROFILE}]"
    fi
  }
  return 0
}
function name_user(){
	echo $USER
}

alias og='ls -ogrt'
alias ll='ls -al'
alias lc='ls -C'
alias dir='ls -lrt' # in case you are a MS-DOS lover
alias h='history'
alias p='pwd -P'  # shows the "real" path in bash, not the path via symlinks

export PS1="$(RANDOM_EMOJI)   \[\033[33m\]mac\[\033[m\]@\[\033[33m\]$(name_user):\[\033[33;31m\]\w\[\033[91m\]\$(aws_profile)\[\033[49m\]\[\033[95m\]\$(parse_git_branch)\[\033[m\]\$ "
export HISTFILESIZE=10000
export HISTSIZE=10000
