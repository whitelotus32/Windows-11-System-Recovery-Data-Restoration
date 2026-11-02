# Windows 11 post-recovery verification
# Read-only system inventory. Run PowerShell as Administrator for best results.
# The only write performed is creation of the text report under ProgramData.

$ErrorActionPreference = "Stop"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$reportDirectory = Join-Path $env:ProgramData "RecoveryVerification"
$reportPath = Join-Path $reportDirectory "Recovery-Verification-$timestamp.txt"

New-Item -ItemType Directory -Path $reportDirectory -Force | Out-Null

$report = [System.Collections.Generic.List[string]]::new()
$results = [System.Collections.Generic.List[object]]::new()

function Add-Check {
    param(
        [string]$Name,
        [ValidateSet("PASS", "WARN", "FAIL", "UNKNOWN")]
        [string]$Status,
        [string]$Details
    )
    $results.Add([pscustomobject]@{
        Name = $Name
        Status = $Status
        Details = $Details
    })
}

function Add-Section {
    param([string]$Heading)
    $report.Add("")
    $report.Add(("=" * 64))
    $report.Add($Heading.ToUpperInvariant())
    $report.Add(("=" * 64))
}

$report.Add("WINDOWS 11 POST-RECOVERY VERIFICATION")
$report.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$report.Add("This report intentionally excludes computer name, user name, disk serial numbers, and personal profile paths.")

# 1. Operating system — explicitly verify Windows 11.
Add-Section "1. Operating System"
try {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $report.Add("Name: $($os.Caption)")
    $report.Add("Version: $($os.Version)")
    $report.Add("Build: $($os.BuildNumber)")
    $report.Add("Architecture: $($os.OSArchitecture)")

    if ($os.Caption -match "Windows 11" -or [int]$os.BuildNumber -ge 22000) {
        Add-Check "Windows 11 identification" "PASS" "Windows 11 or a Windows 11-era build was detected."
    }
    else {
        Add-Check "Windows 11 identification" "FAIL" "The detected operating system does not identify as Windows 11."
    }
}
catch {
    Add-Check "Windows 11 identification" "FAIL" "Could not retrieve operating system information."
}

# 2. Physical disks — use Get-Disk as the primary inventory source.
Add-Section "2. Physical Disks"
try {
    $disks = @(Get-Disk)
    foreach ($disk in $disks) {
        $operational = @($disk.OperationalStatus) -join ", "
        $sizeGB = [math]::Round($disk.Size / 1GB, 2)
        $report.Add("Disk $($disk.Number): $($disk.FriendlyName) | Health=$($disk.HealthStatus) | Operational=$operational | Size=$sizeGB GB | PartitionStyle=$($disk.PartitionStyle)")
    }

    if ($disks.Count -eq 0) {
        Add-Check "Physical disk status" "FAIL" "Windows returned no physical disks."
    }
    else {
        $unhealthyDisks = @($disks | Where-Object {
            $_.HealthStatus -ne "Healthy" -or @($_.OperationalStatus) -notcontains "Online"
        })

        if ($unhealthyDisks.Count -gt 0) {
            Add-Check "Physical disk status" "WARN" "$($unhealthyDisks.Count) disk(s) did not report both Healthy and Online."
        }
        else {
            Add-Check "Physical disk status" "PASS" "$($disks.Count) disk(s) report Healthy and Online."
        }
    }
}
catch {
    Add-Check "Physical disk status" "FAIL" "The Get-Disk inventory query failed."
}

# 3. Partition inventory.
Add-Section "3. Partitions"
try {
    $partitions = @(Get-Partition)
    foreach ($partition in $partitions) {
        $drive = if ($partition.DriveLetter) { "$($partition.DriveLetter):" } else { "(no drive letter)" }
        $sizeMB = [math]::Round($partition.Size / 1MB, 1)
        $report.Add("Disk=$($partition.DiskNumber) | Partition=$($partition.PartitionNumber) | Drive=$drive | Type=$($partition.Type) | Size=$sizeMB MB")
    }

    if ($partitions.Count -gt 0) {
        Add-Check "Partition inventory" "PASS" "$($partitions.Count) partition(s) enumerated."
    }
    else {
        Add-Check "Partition inventory" "WARN" "Windows returned no partitions."
    }
}
catch {
    Add-Check "Partition inventory" "FAIL" "The Get-Partition inventory query failed."
}

