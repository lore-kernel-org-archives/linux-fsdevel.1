Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D63A4F4A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644136; cv=none; b=fXTAH3K2olSWwZT4oCwv4d/6yjxdDPAzbOr6sUK6VJfqOmuX31Tb0no5hIxvIv43JWLVoqb9EN6kiyUOfKo1rlM9liTghXsg6sn8+FGCVAxw1wnqhcf73CRMoU4azMzjIFVoFgzOKEDtX/Y6tCUmZC5hRAjCWe6JrIj90ejyFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644136; c=relaxed/simple;
	bh=aUuXPQMPrHJO14lmhkaPsYgRAxEj8/cH5LHGl0CCOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbTj9XK5Uc/f4rgB1uhVxbZS1i9bQxFjHAkxBFR/Gk3NX3+fDQYZZDQhqSf3xWYobI/r6VmHN7+PgIvF9ABYPYgkOTqMV2yOdqphraM3xX2diI4+rjM7bZ+TRNTxJil5ORlk8syNvrSpaTbe7NJumPnI3DDFAWvajec+ceJyZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E39C68D1F; Tue, 21 Jul 2026 16:28:42 +0200 (CEST)
Date: Tue, 21 Jul 2026 16:28:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, changfengnan@bytedance.com,
	kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
Message-ID: <20260721142842.GA11935@lst.de>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The submission seems to be missing most of the relevant mailing lists,
e.g., xfs for iomap itself and the file system-specific lists.

For now I didn't have too much time to look at it, and the little I had
I used to jump on the simple direct I/O thing, as that's the only part
that stood out as something I didn't like.  The new "don't advance the
iter" magic flag just didn't feel right.

What I came up with is the patch below which sits ontop of your entire
series.  I redoes the simple read path very heavily and now requires the
file system to opt in, and provide the begin callback only, i.e. we
require the file system to only call it if it can, which simplifies the
logic a lot, but requires more care from the file systems, and exposing
the old iomap_begin callback.

Fengnan, can you check if this keeps your performance?  It does more
inlining and avoid the direct call, but hopefully doesn't inline too
much like the previous attempt.  If this works, it probably needs
to move before the conversion.

---
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index adda6342de5b..67b226edb287 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -809,8 +809,8 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, iter, exfat_iomap_next, NULL,
-				IOMAP_DIO_NO_IOMAP_END, NULL, 0);
+		ret = iomap_dio_rw(iocb, iter, exfat_iomap_next, NULL, 0, NULL,
+				0);
 	} else {
 		ret = generic_file_read_iter(iocb, iter);
 	}
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 755fde1baf03..66d281d00d3e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -4004,6 +4004,8 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 		io_end->flag &= ~EXT4_IO_END_UNWRITTEN;
 }
 
+inline int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap);
 int ext4_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
 		struct iomap *srcmap);
 int ext4_iomap_next_report(const struct iomap_iter *iter, struct iomap *iomap,
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index bf0c18cf1017..491854e93f92 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -91,8 +91,10 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, ext4_iomap_next, NULL,
-			   IOMAP_DIO_NO_IOMAP_END, NULL, 0);
+
+	ret = iomap_dio_read_simple(iocb, to, ext4_iomap_begin);
+	if (ret == -ENOTBLK)
+		ret = iomap_dio_rw(iocb, to, ext4_iomap_next, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f455708a8c31..973ee7a97f61 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3771,7 +3771,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 }
 
 
-static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+inline int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9c50adc93cfa..33c2c6d3e134 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -894,6 +894,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(__iomap_dio_rw);
 
+ssize_t
+iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, iomap_iter_next_fn next,
+		const struct iomap_dio_ops *dops, unsigned int dio_flags,
+		void *private, size_t done_before)
+{
+	struct iomap_dio *dio;
+
+	dio = __iomap_dio_rw(iocb, iter, next, dops, dio_flags, private,
+			     done_before);
+	if (IS_ERR_OR_NULL(dio))
+		return PTR_ERR_OR_ZERO(dio);
+	return iomap_dio_complete(dio);
+}
+EXPORT_SYMBOL_GPL(iomap_dio_rw);
+
 struct iomap_dio_simple {
 	struct kiocb		*iocb;
 	size_t			size;
@@ -968,159 +983,47 @@ static void iomap_dio_simple_end_io(struct bio *bio)
 	iocb->ki_complete(iocb, iomap_dio_simple_complete(sr));
 }
 
