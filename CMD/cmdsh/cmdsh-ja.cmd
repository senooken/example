: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: \file      cmdsh-ja.cmd
: \author    SENOO, KEN
: \copyright CC0
: \date      Created: 2021-01-02T16:37+09:00
: \sa        https://senooken.jp/post/2021/01/08/
: \brief     sh/cmd.exe互換スクリプト (日本語対応)。
: 
: sh/cmd.exe両対応スクリプトで日本語を使用する場合，以下の点に注意する。
: 
: 1. 改行コード=CRLF
: 2. 文字エンコーディング=Shift_JIS or CP932 (Windows 932)
: 3. shでCR (\r) が改行とみなされないため，行末を#でコメントアウト
: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: 空行1
: <<-"EOC"
@echo off
echo cmd.exe こんにちは。
exit /b
EOC
# 空行2
echo sh こんにちは。 #