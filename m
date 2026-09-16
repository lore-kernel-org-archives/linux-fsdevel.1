Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551A4D5967
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584670; cv=none; b=VngUj5W4/28zOuBvgaflt8q+VDR/xjAGrz5w8Bxbpf4cXDWVlFpR4E2HibhlVYa17S7T3Br1QWcN78pDQLE/KymLR62SI4ipmdv2EEtWJPa/zyDYYyAkrl+8eiGUU1ADlIZi3YGcc21L9fz5Ha95umBUoRSg9y5B1X4vImc1bkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584670; c=relaxed/simple;
	bh=xznn8Eigzxqh2YUs1dnzzR+SsY1TyJXqdEKmEHj8PvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbc+hsC7Veh0K95Utz1RDrPeB41tDhvK9h/oZxzUFnawEi1QiS+eC9hy0HD4u8CloGOl5vZdxsPn3s9pe87viv72KMJbDhfEbxoNYDXm0OZ6b9uRx0c3Q3j9H8qW1oQIYtgqRRxf8/btmX+TJ4JhFZjw7W+PgAP6KDGCT0lbCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHhF4j2C; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHhF4j2C"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so1065988a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789584657; x=1790189457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLP3dyu4kC5O+SeIQnqT31z28qemX4SrGMKRbJF3BQY=;
        b=VHhF4j2CFDzHWXh20RWtUGVId+Vj4gn1kpJsWCa27Wo5dOHg24e6QZD9t9/6nsftp+
         CcH/6+PJGEa11ehJJKkQaJLiW6U2wKTTyJbs2okI2tngahK7kHLmQ0PaW2pb86GRUG5B
         5RCsisv7vgmMvOjO85e8iawbesefXMq9hjrViOQMs2TGlB9xP7xo7MeGzHsdEr4kbZcF
         PGoChxlonwgPysI6NF1qzP4/k/lVhuLfqcdD7QU3Un7rdkujQyTuHXz4WAfMAKgL50yZ
         8sglivRWgIMi/UhhfhZRY3njw3JR8lKXuQQlrkdOyVUaNhICp7PO43Q9jsFPJYsIl5YI
         m+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584657; x=1790189457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLP3dyu4kC5O+SeIQnqT31z28qemX4SrGMKRbJF3BQY=;
        b=AuSmFVj/r0gbUhFWdJDYKML1/SAweNDtJBVjwbRLqnrAi0lBlYJUMyHlsHacuaavgd
         EmHNlmhX8i/CUsuwjaRO+51EHI7KkSDVKO1uDcXpL8H5NCvZv+q921++yEy6iMeLoKy6
         rrPE01flfakcakHqDbXVtNQWSydxjJwCh7y3BymdBtSTGgbf66hf2FhGFQNbW9Cg5ssN
         swU+LrErjktNVZ3qdI28bHnUkZ636IJrXBuPnTY5cXfBenZhQ2hP0CUfBRU2XthlS5pX
         8Dc2HgTiwqw76S7IdlaxDWnLBlkXZOSPWkqgVmkFB641QOZB167OuYRx1TsFWWf7ENoC
         FyPw==
X-Forwarded-Encrypted: i=1; AKwUvBx7S8MgNI0h8z+Qm7Gl1D94oJq34rraAYevksclxYB/4Rz1iDC+Sbgq4/qo91FbrxlKN7B9KzXehRIPlbC1@vger.kernel.org
X-Gm-Message-State: AFuF++lGWKkgAQUc4VADDy/JLOGWimzOhB8XAZHHW0igVDzedgk9yD2P
	7ED1vKOmZJ17nfaSaXBzBc5VXEjS9+AxrEmh34hwjhNip54PjXNWBIiy
