. "$PSScriptRoot\..\Private\Get-TeamViewerApiData.ps1"

function Get-TeamViewerDevice {
    $Response = Get-TeamViewerApiData -ApiEndpoint 'devices'

    $Response.devices

    # TODO: Cleanup output object
}
