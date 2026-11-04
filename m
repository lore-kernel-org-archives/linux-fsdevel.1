Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815972;
	b=bImf2WXJEmC8e7IQ4PYm24NtMOXYBqjq8R7SreN4ZRYC6mqTz7sAyHMeuHajMJAQ+aJz
	 VyvjJjppzfkfxX50tQdzBuPJCDqEpLJdKku38yOWBABKWfs0UgCLOtDtcmgfTLZycUDt5
	 0wuB1s3ZeHz4+1B23gztOtOOXiJmQAlEw4wo1t+d3WI93fUK7+Q7dozD9aiOq33oyLhc9
	 j1KLWbCvEwGf64cOPqFmE0R7mF3lfTknD1OBm4rP6LH3x4ekQ3wIFM1vnJzkVMv8v4cMu
	 LB5djcI6OgJUmoXAeGMb4yZcGYFAwVJU5G4ollHQ9lhaYwFk38uSYxhyd4oGRL8UxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SLiPD53HR7PY8rScImE/+5BcuQFIJQbmIF65gIT4Fow=;
	b=QQ4yqlsR4Zz54o1EIvBbZWMXnveHAnV9mnlTUJlBat8MipI+bhbfEZv28T5n446AcLYQ
	 ROQroM0Qh9MkEIoTggTiOZplsgms9tRlyaSBXBmneKCgCA7J5X0xvKAZF04cJWBWt7BqS
	 RvQQXVPQtj6rhl7wb8YB7UKrLX5Wark2n7PkiJFXTE1425/J0EgbZxBbOk4EztzcCvq/z
	 e7FGcOo4J5WgOZtOtZSPoZ9MPNPOXPQRS5ZvGrhjtTBvei1keoF42gdZsh4zPqKWlJVe5
	 3WxXI7aSSq8taT3RtRHLsi5apaRu5/IRFNQR+CSDOKVrNV/033GeH2H68beeECUnRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tN//qUCJ";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F2606B205
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 18:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873F2606B205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tN//qUCJ
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so857661a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815971; x=1794420771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SLiPD53HR7PY8rScImE/+5BcuQFIJQbmIF65gIT4Fow=;
        b=tN//qUCJ2vDIkL4IwOY7DC6Qe9s8JylI9u451Pm6jLzcXejLHUjNhLiH4ST93PdSpx
         88SjMM3tkte/B0Ade6FninIhtSrbSdd8ODyRhV0JzVL9CXvL4Njs1+JNsPj6UXn1AN9S
         5JO+u1p4IhidehQRdX3sExxmvx7ZE+BFWwG39YOfsVxip5+0FUk2U8+xeE8+G16LW9bW
         Td0ga4LyyTWN6XYcO5YbX4UyzoKPc2T6i/Jjumpb1mqM5XOXY7FlR43a68RHGdkDr4PJ
         OnqDPkad+9uioHk8jahMj60IEO7X70iHmy4o7CdWgUz0yTjoEi+0TRjjcaR81shZ2k86
         +QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815971; x=1794420771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SLiPD53HR7PY8rScImE/+5BcuQFIJQbmIF65gIT4Fow=;
        b=hTfS5rvobdQyO7wLkzpvYxfCcVAmz6qe1fMq3M+XA6MWDPSkOZJn9uIz0bAMeaFbOy
         r0EMYKAgkL1L3OKxVbHbfViokwotPs0dfTter3TcHdThtEPen4/a6qDBBH7OtjjkxPRh
         y8gy5ZsyCEgKa4g477IVQ5IwnSPVp4Ln+1y6DiPNKbNMrF4ZTgiKNtJChevWyLCPKorA
         aH3aYU6SahfdkRWUN7CoichFotr2/5i1pk6r80qViJ9w43fR9oC7AYSN3E+6k9nXOt0d
         HQGZ4tPjj2i6qiZLldOafLR5pZimHWougdVZ0SNirSjj2iCQSeo2xfxHlDm6s+qPgz7A
         dRaw==
X-Gm-Message-State: APuU4Z/RTUjEkXjKZNA5FWGRN/L8WGoCEoWvE7Hzmmmd9z5z0kG8dRDl
	FK4XW7fm+0FX9c0kLeHacd4ggyvnVJRPT5DFZW/Fvky0nI+fpXa6SitmVvcZ9Sc1kbVR9Q==
