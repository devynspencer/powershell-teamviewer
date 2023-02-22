. "$PSScriptRoot\Get-TeamViewerApiToken.ps1"

function Get-TeamViewerApiData {
    param(
        # TeamViewer API endpoint to target, i.e. devices, ping
        [Parameter(Mandatory)]
        $ApiEndpoint,

        # TeamViewer API token to authenticate the request with
        $Token = (Get-TeamViewerApiToken)
    )

    $BaseUri = 'https://webapi.teamviewer.com/api/v1'
    $EndpointUri = "$BaseUri/$ApiEndpoint"

    $Headers = @{
        'Authorization' = "Bearer $Token"
        'Content-Type' = 'application/json'
    }

    $Response = Invoke-RestMethod -Method GET -Uri $EndpointUri -Headers $Headers -Verbose

    $Response
}
