Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F52369D74
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024765; cv=none; b=XJ2n6XUx80T1wrWKhtwvu5vo7hjdKUgZrEK9goeSKMpH8eP99A25BTEVV85GW6K8/SvrhxSDym064aun2BvzuHG5mxIUMNV/spLvF7mqfueHvMKw1btQA2Byb5sy6EkC58KaS2CNOCHhAtgUJDMpXWNhmvqOhuPB5yVMkLdwfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024765; c=relaxed/simple;
	bh=ebPWwbhZK7a9ZPtZL9IQK+7IBpikM7G4YWSLpPXvkck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjzJBNvJWj0kfFe+WMIATSQtIJt2tBkDNf+KTHcrv/pFvmLAm7YY+5A9URciGesbLhLLnmlP8/HibZ3kIW1bb3g26RglcsDM+bdUBblHjQd8puO5SKwZF0W0F6EmL+8BhWuLGoaZcLtAPQhr40fEQvuqZhCYhhzySNmR/NfYbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2fU9XLa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2fU9XLa"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43ab7bfaa18so5337164fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024763; x=1780629563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56Be5L4j1U5nONJeKG6JktuUMcJW9O2wz7rUTLmLEN8=;
        b=Y2fU9XLaLDj2uJ75hPlJnHbrtEn0T79+K4wZnsvzrH9ke8EColmiYE+41TM1gAHG4l
         h35cTynplUT2xJ7dv84VFH+MgZkFOmUq1/GQkFz8ZUOJqeovV/0J0uFw9570+xtYGVYR
         PQgYFfKlZfVaNKMf9musLogOn8Hs5c+Gst03SgJ9lv5c4oWBZRJdapAd/RSM4HMj9yuP
         BxhhMApmb9TrF6iwq1m67ppazGZikrJ6DFrsIyJClUdcVJTfZ4Cxc7OTJFh+sYVBE+1j
         YqodcZQ6BvI7duEdM6t+YvxQxWZS2b/uhRk6SoNXnVfSdmxSDXwSE5SIc6pksbZ7l50J
         QlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024763; x=1780629563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56Be5L4j1U5nONJeKG6JktuUMcJW9O2wz7rUTLmLEN8=;
        b=WBGmoRU46B/Usgf0ANoYl2Ohz5qIxNyFPnvxM6a66O7mSXSFAlB3i7UyWMKtB3Hahy
         vfjvxHcQZlLKtI/d3j2Ji0YCpH3cdXGVfxXWihq+1jOpYGGbo43HeK1+m/BlNc0wn5rS
         f0DAYjHxdbFujWHrpLAlS5x4UU7B058g11NHeHb+8eo1keo+ddAQALTU/KMiYIIf5pzU
         Ct/qbFtVwb7a6+AXesfoqo3lb1xRLgtevfeHHgHC4gKc0KCepdofXgVI5mrjOvA99PBv
         7V3t94vIvzqx5g+nXA9jWbssckKIOTlZu8FXDrwtRAKES1EfReZH2zDFSQsUCx9kVB8U
         8n3Q==
X-Gm-Message-State: AOJu0YzNJxwVSt9mKEUETqfkXhAVHpQotWAyKBtCTJJ97pWaTANRPFaf
	+N4ku+g8cwsiNk7m84E5jHC8dwUPDIQo7ckuysCHFhZ9TiPkg1Ga4nrZLeBWsDSh
X-Gm-Gg: Acq92OEk/WwVgER51cFQ6h4WlLZIbaX1n/Efn8gK3z4xbl5LUFxnj9XtZfsnVAg0kKD
	0139FEQv6y+7cpDjmeAbU1Vo9PrrmjZRgNVNZkQkN+iTStmZ3smJeQseBHzPZYh1OgzjiTXZY8i
	VSreVbZQSNX/2RibzBkRexkUmGHnS8htWi93GlqPFgDnqLgzSS2P/rqq1E3VJcBscZBN1Qsg6vJ
	DRMkQ4nBOE6dMzlupi+ccp+sHl51PLKULU35fGHT+5jpihCuqij9EFCHDLDLvHFbN/0Lqj4KM8p
	eXIySLs+WaTnwx3terMjquTFzy0TwI/RATBj0hDT/jx4sBsjj0jVJu8rtiwR+B2eKS8jzjvrQO2
	xSBay3NzF68eHq9wOoa2zks87OoDhu37dUNhoMhfAQ5DPtAbHc3zhQYGMBoYoLVca3XI5F+44CB
	BSTqtCxZfq83fNEwfwdIS8SPP97oBVn4KvARK5pubwm5Rxnalg99n2DF4WSt8thfH0eTRvHaHpt
	DRNdz+EgXQtKJJoHI4Zsamz5wO6TP2hpXSvAjkUIU3s7kAUhBpaablVIpuvAe1EWA==