X-Gm-Gg: AYBFou0xY8se1Zv9tvjYjn/Dax18uCXHn0tSbRQeF78K7RLz8hCUMS0wC/TXmhiIywF
	c9diDRNuD5ugehD7q5F7eJ0g5HZGWfDKDguMigFIEBakxXAsISH5IEnrgyjadTVZ8RQ8E8bCD2i
	QoSLJaHyzGnb4K9mRux0QtQ0/wSutPhxR27S0Ydsw6zPKBj+2EVIxjFqN0/5nA+30d6feZQ4ip3
	N1veZOXWnjDxldGNQwAfK0470q7CXFl6j8kz2SUumwcc0N125f33CZ8BXoert0ebkEExaeDNGl3
	qYZCYKpOqDtD6AaNoR5NLhz+fFyseUlKvxLrmAypXSBBAi85HK+443lANn6QcgyMkrchOCK0lcI
	ElG6fx1GeFdztTwaTnGLb5p2FQLjJYqdWTagHYDQWhgshUyA98I5prYbLBxm9lusyZVd0zRc/Hj
	y/c00nT/XtM8i7EPtKcDDpxfYbguwUAC6ypA5OQGNlaVGCYrgeXvcs6h7srZqa0Xh6QCzzXp/8C
	+rWurKpmZr18RZi7cEymLQfSHR255SPd3Rnq2+GLVOVny5n9OdnQsDu0yhZvLnNUMx6aBJaVuNK
	2Ol+C6xhdmHTD8X0oqsIgPufUkDJkPjr8KbNUTpD4Aj6qrVB7nKC7RpTSe6nxIiE/a0BesbWDDJ
	RxQHhentHyASjmocO0h5Jn0zltVA=
X-Received: by 2002:a17:90b:1c10:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3ae89799522mr15264959a91.41.1793815970772;
        Wed, 04 Nov 2026 10:12:50 -0800 (PST)
Received: from archlinux.tail3acd4.ts.net ([69.110.143.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31a3efasm78326a91.9.2026.11.04.10.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:12:50 -0800 (PST)
From: Vitali Lovich <vlovich@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	cem@kernel.org,
	djwong@kernel.org
Subject: [RFC PATCH 2/6] iomap: support generation accounting and caller-registered DIO
Date: Wed,  4 Nov 2026 10:12:42 -0800
Message-ID: <50539e987d104871cff5c25b7e803eaea5d3da27.1793815542.git.vlovich@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793815542.git.vlovich@gmail.com>
References: <cover.1793815542.git.vlovich@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generation draining requires every DIO request on an opted-in inode to
preserve its admission generation until completion. Convert both generic
iomap DIO and the simple-read path to generation-aware accounting,
reusing their existing internal flag fields.

Allow callers to register DIO before entering iomap with
IOMAP_DIO_ACCOUNTED and pass the saved token in IOMAP_DIO_GENERATION.
Iomap owns that registration and releases it on completion or any early
return, including allocation failures, empty requests and -ENOTBLK.
Callers retrying through the generic path must acquire a fresh admission.
Callers without a registration retain internal iomap accounting.

Pass the flags into iomap_dio_read_simple() and update existing XFS and
ext4 callers to pass zero. Preserve the token through mapping and
submission errors, and read it before bio_put() frees the bio-backed
simple-read struct. The completion lifetime still includes filesystem
end_io work and post-write invalidation.

Signed-off-by: Vitali Lovich <vlovich@gmail.com>
---
 fs/ext4/file.c        |  2 +-
 fs/iomap/direct-io.c  | 36 +++++++++++++++++++++-------
 fs/xfs/xfs_file.c     |  2 +-
 include/linux/iomap.h | 56 +++++++++++++++++++++++++++++--------------
 4 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 50d3c92709c8..cb6d6722c18e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -91,7 +91,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_read_simple(iocb, to, ext4_iomap_begin);
+	ret = iomap_dio_read_simple(iocb, to, ext4_iomap_begin, 0);
 	if (ret == -ENOTBLK)
 		ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ad041ac3252a..fffe6702c42f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -149,7 +149,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	    !(dio->flags & IOMAP_DIO_NO_INVALIDATE))
 		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
-	inode_dio_end(file_inode(iocb->ki_filp));
+	inode_dio_end_generation(file_inode(iocb->ki_filp),
+				dio->flags & IOMAP_DIO_GENERATION);
 
 	if (ret > 0) {
 		iocb->ki_pos += ret;
@@ -690,6 +691,12 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
  * the correct total number of bytes transferred; this is essential for
  * completing partial requests asynchronously.
  *
+ * When @dio_flags includes IOMAP_DIO_ACCOUNTED, iomap takes ownership of the
+ * caller's registration from inode_dio_try_begin() on entry, with its saved
+ * generation token supplied in IOMAP_DIO_GENERATION. Iomap releases the
+ * registration on completion or any early error or NULL return, including
+ * -ENOTBLK. Callers retrying the request must acquire a fresh registration.
+ *
  * Returns -ENOTBLK In case of a page invalidation invalidation failure for
  * writes.  The callers needs to fall back to buffered I/O in this case.
  */
@@ -708,6 +715,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	};
 	bool wait_for_completion =
 		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
+	bool accounted = dio_flags & IOMAP_DIO_ACCOUNTED;
+	bool generation = dio_flags & IOMAP_DIO_GENERATION;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 	loff_t ret = 0;
@@ -715,11 +724,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
 	if (!iomi.len)
-		return NULL;
+		goto out_account;
 
 	dio = kmalloc_obj(*dio);
-	if (!dio)
-		return ERR_PTR(-ENOMEM);
+	if (!dio) {
+		ret = -ENOMEM;
+		goto out_account;
+	}
 
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
@@ -816,7 +827,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 	}
 
