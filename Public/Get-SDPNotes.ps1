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
        $RequestID
    )

    Begin
    {
    }
    Process
    {
        $Response = Invoke-SDPAPI -Method "Post" -Module "request" -ID $RequestID -SubModule "notes" -Operation "GET_NOTES"

        $Results = $Response.operation.Details.notes.note

        Write-Verbose "Got $($Results.Count) results from the API"

        $Notes = @()

        foreach ($Result in $Results)
        {
            $object = @{}
            $Result.parameter | % {$object.Add($_.Name,$_.Value)}
            $Notes += New-Object -TypeName PSObject -Property $object
        }

        return $Notes
    }
    End
    {
    }
}