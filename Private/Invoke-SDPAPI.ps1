<#
.Synopsis
   Invokes the SDP REST API to submit or return information
.DESCRIPTION
   Builds the URI and request body from parameters and the configured API key. Calls
   "Invoke-RestMethod" to the SDP API URL from the module configuration. Returns the response
   object or throws an exception if the API responds with an error.
.EXAMPLE
   Invoke-SDPAPI -Method Get -Module 'request' -Operation 'GET_REQUESTS' -InputData $XmlString
#>
function Invoke-SDPAPI
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Module to use
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'Module')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'ID')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModule')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModuleID')]
        [String]
        $Module,

        # ID for module
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'ID')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModule')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModuleID')]
        [int]
        $ID,

        # Sub-Module to use
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModule')]
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModuleID')]
        [String]
        $SubModule,

        # ID for submodule
        [Parameter(Mandatory=$true,
                   ParameterSetName = 'SubModuleID')]
        [int]
        $SubID,

        # Operation to perform
        [Parameter(Mandatory=$true)]
        [String]
        $Operation,

        # HTTP method
        [Parameter(Mandatory=$true)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method,
        
        # Input data
        [Parameter()]
        [String]
        $InputData
    )

    Process
    {
        Write-Verbose "Building the request body"
        $Body = @{
            'TECHNICIAN_KEY' = Get-SDPAPIKey;
            'OPERATION_NAME' = $Operation;
            'INPUT_DATA' = $InputData;
        }

        Write-Verbose "Building the request URI"
        switch ($PSCmdlet.ParameterSetName)
        {
            'Module'
            {
                $Uri = "$SDPURL/$Module"
            }
            'ID'
            {
                $Uri = "$SDPURL/$Module/$ID"
            }
            'SubModule'
            {
                $Uri = "$SDPURL/$Module/$ID/$Submodule"
            }
            'SubModuleID'
            {
                $Uri = "$SDPURL/$Module/$ID/$Submodule/$SubID"
            }
            Default {throw "Bad ParameterSet"}
        }

        Write-Verbose "Invoking the REST API"
        try
        {
            $Response = Invoke-RestMethod -Method $Method -Uri $Uri -Body $Body -ErrorAction Stop
        }
        catch
        {
            throw "API Request failed: $_"
        }
        
        # Throw an error if SDP sent us back a failed message
        if ($Response.API.response.operation.result.status -eq 'Failed')
        {
            throw "API returned error: $($Response.API.response.operation.result.message)"
        }

        # Throw an error if we get a bogus response from the API
        if ($Response -eq "[#document: null]")
        {
            throw "API returned a null response"
        }

        Write-Verbose "Returning the response object"
        $Response.API.response
    }
}