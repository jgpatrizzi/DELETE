# Connect-SharePointOnline.ps1

# This script connects to SharePoint Online using Interactive/Browser-based login.

# Function to check and install the SharePoint Online Management Shell module
function Check-Module {
    # Check if the module is installed
    if (-not (Get-Module -ListAvailable -Name "Microsoft.Online.SharePoint.PowerShell")) {
        Write-Host "SharePoint Online Management Shell module is not installed. Installing..."
        Install-Module -Name "Microsoft.Online.SharePoint.PowerShell" -Force -AcceptLicense
    } else {
        Write-Host "SharePoint Online Management Shell module is already installed."
    }
}

# Function to connect to SharePoint Online
function Connect-SharePointOnline {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SiteUrl
    )

    try {
        # Check and install module if required
        Check-Module

        # Connect to SharePoint Online
        $credential = Get-Credential
        Connect-SPOService -url $SiteUrl -Credential $credential
        Write-Host "Connected to SharePoint Online at $SiteUrl"
    } catch {
        Write-Host "Error connecting to SharePoint Online: $_.Exception.Message"
    }
}

# Example usage:
# Connect-SharePointOnline -SiteUrl "https://yourtenant.sharepoint.com"