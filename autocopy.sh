#!/bin/bash

# Created to save or install easily my dotfiles
# Each files to save have to be place in files/. They need a comment with their folder (e.g. # Folder : /home/)
# Folders will be searched in ~/.config/. Complete the array IGNORE if needed


MODE=$1 

if [ "$MODE" != "save" ] && [ "$MODE" != "install" ]
then
    echo "Usage: $0 { save | install }"
    exit 2
fi

echo
echo "------------------------- Files -------------------------"
for FILE in ./files/{,.}*
do
    if [ -f "$FILE" ]; then

        FOLDER=$(grep "Folder : " "$FILE" | sed "s/. Folder : //" | sed "s|/home|${HOME}|")

        case "$MODE" in
            save)
                cp -fv "$FOLDER$(basename "$FILE")" ./files/
            ;;
            install)
                cp -fv "$FILE" "$FOLDER"
            ;;
        esac
    fi
done

echo
echo "------------------------ Folders ------------------------"
IGNORE=("./files" "./fonts" "./save")

for FOLDER in ./*
do

    if [ -d "$FOLDER" ] && ! [[ ${IGNORE[*]} =~ $FOLDER ]]
    then

        case "$MODE" in
            save)
                (rm -r "$FOLDER" && cp -r "${HOME}/.config/${FOLDER:2:${#FOLDER}}" ./ && echo "$FOLDER OK") || echo "$FOLDER FAIL"
            ;;
            install)
                (rm -r "${HOME}/.config/${FOLDER:2:${#FOLDER}}" && cp -r "$FOLDER" "${HOME}/.config/" && echo "$FOLDER OK") || echo "$FOLDER FAIL"
            ;;
        esac
    fi
done
