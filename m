Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E224921A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120569; cv=none; b=hw5Xfudhr1LDOxIDWt8QIa08IWtXCkgWuFm+Ow7AR0tA5I7frQRKfqbB2s27rPStZOUgGRGd5W3Eh9AZwJnWh6nnQ2U73zq9IaQVQ05VMo4gjeHVwmuJsJfvcm5E48ADclgaKs5T9Lh13bLQaLEWIXvo9ghEmQ5xNv+AbMq/4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120569; c=relaxed/simple;
	bh=D6jlcwbnR+g5EMkQgbi+wNK71CRgyGoU3BDxrCye7Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnaB8yUUPT/5cKvOYF/984o2QejDSWfzBxq0jJhpiBlCiJHUhWg3OVn/ks9TnEVFqldyOOBUO4IclKxsCOXYF8/SvTL04Pg4VwvpVqZ2O9UbdZXMmA5qbJKzXWoqyrAbk5GhtoJR6PqOXNArLgZyxfp1hXwA/MQBNb4zj+xKfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adSzUe+c; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adSzUe+c"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8867815eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120547; x=1779725347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt5iuo/Mn+BLiddYjPlNVAJnp/6tZOTavwSOYrXtXKE=;
        b=adSzUe+cNe9xAvnLQQDqms+DEcn3jh/VqFO/JuSSO7uUskio7YuXdebPxElVrso5Xu
         kKKB5seuZjExUAT5nJvbRtdTaCU1/lRSCxBjkjrmpVsbHzgrAXY4kkG5uo6c1ZUbiN/+
         u4s0K6WIlVI0Tjycq+zWTjfXWqF0Bj88Z8hHB5qLDcbkiJTEnZmOy1W+GoCKCGGgtw9v
         wMRJKpYDLUU4Q379AHV+vVeUuDHfvbhbxmvwhZ9h6/nqqc7hKY0vP5HEEo9XItaHB+uz
         4s4PoqxzJS2iHN82FXt8HKz5SW3DMDQ1k6g8/cxp0Jt8q/m+tDI/0XQVW2k8tvtavBp3
         IHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120547; x=1779725347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nt5iuo/Mn+BLiddYjPlNVAJnp/6tZOTavwSOYrXtXKE=;
        b=QyKJXGlaP0NfgyIpBo0YpxPnC/uaTHF59oHgKOjibvb0ZKsKiltJ5PZOsSbpTsjnnc
         kFpnH4fLnbLrL1QhfVPC6aHD/p0OnKdUPVutHNMUu57cffoyIqbxLwSV0e+MbaYXapGV
         HoNcKWx3STgQcGdGrvDeK2CSqNi/qgZ77rh8DNIfpn0ObeOSwACXGMY1OsqRIXPIuo2x
         Kg7gukKYHO4lZEPOD6R/MfLhJSWzQvZZxqX6jcNo77Q2S1CmBkpPz06yrbK2t2J7Nfi+
         9UsjLrFlQ/KpqSlqYFBIiyiYA3tQ7XnG95YPbGAeLAo+k/nTE3HQhbMgD/s9YpyBXOx5
         VwoQ==
X-Gm-Message-State: AOJu0YxUQpgoOqzzWDQxSWoOsDIfE3+EneJRxqVezllegfAPuNi0jDXT
	LtTmBGiJhh09/SkCRX51ADVAwHkiZEoofsV5xIWQsrtpU3Eh3VtLuXt/vVV2f2RqeA==
X-Gm-Gg: Acq92OHAgYX7RyIF/DGs1plkQ2Dnj26z3AysYen7ZHMh758h/4fDt0nvKePUIypYZCo
	LCnr3LygiaK3GK9QBSkZixhBahz4gG0krrEzFVp0UMnlaXPC2fhV7meQLzmBtT0xrr17JjWD+vo
	mV7vY0ysVdUgQRGkeq94YLQ+wSeIR/JxfDk69UgedcKXlG6Bciq39eYSt7G+sQk25MZTTBY5Vb4
	Ot4tKV/gAjRC1pAACc5VTMzudEHL0Tf4NxKC91+9v7BUYB+GG399HpMxTltDycRWdB/MQxWKpvf
	uwV7FZubjywv1pB5IxCl7kMgE+AZQybn3bAS4sr4DQERXgkqzAjpenXXLhOnHs/R7i4vBWEnmxI
	Z53Y6BV0dgLiZzDI0+NvlkChC7ms7jHozj2/04WaEw9/pYTropIEJx+mkxS60F2vCgwDSD1oNXa
	0EG+31Hs+wX8EHrKS+CQTQhM0yqBC7fQov0BKMHI7sq1CzLiT+8Lb0VgGWucM7cyL0xFkzNzhW/
	ljtF/9niH/RI7K2QOJAFSZ306zU0WfX
X-Received: by 2002:a05:7300:b586:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-3039812a5a6mr6738148eec.3.1779120547150;
        Mon, 18 May 2026 09:09:07 -0700 (PDT)
Received: from localhost.localdomain (157-131-96-99.fiber.dynamic.sonic.net. [157.131.96.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm13778284eec.23.2026.05.18.09.09.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 09:09:06 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org,
	Yuezhang.Mo@sony.com,
	rochan.avlur@gmail.com,
	rochan.avlur@skydio.com,
	sj1557.seo@samsung.com,
	stable@vger.kernel.org
Subject: [PATCH v3] exfat: preserve benign secondary entries during rename and move
Date: Mon, 18 May 2026 09:08:36 -0700
Message-ID: <20260518160836.29876-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
References: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rochan Avlur <rochan.avlur@skydio.com>

Commit 8258ef28001a ("exfat: handle unreconized benign secondary
entries") added cluster freeing for benign secondary entries inside
exfat_remove_entries().  However, exfat_remove_entries() is also called
from the rename and move paths (exfat_rename_file and exfat_move_file),
where the old entry set is being relocated rather than deleted.  This
causes benign secondary entries such as vendor extension entries to be
silently destroyed on rename or cross-directory move, violating the
exFAT spec requirement (section 8.2) that implementations preserve
unrecognized benign secondary entries.

Fix this by adding a free_benign parameter to exfat_remove_entries()
so that callers can choose whether to free benign secondary clusters,
and helper functions to count and copy trailing benign secondary entries
from the old entry set to the new one.  Both exfat_rename_file() and
exfat_move_file() now use these to preserve extra entries across
relocation.

Also clean up the error paths in both functions so that newly allocated
entry sets are properly deleted on failure, avoiding duplicate directory
entries on disk.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@skydio.com>
---
v3:
 - Merge exfat_remove_entries_nofree() into exfat_remove_entries() with
   a bool free_benign parameter.
 - Move new_entries and src_start calculations after the early return in
   exfat_copy_trailing_entries().
 - Clean up error paths in exfat_rename_file() and exfat_move_file() to
   delete newly allocated entries on failure.
v2:
 - Resent with proper formatting (no content changes from v1).

 fs/exfat/dir.c      |   4 +-
 fs/exfat/exfat_fs.h |   2 +-
 fs/exfat/namei.c    | 140 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 127 insertions(+), 19 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e1..04b4ca872 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -505,7 +505,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order)
+		int order, bool free_benign)
 {
 	int i;
 	struct exfat_dentry *ep;
@@ -513,7 +513,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 	for (i = order; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
+		if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef625..33fd6e6aa 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -499,7 +499,7 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 		struct exfat_uni_name *p_uniname);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order);
+		int order, bool free_benign);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493..cac6899bf 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -820,7 +820,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_set_volume_dirty(sb);
 
 	/* update the directory entry */
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (err)
@@ -981,7 +981,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
 	if (err)
