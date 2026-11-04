Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763983;
	b=ghPLhjPoLevKici6reQVGkQVOMh8en3BUmXbfdj18kFQMaOzmly6lWdfxR9m+gkgdl2t
	 Nr0tDI1TlyV10dab5KsyA8sEVyQoBjF2bZHF4dU5k3q3MnPMznoX8j2Y/s1bc2FnNQxoT
	 FKNz+jzoXZqSekCCmY+/JK8m0V49KlOwt+RO/zPIWGvWnwq0/qCCXmxUCBg/fiv/VXwzv
	 wMvF2BH5mgU3/ot1liVyuMSFXkuBRkW8kb7yR4S53lZPj91rLuampXFyDLofunO7jKrmT
	 20lSjwKMMIY5qGMw8W3ULgaSUAOSPH+kEmkXU1RMU8dR3Y1zWURj9cqFVpF9Yq5jumA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RNkwsHEgQrZazZ9jow0ryBzcpVJ/SS9akfZZfGyqRxU=;
	b=YSTd2LArg1T5Fa9IA+Jw6XRckS9/K8HgnAI4ichcGkaOp1vHq2HWPxdpextN2y7Pqor9
	 pu9wayaqvVufn5tyBaBHjvCD4M0gD2Hg3K9wmqnbPITcfK2WNZvRcb+Kg6dHxkI9WX52p
	 JHBqPJhwArn6I3/1JNIvgCc9644Tdx4/wbppI/1JxIp5s7kwj5ZSMJ6aVIURKffnQoEve
	 LeAb35tzfp/whY9MZ/3xBADt1P5+DnQEOrcez5owuWVYhaQmDfrkGhngfcAZJeaTdSip8
	 LKbc+pble/RhtKITjTGvQPanhujX76R2K8dDfD4XbqAKbuudG4iNngrmgY7fT536yNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cm6OG2PG;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96C606A336
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 03:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE96C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cm6OG2PG
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab395abf79so2912877b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 19:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793763982; x=1794368782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNkwsHEgQrZazZ9jow0ryBzcpVJ/SS9akfZZfGyqRxU=;
        b=cm6OG2PGouECdjJLtUrxwdkC1MhAftWS8LzzCUphfoAxaLrDIbxooJbz5CWY1gd6Gi
         vyMVEBtu0rNTpPCzGdAQBXqwzK6nR4tK48oc453DDiwceSkst2t3Sqv2FPV577ss0whi
         7NHc7UgTYBkQV3Hm+/alFBVdwf19Th1jizcRBsuUJnIA2ykDEPunq1zRmeKRgCHU9QAE
         POTjsdSWyc+tlZNe35BcC3tYSVZMCh6Oo/lvDugrS6PUyh4dDOiHuEtTbpIJs0KMF6Fy
         T53Pwtjtu4LEnafx3+aXXmwbTmRpt3jhBm7j43br8rVTpM8QcPdAjt7ENZNxONfgD6tq
         BLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763982; x=1794368782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNkwsHEgQrZazZ9jow0ryBzcpVJ/SS9akfZZfGyqRxU=;
        b=qAPABIKdyhtcDdPNpi4T/Ln/Jl7T5Nb6FlOPtiDsyLrUL1UgJvG8AKGj/zs5UsgkDK
         RNIHSp5WZWQHK300EYDFGohL/atpZZm/1AXyUGECd0cnn9rdz4ubCcgJ/ifDSetBB99o
         9nXylCW2jbjvENp8F0Q9iZFySdKN/HexzrOHmajzRFQg4WJpCrm13/ZEb4dR/clR/edu
         aYVCKPUA+0CvXWXGmiVviyW6kwKnT0xptXadER9gQJJ1v3wgGEGwfj8Xw11lqB0MTXSt
         7YGwS5vyz5kl6McTrE3EC4Sdt2/XIyoK2xwjBlM2tbNQ0endrNxOB/pHwwcjn6qO++n+
         8y/A==
