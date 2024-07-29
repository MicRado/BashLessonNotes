@@ -1,19 +1,39 @@
# Snippets for Bash/sh/BATS
snippet t "BATS test case"
@test '${1:decription}' {
  ${2}
}
endsnippet
snippet fin "Cleanup on exit"
function finish {
  ${1}
}
trap finish EXIT
endsnippet

snippet usage "Usage function"
# Print usage message on stdout by parsing start of script comments
usage() {
  grep '^#/' "${script_dir}/${script_name}" | sed 's/^#\/\w*//'
}

endsnippet

snippet check_args "Function that checks command line arguments"
# Check if command line arguments are valid
check_args() {
  if [ "${#}" -ne "1" ]; then
    error "Expected 1 argument, got ${#}"
    usage
    exit 2
  fi
}

endsnippet

snippet usage2 "Usage function"
# Print usage message on stdout
usage() {
cat << _EOF_
@@ -29,13 +49,18 @@ _EOF_

endsnippet

snippet log "Function that prints a log message"
snippet logv "Variables for logging functions"
# Color definitions
readonly reset='\e[0m'
readonly cyan='\e[0;36m'
readonly red='\e[0;31m'
readonly yellow='\e[0;33m'
# Debug info ('on' to enable)
readonly debug='on'

endsnippet

snippet logf "Functions for log messages"
# Usage: info [ARG]...
#
# Prints all arguments on the standard output stream
@@ -45,9 +70,10 @@ info() {

# Usage: debug [ARG]...
#
# Prints all arguments on the standard output stream
# Prints all arguments on the standard output stream,
# if debug output is enabled
debug() {
  printf "${cyan}### %s${reset}\n" "${*}"
  [ "${debug}" != 'on' ] || printf "${cyan}### %s${reset}\n" "${*}"
}

# Usage: error [ARG]...
@@ -56,6 +82,7 @@ debug() {
error() {
  printf "${red}!!! %s${reset}\n" "${*}" 1>&2
}

endsnippet

snippet die "Exit the script with an error message and exit status"
  26 changes: 14 additions & 12 deletions26  
.vim/templates/sh
Original file line number	Diff line number	Diff line change
@@ -2,7 +2,16 @@
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# PURPOSE
#/ Usage: SCRIPTNAME [OPTIONS]... [ARGUMENTS]...
#/
#/ 
#/ OPTIONS
#/   -h, --help
#/                Print this help message
#/
#/ EXAMPLES
#/  


#{{{ Bash settings
# abort on nonzero exitstatus
@@ -20,23 +29,16 @@ IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)
#}}}

main() {
  check_args "${@}"

  # check_args "${@}"
  :
}

#{{{ Helper functions

# Check if command line arguments are valid
check_args() {
  if [ "${#}" -ne "1" ]; then
    echo "Expected 1 argument, got ${#}" >&2
    usage
    exit 2
  fi
}


#}}}

main "${@}"

# cursor: 25 del
# cursor: 33 del
