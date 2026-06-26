Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBE2EA47C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505286; cv=none; b=P9E95Zn1oQzsjlVTbaP7qDzyMHJydq6JQqolGmOOBEhPZBFnGC+L2OP3+oUM/yq3VgKLPm9JVLSFBu9aRk5k5nKL+RnNkSFUHJivYeURnvWeCUuaAJ5bLuN4bVNMuLKj0F9zNcESqOV5ubahlzqo+lF5OqQeo/hJs26OHWsklXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505286; c=relaxed/simple;
	bh=XD0mZRfO+xiz2MHlvE2755IAm54EReVjcUQfo2b6irE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiIAVoAFvO0d7Ksm5Y2oVyAkrJsFAHZPPOZkwnxY80UVa0lQ5+MpMKwaFfzSgcTtMk7wRJZ8BXweyxhFnoYgYHbTat5CdswUBB1Z5Ds88z9MB3MXyEq+Baul59S2cr+KY3ZVSOLtQsYmcoqJHVNXYmi6lPHYzv8rcYGk8OXWWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXFHGSt5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXFHGSt5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f236418so678619b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782505284; x=1783110084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD6Q9mEYV+9yhyX38JJYbLL34o61PhRiwia/Vo9GOQA=;
        b=FXFHGSt5AzO6vB1a/0gjurUTrXYjlAs4mirIrbTs31kG6xVfT5mT8v+DfciJVGMCbG
         pmUvpWKtzGXttdCEmosMOS/8cjW7nHUJhHekDN/VnGRWEnpwSm0UO8NYTq0exna8WYjs
         9B4LlqJlK+RzzJQB+zkkrmb+ALzElLDGorFKWG19Ho5y5Ve4bktsCP5SnfvUqTUgnQiB
         kM+DQaXnTskjtB5+aTitzUcCKrWebfMoVS6gg+Bi8bqTthSc9oKbQp2TTVm+ieUWmjFc
         Ebqe5gTj8BAl5maLd2v4/4mcGIbiTct7fW3keL2AmqxBD5f2ri/AwUUO60OIsS2c8OMH
         shUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505284; x=1783110084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qD6Q9mEYV+9yhyX38JJYbLL34o61PhRiwia/Vo9GOQA=;
        b=hrxcjVDWFirhHFyxX2BU7XjVNkgciNq42uGo6Vm4OI9LyUdUXM3RBLWQUaqX2N/x1o
         77vDMsonR/Kr8PoIj8wTtjOCqZnUmB52/rF1Dj7KxhhQgQrpqYHOrbYxtPGUedeHcOU+
         neNGQpBARDdZDUr7Y88WXzDiQGY7Xm18+NjruGtN3W20bvGfZHAhWvuLhqt6jOlBbMiv
         T+eSh9DvAZu0wWrLXa+Mc9l5QC9oKQBUsu2eoAHy4sOGY1qgoclIiiKv0kxYkeB4BVZ3
         erMF4jR0rbvZiMXBZE27nxxPoxUbgXNL6FarFKVOO+LmxTZKpI9u80vT6d95+cPZfKwJ
         h44g==
X-Gm-Message-State: AOJu0YxEgVnV3iMT6MqjCkYq0yz1Sc3cchuw+REK01/2JIf2gxG4wCg+
	Ot8NZ/lJBWDLbayEUoG1gjm/+qCSjXanxj4A3PYgaGx4d60xQt3XeWGL
X-Gm-Gg: AfdE7ckIt/AHNsbPxEzVo6gRUwa4RqNwHFevfw3KRaTnPEqL8zvUWN1SGOqluWoD1Ih
	X78RvNNUochhLCZefhP5wvB9grVzhDO1cWYcCEjCQPruJ4VdgwUeSmgyOlB7RxphEe3kBo0qRsF
	CbyzpOodkWfz/CK5NplRr3GVEhN0J/MyIvfCP15d9LLharBlVpoo+Dqc/SUDLJsmdnDhmEpxoL/
	n2aGWsyxLA9wEuV6HCSm7lMY6mDZvuYnruMj75CgIhdxaDb4TkXsEojwK4ODh6upYzgi5YTeBMl
	y/+iLX/qJUL+L9Vq++XdH03cZdRBcAce/Gm/V2ArYnk8mtrs9KJPXAcCmJIh1d66hKWACEUhaFz
	kGp+0ERXPRvDsfjYQ+mkSxn/QdAo84LvPIN22F97fmHRSBgb3Hlkha8ixRiH/Jmw=
