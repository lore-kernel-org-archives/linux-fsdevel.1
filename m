Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B03D8901
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249655; cv=none; b=NyHTtJvUdN3NLGQPCBYRgQq/2PbT7DIi+pI48Y/rMVYzf0grc7hG21sC6qqcmNz65FtyIzA1B9dUBrKj88fhduPk7KzbfweVqN5cMazVIXLC+iXzsQrR7hw68Gl4V5a4+NvFDeM/NveoN1n9TvQoOdeW3Fiw2bWQw45ZFPvZA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249655; c=relaxed/simple;
	bh=lMfBXZOx888HNjdVaIr6sm8yKaI4cZMkgmXwGpia8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieyTXN+PgiiQmRhyQoj7xC+zvBD6a/7lFBcrciofVJp/KnKxovr5dx2TKbTvHftf90gbqpejnjPdWwYPlSO11rNNvE81yzSVQwBBz7q88lHIUuJrba3X7SaNwAdYL1x45vYCqt44AH+SqwHphHhZx62R9KSdAmLGQ2XzMTgpRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg0KO2Ji; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg0KO2Ji"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842273a2c4dso507437b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249653; x=1781854453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tTyv3XOa7wuRYA2g9WoqmFMU9/UlG5ArXQRxsfOyAU=;
        b=Sg0KO2Jix3/nzY7bquH2veN1G16oGTkesC0M+/Jx9z5owTQoS0133RXSWvDbm4Uk+T
         4cLxtx+w0Yrg6mqhv/HJLDlGEDdkGMzexmoffVc5/kaK7wphIT6b8ZhyyEdbVp+pKRf8
         s2RJQyHL9MD5qd5nRQn6OK8kPWBMLH9wrzrkI7pKUmaAV1yb7gfNL57gbmqNY1+hMZ1p
         PqHKhcYN4p9iNH9/kdlRKU0qBos+2A/pizHTNPiC6ZSpnz2z+hhEWyvZkay7A713bi0r
         tdGmpymCR+DHv1vgQOzmWnrtbDF8hoJ0LHze/+Pfj12sQZBhEK2sNkZekxP/1GzrDagd
         YqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249653; x=1781854453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tTyv3XOa7wuRYA2g9WoqmFMU9/UlG5ArXQRxsfOyAU=;
        b=PTdhYxi6749gu4JupaogA3pN0h6sHO3m1ryM/0aXrY/SspZnS5OZz6iu0Kxr+dZSgg
         z0+ZMhJaGBebaapEwhoAqb1xCoxnZviTW7HLOwNBWFQcUBF7/0Fm1rpMgg4Ia6crwov8
         nSdRikanYsOFU/Dwol40lQG4gpKR10RZxl7zF2Q4RXFjaoCJjZwHKepK5uIaqWQk0dm+
         gYwdKVs4uQ4DvVoRuIGXD3CiQ1iHLiHmMP+Ztlszy6a/fAEuUJppUd/3HGm9CakBufKB
         hqWbJhhBWWYT+hDKNe6ZGam13hFXpTv7ij9QzqWM534oE2/Xp2TfhMMCbqde1hAKtnW9
         ovcA==
X-Forwarded-Encrypted: i=1; AFNElJ8GIdy7ioqAAcHoRjz3ZEAT6Kbfay32wB1NUsVQGXNrTFMhYXQjKFOohFRj8EhBgknfCTnau7FvFM20nP00@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCdwYZdTL/uXxDmA1F0kMZRJ0H9DgrmVahQY8vF40pDFn55Bs
	y05ozJ0iBH0dzOV2oGtWsjmknjQv9PADY6GFjJYNTGO6sOWZV40jDGS14ITeqw==
