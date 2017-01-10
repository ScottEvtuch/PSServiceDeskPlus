<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Remove-SDPNote
{
    [CmdletBinding(SupportsShouldProcess=$true,
                  ConfirmImpact='High')]
    [Alias()]
    Param
    (
        # Request to delete note for
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [int]
        $WorkOrderID,

        # Note to delete
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [int]
        $NotesID
    )

    Process
    {
        # Confirm with the user
        if ($pscmdlet.ShouldProcess("Request $WorkOrderID - Note $NotesID", "Delete"))
        {
            # Invoke the API
            $Response = Invoke-SDPAPI -Module "request" -ID $WorkOrderID -SubModule "notes" -SubID $NotesID -Operation "DELETE_NOTE" -Method Post
        }
    }
}