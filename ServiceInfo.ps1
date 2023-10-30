(Get-Service | Select-Object Name, Status, StartType, DisplayName) | Format-Table -AutoSize
pause