X-Gm-Gg: Acq92OGL7fm/jWD6lBli9JB2ECQGb0bJuOO+PeP0lCDUuPLPphaQ7dR4/j211va+UQX
	PLeZbEU0oBdmrAghOltVIfHQnDK6jA20SEzuvUZi3mI76Fvw/GUS/8lazPj9afDhsR/bztAOSvp
	PVqaQts1iCD4gzuihOGtMOXnATKgzeQj0v17OKTfJthOuw331hvspEpicV3Fs4ORhd85ctfqESw
	0hImYoLMHTUyRyAWSUNLp4yPImUYXUC4pTdJgWGD6xMRYWauw6qCiXEWvyx/gMUIlTZuHpHHKXh
	IBXSEhNogaZlhFSJ6wwxvClahQ8YbO72iO0hymw8YohQDuL+632X0NH2ubBR/NRv6rYo6M4xJSb
	RSiJQNuJYpEd+KCC4t2Nc+ROBvrmG6q/AvOX8BsREMIbSqtjkFbNVZ+BlJJ+sT88izDp/1G36+j
	EJ4XfPxo0RXNp2MexlVFbQZnh9LmeqDOBFhGCEqnbd
X-Received: by 2002:a05:6a00:2447:b0:842:3801:47b with SMTP id d2e1a72fcca58-8434cc0d5e9mr1930312b3a.18.1781249653065;
        Fri, 12 Jun 2026 00:34:13 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:12 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ntfs: support following Windows native symlink with absolute paths
Date: Fri, 12 Jun 2026 16:33:33 +0900
Message-ID: <20260612-topic-symlink-v1-3-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11667; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=lMfBXZOx888HNjdVaIr6sm8yKaI4cZMkgmXwGpia8QU=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7XujM7quaNjH3H183H8wqSN+2++471THiRic
 +Yn4efBfBaJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17gAKCRA08jD6945I
 0yUKD/9ypKpW7x8dfqhXk3zKyeJBbxRlrr5Hey1Qo/Vyd0U3tiR0YHn5v6JWQx0x3MCQr4AoL6C
 CPTAbxJhSdFgRHKutTEAO/jfxi0a25mW+Zwca+svj/l2OFARxUIJP88/f8wZhCCUifQKFhGpon9
 G7SNJIJyVLSQ1Y0YnQ4tXwYZel0a+6NsNIC4C6kyw4rFfa5YvjFAv7nj7FND2MhnMrHziqpTZMk
 DHunQNfCYQWxWuvEiJxb2JpMTE3hvtdB6fGcrWhg36uBS7Ho9c+VU/Ee4Mp/6AfoqUfpu47pq7D
 Vk5cwbifRLWxQ66M0dc5NgK1mS4efUQ95deuDD2LbsNulZGgZVAwCNm0H0bBgVB1nUnYcVXqF0O
 agwDUxAvCgMGefTx+kj6XfapXj/nUBzTiw9lskw/4JBFrgXa/bpwgNlVyjXWfzzOxtFIAyLwU9w
 zR7O1DCDzqsIC7gvTgST5pqsuloHLA6Ndwrqg5l2+YO80c8cusTrEwVMFNweXxvoq8cKpFW4MhR
 OvbLepik6Lj2O+/9D4/YkMUkBzSIfMjkDrZwRkhR9+Wv40x21RJ8PpGYG+hsdRxoy1l47SEsi6A
 J9yHGAKGSgpkzVa/YtBmB3Q1Nm0oZvQ0XFspBFZuYvQH2HSl1kz1RCrSPwFSc2dPB/60178qw9J 8oWnPnsYGI7m/kw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Extend reparse-point handling beyond relative symlinks so NTFS can
