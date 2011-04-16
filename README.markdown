# Requirements

Only [jfsh.sh](http://github.com/julien-f/jfsh).


# How to use it?

Just type the following line to test your current shell:

	. shell-info.mv

Or test another shell:

	dash shell-info.sh

And here are the results for “dash”:

	$((1 + 1))                    yes
	--
	${#VAR}                       yes
	--
	${VAR:-word}                  yes
	${VAR:=word}                  yes
	${VAR:?word}                  yes
	${VAR:+word}                  yes
	--
	${VAR#pattern}                yes
	${VAR##pattern}               yes
	${VAR%pattern}                yes
	${VAR%%pattern}               yes
	--
	${!VAR}                       no
	${VAR/pattern/string}         no
	${VAR^pattern}                no
	${VAR^^pattern}               no
	${VAR,pattern}                no
	${VAR,,pattern}               no
	${VAR:1}                      no
	${VAR:1:1}                    no

# Compatibility

shll-info is POSIX compliant and has been tested with the following shells:

- bash
- dash
- ksh
- zsh
