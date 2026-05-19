Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85792BCF46;
	Tue, 19 May 2026 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229827; cv=none; b=Q9vNTV+Q6pRz3FzXIdw+zAk3VQOjEO5lIfNnkvSQX3CLoMbZ0LttC1GMrdtdXqj+Udq4sVFaVo05fK5/TrUICjBTonubQcMmrefI0uzo0IUKcSe6oCOPwmL+qccQbS+cg0HYLEW2YreQCGCRANnGWjVhwKrvJQZynTmyrIe6qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229827; c=relaxed/simple;
	bh=6prmj8zyvM6PRVe9Ejn5mu8Yqi+Ws76Ery5YprQhJIM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swrSeOAAArBbgmbtX8TTYhu0BkGQzJ0ZjYYobE+DHW/A7jzxMu1083O1G/Gx58giR6QVNW8vVLrgAW1VWKUYQepue0auR8yRmK18qnd9pgbVhjx5drgSRhRCALY2f5ErdwDL9EOMZgPc7+I6bALp6j9S/vxVpURbz60OCCLIrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU2k9rTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU2k9rTS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3CAAC1F00893;
	Tue, 19 May 2026 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229825;
	bh=adxvVjSDlepmB7IhlCZ7//mVHZcxXPUU57TDqQ+qOQ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=lU2k9rTSCvbz03ZSjO9dl/0IRvsRjDztzj3VtAZ+offT5pnPyGt3kCnMZGpBk8rvb
	 RILZczVNG7Ocuh3Me1fRaDW30I1mlSp/ZPl0yfDI+R3R2PLyAYmNkbPKNOh0ep16K3
	 P3iKAZoo9VIrpd7qeIXA6ae+AZ8ufsbrdWqp89z+X0lyFPhIin8KKT67Uv1GPeN7r/
	 zjkHD3PB91m+EN/eoKV+05q5QnoToBaGoppZK7KbZy1oBtxCspnXRisWEVVbJBZrQi
	 oN69nPFldTctjLUrxtXOhF/pAOmPDNIWbfw6w6xJ0KPplihtyvLN/YIukBJXPdR6hF
	 3KY0Y1UPPtu9A==
Date: Tue, 19 May 2026 15:30:24 -0700
Subject: [PATCH 4/6] fuse_trace: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945828.2437300.16142820574875268648.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
References: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |  263 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |   43 ++++++++
 2 files changed, 302 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 46a6b7527c3bb3..f1dab22d41636f 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -225,6 +225,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
+struct iomap_writepage_ctx;
+struct iomap_ioend;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -293,7 +295,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_OP_UNSHARE,		"unshare" }, \
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
-	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }
+	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
@@ -308,7 +311,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
 	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
-	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }, \
+	{ FUSE_IOMAP_IOEND_WRITEBACK,		"writeback" }
 
 #define IOMAP_DIOEND_STRINGS \
 	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
@@ -333,6 +337,12 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
 	{ 1 << FUSE_I_IOMAP,			"iomap" }
 
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -658,6 +668,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -694,6 +707,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -766,7 +781,251 @@ DEFINE_EVENT(fuse_iomap_file_range_class, name,         \
         TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
         TP_ARGS(inode, offset, length))
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize_finish);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
 
