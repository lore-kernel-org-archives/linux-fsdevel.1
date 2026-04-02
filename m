Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B03C0636
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128052; cv=none; b=K2eSM582MTuBJUQftPNMfB3yZ1JvecqmF9N7tA0GVNCqQ/y1TiLpP27MF24Yy8R89jKDTSpU0uQwfgi6JMPKCBcsyPJvYHeSwHxFNlxd8CP39j8FwQD/gYBlhKxZ54vNJmPnGv3AIJ7kTuXFhB9SCZIa1Sz76HgMOCiZ3tmAHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128052; c=relaxed/simple;
	bh=bhBJbkY3Nk05hmcy8a58k0kfXc5yFmpj4WfNFtpZoLo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=rFNWegujYkXDtirYrUz65MqVUL8YbbAVHJ0OTHnLVh3HUbaDeXQo4+cuXIs5d7IgSUVVkZQbH/QpYoh0xvG3sdPvjo4lGpxMHxRdr8O5ca7rpFKXDCnGNGFohmwOZPB49d36ofvhZkky6EvvOgJBq9fNKZBWBMSSJ0/I5SS8ioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx+Se9TD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx+Se9TD"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c757a9251faso261995a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775128048; x=1775732848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgw9kFyJ4DuvMCa0cxEPCltwLx3hIHnbJ//wu8pLwa0=;
        b=Xx+Se9TDIYrz0/XjXlVi+67LJLIcxT4St8U/IR98AE0KMP0KlnDUmYaFSZ2/lUj5ym
         5CquxlyysrcG8KXiW+cmAPW4nvOaHsKDuTz/ZOrv+oFKuN0CGzYSRzfIv4Icrzn5Qf8v
         X60Q13JFY5aRXSZFtaUcajhqe5GiltuvJ4Kx2K4JvjrmEY/fnvYluZrJy7eJJv1cXzaC
         HBLL1OMHUtv+WG7zTYcu3bDuk59JWD4rOTpzjZAzTd580HLKQixipdxkZlDYgJ5mFX+d
         LbyFQ/paIkp9z23a6vrZtn7R80k7h3lkS0fkNnQluvmzGdJXow1a0KCdMTHH/wTAEP60
         rm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775128048; x=1775732848;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgw9kFyJ4DuvMCa0cxEPCltwLx3hIHnbJ//wu8pLwa0=;
        b=PuLkQgGHA0gfBGKc3aIZQ0XkFRXyi2RZddXWKeanU9emp5lj5F7Xp/IxOuiiEutZoA
         H3sfb252gx8vF0GHL8rUEG/dIApgjkoh4b2B8ayHKl0iIWL1WjA6MYMd8CNMr9rtkEMe
         iBOwc1ljT2ASnxDRVK5DRWFmzc1xO0H2kukjXGkJo9kEa7N62zy6KMrm3nfUffPqfe2A
         9p6C5We208bI6/TK8vilK3WJeEOdp9CAiVFb07/3SsE+hHppCwlcRdqNUP2HUBQ4qWpG
         AJX05MHyybMwnNPuQIj7MW3tE78+ncLcQi0mJWBNiiBJs5g+YC0yLL70qJmJan3LZudQ
         2mVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw28vsqJe/8wCOJYXDBHqTDbXiqHx/dee0+o3t4QsrbKB6T9w44E7szhJKztxfbjOFCSQXyKG7Xq0AVoJt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyp95LGark6lzNDFNVIyrIATIbLveQFJoeIY+000UXvcperwto
	oXhqppfVoIa1rHnp1lDvEcBKosHmQN2sQCGqUmB7S7QKpa5d/f/5ZzyUuNP9daTSylF/iQ==
X-Gm-Gg: AeBDiesR3s4noZg2BJCJBzHWowmzBQoKXxW2/QH2lecAjNux90BtxJeSvh6Rc2PRq6F
	+hZ7cSR74pTaEQfWw5ld1KsK5Gkz40KicJyDD1V4mj2XSS9FYj+CMaTUraFjx7wvrmfeUDz6q6p
	LT9Slbylh4NmJQWKv8jfeWVhrQxB+nbuoxvxhrTb0qKS9sCzyIJemgDO5ymjNKFPk8MWWHPe0fw
	CdFhsJ5Jo/PHynDgt2yrZMRKFL4eCXEUE9IKHpYlOpvUqehUNJyuWmKkSjuoDdA7NsUMss4jSsH
	7aotTLtBHVl3jOCLpteaqesUB9wxluz/E8x/jhSMTwf8g4nHGIA2Pqzf95RH3BaWG3EdnJ//j+f
	PXm80A062Pb2pbnu6+9l9j9GS/Q4SwdSXPYwWT7BY2/HVkj0l6/Y4Q2s/evdtTMlF41zTizk1aA
	+cYn5cKQWnMSVbWY/fnh8=
