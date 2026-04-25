Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158F37CD3A
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142572; cv=none; b=VEPx6Uh2/xSg9adDO8Jd0mm/usOwaLlNBrXqtj0Sd0BQY9ey2f1Ebo4A2J7ga23PvdciMajUDMCMCJRzHMh2M4mnts+HRX94m4wjeMjZgOA6+7RKEa7C1HPKVdsDSbrVoeV5tXZT5XgqaHq5349OJdk47y9A40ieVYU937pY1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142572; c=relaxed/simple;
	bh=7vjQFDQ3ngEfFpRcZSO66m3dz8MlsyyYwJ6Y/OWi6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwznHsFw9naU2fsnVAeGMpprbLYF4jy+JUOxtM+v7FoomI96GDGGPAMAnpuX+VIDckiTfAa9sbJPKL3MUfm9usHs4E3U/iQIlTimm06UskOZPDnTjZbsTE1sU5n3igFUPkgftez6VScmKbfDpUdEsIIpK5+al6Pto0F7wiE5hA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Fcu2g7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Fcu2g7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso2062285a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777142571; x=1777747371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6T7QXBLhmGguBHO1L+/WMwTbhQuI0+KzV9ksg4NtKw=;
        b=D3Fcu2g7kSIpN4IEqpFscIPIGWGzMf/vh23owWwJyjVPS4tJcWybXTPmTMQrSq+Bd6
         lrRLhToo53c3hGqOZOdZ3tOOB1Z4WkeV4txv3O1wPBnG/hoCpMftKvGTPrLtBiJmqf+O
         wd9nn7zFypXR2Mu78X5S9JenCFrSpGZtmxprt2EItltXoHkZYStvoMJAvnsuXzWxYqaL
         dfbu/FVj1XxxwvpSPFo3RcoCEWg39rPp60gRE2L7CZa1cNc210dk5sLVK36H5UECr3qt
         pbgDdcOP4ovJG08cIFe+x94yyq+4eWV8DvFnJEbDoBtGrFfuHCSrDic0cvZbXIOmhy+3
         XWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777142571; x=1777747371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6T7QXBLhmGguBHO1L+/WMwTbhQuI0+KzV9ksg4NtKw=;
        b=hnu/Bgc04la7w0yjTJP1XwTe8bBAbcXSN2MXWwvnqeR9k4vC8d+MrWpmJc7N/UXMDq
         61qK6c+pHWAGvzTn1mhuYhqxi44/7Zw2KYOoEwTpYzOHfGtf6/7z4xW+fqTh1sJhttza
         3TNubAxsXceyNgrSdt5PSjCYcxStzmLD5gU6XrgJpPwsuqhMa2S19qpKCfpS0TusD7JE
         hkznrdPi2Cnca1/QHIRmv/i0pJ8ZQv+I0hTsja9erL+KlxxtdTJnNk+sMZaUuejlWMl5
         VkAMyDtq0mpEg56NE7EK+Cl0n/xpD0AKseqXbhenuMONZ232VKGnPZQuWP7IRYnR2OwO
         cJtA==
X-Gm-Message-State: AOJu0Yzi/1r4gOHaoMD+NMu4pG+FW+Kh5EsYVn0lT+CsSKNIKEd+qTFb
	DG7Ell8pAwMhxH6LCEuIJYHxFjztjZZiPPucYa8fIx8hgKRb0sSJjcf7
X-Gm-Gg: AeBDieuK2Wk/E9Vy3YasBwIdfslocwLLcN7788+Gl2eNAJomUzotqvaoDIPQg8Gg/mU
	JAeUQGzqttICVat1zQZJyKnwE6vgNTRU8IHp23OBa3JBAYeBx5pX9B1D1JvEZBEN8X8ZHWeguZu
	f897pDIynh3OPRC3tDhbGXQD3xAMbz/hRRhfY2qEOKiSWWiT0aOiBfspnQRotLGFzcrKvE9KYUS
	yt+phYGcMU2TJTmo/wVjW7v90EB9KcscuAiMYXEALGXbI18pzki0upm6s11CvsfUltp/Cds00Rw
	g+4Q3H14Qo8AL/Ym1e2SZcuLjmQYe9A/KjmPfi1KB8EilUp3lz61e2dlC/6ubBJ3BxrBwNI2QIb
	f6qIi1sakq+K4C2xXID9hNgPfi9YYyL2iSoYBplK1HRlZFic+0joiiphIQvyL5TOYOehhBbv1fc
	WKVaVyGbZ7IX4D+L4Z7caNR4cmh3A=
X-Received: by 2002:a05:6a20:2583:b0:39f:c9b1:52ce with SMTP id adf61e73a8af0-3a08d8fe2a9mr23390576637.8.1777142570922;
        Sat, 25 Apr 2026 11:42:50 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm33975874b3a.38.2026.04.25.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:42:50 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/2] ntfs: fix NULL dereference in ntfs_index_walk_down()
Date: Sun, 26 Apr 2026 03:42:42 +0900
Message-ID: <20260425184243.116396-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425184243.116396-1-charsyam@gmail.com>
References: <20260425184243.116396-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_walk_down() allocates ictx->ib when descending from the root
into an index allocation block. If that allocation fails, the old code
still passes the NULL buffer to ntfs_ib_read(), which can write through
it via ntfs_inode_attr_pread().

Allocate the index block into a temporary pointer and return -ENOMEM
before changing the index context on allocation failure. Also propagate
ERR_PTR() through ntfs_index_next() and ntfs_readdir() so walk-down
allocation or index block read failures are not mistaken for normal
index iteration inside the filesystem.

ntfs_readdir() keeps the existing userspace-visible behavior of
suppressing readdir errors after marking end_in_iterate; this change only
prevents the walk-down failure path from dereferencing NULL internally.

The failure was reproduced with failslab fail-nth injection on getdents64;
the original module hits a NULL pointer dereference in memcpy_orig through
ntfs_ib_read(), while the patched module reaches the same
ntfs_index_walk_down() allocation failure without crashing.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/dir.c   | 13 ++++++++++---
 fs/ntfs/index.c | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index bfa904d2ce66..20f5c7074bdd 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -911,8 +911,8 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 
 	if (next->flags & INDEX_ENTRY_NODE) {
 		next = ntfs_index_walk_down(next, ictx);
-		if (!next) {
-			err = -EIO;
+		if (IS_ERR(next)) {
+			err = PTR_ERR(next);
 			goto out;
 		}
 	}
@@ -920,7 +920,14 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	if (next && !(next->flags & INDEX_ENTRY_END))
 		goto nextdir;
 
-	while ((next = ntfs_index_next(next, ictx)) != NULL) {
+	while (1) {
+		next = ntfs_index_next(next, ictx);
+		if (IS_ERR(next)) {
+			err = PTR_ERR(next);
+			goto out;
+		}
+		if (!next)
+			break;
 nextdir:
 		/* Check the consistency of an index entry */
 		if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLATION_FILE_NAME,
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 2080f3969137..f50082708bd1 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1969,15 +1969,19 @@ int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const u32 keyl
 struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_index_context *ictx)
 {
 	struct index_entry *entry;
+	struct index_block *ib;
 	s64 vcn;
 
 	entry = ie;
 	do {
 		vcn = ntfs_ie_get_vcn(entry);
 		if (ictx->is_in_root) {
+			ib = kvzalloc(ictx->block_size, GFP_NOFS);
+			if (!ib)
+				return ERR_PTR(-ENOMEM);
 			/* down from level zero */
 			ictx->ir = NULL;
-			ictx->ib = kvzalloc(ictx->block_size, GFP_NOFS);
+			ictx->ib = ib;
 			ictx->pindex = 1;
 			ictx->is_in_root = false;
 		} else {
@@ -1991,8 +1995,8 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 			ictx->entry = ntfs_ie_get_first(&ictx->ib->index);
 			entry = ictx->entry;
 		} else
-			entry = NULL;
-	} while (entry && (entry->flags & INDEX_ENTRY_NODE));
+			entry = ERR_PTR(-EIO);
+	} while (!IS_ERR_OR_NULL(entry) && (entry->flags & INDEX_ENTRY_NODE));
 
 	return entry;
 }
@@ -2097,10 +2101,15 @@ struct index_entry *ntfs_index_next(struct index_entry *ie, struct ntfs_index_co
 
 		/* walk down if it has a subnode */
 		if (flags & INDEX_ENTRY_NODE) {
-			if (!ictx->ia_ni)
+			if (!ictx->ia_ni) {
 				ictx->ia_ni = ntfs_ia_open(ictx, ictx->idx_ni);
+				if (!ictx->ia_ni)
+					return ERR_PTR(-EIO);
+			}
 
 			next = ntfs_index_walk_down(next, ictx);
+			if (IS_ERR(next))
+				return next;
 		} else {
 
 			/* walk up it has no subnode, nor data */
-- 
2.43.0

