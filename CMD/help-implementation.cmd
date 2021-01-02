::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      help-implementation.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \version   0.0.1
:: \date      Created: 2021-01-02T14:32+09:00
:: \sa        https://senooken.jp/post/2021/01/07/
:: \brief     Implementation for /? option on cmd.exe
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

break %* >nul || (
  echo help
  exit /b 1
)

echo arg: %*
