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

    Begin
    {
    }
    Process
    {
        $Response = Invoke-SDPAPI -Method 'Post' -Module 'request' -ID $RequestID -Operation 'GET_REQUEST'

        $Result = $Response.operation.Details

        Write-Verbose "Got $($Results.Count) results from the API"

        $object = @{}
        $Result.parameter | % {$object.Add($_.Name,$_.Value)}
        $Ticket = New-Object -TypeName PSObject -Property $object

        return $Ticket
    }
    End
    {
    }
}