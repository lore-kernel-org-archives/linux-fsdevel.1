Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44584519A2;
	Fri, 16 Oct 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142133; cv=none; b=E6Uibo8XP1a2xUQSVQfit3YdWrlSQ1c6mW6G0WfN8fppp/HNgDj96KFFiOaXEk5057vVGP1rynrFmrfJjn59AZ43STVvorYQ67smxfR7S9zANpS+e78YjDQedtNYI99uio1bhDJKlIiG1qP+CoaKpLy7T7Dm0vWvGBMoWjbTrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142133; c=relaxed/simple;
	bh=jFxdjNeoRfG8ftOzralff1RCNqbjsg7zyR8emO804GA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=JmGS3PsN9kDG9+s102RzcIR4mDG1oxEbt4eT1wIadBsr32YYknRz1zzIOua9BJDGFwoq1Q66qnONamMtFDTeJk+gDVUL2SdfHiDUr+l79vEPr0Q/YQVyYFaRNEmta4w934WkPGt1R11AegDPSdGKLqT2oksxxYFaMpcy9pxqaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ssCfJXf8; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ssCfJXf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792142120; bh=e7pZdn+FduIIviMFIGwAG6oP+v++QMQOhZst7W5M4gY=;
	h=From:To:Cc:Subject:Date;
	b=ssCfJXf839Z0yaz7AtZduRsbuSfXzrBmj8xdjARsF1ZIGoeNS0vpipzcpmLZBnBAw
	 iJ5q5HewEFzQwq6vig0JK8pwnU2KFPno/3mKs9c8ojdXNcj9NQYPoJvUaVjZbac8ze
	 gjEjq7P4D+0fEnaFyZK+5pQcl9WvEsR27ItDwnKM=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3863503D; Fri, 16 Oct 2026 17:14:06 +0800
X-QQ-mid: xmsmtpt1792142046tl54ybd4u
Message-ID: <tencent_8EF7489193A3E97C94814F52145E2ADE3706@qq.com>
X-QQ-XMAILINFO: MjmARJD6Rl8utq2V/UwT2c4NePRugwSD16/erS2VDcla28Tngq2UCkMp9cHhrD
	 +JmGymMwX+BR0MxP+S+SUx8bUbzjCWkJKoP97VivmK4QuWdK9cVe5Nc0DW4ND1iTTOsDf9CRKvhy
	 VbVHjun1YymeTYM42GTLXKPvvNfnPI07X++Nl6wkrKz0HADdlXLFdm3uoqgmlI9c/7RiCK+QL4Nw
	 C0V4n6BUGMzjlzyKXxtZOL729A/da74MD4Zy4yeYHQApqb7HbvabS9yrxcqyjCWtNS9K3Ra+onjJ
	 fImeEEHYg7C6AO1y67lEUpbfcI91MLydbYrHcJPz9U7u5lEZjanB4amkP0C+FmsO0B+/0XHxKMp5
	 /7ipzJbL9Ux4oMB/GQmDYlyuArbe5csbSvOPt3AGYKuvlaudUYattiJagSctrF1xYigPXoi4vy5C
	 NY2XZfXLGIGvokQvZT3NX7SqtfohjHzy9ANrkFKZyyukiPKHZjq5z0k8HFVzhmlqJYO387BA+Ubl
	 Pb+o+qTk8BkOnq6O3nBafwIIkWHv31ZWvcIPZ/s7JqTRA1EbW1/heMED75SjQ+ud00RPz9mqUOAq
	 qtGROzCC4JLmUUx3jw9Kyl/0vPonAjHzHxi/jDwIkk9/V9xhUns0P+CfusPeBij8exayWTZ9LMXh
	 BnBtbnvCZthFl0v3JiO823dElqsWAVEyx4KL/1aj13ZgZv5HIPjmnCCoB0susSwIzFR1vhORwInF
	 8hLfIBzV2fTtkIcbbej1qUU+mvYPGstTZk5cV/Frv7cPraCaImuEBvk2c1BcyhZYFekDW6HWFDd8
	 ykcqoqoSlNljmSRuLgAXEvThl6GZExytSC361q6/VZdEow3TD8mGcG1e5bXbKMEFpDPtBS+avP+k
	 Xbw20cwFTh8KHHyFlbKqr+JOpvL9GFDSn5rYwb1RRUgooN1bUDhnJlY+qkWShvTgIcqIhqNfsqBg
	 C7wzEHIh5jeY8SyOLdG0cru2z8KG1poEWMkyyUEaIPfSGcv/64jbfMC6dtKTWaCJXr6BXnwOVYA0
	 HwOWEarIKMAke/2toS6vA0LXwr0/uLpFkHUmw1otj7DCrUWLD9ZT2GfSye893gOBpVTm90EB6NDJ
	 z0Aya2W0MPecgFUdSzj9qbQZYZ+b3DxmoX3Ong5jJy6ktu3UI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: yangguikun <yangguikun19@qq.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: validate external log superblock fields in lmLogInit()
