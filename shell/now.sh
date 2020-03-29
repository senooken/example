:
################################################################################
## \file      now.sh
## \author    SENOO, Ken
## \copyright CC0
## \version   0.2.0
## \date      Created: 2016-12-27T23:46+09:00
## \date      Updated: 2020-03-29T12:35+09:00
## \sa        https://senooken.jp/post/2016/12/27/
## \brief     Print current date time in POSIX shell script.
################################################################################

EXE_NAME='now'

now() {
	dt=$(date +%Y%m%dT%H%M%S)
	OPTSTR=':hlst-:'
	for opt in $(echo $OPTSTR | sed 's/[:-]//g' | fold -w 1); do
		eval opt_$opt='false'
	done

	while getopts $OPTSTR opt; do
		case "$opt${OPTARG:-}" in
			l|-long)  opt_l='true' dt=$(date +%Y-%m-%dT%H:%M:%S);;
			s|-short) dt=$(date +%Y%m%dT%H%M%S);;
			t|-time-zone) opt_t='true';;
			h|-help)
				cat <<-EOT
Usage: $EXE_NAME [OPTION]...
Print current date time with ISO 8601 format (YYYYmmddThhmmss).
  -l, --long      print date by ISO 8601 extended format (YYYY-mm-ddThh:mm:ss).
  -s, --short     print date by ISO 8601 format (YYYYmmddThhmmss) [default].
  -t, --time-zone append time zone (-t=[+-]hh:mm, -s=[+-]hhmm).
  -h, --help      display this help and exit.
				EOT
				exit
			;;
			\?*) echo "$EXE_NAME: invalid option -- '$OPTARG'" >&2;        exit 1;;
			*)   echo "$EXE_NAME: unrecognized option '-$opt$OPTARG'" >&2; exit 1;;
		esac
	done

	if $opt_t; then
		EXE_DIR=$(dirname "$0")
		[ -r "$EXE_DIR/tz.sh" ] && . "$EXE_DIR/tz.sh"
		command -v tz.sh >/dev/null && . tz.sh
		if ! command -v tz >/dev/null; then
			echo "tz command was not found. Time zone option (-t) is not enabled!" >&2
			exit 1
		fi
		TIME_ZONE=$(tz)
		! $opt_l && TIME_ZONE=$(echo "$TIME_ZONE" | sed 's/://')
		dt="$dt$TIME_ZONE"
	fi

	echo "$dt"
}

main() {
	## \brief Initialize POSIX shell environment
	init() {
		PATH="$(command -p getconf PATH 2>&-):${PATH:-.}"
		export PATH="${PATH#:}" LC_ALL='C'
		umask 0022
		set -eu
	}

	is_main() { [ "$EXE_NAME.sh" = "${0##*/}" ]; }
	if is_main; then
		init
		$EXE_NAME ${1+"$@"}
	fi
}

main ${1+"$@"}
