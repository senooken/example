:
################################################################################
## \file      get_tz.sh
## \author    SENOO, Ken
## \copyright CC0
## \sa        https://senooken.jp/post/2016/12/27/
## \version   0.0.1
## \date      Created: 2016-12-27T23:46+09:00
## \date      Updated: 2020-03-29T09:10+09:00
## \brief     Get time zone in POSIX shell script.
################################################################################

get_tz()(
	L_D=$(date +%j); U_D=$(date -u +%j)
	is_crossed_year="[ $L_D -eq 1 -o $U_D -eq 1 ] && [ $((L_D+U_D)) -ne 3 ]"
	eval $is_crossed_year && [ $L_D -eq 1 ] && U_D=0 || L_D=0

	LOCAL_MIN=$(echo "$L_D*24*60 + $(date    +%H)*60 + $(date    +%M)" | bc)
	UTC_0_MIN=$(echo "$U_D*24*60 + $(date -u +%H)*60 + $(date -u +%M)" | bc)
	DELTA_MIN=$((LOCAL_MIN - UTC_0_MIN))
	printf '%+03d:%+03d\n' $((DELTA_MIN/60)) $((DELTA_MIN%60)) | sed 's/:[+-]/:/'
)

get_tz