X-Received: by 2002:a17:903:1c9:b0:2b2:539b:d2a0 with SMTP id d9443c01a7336-2b269cfe5d5mr72595485ad.45.1775128047658;
        Thu, 02 Apr 2026 04:07:27 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747a7115sm24492965ad.36.2026.04.02.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:07:27 -0700 (PDT)
Message-ID: <69ce4def.170a0220.9e8ab.803e@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [BUG] BeeGFS 7.4.4 Use-After-Free in FhgfsInode_referenceHandle via Message Type Corruption (S→C)
Date: Thu, 02 Apr 2026 19:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh

BeeGFS 7.4.4 Use-After-Free in FhgfsInode_referenceHandle via Message Type Corruption (S→C)

  1. Vulnerability Title

BeeGFS 7.4.4 Client Kernel Module Use-After-Free in FhgfsInode_referenceHandle via MITM Message Type Corruption

  2. High-Level Overview

This report describes a critical use-after-free vulnerability in the BeeGFS 7.4.4 client kernel module. A MITM attacker corrupts the `msgType` field (2 bytes) in a BeeGFS reply header, changing the expected response type (e.g., LookupIntentResp type 2060) to an invalid value (e.g., 0). The client detects the type mismatch, disconnects from the meta server, and triggers cleanup of file handles and associated state. However, the `beegfs_Flusher` kernel thread still holds a reference to a file handle via `FhgfsInode_referenceHandle`. When the Flusher thread attempts to acquire the mutex on the already-freed handle object, KASAN detects a slab-use-after-free.

This is a high-severity vulnerability. A single 2-byte corruption in the network triggers a complex chain: type mismatch → disconnect → cleanup race → use-after-free. This class of vulnerability is potentially leading to kernel memory corruption or denial of service.

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team.

  Attack Model

The attack direction is Server → Client (S→C) via MITM:

An attacker with network access between a BeeGFS client and its meta server intercepts BeeGFS TCP traffic and corrupts the 2-byte `msgType` field at offset 16 in the 40-byte BeeGFS NetMessage header. The client kernel module processes the corrupted response, triggers a disconnect, and enters a race condition between cleanup and the Flusher thread, resulting in a use-after-free.

  3. Affected Product and Version Information

Product: BeeGFS 7.4.4 (client kernel module, compiled from DKMS source)
Affected Component: `client_module/source/common/storage/FhgfsInode.c` — `FhgfsInode_referenceHandle()`
Supporting Components:
- `client_module/source/common/net/message/NetMessageFactory.c` — message type dispatch
- `client_module/source/common/net/MessagingTk.c` — disconnect logic on type mismatch
- `client_module/source/os/Flusher.c` — beegfs_Flusher kernel thread
Server Components: BeeGFS 7.4.4 official packages (beegfs-mgmtd, beegfs-meta, beegfs-storage)

  Tested Versions (confirmed vulnerable)
- BeeGFS 7.4.4 client DKMS module on Linux kernel 6.19.0 (commit `44331bd6a610`, gcc 11.4.0)
- Kernel built with KASAN enabled

  Affected Distributions and Products

 |  Vendor / Product  |  Notes  | 
 | --- | --- | 
 |  HPC clusters using BeeGFS  |  Primary user base; BeeGFS is widely deployed in research and enterprise HPC storage  | 
 |  Any Linux distribution with BeeGFS 7.4.4 DKMS  |  BeeGFS is a third-party kernel module (not in mainline Linux). Affects any distro where BeeGFS 7.4.4 DKMS module is installed.  | 
 |  ThinkParQ official packages  |  Official BeeGFS packages from thinkparq.com  | 

  4. Root Cause Analysis

  4.a. Detailed Description

The BeeGFS client uses a request-response RPC mechanism over TCP. Each response includes a 40-byte NetMessage header containing a `msgType` field (2 bytes at offset 16) that identifies the response type. The client validates that the received `msgType` matches the expected response type.

When a MITM attacker corrupts `msgType` to an invalid value:

1. Type mismatch detection: The client's `__MessagingTk_requestResponseWithRRArgsComm()` receives a response with an unexpected `msgType`. It logs: `"Received invalid response type: 0; expected: 2060"`.

2. Disconnect: The client disconnects from the meta server: `"Disconnecting: beegfs-meta vm-b [ID: 1] (10.0.0.2:8005)"`.

3. Cleanup: The disconnect triggers cleanup of file handles and associated inode state. File handle objects are freed.

4. Race with Flusher thread: The `beegfs_Flusher` kernel thread runs periodically to flush dirty pages. It holds references to file handles via `FhgfsInode_referenceHandle()`. After the disconnect cleanup frees the handle objects, the Flusher thread attempts to acquire the mutex on the freed handle → use-after-free.