X-Gm-Message-State: APuU4Z8ssMEdCgNFENrJU8Mk8B8CkAHzIbqtur0N44zypttysdDvxg2T
	Xv8jOUjeIpVthYYLZBr+DCi+FZ4IjDauSIekI6eznl2XCqw6e/Lr2DdQZqBfuFcC2KNvp0mq/23
	io78D5tk=
X-Gm-Gg: AYBFou0ErhrF7ith01uFAiUHdiKktMoN0jZcBBHnF6VwFGzVbfTJLG1dx77g+4XZ8Og
	qA4uwd3EHwlCSe4L/yqLukhEx6rTYi4mm1Sjg4WSO19fUJgwgOclMUakEPiXzVructr8xhi1b2O
	1ReBjVkONkIysV19UAcPCCDkjDB9IQM9TXpW1PyQOhvIzc2xsP0jTRRm0EPqrPSP6B82HZzDXCf
	d+ZLpK8qXpCdQxvk4x3YYYczsVHF91sXB4H7rid8XpLC124ft9MjI1W2BP/a904BMLgwCvMXp8s
	fGdk5cnJo9zDIBqN6/W8rjnMvm2R37V8RJl6LW2nDqp6gZof9t0/WrGnr48nq5AZy/Fh4pXjmLA
	3S5R5uqs8T7geIMzeyV4XO6ACvj01PWF/h1a6Y61Iv0h4qllCy9TFAbo/3v6l90QC2yRb3pgUbI
	YeXrxN7wrM8rQubtKVxWFKNkBmecCue7GepijiXWZNeGqHq9GpUgnn3SwxQyJE4ZZEiKrTgugE4
	qdkq+Mn2xAiGCGWAiyFAFjXhfkN6VsTPB8vdFosnwrl5Of3Jq/Dn0YyGRdYTFxo53j3TeZo8i+9
	sG+PDbJpuymRedh3u5WJmdLYRwCSx7Omv27rM/CH+UGWesFcqTpSk+HORnrgPdjkoO7mP6U/s+I
	cNgCJ8qRks7m5y24FJ6cvDjoRInL8NxkJDiU9GomdTxEKK991j+p5NIMpnPg=
X-Received: by 2002:a05:690c:6d81:b0:8b2:e27b:95db with SMTP id 00721157ae682-8b2e27b991fmr63867707b3.2.1793763981761;
        Tue, 03 Nov 2026 19:46:21 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1921:d22d:3124:a258])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309711412sm10918117b3.3.2026.11.03.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:46:21 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/2] hfsplus: make hidden directory name independent from mount's nls
Date: Tue,  3 Nov 2026 19:46:04 -0800
Message-ID: <20261104034605.1582293-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104034605.1582293-1-slava@dubeyko.com>
References: <20261104034605.1582293-1-slava@dubeyko.com>
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

The catalog key of the hidden directory is built from
HFSP_HIDDENDIR_NAME, that is UTF-8 string, by means of the nls table
of the mount. hfsplus_fill_super() works around it by temporarily
replacing sbi->nls with utf8 table. However, hfsplus_reconfigure()
creates the hidden directory on remount read-write with the mount's
nls table. As a result, for example, with nls=cp437 the hidden
directory is created with garbled name that neither macOS nor
the next mount recognizes, and yet another hidden directory is
created on the next read-write mount. Temporary replacement of
sbi->nls is not an option in hfsplus_reconfigure() because lookups
are running concurrently and use sbi->nls.

