Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584A37F8A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481061; cv=none; b=VQSD1W3nP8iO71MGSsZ104TWEhC7HezOeYe4N4sjxG7RaG98jvkUeQC4dTgZWS5tmicQ5IgFcwtbFuDYNBBHzFpG7tcrTW/FBOrXS2F/H2Pbihwja9tNoSPGe6GcXhco+HY167m/9ieTZX+86evryZ3Tab+GUi1K6Arb27bCAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481061; c=relaxed/simple;
	bh=cHuQVhNud0e9ur2jTGd9JiZTsWez2oV1WOXCPdzohSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtgY0SWMxRdSYXTapzY179WUPGMG/mXWJLGl1PV3jRHEfSZX99qKT8SHNtjdNxxgVO6S6t+oA182vLmmbXO6U0bBhLWHEZgfDKP7VeNayrpGt29nn2wju+uWNRw2jvakNbIOR26lxZn6b86hobncfjAUkpASpZ6Kk/yaNLl5EIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXDknrDo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXDknrDo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf18c30bb2so20131935ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481059; x=1782085859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=folxwG2dgKzCYiOGQbAx/147QNu5z6LZzBL5hnrypzg=;
        b=OXDknrDo+9vuban466P3eGP4+X8gmf6hcaDr6nZXjj1lIi+hMLt2d70H82/BSo7zAy
         PS5efaAwQBpdWQzwY2a64mAW+I3M51AtKUOGmoTs7meyEAblQBPWp0zQLTuEP82vNmrO
         tt6qM3OmieFkCOmo7dyEbnoMXc6ODuCjpery9OgjAhTTw+AsFuYH5+sgitE6aOHw5pOA
         5A61AXxnyVflcKjKdcendCOt6pf6jpE9yDZiItq5t+PiCgoQXPaDxDJpnD43IeFuOtMY
         /cpyvgYPh6m9EyDjEk5ON6svRiNFDVzsJ5fzNVzDnXmOv6XolBqxw74LU2pghQIyU7wl
         qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481059; x=1782085859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=folxwG2dgKzCYiOGQbAx/147QNu5z6LZzBL5hnrypzg=;
        b=Q2LCN+WXA+f0N/9B14zLPL54wiHiEoEpvhMvNKjdFU8nis1aAY52zHyEuD8MUKxvNJ
         tgs+AUBXWNe5xaCeCVeG63a3pgMqgdncOlMlCX2NhVvqQbqLCXUrycPf4JmUSbVRe37j
         SKYBo0QW0RDiSgt65CdRMtZqrj3xtciziqO1a8qfumAYQ+Vusr1FapqwEakcoHoXPCfi
         mm638Z/MbPVio51WGOTOyf9kAUVxoV0bMTlpGadMGilh4qlDodczN81qni0vhhOezUfQ
         lqvWGYrXWScvWgtZcSndQ0Dg16/jZTOE7/EcDvS1nQUNji10HoUdwYCNvex0d/9rsOc4
         marA==
X-Forwarded-Encrypted: i=1; AFNElJ+NBkGhUsk+T/WJNjW0LM5QPlNNkIX3MEhmrGXNcudzJlicA3Iv6ajBHrR5aEv6hC89YUew0yq5p9jfaSmG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gtaIlzpOydGeoyVXWP1X0RqX4nUd9FoNeYBeKLSYY0iQL0Lw
	y1B94xy5oh+3+AaDRTZjr2XVLzUfd9nG/fvVv3xhfw1KcZx990g1OLtRu5Y47Q==
X-Gm-Gg: Acq92OGyyGBMAgeVT1IJbukJNsEb4i0EHmuV30ONufgjKoCPXjMxdTU4h8JlQHsnuXs
	lbgn38ZdFMFbxpDhrVa70asSF6nKGBwVf2ecnfpyyIvBa/+YPQZ6KbhosWaTNYywM7SVArDW3Uk
	XMuxDHxgesUojDBzxGaOxg5UwzWsgGQ7DSiHMFLgknZAieIACs1139qAAAxNaxsId6QGTMTRQ2a
	Fz48JgHyblrp7imPIGRugwoeo+rTXqgP2wyvUVyopgrNnSq4ueZYwXiscDHdfvjRim+PJycwotE
	8fVZqIhFPRdaybA5pdf82gDFc6b+AVb70yarkCiWyFrN4T11QbfNGj4BqKX4SKZLqHMqqciXIdv
	/wajuFYWEId4JmvJgR+5UpBZk29UnMaOuQkTRzYp9kYEsfayLf5vcSC2lz1M2SQy7BjXwjeJJ2s
	yb7Oa3KUwB8k6Ls2JfOwtGkNZiMse8iA==
