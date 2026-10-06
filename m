Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221753BA25E;
	Tue,  6 Oct 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326503; cv=none; b=d+ZzG6IswDmXEIotNo6N99+t1QPTb0swFg9jiexS7LM+7qdxMj0RtUAvxoCvylUUVa+GbDqatMNip2pZECoOJQUibtCcjPcKCBl/ozORkQvoQnFeYDVb+y8Rz8N/SOcPzT6QOXBACBHG9YVa9wNNqT5puPzmXQavRuCjKEwNows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326503; c=relaxed/simple;
	bh=snvUqM+8V/HFRa8cSDTMjV35rnSzoyK9O5BHvSjGudg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ar3DBOarWQgjyvRPM+a1cht5LD+T5ZC/TJvCOSdkeZ9kGX/aNcK4BeiJuxo6ufWUbuG1Qfk3Em8FbsS4OTNPvNkYhNfocuKAtp+ES293dvc3BdiLP5v7RduYcBaJ5lHzx3kXlrQbZ6W7Ggeqmuogj2Q2TcWaKe5U+YJSznxLF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQJLfgxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQJLfgxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E763D1F00900;
	Tue,  6 Oct 2026 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326462;
	bh=xckGze5Vk6d/jb8zeNQtWtwOimFDAE7qk3trrh9fh6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQJLfgxhLik9nnQsOciUS38P8EB7t8o00/fokFKKQk7V4GE5YzDRSruHWMxTCZvdp
	 AahBK0b9ZycgwSHqJ7JBy38PfLPDcneISuynNhTKDDNcehRfLXr4j4wLowVRGlACIE
	 tVUiXhx08f89f486N7f+VJh0qQwzpyUqs4Z2E6eYand0LHQbVmTpnQY550UGpcOPdg
	 zq5q2iCMaKgUsUUqd7XZLFpmSi2s2ySlcPFo4gFnsrShwEBuGw2CHJ78Bsrub4DjbO
	 aJesm0dCFw/pjQd6qzBLlv81tZkqhnxpZ6ZZeJit4/NlynGVgMCUkEZcd4GwNblZ5J
	 gm5evsyh8DDMw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 1/4] ntfs: add named stream ioctls support
Date: Wed,  7 Oct 2026 07:40:21 +0900
Message-Id: <20261006224024.14535-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006224024.14535-1-linkinjeon@kernel.org>
References: <20261006224024.14535-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NTFS supports multiple named $DATA attributes, commonly known as alternate
data streams. Add NTFS-specific ioctls to list, read, write, and remove
named streams through an opened base file or directory.

The UAPI provides separate commands for each operation.

  - NTFS_IOC_STREAM_READ
  - NTFS_IOC_STREAM_WRITE
  - NTFS_IOC_STREAM_REMOVE
  - NTFS_IOC_LIST_STREAMS

Read and write requests use struct ntfs_stream to specify the stream name,
byte offset, and transfer length. Writes create the stream if it does not
already exist. A write failure after creation may leave the new stream
visible. It is not rolled back because another caller may already have
opened it. Userspace can remove it with NTFS_IOC_STREAM_REMOVE.

The list command returns variable-length entries containing each named
stream's data size, allocated size, and name. If the buffer is too small,
the command returns -ENOSPC without copying entries. bytes_returned reports
the required buffer size, and stream_count reports the number of streams.

Stream names use the mounted filesystem NLS by default. Set
NTFS_STREAM_FL_UTF16 to pass or receive raw UTF-16LE names. In NLS mode,
names that cannot be represented by the mounted character set are omitted
from the list. Use UTF-16 mode for lossless enumeration. Read and write
transfers are limited to 16 MiB per request.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/ntfs/Makefile                              |   2 +-
 fs/ntfs/attrib.c                              | 148 +--
 fs/ntfs/attrlist.c                            |   3 +-
 fs/ntfs/file.c                                | 162 +++-
 fs/ntfs/inode.c                               | 188 +++-
 fs/ntfs/inode.h                               |  19 +
 fs/ntfs/named_stream.c                        | 915 ++++++++++++++++++
 fs/ntfs/namei.c                               |  43 +-
 fs/ntfs/stream.h                              |  43 +
 include/uapi/linux/ntfs.h                     | 123 +++
 11 files changed, 1500 insertions(+), 147 deletions(-)
 create mode 100644 fs/ntfs/named_stream.c
 create mode 100644 fs/ntfs/stream.h
 create mode 100644 include/uapi/linux/ntfs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2fc53093752d..94a421970b85 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -401,6 +401,7 @@ Code  Seq#    Include File                                             Comments
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                     ChromeOS EC driver
 0xEE  00-09  uapi/linux/pfrut.h                                        Platform Firmware Runtime Update and Telemetry
+0xEF  00-0F  uapi/linux/ntfs.h                                         NTFS
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       sisfb (in development)
                                                                        <mailto:thomas@winischhofer.net>
 0xF6  all                                                              LTTng Linux Trace Toolkit Next Generation
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
index ee8987e496a8..3e8549577653 100644
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_NTFS_FS) += ntfs.o
 ntfs-y := aops.o attrib.o collate.o dir.o file.o index.o inode.o \
 	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
 	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
-	  iomap.o debug.o sysctl.o object_id.o bdev-io.o
+	  iomap.o debug.o sysctl.o object_id.o bdev-io.o named_stream.o
 
 ntfs-$(CONFIG_NTFS_FS_WOF_COMPRESSION) += wof.o \
 	lib/decompress_common.o lib/lzx_decompress.o lib/xpress_decompress.o
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 4df618abc4ef..3266415470a7 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2352,12 +2352,13 @@ int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
 int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
 {
 	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	int err = 0;
 
 	if (!NInoNonResident(ni))
 		return -EINVAL;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -2439,6 +2440,7 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	struct mft_record *m;
 	int err, offset;
 	struct ntfs_inode *base_ni;
+	u32 ic;
 
 	if (!ni || (!name && name_len))
 		return -EINVAL;
@@ -2468,7 +2470,8 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
 	 * file record.
 	 */
-	err = ntfs_attr_find(type, name, name_len, CASE_SENSITIVE, val, size, ctx);
+	ic = type == AT_DATA && name_len ? IGNORE_CASE : CASE_SENSITIVE;
+	err = ntfs_attr_find(type, name, name_len, ic, val, size, ctx);
 	if (!err) {
 		err = -EEXIST;
 		ntfs_debug("Attribute already present.\n");
@@ -2560,6 +2563,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	struct mft_record *m;
 	struct ntfs_inode *base_ni;
 	int err, offset;
+	u32 ic;
 
 	if (!ni || dataruns_size <= 0 || (!name && name_len))
 		return -EINVAL;
@@ -2589,7 +2593,8 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
 	 * file record.
 	 */
-	err = ntfs_attr_find(type, name, name_len, CASE_SENSITIVE, NULL, 0, ctx);
+	ic = type == AT_DATA && name_len ? IGNORE_CASE : CASE_SENSITIVE;
+	err = ntfs_attr_find(type, name, name_len, ic, NULL, 0, ctx);
 	if (!err) {
 		err = -EEXIST;
 		pr_err("Attribute 0x%x already present\n", type);
@@ -2663,7 +2668,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	 * update of attribute list.
 	 */
 	ntfs_attr_reinit_search_ctx(ctx);
-	err = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE,
+	err = ntfs_attr_lookup(type, name, name_len, ic,
 				lowest_vcn, NULL, 0, ctx);
 	if (err) {
 		pr_err("%s: attribute lookup failed\n", __func__);
@@ -3132,6 +3137,7 @@ int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 	struct attr_record *a;
 	bool cs;
 	struct ntfs_inode *base_ni;
+	u32 ic;
 	int err;
 
 	if (!ni || !ni->vol)
@@ -3140,10 +3146,7 @@ int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 	ntfs_debug("Entering for inode %lld, attr 0x%x.\n",
 			ni->mft_no, type);
 
-	if (NInoAttr(ni))
-		base_ni = ni->ext.base_ntfs_ino;
-	else
-		base_ni = ni;
+	base_ni = ntfs_base_inode(ni);
 
 	if (name && name != AT_UNNAMED && name != I30) {
 		name = ntfs_ucsndup(name, name_len);
@@ -3161,7 +3164,8 @@ int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 		goto err_out;
 	}
 
-	err = ntfs_attr_lookup(type, name, name_len, 0, 0, NULL, 0, ctx);
+	ic = type == AT_DATA && name_len ? IGNORE_CASE : CASE_SENSITIVE;
+	err = ntfs_attr_lookup(type, name, name_len, ic, 0, NULL, 0, ctx);
 	if (err)
 		goto put_err_out;
 
@@ -3346,7 +3350,8 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
 			not_mapped = 1;
 
 		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-					CASE_SENSITIVE, next_vcn, NULL, 0, ctx);
+					CASE_SENSITIVE, next_vcn,
+					NULL, 0, ctx);
 		if (err)
 			break;
 
@@ -3431,6 +3436,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	struct ntfs_attr_search_ctx *nctx;
 	struct attr_record *a;
 	int err;
+	u32 ic;
 	struct mft_record *ni_mrec;
 	struct super_block *sb;
 
@@ -3466,9 +3472,11 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
 	 * file record.
 	 */
-	err = ntfs_attr_find(a->type, (__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
-				a->name_length, CASE_SENSITIVE, NULL,
-				0, nctx);
+	ic = a->type == AT_DATA && a->name_length ?
+			IGNORE_CASE : CASE_SENSITIVE;
+	err = ntfs_attr_find(a->type,
+			(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+			a->name_length, ic, NULL, 0, nctx);
 	if (!err) {
 		ntfs_debug("Attribute of such type, with same name already present in this MFT record.\n");
 		err = -EEXIST;
@@ -3800,7 +3808,8 @@ static int __ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni,
 	finished_build = false;
 	start_rl = ni->runlist.rl;
 	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, from_vcn, NULL, 0, ctx))) {
+				CASE_SENSITIVE, from_vcn, NULL,
+				0, ctx))) {
 		unsigned int de_cnt = 0;
 
 		a = ctx->attr;
@@ -4011,7 +4020,8 @@ static int __ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni,
 		ntfs_attr_reinit_search_ctx(ctx);
 		ntfs_debug("Deallocate marked extents.\n");
 		while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+				CASE_SENSITIVE, 0, NULL, 0,
+				ctx))) {
 			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
 					NTFS_VCN_DELETE_MARK)
 				continue;
