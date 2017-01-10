<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Get-SDPChanges
{
    [CmdletBinding()]
    [Alias()]
    Param()

    Process
    {
        # Invoke the API
        $Response = Invoke-SDPAPI -Module 'change' -Operation 'GET_ALL' -Method Get -InputData $InputData

        # Collect the results
        $Results = $Response.operation.Details.record
        Write-Verbose "Got $($Results.Count) results from the API"

        # Convert to PowerShell objects
        $Changes = $Results | ConvertFrom-SDPObject

        # Return the objects
        return $Changes
    }
}