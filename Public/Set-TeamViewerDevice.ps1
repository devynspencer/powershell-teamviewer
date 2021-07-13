function Set-TeamViewerDevice {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNull()]
        $Id,

        $Alias,

        $Description,

        $Password,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $Token
    )

    begin {
        $Headers = @{ authorization = "Bearer $Token" }
    }

    process {
        foreach ($Device in $Id) {
            $Body = @{}

            if ($PSBoundParameters.ContainsKey('Alias')) {
                $Body.alias = $Alias
            }

            if ($PSBoundParameters.ContainsKey('Description')) {
                $Body.description = $Description
            }

            if ($PSBoundParameters.ContainsKey('Password')) {
                $Body.password = $Password
            }

            $RestParams = @{
                Headers = $Headers
                Uri = "https://webapi.teamviewer.com/api/v1/devices/$Device"
                ContentType = 'application/json'
                Method = 'Put'
                Body = ($Body | ConvertTo-Json -Compress)
            }

            $Response = Invoke-RestMethod @RestParams
        }
    }
}
