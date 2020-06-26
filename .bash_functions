# Functions

# mknote - Creates a file in a common directory then opens it in vim
mknote () {
  notedir="$HOME/Nextcloud/Notes"
  vim "${notedir}/$1"
}

# mkrole - Makes directories and the main.yml for a given role
mkrole () {
  dirs=(defaults tasks templates files)
  for dir in "${dirs[@]}"; do 
    mkdir -p "$1"/"$dir";
  done

  for file in "${dirs[@]:0:2}"; do
    #echo "$file";
    touch "$1"/"$file"/main.yml;
  done
}

# divider - Create divider the full width of terminal screen
# Call it by "divider =" for a row of =
divider() {
 if [[ -z ${1} ]];
 then
  echo "Requires a character to print as an argument"
  return
 fi
 for x in $(seq 1 $(tput cols)); do printf "${1}"; done
    echo
}

# Change name from "01 Song.flac" to "01 - Song.flac"
addash() {
 rename -v 's/^(\d{2})/$1 -/' -- *.{flac,mp3}
}

# Change filename from "01. Song.flac" to "01 - Song.flac"
dotodash() {
 rename -v 's/. / - /' -- *.{flac,mp3}
}

findflac() {
  find . -iname *.flac
}

findmp3() {
  find . -iname *.mp3
}

gitcheck() {
    find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git fetch --all; git status -uno && echo)' \;
}
