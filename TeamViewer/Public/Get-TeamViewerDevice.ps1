function Get-TeamViewerDevice {
    [CmdletBinding(DefaultParameterSetName = 'ByDeviceId')]
    param (
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'ByDeviceId')]
        $Id,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'ByGroupId')]
        $GroupId,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $Token
    )

    begin {
        $Headers = @{ authorization = "Bearer $Token" }
    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'ByDeviceId' {
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

            'ByGroupId' {
                foreach ($Group in $GroupId) {
                    $RestParams = @{
                        Headers = $Headers
                        Uri = "https://webapi.teamviewer.com/api/v1/devices?groupid=$Group"
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
    }
}
