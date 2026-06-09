# ============================================================
# Script: 01-export-users.ps1
# Project: AccessDenied Sec - Entra ID IAM Lab
# Description: Export all tenant users with key IAM attributes
# Author: Saurav Shinde
# Date: 2026-06-09
# ============================================================

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "Directory.Read.All"

Write-Host "Connected to Microsoft Graph. Fetching users..." -ForegroundColor Cyan

# Get all users with required properties
$users = Get-MgUser -All -Property `
    DisplayName, `
    UserPrincipalName, `
    Department, `
    JobTitle, `
    AccountEnabled, `
    AssignedLicenses, `
    CreatedDateTime

# Build export object
$export = $users | ForEach-Object {
    [PSCustomObject]@{
        DisplayName       = $_.DisplayName
        UserPrincipalName = $_.UserPrincipalName
        Department        = $_.Department
        JobTitle          = $_.JobTitle
        AccountEnabled    = $_.AccountEnabled
        LicensesAssigned  = if ($_.AssignedLicenses.Count -gt 0) { "Yes" } else { "No" }
        CreatedDateTime   = $_.CreatedDateTime
    }
}

# Output to console
$export | Format-Table -AutoSize

# Export to CSV
$outputPath = "D:\IAM project\scripts\users-export.csv"
$export | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`nExport complete. File saved to: $outputPath" -ForegroundColor Green
Write-Host "Total users exported: $($export.Count)" -ForegroundColor Green

# Disconnect
Disconnect-MgGraph