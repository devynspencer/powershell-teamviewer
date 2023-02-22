# PowerShell TeamViewer
Interact with the TeamViewer API using PowerShell.

## Getting Started

```powershell
cd ~\Downloads
git clone https://github.com/devynspencer/powershell-teamviewer

$UserModulesPath = ($env:PSModulePath -split ";")[0]
Copy-Item -Recurse "~\Downloads\powershell-teamviewer\TeamViewer" "$UserModulesPath\TeamViewer"
Import-Module -Force -Verbose TeamViewer
```

### Dependencies

This project uses the [Microsoft.PowerShell.SecretStore](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.secretstore/?view=ps-modules) module to simplify management of API tokens and other secrets. This requires the installation of a few dependencies:

```powershell
Install-Module -Name "Microsoft.PowerShell.SecretManagement", "Microsoft.PowerShell.SecretStore"
```

### Secret Store

Setup a new secret store to hold TeamViewer passwords, API tokens, and other secrets:

```powershell
Register-SecretVault -ModuleName Microsoft.PowerShell.SecretStore -Name TeamViewer -Verbose
Set-SecretStoreConfiguration -Authentication Password -Scope CurrentUser -Interaction None -Confirm:$false
```

### API Token

Generate a new API script token from your [TeamViewer profile](https://login.teamviewer.com/nav/profile/apps), then add it to the secret store:

```powershell
Unlock-SecretStore # Will prompt for password set in previous step

$ApiToken = "ABCDEFG1234567890HIJKLMNOPQ" # Replace with a real token, obviously
Set-Secret -Vault TeamViewer -Name TEAMVIEWER_API_TOKEN -Secret $ApiToken
```

## Examples

Get TeamViewer devices, and filter based on specific criteria:

```powershell
Get-TeamViewerDevice -GroupName "Developer Workstations"

# Alternatively
Get-TeamViewerGroupMember -Identity "Developer Workstations"
```

Rename a device:

```powershell
Set-TeamViewerDevice -Id 1095514322 -Name "PRDWRK01"
```

Update group memberships:

```powershell
Add-TeamViewerGroupMember -Identity "Developer Workstations" -Members "PRDWRK01"

# Alternatively
Set-TeamViewerDevice -Id 1095514322 -Group 1234567
```

See the built-in help for information on each function:

```powershell
help Get-TeamViewerDevice -Detailed
```
