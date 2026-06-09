# ============================================================
# Script: 02-export-grp-it-members.ps1
# Project: AccessDenied Sec - Entra ID IAM Lab
# Description: Export members of GRP-IT security group
# Author: Saurav Shinde
# Date: 2026-06-09
# ============================================================

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All", "User.Read.All", "Directory.Read.All" -TenantId "Sauravshindegmail.onmicrosoft.com"

Write-Host "Connected to Microsoft Graph. Fetching GRP-IT members..." -ForegroundColor Cyan

# Find GRP-IT group by display name
$group = Get-MgGroup -Filter "displayName eq 'GRP-IT'"

if (-not $group) {
    Write-Host "ERROR: GRP-IT group not found." -ForegroundColor Red
    exit
}

Write-Host "Group found: $($group.DisplayName) | ID: $($group.Id)" -ForegroundColor Green

# Get group members
$members = Get-MgGroupMember -GroupId $group.Id -All

# Build export object
$export = $members | ForEach-Object {
    $user = Get-MgUser -UserId $_.Id -Property DisplayName, UserPrincipalName, Department, JobTitle, AccountEnabled
    [PSCustomObject]@{
        DisplayName       = $user.DisplayName
        UserPrincipalName = $user.UserPrincipalName
        Department        = $user.Department
        JobTitle          = $user.JobTitle
        AccountEnabled    = $user.AccountEnabled
        GroupName         = $group.DisplayName
    }
}

# Output to console
$export | Format-Table -AutoSize

# Export to CSV
$outputPath = "D:\IAM project\scripts\grp-it-members-export.csv"
$export | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`nExport complete. File saved to: $outputPath" -ForegroundColor Green
Write-Host "Total members exported: $($export.Count)" -ForegroundColor Green

# Disconnect
Disconnect-MgGraph