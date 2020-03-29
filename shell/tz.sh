:
################################################################################
## \file      tz.sh
## \author    SENOO, Ken
## \copyright CC0
## \version   0.1.0
## \date      Created: 2016-12-27T23:46+09:00
## \date      Updated: 2020-03-29T11:38+09:00
## \sa        https://senooken.jp/post/2016/12/27/
## \brief     Get time zone in POSIX shell script.
################################################################################

tz() (
	set $(date -u '+%Y %j %H %M'); U_Y=$1 U_D=${2#0} U_D=${U_D#0} U_H=${3#0} U_M=${4#0}
	set $(date    '+%Y %j %H %M'); L_Y=$1 L_D=${2#0} L_D=${L_D#0} L_H=${3#0} L_M=${4#0}

	# Fix if year is crossed.
	U_D=$((U_Y == L_Y ? U_D : L_D + (U_Y - L_Y)))

	# Calculate delta minutes.
	dm=$(((L_D*24*60 + L_H*60 + L_M) - (U_D*24*60 + U_H*60 + U_M)))
	DIGIT_1=$((dm<0 ? -dm%10 : dm%10))

	# Fix if minute is changed during running date command.
	[ $DIGIT_1 = 1 -o $DIGIT_1 = 6 ] && dm=$((dm<0 ? dm+1 : dm-1))
	[ $DIGIT_1 = 4 -o $DIGIT_1 = 9 ] && dm=$((dm<0 ? dm-1 : dm+1))

	printf '%+03d:%+03d\n' $((dm / 60)) $((dm % 60)) | sed 's/:[+-]/:/'
)

is_main() { [ 'tz.sh' = "${0##*/}" ]; }
if is_main; then
	tz
fi
