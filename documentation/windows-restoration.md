# Windows 11 Operating System Restoration

## 1. Restoration Overview

Following the identification of the unintended Windows Server 2025 installation and investigation of available recovery data, the next phase involved restoring the workstation to its intended Windows 11 operating environment.

The restoration process required preparing Windows 11 installation media, investigating firmware boot configuration, and initiating the operating system restoration procedure.

The primary objective was to reestablish a functional Windows 11 environment while preserving previously recovered user data.

## 2. Windows 11 Installation Media Preparation

A separate computer was used to obtain the Windows 11 ISO installation image and prepare USB installation media.

The preparation process involved:

- Downloading the official Windows 11 ISO.
- Preparing a USB storage device for installation media.
- Verifying that the installation media was available for use.
- Connecting the prepared USB device to the affected workstation.

Using separate installation media provided an independent recovery path without relying on the inaccessible operating system.

## 3. Firmware and Boot Configuration

The workstation's firmware configuration was accessed to investigate boot behavior and select the appropriate startup device.

The investigation involved:

- Accessing the motherboard UEFI/BIOS interface.
- Reviewing available boot devices.
- Investigating Windows Boot Manager behavior.
- Identifying the prepared Windows 11 installation USB as the intended recovery media.

These steps were necessary to initiate the restoration process independently of the existing Windows Server installation.

## 4. Operating System Restoration

Windows 11 installation media was used to restore the workstation to its intended operating system environment.

The restoration process focused on:

- Initiating the Windows 11 installation environment.
- Selecting the appropriate installation target.
- Completing the operating system restoration.
- Reestablishing access to the Windows desktop.
- Confirming that the workstation could operate in its intended Windows 11 environment.

## 5. Post-Restoration Verification

Following restoration, the workstation successfully returned to a functional Windows 11 environment.

Post-restoration considerations included:

- Confirming successful operating system startup.
- Verifying access to the Windows desktop.
- Confirming normal workstation functionality.
- Assessing the availability of recovered user data.
- Establishing a stable environment for future virtualization activities.

## 6. Restoration Outcome

The workstation was successfully restored to Windows 11, resolving the operating system disruption caused by the unintended Windows Server installation.

This phase completed the primary recovery objective and reestablished the workstation as the intended host environment for future virtualization and cybersecurity lab activities.

## 7. Technical Skills Demonstrated

- Windows 11 installation and restoration
- Bootable installation media preparation
- UEFI/BIOS configuration
- Boot device troubleshooting
- Windows Boot Manager investigation
- Operating system deployment
- Post-installation verification
- Workstation recovery

## 8. Lessons Learned

The restoration process reinforced several important systems administration practices:

- Maintain independent operating system installation media.
- Understand firmware boot configuration and boot device selection.
- Verify installation targets before proceeding with operating system deployment.
- Preserve recoverable user data before modifying the operating system.
- Perform post-restoration checks to confirm system functionality.

**Documentation Note:** This report documents the restoration workflow and confirmed outcome. Exact installation screens, partition selections, firmware settings, and verification command outputs were not retained and are intentionally omitted.
