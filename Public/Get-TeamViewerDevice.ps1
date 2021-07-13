function Get-TeamViewerDevice {
    param (
        $Id,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $Token
    )

    begin {
        $Headers = @{ authorization = "Bearer $Token" }
    }

    process {
        foreach ($DeviceId in $Id) {
            $RestParams = @{
                Headers = $Headers
                Uri = "https://webapi.teamviewer.com/api/v1/devices/$DeviceId"
            }

            $Response = Invoke-RestMethod @RestParams

            foreach ($Device in $Response.devices) {
                [pscustomobject] @{
                    Id = $Device.teamviewer_id
                    RemoteControlId = $Device.remotecontrol_id
                    DeviceId = $Device.device_id
                    Alias = $Device.alias
                    GroupId = $Device.groupid
                    Status = $Device.online_state
                }
            }
        }

        if (!$PSBoundParameters.ContainsKey('Id')) {
            $RestParams = @{
                Headers = $Headers
                Uri = "https://webapi.teamviewer.com/api/v1/devices"
            }

            $Response = Invoke-RestMethod @RestParams

            foreach ($Device in $Response.devices) {
                [pscustomobject] @{
                    Id = $Device.teamviewer_id
                    RemoteControlId = $Device.remotecontrol_id
                    DeviceId = $Device.device_id
                    Alias = $Device.alias
                    GroupId = $Device.groupid
                    Status = $Device.online_state
                }
            }
        }
    }
}
