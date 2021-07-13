# PowerShell TeamViewer
Interact with the TeamViewer API using PowerShell.

## Install
Install from GitHub source:

```powershell
git clone 'https://github.com/devynspencer/powershell-teamviewer'
cd .\powershell-sysadmin
```

## Repositories
Configure local NuGet feed for publishing and/or staging PowerShell modules:

```powershell
$RegisterParams = @{
    Name = 'Local'
    SourceLocation = 'C:\temp\packages\PowerShell'
    PublishLocation = 'C:\temp\packages\PowerShell'
    InstallationPolicy = 'Trusted'
}

Register-PSRepository @RegisterParams
```

Publish to local repository:

```powershell
$PublishParams = @{
    Path = '.\Sysadmin'
    Repository = 'Local'
    NuGetApiKey = ''
}

Publish-Module @PublishParams
```