-static inline bool
-iomap_dio_simple_supported(struct kiocb *iocb, struct iov_iter *iter,
-			   const struct iomap_dio_ops *dops,
-			   unsigned int dio_flags, size_t done_before)
+ssize_t __iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
+		iomap_iter_begin_fn begin, struct iomap_iter *iomi)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
-
-	if (dops || done_before)
-		return false;
-	if (iov_iter_rw(iter) != READ)
-		return false;
-	if (!count)
-		return false;
-	/*
-	 * Simple dio is an optimization for small IO. Filter out large IO
-	 * early as it's the most common case to fail for typical direct IO
-	 * workloads.
-	 */
-	if (count > inode->i_sb->s_blocksize)
-		return false;
-	if (dio_flags & (IOMAP_DIO_FORCE_WAIT | IOMAP_DIO_PARTIAL |
-			 IOMAP_DIO_BOUNCE))
-		return false;
-	if (iocb->ki_pos + count > i_size_read(inode))
-		return false;
-	if (IS_ENCRYPTED(inode))
-		return false;
-
-	return true;
-}
-
-static inline void
-iomap_dio_simple_finish(struct iomap_iter *iomi, iomap_iter_next_fn next,
-		size_t written)
-{
-	iomi->iter_start_pos = iomi->pos;
-	iomi->pos += written;
-	iomi->len -= written;
-	next(iomi, &iomi->iomap, &iomi->srcmap);
-}
-
-/*
- * Fast path for small, block-aligned direct I/Os that map to a single
- * contiguous on-disk extent.
- *
- * iomap_dio_simple_supported() enforces the cheap up-front constraints before
- * entering this path.
- *
- * @dops must be NULL: a non-NULL @dops means the caller wants its
- * ->end_io / ->submit_io hooks invoked, and in particular wants its bios to be
- * allocated from the filesystem-private @dops->bio_set (whose front_pad sizes a
- * filesystem-private wrapper around the bio).  The fast path instead allocates
- * from the shared iomap_dio_simple_pool, whose front_pad matches struct
- * iomap_dio_simple; the two wrappers are not interchangeable, so we must fall
- * back to __iomap_dio_rw() in that case.
- *
- * @done_before must be zero: a non-zero caller-accumulated residual cannot be
- * carried through a single-bio inline completion.
- *
- * @iter must describe a non-empty READ no larger than the inode block size:
- * writes, zero-length I/O, and larger requests need the generic iomap direct
- * I/O path.
- *
- * @dio_flags must not request IOMAP_DIO_FORCE_WAIT, IOMAP_DIO_PARTIAL, or
- * IOMAP_DIO_BOUNCE: this path does not support forced waiting, partial direct
- * I/O, or bouncing.  The range must also stay within i_size and encrypted
- * inodes must use the generic iomap direct I/O path. IOMAP_DIO_NO_IOMAP_END is
- * a fast-path optimization the caller can set if there is no work that needs to
- * be finished after a mapping.
- *
- * -ENOTBLK is the private sentinel returned by iomap_dio_simple() when it
- * decides the request does not fit the fast path.  In that case we proceed to
- * the generic __iomap_dio_rw() slow path.  Any other errno is a real result and
- * is propagated as-is, in particular -EAGAIN for IOCB_NOWAIT must reach the
- * caller.
- */
-static ssize_t
-iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
-		 iomap_iter_next_fn next, void *private, unsigned int dio_flags)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
-	bool wait_for_completion = is_sync_kiocb(iocb);
-	struct iomap_iter iomi = {
-		.inode		= inode,
-		.pos		= iocb->ki_pos,
-		.len		= count,
-		.flags		= IOMAP_DIRECT,
-		.private	= private,
-	};
 	struct iomap_dio_simple *sr;
 	unsigned int alignment;
 	struct bio *bio;
 	ssize_t ret;
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		iomi.flags |= IOMAP_NOWAIT;
-
-	ret = kiocb_write_and_wait(iocb, count);
-	if (ret)
-		return ret;
-
-	inode_dio_begin(inode);
-
-	ret = next(&iomi, &iomi.iomap, &iomi.srcmap);
-	if (ret <= 0) {
-		inode_dio_end(inode);
-		/* the first iteration must yield a mapping (>0) or an error */
-		if (WARN_ON_ONCE(!ret))
-			return -EFAULT;
-		return ret;
-	}
-
-	if (iomi.iomap.type != IOMAP_MAPPED ||
-	    iomi.iomap.offset + iomi.iomap.length < iomi.pos + count ||
-	    (iomi.iomap.flags & IOMAP_F_INTEGRITY)) {
-		ret = -ENOTBLK;
-		goto out_iomap_end;
-	}
+	if (iomi->iomap.type != IOMAP_MAPPED ||
+	    iomi->iomap.offset + iomi->iomap.length < iomi->pos + iomi->len ||
+	    (iomi->iomap.flags & IOMAP_F_INTEGRITY))
+		return -ENOTBLK;
 
