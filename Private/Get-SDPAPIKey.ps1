<#
.Synopsis
   Returns the API key
.DESCRIPTION
   Returns the API key
.EXAMPLE
   Get-SDPAPIKey
#>
function Get-SDPAPIKey
{
    Process
    {
        if ($SDPAPIKey -ne $null)
        {
            # Return the API key
            return $SDPAPIKey
        }
        else
        {
            # Prompt the user for the API key
            $SDPAPIKey = Read-Host -Prompt "Please provide ServiceDeskPlus API key" -AsSecureString

            # Return the API key
            return $SDPAPIKey
        }
        
    }
}