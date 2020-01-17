$csvFilePath = Read-Host "File Path"
$Files = Get-ChildItem $csvFilePath *.csv

foreach ($File in $Files.FullName)
{
$Datas = Import-Csv $File
$Results = @()
Foreach ($Data in $Datas)
{
$Outdata = @{
    A = $Data.ID1
    B = $Data.ID4
    C = $Data.ID7
    D = $Data.ID9
    }
$results += New-Object PSObject -Property $Outdata

}
$results | Export-Csv $csvFilePath\result.csv -NoTypeInformation -Append
}