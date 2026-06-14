Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FC37EFF8
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481065; cv=none; b=LLOjqEnUyg9a5h3nGNpwXO7s50lPPKmp56Y5oiYtNAfl/0lfeD3kgBpEHQRScG7bWxdZ7NUsH3Yy4WkM3F+RjlDZZYued3ZUQBFLtmWwMoNjPBZruIHIkeF/V3Nangm3bt4ARDJJoVLi7j7E1sHWf19tzRR/N84xNWP3xVqWmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481065; c=relaxed/simple;
	bh=CBqjPqd1fis6CPMXGudTRGMRcGbs30z9zj6HzhgNEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3iXc8ebHXoHJjCLDQkPnbOO0h77izUcN9ZUFy5qGJFvsjNpT7Ppfily6J23jhh0MoVhlgEt794C4W38qN0kasgO/fRuRXwD9dyq5OrGbycRWucj5c+R1YWN3TyBJxzdQDPIO6PMwEgLjHhMSgtBFB2KIETzZ05uZ1FwI6Ne1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBlK620g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBlK620g"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c379e8ffso17293565ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481063; x=1782085863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi+L9wjjkEBCbCcK5d2foVsXiyc/XhnateeodWi0Fig=;
        b=MBlK620gLssqdJHl/n7yETRjkilqHhvA1RjM2qFcZjFTGjYZowDrQoYnOactM2GkMP
         iIRsMx9Iifm2JmgzezCu6b4rxgZw83o+S44nCcErSytOC/qF5zdHkc9ve+voWQyvITt3
         UuC5NJCMPD+JXyIgoaEGVHspBteZoatQDseZk6GQ+LXPTM/sE2uOJIy8+iDJly2PU/aI
         xQznolsSK3KuWp3+n0hfHcylcoUPgS2vYN/Exkko0iqIAr3iMZC3bJ+QaESXO0jjs6Tb
         yLUcrD57NDZZFxtUl56VvmrlASao2n5eRpQx/h41tRWvQCour3XEDScdjDnRRVsC3MzV
         A33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481063; x=1782085863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fi+L9wjjkEBCbCcK5d2foVsXiyc/XhnateeodWi0Fig=;
        b=gR8K1oso40JJdmj5lrDJcPGSh5vwwoUHZNhb7O0ongDMWXWZxFgl0tBMvFtPUxlAFA
         oetL0FmhfoxEP29n3NXV216oz8e25sQaqUENjBIkcgktYYkkPLyWGmk/uUbdX+Fc1YG5
         KF11IjX+9oQs2keRn4iQJr9BZEINGibdGaLwd3mcsoAg/IQvlmFyG+mL+7+/2hcApacf
         O6DieTH79UwS4FRTybBeYQwZ13YYTcjyIK/kh2av6UBaXlxnArhk3flRSFdSC5HUvxfL
         /VdFMs2qCEsU8C/djgo0A40XR+qvJMBHrRFj3B0mkeo3LZryUefAXXReHFZ77djtM0V8
         +QaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qwmr+FKxbQQ/K7VNkVEYnQcuuT6/a4ssqwqnz5eoBTd9KWVhcb2M9MB4WTQutFwq6wEv0LgU/6/MTmfq3@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgVJvY7xUwf7LZRiUCXb4uaskqUR07xi18RaTJvWJ59ny5MjP
	4yZbrePOy5tHzWgxIK9HiMK6WKFJwUXvHYvfu6QSp06MGRB5x4djgDV1
X-Gm-Gg: Acq92OFjiAMDaGbYZBFwGNz00CFU7Sl5mJ92Hblq1XewD1QPEyg/G5gtWeJutcvyh6y
	SrSoIu/mLsViZ6MyzKTqdWmb/dn/ZqMSwjGm4BpfXkBm0WxXxxbytY5m0l7LZhc0XJiI7nqq8Ru
	cz7zm/gQFXFVhmee38SwXlP70Z8Zjxnb9yioeW9ssAVYKC/O5UNrB3kL27QpcjYYGZXHeEAXKaf
	XuGrKWlZEo5mHKlTC4Y+/x6bA+SOJ0uySmzlc4QV67o8Cczse0EJ047RhZqNrib+OeqYzSDIOcs
	2cyM1FVM+mKtkJaqukaJmwkCr+sV5qe7XFhtAkhPgoF7UOU7SgM52075qvZZVKzeTNY9GnJmhTk
	tDFDDgxzb9AMAcuWmrqizY/L/qEsPjKITKrCAZbPrRq0GPDTmL+cq2vb3Y2+Zw//jTAw7CWlEsl
	jGt4mHjRO4oPceg86WuG0vwllUi8sisQ==
