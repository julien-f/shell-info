# Runs everything in a subshell to preserve the environment.
(
	# Imports jfsh.sh
	. psl.sh || exit 1

	# If colors are available, defines these variables.
	if col_ok=$(tput setaf 2) 2> /dev/null
	then
		col_nok=$(tput setaf 1)
		col_res=$(tput op)
	fi

	# Defines this variable which makes the cursor to jump to the 30th column.
	if ! col_shift=$(tput hpa 30) 2> /dev/null
	then
		col_shift=$(printf '\t')
	fi

	# Helper to test a feature.
	test_feature()
	{
		printf '%s' "$1$col_shift"

		if psl_has_feature "$1"
		then
			printf '%s' "${col_ok}yes"
		else
			printf '%s' "${col_nok}no"
		fi

		psl_println "$col_res"
	}

	# Defines VAR because an empty string makes the '${VAR:?word}' test failed.
	VAR='A non empty string.'

	# Tests various features.
	for feature in \
		'$((1 + 1))' \
		'' \
		'${#VAR}' \
		'' \
		'${VAR-word}' '${VAR:-word}' \
		'${VAR=word}' '${VAR:=word}' \
		'${VAR?word}' '${VAR:?word}' \
		'${VAR+word}' '${VAR:+word}' \
		'' \
		'${VAR#pattern}' '${VAR##pattern}' \
		'${VAR%pattern}' '${VAR%%pattern}' \
		'' \
		'${!VAR}' \
		'${VAR/pattern/string}' '${VAR//pattern/string}' \
		'${VAR^pattern}' '${VAR^^pattern}' \
		'${VAR,pattern}' '${VAR,,pattern}' \
		'${VAR:1}' '${VAR:1:1}' \
		'' \
		'$([[ $VAR == * ]])' '$([[ $VAR =~ . ]])'
	do
		# If $feature is empty, it means we have to display a separator.
		if ! [ "$feature" ]
		then
			psl_println '--'
		else
			test_feature "$feature"
		fi
	done
)
