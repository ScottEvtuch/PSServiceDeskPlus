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

    Process
    {
        # Prepare the InputData XML
        $InputData = @"
            <Details>
                <parameter>
                    <name>from</name>
                    <value>0</value>
                </parameter>
                <parameter>
                    <name>limit</name>
                    <value>$Limit</value>
                </parameter>
                <parameter>
                    <name>filterby</name>
                    <value>$View</value>
                </parameter>
            </Details>
"@
        
        # Invoke the API
        $Response = Invoke-SDPAPI -Module 'request' -Operation 'GET_REQUESTS' -Method Get -InputData $InputData

        # Collect the results
        $Results = $Response.operation.Details.record
        Write-Verbose "Got $($Results.Count) results from the API"

        # Convert to PowerShell objects
        $Tickets = $Results | ConvertFrom-SDPObject

        # Return the objects
        return $Tickets
    }
}