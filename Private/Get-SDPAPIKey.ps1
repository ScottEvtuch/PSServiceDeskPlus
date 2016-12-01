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
        Write-Verbose $SDPAPIKey.ToString()

        if ($SDPAPIKey -eq '')
        {
            # Prompt the user for the API key
            $SDPAPIKey = Read-Host -Prompt "Please provide ServiceDeskPlus API key" -AsSecureString
        }
        
        $SDPAPIKeyBSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SDPAPIKey)
        $SDPAPIKeyString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($SDPAPIKeyBSTR)

        return $SDPAPIKeyString
    }
}