-	alignment = iomap_dio_alignment(inode, iomi.iomap.bdev, dio_flags);
-	if ((iomi.pos | count) & (alignment - 1)) {
-		ret = -EINVAL;
-		goto out_iomap_end;
-	}
+	alignment = iomap_dio_alignment(iomi->inode, iomi->iomap.bdev, 0);
+	if ((iomi->pos | iomi->len) & (alignment - 1))
+		return -EINVAL;
 
-	if (!wait_for_completion && unlikely(!inode->i_sb->s_dio_done_wq)) {
-		ret = sb_init_dio_done_wq(inode->i_sb);
+	if (unlikely(!iomi->inode->i_sb->s_dio_done_wq &&
+			!is_sync_kiocb(iocb))) {
+		ret = sb_init_dio_done_wq(iomi->inode->i_sb);
 		if (ret < 0)
-			goto out_iomap_end;
+			return ret;
 	}
 
-	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, 0);
-
-	if (user_backed_iter(iter))
-		dio_flags |= IOMAP_DIO_USER_BACKED;
+	trace_iomap_dio_rw_begin(iocb, iter, 0, 0);
 
-	bio = bio_alloc_bioset(iomi.iomap.bdev,
+	bio = bio_alloc_bioset(iomi->iomap.bdev,
 			       bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS),
 			       REQ_OP_READ, GFP_KERNEL, &iomap_dio_simple_pool);
 	sr = container_of(bio, struct iomap_dio_simple, bio);
 	sr->iocb = iocb;
-	sr->dio_flags = dio_flags;
+	sr->dio_flags = 0;
 
-	bio->bi_iter.bi_sector = iomap_sector(&iomi.iomap, iomi.pos);
+	bio->bi_iter.bi_sector = iomap_sector(&iomi->iomap, iomi->pos);
 	bio->bi_ioprio = iocb->ki_ioprio;
 
 	ret = bio_iov_iter_get_pages(bio, iter, alignment - 1);
 	if (unlikely(ret))
 		goto out_bio_put;
 
