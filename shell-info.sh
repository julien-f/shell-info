# Runs everything in a subshell to preserve the environment.
(
	# Imports jfsh.sh
	. jfsh.sh || exit 1

	# If colors are available, defines these variables.
	if silence2 'col_ok=$(tput setaf 2)'
	then
		col_nok=$(tput setaf 1)
		col_res=$(tput op)
	fi

	# Defines this variable which makes the cursor to jump to the 30th column.
	if ! silence2 'col_shift=$(tput hpa 30)'
	then
		col_shift=$(printf '\t')
	fi

	# Helper to test a feature.
	test_feature()
	{
		printf '%s' "$1$col_shift"

		if have_feature "$1"
		then
			printf '%s' "${col_ok}yes"
		else
			printf '%s' "${col_nok}no"
		fi

		write_lines "$col_res"
	}

	# Defines VAR because an empty string makes the '${VAR:?word}' test failed.
	VAR='A non empty string.'

	# Tests various features.
	for feature in \
		'$((1 + 1))' \
		'' \
		'${#VAR}' \
		'' \
		'${VAR:-word}' \
		'${VAR:=word}' \
		'${VAR:?word}' \
		'${VAR:+word}' \
		'' \
		'${VAR#pattern}' '${VAR##pattern}' \
		'${VAR%pattern}' '${VAR%%pattern}' \
		'' \
		'${!VAR}' \
		'${VAR/pattern/string}' \
		'${VAR^pattern}' '${VAR^^pattern}' \
		'${VAR,pattern}' '${VAR,,pattern}' \
		'${VAR:1}' '${VAR:1:1}'
	do
		# If $feature is empty, it means we have to display a separator.
		if ! [ "$feature" ]
		then
			write_lines '--'
		else
			test_feature "$feature"
		fi
	done
)