X-Received: by 2002:a05:6a00:130f:b0:82c:e692:1f91 with SMTP id d2e1a72fcca58-845b3bf3d6cmr8710033b3a.39.1782505283654;
        Fri, 26 Jun 2026 13:21:23 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845c104113esm2671181b3a.57.2026.06.26.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:21:22 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: syzbot+ci97bc680341b3b928@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	syzkaller-bugs@googlegroups.com,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [syzbot ci] Re: minix: convert to iomap and add direct I/O
Date: Fri, 26 Jun 2026 13:21:18 -0700
Message-ID: <20260626202118.2464544-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a3ed243.656f0a6b.201ab1.0000.GAE@google.com>
References: <6a3ed243.656f0a6b.201ab1.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently I did this wrong the first time. I misunderstood and sent one
patch covering all the changes differing from master, rather than just
patching the changes to fix the errors syzbot found.

#syz test

---
 fs/minix/file.c         |  4 ++--
 fs/minix/inode.c        | 11 ++++++-----
 fs/minix/itree_common.c | 11 ++++++++++-
 fs/minix/minix.h        |  3 +++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/minix/file.c b/fs/minix/file.c
index 1f4217115401..b07c853fa43a 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -175,8 +175,8 @@ const struct file_operations minix_file_operations = {
 	.splice_write	= iter_file_splice_write,
 };
 
-static int minix_setattr(struct mnt_idmap *idmap,
-			 struct dentry *dentry, struct iattr *attr)
+int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+	struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index cd12e59ce9b9..8a79ff82a656 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -444,10 +444,10 @@ static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
 	if (pos < wpc->iomap.offset ||
 			pos >= wpc->iomap.offset + wpc->iomap.length) {
 		if (INODE_VERSION(wpc->inode) == MINIX_V1)
-			error = V1_minix_iomap_begin(wpc->inode, pos, len, 0,
+			error = V1_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
 				&wpc->iomap, NULL);
 		else
-			error = V2_minix_iomap_begin(wpc->inode, pos, len, 0,
+			error = V2_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
 				&wpc->iomap, NULL);
 		if (error)
 			return error;
@@ -490,7 +490,7 @@ static int minix_writepages(struct address_space *mapping,
 
 static int minix_read_folio(struct file *file, struct folio *folio)
 {
-	const struct iomap_ops *ops = minix_iomap_ops_ver(file->f_inode);
+	const struct iomap_ops *ops = minix_iomap_ops_ver(folio->mapping->host);
 
 	iomap_bio_read_folio(folio, ops);
 	return 0;
@@ -504,7 +504,7 @@ static int minix_block_read_folio(struct file *file, struct folio *folio)
 
 static void minix_readahead(struct readahead_control *rac)
 {
-	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->file->f_inode);
+	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->mapping->host);
 
 	iomap_bio_readahead(rac, ops);
 }
@@ -545,7 +545,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, ops);
 }
 
-static const struct address_space_operations minix_aops = {
+const struct address_space_operations minix_aops = {
 	.dirty_folio	= iomap_dirty_folio,
 	.invalidate_folio = iomap_invalidate_folio,
 	.read_folio = minix_read_folio,
@@ -575,6 +575,7 @@ static const struct address_space_operations minix_dir_aops = {
 static const struct inode_operations minix_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= minix_getattr,
+	.setattr	= minix_setattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index c3cd2c75af9c..5a8b73a7beda 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -311,7 +311,16 @@ static inline void truncate (struct inode * inode)
 	long iblock;
 
 	iblock = (inode->i_size + sb->s_blocksize -1) >> sb->s_blocksize_bits;
-	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
+
+	/* Depending on what address space operations are being used by the
+	 * inode being truncated, we need to either call iomap_truncate_page or
+	 * block_truncate_page.
+	 */
+	if (inode->i_mapping->a_ops == &minix_aops)
+		iomap_truncate_page(inode, inode->i_size, NULL,
+			minix_iomap_ops_ver(inode), NULL, NULL);
+	else
+		block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
 	n = block_to_path(inode, iblock, offsets);
 	if (!n)
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index face74100346..270e4e0620a1 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -58,6 +58,8 @@ void minix_free_block(struct inode *inode, unsigned long block);
 unsigned long minix_count_free_blocks(struct super_block *sb);
 int minix_getattr(struct mnt_idmap *, const struct path *,
 		struct kstat *, u32, unsigned);
+int minix_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+	struct iattr *attr);
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 struct mapping_metadata_bhs *minix_get_metadata_bhs(struct inode *inode);
 int minix_fsync(struct file *file, loff_t start, loff_t end, int datasync);
@@ -88,6 +90,7 @@ extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
 	loff_t length, unsigned int flags, struct iomap *iomap,
 	struct iomap *srcmap);
 
+extern const struct address_space_operations minix_aops;
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
 extern const struct file_operations minix_file_operations;
-- 
2.47.3

