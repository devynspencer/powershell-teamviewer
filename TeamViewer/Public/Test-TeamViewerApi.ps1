. "$PSScriptRoot\..\Private\Get-TeamViewerApiData.ps1"

function Test-TeamViewerApi {
    $Response = Get-TeamViewerApiData -ApiEndpoint 'ping'

    $Response.token_valid

    # TODO: Cleanup output object
}
