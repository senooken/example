:
################################################################################
## \file      tegrastats_summary.sh
## \author    SENOO, Ken
## \copyright CC0
## \version   0.0.0
## \date      Created: 2021-01-11T14:43+09:00
## \brief     `tegrastats` コマンドの実行結果を集約する。

## ## Usage
## 以下のように標準入力からtegrastasコマンドの出力結果を渡す。
##
## ```
## tegrastats_summary.sh <tegrastats.log
## ```
##
## ## Output
## Type	Memory[MB]	CPU	GPU
## Mean	1316.63	29.0786%	28.16%
## Min	1314	6%	18%
## Max	1319	83%	38%
##
## ## Input
##
## ```
## RAM 1170/3956MB (lfb 496x4MB) SWAP 0/1978MB (cached 0MB) CPU [20%@1479,21%@1479,33%@1479,29%@1479] EMC_FREQ 0% GR3D_FREQ 34% PLL@38C CPU@39.5C PMIC@100C GPU@39C AO@46C thermal@38.75C POM_5V_IN 3129/3129 POM_5V_GPU 160/160 POM_5V_CPU 922/922
## ```
## 
## 上記のtegrastatsコマンドの出力で必要な情報は以下となる。
## 
## 1. 2列目の消費メモリー (RAM 1170/3956MB)。
## 2. 10列目のCPU使用率 (CPU [20%@1479,21%@1479,33%@1479,29%@1479])。
## 3. GPU使用率 (GR3D_FREQ 34%)。
## 
## 平均値と最大最小値を取得する。
## 
## 使用する列
## - 2: 消費メモリー
## - 13, 15, 17, 19: CPU使用率
## - 25: GPU使用率
################################################################################

EXE_NAME='tegrastats_summary'
tegrastats_summary() {
	awk '
function fmin(left, right) {return int(left) < int(right) ? left : right}
function fmax(left, right) {return int(left) > int(right) ? left : right}
BEGIN {FS="[] [,@/]"}
{
	memory["sum"] += $2
	memory["min"] = memory["min"] ? fmin(memory["min"], $2) : $2
	memory["max"] = fmax(memory["max"], $2)
	gpu["sum"] += $25
	gpu["min"] = gpu["min"] ? fmin(gpu["min"], $25): $25
	gpu["max"] = fmax(gpu["max"], $25)
	cpu["sum"] += $13 + $15 + $17 + $19
	cpu["min"] = cpu["min"] ? fmin(fmin(fmin(fmin(cpu["min"], $13), $15), $17),$19) : $13
	cpu["max"] = fmax(fmax(fmax(fmax(cpu["max"], $13), $15), $17), $19)
}
END {
	print "Type\tMemory[MB]\tCPU\tGPU"
	print "Mean\t" memory["sum"]/NR "\t" cpu["sum"]/NR/4 "%\t" gpu["sum"]/NR "%"
	print "Min\t" memory["min"] "\t" cpu["min"] "\t" gpu["min"]
	print "Max\t" memory["max"] "\t" cpu["max"] "\t" gpu["max"]
}'
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