@@ -4345,7 +4355,7 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni,
 			goto unlock_runlist;
 		}
 
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 		if (!ctx) {
 			ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 			err = -ENOMEM;
@@ -4404,8 +4414,8 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni,
 		return -ENOMEM;
 	}
 
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-				0, NULL, 0, ctx);
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (err) {
 		if (err == -ENOENT)
 			err = -EIO;
@@ -4724,8 +4734,8 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 		goto rollback;
 	}
 
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-			       0, NULL, 0, ctx);
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (err) {
 		if (err == -ENOENT)
 			err = -EIO;
@@ -4837,7 +4847,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	}
 
 	err = ntfs_attr_lookup(attr_ni->type, attr_ni->name, attr_ni->name_len,
-			0, 0, NULL, 0, ctx);
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (err) {
 		ntfs_error(sb, "ntfs_attr_lookup failed");
 		goto put_err_out;
@@ -5211,6 +5221,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 		s64 *lcn_count, s64 max_clu_count, bool *balloc, bool update_mp,
 		bool skip_holes)
 {
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct ntfs_attr_search_ctx *ctx;
 	struct runlist_element *rl, *rlc;
@@ -5224,10 +5235,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 	if (err)
 		return err;
 
-	if (NInoAttr(ni))
-		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
-	else
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -5377,7 +5385,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 	} else {
 		VFS_I(ni)->i_blocks += clu_count << (vol->cluster_size_bits - 9);
 		NInoSetRunlistDirty(ni);
-		mark_mft_record_dirty(ni);
+		mark_mft_record_dirty(base_ni);
 	}
 
 	*lcn_start = lcn;
@@ -5403,10 +5411,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 	struct ntfs_inode *base_ni;
 	struct super_block *sb = ni->vol->sb;
 
-	if (NInoAttr(ni))
-		base_ni = ni->ext.base_ntfs_ino;
-	else
-		base_ni = ni;
+	base_ni = ntfs_base_inode(ni);
 
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
 			(long long) ni->mft_no, ni->type);
@@ -5418,7 +5423,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 		err = ntfs_attr_map_whole_runlist(ni);
 		if (err)
 			return err;
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 		if (!ctx) {
 			ntfs_error(sb, "%s: Failed to get search context", __func__);
 			return -ENOMEM;
@@ -5460,6 +5465,7 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len)
 {
 	struct ntfs_attr_search_ctx *ctx;
+	u32 ic;
 	int ret;
 
 	ntfs_debug("Entering\n");
@@ -5471,7 +5477,8 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		return 0;
 	}
 
-	ret = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE,
+	ic = type == AT_DATA && name_len ? IGNORE_CASE : CASE_SENSITIVE;
+	ret = ntfs_attr_lookup(type, name, name_len, ic,
 			0, NULL, 0, ctx);
 	ntfs_attr_put_search_ctx(ctx);
 
@@ -5493,16 +5500,18 @@ int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
 	if (IS_ERR(attr_vi)) {
 		err = PTR_ERR(attr_vi);
-		ntfs_error(ni->vol->sb, "Failed to open attribute 0x%02x of inode 0x%llx",
-				type, (unsigned long long)ni->mft_no);
+		ntfs_error(ni->vol->sb,
+			"Failed to open attribute 0x%02x of inode 0x%llx",
+			type, (unsigned long long)ni->mft_no);
 		return err;
 	}
 	attr_ni = NTFS_I(attr_vi);
 
 	err = ntfs_attr_rm(attr_ni);
 	if (err)
-		ntfs_error(ni->vol->sb, "Failed to remove attribute 0x%02x of inode 0x%llx",
-				type, (unsigned long long)ni->mft_no);
+		ntfs_error(ni->vol->sb,
+			"Failed to remove attribute 0x%02x of inode 0x%llx",
+			type, (unsigned long long)ni->mft_no);
 	iput(attr_vi);
 	return err;
 }
@@ -5578,13 +5587,14 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 
 int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct runlist_element *hole_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx;
 	int ret;
 	size_t new_rl_count;
 
-	if (NInoAttr(ni) || ni->type != AT_DATA)
+	if (ni->type != AT_DATA)
 		return -EOPNOTSUPP;
 	if (start_vcn > ntfs_bytes_to_cluster(vol, ni->allocated_size))
 		return -EINVAL;
@@ -5633,14 +5643,14 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	if (ret)
 		return ret;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ret = -ENOMEM;
 		return ret;
 	}
 
-	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-			       0, NULL, 0, ctx);
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (ret) {
 		ntfs_attr_put_search_ctx(ctx);
 		return ret;
@@ -5657,6 +5667,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 
 int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct runlist_element *punch_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx = NULL;
@@ -5665,7 +5676,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	int ret;
 	size_t new_rl_cnt;
 
-	if (NInoAttr(ni) || ni->type != AT_DATA)
+	if (ni->type != AT_DATA)
 		return -EOPNOTSUPP;
 
 	end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
@@ -5721,14 +5732,14 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	}
 	up_write(&ni->runlist.lock);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ret = -ENOMEM;
 		goto out_rl;
 	}
 
-	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-			       0, NULL, 0, ctx);
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (ret)
 		goto out_ctx;
 
@@ -5746,12 +5757,13 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 		ntfs_attr_put_search_ctx(ctx);
 out_rl:
 	kvfree(punch_rl);
-	mark_mft_record_dirty(ni);
+	mark_mft_record_dirty(base_ni);
 	return ret;
 }
 
 int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct runlist_element *punch_rl, *rl;
 	s64 end_vcn;
@@ -5759,7 +5771,7 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 	int ret;
 	size_t new_rl_count;
 
-	if (NInoAttr(ni) || ni->type != AT_DATA)
+	if (ni->type != AT_DATA)
 		return -EOPNOTSUPP;
 
 	end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
@@ -5803,12 +5815,13 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 		ntfs_error(vol->sb, "Freeing of clusters failed");
 
 	kvfree(punch_rl);
-	mark_mft_record_dirty(ni);
+	mark_mft_record_dirty(base_ni);
 	return ret;
 }
 
 int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bool keep_size)
 {
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct mft_record *mrec;
 	struct ntfs_attr_search_ctx *ctx;
@@ -5820,7 +5833,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	struct runlist_element *rl;
 	bool balloc;
 
-	if (NInoAttr(ni) || ni->type != AT_DATA)
+	if (ni->type != AT_DATA)
 		return -EINVAL;
 
 	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
@@ -5831,20 +5844,21 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 			return err;
 	}
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-	mrec = map_mft_record(ni);
+	mutex_lock_nested(&base_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mrec = map_mft_record(base_ni);
 	if (IS_ERR(mrec)) {
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&base_ni->mrec_lock);
 		return PTR_ERR(mrec);
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out_unmap;
 	}
 
-	err = ntfs_attr_lookup(AT_DATA, AT_UNNAMED, 0, 0, 0, NULL, 0, ctx);
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (err) {
 		err = -EIO;
 		goto out_unmap;
@@ -5857,25 +5871,28 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 			goto out_unmap;
 		if (keep_size) {
 			ntfs_attr_reinit_search_ctx(ctx);
-			err = ntfs_attr_lookup(AT_DATA, AT_UNNAMED, 0, 0, 0, NULL, 0, ctx);
+			err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+					CASE_SENSITIVE, 0, NULL, 0,
+					ctx);
 			if (err) {
 				err = -EIO;
 				goto out_unmap;
 			}
 			ni->data_size = old_data_size;
+			i_size_write(VFS_I(ni), old_data_size);
 			if (NInoNonResident(ni))
 				ctx->attr->data.non_resident.data_size =
 					cpu_to_le64(old_data_size);
 			else
 				ctx->attr->data.resident.value_length =
 					cpu_to_le32((u32)old_data_size);
-			mark_mft_record_dirty(ni);
+			mark_mft_record_dirty(base_ni);
 		}
 	}
 
 	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(ni);
-	mutex_unlock(&ni->mrec_lock);
+	unmap_mft_record(base_ni);
+	mutex_unlock(&base_ni->mrec_lock);
 
 	if (!NInoNonResident(ni))
 		goto out;
@@ -5917,12 +5934,13 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 			}
 
 			while (try_alloc_cnt > 0) {
-				mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+				mutex_lock_nested(&base_ni->mrec_lock,
+						NTFS_INODE_MUTEX_NORMAL);
 				down_write(&ni->runlist.lock);
 				err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
 							    try_alloc_cnt, &balloc, false, false);
 				up_write(&ni->runlist.lock);
-				mutex_unlock(&ni->mrec_lock);
+				mutex_unlock(&base_ni->mrec_lock);
 				if (err)
 					goto out;
 
@@ -5950,12 +5968,12 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	/* allocate clusters outside of initialized_size */
 	try_alloc_cnt = vcn_end - vcn;
 	while (try_alloc_cnt > 0) {
-		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		mutex_lock_nested(&base_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 		down_write(&ni->runlist.lock);
 		err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
 					    try_alloc_cnt, &balloc, false, false);
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&base_ni->mrec_lock);
 		if (err || fatal_signal_pending(current))
 			goto signal_out;
 
@@ -5965,7 +5983,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	}
 
 	if (NInoRunlistDirty(ni)) {
-		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		mutex_lock_nested(&base_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 		down_write(&ni->runlist.lock);
 		err = ntfs_attr_update_mapping_pairs_locked(ni, 0, ni);
 		if (err)
@@ -5973,14 +5991,14 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 		else
 			NInoClearRunlistDirty(ni);
 		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&base_ni->mrec_lock);
 	}
 	return err;
 out_unmap:
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(ni);
-	mutex_unlock(&ni->mrec_lock);
+	unmap_mft_record(base_ni);
+	mutex_unlock(&base_ni->mrec_lock);
 out:
 	return err >= 0 ? 0 : err;
 signal_out:
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index 6edd5d2d9bf2..8291c4c95b37 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -374,7 +374,8 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 
 	err = ntfs_attr_lookup(attr->type, (attr->name_length) ? (__le16 *)
 			((u8 *)attr + le16_to_cpu(attr->name_offset)) :
-			AT_UNNAMED, attr->name_length, CASE_SENSITIVE,
+			AT_UNNAMED, attr->name_length,
+			CASE_SENSITIVE,
 			le64_to_cpu(lowest_vcn),
 			(attr->non_resident) ? NULL : ((u8 *)attr +
 			le16_to_cpu(attr->data.resident.value_offset)), (attr->non_resident) ?
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 1e2500a52148..7818d88b2133 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -15,6 +15,11 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/compat.h>
 #include <linux/falloc.h>
+#include <linux/file.h>
+#include <linux/filelock.h>
+#include <linux/overflow.h>
+#include <linux/security.h>
+#include <uapi/linux/ntfs.h>
 
 #include "lcnalloc.h"
 #include "ntfs.h"
@@ -23,8 +28,8 @@
 #include "iomap.h"
 #include "bitmap.h"
 #include "volume.h"
-
-#include <linux/filelock.h>
+#include "mft.h"
+#include "stream.h"
 
 /*
  * ntfs_file_open - called when an inode is about to be opened
@@ -44,7 +49,7 @@
  *
  * After the check passes, just call generic_file_open() to do its work.
  */
-static int ntfs_file_open(struct inode *vi, struct file *filp)
+int ntfs_file_open(struct inode *vi, struct file *filp)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 
@@ -78,6 +83,7 @@ static int ntfs_file_open(struct inode *vi, struct file *filp)
 static int ntfs_trim_prealloc(struct inode *vi)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct runlist_element *rl;
 	s64 aligned_data_size;
@@ -86,7 +92,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
 	int err = 0;
 
 	inode_lock(vi);
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&mrec_ni->mrec_lock);
 	down_write(&ni->runlist.lock);
 
 	aligned_data_size = round_up(ni->data_size, vol->cluster_size);
