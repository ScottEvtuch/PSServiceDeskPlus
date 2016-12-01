<#
.Synopsis
   Sets the ServiceDeskPlus URL
.DESCRIPTION
   Sets the ServiceDeskPlus URL, and optionally saves it
.EXAMPLE
   Set-SDPURL -Save
#>
function Set-SDPURL
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Whether or not to save the ServiceDeskPlus URL to the disk
        [Parameter()]
        [switch]
        $Save
    )

    Process
    {
        # Prompt the user for the ServiceDeskPlus URL
        $script:SDPURL = Read-Host -Prompt "Please provide ServiceDeskPlus URL"

        # Optionally save the ServiceDeskPlus URL to disk
        if ($save)
        {
            # Check for a configuration folder
            if (!(Test-Path -Path $ConfigRoot))
            {
                # Configuration folder does not exist, try to create it
                try
                {
                    New-Item -Path $ConfigRoot -ItemType Directory -ErrorAction Stop
                }
                catch
                {
                    throw "Failed to create configuration directory: $_"
                }
            }

            # Update the configuration file
            try
            {
                $SDPURL | Export-Clixml -Path "$ConfigRoot\PSServiceDeskPlus-SDPURL.xml" -Force -ErrorAction Stop
            }
            catch
            {
                throw "Failed to update the configuration file: $_"
            }
        }
    }
}