X-Received: by 2002:a17:903:2c04:b0:2c2:245a:336c with SMTP id d9443c01a7336-2c6641f1e20mr89632845ad.14.1781481059466;
        Sun, 14 Jun 2026 16:50:59 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:50:58 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] ntfs: support following Windows native symlink with relative paths
Date: Mon, 15 Jun 2026 08:49:53 +0900
Message-ID: <20260615-topic-symlink-v2-2-648a769d01f8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9658; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=cHuQVhNud0e9ur2jTGd9JiZTsWez2oV1WOXCPdzohSA=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3PPxwfkom0O+cqxpEuuIeQ7tQhFWNZBbwgs
 YhfsNjxJ7mJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai89zwAKCRA08jD6945I
 09wfEACiRwej88dx5qwHLRO8qcFrD3ns5Mbrp+1eUYfJhUrYjkb/KgMxedTjlvgNn8UmGLrunvY
 F3MFiBVHowxBdlS4eZYurBjWOS+fSJ+LLRP6awfx62mv7h635vHmSMuJZwIDlYHfujgF8ZU4f0b
 d1dvZ5DBXqtonFLZEWiiNiIXe+wxw59C9A7D5DmKd4MPRBqQF+rX/LbDOGL+XZ8SZr+mxMmD5Ye
 b88eIc6YB6bFK1YQkLKRRkeAzr+wxQ6ONxx8yTZjy2cdJPyEH1DkI+T/d781pEOkTEZKPECOzLq
 OxTF1OW+Rz2OdJVREnvIS+To7QmW8y6WdzMghn7yqW/W+it36dVn5t70hMQw9NmFIZHQh0OAmbM
 ztDF1o4+Qkwnntc1rSllkFcEjoU2jI6CaxHkdfvhmG9B+0wpGqIPjT9GNT1nVplj2V25rslCZ1u
 SZ1r5LsAuedf5V0GB+rd4/ksQTofWGEl1MnakQqDyccwmqVms/bkwG48QslGBcJc+d653fRz2zB
 R5AoJlQeJ6OTVbqSlp4w8RDu+Qg3kz3S9bNMPd6M5Viv+d1033l4QiigDhuufqCe/bRpnzsnJEB
 kGXlHzUSTXAIa+24pLawuy+iDB29vxipDupQuowNAXYYGlvUrD7I5/wEDfXwk2gUzEFdv8dSlao m5utvsaGGoXKVWw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Make ntfs_make_symlink() parse native Windows symbolic link reparse
payloads when the SYMLINK_FLAG_RELATIVE bit is set.
Implement the following changes:
 * Add a dedicated on-disk layout definition for symbolic link reparse
   data.
 * validate the UTF-16 name ranges before decoding them.
 * convert the substitute name into the mount's NLS and normalize path
   separators.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/inode.c   |  36 +++++++++-------
 fs/ntfs/layout.h  |  11 +++++
 fs/ntfs/reparse.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 147 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index efb34a5e94d9..8894f33b46ca 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -863,8 +863,26 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		ntfs_ea_get_wsl_inode(vi, &dev, flags);
 	}
 
-	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
+	if (ni->flags & FILE_ATTR_REPARSE_POINT) {
+		unsigned int mode;
+
+		mode = ntfs_make_symlink(ni);
+		if (mode)
+			vi->i_mode |= mode;
+		else {
+			vi->i_mode &= ~S_IFLNK;
+			if (m->flags & MFT_RECORD_IS_DIRECTORY)
+				vi->i_mode |= S_IFDIR;
+			else
+				vi->i_mode |= S_IFREG;
+		}
+	} else if (m->flags & MFT_RECORD_IS_DIRECTORY) {
 		vi->i_mode |= S_IFDIR;
+	} else {
+		vi->i_mode |= S_IFREG;
+	}
+
+	if (S_ISDIR(vi->i_mode)) {
 		/*
 		 * Apply the directory permissions mask set in the mount
 		 * options.
@@ -874,18 +892,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		if (vi->i_nlink > 1)
 			set_nlink(vi, 1);
 	} else {
-		if (ni->flags & FILE_ATTR_REPARSE_POINT) {
-			unsigned int mode;
-
-			mode = ntfs_make_symlink(ni);
-			if (mode)
-				vi->i_mode |= mode;
-			else {
-				vi->i_mode &= ~S_IFLNK;
-				vi->i_mode |= S_IFREG;
-			}
-		} else
-			vi->i_mode |= S_IFREG;
 		/* Apply the file permissions mask set in the mount options. */
 		vi->i_mode &= ~vol->fmask;
 	}
