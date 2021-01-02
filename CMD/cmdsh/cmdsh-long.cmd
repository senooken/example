: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: \file      cmdsh-long.cmd
: \author    SENOO, KEN
: \copyright CC0
: \date      Created: 2021-01-02T16:37+09:00
: \sa        https://senooken.jp/post/2021/01/08/
: \brief     List sh/cmd.exe for same process.
: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

: Process 1: cmd.exe <<-"EOC"
@echo off
echo cmd.exe 1
goto Process
EOC
# Process 1: sh
echo sh 1

: Process 2: cmd.exe <<-"EOC"
@echo off
echo cmd.exe 2
goto Process
EOC
# Process 2: sh
echo sh 2

: Process 3: cmd.exe <<-"EOC"
@echo off
echo cmd.exe 3
exit /b
EOC
# Process 3: sh
echo sh 3
