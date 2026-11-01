# Incident Overview: Windows 11 Workstation Recovery

## Incident Classification
- **Incident:** Unintended Operating System Installation
- **System:** Custom-built desktop workstation
- **Original Operating System:** Windows 11 Home
- **Unintended Operating System:** Windows Server 2025
- **Virtualization Platform:** Oracle VirtualBox
- **Incident Category:** Workstation Recovery / Operating System Misconfiguration

## Background

While configuring a cybersecurity virtual lab environment using Oracle VirtualBox, an operating system installation was inadvertently initiated on the physical host workstation rather than within the intended virtual machine.

As a result, Windows Server 2025 was installed outside the isolated virtualization environment, disrupting access to the original Windows 11 operating environment.

## Business and Technical Impact

The incident resulted in:
- Loss of normal access to the original Windows 11 environment.
- Disruption of the workstation's intended configuration.
- Uncertainty regarding the accessibility of existing user data.
- Interruption of the planned cybersecurity lab deployment.

## Recovery Objectives

1. Assess the workstation's current operating system and storage configuration.
2. Identify existing Windows installation data and potential recovery sources.
3. Preserve important user files before additional system modifications.
4. Prepare Windows 11 installation media.
5. Restore the workstation to its intended operating environment.
6. Document the recovery process and technical lessons learned.

## Recovery Strategy

The recovery approach prioritized data preservation and system integrity before proceeding with operating system restoration.

The process involved investigating storage devices, evaluating previous Windows installation files, preparing external recovery storage, and creating Windows 11 installation media.

## Project Scope

This documentation focuses on the investigation, troubleshooting, data recovery considerations, operating system restoration, and lessons learned from the incident.
