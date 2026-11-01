# Lessons Learned

## 1. Project Summary

This project involved troubleshooting and recovering a Windows 11 workstation following an unintended Windows Server 2025 installation during the configuration of a cybersecurity virtualization environment.

The recovery process required investigating the host operating system, evaluating virtual disk configuration, examining available storage and previous installation data, preparing Windows 11 installation media, and restoring the workstation.

The incident provided practical experience in Windows systems administration, operating system troubleshooting, data preservation, and recovery planning.

## 2. Root Cause Analysis

The primary cause of the incident was an incorrect operating system installation target.

Windows Server 2025 was installed directly onto the physical workstation rather than inside the intended Oracle VirtualBox virtual machine.

A secondary issue involved the Northstar virtual disk, which was approximately 2 MiB in size and had not been fully provisioned.

These issues highlighted the importance of distinguishing between physical host storage and virtual machine storage before initiating operating system deployments.

## 3. Technical Challenges

Several technical challenges were encountered during the recovery process:

### Operating System Accessibility
The original Windows 11 environment was no longer accessible through the expected boot process.

### Storage Investigation
The workstation's storage configuration required investigation to identify existing installation data and potential recovery sources.

### Virtualization Configuration
The incomplete Northstar virtual disk required additional investigation to understand why the intended virtual machine environment had not been properly established.

### Boot Configuration
Accessing the motherboard firmware and identifying the correct boot device required troubleshooting.

### Data Preservation
Important user data needed to be considered before proceeding with additional operating system installation operations.

## 4. Technical Skills Developed

The recovery process provided hands-on experience in the following areas:

| Technical Area | Experience |
|---|---|
| Windows Administration | Operating system troubleshooting and restoration |
| PowerShell | Disk, partition, and volume investigation |
| Command Prompt | Command-line recovery operations |
| Storage Management | Physical disk and filesystem investigation |
| Data Recovery | Previous installation data investigation and preservation |
| Boot Management | UEFI/BIOS and Windows Boot Manager troubleshooting |
| Virtualization | Oracle VirtualBox configuration investigation |
| Incident Management | Root cause identification and recovery documentation |

## 5. Preventive Measures

Based on the incident, the following preventive measures were identified:

1. Validate the installation target before deploying an operating system.
2. Verify virtual machine configuration and virtual disk capacity before beginning installation.
3. Maintain independent backups of important user data.
4. Confirm virtualization isolation before modifying operating system configurations.
5. Maintain accessible Windows recovery and installation media.
6. Document system configuration changes and recovery procedures.

## 6. Professional Takeaways

This experience reinforced the importance of structured troubleshooting rather than immediately pursuing destructive recovery options.

It demonstrated the value of investigating system configuration, evaluating available recovery sources, and prioritizing data preservation before making additional system changes.

It also reinforced the importance of understanding the relationship between physical hardware, host operating systems, virtual machines, storage devices, and boot configuration.

## 7. Conclusion

The workstation recovery was successfully completed, restoring the computer to a functional Windows 11 environment.

This project represents a practical example of troubleshooting an operating system deployment issue, investigating storage and virtualization configuration, preserving important data, and restoring a workstation.

The experience strengthened foundational systems administration skills and provided a real-world technical case study for continued development in IT support, desktop administration, and systems administration.

**Documentation Note:** This reflection is based on the recovery activities and findings established during the project. Technical outcomes are distinguished from preventive recommendations and lessons learned.
