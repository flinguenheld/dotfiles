#!/usr/bin/env bash
# florent@linguenheld.fr 2022-2026

DOTFILES_FOLDER="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
FILES_FOLDER="$DOTFILES_FOLDER/files"
CONFIG_FOLDER="$HOME/.config"

# Folders of the dotfiles that are not in ~/.config
IGNORE=("files" "sandbox" ".git")

RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
RESET=$'\e[0m'

# ──────────                                      ─────────────────────────────
# ─────                                     ─────────────────────── USAGE ─────
usage() {
  echo "Usage: $(basename "${0}") [--install]"
  echo "   Save my dotfiles, spread in the system's folders, into"
  echo "   ${DOTFILES_FOLDER}"
  echo "   or install them back with --install."
  echo
  echo "What is copied:"
  echo "   files/     each file requires a comment with its folder"
  echo "              e.g. # Folder : /home/bin/   (/home → \$HOME)"
  echo "   <folder>/  mirrors ${CONFIG_FOLDER}/<folder>"
  echo "              except: ${IGNORE[*]}"
  echo
  echo "Save (default):"
  echo "   OK         copied from the system"
  echo "   REMOVED    gone from the system: deleted here too"
  echo "   FAIL       the copy failed, or the file has no Folder comment"
  echo
  echo "Install:"
  echo "   All folders and files are overwritten."
  echo "   Missing destination folders are created."
  echo
  echo "Options:"
  echo "   --install    reverse: copy from here to the system"
  echo "   --help, -h   print this help"
}

# ──────────                                      ─────────────────────────────
# ─────                                     ────────────────────── COLORS ─────
# echo_color <color> <name> <status>: the name padded, the status in color
#   an empty color ("") prints the status in the regular color
echo_color() {
  printf "   - %-25s %s\n" "$2" "$1$3${RESET}"
}

# ──────────                                      ─────────────────────────────
# ─────                                     ─────────────────── ARGUMENTS ─────
MODE="save"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install)
      MODE="install"
    ;;
    --help | -h)
      usage
      exit 0
    ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
    ;;
  esac
  shift
done

# ──────────                                      ─────────────────────────────
# ─────                                     ─────────────────────── FILES ─────
# Extract the folder destination written in the file and convert it to a path.
#   "# Folder : /home/bin/"  →  "/home/flo/bin/"
folder_of() {
  grep --max-count=1 "Folder : " "$1" \
    | sed --expression "s/.*Folder : //" \
          --expression "s|^/home|${HOME}|"
}

echo "----------------------------------------------"
echo "----------------------------------- FILES ----"
# {,.}* expands to * and .* : the hidden files too
for file in "${FILES_FOLDER}"/{,.}*; do
  if [[ -f "${file}" ]]; then
    file_name=$(basename "${file}")
    destination=$(folder_of "${file}")

    if [[ -z "${destination}" ]]; then
      echo_color "${RED}" "${file_name}" "FAIL (no \"Folder : \" comment)"
    else
      case "${MODE}" in
        save)
          from="${destination}${file_name}"
          to="${file}"
        ;;
        install)
          from="${file}"
          to="${destination}${file_name}"
        ;;
      esac

      if [[ -f "${from}" ]]; then
        # --parents: no error if it exists, creates the missing parents too
        mkdir --parents "$(dirname "${to}")" \
          && cp -f "${from}" "${to}" \
          && echo_color "${GREEN}" "${file_name}" "OK" \
          || echo_color "${RED}" "${file_name}" "FAIL"
      else
        # Gone from the system: remove it here too
        rm -f "${to}" && echo_color "${YELLOW}" "${file_name}" "REMOVED"
      fi
    fi
  fi
done

# ──────────                                      ─────────────────────────────
# ─────                                     ───────────────────── FOLDERS ─────
# is_not_ignored <name>: true if the name is not in IGNORE (exact match)
is_not_ignored() {
  ! printf '%s\n' "${IGNORE[@]}" \
    | grep --quiet --line-regexp --fixed-strings -- "$1"
}

echo "----------------------------------------------"
echo "--------------------------------- FOLDERS ----"
# */ : the trailing slash keeps only folders
for folder in "${DOTFILES_FOLDER}"/*/; do
  folder_name=$(basename "${folder}")    # ".../dotfiles/niri/" → "niri"

  if is_not_ignored "${folder_name}"; then
    case "${MODE}" in
      save)
        from="${CONFIG_FOLDER}/${folder_name}"
        to="${DOTFILES_FOLDER}/${folder_name}"
      ;;
      install)
        from="${DOTFILES_FOLDER}/${folder_name}"
        to="${CONFIG_FOLDER}/${folder_name}"
      ;;
    esac

    if [[ -d "${from}" ]]; then
      rm -rf "${to}" && cp -r "${from}" "${to}" \
        && echo_color "${GREEN}" "${folder_name}" "OK" \
        || echo_color "${RED}" "${folder_name}" "FAIL"
    else
      # Gone from the system: remove it here too
      rm -rf "${to}" && echo_color "${YELLOW}" "${folder_name}" "REMOVED"
    fi
  fi
done

echo "----------------------------------------------"
