:
################################################################################
## \file      get_tz.sh
## \author    SENOO, Ken
## \copyright CC0
## \sa        https://senooken.jp/post/2016/12/27/
## \version   0.0.1
## \date      Created: 2016-12-27T23:46+09:00
## \date      Updated: 2020-03-29T09:13+09:00
## \brief     Get time zone in POSIX shell script.
################################################################################

get_tz()(
	set $(date -u '+%j %H %M'); U_D=${1#0}; U_D=${U_D#0}; U_H=${2#0}; U_M=${3#0}
	set $(date    '+%j %H %M'); L_D=${1#0}; L_D=${L_D#0}; L_H=${2#0}; L_M=${3#0}

	# Fix if year is crossed
	IS_CROSSED_YEAR="[ $L_D = 1 -o $U_D = 1 ] && [ $((L_D+U_D)) -gt 3 ]"
	eval "$IS_CROSSED_YEAR" && U_D=$((L_D == 1 ? L_D-1 : L_D+1))

	dm=$(( (L_D*24*60 + L_H*60 + L_M) - (U_D*24*60 + U_H*60 + U_M) ))
	DIGIT_1=$((dm<0 ? -dm%10 : dm%10))

	# Fix if minute is changed during running date command
	[ $DIGIT_1 = 1 -o $DIGIT_1 = 6 ] && dm=$((dm<0 ? dm+1 : dm-1))
	[ $DIGIT_1 = 4 -o $DIGIT_1 = 9 ] && dm=$((dm<0 ? dm-1 : dm+1))

	printf '%+03d:%+03d\n' $((dm / 60)) $((dm % 60)) | sed 's/:[+-]/:/'
)

get_tz
