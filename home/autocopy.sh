#!/usr/bin/env bash
# Florent Linguenheld 2022

usage() {
	echo "Usage: $(basename "${0}") [-i] | [-h]"
	echo "   Copy here, my dotfiles which are spreaded in the system's folders."
	echo '      -i INSTALL   reverse the command, copy files/folder from here to their destination.'
	echo '      -h HELP      display this message.'
}

MODE='save'
while getopts iqh OPTION; do
	case ${OPTION} in
	i)
		MODE='install'
		;;
	h)
		echo "Easily save my dotfiles."
		echo
		echo '   Files have to be placed in files/'
		echo '   They need a comment with their folder (e.g. # Folder : /home/) inside.'
		echo
		echo '   All folders here will be searched in ~/.config/ and copied/pasted'
		echo "   To ignore some of them, you can complete the array 'IGNORE'."
		echo

		usage
		exit 0
		;;
	?)
		echo

		usage 2>&1
		exit 1
		;;
	esac
done

echo '------------------------- Files -------------------------'

for FILE in ./files/{,.}*; do
	if [ -f "$FILE" ]; then

		FOLDER=$(grep "Folder : " "$FILE" | sed "s/. Folder : //" | sed "s|/home|${HOME}|")

		case "${MODE}" in
		save)
			cp -fv "${FOLDER}$(basename "$FILE")" ./files/
			;;
		install)
			cp -fv "${FILE}" "${FOLDER}"
			;;
		esac
	fi
done

echo '------------------------ Folders ------------------------'
IGNORE=("./files" "./sandbox")

for FOLDER in ./*; do

	if [ -d "${FOLDER}" ] && ! [[ ${IGNORE[*]} =~ ${FOLDER} ]]; then

		case "${MODE}" in
		save)
			(rm -r "${FOLDER}" && cp -r "${HOME}/.config/${FOLDER:2:${#FOLDER}}" ./ && echo "${FOLDER} OK") || echo "${FOLDER} FAIL"
			;;
		install)
			rm -rf "${HOME}/.config/${FOLDER:2:${#FOLDER}}"
			(cp -r "${FOLDER}" "${HOME}/.config/" && echo "${FOLDER} OK") || echo "${FOLDER} FAIL"
			;;
		esac
	fi
done
echo '---------------------------------------------------------'