expose the Windows absolute forms used by non-relative symbolic links
and junctions.
* Store the reparse tag and symlink flags in the inode.
* Validate junction payloads, and parse targets from substitute_name.
* Add function to rewrite supported Windows absolute path into Linux
  path relative to the mounted NTFS volume.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c    |  22 ++++++-
 fs/ntfs/inode.c   |   2 +
 fs/ntfs/inode.h   |   2 +
 fs/ntfs/layout.h  |   8 +++
 fs/ntfs/reparse.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ntfs/reparse.h |   2 +
 6 files changed, 202 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 264cf8404385..6b0dfc56577b 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -675,10 +675,28 @@ static int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static const char *ntfs_get_link(struct dentry *dentry, struct inode *inode,
 		struct delayed_call *done)
 {
-	if (!NTFS_I(inode)->target)
+	struct ntfs_inode *ni = NTFS_I(inode);
+	char *target;
+	int err;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	if (!ni->target)
 		return ERR_PTR(-EINVAL);
 
-	return NTFS_I(inode)->target;
+	if (ni->reparse_tag == IO_REPARSE_TAG_MOUNT_POINT ||
+	    (ni->reparse_tag == IO_REPARSE_TAG_SYMLINK &&
+	     !(ni->reparse_flags & cpu_to_le32(SYMLINK_FLAG_RELATIVE)))) {
+		err = ntfs_translate_symlink_path(dentry, ni->target, &target);
+		if (err < 0)
+			return ERR_PTR(err);
+
+		set_delayed_call(done, kfree_link, target);
+		return target;
+	}
+
+	return ni->target;
 }
 
 static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 8894f33b46ca..07ca799a8f9a 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -488,6 +488,8 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->flags = 0;
 	ni->mft_lcn[0] = LCN_RL_NOT_MAPPED;
 	ni->mft_lcn_count = 0;
+	ni->reparse_tag = 0;
+	ni->reparse_flags = 0;
 	ni->target = NULL;
 	ni->i_dealloc_clusters = 0;
 }
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 67942b97fac6..9aacd5787ffe 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -142,6 +142,8 @@ struct ntfs_inode {
 		struct ntfs_inode *base_ntfs_ino;
 	} ext;
 	unsigned int i_dealloc_clusters;
+	__le32 reparse_tag;
+	__le32 reparse_flags;
 	char *target;
 };
 
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index 94af6efa04af..9438fd9b668e 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -2289,6 +2289,14 @@ struct reparse_point {
 	u8 reparse_data[];
 } __packed;
 