Date: Fri, 16 Oct 2026 17:14:06 +0800
X-OQ-MSGID: <20261016171406.95376-jfs-patch-yangguikun19@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

lmLogInit() validates only the magic, state and uuid of the on-disk log
superblock before copying its size and l2bsize fields into the in-memory
log structure, and it overwrites the sane l2bsize value set up for the
external-log case a few lines earlier:

    fs/jfs/jfs_logmgr.c:1271
            if (!test_bit(log_INLINELOG, &log->flag))
                    log->l2bsize = L2LOGPSIZE;
    ...
            } else {
                    if (!uuid_equal(&logsuper->uuid, &log->uuid)) { ... }
                    log->size    = le32_to_cpu(logsuper->size);
                    log->l2bsize = le32_to_cpu(logsuper->l2bsize);

l2bsize is then used directly as a shift count:

    fs/jfs/jfs_logmgr.c:1892
            bp->l_blkno = log->base + (pn << (L2LOGPSIZE - log->l2bsize));
    fs/jfs/jfs_logmgr.c:1973
            bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
    fs/jfs/jfs_logmgr.c:2018, :2088
            log->base + (bp->l_pn << (L2LOGPSIZE - log->l2bsize));

and size feeds log->logsize:

    fs/jfs/jfs_logmgr.c:1385
            log->logsize = (log->size - 2) << L2LOGPSIZE;

A crafted external log with l2bsize = 13 makes "L2LOGPSIZE - l2bsize"
negative and "l2bsize - 9" 4, so the computed block number and sector are
garbage.  Mounting such an image panics deterministically:

    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:1892:32
    shift exponent -1 is negative
    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:2018:28
    UBSAN: shift-out-of-bounds in fs/jfs/jfs_logmgr.c:2088:28
    BUG: KASAN: slab-use-after-free in lmLogInit+0x16dd/0x1a90
    Read of size 8 at addr ff110000413e4218 by task mount/8208
    ...
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:___free_pages+0x15b/0x190
    Kernel panic - not syncing: Fatal exception

Three runs on three fresh VMs, all panicked; a control image differing
only in l2bsize = 12 mounts with no UBSAN and no KASAN report.

The inline-log branch of the same function already validates its field
(jfs_logmgr.c:1307 compares the on-disk size against the in-memory one),
and jfs_mount() already validates sbi->l2bsize against the block size
(jfs_mount.c:366).  The external-log branch is the only path that trusts
the on-disk values unchecked.  Validate l2bsize against L2LOGPSIZE, which
is what the external-log path sets it to, and reject a size too small for
logsize to be meaningful.

Found by inspection; the reproducer is a crafted image mounted through a
loop device.

Signed-off-by: yangguikun <yangguikun19@qq.com>
---
 fs/jfs/jfs_logmgr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1316,6 +1316,17 @@
 				rc = -EINVAL;
 				goto errout20;
 			}
+			/*
+			 * The external log must use the same block size as the
+			 * file system.  log->l2bsize was set to L2LOGPSIZE above
+			 * and is used as a shift count below.
+			 */
+			if (le32_to_cpu(logsuper->l2bsize) != L2LOGPSIZE ||
+			    le32_to_cpu(logsuper->size) < 2) {
+				jfs_warn("invalid log superblock");
+				rc = -EINVAL;
+				goto errout20;
+			}
 			log->size = le32_to_cpu(logsuper->size);
 			log->l2bsize = le32_to_cpu(logsuper->l2bsize);
 			jfs_info("lmLogInit: external log:0x%p base:0x%Lx size:0x%x",