X-Received: by 2002:a17:902:f64a:b0:2c0:cf44:3b3d with SMTP id d9443c01a7336-2c6642078f6mr93399325ad.26.1781481062895;
        Sun, 14 Jun 2026 16:51:02 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:51:02 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] ntfs: support following Windows native symlink with absolute paths
Date: Mon, 15 Jun 2026 08:49:54 +0900
Message-ID: <20260615-topic-symlink-v2-3-648a769d01f8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
References: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12353; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=CBqjPqd1fis6CPMXGudTRGMRcGbs30z9zj6HzhgNEHU=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3PuyxRRHglcZQSHFtq39HIHVHmZ6++pQ3G9
 bAzmBjfIVqJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai89zwAKCRA08jD6945I
 0zeBEACZFUBR7nEjea75gilTJpES5McyYiyK0vEuSDE8+xJwtuX4qCS4ogUZPwXSg6Ch+P62IOv
 78qU/1tPwQn96APU8fFcCpMzbKEYdo9WVAnRXnUvjNoog4yVA3M2hIpYE9jNzZuqMODAjPXEf+C
 +m8d5n7dg3GmPCSG1morKJDAvnioJVukGhiV7DuicSsSiGl0IQ+ZGO26KkshqfSuDwIbcQ0Hlle
 XlYh1OwxODUu0E6yLSKM0h1vcwQxs/A9aDHQNkADv0cn7sEIALwsBULWjMsSmXFiumj9+y112G0
 68JdBsJ5gffMQqP5RvJuxLNBNleTCprTy1DriUyinizp1hm8ongPxQ14nKvOXw31P809L7Tywa9
 10E/PHJtfZnUxD+CM6VoeYL2GnIXkQqVFKlyRbGZYcfSTjwx3ZjdoKhUWDb3BETu91enSZPuiHm
 7E6RXYBBHcFhf7kDmiYAc6cCv55Zj+nxLOPi2y1iiGw/EOtT1AqTiNg8OYTjbv8kktZ69HILEcV
 APO5Lnzu1/3UF/RpDWwx4zjwh1gE1rSex+7Wf3GROejZLMtOb/NQ6GJ0C9zZR0pUjBfSzQMF+fo
 nggpKWvudWIs/zXZbe+flNrVVzvHBrbui9jtiVHBqJXGvQCn2Imm5AiweY4QXO+l/p8iOhROcbr 9gYZI3lM3f6eR5Q==
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
 fs/ntfs/reparse.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ntfs/reparse.h |   2 +
 6 files changed, 212 insertions(+), 18 deletions(-)

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
index 4714196185d9..33e5a4198e9b 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -131,6 +131,29 @@ static bool valid_reparse_data(struct ntfs_inode *ni,
 		return false;
 
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
@@ -179,16 +202,22 @@ static bool valid_reparse_data(struct ntfs_inode *ni,
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
@@ -218,17 +247,33 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
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
 	if (reparse_attr &&
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
@@ -236,33 +281,38 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
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
@@ -289,6 +339,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 
 	if (reparse_attr && attr_size >= sizeof(*reparse_attr)) {
 		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_MOUNT_POINT:
 		case IO_REPARSE_TAG_SYMLINK:
 		case IO_REPARSE_TAG_LX_SYMLINK:
 			dt_type = DT_LNK;
@@ -314,6 +365,109 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
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
@@ -628,10 +782,14 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 		err = ntfs_set_ntfs_reparse_data(ni,
 				(char *)reparse, reparse_len);
 		kvfree(reparse);
-		if (!err)
+		if (!err) {
 			ni->target = utarget;
-		else
+			ni->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
+			ni->reparse_flags = 0;
+		} else {
 			kfree(utarget);
+			ni->target = NULL;
+		}
 	}
 	return err;
 }
@@ -671,6 +829,10 @@ int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode)
 		err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse,
 						 reparse_len);
 		kvfree(reparse);
+		if (!err) {
+			ni->reparse_tag = reparse_tag;
+			ni->reparse_flags = 0;
+		}
 	}
 
 	return err;
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

