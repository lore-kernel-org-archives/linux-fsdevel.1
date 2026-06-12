Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103693803D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249649; cv=none; b=p846KQwVj8X2h4/GF/VDyQ2zmUKqQAOviI9A2RXGdQ4/0AGhSykxFVqqZUURvXs4ytvkJnuYm5abFv4Qdy1k7UXntYkeqaanaaPmljFVBIVCl49m9TfpGtOPIau8O/6d47CS2zk0iQipndVHR7i0mB3Y/p4pKZ6fJBrDZIKx9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249649; c=relaxed/simple;
	bh=xUkaOSk80awxz275ERuwabaO7py/uQWIu/0yIrt4/x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRIfkSFQwTFzLRbbHC/iPoImFi7B0Wcka7n0CKAXH4r3YipE9d/DHv3BFpK2gZRXY3ATPgJu5luqv+n8Bxtrev6sTnxxHxxkB3Y5fUX5x1WDTKRxFP5cT2E/aKpBg5zLT5HOf1d67JxRLYEiihWejr4js2vDdNTawd1Rj45PoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2JtkJA6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2JtkJA6"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso567309a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249647; x=1781854447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQoVN49ZJ0nFmM16Q67wLSkpxydhawxy5JLYWlSRojI=;
        b=A2JtkJA61o3EN/7rx3+sCFU+G29N7RIQseerd7BBicsH4EDqbjYi4BoTPEI0XDa+LF
         rwNJj1xjKKlglNKgkB6qem8YUVYh/UtQOIlGUO2HSuYVZ8Y15B/xomNRcLbYUk7lbOnm
         WZS5asiukK/pZwz3sY0nTJUVEYTQPhw2u660aNew6V6F1rdMxLRe4zjDLKZfZYPAaHMA
         QiouTorBlbkBbrasXhPZdZ0tMHTt9rHhwFfO3m1+qNbQ8oWbINmpdyL6fibcvV8jvCeN
         eFo0zH/CPPBuhFuupdMgETOue+x4GGSKdBPTqaJnSu0hEawnlZ2zOoa9yf8GU0o9hiok
         tuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249647; x=1781854447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQoVN49ZJ0nFmM16Q67wLSkpxydhawxy5JLYWlSRojI=;
        b=n8kuNaSuudMs0zIMP7wVleVvG+0q8lr0JTXjmkhCkXBMo6vuWoG3BAyl3ENDE3FnW8
         LXU46FyHge63jR954GybqNyOkH1bIZZOM4qyPLlWTjL3quQ4O30vR9GHizUm/k6n6Ejk
         hkW5Zq3k8JihpLmiLdvnN0oBNdp71U6R/4BrCSP7AHTSTrBGSGdhbTdTWFNh2os1skVN
         eZiZ6NTNsFmdxUc6R+Hu1cbgyXl8wnU0X17oC1i/JKm/5SLZfaMOFppIOja9Y4tzJeN3
         yLq+XNIdnaAZSZJQvfzUMPuQgbSjZlyrLkzf0WaICS2Id6VoGY2a+BGKdw7FnHh+yinb
         Qtqw==
X-Forwarded-Encrypted: i=1; AFNElJ/fbfJqFaJJ6oYrBp0qJJncloDRDPybzLfBbDrn9S3n4fRxogEZmR5qGb9I4zHKWM4zr1yhisA98fcdssgE@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZNxampqWeOrxfPl4XImH9R6686nYovQZxms8Qqq92CaQkNZr
	FYcPUF6r3C7vHEIT1B2aSF2WX/vYh4bLwXJzmkuWWhFeWiitfXQ9DKWGlGGA7A==
X-Gm-Gg: Acq92OEYHAAB9FgPE31HkBLLPxDnsXB+Uk5Rs/3ukq/vT/s/O6lZHkY3dcu/PWSbJNw
	QW2X03w5tP9OuraCsi2dbhsIWrpO6FD6DO+GN48pB0W1dTWpjBaZpuPz4FRqJqGVxXp4YVTNstp
	2fw7qioxKh3gQpXHJM4WUiDgxYSMicR7ZCg8PUotgH8U8DJGOe9OZOX+6GcbLSw8c9ezVa/zAzs
	xSK//cFdyCj4I4bsi6ViOUedWtTQYxDwy3IxCeNEB+Q8XXs3bDnq4x35FGVsdxG+ejFlfZZ1JeG
	FJrS4dvnfKzyXJ7NvQ0b7mEDWi+2QkTiIgKfI0Xt+8oXxHA2CR3X1OpftNskpTn11vEu5/Sp75Y
	1BMExuGBfAmlT8uHwJBHnYNgbXVOab1agSSDKpXaI0UHezEqM1MZlwdNJlfBI15+j1FX32MMBht
	oqixgzMGDR4wj2DA/Sb7FBQbnD2rKhjQ==
