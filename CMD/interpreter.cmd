:; command -p tail -n +3 "$0" | exec node ${1+"$@"}; exit $?
(@powershell -ExecutionPolicy Unrestricted Get-Content "%~f0" ^| Select-Object -Skip 3 | @powershell %* -) & exit /b
console.log(0)
//////////////////////////////////////////////////////////////////////////////
/// \file      interpreter.cmd
/// \authore   SENOO, Ken
/// \copyright CC0
/// \sa        https://senooken.jp/post/2021/01/09/
/// \date      Created: 2021-01-02 Sat
/// \brief     Run without shebang (#!) on script language.
//////////////////////////////////////////////////////////////////////////////
