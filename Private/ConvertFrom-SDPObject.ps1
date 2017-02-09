<#
.Synopsis
   Converts API responses to usable PowerShell objects
.DESCRIPTION
   Takes the response from the SDP API and iterates through each object and its properties to
   create a custom PowerShell object. If necessary, some properties are converted to make them more
   useful in PowerShell. If a collection of properties is included in the parameters, they will be
   added as properties to every object returned. This is useful for injecting the ID of the parent
   object into child objects where the API does not provide that info.
.EXAMPLE
   $Results | ConvertFrom-SDPObject -Properties @{"workorderID"=123456;}
#>
function ConvertFrom-SDPObject
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Raw API response
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
        Write-Debug "Creating epoch DateTime object"
        $Epoch = New-Object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)

        Write-Verbose "Iterating through the results"
        $OutputObjects = @()
        foreach ($Object in $InputObject)
        {
            Write-Debug "Creating a hashtable for the properties"
            $OutputObject = $Properties.Clone()

            # If a URI was passed to us, generate an ID property from it
            if ($InputObject.URI -ne $null)
            {
                Write-Debug "Generating ID property from URL"
                $Split = $InputObject.URI.Split('/')
                $IDName = "$($Split[-3])ID"
                $IDValue = $Split[-2]

                # Check if the property already exists before adding it
                if (!$InputObject.parameter.name.ToLower().Contains($IDName.ToLower()))
                {
                    Write-Verbose "Adding ID property from URL"
                    $OutputObject.Add($IDName,$IDValue)
                }
            }

            Write-Verbose "Iterating through the result parameters"
            $InputObject.parameter | % {
                if ($_.Name -like "*time")
                {
                    Write-Verbose "Parsing $($_.Name) datetime property"
                    if ($_.Value -match '^[\d\.-]+$')
                    {
                        Write-Debug "Time value is a number"
                        if ([int64]$_.Value -lt 1)
                        {
                            Write-Debug "Time is null"
                            $OutputObject.Add($_.Name,$null)
                        }
                        else
                        {
                            Write-Debug "Converting time from epoch"
                            $OutputObject.Add($_.Name,$Epoch.AddMilliseconds($_.Value).ToLocalTime())
                        }
                    }
                    else
                    {
                        Write-Debug "Time value is a string"
                        $ThisValue = $_.Value
                        try
                        {
                            Write-Debug "Converting time from string"
                            $ThisValue = Get-Date $_.Value
                        }
                        catch
                        {
                            Write-Debug "Conversion failed, failback to string"
                        }
                        $OutputObject.Add($_.Name,$ThisValue)
                    }
                }
                else
                {
                    Write-Debug "Adding $($_.Name) property"
                    $OutputObject.Add($_.Name,$_.Value)
                }
            }
            Write-Debug "Return object from result"
            New-Object -TypeName PSObject -Property $OutputObject
        }
    }
}