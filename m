Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A23783B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733466; cv=none; b=B7q5j05scmIE+eY15YAGdUs5xKPG2iqFEfjZzwo22Enz2dS1BwDOliOFmRhdLV1FY17fmlz7yC+/cxuj9p9HGTbgvLuVVxqAvcjEbbD/xcdk309SVfbptnsb9aXJW7pV4bshE0XYrf1vznFCcNAHmASGfm1k5jkdtTk44X6GAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733466; c=relaxed/simple;
	bh=F2oBa7aj08WRmmdx4CITKCkwSJgoUL1aqkWZdc1NHdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csUH8fy2T5LaZYN7dJsAW/H20YAzvFD2mmb2WCDwy9x7O+TIWYN868CxtIAvEvnKep9oIIWoy6Asv12bEv0VJ5Lq2zU8EjxIKY/pOPrxzqV16CxqXV2QyZX81J9pht2OW9drZ/SCNZJfiLYzhteUkHgV/3Fch6MMvcH3sOLZRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsD3svu3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsD3svu3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8dd17d7308bso325606d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733464; x=1782338264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVwNjFuEyUh+SBAQwHYwKAtynKLgHX4Q8K2y3LWjGNc=;
        b=NsD3svu3TlVUgA7qRgHdO6ElogDzBcTsYfblAWxVyFYUVG4imYIR5ojMjpg4uD3Pwn
         Wp4dkD6vASIP/FgQl2Jkpr9wUnsNfOKVp+QjqgB0lnj2Dzx98O87Z4r3odePAJX2pv+n
         NBLnWWmFkX4Xyf6RWGOWhUkqpgbEIgIz2KBCOIshMj2mW/x6R7p3eCmoN6wGJU29ndUF
         KTNYj3hii1WmaMXcU4xfPrUqnH6PNMnOyy8NRGbehacXpkQxWUcN+bFtbj4touku7P+G
         4fpGkDuwLKIwgpXKMLaKYe5PDCusuuBz0F83/aa9xp4tn71YqAvNKOS263AY1wqMqJC7
         WwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733464; x=1782338264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVwNjFuEyUh+SBAQwHYwKAtynKLgHX4Q8K2y3LWjGNc=;
        b=BzbTbdhhi/71W8sQJcptynQ0JlyOfKIavmbaTMrao5SSzUfcLC1rN1d31e00+ZkgA9
         WDu6H5uALzRFpdsrUv6VLd6hns+OhCJJm2i7AwAOpJuIeaUk2eHvGpwBAihwMNmBzQYY
         NTmJnCgTO2VFblLLyVAJL1pA9YV0YNa0jeTr9Ex+nfIKBebny/5eQRtN6GOrK5D26/5y
         LjnrW6qSFEyjDo5+cgTNutHlcPfM2OBUmETcL2Um3CJDXK7ipWGDoq9yKFpd3rS+h6Gm
         2Wf9cXSI8OdzL3gkJ9TrakdVckueJ1GlZ2yoa4jaaIE6BYfqvOs75MLEwL9KA2pMlbrC
         XwRQ==
X-Gm-Message-State: AOJu0Ywgicc5ewgz8vJ4CU9QRYh7uc5LJd1KcVLpjV8i8j4WghyQ0Gmz
	5RvbE/WrVWYwjpMCdQQthwddPLY6kF5qli3tF8kBhpElCxII7DAsusoLtk99o9SQ7ug=
