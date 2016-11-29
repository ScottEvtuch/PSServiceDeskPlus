<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Get-SDPRequests
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # View to pull tickets from
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        $View = 'All_Requests',

        # Limit
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        $Limit = 25
    )

    Begin
    {
    }
    Process
    {
        $Response = Invoke-SDPAPI -Method 'Get' -Module 'request' -Operation 'GET_REQUESTS' -InputData "<Details><parameter><name>from</name><value>0</value></parameter><parameter><name>limit</name><value>$Limit</value></parameter><parameter><name>filterby</name><value>$View</value></parameter><parameter><name>status</name><value>Resolved</value></parameter></Details>"

        $Results = $Response.operation.Details.record

        Write-Verbose "Got $($Results.Count) results from the API"

        $Tickets = @()

        foreach ($Result in $Results)
        {
            $object = @{}
            $Result.parameter | % {$object.Add($_.Name,$_.Value)}
            $Tickets += New-Object -TypeName PSObject -Property $object
        }

        return $Tickets
    }
    End
    {
    }
}