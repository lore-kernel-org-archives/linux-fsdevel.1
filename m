Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBA34DB6C;
	Wed, 29 Apr 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473061; cv=none; b=nP2e6O4pvZdToobSbncTg0xsFfVnQdTS4L0grdBmnSpjLFWkG7zWQXd4JgEKz8+oCSVQK9pSaer97tjF7h8hJUEFlsfDQYtMaSy9m7rk9Ocr3VaENK8pEJbMqHdNIAIwfp/awBKXSSjZNNxS0iYz2oQ4mX0xbg6EHz4wvtWJiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473061; c=relaxed/simple;
	bh=AVoM69x70LQiSt2md9hlYr/Pk3vjgCOHI619Qsknau4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK63m5mIL3u2QCL8HxQ29os95Tr7xYqwdRYA7/+wylWMmrM7L2n/90E+5gVw6jsax1RmGEEvOcXAZcQv7hmYzIdeuIg6h0d0qiWTI/0TbiYJapj1IkpBAtQDdm0fyPUe4apBGji97kTMmz4uqUe6QLxeYC07lF3m/4arZ+wDyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9YxNzlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9YxNzlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0D0C19425;
	Wed, 29 Apr 2026 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473060;
	bh=AVoM69x70LQiSt2md9hlYr/Pk3vjgCOHI619Qsknau4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C9YxNzlMKL7Fl13i20s0Es4pnEFQD3T5ptuQvud5vGTEGIGmux0TpDJJxn2yym/Om
	 svoMxnM7F1uNu6sv/XDK2TTTsEZ2jdFN3dAlaa7j6/lpqBsZlepokzm5PliT+fnH6p
	 UbFYLGsiQRF+QmVkQFcU74Xft8ti9e42/Of9jL4bA6SoLBjui7kD5HhNLdSm387jun
	 0wQBzHbMsvlWQQxLkbUXIU4+58AKD7DPWE3A5K2x2XNo7WFS9Vi6rsGokFA5jl9MnG
	 zfprLiYKxmjnZwYsjye14VwrdkR0ZkhkKYwVGofPTbC9Zi4/ebOfb1oiOfL4Byo7X0
	 VHVoVwSTo1TBw==
Date: Wed, 29 Apr 2026 07:31:00 -0700
Subject: [PATCH 28/33] fuse: allow more statx fields
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205749.4101881.2014517510829307350.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow the fuse server to supply us with the more recently added fields
of struct statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/uapi/linux/fuse.h |   15 ++++++++-
 fs/fuse/dir.c             |   76 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 12 deletions(-)


diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1ef7152306a24f..aa96b4cbdfa255 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -341,7 +341,20 @@ struct fuse_statx {
 	uint32_t	rdev_minor;
 	uint32_t	dev_major;
 	uint32_t	dev_minor;
-	uint64_t	__spare2[14];
+
+	uint64_t	mnt_id;
+	uint32_t	dio_mem_align;
+	uint32_t	dio_offset_align;
+	uint64_t	subvol;
+
+	uint32_t	atomic_write_unit_min;
+	uint32_t	atomic_write_unit_max;
+	uint32_t	atomic_write_segments_max;
+	uint32_t	dio_read_offset_align;
+	uint32_t	atomic_write_unit_max_opt;
+	uint32_t	__spare2[1];
+
+	uint64_t	__spare3[8];
 };
 
 struct fuse_kstatfs {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5b10ddf9b8077a..2db88bc364bb50 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1470,6 +1470,50 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
+#define FUSE_SUPPORTED_STATX_MASK	(STATX_BASIC_STATS | \
+					 STATX_BTIME | \
+					 STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+#define FUSE_UNCACHED_STATX_MASK	(STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+static void kstat_from_fuse_statx(const struct inode *inode,
+				  struct kstat *stat,
+				  const struct fuse_statx *sx)
+{
+	stat->result_mask = sx->mask & FUSE_SUPPORTED_STATX_MASK;
+
+	stat->attributes |= fuse_statx_attributes(inode, sx);
+	stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
+
+	if (sx->mask & STATX_BTIME) {
+		stat->btime.tv_sec = sx->btime.tv_sec;
+		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec,
+					    NSEC_PER_SEC - 1);
+	}
+
+	if (sx->mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = sx->dio_mem_align;
+		stat->dio_offset_align = sx->dio_offset_align;
+	}
+
+	if (sx->mask & STATX_SUBVOL)
+		stat->subvol = sx->subvol;
+
+	if (sx->mask & STATX_WRITE_ATOMIC) {
+		stat->atomic_write_unit_min = sx->atomic_write_unit_min;
+		stat->atomic_write_unit_max = sx->atomic_write_unit_max;
+		stat->atomic_write_unit_max_opt = sx->atomic_write_unit_max_opt;
+		stat->atomic_write_segments_max = sx->atomic_write_segments_max;
+	}
+
+	if (sx->mask & STATX_DIO_READ_ALIGN)
+		stat->dio_read_offset_align = sx->dio_read_offset_align;
+}
+
 static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 			 struct file *file, struct kstat *stat)
 {
@@ -1493,7 +1537,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 	/* For now leave sync hints as the default, request all stats. */
 	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	inarg.sx_mask = FUSE_SUPPORTED_STATX_MASK;
 	args.opcode = FUSE_STATX;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1521,11 +1565,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	if (stat) {
-		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-		stat->btime.tv_sec = sx->btime.tv_sec;
-		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		stat->attributes |= fuse_statx_attributes(inode, sx);
-		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
+		kstat_from_fuse_statx(inode, stat, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1590,16 +1630,30 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-
-	/* FUSE only supports basic stats and possibly btime */
-	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
+	/* Only ask for supported stats */
+	request_mask &= FUSE_SUPPORTED_STATX_MASK;
 retry:
 	if (fc->no_statx)
 		request_mask &= STATX_BASIC_STATS;
 
 	if (!request_mask)
 		sync = false;
-	else if (flags & AT_STATX_FORCE_SYNC)
+	else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
+		switch (flags & AT_STATX_SYNC_TYPE) {
+		case AT_STATX_DONT_SYNC:
+			request_mask &= ~FUSE_UNCACHED_STATX_MASK;
+			sync = false;
+			break;
+		case AT_STATX_FORCE_SYNC:
+		case AT_STATX_SYNC_AS_STAT:
+			sync = true;
+			break;
+		default:
+			WARN_ON(1);
+			sync = false;
+			break;
+		}
+	} else if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
 		sync = false;
@@ -1610,7 +1664,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		/* Try statx if BTIME is requested */
+		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {

