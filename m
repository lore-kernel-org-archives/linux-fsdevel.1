Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19F38E8CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435930; cv=none; b=oeREzFCD7ZKvs2YYTKVmn/p2okvbZbb0fvxmcQddv//eZ/8XKpnTwybTGOhUY6w7m8ny3uw6fN1dd3DDwVZj7frFCWATEk/Dl+4l1EoRJZEOCs0TZiG49zPoA8K7eXkaKaiGR84ueMXy0VQjicCe22zt3TMwj2BNe6+vLVRVMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435930; c=relaxed/simple;
	bh=uOWBoRdk5ZoU3dwWukBaTW7aUvvQBtSMIQm7c5O/NUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gczb5qbVSSqcwx0ihR7JU4zo0CxLxSbW2fUEBsJImxkhER427H8sE+l4lS4rT8bV3bUubSkJsO5WZMX6r1KFRPxN900oNhaSsmF82FTBpt4ai89dDMs97MgMyIOrgxWibg5XKt1FEnkLXm0ddjBfzQYXICdQRJnuNPgCY0PVQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt81KCfw; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt81KCfw"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13643f6d1a9so705153c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435928; x=1780040728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA1eOt1CzL/h1dhQaVN/GCP0GGCMNU8fbLXR5dFf5Lk=;
        b=Xt81KCfwN9nv0koRWFJsVKMaKZCKnE0kynYnCdVRqbKe0zUpoMy1l0V9rv6Dy0aaX3
         Q2UxekvWVSRBAsprMg8Wj6wzdKhmf5Y8zP/2EBnrXGn2Hu7rpPBl5Zx7RP9pTr+HoOQA
         hjrfhA8WDcO1TYXbRyxBt1pwt5l0qOdMJCGXmkrKh4d4Lkob5ffyUHP2qEMWmx+WGvq4
         1Xk/5Yjv3bahfhEiCwn9mCbzFfc6TkXbz7DMf1Y37rtLRb7VetUAy9haPnIiY2jhK+Qy
         Y506LIIXLfpLCCCsfj4I8hwlGfstbyk/evE0/2OYfiIbVb14MCd+LDVsafBR+QuvKxk3
         EV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435928; x=1780040728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xA1eOt1CzL/h1dhQaVN/GCP0GGCMNU8fbLXR5dFf5Lk=;
        b=R7bDKRrYp+pUWC1MwRa5kbDngBzUGIp2XF2xiQK2wqetYi0/v5ZC77E14enAMADdpI
         /0DJkSxKW3mQm48tsxo+wDEdzxU8tHw6HzYpMAYEnNPPvjTOvPuI0GqtQtgxDIJmM3dl
         44yM4YvUSq2WTpru4u/r1y33myxVtRNk345wF8oW4yeZ0bb9gUBcFfwh4rj+aRC0zA+C
         6VEhK6UlUg4MgW0M3Z4In1xrzaEJCDaZiJBF0Pbc6IjQuAd//9dsyXw/CLdjSbu0EcF3
         lxyOz97HXGS5LNAWe7yaRZEdA02yjMjZcbiED4hDvZLSv6mqbQROd2BnJ03BGl8zl2kn
         Q99Q==
X-Forwarded-Encrypted: i=1; AFNElJ8TAUeNKAw2+XQQ4eHS6Y6vS5F/07JR68Uj1r60AgeHPs5EBQVIUGYFtzptlWqtgdYOlMeRDxaCtNUulnrP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGio2g+EFrogA1tj9asRQPQoL6lBNN8srss0Er4j8TrCE69Ywq
	3sGuZeHm/LXgLVTZhcUd6x9VqvpXHXnOQm0ZZFzeyXot5ph5knNMoZI=
X-Gm-Gg: Acq92OEVOvffKmRV/ooOjHIOdl2C2RnSIAJ+jTSmUtzdAC5GQAOhlTU58iWd49Otsj9
	qOH9wfGL6Tgnjks9W9BSIqTMNm8ixWQ2cgSaX0wcG6oZb9mLpBMOdYn808kPSeG48bdUjxXJncu
	3CEXePVjco+q7c4l1ktCCTpG4y8IrMQhc6Y2A5B+oW0wGasN+qjiVGKd+UmLjrX8uKddkUzYtAI
	Pnns7xb4xGGbAUMTMpy6Jg6zD5l2yh2v35BWfEDkDhHdQq50XczLjSBSdeDvCalUqzduciivvdB
	CRLpsntHp9amfJ39IXB5h9wZqP4v4/9x23pD3WJ6VorMu1QUey8OIUOiN8eDPzKtfEMcV6bA0OL
	5OBR66KL/fatJDg4UB+5YcQC61IYPjdTalmaNVu1K40C3rwQVZj4GEOdVaW1slcYiSoqJogIiaZ
	XnH6T25MQgjtwG9Y38EHHr2g0iDljvEq4G6L2DEvp53PWrk9yyieQMftiAXl7fRY16pTQ5htDUU
	h8+JrzWqq3dpu2Yvjtugg==
X-Received: by 2002:a05:7022:68a4:b0:132:7ab5:6cb8 with SMTP id a92af1059eb24-1365f6fd8ecmr876173c88.2.1779435927728;
        Fri, 22 May 2026 00:45:27 -0700 (PDT)