+TRACE_EVENT(fuse_iomap_end_ioend,
+	TP_PROTO(const struct iomap_ioend *ioend, int error),
+
+	TP_ARGS(ioend, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		ioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(ioend->io_inode, fi, fm);
+		__entry->offset		=	ioend->io_offset;
+		__entry->length		=	ioend->io_size;
+		__entry->ioendflags	=	ioend->io_flags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", IOMAP_IOEND_STRINGS),
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_range,
+	TP_PROTO(const struct inode *inode, u64 offset, unsigned int count,
+		 u64 end_pos),
+
+	TP_ARGS(inode, offset, count, end_pos),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(uint64_t,		end_pos)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+		__entry->end_pos	=	end_pos;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " end_pos 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->end_pos)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_range_end,
+	TP_PROTO(const struct inode *inode, u64 offset, unsigned int count,
+		 u64 end_pos, ssize_t ret),
+
+	TP_ARGS(inode, offset, count, end_pos, ret),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(uint64_t,		end_pos)
+		__field(size_t,			bytes)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+		__entry->end_pos	=	end_pos;
+		if (ret >= 0) {
+			__entry->bytes	=	ret;
+			__entry->error	=	0;
+		} else {
+			__entry->bytes	=	0;
+			__entry->error	=	ret;
+		}
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " end_pos 0x%llx bytes 0x%zx error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->end_pos,
+		  __entry->bytes,
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_submit,
+	TP_PROTO(const struct iomap_writepage_ctx *wpc, int error),
+
+	TP_ARGS(wpc, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		nr_folios)
+		__field(uint64_t,		addr)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(wpc->inode, fi, fm);
+		__entry->nr_folios	=	wpc->nr_folios;
+		__entry->offset		=	wpc->iomap.offset;
+		__entry->length		=	wpc->iomap.length;
+		__entry->addr		=	wpc->iomap.addr;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " addr 0x%llx nr_folios %u error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->addr,
+		  __entry->nr_folios,
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_discard_folio,
+	TP_PROTO(const struct inode *inode, loff_t offset, size_t count),
+
+	TP_ARGS(inode, offset, count),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_writepages,
+	TP_PROTO(const struct inode *inode, const struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(long,			nr_to_write)
+		__field(bool,			sync_all)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	wbc->range_start;
+		if (wbc->range_end == LLONG_MAX)
+			__entry->length	=	i_size_read(inode) - wbc->range_start;
+		else
+			__entry->length	=	wbc->range_end - wbc->range_start + 1;
+		__entry->nr_to_write	=	wbc->nr_to_write;
+		__entry->sync_all	=	wbc->sync_mode == WB_SYNC_ALL;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " nr_folios %ld sync_all? %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->nr_to_write,
+		  __entry->sync_all)
+);
+
+TRACE_EVENT(fuse_iomap_read_folio,
+	TP_PROTO(const struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(folio->mapping->host, fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_readahead,
+	TP_PROTO(const struct readahead_control *rac),
+
+	TP_ARGS(rac),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct readahead_control *mutrac = (struct readahead_control *)rac;
+		FUSE_INODE_ASSIGN(file_inode(rac->file), fi, fm);
+		__entry->offset		=	readahead_pos(mutrac);
+		__entry->length		=	readahead_length(mutrac);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_page_mkwrite,
+	TP_PROTO(const struct vm_fault *vmf),
+
+	TP_ARGS(vmf),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct folio *folio = page_folio(vmf->page);
+		FUSE_INODE_ASSIGN(file_inode(vmf->vma->vm_file), fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_fallocate,
+	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
+		 loff_t length, loff_t newsize),
+	TP_ARGS(inode, mode, offset, length, newsize),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(loff_t,			newsize)
+		__field(int,			mode)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->mode		=	mode;
+		__entry->newsize	=	newsize;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " mode 0x%x newsize 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->mode,
+		  __entry->newsize)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 30f173847edba9..503d399d40d708 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1060,6 +1060,8 @@ fuse_iomap_write_zero_eof(
 		return 1;
 	}
 
+	trace_fuse_iomap_write_zero_eof(iocb, from);
+
 	filemap_invalidate_lock(mapping);
 	error = fuse_iomap_zero_range(inode, isize, iocb->ki_pos - isize, NULL);
 	filemap_invalidate_unlock(mapping);
@@ -1191,6 +1193,8 @@ static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
 	if (!error && fuse_is_bad(inode))
 		error = -EIO;
 
+	trace_fuse_iomap_end_ioend(ioend, error);
+
 	if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
@@ -1296,6 +1300,8 @@ static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos, int error)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_discard_folio(inode, pos, end - pos);
+
 	printk_ratelimited(KERN_ERR
 		"page discard on page %px, inode 0x%llx, pos %llu.",
 			folio, fi->orig_ino, pos);
@@ -1318,6 +1324,8 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(wpc->inode));
 
+	trace_fuse_iomap_writeback_range(wpc->inode, offset, len, end_pos);
+
 	if (!iomap_writeback_map_valid(wpc, offset))
 		ret = iomap_writeback_map(wpc, folio, offset, len, end_pos,
 					  &fuse_iomap_ops);
@@ -1327,6 +1335,9 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 discard_folio:
 	if (ret < 0)
 		fuse_iomap_discard_folio(folio, offset, ret);
+
+	trace_fuse_iomap_writeback_range_end(wpc->inode, offset, len, end_pos,
+					     ret);
 	return ret;
 }
 
