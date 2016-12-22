<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function New-SDPNote
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Request to add note to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [int]
        $WorkOrderID,

        # Text for the note
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [String]
        $Text,

        # Is this note public
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true)]
        [switch]
        $Public = $false
    )

    Process
    {
        # HTML Encode the text
        Add-Type -AssemblyName System.Web
        $Text = [System.Web.HttpUtility]::HtmlEncode($Text)

        # Create the input data
        $InputData = @"
            <Operation>
                <Details>
                    <Notes>
                        <Note>
                            <isPublic>$Public</isPublic>
                            <notesText>$Text</notesText>
                        </Note>
                    </Notes>
                </Details>
            </Operation>
"@

        # Invoke the API
        $Response = Invoke-SDPAPI -Module "request" -ID $WorkOrderID -SubModule "notes" -Operation "ADD_NOTE" -InputData $InputData -Method Post
    }
}