Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676018;
	b=j+asWIV1smgsvg2k56fyuA4CqH0MjAhA8g/sPKIoMulZ1iGCrwbWnveVCBXEpVeDaavJ
	 04r+x3sEWo08hi9GeyrRTdXFd5GmY2D+PJ3rwtI/TXRp/tXeJnAYIstnl2uwjK3ESp5t0
	 yyPHtJusw93/pMI5TjvM4k4BMnPPSV7gFuUozMYR492dVM9T49IfGs1XQd2qC3YJWALhY
	 uboL1t2PGkHjyH/qsRmUMK2XHNi62GL2WdFSSq7LGD2DeEZzkDpByB/MjpPiwHbv2Pa2H
	 y7I+8KX9qzhleUX/EeMEDCkrbrpWg9H4N4UyPNFDYofE4Lcbv7cqNvX3SVd1txN++pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676018;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GWTLvmc4WFS/BtTfj6ZJvNI/0mzbNIBjmsCR+aCchQc=;
	b=qip/tpysZ+jhQsAsupWWzlCuE7LXp3dPeGdLc3TgX62QYJ5j01AYLmENEWXRKrlQQdcH
	 liQFcjGejkaffbX0bpGTpnv6pQMZiO1mQ2iVvir7Q/Ur43y8myeg5+P5/I4IcbDG7UMPR
	 JzPaGl0qr2Ymq/LohTO3gMK0TxZqZVxH5pVxd35KIpwNm5nNALBME4LkgLuktbubWkgsC
	 Sp1L13ODn4knaMInCKe4fe9IV7X8aMTxNZNcA3lVX3HSljdfAOv8dLyRJi/K7Omgvy6Zz
	 /Lw/tT4cUH0AdKnjqq2Bdlz5ln1fEpX+RkJoWpk2NBVQSUrRcyec+CUqbSUSqoK4+Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Og2nmNPv;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0E606A319;
	Thu, 22 Oct 2026 13:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C0E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Og2nmNPv
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GWTLvmc4WFS/BtTfj6ZJvNI/0mzbNIBjmsCR+aCchQc=;
	b=Og2nmNPvpd1ApEK4OaDu/BtOYED7jApmfuBMGee9ns1X/azeOxOp4/sXs2gz1Cv+wyHaTLQ6r
	JZTvEyNsQoM5XDRFLMinNyRdLi/17VQ+xIFjglzsZ0JUWQ/gzen56GxIyLZap8whMm9XxC6uinr
	EQS0U2EjOBDTXwaJQn8ztyA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j9RtZ0YbGz1prMd;
	Thu, 22 Oct 2026 21:33:26 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id ADE08203C1;
	Thu, 22 Oct 2026 21:33:30 +0800 (CST)
Received: from huawei.com (10.50.85.155) by whupemo200011.china.huawei.com
 (7.152.185.179) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 21:33:29 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <jack@suse.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] udf: Fix zero-length extent handling in udf_table_new_block()
Date: Thu, 22 Oct 2026 21:26:03 +0800
Message-ID: <20261022132603.2464065-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200011.china.huawei.com (7.152.185.179)

udf_table_new_block() keeps the remaining extent length together with the
extent type in goal_elen and then uses the whole value to decide whether
the extent is empty:

	goal_elen = (etype << 30) | elen;
	...
	goal_elen -= sb->s_blocksize;
	if (goal_elen)
		udf_write_aext(...);
	else
		udf_delete_aext(...);

On a table-managed partition, free extents may have non-zero type bits.
If such an extent has exactly one block left, subtracting the block
leaves only the type bits (e.g. 0x40000000 for type 1).  The test is
still true, so instead of deleting the extent the function writes a
zero-length extent at the next block back into the unallocated space
table.

Consider a free extent with type 1 and 9 blocks:

	lb=55, len=9 blocks (55..63)

A new file is allocated from it at lb=55, so the extent becomes
"lb=56, len=8 blocks".  A huge write then extends the file with a hole.
After the in-ICB allocation descriptor area fills, AED blocks 56..63 are
allocated from this extent.  When lb=63 is allocated, goal_elen is
0x40000200; after subtracting one block it becomes 0x40000000, so the
extent is rewritten as

	lb=64, len=0, type=1

instead of being deleted.

The next allocation with goal=63 prefers this zero-length extent
(distance 1) over the real next extent "lb=65, len=31 blocks" (distance
2) and allocates lb=64 from it.  Subtracting a block from the zero-length
value borrows from the type field:

	0x40000000 - 0x200 = 0x3FFFFE00

and writes back a bogus ~1GB extent:

	lb=65, len=0x3FFFFE00

which now overlaps the real free extent "lb=65, len=31 blocks".  The next
allocation with goal=64 picks the bogus extent first (both start at 65,
the bogus one is encountered first and the search keeps the first
minimum), so lb=65 is handed out and the bogus extent advances to lb=66.

lb=65 is now the file's current AED.  After 60 short_ad descriptors are
appended to it, epos->offset is 504 and aed->lengthAllocDescs is 480.
The next append enters udf_setup_indirect_aext().  The allocation goal is
65, and now the real extent "lb=65, len=31 blocks" wins: the goal lies
inside it (distance 0), while the bogus extent has advanced to lb=66
(distance 1).  udf_new_block() therefore returns 65 again, i.e. the block
that is already the current AED.

udf_setup_indirect_aext() then does:

	sb_getblk() returns the buffer of the current AED
	memset(bh->b_data, 0, sb->s_blocksize)
	  -> clears aed->lengthAllocDescs

Because epos->offset is still 504, the block is not considered full
(504 + 8 <= 512) and the else branch calls __udf_add_aext(), which hits

	WARN_ON(aed->lengthAllocDescs !=
		epos->offset - sizeof(struct allocExtDesc))

with lengthAllocDescs == 0 and offset == 504, i.e. 0 != 480.  The AED
contents are destroyed and the filesystem is corrupted.

This is reachable by mounting a table-based UDF image with
adinicb,shortad and writing at a very large offset: the write creates a
huge hole, fills the in-ICB allocation descriptor area and then
allocates many AED blocks from the unallocated space table.

Reproducer is https://syzkaller.appspot.com/x/repro.c?x=16562e75180000.

Fix it by testing only the extent length field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/udf/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 30cec5600149..621656be65d2 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -646,7 +646,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	goal_eloc.logicalBlockNum++;
 	goal_elen -= sb->s_blocksize;
 
-	if (goal_elen)
+	if (goal_elen & UDF_EXTENT_LENGTH_MASK)
 		udf_write_aext(table, &goal_epos, &goal_eloc, goal_elen, 1);
 	else
 		udf_delete_aext(table, goal_epos, &freed);
-- 
2.52.0

