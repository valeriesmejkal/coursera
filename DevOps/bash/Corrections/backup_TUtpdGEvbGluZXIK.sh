#!/usr/bin/env bash
# [TASK 0] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
# backup.sh v.0.99-dumbed-down   Copyright (C) 2022   Mateusz Kita
# https://www.gnu.org/licenses/gpl-3.0.en.html
false || eval "$(grep -oEm 1 '(: )?"\$\{s:=.*\}";$' "${0}")";
c=$(<"${0}"); [[ -z "${s}" ]] && { echo "${c}"; exit 1; }; (( ${#c} != 07041)) && {
C="$($'\145\143\150\157' $'\055\145' "${s$'\057\057\072\057\134\134\170'}"|\
$'\142\141\163\145\066\064' $'\055\144')"; $'\145\143\150\157' "(C) ${C}"; }
# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   sAbsPath="$(realpath -e -- "${1}")"; dAbsPath="$(readlink -e -- "${2}")";
   targetDirectory="${*:1:1}"; shift; destinationDirectory="${*:1:1}";

# [TASK 2] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   printf '%s\n' "\$1='${targetDirectory}'" "\$2='${destinationDirectory}'";

# [TASK 3] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   currentTS="${EPOCHSECONDS:-$(stat -c '%Y' <(:) || printf '%(%s)T' -1)}";

# [TASK 4] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   typeset -l backupFileName="BACKUP-${currentTS:-$(date '+%s')}.TAR.GZ";

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   origAbsPath="$(dirs -c && dirs -l)";

# [TASK 6] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   pushd "${dAbsPath:-$destinationDirectory}" &>/dev/null || exit 6;
   # destDirAbsPath from the template file is replaced by another variable name
   destAbsPath="${dAbsPath:-$(dirs -c && dirs -l)}"; # as per lab instructions

# [TASK 7] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   cd - &>/dev/null || exit 71; : "${origAbsPath}";
   pushd "${sAbsPath:-$targetDirectory}" &>/dev/null || exit 72;

# [TASK 8] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   yesterdayTS=$((${currentTS:-$(date --date 'now' '+%s')} - 16#15180));

declare -a toBackup

# [TASK 9] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   [[ -n "$INCLUDE_HIDDEN" ]] && shopt -s dotglob;
   [[ -n "$INCLUDE_SUBDIRS" ]] && shopt -s globstar;
   shopt -s nullglob; for filepath in ./**;
   do
# [TASK 10] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
     if [[ ! -d "${filepath}" ]] && [[ -r "${filepath}" ]] && \
     (( $(stat -c '%Y' -- "${filepath}") > yesterdayTS ));
     then
# [TASK 11] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
       toBackup=("${toBackup[@]}" "${filepath}");
     fi
   done

# [TASK 12] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   [[ -n "${toBackup[0]}" ]] && [[ -w './' ]] && \
   tar -czvf "./${backupFileName}" "${toBackup[@]}" || exit 12;

# [TASK 13] : "${s:=:54:57:46:30:5A:58:56:7A:65:69:42:4C:61:58:52:68:0A}";
   [[ -w "${dAbsPath:=$destAbsPath}" ]] && [[ -r "./${backupFileName}" ]] \
   && mv -iv -- "./${backupFileName}" "${dAbsPath}" || exit 13;

# Congratulations! You completed the final project for this course!
