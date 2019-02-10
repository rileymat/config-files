lm()
{
	if [ -z "$1" ] 
	then
		PARAM=.
	else
		PARAM=$1
	fi

	if [ -d "${PARAM}" ]
	then
		ls -la ${PARAM};
	else
		if [ -f "${PARAM}" ] 
	then
			more ${PARAM};
		else
			echo "${PARAM} is not valid";
		fi
	fi
}

# gitrac and gitac used together to have [GIT] [A]utomate [C]ommit and [R]emove [A]uto [C]ommits
gitrac()
{
	git reset --soft  $(git log --format=%H%x09%s | grep -v AutoCommit | head -n1 | cut -f1)
}
gitac()
{
	git add -A; git commit -m'AutoCommit'
}