X-Gm-Gg: AYBFou1XWw5ySEQdenShbbEyAMzhTFPYGSoQAD8908t6TF/ytGfQBLDsMamR4gGVDIy
	ahlFpKOc0OrHZwpIWVErsSGgBkHbKDnH4rZDJsed116M8ZvlGYNmk5JpuWWXbcQY5TN57NYr3xr
	ELUxsNY4RKLb5noFzKJZT7bqWMVlKhYA3fe400/wuUjQ6+OkH2T8PIONiiLrTNY2+nb1BHQbaZZ
	0t196Pc+HnHx/msruCyoT/LR2XltkutAUJqtoEcV46yObWjOtNfyATe+uUt18Fmf7lcEKaU68cj
	kGSzAF840wLKM7LmK+9uxzqEb7Qx0BqZFFTrUj6LwF0dvsiBRbadPYewsnpSibKWK9xQJnopuBf
	5/fOIFQDrKxlAk0dxy4Dw55Y+E9bYOgOJ2q6EmD3mjwvA96EglgGZNhSy4akxETMegbpMBKg3I3
	v7cTK7ExMmwKx9kdxu6MzkHmYGapB0v8mat9/oLE5EenCxgkV2qdxOvqJHNkEmJNI5yTykLZUJP
	Y5kLfhn2avuA7bIqNJ6T+kbKgvY6e2e9SrXSPxI+mlRe5SEuWJ95vpAX5HS9UGDr5o9/yjKo04Q
	yFYrOinW8EzjPHj7NCmMSbr3NQ==
X-Received: by 2002:a17:90b:3b91:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e1e2bf7a7mr9787120a91.6.1789584657245;
        Wed, 16 Sep 2026 11:50:57 -0700 (PDT)
