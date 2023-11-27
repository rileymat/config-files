export HISTSIZE=200000
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export HISTCONTROL=ignoreboth:erasedups

PATH=$PATH:~/Scripts
export BASH_SILENCE_DEPRECATION_WARNING=1

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	if [ -f ~/.bashrc_linux ]; then
   		source ~/.bashrc_linux
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -f ~/.bashrc_mac ]; then
		source ~/.bashrc_mac
	fi
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

