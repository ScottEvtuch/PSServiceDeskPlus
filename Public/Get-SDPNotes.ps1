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
        
        # Check for results
        if ($Response.operation.Details -ne $null)
        {
            # Collect the results
            $Results = $Response.operation.Details.notes.note
            Write-Verbose "Got $(@($Results).Count) notes for WorkOrderID $WorkOrderID"

            # Convert to PowerShell objects and return results
            $Results | ConvertFrom-SDPObject -Properties @{"workOrderID"=$WorkOrderID}
        }

    }
}