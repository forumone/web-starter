---
title: Troubleshooting
---

Occasionally some issues may occur that prevent you from loading the
virtual machine. Below are some common issues that others have
experienced.

### General

If the virtual machine does not boot up and you get a message saying
there was a timeout, try launching the VM through the Virtualbox
interface to get more detailed information.

### Macintosh machines

-   If you experience errors when sharing the folder over NFS you may
    need to enable File Sharing in System Preferences -&gt; Sharing
-   If you receive an error about an invalid export you may need to
    manually delete /etc/exports file
-   If you've updated to Mavericks and Virtualbox is no longer working,
    try the following command:
    `sudo /Library/StartupItems/VirtualBox/VirtualBox restart`
-   If you are prompted to enter your password when SSHing from the VM
    ensure your SSH private key is in the keychain by running
    `ssh-add -K ~/.ssh/id_rsa` from your machine

### Linux machines

-   If you experience errors when sharing the folder over NFS you may
    need to install the appropriate NFS packages, on Ubuntu you will
    need to run `sudo apt-get install nfs-kernel-server`

### Windows machines

-   Virtualbox requires the Intel Virtualization Technology for Directed
    I/O (VT-d) be enabled, if you receive a message saying that the VM
    requires a 64 bit processor and you only have an i686 processor this
    may be the cause
-   Virtualbox may trigger a Windows Firewall popup to allow ports to be
    shared
-   if your ssh key information does not correctly forward, you can copy
    your ssh private key to \~/.ssh and chmod it 700

### NFS

-   PHP reports that NFS shares are not writeable even though they are.
    As a result certain functionality, such as Drupal's CSS and JS
    aggregation, report as being unavailable.
