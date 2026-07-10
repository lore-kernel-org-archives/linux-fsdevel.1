Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825ED3C8C77;
	Fri, 10 Jul 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667720; cv=none; b=YCBPkb6se9AoqWKfQ0TGYOJ/wRsIojmOjgbRgfKBqLPqEXqmyqynSB4snrAA0zDFqkEY/lmCOgURD5P66SwATBCRqB2v8vC2NYL/Dzw+/xaET3LFHSQbjOAiIn4ILdbVZa3ekti1Drcas7WGjEMLtxB2EIuybg5IsoYHp05KwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667720; c=relaxed/simple;
	bh=7cH87X9O80OuVLNj3PzP4rYD0UoawZX5KnA0iQCCNv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WD1kTrloQKdvq3xWsfi9Al9IE/rzyxdTlTZDard03R6wFWzZlR95h2roDlnwaJkOmgeIu0HBOwdpiy4Rx2LsDKU+QL00SqIaZREI6AQrO8ACtJrZ48zQo/wRwlDUKKylLGFserTsyLb1EqqrrwhwQf8ZkBvap2ZPjJT19ZhTCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 166c3e327c2f11f1aa26b74ffac11d73-20260710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5648263b-74be-4f49-b836-b4874850c513,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:5648263b-74be-4f49-b836-b4874850c513,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:59e8684d00f1fde5cd0abb9f0a1926f8,BulkI
	D:260710151512L81U25KW,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 166c3e327c2f11f1aa26b74ffac11d73-20260710
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1744339208; Fri, 10 Jul 2026 15:15:10 +0800
From: Can Peng <pengcan@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] fs: stat: Mark accesses in generic_fillattr
Date: Fri, 10 Jul 2026 15:14:43 +0800
Message-ID: <20260710071444.301350-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got the following KCSAN report during syzbot testing:
==================================================================
write to 0xffff9585c0413028 of 4 bytes by task 1047 on cpu 16:
inc_nlink+0x38/0xb0
ramfs_mkdir+0x8e/0xb0
vfs_mkdir+0x147/0x260
do_mkdirat+0x200/0x240
__x64_sys_mkdirat+0x52/0x60
x64_sys_call+0x1bdf/0x1d90
do_syscall_64+0x5b/0x1d0
entry_SYSCALL_64_after_hwframe+0x76/0xe0

read to 0xffff9585c0413028 of 4 bytes by task 1060 on cpu 4:
generic_fillattr+0xeb/0x2d0
vfs_getattr_nosec+0x1f0/0x200
vfs_statx_path+0x19d/0x200
vfs_statx+0xc2/0x130
vfs_fstatat+0x73/0x110
__do_sys_newfstatat+0x52/0xb0
__x64_sys_newfstatat+0x57/0x70
x64_sys_call+0x141a/0x1d90
do_syscall_64+0x5b/0x1d0
entry_SYSCALL_64_after_hwframe+0x76/0xe0

value changed: 0x00000023 -> 0x00000024
==================================================================
KCSAN reports a data race between generic_fillattr() reading
inode->i_nlink while filling st_nlink and inc_nlink() updating
the link count during ramfs_mkdir().

getattr does not take the inode's i_rwsem, so st_nlink
is a snapshot and may observe either the old or new link count
when it races with directory updates. This is expected and
does not require serializing the stat path with link count updates.

Mark the read with data_race(READ_ONCE()) to document
the intentional lockless snapshot and to keep KCSAN from reporting
this benign race.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 fs/stat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 89909746bed1..5847f10dd20b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -88,7 +88,11 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
-	stat->nlink = inode->i_nlink;
+	/*
+	 * st_nlink is a snapshot. Link count updates are serialized by
+	 * inode->i_rwsem, but getattr does not take that lock.
+	 */
+	stat->nlink = data_race(READ_ONCE(inode->i_nlink));
 	stat->uid = vfsuid_into_kuid(vfsuid);
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
-- 
2.53.0

