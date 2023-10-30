Write-Host "This script updates the state of Task Scheduler tasks, use with caution!"
Write-Host "The file should use json format with 2 arrays 'enabled' and 'disabled' that contain objects with properties 'name' and 'path'."
Write-Host "What file do you want to load the values from?"
$filePath = Read-Host

if (!(Test-Path -Path $filePath -PathType Leaf)) {
    Write-Host "File not found: $filePath"
    Return
}

$tasks = Get-Content -Path $filePath -Raw | ConvertFrom-Json

foreach ($task in $tasks.enabled) {
    Enable-ScheduledTask -TaskName $task.name -TaskPath $task.path
    Write-Host "Enabled task '$($task.path)$($task.name)'."
}

foreach ($task in $tasks.disabled) {
    Disable-ScheduledTask -TaskName $task.name -TaskPath $task.path
    Write-Host "Disabled task '$($task.path)$($task.name)'."
}