function Get-TeamViewerApiToken {
    Get-Secret -Vault TeamViewer -Name TEAMVIEWER_API_TOKEN -AsPlainText
}