X-Received: by 2002:a05:6808:6d8a:b0:482:4df3:91cb with SMTP id 5614622812f47-485e6d1eebemr814280b6e.41.1780024763293;
        Thu, 28 May 2026 20:19:23 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bb393bsm556788a34.7.2026.05.28.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:19:22 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH 2/2] fuse: reduce fi->lock contention on parallel direct I/O
Date: Fri, 29 May 2026 03:19:16 +0000
Message-ID: <20260529031918.7361-3-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529031918.7361-1-russ.fellows@gmail.com>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On the parallel passthrough write path, fi->lock was acquired three
times per I/O under the original code:

  1. fuse_inode_uncached_io_start() -- decrement iocachectr
  2. fuse_write_update_attr()        -- bump attr_version, check i_size
  3. fuse_inode_uncached_io_end()    -- increment iocachectr, wake waiters

At 1.7M IOPS (numjobs=8, iodepth=64, 4K) this amounts to ~5.1M spinlock
acquisitions/second on a single cache line.  While the parallel-writes fix
(patch 1/2) is the primary bottleneck, this patch eliminates the remaining
fi->lock overhead on the hot path.

Convert iocachectr from int to atomic_t and add lockless fast paths:

fuse_inode_uncached_io_start(fb=NULL): use an atomic_try_cmpxchg loop to
check-and-decrement without fi->lock.  The lock is still taken for the
first open (0→-1 transition) and for backing-file manipulation.

fuse_inode_uncached_io_end(): use atomic_inc_return to detect the
still-inflight case (counter still negative after increment) without a
lock.  fi->lock is only taken when the counter reaches zero, to serialize
wake_up and backing-file clear with concurrent opens.

fuse_write_update_attr(): skip fi->lock for the common in-EOF case.
Use WRITE_ONCE for fi->attr_version (some readers already access it
without fi->lock, e.g. inode.c:355 and dir.c:2069).  fi->lock is only
taken when pos > i_size, with a double-check inside to handle races near
EOF.  Parallel direct writes are gated on fuse_io_past_eof() returning
false upstream, so this slow path is not taken on the hot path.

All existing callsites that access iocachectr under fi->lock are updated
to use the atomic API (atomic_read/inc/dec), which are no-ops with the
lock held.

Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
---
 fs/fuse/file.c   | 31 +++++++++++++++++++++++--------
 fs/fuse/fuse_i.h |  9 +++++++--
 fs/fuse/inode.c  |  2 +-
 fs/fuse/iomode.c | 53 +++++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 602c3f18676e..73f870099 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1115,16 +1115,29 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool ret = false;
 
-	spin_lock(&fi->lock);
-	fi->attr_version = atomic64_inc_return(&fc->attr_version);
-	if (written > 0 && pos > inode->i_size) {
-		i_size_write(inode, pos);
-		ret = true;
-	}
-	spin_unlock(&fi->lock);
-
+	/*
+	 * Bump the global attr version so stale cached attrs are detected.
+	 * WRITE_ONCE is sufficient: some readers don't hold fi->lock, and
+	 * on x86_64 the store is naturally atomic.  fi->lock is only needed
+	 * for the i_size extension case below.
+	 */
+	WRITE_ONCE(fi->attr_version, atomic64_inc_return(&fc->attr_version));
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 
+	/*
+	 * Only take fi->lock when the write may extend the file.  Parallel
+	 * direct writes are gated on fuse_io_past_eof() returning false, so
+	 * this slow path is not taken on the hot parallel-write path.
+	 */
+	if (written > 0 && pos > READ_ONCE(inode->i_size)) {
+		spin_lock(&fi->lock);
+		if (pos > inode->i_size) {
+			i_size_write(inode, pos);
+			ret = true;
+		}
+		spin_unlock(&fi->lock);
+	}
+
 	return ret;
 }
 
