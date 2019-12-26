$ServerList = Import-Csv -Path C:\Wally\DEV\serverlist.csv
$ResultPath = 'C:\wally\dev'
$domain = '.danfoss.net'
$static = '.static.danfoss.net'

$results = @()
foreach ($server in $ServerList.server)
{
#Get hostname if FQDN and remove tailing blank spaces
$hostname = $server.Split('.')[0].Trim()
#Add RIB at the tail
$rib = "$($hostname)rib"

if (-NOT($HostDNS = Resolve-DnsName $hostname -ErrorAction Ignore))
{
$HostDNS = Resolve-DnsName $hostname$static -ErrorAction Ignore
}
    if ($RIBDNS = Resolve-DnsName $rib -ErrorAction Ignore)
    {
    $details = @{
        HostName = $hostname
        HostDNS = $HostDNS.IPAddress
        iLo = $rib
        iLoIP =  $RIBDNS.IPAddress
           }
    $results += New-Object PSObject -Property $details
    }

    else           
    {
    $details = @{
        HostName = $hostname
        HostDNS = $HostDNS.IPAddress
        iLo = $rib
        iLoIP = 'Not Exists'
           }
    $results += New-Object PSObject -Property $details
    }

}

$results | Export-Csv -Path $ResultPath\result.csv -NoTypeInformation