@@ -894,7 +900,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * If an attribute list is present we now have the attribute list value
 	 * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size bytes.
 	 */
-	if (S_ISDIR(vi->i_mode)) {
+	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
 		struct index_root *ir;
 
 view_index_meta:
@@ -1018,7 +1024,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		m = NULL;
 		ctx = NULL;
 		/* Setup the operations for this inode. */
-		ntfs_set_vfs_operations(vi, S_IFDIR, 0);
+		ntfs_set_vfs_operations(vi, vi->i_mode, 0);
 		if (ir->index.flags & LARGE_INDEX)
 			NInoSetIndexAllocPresent(ni);
 	} else {
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index d94f914e830f..94af6efa04af 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -2267,6 +2267,8 @@ enum {
 	IO_REPARSE_PLUGIN_SELECT	= cpu_to_le32(0xffff0fff),
 };
 
+#define SYMLINK_FLAG_RELATIVE		1
+
 /*
  * struct reparse_point - $REPARSE_POINT attribute content (0xc0)\
  *
@@ -2287,6 +2289,15 @@ struct reparse_point {
 	u8 reparse_data[];
 } __packed;
 
+struct symlink_reparse_data {
+	__le16 substitute_name_offset;
+	__le16 substitute_name_length;
+	__le16 print_name_offset;
+	__le16 print_name_length;
+	__le32 flags;
+	__le16 path_buffer[];
+} __packed;
+
 /*
  * struct ea_information - $EA_INFORMATION attribute content (0xd0)
  *
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index 74713716813f..4714196185d9 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -24,6 +24,47 @@ struct wsl_link_reparse_data {
 	char	link[];
 };
 
+static bool reparse_name_is_valid(size_t size, size_t name_off, u16 len)
+{
+	if ((name_off | len) & 1)
+		return false;
+
+	return name_off + len <= size;
+}
+
+/*
+ * Windows-native reparse payloads store pathnames as UTF-16 strings with '\\'
+ * separators. Convert the on-disk UTF-16 target into the mount's NLS and
+ * normalize path separators.
+ */
+static int ntfs_reparse_target_to_nls(struct ntfs_volume *vol,
+				      const __le16 *uname, u16 ulen,
+				      char **target)
+{
+	int err, i;
+
+	*target = NULL;
+	ulen >>= 1;
+	if (!ulen)
+		return -EINVAL;
+
+	if (!uname[ulen - 1])
+		ulen--;
+
+	err = ntfs_ucstonls(vol, uname, ulen, (unsigned char **)target, 0);
+	if (err < 0) {
+		ntfs_attr_name_free((unsigned char **)target);
+		return err;
+	}
+
+	for (i = 0; i < err; i++) {
+		if ((*target)[i] == '\\')
+			(*target)[i] = '/';
+	}
+
+	return 0;
+}
+
 /* Index entry in $Extend/$Reparse */
 struct reparse_index {
 	struct index_entry_header header;
@@ -38,8 +79,10 @@ __le16 reparse_index_name[] = {cpu_to_le16('$'), cpu_to_le16('R'), 0};
  * Check if the reparse point attribute buffer is valid.
  * Returns true if valid, false otherwise.
  */
-static bool ntfs_is_valid_reparse_buffer(struct ntfs_inode *ni,
-		const struct reparse_point *reparse_attr, size_t size)
+static bool valid_reparse_buffer(struct ntfs_inode *ni,
+				 const struct reparse_point *reparse_attr,
+				 size_t size,
+				 size_t payload_min_len)
 {
 	size_t expected;
 
@@ -50,6 +93,11 @@ static bool ntfs_is_valid_reparse_buffer(struct ntfs_inode *ni,
 	if (size < sizeof(struct reparse_point))
 		return false;
 
+	/* The payload must contain the fixed fields for the current tag. */
+	if (payload_min_len &&
+	    le16_to_cpu(reparse_attr->reparse_data_length) < payload_min_len)
+		return false;
+
 	/* Reserved zero tag is invalid */
 	if (reparse_attr->reparse_tag == IO_REPARSE_TAG_RESERVED_ZERO)
 		return false;
@@ -79,24 +127,57 @@ static bool ntfs_is_valid_reparse_buffer(struct ntfs_inode *ni,
 static bool valid_reparse_data(struct ntfs_inode *ni,
 		const struct reparse_point *reparse_attr, size_t size)
 {
-	const struct wsl_link_reparse_data *wsl_reparse_data =
-		(const struct wsl_link_reparse_data *)reparse_attr->reparse_data;
-	unsigned int data_len = le16_to_cpu(reparse_attr->reparse_data_length);
-
-	if (ntfs_is_valid_reparse_buffer(ni, reparse_attr, size) == false)
+	if (size < sizeof(*reparse_attr))
 		return false;
 
 	switch (reparse_attr->reparse_tag) {
+	case IO_REPARSE_TAG_SYMLINK:
+	{
+		struct symlink_reparse_data *data;
+		size_t data_offs;
+
+		if (!valid_reparse_buffer(ni, reparse_attr, size,
+					  sizeof(*data)))
+			return false;
+
+		data = (struct symlink_reparse_data *)reparse_attr->reparse_data;
+		data_offs = offsetof(struct reparse_point, reparse_data) +
+			offsetof(struct symlink_reparse_data, path_buffer);
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
 	case IO_REPARSE_TAG_LX_SYMLINK:
-		if (data_len <= sizeof(wsl_reparse_data->type) ||
-		    wsl_reparse_data->type != cpu_to_le32(2))
+	{
+		struct wsl_link_reparse_data *data;
+
+		if (!valid_reparse_buffer(ni, reparse_attr, size,
+					  sizeof(*data)))
+			return false;
+
+		data = (struct wsl_link_reparse_data *)reparse_attr->reparse_data;
+
+		if (le16_to_cpu(reparse_attr->reparse_data_length) <= sizeof(data->type) ||
+		    data->type != cpu_to_le32(2))
 			return false;
 		break;
+	}
 	case IO_REPARSE_TAG_AF_UNIX:
 	case IO_REPARSE_TAG_LX_FIFO:
 	case IO_REPARSE_TAG_LX_CHR:
 	case IO_REPARSE_TAG_LX_BLK:
-		if (data_len || !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
+		if (!valid_reparse_buffer(ni, reparse_attr, size, 0))
+			return false;
+		if (le16_to_cpu(reparse_attr->reparse_data_length) ||
+		    !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
 			return false;
 	}
 
@@ -134,16 +215,38 @@ static unsigned int ntfs_reparse_tag_mode(struct reparse_point *reparse_attr)
 unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
 {
 	s64 attr_size = 0;
+	int err;
 	unsigned int lth;
 	struct reparse_point *reparse_attr;
 	struct wsl_link_reparse_data *wsl_link_data;
 	unsigned int mode = 0;
 
+	kvfree(ni->target);
+	ni->target = NULL;
+
 	reparse_attr = ntfs_attr_readall(ni, AT_REPARSE_POINT, NULL, 0,
 					 &attr_size);
-	if (reparse_attr && attr_size &&
+	if (reparse_attr &&
 	    valid_reparse_data(ni, reparse_attr, attr_size)) {
 		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_SYMLINK:
+		{
+			struct symlink_reparse_data *data =
+				(struct symlink_reparse_data *)reparse_attr->reparse_data;
+			const __le16 *name = (const __le16 *)((u8 *)data->path_buffer +
+							le16_to_cpu(data->substitute_name_offset));
+
+			mode = ntfs_reparse_tag_mode(reparse_attr);
+			if (!(data->flags & cpu_to_le32(SYMLINK_FLAG_RELATIVE)))
+				break;
+
+			err = ntfs_reparse_target_to_nls(ni->vol, name,
+							 le16_to_cpu(data->substitute_name_length),
+							 &ni->target);
+			if (err < 0)
+				mode = 0;
+			break;
+		}
 		case IO_REPARSE_TAG_LX_SYMLINK:
 			wsl_link_data =
 				(struct wsl_link_reparse_data *)reparse_attr->reparse_data;
@@ -184,7 +287,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 	reparse_attr = (struct reparse_point *)ntfs_attr_readall(NTFS_I(vi),
 			AT_REPARSE_POINT, NULL, 0, &attr_size);
 
-	if (reparse_attr && attr_size) {
+	if (reparse_attr && attr_size >= sizeof(*reparse_attr)) {
 		switch (reparse_attr->reparse_tag) {
 		case IO_REPARSE_TAG_SYMLINK:
 		case IO_REPARSE_TAG_LX_SYMLINK:

-- 
2.43.0

