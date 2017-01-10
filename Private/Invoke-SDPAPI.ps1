<#
.Synopsis
   Uses the REST API in SDP to submit or return information
.DESCRIPTION
   Calls "Invoke-RestMethod" to the SDP API URL given the specified parameters
.EXAMPLE
   Invoke-SDPAPI -Method Get -Module 'request' -Operation 'GET_REQUESTS' -InputData '<Details><parameter><name>filterby</name><value>All_Requests</value></parameter></Details>'
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
        $Body = @{
            'TECHNICIAN_KEY' = Get-SDPAPIKey;
            'OPERATION_NAME' = $Operation;
            'INPUT_DATA' = $InputData;
        }

        # Build the URI
        switch ($PSCmdlet.ParameterSetName)
        {
            'Module'
            {
                $Uri = "$SDPURL/$Module/"
            }
            'ID'
            {
                $Uri = "$SDPURL/$Module/$ID/"
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

        # Invoke the API
        try
        {
            $Response = Invoke-RestMethod -Method $Method -Uri $Uri -Body $Body -ErrorAction Stop
        }
        catch
        {
            throw "API Request failed: $_"
        }
        
        # Throw an error if SDP sent us back a failed message
        if ($Response.operation.result.status -eq 'Failed')
        {
            throw "API returned error: $($Response.operation.result.message)"
        }

        # Return the response object
        return $Response.API.response
    }
}