+struct mount_point_reparse_data {
+	__le16 substitute_name_offset;
+	__le16 substitute_name_length;
+	__le16 print_name_offset;
+	__le16 print_name_length;
+	__le16 path_buffer[];
+} __packed;
+
 struct symlink_reparse_data {
 	__le16 substitute_name_offset;
 	__le16 substitute_name_length;
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index 4cc37f1c9c90..fb8c42a27699 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -128,6 +128,29 @@ static bool valid_reparse_data(struct ntfs_inode *ni,
 		const struct reparse_point *reparse_attr, size_t size)
 {
 	switch (reparse_attr->reparse_tag) {
+	case IO_REPARSE_TAG_MOUNT_POINT:
+	{
+		struct mount_point_reparse_data *data;
+		size_t data_offs;
+
+		if (!valid_reparse_buffer(ni, reparse_attr, size, sizeof(*data)))
+			return false;
+
+		data = (struct mount_point_reparse_data *)reparse_attr->reparse_data;
+		data_offs = offsetof(struct reparse_point, reparse_data) +
+			offsetof(struct mount_point_reparse_data, path_buffer);
+
+		if (!reparse_name_is_valid(size,
+					   data_offs +
+					   le16_to_cpu(data->substitute_name_offset),
+					   le16_to_cpu(data->substitute_name_length)) ||
+		    !reparse_name_is_valid(size,
+					   data_offs +
+					   le16_to_cpu(data->print_name_offset),
+					   le16_to_cpu(data->print_name_length)))
+			return false;
+		break;
+	}
 	case IO_REPARSE_TAG_SYMLINK:
 	{
 		struct symlink_reparse_data *data;
@@ -176,16 +199,22 @@ static bool valid_reparse_data(struct ntfs_inode *ni,
 		if (le16_to_cpu(reparse_attr->reparse_data_length) ||
 		    !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
 			return false;
+		break;
+	default:
+		if (!valid_reparse_buffer(ni, reparse_attr, size, 0))
+			return false;
+		break;
 	}
 
 	return true;
 }
 
-static unsigned int ntfs_reparse_tag_mode(struct reparse_point *reparse_attr)
+static unsigned int ntfs_reparse_tag_mode(__le32 reparse_tag)
 {
 	unsigned int mode = 0;
 
-	switch (reparse_attr->reparse_tag) {
+	switch (reparse_tag) {
+	case IO_REPARSE_TAG_MOUNT_POINT:
 	case IO_REPARSE_TAG_SYMLINK:
 	case IO_REPARSE_TAG_LX_SYMLINK:
 		mode = S_IFLNK;
@@ -215,17 +244,33 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
 	int err;
 	unsigned int lth;
 	struct reparse_point *reparse_attr;
-	struct wsl_link_reparse_data *wsl_link_data;
 	unsigned int mode = 0;
 
 	kvfree(ni->target);
 	ni->target = NULL;
+	ni->reparse_tag = 0;
+	ni->reparse_flags = 0;
 
 	reparse_attr = ntfs_attr_readall(ni, AT_REPARSE_POINT, NULL, 0,
 					 &attr_size);
 	if (reparse_attr && attr_size &&
 	    valid_reparse_data(ni, reparse_attr, attr_size)) {
+		err = -EINVAL;
+
 		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_MOUNT_POINT:
+		{
+			struct mount_point_reparse_data *data =
+				(struct mount_point_reparse_data *)reparse_attr->reparse_data;
+			const __le16 *name = (const __le16 *)((u8 *)data->path_buffer +
+					      le16_to_cpu(data->substitute_name_offset));
+
+			err = ntfs_reparse_target_to_nls(ni->vol,
+							 name,
+							 le16_to_cpu(data->substitute_name_length),
+							 &ni->target);
+			break;
+		}
 		case IO_REPARSE_TAG_SYMLINK:
 		{
 			struct symlink_reparse_data *data =
@@ -233,33 +278,38 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
 			const __le16 *name = (const __le16 *)((u8 *)data->path_buffer +
 							le16_to_cpu(data->substitute_name_offset));
 
-			mode = ntfs_reparse_tag_mode(reparse_attr);
-			if (!(data->flags & cpu_to_le32(SYMLINK_FLAG_RELATIVE)))
-				break;
-
-			err = ntfs_reparse_target_to_nls(ni->vol, name,
+			err = ntfs_reparse_target_to_nls(ni->vol,
+							 name,
 							 le16_to_cpu(data->substitute_name_length),
 							 &ni->target);
-			if (err < 0)
-				mode = 0;
+			if (!err)
+				ni->reparse_flags = data->flags;
 			break;
 		}
 		case IO_REPARSE_TAG_LX_SYMLINK:
-			wsl_link_data =
+		{
+			struct wsl_link_reparse_data *wsl_link_data =
 				(struct wsl_link_reparse_data *)reparse_attr->reparse_data;
+
 			if (wsl_link_data->type == cpu_to_le32(2)) {
 				lth = le16_to_cpu(reparse_attr->reparse_data_length) -
-						  sizeof(wsl_link_data->type);
+					  sizeof(wsl_link_data->type);
 				ni->target = kvzalloc(lth + 1, GFP_NOFS);
 				if (ni->target) {
 					memcpy(ni->target, wsl_link_data->link, lth);
 					ni->target[lth] = 0;
-					mode = ntfs_reparse_tag_mode(reparse_attr);
+					err = 0;
 				}
 			}
 			break;
+		}
 		default:
-			mode = ntfs_reparse_tag_mode(reparse_attr);
+			err = 0;
+		}
+
+		if (!err) {
+			mode = ntfs_reparse_tag_mode(reparse_attr->reparse_tag);
+			ni->reparse_tag = reparse_attr->reparse_tag;
 		}
 	} else
 		ni->flags &= ~FILE_ATTR_REPARSE_POINT;
@@ -286,6 +336,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 
 	if (reparse_attr && attr_size) {
 		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_MOUNT_POINT:
 		case IO_REPARSE_TAG_SYMLINK:
 		case IO_REPARSE_TAG_LX_SYMLINK:
 			dt_type = DT_LNK;
@@ -311,6 +362,109 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 	return dt_type;
 }
 
+/*
+ * ntfs_translate_symlink_path
+ *
+ * @dentry: dentry of the symlink/junction being resolved
+ * @target: NUL-terminated NLS target string with '\\' already normalized to '/'
+ * @translated: out parameter, set to a newly kmalloc'd relative path on success
+ *
+ * Windows junctions (IO_REPARSE_TAG_MOUNT_POINT) and non-relative symlinks
+ * (IO_REPARSE_TAG_SYMLINK without SYMLINK_FLAG_RELATIVE) store substitute
+ * names such as "/??/C:/foo", "//?/C:/foo", "/foo", or "C:/foo". Linux
+ * cannot continue pathname lookup from those syntaxes, so rewrite them as a
+ * path relative to the symlink's containing directory on this NTFS volume,
+ * anchored at the volume root via "../".
+ *
+ * Note: bind-mounted subtrees of the volume may resolve to unexpected
+ * locations because the computed "../" depth is relative to the NTFS volume
+ * root, not the bind-mounted subtree root.
+ *
+ * Return: 0 on success with *translated set to a newly allocated string the
+ * caller must kfree(); negative errno on failure.
+ */
+int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
+				char **translated)
+{
+	char *buf, *link_path, *out, *p;
+	const char *path, *tail;
+	unsigned int up_levels = 0;
+	size_t tail_len, out_len;
+	int err;
+
+	if (!dentry || !target || !translated)
+		return -EINVAL;
+
+	path = target;
+	/* reject UNC path. */
+	if (path[0] == '/' && path[1] == '/' &&
+	    !(path[2] == '?' && path[3] == '/'))
+		return -EOPNOTSUPP;
+
+	/* target starts with "/??/" or "//?/"? */
+	if ((path[0] == '/' && path[1] == '?' && path[2] == '?' && path[3] == '/') ||
+	    (path[0] == '/' && path[1] == '/' && path[2] == '?' && path[3] == '/'))
+		path += 4;
+
+	/* target must start with a drive character or '/'. */
+	if (((path[0] >= 'A' && path[0] <= 'Z') ||
+	     (path[0] >= 'a' && path[0] <= 'z')) && path[1] == ':') {
+		if (path[2] && path[2] != '/')
+			return -EOPNOTSUPP;
+		tail = path + 2;
+		if (*tail == '/')
+			tail++;
+	} else if (*path == '/') {
+		tail = path + 1;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	tail_len = strlen(tail);
+
+	buf = kmalloc(PATH_MAX, GFP_NOFS);
+	if (!buf)
+		return -ENOMEM;
+
+	link_path = dentry_path_raw(dentry, buf, PATH_MAX);
+	if (IS_ERR(link_path)) {
+		err = PTR_ERR(link_path);
+		goto out;
+	}
+
+	/* count '/' after the leading slash. */
+	for (p = link_path + 1; *p; p++)
+		if (*p == '/')
+			up_levels++;
+
+	/* build "./" + ("../" * up_levels) + tail. */
+	out_len = 2 + up_levels * 3 + tail_len;
+	if (out_len >= PATH_MAX) {
+		err = -ENAMETOOLONG;
+		goto out;
+	}
+
+	out = kmalloc(out_len + 1, GFP_NOFS);
+	if (!out) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(out, "./", 2);
+	p = out + 2;
+	while (up_levels--) {
+		memcpy(p, "../", 3);
+		p += 3;
+	}
+	memcpy(p, tail, tail_len + 1);
+
+	*translated = out;
+	err = 0;
+out:
+	kfree(buf);
+	return err;
+}
+
 /*
  * Set the index for new reparse data
  */
diff --git a/fs/ntfs/reparse.h b/fs/ntfs/reparse.h
index 28da40257f2a..ed7b93c359c1 100644
--- a/fs/ntfs/reparse.h
+++ b/fs/ntfs/reparse.h
@@ -11,6 +11,8 @@ extern __le16 reparse_index_name[];
 
 unsigned int ntfs_make_symlink(struct ntfs_inode *ni);
 unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mref);
+int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
+				char **translated);
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 			const __le16 *target, int target_len);
 int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode);

-- 
2.43.0

