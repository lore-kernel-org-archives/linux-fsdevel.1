Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AA368269;
	Wed, 29 Apr 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473420; cv=none; b=PAXgRzP0wPzNKC4o6MzfKLHPujsP8H092K/VIfArxZOceNap4TwvdmmKGL+AwX4T5nhqsfcqkd8y9JiaUfQ/5Nk3wjj4QZaBVNpNuFHSP38UVyT66UIPnCd3AzHJgNuhXl0RDhGDay3hyQkgSnkyLGh23qmlde5jtVVFJE/rhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473420; c=relaxed/simple;
	bh=bYw+0z3LzitJmvSIORYGJVQQssXU8tpbU9GX0puwmoI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geUzIjhQ6BOcDcb/BuBVvyiEnykmQXCzkZ6uTS2ze32BNPrQp9z36/Hy79cqrZ81GclYfKaNkygyLCRHIOqhOP8s6eC03w8md72egq/pGy7/HdUVyPRgbSytgMFWRZb4eGOEpdCT9Ll7kyPgruvvrco2cNNm2cbR6/DYOw8lF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKkjcJbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKkjcJbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF1FC19425;
	Wed, 29 Apr 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473420;
	bh=bYw+0z3LzitJmvSIORYGJVQQssXU8tpbU9GX0puwmoI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EKkjcJbUlVLkWWf3sv7j/oe3bsrRKJ0qssZIUPB46EZ2H6mgHFrjsQGm6egBT6tOV
	 7ELmYmyb8640+zFWi/9c0igf0xrPkmrs3kRgsjbcP6p9YnZAGAB8wwjLGkkX/3q7C7
	 wx/nUZJG6G9+RBJcf5nvX2NDp1KPg1Wqn0Iaw6qFiL0VKxKa20DYAJEGSh7mhnxIwu
	 Zr5aVojUJsLN+ZVS4ADSufrAunCtqhgmPy4R5DJ/Yo1e88rvfJ3zvW0MX/Y8eYcYDO
	 Os9+mKwq+XtxtEryAqjmVpfwVv4DF083NdOaoYSApMVlRV6aaGPNwI4NV7XQPD1Lt+
	 JdPlLrV/6IrMw==
Date: Wed, 29 Apr 2026 07:36:59 -0700
Subject: [PATCH 06/12] fuse_trace: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207127.4103699.17357823812019720836.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h       |   20 ++++++++++++++++++++
 fs/fuse/fuse_iomap.c       |    2 ++
 fs/fuse/fuse_iomap_cache.c |    2 ++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bf47008e50920a..ddcbefd33a4024 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -932,6 +932,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_end_ioend,
 	TP_PROTO(const struct iomap_ioend *ioend),
@@ -1248,6 +1249,25 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	written;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
 DECLARE_EVENT_CLASS(fuse_iext_class,
 	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
 		 int state, unsigned long caller_ip),
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 6223b98890a83b..6d6c42fdaaac5b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2635,5 +2635,7 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 3d80c3eafad2cc..7d6944a6106f07 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1454,6 +1454,8 @@ int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
 	if (!fuse_inode_caches_iomaps(inode))
 		return 0;
 
+	trace_fuse_iomap_cache_invalidate_range(inode, offset, length);
+
 	aligned_offset = round_down(offset, blocksize);
 	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
 		length += offset - aligned_offset;