@@ -1008,6 +1008,55 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
+/*
+ * Count benign secondary entries beyond the filename entries.
+ * Returns the count, or -EIO if the entry set is inconsistent.
+ */
+static int exfat_count_extra_entries(struct exfat_entry_set_cache *es)
+{
+	struct exfat_dentry *stream;
+	unsigned int name_entries;
+	int extra;
+
+	stream = exfat_get_dentry_cached(es, ES_IDX_STREAM);
+	name_entries = EXFAT_FILENAME_ENTRY_NUM(stream->dentry.stream.name_len);
+	extra = es->num_entries - (ES_IDX_FIRST_FILENAME + name_entries);
+
+	return extra >= 0 ? extra : -EIO;
+}
+
+/*
+ * Copy benign secondary entries from @src_es to @dst_es, placing them after
+ * the new filename entries.  Updates num_ext and the directory checksum.
+ */
+static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src_es,
+		struct exfat_entry_set_cache *dst_es)
+{
+	struct exfat_dentry *ep;
+	int extra = exfat_count_extra_entries(src_es);
+	int new_entries, src_start, i;
+
+	if (extra <= 0)
+		return extra < 0 ? extra : 0;
+
+	new_entries = dst_es->num_entries - extra;
+	src_start = src_es->num_entries - extra;
+
+	if (new_entries < ES_IDX_FIRST_FILENAME ||
+	    src_start < ES_IDX_FIRST_FILENAME)
+		return -EIO;
+
+	for (i = 0; i < extra; i++) {
+		*exfat_get_dentry_cached(dst_es, new_entries + i) =
+			*exfat_get_dentry_cached(src_es, src_start + i);
+	}
+
+	ep = exfat_get_dentry_cached(dst_es, ES_IDX_FILE);
+	ep->dentry.file.num_ext += extra;
+	exfat_update_dir_chksum(dst_es);
+	return 0;
+}
+
 static int exfat_rename_file(struct inode *parent_inode,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
@@ -1016,6 +1065,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_old_name_entries, num_new_name_entries;
+	unsigned int num_extra_entries, num_total_entries;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1023,21 +1074,34 @@ static int exfat_rename_file(struct inode *parent_inode,
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
 		return num_new_entries;
+	num_new_name_entries = EXFAT_FILENAME_ENTRY_NUM(p_uniname->name_len);
 
 	ret = exfat_get_dentry_set_by_ei(&old_es, sb, ei);
-	if (ret) {
-		ret = -EIO;
-		return ret;
-	}
+	if (ret)
+		return -EIO;
 
 	epold = exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
 
-	if (old_es.num_entries < num_new_entries) {
+	ret = exfat_count_extra_entries(&old_es);
+	if (ret < 0)
+		goto put_old_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+	/* needed to detect whether in-place rename would shift extras */
+	num_old_name_entries =
+		old_es.num_entries - ES_IDX_FIRST_FILENAME - num_extra_entries;
+
+	/*
+	 * Relocate when the old slot is too small, or when extra
+	 * entries exist and the name entry count changes.
+	 */
+	if (old_es.num_entries < num_total_entries ||
+	    (num_extra_entries && num_old_name_entries != num_new_name_entries)) {
 		int newentry;
 		struct exfat_chain dir;
 
 		newentry = exfat_find_empty_entry(parent_inode, &dir,
-				num_new_entries, &new_es);
+				num_total_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1056,11 +1120,24 @@ static int exfat_rename_file(struct inode *parent_inode,
 
 		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
 
-		ret = exfat_put_dentry_set(&new_es, sync);
+		ret = exfat_copy_trailing_entries(&old_es, &new_es);
 		if (ret)
+			goto put_new_es;
+
+		ret = exfat_put_dentry_set(&new_es, sync);
+		if (ret) {
+			/* Best-effort delete to avoid duplicate entries */
+			if (!exfat_get_dentry_set(&new_es, sb, &dir,
+						  newentry,
+						  ES_ALL_ENTRIES)) {
+				exfat_remove_entries(parent_inode, &new_es,
+						    ES_IDX_FILE, false);
+				exfat_put_dentry_set(&new_es, false);
+			}
 			goto put_old_es;
+		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
+		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE, false);
 		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
@@ -1069,11 +1146,19 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+		exfat_remove_entries(parent_inode, &old_es,
+				num_new_entries + num_extra_entries, false);
 		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		if (num_extra_entries) {
+			epold->dentry.file.num_ext += num_extra_entries;
+			exfat_update_dir_chksum(&old_es);
+		}
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
+put_new_es:
+	exfat_remove_entries(parent_inode, &new_es, ES_IDX_FILE, false);
+	exfat_put_dentry_set(&new_es, false);
 put_old_es:
 	exfat_put_dentry_set(&old_es, false);
 	return ret;
@@ -1086,6 +1171,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1095,8 +1181,14 @@ static int exfat_move_file(struct inode *parent_inode,
 	if (ret)
 		return -EIO;
 
+	ret = exfat_count_extra_entries(&mov_es);
+	if (ret < 0)
+		goto put_mov_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+
 	newentry = exfat_find_empty_entry(parent_inode, &newdir,
-			num_new_entries, &new_es);
+			num_total_entries, &new_es);
 	if (newentry < 0) {
 		ret = newentry; /* -EIO or -ENOSPC */
 		goto put_mov_es;
@@ -1115,20 +1207,36 @@ static int exfat_move_file(struct inode *parent_inode,
 	*epnew = *epmov;
 
 	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+
+	ret = exfat_copy_trailing_entries(&mov_es, &new_es);
+	if (ret)
+		goto put_new_es;
+
+	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE, false);
 
 	ei->dir = newdir;
 	ei->entry = newentry;
 
 	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(parent_inode));
-	if (ret)
+	if (ret) {
+		/* Best-effort delete to avoid duplicate entries */
+		if (!exfat_get_dentry_set(&new_es, parent_inode->i_sb,
+					  &newdir, newentry,
+					  ES_ALL_ENTRIES)) {
+			exfat_remove_entries(parent_inode, &new_es,
+					    ES_IDX_FILE, false);
+			exfat_put_dentry_set(&new_es, false);
+		}
 		goto put_mov_es;
+	}
 
 	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(parent_inode));
 
+put_new_es:
+	exfat_remove_entries(parent_inode, &new_es, ES_IDX_FILE, false);
+	exfat_put_dentry_set(&new_es, false);
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-
 	return ret;
 }
 
@@ -1202,7 +1310,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 		}
 
-		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE, true);
 
 		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
 		if (ret)
-- 
2.45.2

