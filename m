Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A733FE02;
	Tue, 14 Jul 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007452; cv=none; b=ipkDybjiqo0OqQvEWyRJvyxxDT0f8baVIp+S2JggCz5BhmhmmCrplfzuDUg49jq05qyjVgRXvU8AFVz1tIvUng5JIshbi27OJOzX3Q9MxrKxWlFjXA+LthHYGysYEYgoFD7cyk7HEhFckaaJa7BPa/YdgcWq3MDhIn1ByhRv5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007452; c=relaxed/simple;
	bh=c88RgtfbO8RbLF3/eduLTgGEzvoOpMopVSwMRXiRL7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK588/9yiK/RsmS7tDvz9FVndefNLBCStd0G1qMjYMHCF19cf6kljY2sKzbCE9hBo5BGLOy/ZOqgspjzPe/5jVPmwS6/7MIgsQT/FniNuu1CWP9BXZLgx1HLuJyi9folG/lwjX+XxJlt5qoDZqS5y0vhsj9XJo2RrG8eM4ivrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 158766bc7f4611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e07267db-1b95-454e-b833-ad983aad9537,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:87092e046cec8ff8298bacc935b18d23,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 158766bc7f4611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1524279156; Tue, 14 Jul 2026 13:37:21 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, mjguzik@gmail.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] affs: replace get_zeroed_page() with kzalloc()
Date: Mon, 13 Jul 2026 16:32:57 +0800
Message-ID: <1691d0f1a05888816815c56d5329892a62df1b2d.1783931577.git.kylinos.cn>
In-Reply-To: <cover.affs-kzalloc-v1.1783931577.git.kylinos.cn>
References: <cover.affs-kzalloc-v1.1783931577.git.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: affs/send-local.py

affs_grow_extcache() allocates the per-inode extent lookup cache with
get_zeroed_page(); affs_evict_inode() frees it with free_page() through
an unsigned long cache_page local.

The cache is one zeroed buffer of AFFS_CACHE_SIZE bytes: i_lc and i_ac
share it in process context, not as a page frame.  Use u32 *lc with
kzalloc()/kfree() and AFFS_LC_SIZE to split the two tables.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 fs/affs/file.c  | 10 ++++++----
 fs/affs/inode.c |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 144b17482d12..b8da8c54e0d7 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -56,11 +56,13 @@ affs_grow_extcache(struct inode *inode, u32 lc_idx)
 	int i, j, key;
 
 	if (!AFFS_I(inode)->i_lc) {
-		char *ptr = (char *)get_zeroed_page(GFP_NOFS);
-		if (!ptr)
+		u32 *lc;
+
+		lc = kzalloc(AFFS_CACHE_SIZE, GFP_NOFS);
+		if (!lc)
 			return -ENOMEM;
-		AFFS_I(inode)->i_lc = (u32 *)ptr;
-		AFFS_I(inode)->i_ac = (struct affs_ext_key *)(ptr + AFFS_CACHE_SIZE / 2);
+		AFFS_I(inode)->i_lc = lc;
+		AFFS_I(inode)->i_ac = (struct affs_ext_key *)(lc + AFFS_LC_SIZE);
 	}
 
 	lc_max = AFFS_LC_SIZE << AFFS_I(inode)->i_lc_shift;
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 5dd1b016bcb0..07c3a6376aaa 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -258,7 +258,7 @@ affs_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
 void
 affs_evict_inode(struct inode *inode)
 {
-	unsigned long cache_page;
+	u32 *lc;
 	pr_debug("evict_inode(ino=%llu, nlink=%u)\n",
 		 inode->i_ino, inode->i_nlink);
 	truncate_inode_pages_final(&inode->i_data);
@@ -273,12 +273,12 @@ affs_evict_inode(struct inode *inode)
 	mmb_invalidate(&AFFS_I(inode)->i_metadata_bhs);
 	clear_inode(inode);
 	affs_free_prealloc(inode);
-	cache_page = (unsigned long)AFFS_I(inode)->i_lc;
-	if (cache_page) {
+	lc = AFFS_I(inode)->i_lc;
+	if (lc) {
 		pr_debug("freeing ext cache\n");
 		AFFS_I(inode)->i_lc = NULL;
 		AFFS_I(inode)->i_ac = NULL;
-		free_page(cache_page);
+		kfree(lc);
 	}
 	affs_brelse(AFFS_I(inode)->i_ext_bh);
 	AFFS_I(inode)->i_ext_last = ~1;
-- 
2.43.0

