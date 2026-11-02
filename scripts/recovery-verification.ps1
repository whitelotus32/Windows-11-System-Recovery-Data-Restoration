
<#
.SYNOPSIS
    Windows System Recovery Verification

.DESCRIPTION
    Collects read-only system, operating system, disk,
    partition, and volume information.

    Generates a timestamped diagnostic report on the
    current user's Desktop.

.NOTES
    Project: Windows 11 System Recovery & Data Restoration
    Author: Portfolio Project
    Version: 1.0

    This script performs read-only diagnostics.
    It does not format disks, modify partitions,
    change boot configuration, or alter system settings.
#>

$ErrorActionPreference = "Continue"

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$ReportPath = Join-Path ([Environment]::GetFolderPath("Desktop")) `
    "Recovery-Verification-$Timestamp.txt"

function Write-Section {
    param([string]$Title)

    $Header = "`r`n" + ("=" * 65) +
              "`r`n$Title`r`n" + ("=" * 65)

    Write-Host $Header -ForegroundColor Cyan
    Add-Content -Path $ReportPath -Value $Header
}

function Write-Report {
    param([string]$Content)

    Write-Host $Content
    Add-Content -Path $ReportPath -Value $Content
}

# Initialize report
@"
WINDOWS SYSTEM RECOVERY VERIFICATION
Generated: $(Get-Date)
===============================================================
Read-only system diagnostic report.
Personal identifiers and hardware serial numbers are excluded.
"@ | Set-Content -Path $ReportPath

Write-Host "`nStarting Windows system verification..." `
    -ForegroundColor Green

# ------------------------------------------------------------
# 1. Operating System Information
# ------------------------------------------------------------

Write-Section "1. OPERATING SYSTEM INFORMATION"

try {
    $OS = Get-CimInstance Win32_OperatingSystem

    Write-Report "Operating System: $($OS.Caption)"
    Write-Report "Version: $($OS.Version)"
    Write-Report "Build Number: $($OS.BuildNumber)"
    Write-Report "Architecture: $($OS.OSArchitecture)"
    Write-Report "Last Boot Time: $($OS.LastBootUpTime)"
}
catch {
    Write-Report "Unable to retrieve operating system information."
}

# ------------------------------------------------------------
# 2. Hardware Information
# ------------------------------------------------------------

Write-Section "2. HARDWARE INFORMATION"

try {
    $Computer = Get-CimInstance Win32_ComputerSystem
    $Processor = Get-CimInstance Win32_Processor

    $RAM = [math]::Round(
        $Computer.TotalPhysicalMemory / 1GB, 2
    )

    Write-Report "Manufacturer: $($Computer.Manufacturer)"
    Write-Report "System Model: $($Computer.Model)"
    Write-Report "Processor: $($Processor.Name)"
    Write-Report "Installed Memory: $RAM GB"
}
catch {
    Write-Report "Unable to retrieve hardware information."
}

# ------------------------------------------------------------
# 3. Physical Disk Inventory
# ------------------------------------------------------------

Write-Section "3. PHYSICAL DISK INVENTORY"

try {
    $Disks = Get-Disk

    foreach ($Disk in $Disks) {
        $SizeGB = [math]::Round($Disk.Size / 1GB, 2)

        $DiskInfo = @"
Disk Number: $($Disk.Number)
Model: $($Disk.FriendlyName)
Capacity: $SizeGB GB
Partition Style: $($Disk.PartitionStyle)
Operational Status: $($Disk.OperationalStatus)
Health Status: $($Disk.HealthStatus)
"@

        Write-Report $DiskInfo
    }
}
catch {
    Write-Report "Unable to retrieve physical disk information."
}

# ------------------------------------------------------------
# 4. Partition Inventory
# ------------------------------------------------------------

Write-Section "4. PARTITION INVENTORY"

try {
    $Partitions = Get-Partition

    foreach ($Partition in $Partitions) {
        $SizeGB = [math]::Round($Partition.Size / 1GB, 2)

        $PartitionInfo = @"
Disk: $($Partition.DiskNumber)
Partition: $($Partition.PartitionNumber)
Drive Letter: $($Partition.DriveLetter)
Type: $($Partition.Type)
Size: $SizeGB GB
"@

        Write-Report $PartitionInfo
    }
}
catch {
    Write-Report "Unable to retrieve partition information."
}

# ------------------------------------------------------------
# 5. Volume and Filesystem Information
# ------------------------------------------------------------

Write-Section "5. VOLUME AND FILESYSTEM INFORMATION"

try {
    $Volumes = Get-Volume

    foreach ($Volume in $Volumes) {
        $SizeGB = if ($Volume.Size) {
            [math]::Round($Volume.Size / 1GB, 2)
        } else {
            "N/A"
        }

        $FreeGB = if ($null -ne $Volume.SizeRemaining) {
            [math]::Round($Volume.SizeRemaining / 1GB, 2)
        } else {
            "N/A"
        }

        $VolumeInfo = @"
Drive Letter: $($Volume.DriveLetter)
Label: $($Volume.FileSystemLabel)
Filesystem: $($Volume.FileSystem)
Capacity: $SizeGB GB
Free Space: $FreeGB GB
Health Status: $($Volume.HealthStatus)
"@

        Write-Report $VolumeInfo
    }
}
catch {
    Write-Report "Unable to retrieve volume information."
}

# ------------------------------------------------------------
# 6. BIOS / Firmware Information
# ------------------------------------------------------------

Write-Section "6. FIRMWARE INFORMATION"

try {
    $BIOS = Get-CimInstance Win32_BIOS

    Write-Report "BIOS Manufacturer: $($BIOS.Manufacturer)"
    Write-Report "BIOS Version: $($BIOS.SMBIOSBIOSVersion)"
    Write-Report "Release Date: $($BIOS.ReleaseDate)"
}
catch {
    Write-Report "Unable to retrieve firmware information."
}

# ------------------------------------------------------------
# 7. Secure Boot Status
# ------------------------------------------------------------

Write-Section "7. SECURE BOOT STATUS"

try {
    $SecureBoot = Confirm-SecureBootUEFI -ErrorAction Stop

    if ($SecureBoot) {
        Write-Report "Secure Boot: Enabled"
    }
    else {
        Write-Report "Secure Boot: Disabled"
    }
}
catch {
    Write-Report "Secure Boot status could not be determined."
    Write-Report "The system may not support this query or may require elevated permissions."
}

# ------------------------------------------------------------
# 8. Verification Summary
# ------------------------------------------------------------

Write-Section "8. VERIFICATION SUMMARY"

Write-Report "Operating system information collected."
Write-Report "Hardware information collected."
Write-Report "Physical disk inventory attempted."
Write-Report "Partition inventory attempted."
Write-Report "Volume and filesystem inventory attempted."
Write-Report "Firmware information attempted."
Write-Report "Secure Boot status checked where supported."

Write-Report "`r`nReport generated successfully:"
Write-Report $ReportPath

Write-Host "`nVerification complete!" -ForegroundColor Green
Write-Host "Report saved to: $ReportPath" -ForegroundColor Yellow
