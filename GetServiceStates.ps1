Write-Host "This script exports all the values of Windows Services startup types."
Write-Host "The file will be in a json format with .json extension."
Write-Host "Name of the output file: (ENTER for generated)"
$fileName = Read-Host

if ($fileName.Equals("")) {
    $fileName = "Services_$(Get-Date -Format "ddMMyy_HHmmss").json"
} else {
    $fileName = "$fileName.json"
}

$serviceData = @{}
$services = Get-Service

if (Test-Path -Path $fileName -PathType Leaf) {
    Write-Host "File $fileName already exists, do you want to replace it? (Y/n)"
    $answer = Read-Host
    if ($answer.ToLower().Equals("n")) {
        Write-Host "Stopping..."
        Return
    }
}

foreach ($service in $services) {
    $serviceData[$service.ServiceName] = $service.StartType
}

ConvertTo-Json $serviceData | Out-File -FilePath $fileName -Encoding ASCII

Write-Host "Startup types of services have been exported to '$($fileName)' successfully."