Received: from DESKTOP-TJS95SS.tail460ce2.ts.net (36-232-230-153.dynamic-ip.hinet.net. [36.232.230.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35b6a350sm879890a91.0.2026.09.16.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:50:56 -0700 (PDT)
From: Yuan-Hao Hsu <aa9736195201@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/readahead: use large folios in page_cache_ra_unbounded()
Date: Thu, 17 Sep 2026 02:50:52 +0800
Message-ID: <20260916185052.489-1-aa9736195201@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915135909.1007-1-aa9736195201@gmail.com>
References: <20260915135909.1007-1-aa9736195201@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forced readahead still allocates one folio per page.  Everything that
reaches page_cache_ra_unbounded() gets mapping_min_folio_order()
folios, which is order 0 unless the block size is larger than the page
size:

 - fadvise(POSIX_FADV_WILLNEED), readahead(2) and madvise(MADV_WILLNEED)
   on a file mapping, through force_page_cache_ra()
 - every read() on a file after fadvise(POSIX_FADV_RANDOM), and every
   read() when ra_pages is 0, through the do_forced_ra path of
   page_cache_sync_ra()
 - the "standalone, small random read" path of page_cache_sync_ra()
 - the merkle tree readahead of generic_readahead_merkle_tree()
 - the rest of the window when page_cache_ra_order() falls back

Both the ramp-up path (page_cache_ra_order()) and the write path
(__filemap_get_folio()) allocate the largest folio that fits the range
and its alignment.  The same 1 GiB file read sequentially ends up 97%
in order-9 folios; read after POSIX_FADV_RANDOM it is 262,144 order-0
folios.  RocksDB (PosixRandomAccessFile::Hint(kRandom), ::Prefetch()),
WiredTiger (WT_FS_OPEN_ACCESS_RAND) and MappedByteBuffer.load() in the
JDK all take these paths.

Every mapping whose mapping_max_folio_order() is above the minimum is
affected: ext4 (without the encrypt feature or data=journal), xfs,
btrfs (without HIGHMEM), erofs, nfs, afs, cifs, zonefs, f2fs (immutable
files) and the block device page cache, and through them overlayfs.
tmpfs sets the flag but cannot get here: force_page_cache_ra() returns
when the a_ops have neither read_folio nor readahead, generic_fadvise()
ignores every hint on a noop bdi and madvise(MADV_WILLNEED) takes
shmem_swapin_range().  Nothing changes with CONFIG_TRANSPARENT_HUGEPAGE=n.

Allocate the largest folio that fits instead, in three steps.

Scan the xarray first and size the folio to the run of absent indices
in front of the index (shadow entries count as absent), bounded by the
mapping's maximum order, by what is left of the request and by the
alignment of the index, never below the minimum order.  Nothing beyond
the request is read; for a forced read the request is exactly what the
caller asked for.  filemap_add_folio() then only returns -EEXIST when
another reader added a folio between the scan and the insert, and the
loop scans again.

Allocate a folio above the minimum order without __GFP_RECLAIM: it is
taken when the free lists have one, and nothing is reclaimed,
compacted or woken up to make one.  The minimum order allocation keeps
the full readahead_gfp_mask() as before.

If that fails, read the rest of the request with the minimum order, as
page_cache_ra_order() falls back too, so a request costs at most one
failed free list lookup more than it does today.

ra_alloc_folio() already does the allocation, the PG_readahead mark
and the accounting for page_cache_ra_order(); move it up unchanged and
use it here too, so the mark goes on the folio that contains the mark
index in both places.

1 GiB file on ext4, cold cache, x86-64 4K pages, medians of 15 runs:

                                          folios      minor faults to
                                     before  after   mmap it afterwards
  readahead(2), 2 MiB at a time     262,144    512    16,384 ->    512
  POSIX_FADV_RANDOM, 1 MiB pread()  262,144  1,024    16,384 ->  1,024
  2000 random 256 KiB pread()       105,996  9,346     6,671 ->  2,055
  madvise(MADV_WILLNEED), 8 MiB       2,048      4       128 ->      4
  sequential read() (unchanged)       1,433  1,433       761 ->    761

The same on xfs, erofs, cifs and a block device; btrfs, whose maximum
order is 6, ends up with 4,096 folios for the 1 GiB, NFS over loopback
with 1,024, zonefs on a zoned null_blk (128 KiB bdi readahead) with
8,192.  read() and mmap() of each of them match the O_DIRECT sha256 of
the file.

Memory fragmented so that no free block above order 3 is left, with the
kept pages pinned so that compaction cannot help, same file on a RAM
disk, POSIX_FADV_RANDOM 1 MiB pread() over the 1 GiB, per run:

                              before    after     v1 of this patch
  sys ms                         219      239            1,462
  compact_stall                    0        0            2,437
  pgsteal_kswapd (pages)           0        0          234,494
  pswpout (pages)                  0        0           23,759
  folios left in the cache   262,144  260,869           36,508

The 20 ms are the failed free list lookup per request.  v1 allocated
with the full gfp mask and stepped down one order at a time; it also
made a plain sequential read() 3.6 times slower on that memory through
the page_cache_ra_order() fallback.

Four processes reading the same cold file after POSIX_FADV_RANDOM,
64 KiB at a time: filemap_add_folio() fails with -EEXIST 7,754 times
before (one page each), 59,783 times with v1 and 15,828 times now,
which is the race itself; the loser scans again and skips.

ext4 on a loop device over tmpfs, so that cold reads cost CPU only:

  fio psync randread bs=256k fadvise_hint=random:
        2,226 -> 2,753 MB/s, sys 57.0% -> 45.7%
  fio psync randread bs=64k fadvise_hint=random:
        1,219 -> 1,384 MB/s, sys 49.4% -> 44.1%
  4 processes reading the same file with POSIX_FADV_RANDOM, 64 KiB:
        6.8 s -> 1.1 s total, 459 -> 123 ms sys per process
  20000 random 4 KiB pread() (order stays 0):
        592 -> 585 ms wall, 233 -> 230 ms sys

fs-verity on ext4 (300 MiB file, drop_caches, read, mmap, WILLNEED,
FADV_RANDOM) verifies with merkle tree folios of order 0 to 3; f2fs
immutable, compressed and verity files verify as before.

Link: https://lore.kernel.org/r/aS4K3jGkJErj94R_@casper.infradead.org
Link: https://lore.kernel.org/r/aS9uod21hG_qq7Rd@casper.infradead.org
Link: https://lore.kernel.org/r/20260915172615.c183c61c774f529ca57f1fb5@linux-foundation.org
Assisted-by: LLM sparse
Signed-off-by: Yuan-Hao Hsu <aa9736195201@gmail.com>
---
v1 -> v2, after Andrew's questions
(https://lore.kernel.org/r/20260915172615.c183c61c774f529ca57f1fb5@linux-foundation.org):
 - scan the xarray before allocating and size the folio to the run of
   absent indices, so filemap_add_folio() fails with -EEXIST only on a
   race with another reader; rescan instead of trying smaller orders
 - allocate above the minimum order without __GFP_RECLAIM: never
   reclaim, compact or wake kswapd for a large readahead folio; on
   failure read the rest of the request with the minimum order
 - list every filesystem whose mapping can reach this path, and test
   xfs, btrfs, erofs, a block device, NFS, cifs and zonefs in addition
   to ext4/f2fs
 - numbers on fragmented memory, and the -EEXIST counts, in the log

 mm/readahead.c | 167 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 114 insertions(+), 53 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290287..b1e0d963f2b0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -204,6 +204,74 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 	return folio;
 }
 
+static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
+
+	if (!folio)
+		return -ENOMEM;
+	mark = round_down(mark, 1UL << order);
+	if (index == mark)
+		folio_set_readahead(folio);
+	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
+	if (err) {
+		folio_put(folio);
+		return err;
+	}
+
+	ractl->_nr_pages += 1UL << order;
+	ractl->_workingset |= folio_test_workingset(folio);
+	return 0;
+}
+
+/*
+ * How many pages starting at @index are absent from the page cache, at
+ * most @max.  Shadow entries count as absent; filemap_add_folio() replaces
+ * them.  The caller holds invalidate_lock shared, which keeps truncation
+ * out but not other readers: a folio can still be added behind this scan,
+ * and filemap_add_folio() then fails with -EEXIST.
+ */
+static unsigned long ra_absent_pages(struct address_space *mapping,
+				     pgoff_t index, unsigned long max)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned long absent = max;
+	void *entry;
+
+	rcu_read_lock();
+	xas_for_each(&xas, entry, index + max - 1) {
+		if (xas_retry(&xas, entry))
+			continue;
+		if (!xa_is_value(entry)) {
+			absent = xas.xa_index - index;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return absent;
+}
+
+/*
+ * The largest folio that fits at @index: it must be naturally aligned
+ * and must not extend past the @absent pages in front of it, which are
+ * bounded by what is left of the request.  Nothing beyond the request is
+ * read; for a forced read (WILLNEED, readahead(2), FMODE_RANDOM) the
+ * request is all the caller asked for.  This is the policy
+ * page_cache_ra_order() and __filemap_get_folio() already use.
+ */
+static unsigned int ra_unbounded_order(pgoff_t index, unsigned long absent,
+				       unsigned int min_order,
+				       unsigned int max_order)
+{
+	unsigned int order = min_t(unsigned int, max_order, ilog2(absent));
+
+	if (index)
+		order = min_t(unsigned int, order, __ffs(index));
+	return max(order, min_order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -215,6 +283,9 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
  * not the function you want to call.  Use page_cache_async_readahead()
  * or page_cache_sync_readahead() instead.
  *
+ * Folios as large as the mapping allows are used, but the request is
+ * not extended to fit them.
+ *
  * Context: File is referenced by caller, and ractl->mapping->invalidate_lock
  * must be held by the caller at least in shared mode.  Mutexes may be held by
  * caller.  May sleep, but will not reenter filesystem to reclaim memory.
@@ -227,6 +298,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long mark = ULONG_MAX, i = 0;
 	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int max_order = mapping_max_folio_order(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -247,19 +320,13 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	index = mapping_align_index(mapping, index);
 
 	/*
-	 * As iterator `i` is aligned to min_nrpages, round_up the
-	 * difference between nr_to_read and lookahead_size to mark the
-	 * index that only has lookahead or "async_region" to set the
-	 * readahead flag.
+	 * Folios start at multiples of min_nrpages, so round_up the
+	 * index that only has lookahead or "async_region" to mark the
+	 * folio that gets the readahead flag.
 	 */
-	if (lookahead_size <= nr_to_read) {
-		unsigned long ra_folio_index;
-
-		ra_folio_index = round_up(readahead_index(ractl) +
-					  nr_to_read - lookahead_size,
-					  min_nrpages);
-		mark = ra_folio_index - index;
-	}
+	if (lookahead_size <= nr_to_read)
+		mark = round_up(readahead_index(ractl) + nr_to_read -
+				lookahead_size, min_nrpages);
 	nr_to_read += readahead_index(ractl) - index;
 	ractl->_index = index;
 
@@ -267,10 +334,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * Preallocate as many pages as we will need.
 	 */
 	while (i < nr_to_read) {
-		struct folio *folio = xa_load(&mapping->i_pages, index + i);
+		unsigned long absent = ra_absent_pages(mapping, index + i,
+						       nr_to_read - i);
+		unsigned int order;
 		int ret;
 
-		if (folio && !xa_is_value(folio)) {
+		if (!absent) {
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -285,26 +354,40 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = ractl_alloc_folio(ractl, gfp_mask,
-					mapping_min_folio_order(mapping));
-		if (!folio)
+		order = ra_unbounded_order(index + i, absent, min_order,
+					   max_order);
+		/*
+		 * A folio larger than the minimum is taken only if one is
+		 * free right now: nothing is reclaimed, compacted or woken
+		 * to make one, so on fragmented memory this costs no more
+		 * than the failed freelist lookup.
+		 */
+		ret = ra_alloc_folio(ractl, index + i, mark, order,
+				     order > min_order ?
+				     gfp_mask & ~__GFP_RECLAIM : gfp_mask);
+		if (ret == -ENOMEM && order > min_order) {
+			/*
+			 * No free folio of that size, or the memcg would not
+			 * take it without reclaim.  Do not ask again during
+			 * this request; the rest is read with the smallest
+			 * folios, which is what page_cache_ra_order() falls
+			 * back to as well.
+			 */
+			max_order = min_order;
+			order = min_order;
+			ret = ra_alloc_folio(ractl, index + i, mark, order,
+					     gfp_mask);
+		}
+		if (ret == -ENOMEM)
 			break;
-
-		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
-		if (ret < 0) {
-			folio_put(folio);
-			if (ret == -ENOMEM)
-				break;
-			read_pages(ractl);
-			ractl->_index += min_nrpages;
-			i = ractl->_index - index;
+		if (ret == -EEXIST) {
+			/*
+			 * A folio was added within the range after the scan
+			 * above; look again at what is left in front of it.
+			 */
 			continue;
 		}
-		if (i == mark)
-			folio_set_readahead(folio);
-		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages += min_nrpages;
-		i += min_nrpages;
+		i += 1UL << order;
 	}
 
 	/*
@@ -456,28 +539,6 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
  * it approaches max_readahead.
  */
 
-static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
-		pgoff_t mark, unsigned int order, gfp_t gfp)
-{
-	int err;
-	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
-
-	if (!folio)
-		return -ENOMEM;
-	mark = round_down(mark, 1UL << order);
-	if (index == mark)
-		folio_set_readahead(folio);
-	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
-	if (err) {
-		folio_put(folio);
-		return err;
-	}
-
-	ractl->_nr_pages += 1UL << order;
-	ractl->_workingset |= folio_test_workingset(folio);
-	return 0;
-}
-
 void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra)
 {

base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf
-- 
2.43.0