The root cause is a missing synchronization between the disconnect cleanup path and the Flusher thread. The cleanup frees handle objects without ensuring that the Flusher has released its references.

  4.b. Code Flow

---
[Thread 1: RPC response handling]
  __MessagingTk_requestResponseWithRRArgsComm()
    ← receives response with corrupted msgType (0 instead of 2060)
    → logs "Received invalid response type: 0; expected: 2060"
    → initiates disconnect from beegfs-meta
    → cleanup: frees file handle objects (including mutex embedded in handle)

[Thread 2: beegfs_Flusher kernel thread]  (concurrent)
  __Thread_runStatic+0x3f/0xb0 [beegfs]
    FhgfsInode_referenceHandle+0x1c3/0x13b0 [beegfs]
      __mutex_lock+0x1ad3/0x2330
        ← attempts to lock mutex in FREED handle object
        → KASAN: slab-use-after-free!
---

MITM mutation detail:
- Target: `msgType` field at offset 16 in the 40-byte BeeGFS NetMessage header
- Corruption: 2-byte change (e.g., type 2060 → 0)
- Impact chain: type mismatch → disconnect → cleanup → Flusher thread UAF

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kernel trace is submitted following syzkaller's common practice of providing the raw crash trace as the primary reproduction evidence:

---
BUG: KASAN: slab-use-after-free in __mutex_lock+0x1ad3/0x2330
Read of size 4 at addr ffff888003ddb874 by task beegfs_Flusher/789

Call Trace:
 <TASK>
 __mutex_lock+0x1ad3/0x2330
 FhgfsInode_referenceHandle+0x1c3/0x13b0 [beegfs]
 __Thread_runStatic+0x3f/0xb0 [beegfs]
 </TASK>

Preceding kernel log messages:
  beegfs: Messaging (RPC): Received invalid response type: 0; expected: 2060.
    Disconnecting: beegfs-meta vm-b [ID: 1] (10.0.0.2:8005)
  beegfs: Remoting (write file): Error storage targetID: 1
---

Key observations:
- Access type: Read of size 4 — reading the mutex state field from a freed slab object
- Freed object address: `ffff888003ddb874`
- Accessing task: `beegfs_Flusher/789` — the BeeGFS background flusher thread
- Trigger: A single 2-byte corruption in `msgType` field triggers the entire chain
- Reproduced: 2 times during Phase 1 (structural mutation) fuzzing

  4.d. Suggested Fix

Add proper synchronization between the disconnect cleanup path and the Flusher thread:

Option 1: Reference counting on file handle objects — prevent cleanup from freeing handles while the Flusher still holds references:

---
/ In disconnect cleanup: /
void __cleanup_file_handles(FhgfsInode* inode) {
    / Wait for Flusher to release all references before freeing /
    wait_event_timeout(handle->release_wait,
        atomic_read(&handle->refcount) == 0,
        msecs_to_jiffies(5000));
    / Now safe to free /
    kfree(handle);
}
---

Option 2: Mark handles as invalid before freeing, and check validity in the Flusher:

---
/ In FhgfsInode_referenceHandle: /
if (handle->invalidated) {
    / Handle was freed by disconnect — skip /
    return NULL;
}
---

  5. Discovery Method and Reproduction

  5.a. Discovery

This vulnerability was discovered using ven0mfuzzer, a custom-designed MITM-based network filesystem fuzzer developed by our team. The fuzzer operates by positioning an AF_PACKET/TCP transparent proxy between a Linux kernel filesystem client (VM-A) and its server (VM-B), then mutating network protocol messages in-flight. We designed ven0mfuzzer specifically for this class of network filesystem vulnerabilities.

The bug was found during Phase 1 (structural mutation), where the fuzzer targets message header fields including the `msgType` field.

Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  5.b. Reproduction Setup

---
VM-A (BeeGFS client) ──BeeGFS──► Host (MITM proxy) ──TCP──► VM-B (BeeGFS servers)
---

Trigger condition: MITM corrupts the `msgType` field (2 bytes at offset 16 in the BeeGFS NetMessage header) in a reply from the meta server to the client. The corrupted type must differ from the expected type to trigger the disconnect-cleanup-UAF chain.

Reproduction steps:
1. Build kernel 6.19.0 (commit `44331bd6a610`) with KASAN enabled
2. Install BeeGFS 7.4.4 client DKMS module
3. Start BeeGFS servers on VM-B
4. Start MITM proxy on host, configured to corrupt `msgType` field in BeeGFS response headers
5. Mount BeeGFS filesystem in VM-A through the MITM proxy
6. Execute filesystem operations that involve the Flusher thread (e.g., write data to files, then wait for background flush)

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz
