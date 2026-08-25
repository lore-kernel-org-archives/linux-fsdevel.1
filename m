Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDC3BD635;
	Tue, 25 Aug 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659905; cv=none; b=sq/IesEOrf0Sb2QXTlCfMJZhRHS71TWqdt7CBxkWJC4jCbep8vnRTAPJgdI7+MjywH81eXP8wlCDca87xFHNRofAB3vzCOYt0GUlpSA2V4UjR6toNxxCS08vJubGaj6YNZQihrQw5n08dHorKPw/V0UhS+yYLSS2W7METbWGNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659905; c=relaxed/simple;
	bh=yvgN+u636RDAjwsxCTkP0MVwNUpS3S2y9mrnOZLZBJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wb290CjT1dZetaFeDY3UZ0nAO/Gq0C7DuADKQBqLbx1YlDOFAlWT3OemkZXxtkL+td0lOLb155Wo3roD+ErqIOMWEKzVASgiZt02asniFfGYR1rw+IdoeqfsIkiiz42DGpcV0pNbbNYk9jWuUG+SyudLEtL3d60H0eyhVLqMNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=LRFPqbbj; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=MiBNia8C; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="LRFPqbbj";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="MiBNia8C"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 58382209655C;
	Tue, 25 Aug 2026 21:11:33 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787659893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBIsTJXDwnMOf6ijZgADVbbkN/paN6Of7rNk/WuI9h8=;
	b=LRFPqbbjQbgzCvQK7BUyemVsKJjKv1IswmD/xcJhh/3ORhNZ6YZJMuQnz3iZVNrJxemqch
	VGA9GXEXofSXqKCLUOh+P6+C6WC1LdUmjqkCwX0RssXzQU4nKQcnyPFwt6AKkcqs8coALu
	R5LxoP34mcsIdEBYNQ4ZiQNmnVEPqmfC8lko9Bjd2ORqxpWp6e1jBt5yjTu+6taIhkh+m8
	tSl6Hg5AvERFqaDK7gFrOHVciyjufaDVulrkYdaTu8krTsqeUrJHqAjhOGd/iWtGNlcrnG
	+h7d+ofM7ehfsZ+TPHT4e1cHuLeBIfGq6gCPNeovgkmQvGH0+ExncCC8I4fX0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787659893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBIsTJXDwnMOf6ijZgADVbbkN/paN6Of7rNk/WuI9h8=;
	b=MiBNia8Cc24QJ8e3XzfO6vT+FRUrQRKEeHyuCBJ3vo05N1/NDoCxOM/XYIFKgEi9ASkkqq
	ae+ntm4bfMlVMgDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id D9512E0015B;
	Tue, 25 Aug 2026 21:11:32 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id D032E22000F2; Tue, 25 Aug 2026 21:11:32 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linkinjeon@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  sj1557.seo@samsung.com,
  syzkaller-bugs@googlegroups.com
Subject: [PATCH] fat: Fix fat_ent_write() for reverting the value
In-Reply-To: <20260824095013.ec38b9d5d5ec33922aad47e2@linux-foundation.org>
References: <6a8bf715.dbb3a75c.13dd47.0065.GAE@google.com>
	<875x0z6f0u.fsf@mail.parknet.co.jp>
	<20260824095013.ec38b9d5d5ec33922aad47e2@linux-foundation.org>
Date: Tue, 25 Aug 2026 21:11:32 +0900
Message-ID: <87ik4yz9fv.fsf_-_@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

commit 64d9183203ee ("fat: restore original value when fat_ent_write
failed") try to revert the fatent value to old value when got the
error on mirror FAT.

However it didn't work if the error is when writing the fatent bh. In
that case, the bh is cleared the uptodate flag, so reuse bh is
invalid.

So this fix it by reverting the fatent only if got the error on mirror
FAT.

Fixes: 64d9183203ee ("fat: restore original value when fat_ent_write failed")
Reported-by: syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e64c6472a3d96a75172a
Reported-by: syzbot+26461e903494e689c24f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=26461e903494e689c24f
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/fat.h    |    2 +-
 fs/fat/fatent.c |   21 ++++++++++++++++++---
 fs/fat/file.c   |    3 ++-
 fs/fat/misc.c   |    6 ++----
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 6133841..fbd207c 100644
--- a/fs/fat/fat.h	2026-08-25 04:18:02.783584853 +0900
+++ b/fs/fat/fat.h	2026-08-25 04:41:16.699018559 +0900
@@ -392,7 +392,7 @@ extern void fat_ent_access_init(struct s
 extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
 			int entry);
 extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
-			 int new, int wait);
+			 int new, int old, int wait);
 extern int fat_alloc_clusters(struct inode *inode, int *cluster,
 			      int nr_cluster);
 extern int fat_free_clusters(struct inode *inode, int cluster);
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f0801d9..df23fc8 100644
--- a/fs/fat/fatent.c	2026-08-25 04:18:02.783584853 +0900
+++ b/fs/fat/fatent.c	2026-08-25 20:53:03.682868977 +0900
@@ -413,7 +413,7 @@ error:
 }
 
 int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
-		  int new, int wait)
+		  int new, int old, int wait)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
@@ -422,10 +422,25 @@ int fat_ent_write(struct inode *inode, s
 	ops->ent_put(fatent, new);
 	if (wait) {
 		err = fat_sync_bhs(fatent->bhs, fatent->nr_bhs);
-		if (err)
+		if (err) {
+			/*
+			 * bhs are not uptodate after I/O error. So we
+			 * can't simply re-dirty to revert. And it
+			 * would not have value to write again on I/O
+			 * error.
+			 */
 			return err;
+		}
 	}
-	return fat_mirror_bhs(sb, fatent->bhs, fatent->nr_bhs);
+
+	err = fat_mirror_bhs(sb, fatent->bhs, fatent->nr_bhs);
+	if (err) {
+		/* Try to revert if got the error on mirror FAT */
+		ops->ent_put(fatent, old);
+		if (wait)
+			fat_sync_bhs(fatent->bhs, fatent->nr_bhs);
+	}
+	return err;
 }
 
 static inline int fat_ent_next(struct msdos_sb_info *sbi,
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 1c835ca..6c475c5 100644
--- a/fs/fat/file.c	2026-08-25 04:18:02.783584853 +0900
+++ b/fs/fat/file.c	2026-08-25 04:36:54.305256547 +0900
@@ -363,7 +363,8 @@ static int fat_free(struct inode *inode,
 				     __func__, MSDOS_I(inode)->i_pos);
 			ret = -EIO;
 		} else if (ret > 0) {
-			err = fat_ent_write(inode, &fatent, FAT_ENT_EOF, wait);
+			err = fat_ent_write(inode, &fatent, FAT_ENT_EOF, ret,
+					    wait);
 			if (err)
 				ret = err;
 		}
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index e79762c..c442967 100644
--- a/fs/fat/misc.c	2026-08-25 04:18:02.784584849 +0900
+++ b/fs/fat/misc.c	2026-08-25 04:33:40.124172801 +0900
@@ -133,11 +133,9 @@ int fat_chain_add(struct inode *inode, i
 		ret = fat_ent_read(inode, &fatent, last);
 		if (ret >= 0) {
 			int wait = inode_needs_sync(inode);
-			int old = ret;
 
-			ret = fat_ent_write(inode, &fatent, new_dclus, wait);
-			if (ret < 0)
-				fat_ent_write(inode, &fatent, old, wait);
+			ret = fat_ent_write(inode, &fatent, new_dclus, ret,
+					    wait);
 			fatent_brelse(&fatent);
 		}
 		if (ret < 0)
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
