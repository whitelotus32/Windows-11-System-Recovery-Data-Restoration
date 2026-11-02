# PowerShell System Recovery Verification

## Project Overview

A PowerShell diagnostic utility developed to demonstrate Windows system administration and post-recovery verification capabilities.

The script collects operating system, hardware, physical disk, partition, volume, filesystem, and firmware information.

## Technical Objectives

- Retrieve Windows operating system information.
- Enumerate physical storage devices.
- Inspect disk partition configurations.
- Retrieve filesystem and volume information.
- Collect hardware and firmware details.
- Check Secure Boot status where supported.
- Generate a timestamped diagnostic report.

## Technologies

- Windows PowerShell
- CIM / WMI
- Storage Management cmdlets
- Windows firmware interfaces
- PowerShell error handling
- Text-based report generation

## Safety Considerations

The script is designed for read-only diagnostics. It does not perform disk formatting, partition modifications, operating system installations, or boot configuration changes.

System information is collected without intentionally including account usernames, hardware serial numbers, or other unnecessary personal identifiers.

## Expected Output

A timestamped text report containing system configuration and storage inventory information.

## Skills Demonstrated

- PowerShell scripting
- Windows system administration
- Disk and partition enumeration
- Filesystem inspection
- System verification
- Diagnostic reporting
- Error handling and troubleshooting