X-Gm-Gg: AfdE7clXEYzsz7k6fpWnssyoKW2ArU/CFwBouacIDlJAyFEcoNUogsIPL41+NhLuurW
	Y7v64e/2mzLHGUIvb6YgHEvn7uYUk4aBaDgmsNjQrSSy4XeERac3lS13tuV30MaGkqF9t24QUZB
	O1jKFEUR08A0n8PPCPAlZtRmkrHj4svb9V4LYSyqF4x638Qbb78upTiDpoqNSGjQ8bInUMm8G7W
	/ruXTwzc8wJRDmQNcOqfZieaxDcZy6sBq0DhakdoZhEBXQpgl0rXYILxks1mVwTF0am+BTX2FGQ
	ehbbamRQ5M9yMhuWr0GJ10ByDWaaAdsXVo6ixFcH39F6nZMjUrHtJejB6pkjvDJfpiSSjCCwZ6L
	KPCHNM0fuNfbQNh11Xst186+aOyP57zSNaWLfUQKFeORfpJV8kpEOMhXHV6BA9zQhhRVTZwrxrJ
	k2KEPUuRlcvAyOue3VUTTeHozipEnbCGpfSPVazOWeClpPhWO/B3lVbQKOebCmqaQTVPKwFt5a2
	N1D4RKFkwyEaVrMEN0li11Xrk5tdm19
X-Received: by 2002:a05:6214:187:b0:8ce:a033:eef9 with SMTP id 6a1803df08f44-8db5ca19211mr80317266d6.26.1781733464294;
        Wed, 17 Jun 2026 14:57:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8dcf3cf5552sm4252196d6.39.2026.06.17.14.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:57:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] minix: avoid overflow in bitmap block count calculation
Date: Wed, 17 Jun 2026 17:57:40 -0400
Message-ID: <20260617215740.1116778-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

minix_check_superblock() uses minix_blocks_needed() to verify that the
on-disk imap and zmap block counts are large enough for the advertised
inode and zone counts.

The helper currently performs DIV_ROUND_UP() in unsigned int arithmetic.
A Minix v3 image can set s_ninodes or s_zones near UINT_MAX so the
addition inside DIV_ROUND_UP() wraps to zero. That makes a zero imap/zmap
block count look valid, after which minix_fill_super() can dereference
s_imap[0] or s_zmap[0] even though no bitmap buffers were allocated.

Impact: mounting a crafted Minix v3 image whose s_ninodes or s_zones is
near UINT_MAX makes minix_check_superblock() accept a zero bitmap-block
count and minix_fill_super() dereference s_imap[0]/s_zmap[0], panicking
the kernel.

Calculate the required bitmap block count with 64-bit arithmetic. Return it
as unsigned long to match the superblock fields and local comparison.

Fixes: 8c97a6ddc956 ("minix: Add required sanity checking to minix_check_superblock()")
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Testing: integer overflow (no sanitizer); the oracle is the downstream
NULL/ZERO_SIZE_PTR dereference crash.

Reproduction (UML mount, same crafted image, before/after): a Minix v3
image is crafted with s_ninodes near UINT_MAX so DIV_ROUND_UP(s_ninodes,
blocksize * 8) wraps to zero, then mounted from /dev/ubda by a one-line
init.
  stock:   RIP: minix_fill_super+0x3f6/0x5c3 ; Kernel panic - not syncing:
           Kernel mode fault at addr 0x10 (ZERO_SIZE_PTR deref of
           s_imap[0]); UML exit code 134.
  patched: "MINIX-fs: file system does not have enough imap blocks
           allocated. Refusing to mount." / "bad superblock"; mount
           fails cleanly, no crash.
A KUnit case additionally asserts minix_blocks_needed() no longer wraps
for near-UINT_MAX inputs; both run on stock and patched.

Conditions: CONFIG_MINIX_FS=y and an attacker-supplied Minix image is
mounted (CAP_SYS_ADMIN in the mounting namespace, or a removable-media
automount path). v3 only: s_ninodes/s_zones are 32-bit; the v1/v2 16-bit
fields cannot reach the wrap.

Mitigations: do not mount untrusted Minix images; most distributions do
not enable CONFIG_MINIX_FS. No sysctl toggle.

Harness (init script, crafted image, KUnit) available on request.

 fs/minix/minix.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b58252..8dc83f80bd768 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -95,9 +95,10 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned long minix_blocks_needed(unsigned long bits,
+						unsigned int blocksize)
 {
-	return DIV_ROUND_UP(bits, blocksize * 8);
+	return DIV_ROUND_UP_ULL(bits, blocksize * 8);
 }
 
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
-- 
2.53.0

