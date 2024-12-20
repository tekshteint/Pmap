function Get-WebPorts {

    [xml]$LatestPorts = (Invoke-WebRequest -Uri "https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml").Content

    $output = ""
    $total = $LatestPorts.ChildNodes.record.Count
    $current = 0
    foreach ($record in $LatestPorts.ChildNodes.record){
        $current++
        $percentComplete = [math]::Round(($current / $total) * 100, 2)
        Write-Progress -Activity "Processing records" -Status "Getting port descriptions from the web $percentComplete%" -PercentComplete $percentComplete
        if ([string]::IsNullOrEmpty($record.number) -or ([string]::IsNullOrEmpty($record.protocol))) {
            continue
        }

        $description = ($record.description -replace '`n','') -replace '\s+',' '

        $number = $record.number

        if ($number -like "*-*") {
            $numberArr = $number.Split('-')

            foreach($number1 in $numberArr[0]..$numberArr[1]) {
                $output += "$number1|$($record.protocol)|$($record.name)|$description`n"
            }
        }
        
        else {
            $output += "$number|$($record.protocol)|$($record.name)|$description`n"
        }
    }
    Write-Progress -Activity "Processing records" -Status "Getting port descriptions from the web $percentComplete%" -Completed

    Out-File -InputObject $output -FilePath "$PSScriptRoot\ports.txt"
    Write-Verbose -message "File created at $PSScriptRoot\ports.txt" 
}

function get-Version {
    $localModulePath = "$PSScriptRoot\pmap.psd1"
    $remoteModuleUrl = "https://raw.githubusercontent.com/tekshteint/Pmap/main/pmap.psd1"

    $localModule = Import-PowerShellDataFile -Path $localModulePath
    $localVersion = [version]$localModule.ModuleVersion

    $remoteModuleContent = Invoke-WebRequest -Uri $remoteModuleUrl -UseBasicParsing
    $remoteModule = Invoke-Expression $remoteModuleContent.Content
    $remoteVersion = [version]$remoteModule.ModuleVersion

    if ($localVersion.Major -lt $remoteVersion.Major) {
        Write-Host "A new version ($remoteVersion) is available. Please update your module." -ForegroundColor Yellow
    }         
}