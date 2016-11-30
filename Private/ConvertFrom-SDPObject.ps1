<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function ConvertFrom-SDPObject
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # View to pull tickets from
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true)]
        $InputObject
    )

    Process
    {
        # Iterate through the results
        $OutputObjects = @()
        foreach ($Object in $InputObject)
        {
            $OutputObject = @{}
            $InputObject.parameter | % {$OutputObject.Add($_.Name,$_.Value)}
            $OutputObjects += New-Object -TypeName PSObject -Property $OutputObject
        }

        # Return the objects
        return $OutputObjects
    }
}