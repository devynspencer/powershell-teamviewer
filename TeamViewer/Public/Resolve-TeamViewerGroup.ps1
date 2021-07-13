function Resolve-TeamViewerGroup {
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        $Name,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $Token
    )

    begin {
        $Headers = @{ authorization = "Bearer $Token" }
    }

    process {
        foreach ($GroupName in $Name) {
            $RestParams = @{
                Headers = $Headers
                Uri = "https://webapi.teamviewer.com/api/v1/groups?name=$Name"
                ContentType = 'application/json'
                Method = 'Get'
            }

            $Response = Invoke-RestMethod @RestParams

            foreach ($Group in $Response.groups) {
                [pscustomobject] @{
                    GroupId = $Group.id
                    Name = $Group.name
                    Policy = $Group.policy_id
                    Permissions = $Group.permissions
                    Owner = [pscustomobject] @{
                        Id = $Group.owner.userid
                        Name = $Group.owner.name
                    }
                    SharedWith = $Group.shared_with.foreach({ [pscustomobject] @{ Name = $_.name; Id = $_.userid; Permissions = $_.permissions } })
                }
            }
        }
    }
}
