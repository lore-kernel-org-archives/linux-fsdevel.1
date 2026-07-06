Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3F43786D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362180; cv=none; b=fk5cUenP15MMY92yXQN3b9TSnFXkTFDGyTAXBBpGtI6N8GnkkAkdKvjKdZbTsozLNDcYIs397QaQPh0DP+lvJ8xFE/Cc2/RJMqGSmwT5d1jIIj51fRtl78ftHaia63Tr7f9kryOwFctdMN8QK7d8tgk10Yzw0J8rgsmVxoL1OWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362180; c=relaxed/simple;
	bh=sE+XIPbKjFOl4uFuweH0KT2tpzHoCd94c07RjdbnZd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV0hvssquOhscRqvSkTXpAahugb/1X6mpT6D5u3pHGtgwK0itIJYVYrV745przlZD7fVsGcX3yQyBgpk9pgjXLDdCjrzbS02UcOiyQ1e44ABq5DgHWuUqUQhMwSN4pEGb7KKvb1iDZQXKwjcxOkEsRdLZk5Ihn2dOmYUCeGpgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDWJN86N; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDWJN86N"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so370876a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362177; x=1783966977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GMDfk/cscIlL88JTWUBOd5FcSvUX50AhqoTnh79o+U=;
        b=kDWJN86N0VIsG677QBiyoE+jtKZjFHonZoFiqQPwzH7JMOfr1ZQZdpgJCz4+xyLYWx
         0R1FGUDaAtgwvy0qTz5bzh6qonRyb8BZgNW+aiWmAZLnti/Oy5SauLbpU4NG1llZt+De
         bbxENzHZa/9SEPsfadtgikMXdvZp7ZHKOoZd/2CX2yNcen8fKu6Fa6JCsvrlsvwoshm3
         QlD15J57qS9xR1mf9fcpAc5ZSGay0VpzSHAvXwlFeBzdyj7h7+94o/LH84sacIxl+q4l
         iuRM2LhFC/iAJRQAeNZua0YYdlPeAofO5Rn3Y/4pd+DDuo+10ZZG2ZfEAjdFvRr2/VAs
         mcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362177; x=1783966977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GMDfk/cscIlL88JTWUBOd5FcSvUX50AhqoTnh79o+U=;
        b=TZE7Ps70JXre1PMUznoSCY1qd+sFIu8VUoerU021xek9Znqm9pUFPgfEOpmsOoQnXU
         wFBY+TlxPoLl5xnl2APCKxoTIEn7TDXEdd+Y+HR6ZFnUxUSDsZZqS7mNXpPK/SchJKwv
         9Qg/pwLETUEzg2kUnvpBU88odKy+I8vDt0kgcX36H/v87hT2BnhotjDoprsf88s4pzsY
         RkA5EWhsW+t7t5uuTUTSj/ENn0S/0WNT0zTqzEx/baBhVs6sn0YuigkiOEpm+co3DPfM
         cGkwplgFZemqVNZnF25FnfbEc9bBRLL59D0HwvGNn32Mb8l/pkgHPea3ophYjJ9F7j1/
         Wd6g==
X-Gm-Message-State: AOJu0Yw8qQgSPihjOFk44W701mJa2VOuFh5gfxAg6k779qayt4JHglMi
	xtleRkq7bLx/4LjBuH+i4G0+iAiCSzEGafXBsoeLEHRJuCfD+xfSEHxywKiqVA==
X-Gm-Gg: AfdE7cnwzp4zXZ9d2ovzo4dtsaZC/VsqetIKfwgTfWARAdu0xADuUb7VErrzs04PeyG
	M4/uP15j7BAuVKlIt0Jinedj2chwDDp5m7sW3qbwFTIkb9uGChYYYejKAd0pK7uhgG0tQozxtyS
	i0F5phQ+mLCYZddj3qwaw0u/r3tWPsFAzSs8IeRZ2awyYbeMjMxaO90UAhghTfZ/keDwjgAHt+M
	tvR+pOj7eW1n61CSKgF3OB4xmovI/7ifSz55RQMSCUrCOO0ZcMMNajtkfvibIcmxzrHzMpc856t
	w1wB0bbUoPJsQ7KIDZxZhSu0eVCfixo6iU5stAm94ytvkWvh/3f7Y1LgRipmlGBQuCURbQ8S9Pw
	oioUJYa/ea7rLpUkBkGeysWYdXY/5rz0YcSOCdkZu2VuhnxsbVTnl4bCGZARplPCkdgFT463gog
	==
X-Received: by 2002:a17:90b:2e87:b0:37f:9ce0:af35 with SMTP id 98e67ed59e1d1-38757b81efamr1875061a91.32.1783362177151;
        Mon, 06 Jul 2026 11:22:57 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387a83fb23csm21238a91.0.2026.07.06.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:56 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 2/2] minix: modernize function declarations in minix.h
