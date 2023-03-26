#!/bin/bash

usage ()
{
    echo
    echo "   Usage: $(basename ${0}) [-l LENGTH] [-h]"
    echo '   Generate a random password'
    echo '       -l   LENGTH    Specify the password length.'
    echo '       -h   HELP      Display this message'
}

random_char ()
{
    # Print a string of randomised char
    # $1: String of chars
    # $2: Length of wanted result (one by default)

    [[ -v 2 ]] && NUM=${2} || NUM=1

    for ((i = 0; i < ${NUM}; i++)); do
        echo -n "$(echo ${1} | fold -w1 | shuf | head -c1)"
    done

    return 0
}

# --
SPECIAL_CHAR='|&~!#@?$^_*/()+-='
LETTER='abcdefghijklmnopqrstuvwxyz'
CAPITAL_LETTER='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
NUMBER='0123456789'

LENGTH=20
while getopts hl: OPTION
do

    case ${OPTION} in
        l)
            LENGTH=${OPTARG}
        ;;
        h)
            usage
            exit 0
        ;;
        ?) 
            usage >&2
            exit 1
        ;;
    esac
done

PASSWORD=$(random_char ${SPECIAL_CHAR} ${LENGTH})
PASSWORD=${PASSWORD}$(random_char ${LETTER} ${LENGTH})
PASSWORD=${PASSWORD}$(random_char ${CAPITAL_LETTER} ${LENGTH})
PASSWORD=${PASSWORD}$(random_char ${NUMBER} ${LENGTH})

PASSWORD="$(echo ${PASSWORD} | fold -w1 | shuf | tr -d '\n' | head -c${LENGTH} )"

echo "${PASSWORD}"
