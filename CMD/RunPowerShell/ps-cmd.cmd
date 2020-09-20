@echo off
:: -Commandと-Fileのオプション指定は省略可能な模様
:: 1. コマンド引数による実行
powershell ^
  $var = 'argument'; ^
  echo $var;

:: 2. 標準入力による実行
echo ^
  $var = 'stdin'; ^
  echo $var; ^
  | powershell -

:: 3. ファイルによる実行
echo $var = 'file'>>file.ps1
echo echo $var>>file.ps1
type file.ps1 | powershell -
powershell - <file.ps1
powershell -ExecutionPolicy Unrestricted .\file.ps1
del file.ps1