# 4. Volume inventory — check the HealthStatus and OperationalStatus fields.
Add-Section "4. Volumes and File Systems"
try {
    $volumes = @(Get-Volume)
    foreach ($volume in $volumes) {
        $drive = if ($volume.DriveLetter) { "$($volume.DriveLetter):" } else { "(no drive letter)" }
        $freeSpace = if ($null -ne $volume.SizeRemaining) {
            "$([math]::Round($volume.SizeRemaining / 1GB, 2)) GB free"
        }
        else {
            "free space unavailable"
        }
        $operational = @($volume.OperationalStatus) -join ", "
        $report.Add("Drive=$drive | FileSystem=$($volume.FileSystem) | Health=$($volume.HealthStatus) | Operational=$operational | $freeSpace")
    }

    if ($volumes.Count -eq 0) {
        Add-Check "Volume inventory" "WARN" "Windows returned no volumes."
    }
    else {
        $problemVolumes = @($volumes | Where-Object {
            $_.HealthStatus -ne "Healthy" -or @($_.OperationalStatus) -notcontains "OK"
        })

        if ($problemVolumes.Count -gt 0) {
            Add-Check "Volume inventory" "WARN" "$($problemVolumes.Count) volume(s) did not report both Healthy and OK."
        }
        else {
            Add-Check "Volume inventory" "PASS" "$($volumes.Count) volume(s) report Healthy and OK."
        }
    }
}
catch {
    Add-Check "Volume inventory" "FAIL" "The Get-Volume inventory query failed."
}

# 5. Firmware inventory. No serial number is collected.
Add-Section "5. Firmware"
try {
    $bios = Get-CimInstance -ClassName Win32_BIOS
    $report.Add("Manufacturer: $($bios.Manufacturer)")
    $report.Add("BIOS version: $($bios.SMBIOSBIOSVersion)")
    $report.Add("Release date: $($bios.ReleaseDate)")
    Add-Check "Firmware inventory" "PASS" "BIOS manufacturer, version, and release date retrieved."
}
catch {
    Add-Check "Firmware inventory" "UNKNOWN" "BIOS information could not be retrieved."
}

# 6. Secure Boot. Requires UEFI support and may require an elevated session.
Add-Section "6. Secure Boot"
try {
    $secureBootEnabled = Confirm-SecureBootUEFI
    if ($secureBootEnabled) {
        $report.Add("Secure Boot: Enabled")
        Add-Check "Secure Boot" "PASS" "Confirm-SecureBootUEFI returned True."
    }
    else {
        $report.Add("Secure Boot: Disabled")
        Add-Check "Secure Boot" "WARN" "Confirm-SecureBootUEFI returned False."
    }
}
catch {
    $report.Add("Secure Boot query was unavailable in this session.")
    Add-Check "Secure Boot" "UNKNOWN" "Query unsupported or unavailable; try an elevated PowerShell session on a UEFI system."
}

# 7. Summary.
Add-Section "7. Verification Summary"
foreach ($result in $results) {
    $report.Add(("{0,-30} {1,-8} {2}" -f $result.Name, $result.Status, $result.Details))
}

$passCount = @($results | Where-Object Status -eq "PASS").Count
$warnCount = @($results | Where-Object Status -eq "WARN").Count
$failCount = @($results | Where-Object Status -eq "FAIL").Count
$unknownCount = @($results | Where-Object Status -eq "UNKNOWN").Count

$report.Add("Totals: PASS=$passCount | WARN=$warnCount | FAIL=$failCount | UNKNOWN=$unknownCount")

if ($failCount -gt 0) {
    $overall = "REVIEW REQUIRED"
}
elseif ($warnCount -gt 0 -or $unknownCount -gt 0) {
    $overall = "PARTIAL - review warnings and unknowns"
}
else {
    $overall = "PASS"
}
$report.Add("Overall result: $overall")

$report | Set-Content -LiteralPath $reportPath -Encoding UTF8

Write-Host ""
Write-Host "Verification run finished." -ForegroundColor Green
Write-Host "Overall result: $overall"
Write-Host "PASS=$passCount WARN=$warnCount FAIL=$failCount UNKNOWN=$unknownCount"
Write-Host "Report saved to: $reportPath" -ForegroundColor Yellow
Write-Host "No disks, partitions, volumes, or firmware settings were changed."
