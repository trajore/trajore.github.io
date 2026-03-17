---
layout: post
title: "Using a YubiKey PIV Key for SSH on Windows: The Practical, Working Guide"
date: 2026-03-17
description: "A reliable guide to fixing YubiKey PIV SSH authentication on Windows and VS Code Remote-SSH."
tags: [SSH, YubiKey, Windows, VS Code, Security]
---

# Using a YubiKey PIV Key for SSH on Windows: The Practical, Working Guide

> **TL;DR** 
> If you generate your SSH key on a YubiKey using PIV, do not trust `ssh-keygen -D libykcs11.dll` on Windows to give you the correct public key. It often exports the PIV Attestation key, not your SSH key.
>
> The reliable method is:
>
> ```bash
> openssl x509 -in yourcert.crt -pubkey -noout > pubkey.pem
> ssh-keygen -i -m PKCS8 -f pubkey.pem > id_yubikey.pub
> ```
>
> Then configure Windows so `ssh-agent` can see `libykcs11.dll`, and everything works — including VS Code Remote‑SSH.

This post documents the exact sequence that finally worked after a lot of trial and error, so future‑me (and hopefully others) don’t have to rediscover it the hard way.

---

## Background

I wanted to:

- Generate an SSH key directly on a YubiKey (so the private key never leaves hardware)
- Use that key for SSH on Windows with the native OpenSSH client
- Use the same setup with VS Code Remote‑SSH

I generated the key using the YubiKey PIV workflow, which produces an X.509 certificate (`.crt`) tied to the private key stored in a PIV slot.

At first glance, this should be straightforward:

1.  Export the public key
2.  Put it into `~/.ssh/authorized_keys`
3.  Tell SSH to use `libykcs11.dll`

In practice, Windows makes this far more confusing than it needs to be.

---

## The Core Problem

On Windows, the obvious command:

```powershell
ssh-keygen -D "C:\Program Files\Yubico\Yubico PIV Tool\bin\libykcs11.dll" -e
```

often outputs the wrong public key.

**Typical symptoms:**

- Lots of noise like: `skipping unsupported key type`, `unknown certificate`, `key type failed to fetch key`
- One lone key that looks valid, but is labeled: `Public key for PIV Attestation`
- If you put that key into `authorized_keys`, SSH fails with: `sign_and_send_pubkey: signing failed for RSA "Public key for PIV Attestation" from agent: agent refused operation`

### Why this happens (high‑level)

- Windows OpenSSH enumerates all objects exposed by the PKCS#11 provider.
- It often prefers the PIV Attestation key, which is not meant for SSH authentication.
- Even with RSA‑2048 keys, the wrong object is selected.

Rather than fighting this behavior, the reliable solution is to extract the public key from the certificate directly.

---

## The Correct Way to Extract the SSH Public Key

This is the most important section of the post.

### Prerequisites

- You already have a `.crt` file exported from the YubiKey PIV slot that holds your SSH key.
- You have access to OpenSSL (Linux, macOS, WSL, or OpenSSL for Windows). _(I used WSL, which avoids installing OpenSSL globally on Windows)._

### Step 1: Extract the public key from the certificate

```bash
openssl x509 -in /mnt/c/Users/tanmayrajore/yourcert.crt -pubkey -noout > pubkey.pem
```

This extracts the actual public key embedded in the X.509 certificate. At this point, `pubkey.pem` should look like:

```text
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkq...
-----END PUBLIC KEY-----
```

### Step 2: Convert PEM → OpenSSH format

```bash
ssh-keygen -i -m PKCS8 -f pubkey.pem > id_yubikey.pub
```

Now you have a proper OpenSSH public key:

```text
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ...
```

**This is the key that must go into `~/.ssh/authorized_keys`.**

---

## Installing the Public Key on the Server

On the target machine (Linux example):

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat id_yubikey.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

At this point, the server side is done.

---

## Making YubiKey PIV Work with SSH on Windows

Even with the correct public key, Windows needs some careful setup so `ssh-agent` can see the YubiKey correctly.

### Key Insight

`libykcs11.dll` must be discoverable by the `ssh-agent` service.
That means:

- Adding it to the **System PATH**, not User PATH.
- Restarting the agent after changes.

### Step‑by‑Step: Correct Windows Configuration

#### 1. Add YubiKey PIV Tool to the System PATH

Add the following as the first entry in your **System PATH**:
`C:\Program Files\Yubico\Yubico PIV Tool\bin`

> **Do not add this only to User PATH.** The `ssh-agent` service runs outside your user session.

#### 2. Restart the SSH Agent (Admin Required)

Open an Administrator Command Prompt, then run:

```cmd
net stop ssh-agent && net start ssh-agent
```

This ensures the agent picks up the updated PATH.

#### 3. Load the YubiKey into the SSH Agent

```cmd
ssh-add -s "C:\Program Files\Yubico\Yubico PIV Tool\bin\libykcs11.dll"
```

When prompted:

- Type the PIN **manually**.
- ❌ Do not copy/paste (this can fail silently).

**Verify:**

```cmd
ssh-add -L
```

You should now see your SSH key (not the attestation key).

---

## Using the Setup with VS Code Remote‑SSH

VS Code generally works out of the box once `ssh-agent` is configured, but one setting helps ensure PIN prompts appear reliably.

### Ensure the login terminal is visible

1.  Open File → Settings (`Ctrl` + `,`)
2.  Search for: `remote.SSH.showLoginTerminal`
3.  Set it to `true`

This forces VS Code to show the interactive terminal needed for PIN entry and YubiKey touch confirmation.

### Connecting in VS Code

1.  Open Command Palette (`Ctrl` + `Shift` + `P`)
2.  Select **Remote‑SSH: Connect to Host…**
3.  Choose your configured host

A new VS Code window opens, and you should be prompted for your YubiKey PIN and a touch confirmation.

At this point, SSH authentication is fully hardware-backed.

---

## Final Notes & Lessons Learned

- Generating keys on the YubiKey is a good workflow.
- Windows OpenSSH PKCS#11 enumeration is unreliable.
- Extracting the public key from the `.crt` is the most dependable method.
- System PATH vs User PATH matters more than most docs admit.

I may dive deeper into why `ssh-keygen -D libykcs11.dll` behaves this way on Windows in a future post, but for now — this workflow works consistently.

---

## Why I Wanted This Setup

Part of the reason I wanted to get this working was simply to experiment with a setup that felt cleaner and more deliberate than keeping long-lived SSH keys on disk. I wanted my SSH sessions to be a little more secure, and I wanted the private key to live in the place that made the most sense for it: on hardware I physically carry, rather than as a file sitting on a machine.

The YubiKey PIV route turned out to be more awkward on Windows than it should be, but once the pieces are in the right place, the workflow is actually pretty nice. The key stays on the token, authentication works with the normal OpenSSH client, and VS Code Remote-SSH can use the same setup without needing a separate workaround.

If nothing else, this was a useful experiment in making everyday SSH usage a bit more intentional and a bit harder to get wrong.
