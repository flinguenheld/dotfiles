#!/bin/bash


MODE=$1 

if [ "$MODE" != "save" ] && [ "$MODE" != "install" ]
then
    echo "Usage: $0 {save|install}"
    exit 2
fi

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
                echo cp -fv "$FILE" "$FOLDER"
            ;;
        esac
    fi




done
