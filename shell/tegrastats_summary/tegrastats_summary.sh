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
## - 02: 消費メモリー
## - 13, 15, 17, 19: CPU使用率
## - 25: GPU使用率
## - 27: 温度 PLL
## - 29: 温度 CPU
## - 31: 温度 PMIC
## - 33: 温度 GPU
## - 35: 温度 AO
## - 37: 温度 温度センサー
## - 40: 消費電力 POM_5V_IN
## - 43: 消費電力 POM_5V_GPU
## - 46: 消費電力 POM_5V_CPU

################################################################################


## 列をforで回して，1文字目が文字ならスキップ，そうでなければ集計するみたいな？

EXE_NAME='tegrastats_summary'
tegrastats_summary() {
	mawk '
function fmin(left, right) {return (left+0) < (right+0) ? left+0 : right+0}
function fmax(left, right) {return (left+0) > (right+0) ? left+0 : right+0}
function get_unit(name) {
	if (name == "RAM") {
		return "[MB]"
	} else if (name == "CPU") {
		return "[%]"
	} else if (name == "PLL") {
		return "[C]"
	} else if (name == "POM_5V_IN") {
		return "[mW]"
	}
	return ""
}
BEGIN {FS="[] [,@/()]*"}
{
	for (col = 1; col <= NF; ++col) {
		if ($col !~ /^[0-9]/) {
			if (length(get_unit($col))) {
				if (unit != "[C]" || get_unit($col) != "[%]") {
					unit = get_unit($col)
				}
			}
			header = $col unit
			continue
		}
		array[col, "name"] = header
		array[col, "mean"] = (array[col, "mean"]*(NR-1) + $col) / NR
		array[col, "min"] = length(array[col, "min"]) ? fmin(array[col, "min"], $col) : $col
		array[col, "max"] = fmax(array[col, "max"], $col)
		if (header == "CPU[%]") {
			header = "CPU[MHz]"
		} else if (header == "CPU[MHz]") {
			header = "CPU[%]"
		}
	}
}
END {
	ORS="\t"
	num = split("name,mean,min,max", labels, ",")
	for (label = 1; label <= num; ++label) {
		print labels[label]
		## Parital
		if (1) {
			print array[2, labels[label]] # RAM
			## CPU [%]
			if (label == 1) {
				print array[12, labels[label]]
			} else {
				print (array[12, labels[label]] + array[14, labels[label]] + array[16, labels[label]] + array[18, labels[label]])/4 # CPU [%]
			}
			print array[23, labels[label]] # GPU [%]

			print array[27, labels[label]] # CPU [C]
			print array[31, labels[label]] # GPU [C]

			## mW
			for (col = 38; col <= NF; col += 3) {
				print array[col, labels[label]]
			}
		} else {
		## All column
		# for (col = 1; col <= NF; ++col) {
		# 	if (!length(array[col, labels[label]])) continue
		# 	print array[col, labels[label]]
		# }
		}

		printf("\n")
	}
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

