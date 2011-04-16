# Imports jfsh.sh
. jfsh.sh || {
	echo "jfsh.sh is required!!!" >&2
	exit 1
}

# If colors are available, defines these variables.
if have tput && silence tput setaf 1
then
	col_ok=$(tput setaf 2)
	col_nok=$(tput setaf 1)
	col_res=$(tput op)
fi

# Defines this variable which makes the cursor to jump to the 30th column.
col_shift=$(tput hpa 30)

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

# Cleans the environment.
unset -f test_feature
unset -v col_ok col_nok col_res col_shift VAR
jfsh_unload
