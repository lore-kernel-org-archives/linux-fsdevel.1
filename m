Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2B143FD0C;
	Tue, 14 Jul 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021291; cv=none; b=YTsSBgM1Jq8E7hzhH0wReKd2MbZ+YxeyJ5ZpaGGglwwGG2lJFm66BpzjI5AhoOK1k6WJDDbOtjjHQzyYo7yLnkcFmrZmgdXkt+YWKOy424e8JvP8anRhxhCe95b/WV8u+uxeI4UTBQN411+O9lEihsKEa4wwbTvFlKXVzAsclLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021291; c=relaxed/simple;
	bh=NSokBI3S+ONfPvAoH6wiWvPTcZiyO9AHpZZUkQgRD1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Eyd7ffsyNcjW6nQfcFM988nsY84ymSuDhQRXgd//eI3QU+w/KnGIV4CUdXTCGEy9vhIhUZ2RZ893lbxYrQ75HEHaob9qHhn3rcbFsUenfhMTaNdgiwb/ojRX+eICSB/kkVh6JRYnVUnmYF6f3sdS35u9Y9tSD2rNQrKrd0jHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4c5575f67f6611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c1501126-c86e-46ce-a2ec-9dc0cb9c2e51,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e10fd2eda2430bbde43c6af0185876e8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4c5575f67f6611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 999012092; Tue, 14 Jul 2026 17:27:56 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] affs: fix i_size on failed OFS hole extension
Date: Tue, 14 Jul 2026 17:05:29 +0800
Message-ID: <220864429a522fceb39827cddd019f15aca40227.1784019929.git.kylinos.cn>
In-Reply-To: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
References: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: affs/send-local.py

affs_extent_file_ofs() grows OFS mmu_private during write_begin. On
allocation failure the error path still set i_size and mmu_private to
newsize, so a partially extended hole left a too-large i_size.

Set both to the bytes actually extended, and release the previous data
block held across the failed getzeroblk_ino().

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 fs/affs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 144b17482d12..3265b6b6bf9f 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -569,6 +569,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 	pr_debug("%s(%llu, %d)\n", __func__, inode->i_ino, newsize);
 	bsize = AFFS_SB(sb)->s_data_blksize;
 	bh = NULL;
+	prev_bh = NULL;
 	size = AFFS_I(inode)->mmu_private;
 	bidx = size / bsize;
 	boff = size % bsize;
@@ -625,7 +626,9 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 	return 0;
 
 out:
-	inode->i_size = AFFS_I(inode)->mmu_private = newsize;
+	affs_brelse(prev_bh);
+	/* Keep i_size/mmu_private at how far we actually extended. */
+	inode->i_size = AFFS_I(inode)->mmu_private = size;
 	return PTR_ERR(bh);
 }
 
@@ -662,9 +665,6 @@ static int affs_write_begin_ofs(const struct kiocb *iocb,
 	pr_debug("%s(%llu, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
 	if (pos > AFFS_I(inode)->mmu_private) {
-		/* XXX: this probably leaves a too-big i_size in case of
-		 * failure. Should really be updating i_size at write_end time
-		 */
 		err = affs_extent_file_ofs(inode, pos);
 		if (err)
 			return err;
-- 
2.43.0

