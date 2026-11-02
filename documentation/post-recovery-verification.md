Post-Recovery Verification
Objective
Document the read-only checks performed after restoring Windows 11. The verification covers operating-system identification, disk and volume status, partition inventory, firmware information, and Secure Boot status.
Previously observed results
The PowerShell evidence supplied during this project showed:
`Confirm-SecureBootUEFI` returned `True` in an elevated PowerShell session.
`Get-Disk` listed three disks, each reporting `HealthStatus: Healthy` and `OperationalStatus: Online`.
`Get-Partition` returned a partition inventory.
`Get-Volume` returned a volume inventory; the user confirmed the volumes reported `HealthStatus: Healthy` and `OperationalStatus: OK`.
These results are positive indicators that Windows can detect the storage devices and that the reported status fields are healthy. They do not prove that every file is intact or that every application works.
Verification script
The script is located at `scripts/recovery-verification.ps1`.
It collects:
Windows version, build, and architecture, including an explicit Windows 11 identification check.
Physical disk health and operational status using `Get-Disk`.
Partition inventory using `Get-Partition`.
Volume filesystem, health, operational status, and available free space using `Get-Volume`.
BIOS manufacturer, version, and release date.
Secure Boot status using `Confirm-SecureBootUEFI`.
Each check is labelled `PASS`, `WARN`, `FAIL`, or `UNKNOWN`. Optional physical-drive provider data is deliberately not used as a gate, so missing provider support does not downgrade otherwise successful checks.
Run instructions
Open Windows PowerShell as Administrator, change to the root of the cloned repository, and run:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\recovery-verification.ps1
```
The script saves a timestamped text report under:
`C:\ProgramData\RecoveryVerification\`
Safety and privacy
The script is intended for read-only verification. It creates a report file, but it does not modify disks, partitions, filesystems, boot configuration, or firmware settings.
The report intentionally omits the computer name, user name, disk serial numbers, and personal profile paths. Review the report and screenshots before publishing them; hardware model names, volume labels, or other environment details may still be identifying in some contexts.
Interpretation and limitations
`Healthy` and `Online` for disks, and `Healthy` and `OK` for volumes, are positive status indicators—not a guarantee against future hardware failure.
Secure Boot can be `UNKNOWN` if the query is unsupported or unavailable in the current session. On this system, the earlier elevated query returned `True`.
A successful inventory does not verify every personal file, application, driver, or backup.
The script does not run disk repair, filesystem repair, malware scanning, or a full backup validation.
