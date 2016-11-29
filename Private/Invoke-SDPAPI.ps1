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
        # HTTP method
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        $Method,

        # Module to use
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        $Module,

        # ID for module
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        $ID,

        # Sub-Module to use
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        $SubModule,

        # Operation to perform
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        $Operation,

        # Input data
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        $InputData
    )

    Begin
    {
    }
    Process
    {
        $RequestBody = @{
            'TECHNICIAN_KEY' = Get-SDPAPIKey;
            'OPERATION_NAME' = $Operation;
            'INPUT_DATA' = $InputData;
        }

        if ($ID -eq $null)
        {
            $Response = Invoke-RestMethod -Method $Method -Uri "$SDPURL/$Module/" -Body $RequestBody -ErrorAction Stop
        }
        elseif ($SubModule -eq $null)
        {
            $Response = Invoke-RestMethod -Method $Method -Uri "$SDPURL/$Module/$ID/" -Body $RequestBody -ErrorAction Stop
        } else
        {
            $Response = Invoke-RestMethod -Method $Method -Uri "$SDPURL/$Module/$ID/$Submodule" -Body $RequestBody -ErrorAction Stop
        }
        

        if ($Response.operation.result.status -eq 'Failed')
        {
            throw [Exception] "API Request failed: $($Response.operation.result.message)"
        }

        return $Response.API.response
    }
    End
    {
    }
}