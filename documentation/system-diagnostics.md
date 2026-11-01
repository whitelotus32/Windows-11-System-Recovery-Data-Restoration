# System Diagnostics and Technical Investigation

## 1. Diagnostic Overview

Following an unintended Windows Server 2025 installation on the physical workstation, a systematic troubleshooting process was initiated to identify the source of the operating system disruption and determine an appropriate recovery strategy.

The investigation focused on operating system configuration, physical storage devices, disk partitions, filesystem volumes, virtualization configuration, and boot environment behavior.

**Primary diagnostic tools:**
- Windows PowerShell
- Windows Command Prompt
- Windows Boot Manager
- UEFI/BIOS firmware configuration

## 2. Virtualization Environment Assessment

The original objective was to deploy Windows Server within an isolated Oracle VirtualBox virtual machine as part of a cybersecurity lab environment.

During the investigation, it was determined that Windows Server 2025 had been installed directly onto the physical workstation rather than within the intended virtual machine.

An additional issue was identified with the Northstar virtual disk configuration.

The virtual disk file was approximately 2 MiB in size, indicating that the intended virtual disk had not been fully created or provisioned.

This finding helped distinguish the incomplete virtual machine configuration from the operating system installation affecting the physical host.

## 3. PowerShell System Diagnostics

Windows PowerShell was utilized to investigate the workstation's storage configuration and examine the relationship between physical disks, partitions, and logical volumes.

The following commands were used during the diagnostic process:

| PowerShell Command | Administrative Purpose |
|---|---|
| `Get-Disk` | Enumerate physical disks and inspect disk attributes |
| `Get-Partition` | Retrieve partition information and disk associations |
| `Get-Volume` | Inspect logical volumes, filesystem types, drive letters, and health information |
| `Get-ChildItem` | Examine directories and filesystem contents |

These commands provided visibility into the storage environment and supported the investigation of existing Windows installation data.

## 4. Command-Line Recovery Investigation

Windows Command Prompt was also used during the recovery process to support command-line troubleshooting and system recovery operations.

The command-line environment provided an additional method for interacting with the Windows recovery environment and investigating system accessibility.

The use of both PowerShell and Command Prompt demonstrated the importance of understanding multiple Windows administration interfaces when troubleshooting operating system issues.

## 5. Boot Configuration Investigation

The workstation was no longer booting into the expected Windows 11 environment.

The investigation included examining available boot options and accessing the system firmware configuration.

A Windows Boot Manager screen was encountered that presented Windows Server as a boot option.

The boot configuration and available installation media were evaluated to determine the appropriate restoration procedure.

## 6. Storage and Previous Installation Investigation

The workstation's storage environment was investigated to identify potential sources of recoverable user data.

A previous Windows installation directory, `Windows.old`, was identified as a potential recovery source.

The recovery strategy prioritized preserving important files before proceeding with additional operating system installation or disk modifications.

A separate external storage device was available to serve as a recovery destination.

## 7. Diagnostic Findings

| Finding | Technical Significance |
|---|---|
| Windows Server 2025 installed on physical host | Operating system deployment occurred outside the intended virtual machine |
| Northstar virtual disk approximately 2 MiB | Virtual disk was not fully provisioned |
| Windows 11 unavailable during normal boot | Host operating system environment required restoration |
| Windows Boot Manager displayed Windows Server | Boot configuration required investigation |
| Windows.old directory identified | Potential source of previous installation data |

## 8. Troubleshooting Considerations

The investigation reinforced several important systems administration practices:

- Verify the target storage device before initiating operating system installation.
- Confirm that virtual machine storage is correctly provisioned before deployment.
- Distinguish between physical host storage and virtual machine storage.
- Evaluate existing installation directories before performing destructive recovery operations.
- Maintain a separate recovery destination for important files.
- Verify boot configuration before proceeding with operating system restoration.

## 9. Diagnostic Outcome

The investigation established that the incident involved an unintended operating system installation on the physical workstation and an incomplete virtualization configuration.

PowerShell and Command Prompt provided command-line interfaces for investigating the system and supporting the recovery process.

The diagnostic findings informed the subsequent data preservation and Windows 11 restoration procedures.

**Documentation Note:** This report summarizes the diagnostic activities and findings established during the recovery process. Individual command histories, complete terminal transcripts, and detailed disk-layout outputs were not retained. Specific partition identifiers and unverified command outputs are therefore intentionally omitted.