Define the hidden directory name as constant Unicode string and
introduce hfsplus_create_cat_uni() that creates catalog records for
already converted name. Use hfsplus_cat_build_key_uni() for hidden
directory lookup and remove the temporary nls replacement from
hfsplus_fill_super(). The rollback in hfsplus_create_hidden_dir()
calls hfsplus_delete_cat() with NULL name, so the name is taken
from the thread record.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/catalog.c       | 83 ++++++++++++++++++++++++++++++--------
 fs/hfsplus/hfsplus_fs.h    |  5 +++
 fs/hfsplus/super.c         | 66 ++++++++++++++++--------------
 include/linux/hfs_common.h | 20 ++++++++-
 4 files changed, 124 insertions(+), 50 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index fe11c4b6dd99..5e53a978d420 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -40,8 +40,8 @@ int hfsplus_cat_bin_cmp_key(const hfsplus_btree_key *k1,
 }
 
 /* Generates key for catalog file/folders record. */
-int hfsplus_cat_build_key(struct super_block *sb,
-		hfsplus_btree_key *key, u32 parent, const struct qstr *str)
+int hfsplus_cat_build_key(struct super_block *sb, hfsplus_btree_key *key,
+			  u32 parent, const struct qstr *str)
 {
 	int len, err;
 
@@ -58,15 +58,15 @@ int hfsplus_cat_build_key(struct super_block *sb,
 
 /* Generates key for catalog thread record. */
 void hfsplus_cat_build_key_with_cnid(struct super_block *sb,
-			hfsplus_btree_key *key, u32 parent)
+				     hfsplus_btree_key *key, u32 parent)
 {
 	key->cat.parent = cpu_to_be32(parent);
 	key->cat.name.length = 0;
 	key->key_len = cpu_to_be16(6);
 }
 
-static void hfsplus_cat_build_key_uni(hfsplus_btree_key *key, u32 parent,
-				      struct hfsplus_unistr *name)
+void hfsplus_cat_build_key_uni(hfsplus_btree_key *key, u32 parent,
+			       const struct hfsplus_unistr *name)
 {
 	int ustrlen;
 
@@ -103,7 +103,7 @@ void hfsplus_cat_set_perms(struct inode *inode, struct hfsplus_perm *perms)
 }
 
 static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
-		u32 cnid, struct inode *inode)
+				    u32 cnid, struct inode *inode)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 
@@ -187,7 +187,23 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 	if (unlikely(err < 0))
 		return err;
 
-	return 10 + be16_to_cpu(entry->thread.nodeName.length) * 2;
+	return hfsplus_cat_thread_size(&entry->thread);
+}
+
+static int hfsplus_fill_cat_thread_uni(hfsplus_cat_entry *entry, int type,
+				       u32 parentid,
+				       const struct hfsplus_unistr *name)
+{
+	u16 len = be16_to_cpu(name->length);
+
+	entry->type = cpu_to_be16(type);
+	entry->thread.reserved = 0;
+	entry->thread.parentID = cpu_to_be32(parentid);
+	entry->thread.nodeName.length = name->length;
+	memcpy(entry->thread.nodeName.unicode, name->unicode,
+	       len * sizeof(hfsplus_unichr));
+
+	return hfsplus_cat_thread_size(&entry->thread);
 }
 
 /* Try to get a catalog entry for given catalog id */
@@ -250,17 +266,25 @@ static void hfsplus_subfolders_dec(struct inode *dir)
 	}
 }
 
-int hfsplus_create_cat(u32 cnid, struct inode *dir,
-		const struct qstr *str, struct inode *inode)
+/*
+ * Create catalog records for the name given either as @str (it is converted
+ * by means of the mount's nls table) or as already converted @name.
+ */
+static int __hfsplus_create_cat(u32 cnid, struct inode *dir,
+				const struct qstr *str,
+				const struct hfsplus_unistr *name,
+				struct inode *inode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int type;
 	int entry_size;
 	int err;
 
 	hfs_dbg("name %s, cnid %u, i_nlink %d\n",
-		str->name, cnid, inode->i_nlink);
+		str ? (const char *)str->name : "<unicode>",
+		cnid, inode->i_nlink);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
@@ -274,10 +298,14 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 		goto err2;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd.search_key, cnid);
-	entry_size = hfsplus_fill_cat_thread(sb, &entry,
-		S_ISDIR(inode->i_mode) ?
-			HFSPLUS_FOLDER_THREAD : HFSPLUS_FILE_THREAD,
-		dir->i_ino, str);
+	type = S_ISDIR(inode->i_mode) ?
+			HFSPLUS_FOLDER_THREAD : HFSPLUS_FILE_THREAD;
+	if (name)
+		entry_size = hfsplus_fill_cat_thread_uni(&entry, type,
+							 dir->i_ino, name);
+	else
+		entry_size = hfsplus_fill_cat_thread(sb, &entry, type,
+						     dir->i_ino, str);
 	if (unlikely(entry_size < 0)) {
 		err = entry_size;
 		goto err2;
@@ -293,9 +321,13 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	if (err)
 		goto err2;
 
-	err = hfsplus_cat_build_key(sb, fd.search_key, dir->i_ino, str);
-	if (unlikely(err))
-		goto err1;
+	if (name)
+		hfsplus_cat_build_key_uni(fd.search_key, dir->i_ino, name);
+	else {
+		err = hfsplus_cat_build_key(sb, fd.search_key, dir->i_ino, str);
+		if (unlikely(err))
+			goto err1;
+	}
 
 	entry_size = hfsplus_cat_build_record(&entry, cnid, inode);
 	err = hfs_brec_find(&fd, hfs_find_rec_by_key);
@@ -328,6 +360,23 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	return err;
 }
 
+int hfsplus_create_cat(u32 cnid, struct inode *dir,
+			const struct qstr *str, struct inode *inode)
+{
+	return __hfsplus_create_cat(cnid, dir, str, NULL, inode);
+}
+
+/*
+ * Create catalog records for the name that is independent from
+ * the mount's nls table (for example, the hidden directory name).
+ */
+int hfsplus_create_cat_uni(u32 cnid, struct inode *dir,
+			   const struct hfsplus_unistr *name,
+			   struct inode *inode)
+{
+	return __hfsplus_create_cat(cnid, dir, NULL, name, inode);
+}
+
 int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 {
 	struct super_block *sb = dir->i_sb;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6f240f87f8ff..e2d3f488142b 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -418,11 +418,16 @@ int hfsplus_cat_build_key(struct super_block *sb, hfsplus_btree_key *key,
 			   u32 parent, const struct qstr *str);
 void hfsplus_cat_build_key_with_cnid(struct super_block *sb,
 				     hfsplus_btree_key *key, u32 parent);
+void hfsplus_cat_build_key_uni(hfsplus_btree_key *key, u32 parent,
+			       const struct hfsplus_unistr *name);
 void hfsplus_cat_set_perms(struct inode *inode, struct hfsplus_perm *perms);
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd);
 int hfsplus_create_cat(u32 cnid, struct inode *dir, const struct qstr *str,
 		       struct inode *inode);
+int hfsplus_create_cat_uni(u32 cnid, struct inode *dir,
+			   const struct hfsplus_unistr *name,
+			   struct inode *inode);
 int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str);
 int hfsplus_rename_cat(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 		       struct inode *dst_dir, const struct qstr *dst_name);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 8c65741f2cf2..57858d8685ff 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -399,6 +399,28 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+/*
+ * On-disk UTF-16 name of the hidden directory: HFSP_HIDDENDIR_NUL_COUNT
+ * U+0000 (NUL) followed by HFSP_HIDDENDIR_SUFFIX. HFSP_HIDDENDIR_NAME_UTF8
+ * is the Linux representation of this name, where every NUL is replaced
+ * by U+2400 (SYMBOL FOR NULL). The catalog key of the hidden directory
+ * must not depend on the nls table of the mount.
+ */
+static const struct hfsplus_unistr hfsplus_hidden_dir_name_utf16 = {
+	.length = cpu_to_be16(HFSP_HIDDENDIR_NAME_UTF16_LEN),
+	.unicode = {
+		/* unicode[0 .. HFSP_HIDDENDIR_NUL_COUNT - 1] are U+0000 */
+		[HFSP_HIDDENDIR_NUL_COUNT] =
+		cpu_to_be16('H'), cpu_to_be16('F'), cpu_to_be16('S'),
+		cpu_to_be16('+'), cpu_to_be16(' '),
+		cpu_to_be16('P'), cpu_to_be16('r'), cpu_to_be16('i'),
+		cpu_to_be16('v'), cpu_to_be16('a'), cpu_to_be16('t'),
+		cpu_to_be16('e'), cpu_to_be16(' '),
+		cpu_to_be16('D'), cpu_to_be16('a'), cpu_to_be16('t'),
+		cpu_to_be16('a'),
+	},
+};
+
 /*
  * Create the hidden directory that keeps the indirect node files
  * of hard links. The caller is responsible for cancelling the
@@ -406,11 +428,12 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
  * set to true if the catalog file could be left in inconsistent state.
  */
 static int hfsplus_create_hidden_dir(struct super_block *sb,
-				     const struct qstr *str,
 				     bool *cat_damaged)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct inode *root = d_inode(sb->s_root);
