Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C73BF682
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128058; cv=none; b=a+fKT7UhTlDHJgoumPQg/5zUjlXE+Ri+QJp49NzNPTz6a+QvhjaF33jTeM8TPkg4YDUuc4ps2xZKtqQNvyOT46XxfhpovFyf6oRzd8jD2UfLP+2jyDhsTEsWYgYVK9Gqs/5dxdGDVCcp09R+SsTG57y7YqhAqBpqNPpU20ZaKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128058; c=relaxed/simple;
	bh=6Xcp7GmOW3jpJBK+D0G5wqJj5TwHgxwR+LgHOelxgVw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=mo4RDoo2fm7Yf0SKRHCjUlV1mZYd6TN85H7+KBlSXtbjRxyMEunaPd1/Gs+3Z/DlC/qkisJJrz6sQqRFkc0dpcM9MwPAV8ExCR85MZ3eV+nSJTo6Ed7F5csTTf4usXZBGwYmFdmTHKgdvQdMdPpbK6IIuYlJZsqavXhgbKouOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oL0Edrbg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL0Edrbg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a655cfab5so663710b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775128054; x=1775732854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5YYoniV5Ssc5TtvsKPJbgMJd9HOmOwQ9sgOo8wIBalY=;
        b=oL0EdrbgKnSBFz2kltgg9tdAw53hiziqMBWz2UcYZymBpfHWHxqriI9+VuALndQNJa
         l7ykTpOBdUSRhy7XoZXgwGtfGyXUWutH0mTFiTFP5J/0Bwr37rtzIxwEvWPd0EyjOMm5
         qXEKgkgHyYGeGICBXn1IdNWw94iiGewhlXdHL3TO8fG/lUnkSOgJvs8omvhXg0A2nkft
         8E0ziPxaReMMaxOWYs2pMfemtHCTu7QJOOR7oBo6e9uI/Cl9INMKKykGeleI53CYmtxj
         xWYXyKAKtrmbgpQlOEH6ueeeGu/z1dJ4aBy/WwReBK7SlDb4e7pDKN+qs0xDQbDKtqTO
         fNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775128054; x=1775732854;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YYoniV5Ssc5TtvsKPJbgMJd9HOmOwQ9sgOo8wIBalY=;
        b=BvebElUDHFxdvhMVbvfbUN9Dob3IZL2bQ7r+nQbson3OnP7hJwBShN+o+Fx5ZexxzQ
         kGZ7lA1Q8IuLs9lXsOkLelMMYIwFnd05R1IjINt7/+zudmKE/hvesBXMls7RBr571ON2
         nTVuG2RsUgxDCMXF1J3y5IFrdYFV1Tg702QA5HKkUSlQgzn1wnhWcMgXGANEvolRUolM
         S2XkbihqVYzBFNQC9uNJW05jE4s0zWE/ESMI33wadwhOPRxgsxZkY8m7B0pKHG8ajGQ3
         HXR8YYDENt74XXNdOqDDAtX3uItFHNfpi8lA6g4oXNprRmvAO/vOxS+sw0a6mMS13H33
         B8/w==
X-Forwarded-Encrypted: i=1; AJvYcCVgfYrQxnMKf66FEFGJGM2SE4fQQESjBd1mU4N7tVVuR1K1EdQQAxET8Zl7+ucA1dgLhhtdhmmJQZoVkapC@vger.kernel.org
X-Gm-Message-State: AOJu0YziF9bFAohF0xv3MBgE4idIw+h57BU5CHViUuxoEs6OTx7zvR6h
	d/OT4QaKnFFwO8HFC1G9Mv06LAqMFKZJrXsufNXz2OI8lH43baO4GRDA
