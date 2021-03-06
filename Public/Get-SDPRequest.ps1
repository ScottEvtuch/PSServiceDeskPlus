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
        $WorkOrderID
    )

    Process
    {
        # Invoke the API
        $Response = Invoke-SDPAPI -Module 'request' -ID $WorkOrderID -Operation 'GET_REQUEST' -Method Post

        # Collect the result
        $Result = $Response.operation.Details

        # Convert to PowerShell object and return result
        $Result | ConvertFrom-SDPObject
    }
}