+	const struct qstr str = QSTR_INIT(HFSP_HIDDENDIR_NAME_UTF8,
+					  HFSP_HIDDENDIR_NAME_UTF8_LEN);
 	struct inode *inode;
 	int err;
 
@@ -423,15 +446,17 @@ static int hfsplus_create_hidden_dir(struct super_block *sb,
 		goto out_unlock;
 	}
 
-	err = hfsplus_create_cat(inode->i_ino, root, str, inode);
+	err = hfsplus_create_cat_uni(inode->i_ino, root,
+				     &hfsplus_hidden_dir_name_utf16, inode);
 	if (err)
 		goto out_put_inode;
 
-	err = hfsplus_init_security(inode, root, str);
+	err = hfsplus_init_security(inode, root, &str);
 	if (err == -EOPNOTSUPP)
 		err = 0; /* Operation is not supported. */
 	else if (err) {
-		if (hfsplus_delete_cat(inode->i_ino, root, str)) {
+		/* The name is taken from the thread record. */
+		if (hfsplus_delete_cat(inode->i_ino, root, NULL)) {
 			pr_err("unable to remove hidden directory record\n");
 			*cat_damaged = true;
 		}
@@ -520,11 +545,9 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 	 * It could be absent if the volume was mounted read-only.
 	 */
 	if (!sbi->hidden_dir) {
-		struct qstr str = QSTR_INIT(HFSP_HIDDENDIR_NAME,
-					    sizeof(HFSP_HIDDENDIR_NAME) - 1);
 		bool cat_damaged;
 
-		err = hfsplus_create_hidden_dir(sb, &str, &cat_damaged);
+		err = hfsplus_create_hidden_dir(sb, &cat_damaged);
 		if (err) {
 			pr_err("unable to create hidden directory: err %d\n",
 			       err);
@@ -562,7 +585,6 @@ void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr)
 }
 
 static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
-					       const struct qstr *str,
 					       hfsplus_cat_entry *entry)
 {
 	struct hfs_find_data fd;
@@ -572,15 +594,13 @@ static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
 	if (unlikely(err))
 		return err;
 
-	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, str);
-	if (unlikely(err))
-		goto free_fd;
+	hfsplus_cat_build_key_uni(fd.search_key, HFSPLUS_ROOT_CNID,
+				  &hfsplus_hidden_dir_name_utf16);
 
 	err = hfsplus_brec_read_cat(&fd, entry);
 	if (err)
 		err = -ENOENT;
 
-free_fd:
 	hfs_find_exit(&fd);
 	return err;
 }
@@ -591,8 +611,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	hfsplus_cat_entry entry;
 	struct inode *root, *inode;
-	struct qstr str;
-	struct nls_table *nls;
 	u64 last_fs_block, last_fs_page;
 	int silent = fc->sb_flags & SB_SILENT;
 	int err;
