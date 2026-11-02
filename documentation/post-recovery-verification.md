# Post-Recovery Verification

## Objective

Document the read-only checks performed after restoring Windows 11. The verification covers operating-system identification, disk and volume status, partition inventory, firmware information, and Secure Boot status.

## Previously Observed Results

The PowerShell evidence collected during this project showed:

- `Confirm-SecureBootUEFI` returned `True` in an elevated PowerShell session.
- `Get-Disk` listed three disks, each reporting `HealthStatus: Healthy` and `OperationalStatus: Online`.
- `Get-Partition` successfully returned a partition inventory.
- `Get-Volume` successfully returned a volume inventory. All reported volumes showed `HealthStatus: Healthy` and `OperationalStatus: OK`.

These results indicate that Windows can detect the storage devices and that the reported status fields are healthy. They do not guarantee that every file is intact or that every application is functioning correctly.

## Verification Script

**Location:** `scripts/recovery-verification.ps1`

The script collects and evaluates the following information:

| Verification Area | PowerShell Command / Method |
|---|---|
| Operating system | Windows version, build, architecture, and Windows 11 identification |
| Physical disks | `Get-Disk` |
| Partitions | `Get-Partition` |
| Volumes and filesystems | `Get-Volume` |
| Firmware | BIOS manufacturer, version, and release date |
| Secure Boot | `Confirm-SecureBootUEFI` |

Each verification check is assigned one of four statuses:

- `PASS` — The check completed successfully.
- `WARN` — The check returned a condition requiring attention.
- `FAIL` — The check did not meet its expected condition.
- `UNKNOWN` — The check could not be completed or its status could not be determined.

Optional physical-drive provider data is not used as a pass/fail requirement.

## Run Instructions

1. Open **Windows PowerShell as Administrator**.
2. Navigate to the root directory of the cloned GitHub repository.
3. Run the following commands:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\recovery-verification.ps1
```

The script generates a timestamped text report in:

```text
C:\ProgramData\RecoveryVerification\
```

## Verification Results

The completed verification run produced the following results:

| Check | Result |
|---|---|
| Windows 11 identification | PASS |
| Physical disk status | PASS |
| Partition inventory | PASS |
| Volume inventory | PASS |
| Firmware inventory | PASS |
| Secure Boot | PASS |

**Overall result: PASS**

The completed run reported:

```text
PASS=6
WARN=0
FAIL