Received: from localhost.localdomain (157-131-96-99.fiber.dynamic.sonic.net. [157.131.96.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm515884eec.17.2026.05.22.00.45.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 00:45:27 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: Yuezhang.Mo@sony.com
Cc: linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	rochan.avlur@skydio.com,
	sj1557.seo@samsung.com,
	stable@vger.kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>
Subject: [PATCH v4] exfat: preserve benign secondary entries during rename and move
Date: Fri, 22 May 2026 00:44:41 -0700
Message-ID: <20260522074441.24645-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
so callers can suppress cluster freeing during relocation, and
extending exfat_init_ext_entry() to copy trailing benign secondary
entries from the old entry set into the new one internally.  Also
clean up the error paths to delete newly allocated entries on failure.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
v4:
 - Fold benign secondary copy into exfat_init_ext_entry(), removing
   exfat_copy_trailing_entries(); handle in-place shrink internally.
 - Simplify relocation condition to avoid unnecessary ENOSPC.
v3:
 - Merge exfat_remove_entries_nofree() into exfat_remove_entries() with
   a bool free_benign parameter.
 - Move new_entries and src_start calculations after the early return in
   exfat_copy_trailing_entries().
 - Clean up error paths in exfat_rename_file() and exfat_move_file() to
   delete newly allocated entries on failure.
v2:
 - Resent with proper formatting (no content changes from v1).

 fs/exfat/dir.c      | 50 ++++++++++++++++++++++---
 fs/exfat/exfat_fs.h |  5 ++-
 fs/exfat/namei.c    | 89 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac008ccaa97d..2f883107be6e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -470,32 +470,70 @@ static void exfat_free_benign_secondary_clusters(struct inode *inode,
 	exfat_free_cluster(inode, &dir);
 }
 
+/*
+ * exfat_init_ext_entry - initialize extension entries in a directory entry set
+ * @es:          target entry set
+ * @num_entries: number of entries excluding benign secondary entries
+ * @p_uniname:   filename to store
+ * @old_es:      optional source entry set with benign secondary entries, or NULL
+ * @num_extra:   number of benign secondary entries to copy from @old_es
+ *
+ * Set up the file, stream extension, and filename entries in @es, optionally
+ * preserving @num_extra benign secondary entries from @old_es.  @es and @old_es
+ * may refer to the same entry set; excess entries are marked as deleted.
+ */
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname)
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra)
 {
-	int i;
+	int i, src_start = 0, old_num;
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
 
-	es->num_entries = num_entries;
+	if (WARN_ON(num_extra < 0 || (num_extra && (!old_es ||
+		    old_es->num_entries < ES_IDX_FIRST_FILENAME + num_extra))))
+		num_extra = 0;
+
+	/*
+	 * Save old entry count and source position before modifying
+	 * es->num_entries, since old_es and es may point to the same
+	 * entry set.
+	 */
+	old_num = es->num_entries;
+	if (old_es && num_extra > 0)
+		src_start = old_es->num_entries - num_extra;
+
+	es->num_entries = num_entries + num_extra;
 	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
-	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
+	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1 + num_extra);
 
 	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
 
+	if (old_es && num_extra > 0) {
+		for (i = 0; i < num_extra; i++)
+			*exfat_get_dentry_cached(es, num_entries + i) =
+				*exfat_get_dentry_cached(old_es, src_start + i);
+	}
+
 	for (i = ES_IDX_FIRST_FILENAME; i < num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 		exfat_init_name_entry(ep, uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
+	/* Mark excess old entries as deleted (in-place shrink) */
+	for (i = num_entries + num_extra; i < old_num; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		exfat_set_entry_type(ep, TYPE_DELETED);
+	}
+
 	exfat_update_dir_chksum(es);
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order)
+		int order, bool free_benign)
 {
 	int i;
 	struct exfat_dentry *ep;
@@ -503,7 +541,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 	for (i = order; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
+		if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 89ef5368277f..e22b4ca3ec7f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -524,9 +524,10 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 		unsigned int type, unsigned int start_clu,
 		unsigned long long size, struct timespec64 *ts);
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname);
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order);
+		int order, bool free_benign);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2c5636634b4a..76b2e2db80fb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -503,7 +503,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	 * the first cluster is not determined yet. (0)
 	 */
 	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
-	exfat_init_ext_entry(&es, num_entries, &uniname);
+	exfat_init_ext_entry(&es, num_entries, &uniname, NULL, 0);
 
 	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (ret)
@@ -814,7 +814,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_set_volume_dirty(sb);
 
 	/* update the directory entry */
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (err)
@@ -969,7 +969,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
 	if (err)
@@ -996,6 +996,23 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
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
 static int exfat_rename_file(struct inode *parent_inode,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
@@ -1004,6 +1021,7 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_extra_entries, num_total_entries;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1013,19 +1031,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		return num_new_entries;
 
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
+
+	if (old_es.num_entries < num_total_entries) {
 		int newentry;
 		struct exfat_chain dir;
 
 		newentry = exfat_find_empty_entry(parent_inode, &dir,
-				num_new_entries, &new_es);
+				num_total_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1042,13 +1064,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 		*epnew = *epold;
 
-		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 
 		ret = exfat_put_dentry_set(&new_es, sync);
-		if (ret)
+		if (ret) {
+			/* Best-effort delete to avoid duplicate entries */
+			if (!exfat_get_dentry_set(&new_es, sb,
+						  &dir, newentry,
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
@@ -1057,8 +1089,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
-		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
@@ -1074,6 +1106,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1083,8 +1116,14 @@ static int exfat_move_file(struct inode *parent_inode,
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
@@ -1102,21 +1141,31 @@ static int exfat_move_file(struct inode *parent_inode,
 	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 	*epnew = *epmov;
 
-	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+			     &mov_es, num_extra_entries);
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
 
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-
 	return ret;
 }
 
@@ -1190,7 +1239,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 		}
 
-		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE, true);
 
 		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
 		if (ret)
-- 
2.45.2

