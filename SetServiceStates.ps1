$STARTUP_NAMES = @("Boot","System","Automatic","Manual","Disabled")

Write-Host "This script updates the startup type of Windows Services, use with caution!"
Write-Host "The file should use json format with keys meaning name and values meaning startup type of a service."
Write-Host "What file do you want to load the values from?"
$filePath = Read-Host

if (!(Test-Path -Path $filePath -PathType Leaf)) {
    Write-Host "File not found: $filePath"
    Return
}

$services = Get-Content -Path $filePath -Raw | ConvertFrom-Json

foreach ($service in $services.PSObject.Properties) {
    Set-Service -Name $service.Name -StartupType $service.Value
    Write-Host "Set service '$($service.Name)' to start type '$($STARTUP_NAMES[$service.Value])'."
}