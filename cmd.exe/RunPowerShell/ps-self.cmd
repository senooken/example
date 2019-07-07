@powershell -ExecutionPolicy Unrestricted Invoke-Expression((Get-Content "%~f0" ^| Select-Object -Skip 1) -join \"`n\") %* & exit /b
$var = 'powershell'
echo $var
