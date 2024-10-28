[xml]$LatestPorts = (Invoke-WebRequest -Uri "https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml").Content

$output = ""

foreach ($record in $LatestPorts.ChildNodes.record){

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

Out-File -InputObject $output -FilePath "$PSScriptRoot\ports.txt"