X-Gm-Gg: ATEYQzyFfMdGzB3UJB7aWneoM8mXoLydJXSTcMECKMD7nIle1V3sxfcToLD3gtWy/OS
	1rnPbO4NUUaeFAPgrw845o6NjQ0y/KdyPudlp5DhiOQAFfCcl86LWee9MgLIvGko3Gjyc24YHNv
	SIndyNCx5g4txNnCTxKGQmv4amt0ZkYaq9YqJ5MN6gFtG0TKCycO2zkasr/O6Iw+lItDsUDJVDA
	upmVOnTHKh/ZtSZk8TY5+eT+j8kDNW56/E9uXcka1mPzkVqbrQLiFKQDqhAExI0WHcRntVNrmCJ
	F5eJniQP8gz/2+XF3AnFHphnsWz9jUWKKTzTLSmYvk9mLR2Z2WL3dNwsoXvZfgUXIhytdni6jqG
	6xLMrUoJmVOvhrc0v2tQ2LK9MBX5T4z8k09C96eCNkNRYDpO+0/x6bVFlyG+WjjeX7vZUlHhwdu
	jdzSZ2vhT6dZ6/7fEsIj0=
X-Received: by 2002:a05:6a00:451b:b0:82a:65fa:cecf with SMTP id d2e1a72fcca58-82ce88f531bmr7412351b3a.4.1775128054192;
        Thu, 02 Apr 2026 04:07:34 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41225sm2873390b3a.28.2026.04.02.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:07:33 -0700 (PDT)
Message-ID: <69ce4df5.050a0220.a58c.d9d8@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [BUG] BeeGFS 7.4.4 Out-of-Bounds Read in Serialization_deserializeStrAlign4 (S→C)
Date: Thu, 02 Apr 2026 19:07:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh

BeeGFS 7.4.4 Out-of-Bounds Read in Serialization_deserializeStrAlign4 (S→C)

  1. Vulnerability Title

BeeGFS 7.4.4 Client Kernel Module Out-of-Bounds Read in String Deserializer via Corrupted String Length Field

  2. High-Level Overview

This report describes an out-of-bounds read vulnerability in the BeeGFS 7.4.4 client kernel module's serialization/deserialization layer. The `Serialization_deserializeStrAlign4()` function reads a string length value from a network buffer and uses it to calculate a read offset without sufficient bounds checking. When a MITM attacker corrupts the string length field in a BeeGFS response message (e.g., `OpenFileResp`), the deserializer reads beyond the allocated buffer boundary, triggering a kernel page fault (Oops).

This bug was triggered approximately 40 times across multiple fuzzing sessions, confirming it is highly reproducible under MITM mutation.

In a non-KASAN kernel, this vulnerability could lead to information disclosure (reading adjacent kernel memory) or kernel crash (denial of service).

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team.

  Attack Model

The attack direction is Server → Client (S→C) via MITM:

An attacker with network access between a BeeGFS client and its servers intercepts BeeGFS TCP traffic and corrupts the string length field in response messages (e.g., `fileHandleID` length in `OpenFileResp`, or `responseFlags` causing misaligned field parsing in `LookupIntentResp`). The client kernel module's deserializer reads past the buffer boundary.

  3. Affected Product and Version Information

Product: BeeGFS 7.4.4 (client kernel module, compiled from DKMS source)
Affected Component: `client_module/source/common/toolkit/Serialization.c` — `Serialization_deserializeStrAlign4()`
Supporting Components:
- `OpenFileRespMsg_deserializePayload()` — deserializes file open responses
- `LookupIntentRespMsg_deserializePayload()` — deserializes lookup responses
- `__NetMessageFactory_deserializeRaw()` — generic message deserialization
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

`Serialization_deserializeStrAlign4()` is a core BeeGFS deserialization function that reads variable-length strings from network message buffers. The function:

1. Reads a 4-byte length field from the buffer
2. Uses this length to calculate the offset of the string data
3. Returns a pointer to the string within the buffer

The vulnerability is that the function does not adequately validate the length field against the remaining buffer size. When a MITM attacker corrupts the length field to a value larger than the actual buffer, the function calculates an offset that extends beyond the allocated buffer. Subsequent access to the "string" data reads from unmapped KASAN shadow memory (or adjacent kernel memory on a non-KASAN kernel), triggering a page fault.

The bug affects all response messages containing serialized strings, including but not limited to `OpenFileResp`, `LookupIntentResp`, and any message passing file handle IDs, path strings, or metadata strings.

  4.b. Code Flow