@@ -121,13 +127,13 @@ static int ntfs_trim_prealloc(struct inode *vi)
 
 out_unlock:
 	up_write(&ni->runlist.lock);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 	inode_unlock(vi);
 
 	return err;
 }
 
-static int ntfs_file_release(struct inode *vi, struct file *filp)
+int ntfs_file_release(struct inode *vi, struct file *filp)
 {
 	if (!NInoCompressed(NTFS_I(vi)) &&
 	    !NInoWofCompressed(NTFS_I(vi)))
@@ -156,7 +162,7 @@ static int ntfs_file_release(struct inode *vi, struct file *filp)
  * Also, if @datasync is true, we do not wait on the inode to be written out
  * but we always wait on the page cache pages to be written out.
  */
-static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
+int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 			   int datasync)
 {
 	struct inode *vi = filp->f_mapping->host;
@@ -165,6 +171,7 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	int err, ret = 0;
 	struct inode *parent_vi, *ia_vi;
 	struct ntfs_attr_search_ctx *ctx;
+	bool non_resident, stream;
 
 	ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
 
@@ -175,10 +182,25 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	if (err)
 		return err;
 
-	if (!datasync || !NInoNonResident(NTFS_I(vi)))
+	stream = ntfs_inode_is_named_stream(ni);
+	non_resident = NInoNonResident(ni);
+	if (stream) {
+		ni = ni->ext.base_ntfs_ino;
+		vi = VFS_I(ni);
+	}
+
+	if (!datasync || !non_resident)
 		ret = __ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
 
+	/*
+	 * file_write_and_wait_range() already flushed this stream mapping.
+	 * Do not walk sibling attribute mappings while holding the base MFT
+	 * lock; ordinary file fsync retains its existing behavior below.
+	 */
+	if (stream)
+		goto sync_volume;
+
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
 	if (!ctx)
 		return -ENOMEM;
@@ -227,6 +249,7 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	mutex_unlock(&ni->mrec_lock);
 	ntfs_attr_put_search_ctx(ctx);
 
+sync_volume:
 	write_inode_now(vol->mftbmp_ino, 1);
 	down_write(&vol->lcnbmp_lock);
 	write_inode_now(vol->lcnbmp_ino, 1);
@@ -268,12 +291,18 @@ static void ntfs_pagecache_extend(struct inode *vi, loff_t from, loff_t to)
 				    PAGE_SIZE, 0);
 }
 
-static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
+int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
+	struct inode *time_vi = vi;
+	bool stream = ntfs_inode_is_named_stream(ni);
 	int err;
 	loff_t old_size = vi->i_size;
 
+	if (stream && NVolShutdown(ni->vol))
+		return -EIO;
+
 	if (NInoCompressed(ni) || NInoEncrypted(ni) || NInoWofCompressed(ni)) {
 		ntfs_warning(
 			vi->i_sb,
@@ -293,7 +322,22 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 	 * readers cannot observe the size change until the attribute
 	 * updates below have completed.
 	 */
-	filemap_invalidate_lock(vi->i_mapping);
+	if (stream) {
+		filemap_invalidate_lock(vi->i_mapping);
+		err = filemap_write_and_wait(vi->i_mapping);
+		if (err)
+			goto out_unlock_mapping;
+
+		mutex_lock(&base_ni->mrec_lock);
+		err = ntfs_stream_inode_validate(vi);
+		mutex_unlock(&base_ni->mrec_lock);
+		if (err)
+			goto out_unlock_mapping;
+		time_vi = VFS_I(base_ni);
+	} else {
+		filemap_invalidate_lock(vi->i_mapping);
+	}
+
 	if (attr->ia_size > old_size) {
 		truncate_pagecache(vi, old_size);
 		i_size_write(vi, attr->ia_size);
@@ -302,9 +346,28 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		truncate_setsize(vi, attr->ia_size);
 	}
 
-	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
-	if (err)
+	if (stream) {
+		mutex_lock(&base_ni->mrec_lock);
+		err = ntfs_stream_inode_validate(vi);
+		if (!err)
+			err = __ntfs_attr_truncate_vfs(ni, attr->ia_size,
+					old_size);
+		mutex_unlock(&base_ni->mrec_lock);
+	} else {
+		err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
+	}
+	if (err) {
 		i_size_write(vi, old_size);
+		goto out_unlock_mapping;
+	}
+
+	if (stream) {
+		inode_set_mtime_to_ts(time_vi,
+				inode_set_ctime_current(time_vi));
+		mark_inode_dirty(time_vi);
+	}
+
+out_unlock_mapping:
 	filemap_invalidate_unlock(vi->i_mapping);
 
 	return err;
@@ -437,7 +500,7 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
-static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
+loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
 
@@ -466,7 +529,7 @@ static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
 
-static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *vi = file_inode(iocb->ki_filp);
 	struct super_block *sb = vi->i_sb;
@@ -513,7 +576,11 @@ static int ntfs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 	if (size) {
 		if (i_size_read(inode) < iocb->ki_pos + size) {
 			i_size_write(inode, iocb->ki_pos + size);
-			mark_inode_dirty(inode);
+			if (ntfs_inode_is_named_stream(NTFS_I(inode)))
+				mark_inode_dirty(VFS_I(
+					NTFS_I(inode)->ext.base_ntfs_ino));
+			else
+				mark_inode_dirty(inode);
 		}
 	}
 
@@ -583,6 +650,7 @@ static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int ntfs_expand_for_write(struct ntfs_inode *ni, loff_t end)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	loff_t prealloc_size = 0;
 	int err;
 
@@ -598,14 +666,14 @@ static int ntfs_expand_for_write(struct ntfs_inode *ni, loff_t end)
 		prealloc_size = ni->allocated_size + vol->preallocated_size;
 	}
 
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&mrec_ni->mrec_lock);
 	err = ntfs_attr_expand(ni, end, prealloc_size);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 
 	return err;
 }
 
-static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *vi = file->f_mapping->host;
@@ -692,13 +760,21 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 out:
 	if (ret < 0 && ret != -EIOCBQUEUED) {
 		if (ni->initialized_size != old_init_size) {
-			mutex_lock(&ni->mrec_lock);
+			struct ntfs_inode *mrec_ni =
+				ntfs_base_inode(ni);
+
+			mutex_lock(&mrec_ni->mrec_lock);
 			ntfs_attr_set_initialized_size(ni, old_init_size);
-			mutex_unlock(&ni->mrec_lock);
+			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 		if (ni->data_size != old_data_size) {
+			struct ntfs_inode *mrec_ni =
+				ntfs_base_inode(ni);
+
 			truncate_setsize(vi, old_data_size);
+			mutex_lock(&mrec_ni->mrec_lock);
 			ntfs_attr_truncate(ni, old_data_size);
+			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 	}
 out_lock:
@@ -727,7 +803,6 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_lock_shared(mapping);
 	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
 	filemap_invalidate_unlock_shared(mapping);
-
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
@@ -738,7 +813,7 @@ static const struct vm_operations_struct ntfs_file_vm_ops = {
 	.page_mkwrite	= ntfs_filemap_page_mkwrite,
 };
 
-static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
+int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 {
 	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
@@ -771,7 +846,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	return 0;
 }
 
-static int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	if (NInoWofCompressed(NTFS_I(inode)))
@@ -808,7 +883,7 @@ static const char *ntfs_get_link(struct dentry *dentry, struct inode *inode,
 	return ni->target;
 }
 
-static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
 {
 	if (NVolShutdown(NTFS_SB(in->f_mapping->host->i_sb)))
@@ -924,6 +999,14 @@ long ntfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ntfs_ioctl_set_volume_label(filp, arg);
 	case FITRIM:
 		return ntfs_ioctl_fitrim(NTFS_SB(file_inode(filp)->i_sb), arg);
+	case NTFS_IOC_STREAM_READ:
+		return ntfs_ioctl_stream_read(filp, arg);
+	case NTFS_IOC_STREAM_WRITE:
+		return ntfs_ioctl_stream_write(filp, arg);
+	case NTFS_IOC_STREAM_REMOVE:
+		return ntfs_ioctl_stream_remove(filp, arg);
+	case NTFS_IOC_LIST_STREAMS:
+		return ntfs_ioctl_list_streams(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -980,6 +1063,7 @@ static int ntfs_allocate_range(struct ntfs_inode *ni, int mode, loff_t offset,
 static int ntfs_punch_hole(struct ntfs_inode *ni, int mode, loff_t offset,
 		loff_t len)
 {
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct inode *vi = VFS_I(ni);
 	loff_t end_offset;
@@ -1044,16 +1128,17 @@ static int ntfs_punch_hole(struct ntfs_inode *ni, int mode, loff_t offset,
 		end_vcn--;
 	}
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&mrec_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	err = ntfs_non_resident_attr_punch_hole(ni, start_vcn,
 			end_vcn - start_vcn);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 out:
 	return err;
 }
 
 static int ntfs_collapse_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 {
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct inode *vi = VFS_I(ni);
 	loff_t old_size, new_size;
@@ -1087,10 +1172,10 @@ static int ntfs_collapse_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 
 	truncate_pagecache(vi, offset_down);
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&mrec_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	err = ntfs_non_resident_attr_collapse_range(ni, start_vcn,
 			end_vcn - start_vcn);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 
 	if (new_size != old_size)
 		i_size_write(vi, ni->data_size);
@@ -1100,6 +1185,7 @@ static int ntfs_collapse_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 
 static int ntfs_insert_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 {
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
 	struct inode *vi = VFS_I(ni);
 	loff_t offset_down = round_down(offset,
@@ -1143,10 +1229,10 @@ static int ntfs_insert_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 
 	truncate_pagecache(vi, offset_down);
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mutex_lock_nested(&mrec_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	err = ntfs_non_resident_attr_insert_range(ni, start_vcn,
 			end_vcn - start_vcn);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 
 	if (new_size != old_size)
 		i_size_write(vi, ni->data_size);
@@ -1159,11 +1245,13 @@ static int ntfs_insert_range(struct ntfs_inode *ni, loff_t offset, loff_t len)
 		 FALLOC_FL_INSERT_RANGE | FALLOC_FL_PUNCH_HOLE |	\
 		 FALLOC_FL_COLLAPSE_RANGE)
 
-static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *vi = file_inode(file);
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
 	struct ntfs_volume *vol = ni->vol;
+	bool stream = ntfs_inode_is_named_stream(ni);
 	int err = 0;
 	loff_t old_size, new_size;
 
@@ -1233,9 +1321,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	filemap_invalidate_unlock(vi->i_mapping);
 
 	if (!err) {
-		NInoSetFileNameDirty(ni);
-		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
-		mark_inode_dirty(vi);
+		if (stream) {
+			inode_set_mtime_to_ts(VFS_I(base_ni),
+					inode_set_ctime_current(VFS_I(base_ni)));
+			mark_inode_dirty(VFS_I(base_ni));
+		} else {
+			NInoSetFileNameDirty(ni);
+			inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
+			mark_inode_dirty(vi);
+		}
 	}
 
 	inode_unlock(vi);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index eca0724c4358..ed2cb7e9e5bb 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -19,6 +19,7 @@
 #include "attrib.h"
 #include "iomap.h"
 #include "object_id.h"
+#include "stream.h"
 
 /*
  * ntfs_test_inode - compare two (possibly fake) inodes for equality
@@ -55,9 +56,18 @@ int ntfs_test_inode(struct inode *vi, void *data)
 			return 0;
 		if (ni->name_len != na->name_len)
 			return 0;
-		if (na->name_len && memcmp(ni->name, na->name,
-				na->name_len * sizeof(__le16)))
-			return 0;
+		if (na->name_len) {
+			if (ntfs_inode_is_named_stream(ni)) {
+				if (!ntfs_names_are_equal(ni->name, ni->name_len,
+						na->name, na->name_len,
+						IGNORE_CASE, ni->vol->upcase,
+						ni->vol->upcase_len))
+					return 0;
+			} else if (memcmp(ni->name, na->name,
+					na->name_len * sizeof(__le16))) {
+				return 0;
+			}
+		}
 		if (!ni->ext.base_ntfs_ino)
 			return 0;
 	}
@@ -66,6 +76,33 @@ int ntfs_test_inode(struct inode *vi, void *data)
 	return 1;
 }
 
+/*
+ * ntfs_test_inode_rcu() - Test an inode during RCU hash lookup
+ * @vi: inode being tested
+ * @data: NTFS attribute key to match
+ *
+ * Reject inodes being initialized or destroyed, then run the normal NTFS
+ * inode match while holding @vi's inode lock.
+ *
+ * Return: 1 if the inode matches, or 0 otherwise.
+ */
+int ntfs_test_inode_rcu(struct inode *vi, void *data)
+{
+	unsigned long state;
+	int ret;
+
+	spin_lock(&vi->i_lock);
+	state = inode_state_read_once(vi);
+	if (state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		ret = 0;
+		goto out;
+	}
+	ret = ntfs_test_inode(vi, data);
+out:
+	spin_unlock(&vi->i_lock);
+	return ret;
+}
+
 /*
  * ntfs_init_locked_inode - initialize an inode
  * @vi:		vfs inode to initialize
@@ -467,6 +504,7 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->seq_no = 0;
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
+	atomic_set(&ni->stream_open_count, 0);
 	ntfs_init_runlist(&ni->runlist);
 	mutex_init(&ni->mrec_lock);
 	if (ni->type == AT_ATTRIBUTE_LIST) {
@@ -1319,6 +1357,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	struct attr_record *a;
 	struct ntfs_attr_search_ctx *ctx;
 	int err = 0;
+	u32 ic;
 
 	ntfs_debug("Entering for i_ino 0x%llx.", ni->mft_no);
 
@@ -1333,8 +1372,12 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
 	vi->i_generation = ni->seq_no = base_ni->seq_no;
 
-	/* Set inode type to zero but preserve permissions. */
-	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
+	/* Named data streams are regular files throughout initialization. */
+	vi->i_mode = base_vi->i_mode & ~S_IFMT;
+	if (ni->type == AT_DATA && ni->name_len) {
+		vi->i_mode |= S_IFREG;
+		vi->i_flags = base_vi->i_flags;
+	}
 
 	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
@@ -1347,11 +1390,29 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		goto unm_err_out;
 	}
 	/* Find the attribute. */
+	ic = ntfs_inode_is_named_stream(ni) ? IGNORE_CASE : CASE_SENSITIVE;
 	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx);
+			ic, 0, NULL, 0, ctx);
 	if (unlikely(err))
 		goto unm_err_out;
 	a = ctx->attr;
+	if (ntfs_inode_is_named_stream(ni)) {
+		__le16 *disk_name = (__le16 *)((u8 *)a +
+				le16_to_cpu(a->name_offset));
+
+		/* Subsequent extent and mutation lookups must select this name. */
+		if (ni->name == I30) {
+			ni->name = kmalloc_array(ni->name_len + 1,
+						sizeof(__le16), GFP_NOFS);
+			if (!ni->name) {
+				err = -ENOMEM;
+				goto unm_err_out;
+			}
+		}
+		memcpy(ni->name, disk_name,
+			ni->name_len * sizeof(__le16));
+		ni->name[ni->name_len] = 0;
+	}
 	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
 		if (a->flags & ATTR_COMPRESSION_MASK) {
 			NInoSetCompressed(ni);
@@ -2484,6 +2545,7 @@ int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
 				 const loff_t new_size)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 	loff_t old_init_size;
 	unsigned long flags;
 	int err;
@@ -2511,9 +2573,9 @@ int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
 	}
 
 
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&mrec_ni->mrec_lock);
 	err = ntfs_attr_set_initialized_size(ni, new_size);
-	mutex_unlock(&ni->mrec_lock);
+	mutex_unlock(&mrec_ni->mrec_lock);
 	if (err)
 		truncate_setsize(vi, old_init_size);
 	return err;
@@ -3602,19 +3664,30 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 	struct address_space *mapping = vi->i_mapping;
 	struct folio *folio;
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			base_ni : ni;
 	s64 isize;
 	u32 attr_len, total = 0, offset;
 	pgoff_t index;
 	int err = 0;
+	bool claimed = false;
 
 	WARN_ON(!NInoAttr(ni));
 	if (!count)
 		return 0;
 
-	mutex_lock(&ni->mrec_lock);
+	mutex_lock(&mrec_ni->mrec_lock);
+	if (ntfs_inode_is_named_stream(ni)) {
+		err = ntfs_stream_inode_validate(vi);
+		if (err) {
+			mutex_unlock(&mrec_ni->mrec_lock);
+			return err;
+		}
+	}
 	isize = i_size_read(vi);
 	if (pos > isize) {
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 		return -EINVAL;
 	}
 	if (pos + count > isize)
@@ -3624,30 +3697,35 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 		struct ntfs_attr_search_ctx *ctx;
 		u8 *attr;
 
-		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 		if (!ctx) {
 			ntfs_error(vi->i_sb, "Failed to get attr search ctx");
 			err = -ENOMEM;
-			mutex_unlock(&ni->mrec_lock);
+			mutex_unlock(&mrec_ni->mrec_lock);
 			goto out;
 		}
 
-		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				       CASE_SENSITIVE,
 				       0, NULL, 0, ctx);
 		if (err) {
 			ntfs_error(vi->i_sb, "Failed to look up attr %#x", ni->type);
 			ntfs_attr_put_search_ctx(ctx);
-			mutex_unlock(&ni->mrec_lock);
+			mutex_unlock(&mrec_ni->mrec_lock);
 			goto out;
 		}
 
 		attr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
 		memcpy(buf, (u8 *)attr + pos, count);
 		ntfs_attr_put_search_ctx(ctx);
-		mutex_unlock(&ni->mrec_lock);
+		mutex_unlock(&mrec_ni->mrec_lock);
 		return count;
 	}
-	mutex_unlock(&ni->mrec_lock);
+	if (ntfs_inode_is_named_stream(ni)) {
+		atomic_inc(&ni->stream_open_count);
+		claimed = true;
+	}
+	mutex_unlock(&mrec_ni->mrec_lock);
 
 	index = pos >> PAGE_SHIFT;
 	do {
@@ -3671,6 +3749,8 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 		index++;
 	} while (count);
 out:
+	if (claimed)
+		ntfs_stream_put(vi);
 	return err ? (s64)err : total;
 }
 
@@ -3698,8 +3778,8 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
 		}
 
 		ntfs_attr_reinit_search_ctx(ctx);
-		ret = ntfs_attr_lookup(ni->type,
-				       ni->name, ni->name_len, CASE_SENSITIVE,
+		ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				       CASE_SENSITIVE,
 				       0, NULL, 0, ctx);
 		if (ret) {
 			ntfs_error(sb, "Failed to look up attr %#x", ni->type);
@@ -3713,6 +3793,13 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
 		return 0;
 	}
 
+	/* Named streams initialize gaps after dropping the MFT record lock. */
+	if (ntfs_inode_is_named_stream(ni)) {
+		if (i_size_read(vi) < ni->data_size)
+			i_size_write(vi, ni->data_size);
+		return 0;
+	}
+
 	if (pos + count > ni->initialized_size) {
 		ctx->attr->data.non_resident.initialized_size = cpu_to_le64(pos + count);
 		mark_mft_record_dirty(ctx->ntfs_ino);
@@ -3767,7 +3854,6 @@ static s64 __ntfs_inode_resident_attr_pwrite(struct inode *vi,
 
 static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 						 s64 pos, s64 count, u8 *buf,
-						 struct ntfs_attr_search_ctx *ctx,
 						 bool sync)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
@@ -3906,37 +3992,79 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool sync)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
+	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
+			base_ni : ni;
 	struct ntfs_attr_search_ctx *ctx;
 	s64 ret;
 
 	WARN_ON(!NInoAttr(ni));
 
-	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+	if (ntfs_inode_is_named_stream(ni)) {
+		if (NInoEncrypted(ni))
+			return -EACCES;
+		if (NInoCompressed(ni))
+			return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&mrec_ni->mrec_lock);
+	if (ntfs_inode_is_named_stream(ni)) {
+		ret = ntfs_stream_inode_validate(vi);
+		if (ret)
+			goto out_unlock;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ntfs_error(vi->i_sb, "Failed to get attr search ctx");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_unlock;
 	}
 
-	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE,
 			       0, NULL, 0, ctx);
 	if (ret) {
 		ntfs_attr_put_search_ctx(ctx);
 		ntfs_error(vi->i_sb, "Failed to look up attr %#x", ni->type);
-		return ret;
+		goto out_unlock;
 	}
 
-	mutex_lock(&ni->mrec_lock);
 	ret = ntfs_enlarge_attribute(vi, pos, count, ctx);
-	mutex_unlock(&ni->mrec_lock);
 	if (ret)
-		goto out;
+		goto out_ctx;
 
-	if (NInoNonResident(ni))
-		ret = __ntfs_inode_non_resident_attr_pwrite(vi, pos, count, buf, ctx, sync);
-	else
+	if (!NInoNonResident(ni)) {
 		ret = __ntfs_inode_resident_attr_pwrite(vi, pos, count, buf, ctx);
-out:
+		goto out_ctx;
+	}
+
+	if (ntfs_inode_is_named_stream(ni))
+		atomic_inc(&ni->stream_open_count);
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&mrec_ni->mrec_lock);
+	/* Attribute writes bypass iomap's delayed-allocation preparation. */
+	if (ntfs_inode_is_named_stream(ni)) {
+		/* A failed write must not expose any newly initialized data. */
+		ret = ntfs_extend_initialized_size(vi, pos + count, pos + count);
+		if (!ret)
+			ret = ntfs_attr_fallocate(ni, pos, count, true);
+	}
+	if (!ret)
+		ret = __ntfs_inode_non_resident_attr_pwrite(vi, pos, count,
+							    buf, sync);
+	if (ntfs_inode_is_named_stream(ni))
+		ntfs_stream_put(vi);
+	if (ret > 0 && ntfs_inode_is_named_stream(ni))
+		ntfs_stream_update_base_time(base_ni);
+	return ret;
+
+out_ctx:
 	ntfs_attr_put_search_ctx(ctx);
+out_unlock:
+	mutex_unlock(&mrec_ni->mrec_lock);
+	if (ret > 0 && ntfs_inode_is_named_stream(ni))
+		ntfs_stream_update_base_time(base_ni);
 	return ret;
 }
 
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index ff61bd402df0..f4e5562d56a7 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -107,6 +107,7 @@ struct ntfs_inode {
 	__le32 type;
 	__le16 *name;
 	u32 name_len;
+	atomic_t stream_open_count;
 	struct runlist runlist;
 	s64 data_size;
 	s64 initialized_size;
@@ -178,6 +179,7 @@ struct ntfs_inode {
  * NI_BeingCreated		ntfs inode is being created.
  * NI_HasEA			ntfs inode has EA attribute.
  * NI_RunlistDirty		runlist need to be updated.
+ * NI_StreamUnlinked		Named stream is unlinked but still open.
  */
 enum {
 	NI_Dirty,
@@ -199,6 +201,7 @@ enum {
 	NI_BeingCreated,
 	NI_HasEA,
 	NI_RunlistDirty,
+	NI_StreamUnlinked,
 };
 
 /*
@@ -259,6 +262,7 @@ TAS_NINO_FNS(FileNameDirty)
 NINO_FNS(BeingDeleted)
 NINO_FNS(HasEA)
 NINO_FNS(RunlistDirty)
+NINO_FNS(StreamUnlinked)
 
 /*
  * The full structure containing a ntfs_inode and a vfs struct inode. Used for
@@ -286,6 +290,20 @@ static inline struct inode *VFS_I(struct ntfs_inode *ni)
 	return &container_of(ni, struct big_ntfs_inode, ntfs_inode)->vfs_inode;
 }
 
+/* Return true when @ni represents a named $DATA attribute inode. */
+static inline bool ntfs_inode_is_named_stream(struct ntfs_inode *ni)
+{
+	return NInoAttr(ni) && ni->type == AT_DATA && ni->name_len;
+}
+
+/* Return the base MFT inode for an attribute inode, or @ni itself. */
+static inline struct ntfs_inode *ntfs_base_inode(struct ntfs_inode *ni)
+{
+	if (NInoAttr(ni) && ni->nr_extents == -1 && ni->ext.base_ntfs_ino)
+		return ni->ext.base_ntfs_ino;
+	return ni;
+}
+
 /*
  * ntfs_attr - ntfs in memory attribute structure
  *
@@ -304,6 +322,7 @@ struct ntfs_attr {
 };
 
 int ntfs_test_inode(struct inode *vi, void *data);
+int ntfs_test_inode_rcu(struct inode *vi, void *data);
 struct inode *ntfs_iget(struct super_block *sb, u64 mft_no);
 struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 		__le16 *name, u32 name_len);
diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
new file mode 100644
index 000000000000..f18312db9859
--- /dev/null
+++ b/fs/ntfs/named_stream.c
@@ -0,0 +1,915 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS named stream handling.
+ *
+ * Copyright (c) 2026 LG Electronics Co., Ltd.
+ */
+
+#include <linux/file.h>
+#include <linux/overflow.h>
+
+#include <uapi/linux/ntfs.h>
+
+#include "attrib.h"
+#include "dir.h"
+#include "iomap.h"
+#include "mft.h"
+#include "ntfs.h"
+#include "stream.h"
+#include "time.h"
+
+#define NTFS_STREAM_MAX_IO	(16 * 1024 * 1024)
+
+/*
+ * ntfs_check_stream_name() - Validate a named-stream name
+ * @name: UTF-16LE stream name
+ * @name_len: Length of @name in UTF-16 code units
+ *
+ * Reject empty, overlong, separator-containing, or malformed UTF-16 names.
+ *
+ * Return: 0 if valid, or -EINVAL otherwise.
+ */
+int ntfs_check_stream_name(const __le16 *name, unsigned int name_len)
+{
+	unsigned int i;
+
+	if (!name_len || name_len > NTFS_MAX_NAME_LEN)
+		return -EINVAL;
+
+	for (i = 0; i < name_len; i++) {
+		u16 c = le16_to_cpu(name[i]);
+
+		if (c == 0 || c == '/' || c == '\\' || c == ':')
+			return -EINVAL;
+		if (c >= 0xd800 && c <= 0xdbff) {
+			if (++i >= name_len)
+				return -EINVAL;
+			c = le16_to_cpu(name[i]);
+			if (c < 0xdc00 || c > 0xdfff)
+				return -EINVAL;
+		} else if (c >= 0xdc00 && c <= 0xdfff) {
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ntfs_stream_inode_refresh() - Refresh base-derived stream inode metadata
+ * @vi: inode representing a named stream
+ *
+ * Synchronize ownership, mode, flags, timestamps, and generation with the
+ * base inode. Stream size and allocation remain specific to the stream.
+ */
+void ntfs_stream_inode_refresh(struct inode *vi)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct inode *base_vi;
+
+	if (!ntfs_inode_is_named_stream(ni) || ni->nr_extents != -1)
+		return;
+
+	base_vi = VFS_I(ni->ext.base_ntfs_ino);
+	vi->i_uid = base_vi->i_uid;
+	vi->i_gid = base_vi->i_gid;
+	vi->i_mode = (base_vi->i_mode & ~S_IFMT) | S_IFREG;
+	vi->i_flags = base_vi->i_flags;
+	inode_set_mtime_to_ts(vi, inode_get_mtime(base_vi));
+	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
+	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
+	vi->i_generation = base_vi->i_generation;
+}
+
+/*
+ * ntfs_stream_update_base_time() - Update base timestamps after a stream change
+ * @base_ni: base inode containing the stream attribute
+ *
+ * Update the base inode's mtime and ctime and mark it dirty. The helper takes
+ * the base inode lock.
+ */
+void ntfs_stream_update_base_time(struct ntfs_inode *base_ni)
+{
+	struct inode *base_vi = VFS_I(base_ni);
+
+	inode_lock_nested(base_vi, I_MUTEX_PARENT);
+	inode_set_mtime_to_ts(base_vi, inode_set_ctime_current(base_vi));
+	mark_inode_dirty(base_vi);
+	inode_unlock(base_vi);
+}
+
+/*
+ * ntfs_stream_inode_validate() - Validate a named-stream inode
+ * @vi: stream inode to validate
+ *
+ * Verify that @vi still maps to its named DATA attribute and refresh its
+ * base-derived metadata. The caller must hold the base inode's MFT-record
+ * lock.
+ *
+ * Return: 0 if valid, or a negative errno.
+ */
+int ntfs_stream_inode_validate(struct inode *vi)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *base_ni;
+	struct ntfs_attr_search_ctx *ctx;
+	int err;
+
+	if (!ntfs_inode_is_named_stream(ni) || ni->nr_extents != -1)
+		return -EINVAL;
+
+	base_ni = ni->ext.base_ntfs_ino;
+	lockdep_assert_held(&base_ni->mrec_lock);
+	if (NVolShutdown(base_ni->vol))
+		return -EIO;
+	if (!NInoStreamUnlinked(ni) &&
+	    (!vi->i_nlink || !VFS_I(base_ni)->i_nlink ||
+	     NInoBeingDeleted(base_ni)))
+		return -ESTALE;
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+	err = ntfs_attr_lookup(AT_DATA, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	ntfs_attr_put_search_ctx(ctx);
+	if (err)
+		return err;
+
+	ntfs_stream_inode_refresh(vi);
+	return 0;
+}
+
+/*
+ * ntfs_stream_unlinked() - Check a cached stream's deferred-unlink state
+ * @base_ni: base inode containing the stream
+ * @name: UTF-16LE stream name
+ * @name_len: Length of @name in UTF-16 code units
+ *
+ * The caller must hold the base inode's MFT-record lock.
+ *
+ * Return: true if the cached stream inode is unlinked, or false if it is not
+ * cached or is still linked.
+ */
+bool ntfs_stream_unlinked(struct ntfs_inode *base_ni,
+		const __le16 *name, u32 name_len)
+{
+	struct ntfs_attr na = {
+		.mft_no = base_ni->mft_no,
+		.type = AT_DATA,
+		.name = (__le16 *)name,
+		.name_len = name_len,
+	};
+	struct inode *vi;
+	bool unlinked;
+
+	lockdep_assert_held(&base_ni->mrec_lock);
+	rcu_read_lock();
+	vi = find_inode_rcu(base_ni->vol->sb, na.mft_no,
+			ntfs_test_inode_rcu, &na);
+	if (!vi) {
+		rcu_read_unlock();
+		return false;
+	}
+	unlinked = NInoStreamUnlinked(NTFS_I(vi));
+	rcu_read_unlock();
+	return unlinked;
+}
+
+/*
+ * Hold a temporary stream reference so unlink cannot remove its attribute
+ * while an operation is using it.
+ */
+static int ntfs_stream_claim(struct inode *inode)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
+	int err;
+
+	mutex_lock(&base_ni->mrec_lock);
+	if (NInoStreamUnlinked(ni))
+		err = -ESTALE;
+	else
+		err = ntfs_stream_inode_validate(inode);
+	if (!err) {
+		if (atomic_read(&ni->stream_open_count) < 0)
+			err = -ESTALE;
+		else
+			atomic_inc(&ni->stream_open_count);
+	}
+	mutex_unlock(&base_ni->mrec_lock);
+	return err;
+}
+
+/*
+ * Remove an unlinked stream's DATA attribute after its final active reference
+ * is released. Base-inode deletion handles the attribute when the base is
+ * already being removed.
+ */
+static int ntfs_stream_finish_remove(struct inode *attr_vi)
+{
+	struct ntfs_inode *attr_ni = NTFS_I(attr_vi);
+	struct ntfs_inode *ni = attr_ni->ext.base_ntfs_ino;
+	int err;
+
+	mutex_lock(&ni->mrec_lock);
+	if (!NInoStreamUnlinked(attr_ni) ||
+	    atomic_cmpxchg(&attr_ni->stream_open_count, 0, -1)) {
+		err = 0;
+		goto out_unlock;
+	}
+	if (NInoBeingDeleted(ni) || !VFS_I(ni)->i_nlink) {
+		remove_inode_hash(attr_vi);
+		err = 0;
+		goto out_unlock;
+	}
+	mutex_unlock(&ni->mrec_lock);
+
+	truncate_inode_pages(attr_vi->i_mapping, 0);
+
+	mutex_lock(&ni->mrec_lock);
+	if (NVolShutdown(ni->vol)) {
+		err = -EIO;
+		goto out_unlock;
+	}
+	if (NInoBeingDeleted(ni) || !VFS_I(ni)->i_nlink) {
+		remove_inode_hash(attr_vi);
+		err = 0;
+		goto out_unlock;
+	}
+	err = ntfs_attr_rm(attr_ni);
+	if (!err) {
+		NInoClearDirty(attr_ni);
+		remove_inode_hash(attr_vi);
+	} else {
+		NInoSetBeingDeleted(attr_ni);
+		remove_inode_hash(attr_vi);
+	}
+
+out_unlock:
+	mutex_unlock(&ni->mrec_lock);
+	return err;
+}
+
+/*
+ * ntfs_stream_put() - Release a stream operation reference
+ * @vi: stream inode whose reference is being released
+ *
+ * Finish a deferred unlink when this is the last reference to an unlinked
+ * stream.
+ *
+ * Return: 0 on success, or a negative errno if deferred removal fails.
+ */
+int ntfs_stream_put(struct inode *vi)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	if (atomic_dec_and_test(&ni->stream_open_count) &&
+	    NInoStreamUnlinked(ni))
+		return ntfs_stream_finish_remove(vi);
+	return 0;
+}
+
+/*
+ * ntfs_remove_named_stream() - Remove a named DATA stream
+ * @ni: base inode containing the stream
+ * @uname: UTF-16LE stream name
+ * @uname_len: length of @uname in UTF-16 code units
+ * @expected_vi: expected cached stream inode, or NULL
+ *
+ * Refuse removal while the stream is open. If @expected_vi is non-NULL, it
+ * must be the inode currently associated with the named attribute.
+ *
+ * Return: 0 on success, -ENOENT if the stream is absent, or another negative
+ * errno.
+ */
+int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
+		u32 uname_len, struct inode *expected_vi)
+{
+	struct inode *attr_vi;
+	struct ntfs_inode *attr_ni;
+	int err;
+
+	if (!ni || !uname || uname_len == 0)
+		return -EINVAL;
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+	if (IS_APPEND(VFS_I(ni)) || IS_IMMUTABLE(VFS_I(ni)))
+		return -EPERM;
+	if (!(ni->vol->vol_flags & VOLUME_IS_DIRTY)) {
+		err = ntfs_set_volume_flags(ni->vol, VOLUME_IS_DIRTY);
+		if (err)
+			return err;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	if (NInoBeingDeleted(ni) || !VFS_I(ni)->i_nlink) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	attr_vi = ntfs_attr_iget(VFS_I(ni), AT_DATA, uname, uname_len);
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		goto out_unlock;
+	}
+	if (expected_vi && attr_vi != expected_vi) {
+		err = -ESTALE;
+		goto out_iput;
+	}
+
+	attr_ni = NTFS_I(attr_vi);
+	if (NInoStreamUnlinked(attr_ni)) {
+		err = -ENOENT;
+		goto out_iput;
+	}
+	if (atomic_read(&attr_ni->stream_open_count) > 0) {
+		err = -EBUSY;
+		goto out_iput;
+	}
+	err = ntfs_stream_inode_validate(attr_vi);
+	if (err)
+		goto out_iput;
+
+	NInoSetStreamUnlinked(attr_ni);
+	clear_nlink(attr_vi);
+	mutex_unlock(&ni->mrec_lock);
+
+	ntfs_stream_update_base_time(ni);
+	err = ntfs_stream_finish_remove(attr_vi);
+	iput(attr_vi);
+	return err;
+
+out_iput:
+	mutex_unlock(&ni->mrec_lock);
+	iput(attr_vi);
+	return err;
+out_unlock:
+	mutex_unlock(&ni->mrec_lock);
+	return err;
+}
+
+enum ntfs_stream_ioctl_op {
+	NTFS_STREAM_IOCTL_READ,
+	NTFS_STREAM_IOCTL_WRITE,
+	NTFS_STREAM_IOCTL_REMOVE,
+};
+
+/*
+ * Look up or create an ioctl target stream and return its referenced inode.
+ */
+static int ntfs_stream_ioctl_get_inode(struct inode *base_vi, __le16 *sname,
+		int sname_len, bool create, struct inode **stream_vi)
+{
+	struct ntfs_inode *base_ni = NTFS_I(base_vi);
+	struct ntfs_attr_search_ctx *ctx;
+	struct inode *attr_vi = NULL;
+	bool created = false;
+	int err;
+
+	*stream_vi = NULL;
+
+	mutex_lock(&base_ni->mrec_lock);
+	if (NVolShutdown(base_ni->vol)) {
+		err = -EIO;
+		goto out_unlock;
+	}
+	if (NInoBeingDeleted(base_ni) || !base_vi->i_nlink) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	err = ntfs_attr_lookup(AT_DATA, sname, sname_len, IGNORE_CASE,
+			0, NULL, 0, ctx);
+	if (err == -ENOENT && create) {
+		err = ntfs_attr_add(base_ni, AT_DATA, sname, sname_len,
+				NULL, 0);
+		if (!err) {
+			created = true;
+			mark_mft_record_dirty(base_ni);
+		}
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	if (err)
+		goto out_unlock;
+
+	attr_vi = ntfs_attr_iget(base_vi, AT_DATA, sname, sname_len);
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		attr_vi = NULL;
+		goto out_unlock;
+	}
+	if (NInoStreamUnlinked(NTFS_I(attr_vi)))
+		err = create ? -EBUSY : -ENOENT;
+	else
+		err = ntfs_stream_inode_validate(attr_vi);
+out_unlock:
+	mutex_unlock(&base_ni->mrec_lock);
+	if (created)
+		ntfs_stream_update_base_time(base_ni);
+	if (err) {
+		iput(attr_vi);
+		return err;
+	}
+
+	*stream_vi = attr_vi;
+	return 0;
+}
+
+/* Check file mode, base-inode flags, and the requested transfer range. */
+static int ntfs_stream_ioctl_access(struct file *filp,
+		enum ntfs_stream_ioctl_op op, loff_t pos, size_t len)
+{
+	struct inode *inode = file_inode(filp);
+	bool is_dir = S_ISDIR(inode->i_mode);
+	int err;
+
+	if (op == NTFS_STREAM_IOCTL_READ) {
+		if (!(filp->f_mode & FMODE_READ))
+			return -EBADF;
+		return rw_verify_area(READ, filp, &pos, len);
+	}
+
+	if (!(filp->f_mode & FMODE_WRITE) && !is_dir)
+		return -EBADF;
+	if (is_dir) {
+		err = inode_permission(file_mnt_idmap(filp), inode,
+				MAY_WRITE | MAY_EXEC);
+		if (err)
+			return err;
+	}
+	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+		return -EPERM;
+	if (op == NTFS_STREAM_IOCTL_REMOVE)
+		return 0;
+	return rw_verify_area(WRITE, filp, &pos, len);
+}
+
+/*
+ * Validate and execute a named-stream read, write, or remove ioctl request.
+ */
+static long ntfs_ioctl_stream(struct file *filp, unsigned long arg,
+		enum ntfs_stream_ioctl_op op)
+{
+	struct inode *base_vi = file_inode(filp);
+	struct ntfs_inode *base_ni = NTFS_I(base_vi);
+	struct ntfs_stream hdr;
+	struct ntfs_stream *req;
+	struct inode *stream_vi = NULL;
+	__le16 *uname = NULL, *sname;
+	size_t data_size, total_size;
+	loff_t pos;
+	s64 ret;
+	int sname_len, err;
+	bool claimed = false, got_write = false, utf16;
+
+	if (NVolShutdown(base_ni->vol))
+		return -EIO;
+	if (NInoAttr(base_ni) ||
+	    (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)))
+		return -EOPNOTSUPP;
+	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
+		return -EFAULT;
+
+	if (hdr.io_len > NTFS_STREAM_MAX_IO ||
+	    (hdr.flags & ~NTFS_STREAM_FL_UTF16) || hdr.reserved)
+		return -EINVAL;
+	if (!hdr.name_len)
+		return -EINVAL;
+
+	utf16 = hdr.flags & NTFS_STREAM_FL_UTF16;
+	if (utf16) {
+		if ((hdr.name_len & 1) ||
+		    hdr.name_len > NTFS_MAX_NAME_LEN * sizeof(__le16))
+			return -EINVAL;
+	} else if (hdr.name_len >
+			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE) {
+		return -EINVAL;
+	}
+
+	switch (op) {
+	case NTFS_STREAM_IOCTL_READ:
+	case NTFS_STREAM_IOCTL_WRITE:
+		if (!hdr.io_len)
+			return -EINVAL;
+		if (hdr.stream_offset > S64_MAX ||
+		    hdr.stream_offset > S64_MAX - hdr.io_len)
+			return -EOVERFLOW;
+		data_size = hdr.io_len;
+		break;
+	case NTFS_STREAM_IOCTL_REMOVE:
+		if (hdr.io_len || hdr.stream_offset)
+			return -EINVAL;
+		data_size = 0;
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	if (check_add_overflow(sizeof(hdr), (size_t)hdr.name_len,
+			&total_size) ||
+	    check_add_overflow(total_size, data_size, &total_size))
+		return -EOVERFLOW;
+
+	if (op == NTFS_STREAM_IOCTL_READ) {
+		req = kvmalloc(total_size, GFP_KERNEL);
+		if (!req)
+			return -ENOMEM;
+		if (copy_from_user(req, (void __user *)arg,
+				sizeof(hdr) + hdr.name_len)) {
+			kvfree(req);
+			return -EFAULT;
+		}
+	} else {
+		req = vmemdup_user((void __user *)arg, total_size);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+	}
+
+	req->bytes_returned = 0;
+	if (req->stream_offset != hdr.stream_offset ||
+	    req->io_len != hdr.io_len || req->name_len != hdr.name_len ||
+	    req->flags != hdr.flags || req->reserved) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	if (utf16) {
+		sname = (__le16 *)req->buffer;
+		sname_len = req->name_len / sizeof(__le16);
+	} else {
+		if (memchr(req->buffer, '\0', req->name_len)) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		sname_len = ntfs_nlstoucs(base_ni->vol, req->buffer,
+				req->name_len, &uname, NTFS_MAX_NAME_LEN);
+		if (sname_len < 0) {
+			err = sname_len;
+			goto out_free;
+		}
+		sname = uname;
+	}
+	err = ntfs_check_stream_name(sname, sname_len);
+	if (err)
+		goto out_free;
+
+	pos = hdr.stream_offset;
+	err = ntfs_stream_ioctl_access(filp, op, pos, data_size);
+	if (err)
+		goto out_free;
+
+	if (op == NTFS_STREAM_IOCTL_REMOVE) {
+		err = mnt_want_write_file(filp);
+		if (err)
+			goto out_free;
+		err = ntfs_remove_named_stream(base_ni, sname, sname_len, NULL);
+		mnt_drop_write_file(filp);
+		goto out_free;
+	}
+
+	if (op == NTFS_STREAM_IOCTL_WRITE) {
+		err = mnt_want_write_file(filp);
+		if (err)
+			goto out_free;
+		got_write = true;
+		inode_lock(base_vi);
+		err = file_remove_privs(filp);
+		inode_unlock(base_vi);
+		if (err)
+			goto out_drop_write;
+		if (!(base_ni->vol->vol_flags & VOLUME_IS_DIRTY)) {
+			err = ntfs_set_volume_flags(base_ni->vol,
+					VOLUME_IS_DIRTY);
+			if (err)
+				goto out_drop_write;
+		}
+	}
+
+	err = ntfs_stream_ioctl_get_inode(base_vi, sname, sname_len,
+			op == NTFS_STREAM_IOCTL_WRITE, &stream_vi);
+	if (err)
+		goto out_drop_write;
+
+	err = ntfs_stream_claim(stream_vi);
+	if (err)
+		goto out_drop_write;
+	claimed = true;
+
+	if (op == NTFS_STREAM_IOCTL_READ) {
+		inode_lock_shared(stream_vi);
+		if (pos < i_size_read(stream_vi))
+			ret = ntfs_inode_attr_pread(stream_vi, pos, data_size,
+					req->buffer + req->name_len);
+		else
+			ret = 0;
+		inode_unlock_shared(stream_vi);
+		if (ret < 0)
+			err = ret;
+		else
+			req->bytes_returned = ret;
+		if (!err)
+			file_accessed(filp);
+	} else {
+		inode_lock(stream_vi);
+		err = inode_newsize_ok(stream_vi, pos + data_size);
+		if (!err) {
+			ret = ntfs_inode_attr_pwrite(stream_vi, pos, data_size,
+					req->buffer + req->name_len, false);
+			if (ret < 0)
+				err = ret;
+			else
+				req->bytes_returned = ret;
+		}
+		inode_unlock(stream_vi);
+	}
+	if (claimed) {
+		int put_err;
+
+		put_err = ntfs_stream_put(stream_vi);
+		claimed = false;
+		if (!err && put_err)
+			err = put_err;
+	}
+	iput(stream_vi);
+	stream_vi = NULL;
+	if (err)
+		goto out_drop_write;
+
+	if (op == NTFS_STREAM_IOCTL_READ) {
+		if (copy_to_user((void __user *)arg, req,
+				sizeof(*req) + req->name_len +
+				req->bytes_returned))
+			err = -EFAULT;
+	} else if (copy_to_user((void __user *)arg +
+			offsetof(struct ntfs_stream, bytes_returned),
+			&req->bytes_returned, sizeof(req->bytes_returned))) {
+		err = -EFAULT;
+	}
+	goto out_drop_write;
+
+out_drop_write:
+	if (claimed)
+		ntfs_stream_put(stream_vi);
+	if (stream_vi)
+		iput(stream_vi);
+	if (got_write)
+		mnt_drop_write_file(filp);
+out_free:
+	if (uname)
+		kmem_cache_free(ntfs_name_cache, uname);
+	kvfree(req);
+	return err;
+}
+
+/*
+ * ntfs_ioctl_stream_read() - Handle a named-stream read ioctl
+ * @filp: file opened on the base file or directory
+ * @arg: userspace pointer to the request and data buffer
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+long ntfs_ioctl_stream_read(struct file *filp, unsigned long arg)
+{
+	return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_IOCTL_READ);
+}
+
+/*
+ * ntfs_ioctl_stream_write() - Handle a named-stream write ioctl
+ * @filp: file opened on the base file or directory
+ * @arg: userspace pointer to the request and data buffer
+ *
+ * Create the stream if needed.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+long ntfs_ioctl_stream_write(struct file *filp, unsigned long arg)
+{
+	return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_IOCTL_WRITE);
+}
+
+/*
+ * ntfs_ioctl_stream_remove() - Handle a named-stream remove ioctl
+ * @filp: file opened on the base file or directory
+ * @arg: userspace pointer to the request
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+long ntfs_ioctl_stream_remove(struct file *filp, unsigned long arg)
+{
+	return ntfs_ioctl_stream(filp, arg, NTFS_STREAM_IOCTL_REMOVE);
+}
+
+/*
+ * ntfs_ioctl_list_streams() - List named DATA streams
+ * @filp: file opened on the base file or directory
+ * @arg: userspace pointer to the request and output buffer
+ *
+ * On -ENOSPC, return the required buffer size in the request header.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int ntfs_ioctl_list_streams(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_list_streams hdr;
+	struct ntfs_stream_entry *entry, *last_entry = NULL;
+	size_t required = 0;
+	void *kbuf = NULL;
+	void __user *ubuf;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *actx;
+	int ret = 0, err, count = 0;
+	size_t entry_size, offset = 0;
+	const size_t name_offset = offsetof(struct ntfs_stream_entry, name);
+	int name_len;
+	unsigned char *sn = NULL;
+	bool utf16;
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+	if (NInoAttr(ni) ||
+	    (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)))
+		return -EOPNOTSUPP;
+	err = inode_permission(file_mnt_idmap(filp), inode, MAY_READ);
+	if (err)
+		return err;
+
+	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
+		return -EFAULT;
+
+	if ((hdr.flags & ~NTFS_STREAM_FL_UTF16) || hdr.reserved)
+		return -EINVAL;
+
+	utf16 = hdr.flags & NTFS_STREAM_FL_UTF16;
+
+	ubuf = (void __user *)arg + sizeof(hdr);
+
+	mutex_lock(&ni->mrec_lock);
+	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!actx) {
+		mutex_unlock(&ni->mrec_lock);
+		return -ENOMEM;
+	}
+
+	while ((err = ntfs_attrs_walk(actx)) == 0) {
+		a = actx->attr;
+		if (a->type != AT_DATA || !a->name_length)
+			continue;
+		if (a->non_resident &&
+		    a->data.non_resident.lowest_vcn)
+			continue;
+		if (ntfs_stream_unlinked(ni,
+				(__le16 *)((u8 *)a +
+				le16_to_cpu(a->name_offset)),
+				a->name_length))
+			continue;
+
+		if (utf16) {
+			name_len = a->name_length * sizeof(__le16);
+		} else {
+			name_len = ntfs_ucstonls(ni->vol,
+					(__le16 *)((u8 *)a +
+					le16_to_cpu(a->name_offset)),
+					a->name_length, &sn, 0);
+			if (name_len < 0) {
+				if (name_len == -EILSEQ ||
+				    name_len == -ENAMETOOLONG)
+					continue;
+				ret = name_len;
+				goto out;
+			}
+			kfree(sn);
+			sn = NULL;
+		}
+
+		entry_size = ALIGN(name_offset + name_len, 8);
+
+		if (required > SIZE_MAX - entry_size) {
+			ret = -EOVERFLOW;
+			goto out;
+		}
+		required += entry_size;
+		count++;
+	}
+	if (err != -ENOENT) {
+		ret = err;
+		goto out;
+	}
+
+	hdr.stream_count = count;
+	hdr.bytes_returned = required;
+
+	if (!count)
+		goto out;
+
+	if (hdr.buffer_size < required) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	kbuf = kvzalloc(required, GFP_NOFS);
+	if (!kbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ntfs_attr_reinit_search_ctx(actx);
+	while ((err = ntfs_attrs_walk(actx)) == 0) {
+		a = actx->attr;
+		if (a->type != AT_DATA || !a->name_length)
+			continue;
+		if (a->non_resident &&
+		    a->data.non_resident.lowest_vcn)
+			continue;
+		if (ntfs_stream_unlinked(ni,
+				(__le16 *)((u8 *)a +
+				le16_to_cpu(a->name_offset)),
+				a->name_length))
+			continue;
+		if (utf16) {
+			sn = NULL;
+			name_len = a->name_length * sizeof(__le16);
+		} else {
+			name_len = ntfs_ucstonls(ni->vol,
+					(__le16 *)((u8 *)a +
+					le16_to_cpu(a->name_offset)),
+					a->name_length, &sn, 0);
+			if (name_len < 0) {
+				if (name_len == -EILSEQ ||
+				    name_len == -ENAMETOOLONG)
+					continue;
+				ret = name_len;
+				goto out;
+			}
+		}
+
+		entry_size = ALIGN(name_offset + name_len, 8);
+		if (offset > required - entry_size) {
+			ret = -EOVERFLOW;
+			kfree(sn);
+			sn = NULL;
+			goto out;
+		}
+
+		entry = (struct ntfs_stream_entry *)(kbuf + offset);
+
+		if (a->non_resident) {
+			entry->size = le64_to_cpu(a->data.non_resident.data_size);
+			entry->alloc_size =
+				le64_to_cpu(a->data.non_resident.allocated_size);
+		} else {
+			entry->size = le32_to_cpu(a->data.resident.value_length);
+			entry->alloc_size = le32_to_cpu(a->length) -
+				le16_to_cpu(a->data.resident.value_offset);
+		}
+
+		entry->name_len = name_len;
+		entry->name_offset = name_offset;
+		if (utf16)
+			memcpy(entry->name,
+			       (u8 *)a + le16_to_cpu(a->name_offset), name_len);
+		else
+			memcpy(entry->name, sn, name_len);
+		kfree(sn);
+		sn = NULL;
+
+		entry->next_entry_off = entry_size;
+		last_entry = entry;
+		offset += entry_size;
+	}
+	if (err != -ENOENT) {
+		ret = err;
+	} else {
+		/* The chain terminates at the last entry. */
+		if (last_entry)
+			last_entry->next_entry_off = 0;
+		hdr.bytes_returned = offset;
+	}
+
+out:
+	kfree(sn);
+	ntfs_attr_put_search_ctx(actx);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (ret && ret != -ENOSPC)
+		goto out_free;
+
+	if (!ret && kbuf && copy_to_user(ubuf, kbuf, hdr.bytes_returned)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	if (copy_to_user((void __user *)arg, &hdr, sizeof(hdr)))
+		ret = -EFAULT;
+
+out_free:
+	kvfree(kbuf);
+	return ret;
+}
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 75e201096525..3cf58befd77f 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -805,8 +805,29 @@ static int ntfs_test_inode_attr(struct inode *vi, void *data)
 		return 0;
 	if (NInoAttr(ni) || ni->nr_extents == -1)
 		return 1;
-	else
-		return 0;
+	return 0;
+}
+
+static void ntfs_cleanup_deleted_inode(struct ntfs_inode *ni)
+{
+	struct inode *attr_vi;
+	struct super_block *sb = VFS_I(ni)->i_sb;
+
+	if (!NInoBeingDeleted(ni))
+		return;
+
+	while ((attr_vi = ilookup5(sb, ni->mft_no, ntfs_test_inode_attr,
+			(void *)(uintptr_t)ni->mft_no))) {
+		struct ntfs_inode *attr_ni = NTFS_I(attr_vi);
+
+		if (ntfs_inode_is_named_stream(attr_ni)) {
+			if (atomic_read(&attr_ni->stream_open_count) > 0)
+				NInoSetStreamUnlinked(attr_ni);
+			remove_inode_hash(attr_vi);
+		}
+		clear_nlink(attr_vi);
+		iput(attr_vi);
+	}
 }
 
 /*
@@ -976,22 +997,10 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	if (need_lock == true) {
 		mutex_unlock(&dir_ni->mrec_lock);
 		mutex_unlock(&ni->mrec_lock);
+		if (link_count_zero)
+			ntfs_cleanup_deleted_inode(ni);
 	}
 
-	/*
-	 * If hard link count is not equal to zero then we are done. In other
-	 * case there are no reference to this inode left, so we should free all
-	 * non-resident attributes and mark all MFT record as not in use.
-	 */
-	if (link_count_zero == true) {
-		struct inode *attr_vi;
-
-		while ((attr_vi = ilookup5(sb, ni->mft_no, ntfs_test_inode_attr,
-					   (void *)(uintptr_t)ni->mft_no)) != NULL) {
-			clear_nlink(attr_vi);
-			iput(attr_vi);
-		}
-	}
 	ntfs_debug("Done.\n");
 	return 0;
 err_out:
@@ -1385,6 +1394,8 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_ni)
 		mutex_unlock(&new_ni->mrec_lock);
 	mutex_unlock(&old_ni->mrec_lock);
+	if (new_ni)
+		ntfs_cleanup_deleted_inode(new_ni);
 	if (uname_new)
 		kmem_cache_free(ntfs_name_cache, uname_new);
 	if (uname_old)
diff --git a/fs/ntfs/stream.h b/fs/ntfs/stream.h
new file mode 100644
index 000000000000..da0096d2b751
--- /dev/null
+++ b/fs/ntfs/stream.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NTFS_STREAM_H
+#define _NTFS_STREAM_H
+
+#include <linux/fs.h>
+
+struct ntfs_inode;
+struct ntfs_volume;
+
+int ntfs_check_stream_name(const __le16 *name, unsigned int name_len);
+
+void ntfs_stream_inode_refresh(struct inode *inode);
+int ntfs_stream_inode_validate(struct inode *inode);
+void ntfs_stream_update_base_time(struct ntfs_inode *base_ni);
+bool ntfs_stream_unlinked(struct ntfs_inode *base_ni,
+		const __le16 *name, u32 name_len);
+int ntfs_stream_put(struct inode *inode);
+int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *name,
+		u32 name_len, struct inode *expected_inode);
+
+long ntfs_ioctl_stream_read(struct file *file, unsigned long arg);
+long ntfs_ioctl_stream_write(struct file *file, unsigned long arg);
+long ntfs_ioctl_stream_remove(struct file *file, unsigned long arg);
+int ntfs_ioctl_list_streams(struct file *file, unsigned long arg);
+
+int ntfs_file_open(struct inode *inode, struct file *file);
+int ntfs_file_release(struct inode *inode, struct file *file);
+int ntfs_file_fsync(struct file *file, loff_t start, loff_t end,
+		int datasync);
+int ntfs_setattr_size(struct inode *inode, struct iattr *attr);
+loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence);
+ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+int ntfs_file_mmap_prepare(struct vm_area_desc *desc);
+ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags);
+int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 len);
+long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len);
+
+int ntfs_test_inode_rcu(struct inode *inode, void *data);
+
+#endif /* _NTFS_STREAM_H */
diff --git a/include/uapi/linux/ntfs.h b/include/uapi/linux/ntfs.h
new file mode 100644
index 000000000000..62dadce58087
--- /dev/null
+++ b/include/uapi/linux/ntfs.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2026 LG Electronics Co., Ltd.
+ */
+
+#ifndef _UAPI_LINUX_NTFS_H
+#define _UAPI_LINUX_NTFS_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define NTFS_IOC_MAGIC	0xEF
+
+/*
+ * Flags for ntfs_stream.flags and ntfs_list_streams.flags.
+ *
+ * NTFS_STREAM_FL_UTF16 makes stream names raw UTF-16LE, exactly as stored on
+ * disk, instead of encoding them with the mounted filesystem NLS. This
+ * allows lossless round-tripping of stream names whose characters are not
+ * representable by the mount NLS (e.g. for Wine, which works in UTF-16
+ * natively). When set, the name length fields count bytes of UTF-16LE and
+ * must therefore be even.
+ */
+#define NTFS_STREAM_FL_UTF16		0x1
+
+/*
+ * ntfs named stream read, write, and remove ioctl structure.
+ *
+ * @stream_offset:	Offset within the named stream for read/write.
+ * @io_len:		Number of bytes to read/write. Must be zero for remove.
+ * @bytes_returned:	Actual bytes transferred (out).
+ * @name_len:		Stream name length in bytes, not including any
+ *			terminating NUL. When NTFS_STREAM_FL_UTF16 is set,
+ *			this counts UTF-16LE bytes and must be even.
+ * @flags:		Bit mask of NTFS_STREAM_FL_* flags. Other bits must
+ *			be zero.
+ * @reserved:		Must be zero.
+ * @buffer:		Bare stream name followed by stream data for read/write.
+ *
+ * The stream name is encoded with the mounted filesystem NLS, or as raw
+ * UTF-16LE when NTFS_STREAM_FL_UTF16 is set. A write creates the stream if
+ * it does not already exist. A write failure after creation may leave the
+ * new stream behind; it can be removed separately.
+ */
+struct ntfs_stream {
+	__aligned_u64 stream_offset;
+	__aligned_u64 io_len;
+	__aligned_u64 bytes_returned;
+	__u32 name_len;
+	__u32 flags;
+	__aligned_u64 reserved;
+	__u8 buffer[];
+};
+
+/*
+ * Single stream entry returned by NTFS_IOC_LIST_STREAMS.
+ *
+ * @next_entry_off:	Byte offset from the start of this entry to the next
+ *			entry, or zero for the last entry. Always a multiple
+ *			of 8. Consumers must use this to advance instead of
+ *			computing the stride themselves.
+ * @size:		Stream data size in bytes.
+ * @alloc_size:		Bytes allocated for the stream (cluster aligned for
+ *			non-resident streams).
+ * @name_len:		Stream name length in bytes, not including a NUL
+ *			terminator (none is stored). Counts UTF-16LE bytes
+ *			when NTFS_STREAM_FL_UTF16 was requested.
+ * @name_offset:	Byte offset from the start of this entry to @name.
+ * @reserved:		Must be zero.
+ * @name:		Bare stream name; NLS encoded, or raw UTF-16LE when
+ *			NTFS_STREAM_FL_UTF16 was requested.
+ *
+ * New fixed fields may be added after @reserved and before @name. Consumers
+ * must use @name_offset to locate the name and @next_entry_off to advance to
+ * the next entry.
+ */
+struct ntfs_stream_entry {
+	__aligned_u64 next_entry_off;
+	__aligned_u64 size;
+	__aligned_u64 alloc_size;
+	__u32 name_len;
+	__u32 name_offset;
+	__u32 reserved;
+	__u8 name[];
+};
+
+/*
+ * ntfs list streams ioctl structure.
+ *
+ * @buffer_size:	user buffer size(in).
+ * @bytes_returned:	actual bytes written or required(out).
+ * @stream_count:	number of streams(out).
+ * @flags:		Bit mask of NTFS_STREAM_FL_* flags controlling the
+ *			encoding of the returned names; other bits must be zero.
+ * @reserved:		Must be zero.
+ * @buffer:		ntfs_stream_entry array.
+ *
+ * The variable-length entries follow the header in @buffer, each aligned on
+ * an 8-byte boundary and chained via ntfs_stream_entry.next_entry_off. If
+ * @buffer_size is too small, no data is copied, @stream_count and
+ * @bytes_returned report the required values and the ioctl fails with
+ * -ENOSPC. In NLS mode, names that cannot be represented by the mounted
+ * character set are omitted; use NTFS_STREAM_FL_UTF16 to list all
+ * names without conversion loss.
+ */
+struct ntfs_list_streams {
+	__aligned_u64 buffer_size;
+	__aligned_u64 bytes_returned;
+	__aligned_u64 stream_count;
+	__u32 flags;
+	__u32 reserved;
+	__u8 buffer[];
+};
+
+#define NTFS_IOC_STREAM_READ \
+	_IOWR(NTFS_IOC_MAGIC, 1, struct ntfs_stream)
+#define NTFS_IOC_STREAM_WRITE \
+	_IOWR(NTFS_IOC_MAGIC, 2, struct ntfs_stream)
+#define NTFS_IOC_STREAM_REMOVE \
+	_IOWR(NTFS_IOC_MAGIC, 3, struct ntfs_stream)
+#define NTFS_IOC_LIST_STREAMS \
+	_IOWR(NTFS_IOC_MAGIC, 4, struct ntfs_list_streams)
+
+#endif /* _UAPI_LINUX_NTFS_H */
-- 
2.25.1

