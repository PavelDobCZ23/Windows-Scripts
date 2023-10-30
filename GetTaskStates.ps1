Write-Host "This script exports all the values of Windows Task Scheduler tasks states."
Write-Host "The file will be in a json format with .json extension."
Write-Host "Name of the output file: (ENTER for generated)"
$fileName = Read-Host

if ($fileName.Equals("")) {
    $fileName = "Tasks_$(Get-Date -Format "ddMMyy_HHmmss").json"
} else {
    $fileName = "$fileName.json"
}

$taskData = @{
    "enabled" = @()
    "disabled" = @()
}

$tasks = Get-ScheduledTask

if (Test-Path -Path $fileName -PathType Leaf) {
    Write-Host "File $fileName already exists, do you want to replace it? (Y/n)"
    $answer = Read-Host
    if ($answer.ToLower().Equals("n")) {
        Write-Host "Stopping..."
        Return
    }
}

foreach ($task in $tasks) {
    $taskEntry = @{
        "name" = $task.TaskName
        "path" = $task.TaskPath
    }

    if ($task.State.ToString().Equals("Disabled")) {
        $taskData["disabled"] += $taskEntry
    } else {
        $taskData["enabled"] += $taskEntry
    }
}

ConvertTo-Json $taskData | Out-File -FilePath $fileName -Encoding ASCII

Write-Host "States of Task Scheduler tasks have been exported to '$($fileName)' successfully."