-	if (bio->bi_iter.bi_size != count) {
+	if (bio->bi_iter.bi_size != iomi->len) {
 		iov_iter_revert(iter, bio->bi_iter.bi_size);
 		ret = -ENOTBLK;
 		goto out_bio_release_pages;
@@ -1128,68 +1031,35 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	sr->size = bio->bi_iter.bi_size;
 
-	if (dio_flags & IOMAP_DIO_USER_BACKED)
+	if (user_backed_iter(iter)) {
 		bio_set_pages_dirty(bio);
+		sr->dio_flags |= IOMAP_DIO_USER_BACKED;
+	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
-	if ((iocb->ki_flags & IOCB_HIPRI) && !wait_for_completion) {
-		bio->bi_opf |= REQ_POLLED;
-		WRITE_ONCE(iocb->private, bio);
-	}
 
-	/*
-	 * The finishing iomap_iter() only runs the filesystem's iomap_end()
-	 * work and releases any attached folio batch.  When the caller promised
-	 * neither applies (IOMAP_DIO_NO_IOMAP_END), skip it to avoid an extra
-	 * iomap_next() call on the hot read path.
-	 */
-	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
-		iomap_dio_simple_finish(&iomi, next, count);
-
-	if (!wait_for_completion) {
-		bio->bi_end_io = iomap_dio_simple_end_io;
-		submit_bio(bio);
-		trace_iomap_dio_rw_queued(inode, iocb->ki_pos, count);
-		return -EIOCBQUEUED;
+	if (is_sync_kiocb(iocb)) {
+		submit_bio_wait(bio);
+		return iomap_dio_simple_complete(sr);
 	}
 
-	submit_bio_wait(bio);
-	return iomap_dio_simple_complete(sr);
+	if ((iocb->ki_flags & IOCB_HIPRI)) {
+		bio->bi_opf |= REQ_POLLED;
+		WRITE_ONCE(iocb->private, bio);
+	}
+	bio->bi_end_io = iomap_dio_simple_end_io;
+	submit_bio(bio);
+	trace_iomap_dio_rw_queued(iomi->inode, iocb->ki_pos, iomi->len);
+	return -EIOCBQUEUED;
 
 out_bio_release_pages:
 	bio_release_pages(bio, false);
 out_bio_put:
 	bio_put(bio);
-out_iomap_end:
-	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
-		iomap_dio_simple_finish(&iomi, next, 0);
-	inode_dio_end(inode);
 	return ret;
 }
-
-ssize_t
-iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, iomap_iter_next_fn next,
-		const struct iomap_dio_ops *dops, unsigned int dio_flags,
-		void *private, size_t done_before)
-{
-	struct iomap_dio *dio;
-	ssize_t ret;
-
-	if (iomap_dio_simple_supported(iocb, iter, dops, dio_flags,
-				       done_before)) {
-		ret = iomap_dio_simple(iocb, iter, next, private, dio_flags);
-		if (ret != -ENOTBLK)
-			return ret;
-	}
-
-	dio = __iomap_dio_rw(iocb, iter, next, dops, dio_flags, private,
-			     done_before);
-	if (IS_ERR_OR_NULL(dio))
-		return PTR_ERR_OR_ZERO(dio);
-	return iomap_dio_complete(dio);
-}
-EXPORT_SYMBOL_GPL(iomap_dio_rw);
+EXPORT_SYMBOL_GPL(__iomap_dio_simple);
 
 static int __init iomap_dio_init(void)
 {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 012c073c9b01..d36a77b854aa 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -127,8 +127,7 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
 	{IOMAP_DIO_FORCE_WAIT,		"DIO_FORCE_WAIT" }, \
 	{IOMAP_DIO_OVERWRITE_ONLY,	"DIO_OVERWRITE_ONLY" }, \
 	{IOMAP_DIO_PARTIAL,		"DIO_PARTIAL" }, \
-	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }, \
-	{IOMAP_DIO_NO_IOMAP_END,	"DIO_NO_IOMAP_END" }
+	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }
 
 DECLARE_EVENT_CLASS(iomap_class,
 	TP_PROTO(struct inode *inode, struct iomap *iomap),
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 24c621ac984a..a4f99128b46c 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -458,8 +458,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, to, ntfs_read_iomap_next, NULL,
-				IOMAP_DIO_NO_IOMAP_END, NULL, 0);
+		ret = iomap_dio_rw(iocb, to, ntfs_read_iomap_next, NULL, 0,
+				NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 	}
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ea709e4c9607..877f9024d333 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -251,8 +251,6 @@ xfs_file_dio_read(
 	struct iov_iter		*to)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
-	unsigned int		dio_flags = IOMAP_DIO_NO_IOMAP_END;
-	const struct iomap_dio_ops *dio_ops = NULL;
 	ssize_t			ret;
 
 	trace_xfs_file_direct_read(iocb, to);
@@ -266,11 +264,15 @@ xfs_file_dio_read(
 	if (ret)
 		return ret;
 	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
-		dio_ops = &xfs_dio_read_bounce_ops;
-		dio_flags |= IOMAP_DIO_BOUNCE;
+		ret = iomap_dio_rw(iocb, to, xfs_read_iomap_next,
+				&xfs_dio_read_bounce_ops, IOMAP_DIO_BOUNCE,
+				NULL, 0);
+	} else {
+		ret = iomap_dio_read_simple(iocb, to, xfs_read_iomap_begin);
+		if (ret == -ENOTBLK)
+			ret = iomap_dio_rw(iocb, to, xfs_read_iomap_next, NULL,
+					0, NULL, 0);
 	}
-	ret = iomap_dio_rw(iocb, to, xfs_read_iomap_next, dio_ops, dio_flags,
-			NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1314c95f7416..534cdf537224 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -2167,7 +2167,7 @@ xfs_buffered_write_iomap_end(
 DEFINE_IOMAP_ITER_NEXT_END(xfs_buffered_write_iomap_next,
 		xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap_end);
 
-static int
+inline int
 xfs_read_iomap_begin(
 	struct inode		*inode,
 	loff_t			offset,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 01875d20fb66..d271db75d891 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -55,6 +55,9 @@ int xfs_direct_write_iomap_next(const struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap *srcmap);
 int xfs_zoned_direct_write_iomap_next(const struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap *srcmap);
+inline int xfs_read_iomap_begin(struct inode *inode, loff_t offset,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap);
 int xfs_read_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
 		struct iomap *srcmap);
 int xfs_seek_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 519613f281aa..368be7e87c6a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -10,6 +10,7 @@
 #include <linux/mm_types.h>
 #include <linux/blkdev.h>
 #include <linux/folio_batch.h>
+#include <linux/pagemap.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -668,14 +669,6 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
-/*
- * The caller's ->iomap_next() has no ->iomap_end() work to run and this I/O
- * does not use a folio batch, so the iomap_dio_simple() fast path may skip the
- * finishing iomap_iter() call entirely.  Only meaningful on the simple read
- * fast path; ignored by the generic __iomap_dio_rw() slow path.
- */
-#define IOMAP_DIO_NO_IOMAP_END		(1 << 5)
-
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iomap_iter_next_fn next, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
@@ -685,6 +678,70 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
+/*
+ * Fast path for small, block-aligned direct I/Os that map to a single
+ * contiguous on-disk extent.
+ *
+ * @iter must describe a non-empty READ no larger than the inode block size:
+ * writes, zero-length I/O, and larger requests need the generic iomap direct
+ * I/O path.
+ *
+ * Does not support iomap_dio_ops, dio_flags, done_before or private data.
+ * The range must also stay within i_size and encrypted inodes must use the
+ * generic iomap direct I/O path.
+ *
+ * -ENOTBLK inidicates the generic path must be used by the caller instead.
+ * Any other errno is a real result and is propagated as-is, in particular
+ * -EAGAIN for IOCB_NOWAIT must reach the caller.
+ *
+ * The caller can only provide an iomap begin handler, and the iterator
+ * is never advanced.
+ */
+ssize_t __iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
+		iomap_iter_begin_fn begin, struct iomap_iter *iomi);
+static __always_inline ssize_t iomap_dio_read_simple(struct kiocb *iocb,
+		struct iov_iter *iter, iomap_iter_begin_fn begin)
+{
+	struct iomap_iter iomi = {
+		.inode		= file_inode(iocb->ki_filp),
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(iter),
+		.flags		= IOMAP_DIRECT,
+	};
+	ssize_t ret;
+
+	if (!iomi.len)
+		return 0;
+
+	/*
+	 * Simple dio is an optimization for small IO. Filter out large IO
+	 * early as it's the most common case to fail for typical direct IO
+	 * workloads.
+	 */
+	if (iomi.len > iomi.inode->i_sb->s_blocksize)
+		return -ENOTBLK;
+	if (iocb->ki_pos + iomi.len > i_size_read(iomi.inode))
+		return -ENOTBLK;
+	if (IS_ENCRYPTED(iomi.inode))
+		return -ENOTBLK;
+
+	ret = kiocb_write_and_wait(iocb, iomi.len);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		iomi.flags |= IOMAP_NOWAIT;
+
+	inode_dio_begin(iomi.inode);
+	ret = begin(iomi.inode, iomi.pos, iomi.len, iomi.flags, &iomi.iomap,
+			&iomi.srcmap);
+	if (!ret) 
+		ret = __iomap_dio_simple(iocb, iter, begin, &iomi);
+	if (ret <= 0 && ret != -EIOCBQUEUED)
+		inode_dio_end(iomi.inode);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 struct file;
 struct swap_info_struct;