---
[VFS operation, e.g., open()]
  FhgfsOpsRemoting_openfile+0x472/0xfd0 [beegfs]
    __MessagingTk_requestResponseWithRRArgsComm+0xd90/0x1b60 [beegfs]
      NetMessageFactory_createFromBuf+0xff/0x160 [beegfs]
        __NetMessageFactory_deserializeRaw+0x1c1/0x350 [beegfs]
          OpenFileRespMsg_deserializePayload+0x116/0x2e0 [beegfs]
            Serialization_deserializeStrAlign4+0x160/0x2a0 [beegfs]
              ← reads length field (corrupted by MITM to large value)
              ← calculates offset: buf_ptr + corrupted_length
              ← accesses memory beyond buffer boundary
              → PAGE FAULT on unmapped address
---

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kernel trace is submitted following syzkaller's common practice of providing the raw crash trace as the primary reproduction evidence:

---
BUG: unable to handle page fault for address: fffff5202064ba05
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: 0000 [#1] SMP KASAN NOPTI

RIP: 0010:Serialization_deserializeStrAlign4+0x160/0x2a0 [beegfs]

Call Trace:
 <TASK>
 OpenFileRespMsg_deserializePayload+0x116/0x2e0 [beegfs]
 __NetMessageFactory_deserializeRaw+0x1c1/0x350 [beegfs]
 NetMessageFactory_createFromBuf+0xff/0x160 [beegfs]
 __MessagingTk_requestResponseWithRRArgsComm+0xd90/0x1b60 [beegfs]
 FhgfsOpsRemoting_openfile+0x472/0xfd0 [beegfs]
 </TASK>
---

Key observations:
- Faulting address: `fffff5202064ba05` — KASAN shadow memory region (beyond allocated buffer)
- Access type: Supervisor read in kernel mode
- Faulting instruction: `Serialization_deserializeStrAlign4+0x160` — the string data access
- Trigger: MITM corruption of string length field in `OpenFileResp`
- ~40 instances reproduced across multiple fuzzing sessions
- Affected messages: OpenFileResp, LookupIntentResp, and any response containing serialized strings

  4.d. Suggested Fix

Add bounds checking to `Serialization_deserializeStrAlign4()` to validate the string length against the remaining buffer size:

---
bool Serialization_deserializeStrAlign4(const char buf, size_t* bufLen,
                                        unsigned outLen, const char* outStr)
{
    unsigned strLen;
    / read length field /
    if (*bufLen < sizeof(unsigned))
        return false;
    strLen = (unsigned)(*buf);

+   / Validate string length against remaining buffer /
+   unsigned alignedLen = BEEGFS_ALIGN(strLen + 1, 4);
+   if (alignedLen > *bufLen - sizeof(unsigned))
+       return false;

    *outLen = strLen;
    outStr = buf + sizeof(unsigned);
    *buf += sizeof(unsigned) + alignedLen;
    *bufLen -= sizeof(unsigned) + alignedLen;
    return true;
}
---

This fix ensures the deserializer never reads beyond the buffer boundary, regardless of the length value received from the network.

  5. Discovery Method and Reproduction

  5.a. Discovery

This vulnerability was discovered using ven0mfuzzer, a custom-designed MITM-based network filesystem fuzzer developed by our team. The fuzzer operates by positioning an AF_PACKET/TCP transparent proxy between a Linux kernel filesystem client (VM-A) and its server (VM-B), then mutating network protocol messages in-flight. We designed ven0mfuzzer specifically for this class of network filesystem vulnerabilities.

The bug was found during Phase 1 (structural mutation), where the fuzzer corrupts message structure fields including string length fields.

Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  5.b. Reproduction Setup

---
VM-A (BeeGFS client) ──BeeGFS──► Host (MITM proxy) ──TCP──► VM-B (BeeGFS servers)
---

Trigger condition: MITM corrupts the string length field in any BeeGFS response message containing serialized strings (e.g., `fileHandleID` in `OpenFileResp`).

Reproduction steps:
1. Build kernel 6.19.0 (commit `44331bd6a610`) with KASAN enabled
2. Install BeeGFS 7.4.4 client DKMS module
3. Start BeeGFS servers (beegfs-mgmtd, beegfs-meta, beegfs-storage) on VM-B
4. Start MITM proxy on host, configured to corrupt string length fields in BeeGFS response packets
5. Mount BeeGFS filesystem in VM-A through the MITM proxy
6. Execute filesystem operations (open, read, stat) on mounted files

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz
