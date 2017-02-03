<#
.Synopsis
   Returns the API key as plain text
.DESCRIPTION
   Checks for existence of the API key. If it exists, decrypt the SecureString and return the
   plaintext. If it is null, prompt the user by invoking "Set-SDPAPIKey" and then continue.
.EXAMPLE
   Get-SDPAPIKey
#>
function Get-SDPAPIKey
{
    Process
    {
        if ($SDPAPIKey -eq '')
        {
            Write-Verbose "Prompting user due to null API key"
            Set-SDPAPIKey
        }
        
        Write-Verbose "Decrypting API key"
        $SDPAPIKeyBSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SDPAPIKey)
        $SDPAPIKeyString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($SDPAPIKeyBSTR)

        return $SDPAPIKeyString
    }
}