-	inode_dio_begin(inode);
+	if (!accounted)
+		generation = inode_dio_begin_generation(inode);
+	if (generation)
+		dio->flags |= IOMAP_DIO_GENERATION;
 
 	blk_start_plug(&plug);
 	while ((ret = iomap_iter(&iomi, ops)) > 0) {
@@ -901,6 +915,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 out_free_dio:
 	kfree(dio);
+out_account:
+	if (accounted)
+		inode_dio_end_generation(inode, generation);
 	if (ret)
 		return ERR_PTR(ret);
 	return NULL;
@@ -943,6 +960,7 @@ static ssize_t iomap_dio_simple_complete(struct iomap_dio_simple *sr)
 	struct bio *bio = &sr->bio;
 	struct kiocb *iocb = sr->iocb;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	bool generation = sr->dio_flags & IOMAP_DIO_GENERATION;
 	ssize_t ret;
 
 	if (unlikely(bio->bi_status)) {
@@ -962,7 +980,7 @@ static ssize_t iomap_dio_simple_complete(struct iomap_dio_simple *sr)
 		bio_release_pages(bio, false);
 		bio_put(bio);
 	}
-	inode_dio_end(inode);
+	inode_dio_end_generation(inode, generation);
 	trace_iomap_dio_complete(iocb, ret < 0 ? ret : 0, ret);
 	return ret;
 }
@@ -980,7 +998,7 @@ static void iomap_dio_simple_end_io(struct bio *bio)
 }
 
 ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
-		struct iomap_iter *iomi)
+		struct iomap_iter *iomi, bool generation)
 {
 	gfp_t gfp = (iomi->flags & IOMAP_NOWAIT) ? GFP_NOWAIT : GFP_KERNEL;
 	struct iomap_dio_simple *sr;
@@ -1019,7 +1037,7 @@ ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	sr = container_of(bio, struct iomap_dio_simple, bio);
 	sr->iocb = iocb;
-	sr->dio_flags = 0;
+	sr->dio_flags = generation ? IOMAP_DIO_GENERATION : 0;
 
 	bio->bi_iter.bi_sector = iomap_sector(&iomi->iomap, iomi->pos);
 	bio->bi_ioprio = iocb->ki_ioprio;
@@ -1064,7 +1082,7 @@ ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 out_bio_put:
 	bio_put(bio);
 out_dio_end:
-	inode_dio_end(iomi->inode);
+	inode_dio_end_generation(iomi->inode, generation);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__iomap_dio_read_simple);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7d0c8a197575..124a037cfa9f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -253,7 +253,7 @@ xfs_file_dio_read(
 		ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops,
 				&xfs_dio_read_bounce_ops, 0, NULL, 0);
 	} else {
-		ret = iomap_dio_read_simple(iocb, to, xfs_read_iomap_begin);
+		ret = iomap_dio_read_simple(iocb, to, xfs_read_iomap_begin, 0);
 		if (ret == -ENOTBLK)
 			ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
 					0, NULL, 0);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5254430844b2..611c37c19f82 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -710,6 +710,16 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
+/*
+ * IOMAP_DIO_ACCOUNTED indicates the caller has already registered this
+ * request with inode_dio_try_begin(); iomap takes ownership of the
+ * registration and releases it on completion or early return (including
+ * -ENOTBLK). IOMAP_DIO_GENERATION carries the generation token returned
+ * by that admission and is only meaningful with IOMAP_DIO_ACCOUNTED.
+ */
+#define IOMAP_DIO_ACCOUNTED	(1 << 5)
+#define IOMAP_DIO_GENERATION	(1 << 6)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
@@ -727,7 +737,8 @@ void iomap_dio_bio_end_io(struct bio *bio);
  * writes, zero-length I/O, and larger requests need the generic iomap direct
  * I/O path.
  *
- * Does not support iomap_dio_ops, dio_flags, done_before or private data.
+ * Does not support iomap_dio_ops, done_before, private data, or dio_flags
+ * other than IOMAP_DIO_ACCOUNTED and IOMAP_DIO_GENERATION.
  * The range must also stay within i_size and encrypted inodes must use the
  * generic iomap direct I/O path.
  *
@@ -739,9 +750,10 @@ void iomap_dio_bio_end_io(struct bio *bio);
  * is never advanced.
  */
 ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
-		struct iomap_iter *iomi);
+		struct iomap_iter *iomi, bool generation);
 static __always_inline ssize_t iomap_dio_read_simple(struct kiocb *iocb,
-		struct iov_iter *iter, iomap_iter_begin_fn begin)
+		struct iov_iter *iter, iomap_iter_begin_fn begin,
+		unsigned int dio_flags)
 {
 	struct iomap_iter iomi = {
 		.inode		= file_inode(iocb->ki_filp),
@@ -749,39 +761,47 @@ static __always_inline ssize_t iomap_dio_read_simple(struct kiocb *iocb,
 		.len		= iov_iter_count(iter),
 		.flags		= IOMAP_DIRECT,
 	};
+	bool accounted = dio_flags & IOMAP_DIO_ACCOUNTED;
+	bool generation = dio_flags & IOMAP_DIO_GENERATION;
 	ssize_t ret;
 
-	if (!iomi.len)
-		return 0;
+	if (!iomi.len) {
+		ret = 0;
+		goto out_account;
+	}
 
 	/*
 	 * Simple dio is an optimization for small IO. Filter out large IO
 	 * early as it's the most common case to fail for typical direct IO
 	 * workloads.
 	 */
-	if (iomi.len > iomi.inode->i_sb->s_blocksize)
-		return -ENOTBLK;
-	if (iocb->ki_pos + iomi.len > i_size_read(iomi.inode))
-		return -ENOTBLK;
-	if (IS_ENCRYPTED(iomi.inode))
-		return -ENOTBLK;
+	ret = -ENOTBLK;
+	if (iomi.len > iomi.inode->i_sb->s_blocksize ||
+	    iocb->ki_pos + iomi.len > i_size_read(iomi.inode) ||
+	    IS_ENCRYPTED(iomi.inode))
+		goto out_account;
 
 	ret = kiocb_write_and_wait(iocb, iomi.len);
 	if (ret)
-		return ret;
+		goto out_account;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	inode_dio_begin(iomi.inode);
+	if (!accounted) {
+		generation = inode_dio_begin_generation(iomi.inode);
+		accounted = true;
+	}
 	ret = begin(iomi.inode, iomi.pos, iomi.len, iomi.flags, &iomi.iomap,
 			&iomi.srcmap);
-	if (ret) {
-		inode_dio_end(iomi.inode);
-		return ret;
-	}
+	if (ret)
+		goto out_account;
 
-	return __iomap_dio_read_simple(iocb, iter, &iomi);
+	return __iomap_dio_read_simple(iocb, iter, &iomi, generation);
+out_account:
+	if (accounted)
+		inode_dio_end_generation(iomi.inode, generation);
+	return ret;
 }
 
 #ifdef CONFIG_SWAP
-- 
2.56.0

