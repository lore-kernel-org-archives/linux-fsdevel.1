Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E093CF057
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043347; cv=none; b=ERMvnQtI6Gq9peGydlIjLFO0Q/q6DXldtEckpFVs4zkKIGFHLXG3+YlfY2ByXA1UNPVATHvhbGNiB3hJiQrxccu8bXCCW/1PupTTgACERmHkO0ZYq0DKiITN2UNjXNM3aes/u6a8jyU8OI3qd2fJsWRvKN8MY9WK683z/HhDO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043347; c=relaxed/simple;
	bh=yJxtshONGVODoLlqYJvaR4JOYVGiPJl5ehcH43UvX7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0dwExRm8U6Go+lujS0mVZ2p47jA2Rrn/NO/kciQRuDog4520+tF3WHwtMytmPxyWW7ra5JDHS6G84bHQOC7/6jXfW3vyQeVTUXBeEVEbInWMGyw4r/XWSWgcLn415+rJxyHbWG3annJf7P9ljMJD74sQAwkiMs2zRRJ4+8jzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ3klcWq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ3klcWq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bde9d73678so9427027b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779043330; x=1779648130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Jmp2cvOBVtngCOowHqjebp2ySaRIu3VyW1CCf1tpI=;
        b=jZ3klcWqaY4ml78YW8WUXF4pUS1xR4bbaFx9Ekpi4vBoEGFYYooHvmuOod0dur7Ejk
         5iL1TsZ+7ZHkMqtH2FS7sZ7e+YDUZZ+nv7w3HEsXsS+O8w5gf6Je5n9OgcKxCCSjbILF
         8vDQH99GqHbj3ywsbVycwq8gbcIojXNiZryJU3gyDzWKQueZk3A65EwOgh+JZrA4lC/A
         3WasIcRoDGfDWVjhIBCArg26tKrp0gXqAC5SrCLIjKTwWK6nb/nLeOtNSs4GVaLqhzLh
         4QDIBqh4TChAzMEH14HvKXoZ5BUNQLa2lFO6b4dZ714I6g/LWRys0Pbe2YydICWyYDni
         v8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043330; x=1779648130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4Jmp2cvOBVtngCOowHqjebp2ySaRIu3VyW1CCf1tpI=;
        b=kV9H9UUec3LuqDpEOH9NZFI3x6oqFCYp9NMcKErSozKsquSQ6Q0NtJ8/l2XyG6YEZe
         ZlEggtiIf8WZJih4X/39VElGGlxwrY6UQPoOjWFQhuk/VCD3mv/ZS2zU/Pjjq/jFP2FS
         Azr0t0TmuqEzgn/fT9NRp53pZ0tCg0wi6POL9pXpTK/iPdnuDaIV8p7T4q1MRdWH7P+5
         YvwO0vFarwYAWaoZd6tcCGr0+HZwCBkP0mW2l6Ms9V9K7T8paJGLvKNz6L9Kv7n29+Tq
         huIBbD5Cwy90Xk4vvyR54PAi3nUTlKvyx4+kxJ/FVX0oTZmEO8AwR5bkZso1Ud0+3Sgz
         eAjQ==
X-Gm-Message-State: AOJu0YyEBrixQg9FImDEBXEOX9w+AS+tVPZM0a3NcqNZT97il1ljIzvr
	GuHAI34tqEfmKizKAY1rnleuE/1ykdN0KjWWOMZiGU3J5RV2+DzIxbhW8z2p4hY=
X-Gm-Gg: Acq92OG6TT62n7hFrC+xDwcM2vHnaCL7xlHFdyw0ml1XyQqUMXo0kjeNoz6LD8plesO
	fIxAyh9fWZpFurGh1GrPx1qFifO7XUGrbDOiqxot+WETqYk8Z0SjEDNF1cMcU+LwSpnog/qUnU4
	4MO8V5jB2AbsPr4Rbtv1nnsSUH6Tm9QqCwNx3FacRV+ykD7tMwDa1HvK258I4oGzMXDSf0HPuG7
	KubVCJXiw+6YQKom1/FT0gBFe/FCHvylci3xba+LMP8RpGMPoBZR6smuVKweJoiqJdeseCDOKdk
	hB0NPMkh2SDAY3cjTabRUqaEoqYGc+rOwbSSfgu1yCqxREfUXmu1ZhMloj6/jvb9oowcXbvR864
	IdDe9FrTbPUvLkcc+4BnknM8WWR1YZ1+IRowfeNicIkrYkHwnScWfjTOZAOyNFesAF6JGDnRgMt
	4/Rqn0FFakpKy5oPDkOWA8veaaoZhTWB2fgkGIAM7Wu+cxKE2ioigDl8/Fw/bf23VLrPrNHVlSq
	CqWu4rPIslUXx8OK3jVFVF9Yx7WZmDe5w==
