(@powershell -ExecutionPolicy Unrestricted Get-Content "%~f0" ^| Select-Object -Skip 1 | [powershell %* -) & exit /b
$var = 'powershell'
echo $var
