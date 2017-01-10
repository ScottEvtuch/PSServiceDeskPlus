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
        $InputObject,

        # Additional properties
        [Parameter(Mandatory=$false)]
        [System.Collections.Hashtable]
        $Properties = @{}
    )

    Process
    {
        # Set up variables
        $Epoch = New-Object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)

        # Iterate through the results
        $OutputObjects = @()
        foreach ($Object in $InputObject)
        {
            $OutputObject = $Properties.Clone()

            # If a URI was passed to us, generate an ID property from it
            if ($InputObject.URI -ne $null)
            {
                $Split = $InputObject.URI.Split('/')
                $OutputObject.Add("$($Split[-3])id",$Split[-2])
            }

            # Add the parameters to the object properties
            $InputObject.parameter | % {
                if ($_.Name -like "*time")
                {
                    # Convert the epoch integer to a datetime before adding
                    if ($_.Value -eq -1)
                    {
                        $OutputObject.Add($_.Name,$null)
                    }
                    else
                    {
                        $OutputObject.Add($_.Name,$Epoch.AddMilliseconds($_.Value).ToLocalTime())
                    }
                }
                else
                {
                    # Add normal properties
                    $OutputObject.Add($_.Name,$_.Value)
                }
            }
            $OutputObjects += New-Object -TypeName PSObject -Property $OutputObject
        }

        # Return the objects
        return $OutputObjects
    }
}