<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Get-SDPNotes
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Request to pull notes for
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [int]
        $WorkOrderID
    )

    Process
    {
        # Invoke the API
        $Response = Invoke-SDPAPI -Module "request" -ID $WorkOrderID -SubModule "notes" -Operation "GET_NOTES" -Method Post

        # Collect the results
        $Results = $Response.operation.Details.notes.note
        Write-Verbose "Got $($Results.Count) results from the API"

        if ($Results.Count -gt 0)
        {
            # Convert to PowerShell objects
            $Notes = $Results | ConvertFrom-SDPObject -Properties @{"workOrderID"=$WorkOrderID}
        }
        else
        {
            # We have no results from the API
            Write-Warning "No notes were returned for WorkOrderID $WorkOrderID"
            $Notes = $null
        }

        # Return the objects
        return $Notes
    }
}