X-Received: by 2002:a17:90a:d44e:b0:368:1064:62f7 with SMTP id 98e67ed59e1d1-37a01e2e4c5mr1919517a91.6.1781249647269;
        Fri, 12 Jun 2026 00:34:07 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:06 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ntfs: support following Windows native symlink with relative paths
Date: Fri, 12 Jun 2026 16:33:32 +0900
Message-ID: <20260612-topic-symlink-v1-2-cc1ebf9528e1@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9203; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=xUkaOSk80awxz275ERuwabaO7py/uQWIu/0yIrt4/x4=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7XuTVYXCku9FZqgEnzVJGYPtfgdvuM3hj2su
 NC6uNm1u4SJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17gAKCRA08jD6945I
 00Y4D/9Sppp0r7JMoRAowHei03SWsea5+fx+TuEl8PPvQvIPEgrFCGloCe7JclNwoiMJOsiwW3m
 I6UwEnsMtT7TSWS06S92HKdqZgjee/yoQDhMhKtYGRbSur8DjFHGxRu6B++TKB8YIZaX+tZwNLG
 NYh8ZnAgcuNii7aDE3PMC/vVwexHzP9kPiL7/r31Q9/hg241vEAgQWFckUoXzCtnbheK2jzzOFh
 lz83FsSzAhyCwVWfyWk1cCn87nIPkIkeuyvy/UqSYcHm3/47Zhd7ycgFBuC8mJaUTJA8FHXTclL
 uhli+3dfwpoeSfis7Kzo7kIw11Rlx5HfA9nkeifMQygrtfk5RrYNJPj7GjJEbl+hfMKLucxaC1e
 sg1M6XdW4oJeIS3Jeald129yTZdz5EBaqe552AiJKrFHwA6NeC4YHQDcZNhG1KDWfxQowHhVBc9
 83/2ISUq3pn5jtS7roQkV5l0NCuJeaAOflN/QRaQXxB2y+Nek2lwAKXjs/tlJlhZLZTwkuVa9NQ
 4EjZ0oGWok0bfNS+1g+h6QUOW200g73tV3h5Goyn0untCTPBFPyzFf6VzjuCMP3Qma7Fj91ezMy
 R1dG4otG/h/Kx4GnVJP6SKImdQN5gVD3K5Q63r+bn9E0pa5eByooTm0gihAKp2ytnZX1ddGinv/ kLM9ROs6P+KPYcQ==
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
 fs/ntfs/reparse.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 143 insertions(+), 26 deletions(-)

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
index 74713716813f..4cc37f1c9c90 100644
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
@@ -79,24 +127,54 @@ static bool ntfs_is_valid_reparse_buffer(struct ntfs_inode *ni,
 static bool valid_reparse_data(struct ntfs_inode *ni,
 		const struct reparse_point *reparse_attr, size_t size)
 {
-	const struct wsl_link_reparse_data *wsl_reparse_data =
-		(const struct wsl_link_reparse_data *)reparse_attr->reparse_data;
-	unsigned int data_len = le16_to_cpu(reparse_attr->reparse_data_length);
+	switch (reparse_attr->reparse_tag) {
+	case IO_REPARSE_TAG_SYMLINK:
+	{
+		struct symlink_reparse_data *data;
+		size_t data_offs;
 
-	if (ntfs_is_valid_reparse_buffer(ni, reparse_attr, size) == false)
-		return false;
+		if (!valid_reparse_buffer(ni, reparse_attr, size,
+					  sizeof(*data)))
+			return false;
 
-	switch (reparse_attr->reparse_tag) {
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
 
@@ -134,16 +212,38 @@ static unsigned int ntfs_reparse_tag_mode(struct reparse_point *reparse_attr)
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
 	if (reparse_attr && attr_size &&
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

-- 
2.43.0

