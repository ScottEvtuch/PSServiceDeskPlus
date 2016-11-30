<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Get-SDPRequest
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Request to pull notes for
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [int]
        $RequestID
    )

    Process
    {
        # Invoke the API
        $Response = Invoke-SDPAPI -Module 'request' -ID $RequestID -Operation 'GET_REQUEST' -Method Post

        # Collect the result
        $Result = $Response.operation.Details

        # Convert to PowerShell object
        $Ticket = $Result | ConvertFrom-SDPObject

        # Return the object
        return $Ticket
    }
}