@@ -1337,6 +1348,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(ioend->io_inode));
 
+	trace_fuse_iomap_writeback_submit(wpc, error);
+
 	/* always call our ioend function, even if we cancel the bio */
 	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
 	return iomap_ioend_writeback_submit(wpc, error);
@@ -1360,6 +1373,8 @@ static int fuse_iomap_writepages(struct address_space *mapping,
 
 	ASSERT(fuse_inode_has_iomap(mapping->host));
 
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
 	return iomap_writepages(&wpc.ctx);
 }
 
@@ -1367,6 +1382,8 @@ static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(file)));
 
+	trace_fuse_iomap_read_folio(folio);
+
 	iomap_bio_read_folio(folio, &fuse_iomap_ops);
 	return 0;
 }
@@ -1375,6 +1392,8 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
 
+	trace_fuse_iomap_readahead(rac);
+
 	iomap_bio_readahead(rac, &fuse_iomap_ops);
 }
 
@@ -1425,6 +1444,8 @@ static vm_fault_t fuse_iomap_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_page_mkwrite(vmf);
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
@@ -1458,6 +1479,8 @@ static ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		goto out; /* skip atime */
 
@@ -1471,6 +1494,7 @@ static ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 	inode_unlock_shared(inode);
 
 out:
+	trace_fuse_iomap_buffered_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -1484,6 +1508,8 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_write(iocb, from);
+
 	if (!iov_iter_count(from))
 		goto out;
 
@@ -1513,6 +1539,7 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 		ret = generic_write_sync(iocb, ret);
 	}
 out:
+	trace_fuse_iomap_buffered_write_end(iocb, from, ret);
 	return ret;
 }
 
@@ -1635,11 +1662,17 @@ fuse_iomap_setsize_start(
 	 * extension, or zeroing out the rest of the block on a downward
 	 * truncate.
 	 */
-	if (newsize > oldsize)
+	if (newsize > oldsize) {
+		trace_fuse_iomap_truncate_up(inode, oldsize, newsize - oldsize);
+
 		error = fuse_iomap_zero_range(inode, oldsize, newsize - oldsize,
 					      &did_zeroing);
-	else
+	} else {
+		trace_fuse_iomap_truncate_down(inode, newsize,
+					       oldsize - newsize);
+
 		error = fuse_iomap_truncate_page(inode, newsize, &did_zeroing);
+	}
 	if (error)
 		return error;
 
@@ -1688,6 +1721,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 	start = round_down(pos, rounding);
 	end = round_up(endpos + 1, rounding) - 1;
 
+	trace_fuse_iomap_flush_unmap_range(inode, start, end + 1 - start);
+
 	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (error)
 		return error;
@@ -1701,6 +1736,8 @@ static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
 	loff_t isize = i_size_read(inode);
 	int error;
 
+	trace_fuse_iomap_punch_range(inode, offset, length);
+
 	/*
 	 * Now that we've unmap all full blocks we'll have to zero out any
 	 * partial block at the beginning and/or end.  iomap_zero_range is
@@ -1744,6 +1781,8 @@ fuse_iomap_fallocate(
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make

