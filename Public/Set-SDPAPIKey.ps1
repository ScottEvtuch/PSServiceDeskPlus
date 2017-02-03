<#
.Synopsis
   Sets the API key, and optionally saves it to the disk
.DESCRIPTION
   If not supplied in the parameters, prompts the user for the API key. Converts plaintext string
   to a SecureString and stores it in the module variable. If the Save switch is specified, check
   for a configuration XML file and update/create it with the new key.
.EXAMPLE
   Set-SDPAPIKey -Save
#>
function Set-SDPAPIKey
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # The API key
        [Parameter()]
        [String]
        $Key,

        # Whether or not to save the API key to the disk
        [Parameter()]
        [switch]
        $Save
    )

    Process
    {
        # Check if API key has been provided by parameter
        if ($Key -eq $null)
        {
            $script:SDPAPIKey = Read-Host -Prompt "Please provide ServiceDeskPlus API key" -AsSecureString
        }
        else
        {
            $script:SDPAPIKey = $Key | ConvertTo-SecureString -AsPlainText -Force
        }

        if ($save)
        {
            Write-Verbose "Saving the API key to disk"

            # Check for a configuration folder
            if (!(Test-Path -Path $ConfigRoot))
            {
                try
                {
                    Write-Debug "Creating the configuration folder"
                    New-Item -Path $ConfigRoot -ItemType Directory -ErrorAction Stop
                }
                catch
                {
                    throw "Failed to create configuration directory: $_"
                }
            }

            try
            {
                Write-Debug "Updating the XML configuration file"
                $SDPAPIKey | Export-Clixml -Path "$ConfigRoot\PSServiceDeskPlus-SDPAPIKey.xml" -Force -ErrorAction Stop
            }
            catch
            {
                throw "Failed to update the configuration file: $_"
            }
        }
    }
}