@@ -3154,7 +3154,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
-	fi->iocachectr = 0;
+	atomic_set(&fi->iocachectr, 0);
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 120de517cea0..67077afb3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -153,8 +153,13 @@ struct fuse_inode {
 			 * (FUSE_NOWRITE) means more writes are blocked */
 			int writectr;
 
-			/** Number of files/maps using page cache */
-			int iocachectr;
+			/**
+			 * Refcount for inode I/O mode: > 0 means cached I/O
+			 * users, 0 is idle, < 0 means parallel uncached I/Os
+			 * in flight.  Use atomic ops; fi->lock only needed
+			 * for the 0↔±1 boundary transitions.
+			 */
+			atomic_t iocachectr;
 
 			/* Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7c0403a00..81e01cb55 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -190,7 +190,7 @@ static void fuse_evict_inode(struct inode *inode)
 		atomic64_inc(&fc->evict_ctr);
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
-		WARN_ON(fi->iocachectr != 0);
+		WARN_ON(atomic_read(&fi->iocachectr) != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3..611baacf9 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -17,7 +17,7 @@
  */
 static inline bool fuse_is_io_cache_wait(struct fuse_inode *fi)
 {
-	return READ_ONCE(fi->iocachectr) < 0 && !fuse_inode_backing(fi);
+	return atomic_read(&fi->iocachectr) < 0 && !fuse_inode_backing(fi);
 }
 
 /*
@@ -60,9 +60,9 @@ int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
 	WARN_ON(ff->iomode == IOM_UNCACHED);
 	if (ff->iomode == IOM_NONE) {
 		ff->iomode = IOM_CACHED;
-		if (fi->iocachectr == 0)
-			set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
-		fi->iocachectr++;
+		if (!atomic_read(&fi->iocachectr))
+			set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+		atomic_inc(&fi->iocachectr);
 	}
 	spin_unlock(&fi->lock);
 	return 0;
@@ -72,11 +72,10 @@ static void fuse_file_cached_io_release(struct fuse_file *ff,
 				        struct fuse_inode *fi)
 {
 	spin_lock(&fi->lock);
-	WARN_ON(fi->iocachectr <= 0);
+	WARN_ON(atomic_read(&fi->iocachectr) <= 0);
 	WARN_ON(ff->iomode != IOM_CACHED);
 	ff->iomode = IOM_NONE;
-	fi->iocachectr--;
-	if (fi->iocachectr == 0)
+	if (!atomic_dec_return(&fi->iocachectr))
 		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
 	spin_unlock(&fi->lock);
 }
@@ -85,23 +84,37 @@ static void fuse_file_cached_io_release(struct fuse_file *ff,
 int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 {
 	struct fuse_backing *oldfb;
-	int err = 0;
+	int old, err = 0;
+
+	/*
+	 * Fast lockless path for per-I/O calls (fb=NULL, no backing file).
+	 * Use a CAS loop to atomically verify no cached users are present
+	 * and decrement the refcount in one step.
+	 */
+	if (!fb) {
+		old = atomic_read(&fi->iocachectr);
+		do {
+			if (old > 0)
+				return -ETXTBSY;
+		} while (!atomic_try_cmpxchg(&fi->iocachectr, &old, old - 1));
+		return 0;
+	}
 
 	spin_lock(&fi->lock);
 	/* deny conflicting backing files on same fuse inode */
 	oldfb = fuse_inode_backing(fi);
-	if (fb && oldfb && oldfb != fb) {
+	if (oldfb && oldfb != fb) {
 		err = -EBUSY;
 		goto unlock;
 	}
-	if (fi->iocachectr > 0) {
+	if (atomic_read(&fi->iocachectr) > 0) {
 		err = -ETXTBSY;
 		goto unlock;
 	}
-	fi->iocachectr--;
+	atomic_dec(&fi->iocachectr);
 
 	/* fuse inode holds a single refcount of backing file */
-	if (fb && !oldfb) {
+	if (!oldfb) {
 		oldfb = fuse_inode_backing_set(fi, fb);
 		WARN_ON_ONCE(oldfb != NULL);
 	} else {
@@ -133,10 +146,20 @@ void fuse_inode_uncached_io_end(struct fuse_inode *fi)
 {
 	struct fuse_backing *oldfb = NULL;
 
+	/*
+	 * Fast path: other uncached I/Os still in flight -- just increment
+	 * and return without taking fi->lock.
+	 */
+	if (atomic_inc_return(&fi->iocachectr) < 0)
+		return;
+
+	/*
+	 * This may be the last uncached I/O.  Take the lock and re-check:
+	 * a new uncached I/O may have started between the atomic_inc_return
+	 * and the spin_lock, so only wake/clear if iocachectr is still zero.
+	 */
 	spin_lock(&fi->lock);
-	WARN_ON(fi->iocachectr >= 0);
-	fi->iocachectr++;
-	if (!fi->iocachectr) {
+	if (!atomic_read(&fi->iocachectr)) {
 		wake_up(&fi->direct_io_waitq);
 		oldfb = fuse_inode_backing_set(fi, NULL);
 	}
-- 
2.51.0
