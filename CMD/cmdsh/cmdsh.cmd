: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: \file      cmdsh.cmd
: \author    SENOO, KEN
: \copyright CC0
: \date      Created: 2021-01-02T16:37+09:00
: \sa        https://senooken.jp/post/2021/01/08/
: \brief     sh/cmd.exe compatible script.
:
: 1. Use .cmd extension.
: 2. Use LF for line break.
: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

: cmd.exe block
: <<-"::EOC"
@echo off
echo cmd.exe
exit /b
::EOC

: sh block
echo sh