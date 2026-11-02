# Windows 11 System Recovery & Data Restoration

## Project Overview

This project documents a hands-on operating system recovery and data restoration scenario involving an unintended deployment of Windows Server 2025 on a physical workstation.

During the configuration of a cybersecurity virtualization environment using Oracle VirtualBox, Windows Server was inadvertently installed directly onto the host machine rather than within the intended virtual machine environment.

The incident required system-level troubleshooting, storage configuration analysis, recovery media preparation, data preservation, and restoration of the original Windows 11 operating system.

This project demonstrates practical experience with Windows operating system administration, disk management, boot configuration, data recovery procedures, and technical problem-solving.

---

## Incident Summary

**Incident Type:** Operating System Misconfiguration / Workstation Recovery

**Affected System:** Custom-built desktop workstation

**Original Operating System:** Windows 11 Home

**Unintended Installation:** Windows Server 2025

**Virtualization Platform:** Oracle VirtualBox

**Processor:** Intel Core i9-13900K

**Memory:** 32 GB RAM

**Primary Objective:** Recover the workstation, preserve important user data, and restore the intended Windows 11 operating environment.

---

## Technical Objectives

- Diagnose an unintended operating system installation on a physical workstation.
- Investigate disk layouts, partitions, volumes, and existing operating system directories.
- Identify potentially recoverable data from previous Windows installation files.
- Establish a separate backup destination for recovered data.
- Prepare bootable Windows 11 installation media.
- Restore the workstation to its intended operating system environment.
- Document troubleshooting procedures and recovery considerations.

---

## Technical Implementation

### 1. System Diagnostics and Environment Assessment

Performed initial troubleshooting to identify the cause of the operating system misconfiguration and assess the workstation's current state.

Diagnostic activities included:

- Reviewing the system boot environment.
- Investigating available storage devices and partition configurations.
- Identifying existing Windows installation directories.
- Evaluating the condition of the virtualization environment.
- Determining the appropriate recovery approach while prioritizing data preservation.

### 2. Storage and Data Recovery Investigation

Investigated the workstation's storage configuration to distinguish between the physical host installation and the intended virtual machine environment.

Identified that the Northstar virtual disk had not been fully provisioned, with the virtual disk file showing an unexpectedly small capacity of approximately 2 MiB.

Investigated the presence of the `Windows.old` directory as a potential source of recoverable user data.

Recovery considerations included:

- Identifying existing user data directories.
- Evaluating available backup storage.
- Preserving recoverable files before performing additional installation operations.
- Separating recovery storage from the operating system installation target.

### 3. Windows 11 Recovery Media Preparation

Prepared Windows 11 installation media using a separate computer and USB storage device.

The recovery process involved:

- Obtaining the Windows 11 ISO installation image.
- Preparing USB installation media.
- Accessing the system firmware configuration.
- Investigating boot device selection and Windows Boot Manager behavior.
- Preparing the workstation for operating system restoration.

### 4. Operating System Restoration

Performed the Windows 11 restoration process to return the workstation to its intended operating environment.

The restoration effort focused on:

- Reestablishing a functional Windows 11 environment.
- Verifying operating system accessibility.
- Assessing system stability following restoration.
- Reestablishing the foundation for future virtualization lab configuration.

---

## Technologies and Tools

| Technology | Application |
|---|---|
| Windows 11 | Host operating system restoration |
| Windows Server 2025 | Unintended operating system installation |
| Oracle VirtualBox | Virtualization environment |
| Windows 11 ISO | Operating system installation media |
| Windows.old | Previous installation data investigation |
| UEFI / BIOS | Firmware and boot configuration |
| PowerShell / Windows Command Line | System diagnostics and administration |
| USB Recovery Media | Operating system restoration |

---

## Skills Demonstrated

- Windows desktop administration
- Operating system troubleshooting
- Disk and partition management
- Data preservation and recovery planning
- Boot configuration and firmware navigation
- Windows installation media preparation
- Virtualization troubleshooting
- Incident documentation
- Technical problem-solving
- Risk-aware system recovery

---

## Lessons Learned

This incident reinforced several important systems administration practices:

1. **Virtualization Isolation:** Verify virtual machine storage configuration and installation targets before deploying an operating system.
2. **Data Protection:** Maintain independent backups before modifying disk partitions or performing operating system installations.
3. **System Diagnostics:** Understand the relationship between physical storage devices, partitions, boot configuration, and virtual disks.
4. **Recovery Planning:** Maintain access to bootable recovery media and a separate backup destination.
5. **Change Management:** Validate configuration changes before applying them to production or host environments.

---

## Project Outcome

This project documents a real-world workstation recovery scenario involving operating system misconfiguration, storage investigation, data preservation, and Windows restoration.

It demonstrates the practical troubleshooting methodology required to diagnose system-level issues, evaluate recovery options, and restore a workstation to a functional operating environment.

---

## Repository Structure

```text
windows-11-system-recovery/
│
├── README.md
│
├── documentation/
│   ├── incident-overview.md
│   ├── system-diagnostics.md
│   ├── data-recovery.md
│   ├── post-recovery-verification.md
│   ├── windows-restoration.md
│   └── lessons-learned.md
│
├── screenshots/
│   ├── system-diagnostics/
│   ├── data-recovery/
│   └── restoration/
│
└── scripts/
    └── recovery-verification.ps1
```

---

## Disclaimer

This repository documents a personal hands-on technical recovery project. Screenshots and supporting documentation should be sanitized to exclude personal information, credentials, product keys, and sensitive system identifiers.

The project is intended to demonstrate practical IT troubleshooting and systems administration experience.