Date: Mon,  6 Jul 2026 11:22:44 -0700
Message-ID: <9f17d0773dd24fff5cb77bf32d1ec9ed3e941e30.1783360491.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783360491.git.jbingham@gmail.com>
References: <cover.1783360491.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function prototypes in minix.h were a mix of current and historic
standards. Some functions had arguments with types and names while
others had just the types. Some functions were also still prefixed with
extern, and there were a few uses of bare 'unsigned' still as well.

This brings fs/minix/minix.h up to speed with the current formatting
standards. Function declarations are consistent with types and names
both declared, and the bare 'unsigned' variables are now declared as
'unsigned int'.

There are no functional changes with this patch.

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/itree_v1.c |  2 +-
 fs/minix/itree_v2.c |  2 +-
 fs/minix/minix.h    | 55 +++++++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 1fed906042aa..3433f50e2de2 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -61,7 +61,7 @@ void V1_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index 9d00f31a2d9d..a18b6e1f9ed5 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -69,7 +69,7 @@ void V2_minix_truncate(struct inode * inode)
 	truncate(inode);
 }
 
-unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
+unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
 {
 	return nblocks(size, sb);
 }
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 972a71c5b481..d124145850e9 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -67,39 +67,44 @@ struct minix_sb_info {
 void __minix_error_inode(struct inode *inode, const char *function,
 			 unsigned int line, const char *fmt, ...);
 
-struct inode *minix_iget(struct super_block *, unsigned long);
-struct minix_inode *minix_V1_raw_inode(struct super_block *, ino_t, struct buffer_head **);
-struct minix2_inode *minix_V2_raw_inode(struct super_block *, ino_t, struct buffer_head **);
-struct inode *minix_new_inode(const struct inode *, umode_t);
+struct inode *minix_iget(struct super_block *sb, unsigned long ino);
+struct minix_inode *minix_V1_raw_inode(struct super_block *sb, ino_t ino,
+		struct buffer_head **bh);
+struct minix2_inode *minix_V2_raw_inode(struct super_block *sb, ino_t ino,
+		struct buffer_head **bh);
+struct inode *minix_new_inode(const struct inode *dir, umode_t mode);
 void minix_free_inode(struct inode *inode);
 unsigned long minix_count_free_inodes(struct super_block *sb);
 int minix_new_block(struct inode *inode);
 void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
-int minix_getattr(struct mnt_idmap *, const struct path *,
-		struct kstat *, u32, unsigned int);
+int minix_getattr(struct mnt_idmap *idmap, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int flags);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 
-extern void V1_minix_truncate(struct inode *);
-extern void V2_minix_truncate(struct inode *);
-extern void minix_truncate(struct inode *);
-extern void minix_set_inode(struct inode *, dev_t);
-extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
-extern unsigned V1_minix_blocks(loff_t, struct super_block *);
-extern unsigned V2_minix_blocks(loff_t, struct super_block *);
-
-struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
-int minix_add_link(struct dentry*, struct inode*);
-int minix_delete_entry(struct minix_dir_entry *, struct folio *);
-int minix_make_empty(struct inode*, struct inode*);
-int minix_empty_dir(struct inode*);
+void V1_minix_truncate(struct inode *inode);
+void V2_minix_truncate(struct inode *inode);
+void minix_truncate(struct inode *inode);
+void minix_set_inode(struct inode *inode, dev_t rdev);
+int V1_minix_get_block(struct inode *inode, long block,
+		struct buffer_head *bh, int create);
+int V2_minix_get_block(struct inode *inode, long block,
+		struct buffer_head *bh, int create);
+unsigned int V1_minix_blocks(loff_t size, struct super_block *sb);
+unsigned int V2_minix_blocks(loff_t size, struct super_block *sb);
+
+struct minix_dir_entry *minix_find_entry(struct dentry *dentry,
+	struct folio **foliop);
+int minix_add_link(struct dentry *dentry, struct inode *inode);
+int minix_delete_entry(struct minix_dir_entry *de, struct folio *folio);
+int minix_make_empty(struct inode *inode, struct inode *dir);
+int minix_empty_dir(struct inode *inode);
 int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode);
-struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
-ino_t minix_inode_by_name(struct dentry*);
+struct minix_dir_entry *minix_dotdot(struct inode *dir, struct folio **foliop);
+ino_t minix_inode_by_name(struct dentry *dentry);
 
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
@@ -116,7 +121,8 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 	return container_of(inode, struct minix_inode_info, vfs_inode);
 }
 
-static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
+static inline unsigned int minix_blocks_needed(unsigned int bits,
+		unsigned int blocksize)
 {
 	return DIV_ROUND_UP(bits, blocksize * 8);
 }
@@ -150,7 +156,8 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
  * big-endian 16bit indexed bitmaps
  */
 
-static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
+static inline int minix_find_first_zero_bit(const void *vaddr,
+		unsigned int size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
 	unsigned short num;
-- 
2.47.3