@@ -610,19 +628,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			sbi->nls = load_nls_default();
 	}
 
-	/* temporarily use utf8 to correctly find the hidden dir below */
-	nls = sbi->nls;
-	sbi->nls = load_nls("utf8");
-	if (!sbi->nls) {
-		pr_err("unable to load nls for utf8\n");
-		goto out_unload_nls;
-	}
-
 	/* Grab the volume header */
 	if (hfsplus_read_wrapper(sb)) {
 		if (!silent)
 			pr_warn("unable to find HFS+ superblock\n");
-		goto out_unload_nls;
+		return err;
 	}
 	vhdr = sbi->s_vhdr;
 
@@ -723,9 +733,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_put_alloc_file;
 	}
 
-	str = (struct qstr)QSTR_INIT(HFSP_HIDDENDIR_NAME,
-				     sizeof(HFSP_HIDDENDIR_NAME) - 1);
-	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
+	err = hfsplus_get_hidden_dir_entry(sb, &entry);
 	if (err == -ENOENT) {
 		/*
 		 * Hidden directory is absent or it cannot be read.
@@ -756,14 +764,12 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sbi->hidden_dir) {
 			bool cat_damaged;
 
-			err = hfsplus_create_hidden_dir(sb, &str, &cat_damaged);
+			err = hfsplus_create_hidden_dir(sb, &cat_damaged);
 			if (err)
 				goto out_cancel_sync_work;
 		}
 	}
 
-	unload_nls(sbi->nls);
-	sbi->nls = nls;
 	return 0;
 
 out_cancel_sync_work:
@@ -782,8 +788,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_free_vhdr:
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-out_unload_nls:
-	unload_nls(nls);
 	return err;
 }
 
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..8a7bc9763eb9 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -57,8 +57,24 @@
 
 #define HFSP_MOUNT_VERSION		0x482b4c78	/* 'H+Lx' */
 
-#define HFSP_HIDDENDIR_NAME \
-	"\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80HFS+ Private Data"
+/*
+ * The name of the hidden directory is HFSP_HIDDENDIR_NUL_COUNT U+0000
+ * characters followed by HFSP_HIDDENDIR_SUFFIX. On disk, it is stored
+ * in UTF-16 and has HFSP_HIDDENDIR_NAME_UTF16_LEN characters. In Linux,
+ * it is HFSP_HIDDENDIR_NAME_UTF8, where every U+0000 is represented by
+ * U+2400 (SYMBOL FOR NULL); it has HFSP_HIDDENDIR_NAME_UTF8_LEN bytes.
+ */
+#define HFSP_HIDDENDIR_NUL_COUNT	4
+#define HFSP_HIDDENDIR_SUFFIX		"HFS+ Private Data"
+#define HFSP_HIDDENDIR_SUFFIX_LEN	(sizeof(HFSP_HIDDENDIR_SUFFIX) - 1)
+#define HFSP_HIDDENDIR_NAME_UTF16_LEN \
+	(HFSP_HIDDENDIR_NUL_COUNT + HFSP_HIDDENDIR_SUFFIX_LEN)
+#define HFSP_SYMBOL_FOR_NULL_UTF8	"\xe2\x90\x80"
+#define HFSP_HIDDENDIR_NAME_UTF8 \
+	(HFSP_SYMBOL_FOR_NULL_UTF8 HFSP_SYMBOL_FOR_NULL_UTF8 \
+	 HFSP_SYMBOL_FOR_NULL_UTF8 HFSP_SYMBOL_FOR_NULL_UTF8 \
+	 HFSP_HIDDENDIR_SUFFIX)
+#define HFSP_HIDDENDIR_NAME_UTF8_LEN	(sizeof(HFSP_HIDDENDIR_NAME_UTF8) - 1)
 
 /* various FIXED size parameters */
 #define HFS_SECTOR_SIZE			512	/* size of an HFS sector */
-- 
2.43.0

