# cmdsh: sh/cmd.exe両対応スクリプト

## Overview
URL: https://senooken.jp/post/2021/01/08/

Windowsのcmd.exeとUNIX系OSのsh (bashなど) の両方で動作するスクリプトのコーディング方法を整理した。


以下のように`:` のヒアドキュメント内にcmd.exeのコードを記述して実装する。

```
: cmd.exe block
: <<-"::EOC"
@echo off
echo cmd.exe
exit /b
::EOC

: sh block
echo sh
```

## Content

1. cmdsh.cmd: 基本的な実装例
2. cmdsh-long.cmd: cmd.exeとshの処理ごとの併記例
3. cmdsh-ja.cmd: 日本語を含む場合の例