X-Received: by 2002:a05:690c:e28d:10b0:7bd:9a25:f39f with SMTP id 00721157ae682-7c7e5d8e253mr109801267b3.4.1779043329683;
        Sun, 17 May 2026 11:42:09 -0700 (PDT)
Received: from localhost.localdomain (157-131-96-99.fiber.dynamic.sonic.net. [157.131.96.99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc996b7d54sm11197847b3.12.2026.05.17.11.42.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 May 2026 11:42:09 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
X-Google-Original-From: Rochan Avlur <rochan.avlur@skydio.com>
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	Rochan Avlur <rochan.avlur@skydio.com>
Subject: [PATCH v2] exfat: preserve benign secondary entries during rename and move
Date: Sun, 17 May 2026 11:41:41 -0700
Message-ID: <20260517184141.21939-1-rochan.avlur@skydio.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
References: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
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

Fix this by introducing exfat_remove_entries_nofree() that marks entries
as deleted without freeing benign secondary clusters, and helper
functions to count and copy trailing benign secondary entries from the
old entry set to the new one.  Both exfat_rename_file() and
exfat_move_file() now use these to preserve extra entries across
relocation.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@skydio.com>
---
v2: Resend with whitespace intact. v1 was mangled by Gmail's plain-text
    mode stripping leading whitespace from the diff. No code changes.
    Apologies for the noise.

 fs/exfat/dir.c      |  14 ++++++
 fs/exfat/exfat_fs.h |   1 +
 fs/exfat/namei.c    | 102 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e1..1894f839e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -523,6 +523,20 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 		es->modified = true;
 }

+void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order)
+{
+	int i;
+	struct exfat_dentry *ep;
+
+	for (i = order; i < es->num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		exfat_set_entry_type(ep, TYPE_DELETED);
+	}
+
+	if (order < es->num_entries)
+		es->modified = true;
+}
+
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es)
 {
 	int chksum_type = CS_DIR_ENTRY, i;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef625..9b6dd3dab 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -500,6 +500,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 		struct exfat_uni_name *p_uniname);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 		int order);
+void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493..8c33d9dfb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1008,6 +1008,52 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
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
+	int new_entries = dst_es->num_entries - extra;
+	int i, src_start = src_es->num_entries - extra;
+
+	if (extra == 0)
+		return 0;
+	if (extra < 0 || new_entries < ES_IDX_FIRST_FILENAME ||
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
@@ -1016,6 +1062,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_old_name_entries, num_new_name_entries;
+	unsigned int num_extra_entries, num_total_entries;

 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1023,21 +1071,34 @@ static int exfat_rename_file(struct inode *parent_inode,
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
@@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent_inode,

 		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);

+		ret = exfat_copy_trailing_entries(&old_es, &new_es);
+		if (ret)
+			goto put_old_es;
+
 		ret = exfat_put_dentry_set(&new_es, sync);
 		if (ret)
 			goto put_old_es;

-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
+		exfat_remove_entries_nofree(&old_es, ES_IDX_FILE);
 		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
@@ -1069,8 +1134,13 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}

-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+		exfat_remove_entries_nofree(&old_es,
+				num_new_entries + num_extra_entries);
 		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		if (num_extra_entries) {
+			epold->dentry.file.num_ext += num_extra_entries;
+			exfat_update_dir_chksum(&old_es);
+		}
 	}
 	return exfat_put_dentry_set(&old_es, sync);

@@ -1086,6 +1156,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;

 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1095,8 +1166,14 @@ static int exfat_move_file(struct inode *parent_inode,
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
@@ -1115,7 +1192,12 @@ static int exfat_move_file(struct inode *parent_inode,
 	*epnew = *epmov;

 	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+
+	ret = exfat_copy_trailing_entries(&mov_es, &new_es);
+	if (ret)
+		goto put_mov_es;
+
+	exfat_remove_entries_nofree(&mov_es, ES_IDX_FILE);

 	ei->dir = newdir;
 	ei->entry = newentry;
--
2.45.2

