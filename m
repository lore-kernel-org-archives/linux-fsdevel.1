Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF04A2A42
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480757; cv=none; b=eGBfq7WlF8ZjGvcP2xrWL0cdP1TvKRH0T8NmzG9J9kroPZK+j6oliEnDOtSKOWT5xa9vPCj08kqotBT9JAU5OA5EKv2ufx8Pvib5Hef8H2cJel2xZ4yJT79bWa0EG20zBKO/mhVnK4t7JE3jMqVGG6p9Vyuum1QGHrqztB0i2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480757; c=relaxed/simple;
	bh=VccP23xYPWhOACpU8So4rSoHxSYpZHeJZu88MLLsMz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXXJE5G5ynhLQJ+KQqvjOd3jc8OpOwSD1otO2pAaK8bZDU+Bla/pOu3mn7kDLjdMtJ3JNx1ExILtZdfXYDuorjM7T9JouggXiFcyLTuYPqix9L9pxTDWJ0HvrXxSRIOKIZ1NDUHQbPMiJo+M40iFO2gQWHuURN5Seb8ngp+MzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVjaXmr7; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVjaXmr7"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so37537625ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789480755; x=1790085555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xt1pn2hZDDCJHs47h/vFTcvzZQctrx3Ka/dgj8KHcQs=;
        b=AVjaXmr7c7L4zitbfsQXjjAidBJKjIfen/CDd39AgIL0g6hbxzDdN1HMtU020eijVR
         56qCzRBB0JhMjM7isGh8p7b/KpuZdIc3eMi+2/2Fsgd2hA2w4hGw5hkX/rTq3FFJfXoT
         o0hNO8jTySc+Um6UHovuDTpsOSpRtMwE26KvTjquGr4SOHsmFFFrKcgqalaz9gwWV/zA
         cRknBQXP9n7k9hrfCE+BsqD+9fR9WopHaRY/yi4uz15yvtqKTibTh1h53FuZEQhMWgsl
         NcvOFbL27wunkMQaDzzK+YS8QA723UnBu9bHIne/bCOYcZdaMiiaGNgTBWJ8CcGhAu+A
         gjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480755; x=1790085555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xt1pn2hZDDCJHs47h/vFTcvzZQctrx3Ka/dgj8KHcQs=;
        b=GX36sHmZSgsd4ALqkgavTyzsfvF8f1QW2GJvPh+KHH/YBTl4vFWgZkiiFxJewFlP2Q
         5yDWQn5DvBfZCGlAuyL8LW77zlorS6GfyPbX1uOYa8w1SUwsrHKjykzSlM8UXPD6qYSP
         r1pegj4meWw5JJN7XVH9P+sUG6tAWIyEf7Rxyn5+r1uze3+uRnrAWOJCARa/WeZF9SLf
         zN+NhkZjJMN5MN/X7khJsP+BFdY0rngNk2NqLTE/w29ucUZ7l5cst7BqZ85bA7gZZ/g2
         8NNTvTOBO28vRP5ZUcG8elf4pa5njuUM16BEX9Iks//iR6NRbIWXWFaQvDknE2XY9G78
         t7rg==
X-Forwarded-Encrypted: i=1; AKwUvByI4b0Mdo+0jJnog09zRi2GcF281V09+2jG1p/VUL0HTURT30JnjmJf01WwMzAKC2kUBXgcjhzzpphoiHod@vger.kernel.org
X-Gm-Message-State: AFuF++kmqhoCS4pnXDfqLwB+Rs0J14VFYGfF7pgAd8fqF0vJkht+MMm2
	214PZfOyHSZg7kWgSakjJe7mtHe4fFoGm/hiRg7RMqxttxrAwy/6QzFU
X-Gm-Gg: AYBFou08SJU/hBzW/SPGYkaVmHWdtSY5vzv8KsDad7sgkox+y7PuWiS3MaUmS4LUw8v
	QcSyFL3RFUv1yPC8TYaJ8ycYAxLszgiYDfpb8zqIxYRgcn8yzV1xZcIPF+UwDWyXtAFCJdY0+Ij
	y7RuKcv533/7AomIWtHTwzhsqW1CE/XkUS/9MD6PJocN6JUwSfD4Nb2bpKrDQfEiHhDlM7R4JTk
	eg5gQIgyHwxY9nBovAjCf+BXXk7Q9OG6xW+i+VUozacJrn6f5pFg4qj5V/5YI7aie1N70imUxTC
	4cq0BgvcNh/K8c/w6A9hH9MOQ9TsE2hSaYtYroirISSblrVTKH47oQYXhbP1acaqD3bCQGRdEv1
	oqDsuH8vGHy0S0xPvRAL1NaPR4z9np+eBANkQxKPwxvReMDReFJf6fP97T9G6jePfgBf6/gxChh
	oK7JrIWutnbXGApoJify/Rzl33FKgTp400tuibjWrmzEEH4BJ/ye165KlQDcg/a3oO8PRuwmGNK
	ERzV7xQSNoIvbRJEDxrns+5zam+zJd+pPHT0HJ/XsU0fuBVOdBftU3RTivx8BoSSg3nqKhAeNka
	p3jqKxTE4ksfF4z1peARvViyOA==
X-Received: by 2002:a17:902:db0a:b0:2dc:fdde:30c5 with SMTP id d9443c01a7336-2dd6c73459fmr139178655ad.17.1789480754318;
        Tue, 15 Sep 2026 06:59:14 -0700 (PDT)
Received: from DESKTOP-TJS95SS.tail460ce2.ts.net (36-232-230-153.dynamic-ip.hinet.net. [36.232.230.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd34c7f976sm65270435ad.81.2026.09.15.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:59:13 -0700 (PDT)
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
Subject: [PATCH] mm/readahead: use large folios in page_cache_ra_unbounded()
Date: Tue, 15 Sep 2026 21:59:09 +0800
Message-ID: <20260915135909.1007-1-aa9736195201@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forced readahead still allocates one folio per page.  Everything that
reaches page_cache_ra_unbounded() gets mapping_min_folio_order()
folios, which is order 0 on ext4, xfs and btrfs:

 - fadvise(POSIX_FADV_WILLNEED), readahead(2) and madvise(MADV_WILLNEED)
   on a file mapping, through force_page_cache_ra()
 - every read() on a file after fadvise(POSIX_FADV_RANDOM), and every
   read() when ra_pages is 0, through the do_forced_ra path of
   page_cache_sync_ra()
 - the "standalone, small random read" path of page_cache_sync_ra()
 - the merkle tree readahead of generic_readahead_merkle_tree()

Both the ramp-up path (page_cache_ra_order()) and the write path
(__filemap_get_folio()) allocate the largest folio that fits the range
and its alignment.  The same 1 GiB file read sequentially ends up 97%
in order-9 folios; read after POSIX_FADV_RANDOM it is 262,144 order-0
folios.  RocksDB (PosixRandomAccessFile::Hint(kRandom), ::Prefetch()),
WiredTiger (WT_FS_OPEN_ACCESS_RAND) and MappedByteBuffer.load() in the
JDK all take these paths.

Allocate the largest folio that fits instead: bounded by the mapping's
maximum order, by what is left of the request and by the alignment of
the index, never below the minimum order.  Nothing beyond the request is
read; for a forced read the request is exactly what the caller asked
for.  If an allocation fails, or filemap_add_folio() returns -ENOMEM,
do not ask for that order again during this request.  If
filemap_add_folio() returns -EEXIST for a large folio, something sits
within the range it would cover but the index itself may still be free,
so retry with a smaller folio and only skip the index once the minimum
size collides, as before.  ra_alloc_folio() already does the
allocation, the PG_readahead mark and the accounting for
page_cache_ra_order(); move it up unchanged and use it here too, so
the mark goes on the folio that contains the mark index in both
places.

1 GiB file on ext4, cold cache, x86-64 4K pages, medians of 15 runs:

                                          folios      minor faults to
                                     before  after   mmap it afterwards
  readahead(2), 2 MiB at a time     262,144    512    16,384 ->    512
  POSIX_FADV_RANDOM, 1 MiB pread()  262,144  1,024    16,384 ->  1,024
  2000 random 256 KiB pread()       105,996  9,346     6,671 ->  2,055
  madvise(MADV_WILLNEED), 8 MiB       2,048      4       128 ->      4
  sequential read() (unchanged)       1,433  1,433       761 ->    761

ext4 on a loop device over tmpfs, so that cold reads cost CPU only:

  fio psync randread bs=256k fadvise_hint=random:
        2,142 -> 2,977 MB/s, sys 57.0% -> 48.2%
  fio psync randread bs=64k fadvise_hint=random:
        1,051 -> 1,434 MB/s, sys 50.9% -> 45.1%
  4 processes reading the same file with POSIX_FADV_RANDOM, 64 KiB:
        6.9 s -> 1.1 s total, 552 -> 121 ms sys per process
  20000 random 4 KiB pread() (order stays 0):
        665 -> 580 ms

A warm read() of the 1 GiB file costs 92.5 ms when the cache was filled
through POSIX_FADV_RANDOM and 82.8 ms when it was filled by a sequential
read; after this patch both are 77-80 ms.

fs-verity on ext4 (300 MiB file, drop_caches, read, mmap, WILLNEED,
FADV_RANDOM) verifies with merkle tree folios of order 0 to 3.  No
change with CONFIG_TRANSPARENT_HUGEPAGE=n, where
mapping_max_folio_order() is 0.

Link: https://lore.kernel.org/r/aS4K3jGkJErj94R_@casper.infradead.org
Link: https://lore.kernel.org/r/aS9uod21hG_qq7Rd@casper.infradead.org
Assisted-by: LLM sparse
Signed-off-by: Yuan-Hao Hsu <aa9736195201@gmail.com>
---
 mm/readahead.c | 123 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 48 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290287..d9ad081c72fd 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -204,6 +204,47 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
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
+ * The largest folio that fits at @index: it must be naturally aligned
+ * and must not extend past the @remaining pages left of the request.
+ * Nothing beyond the request is read; for a forced read (WILLNEED,
+ * readahead(2), FMODE_RANDOM) the request is all the caller asked for.
+ * This is the policy page_cache_ra_order() and __filemap_get_folio()
+ * already use.
+ */
+static unsigned int ra_unbounded_order(pgoff_t index, unsigned long remaining,
+				       unsigned int min_order,
+				       unsigned int max_order)
+{
+	unsigned int order = min_t(unsigned int, max_order, ilog2(remaining));
+
+	if (index)
+		order = min_t(unsigned int, order, __ffs(index));
+	return max(order, min_order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -215,6 +256,9 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
  * not the function you want to call.  Use page_cache_async_readahead()
  * or page_cache_sync_readahead() instead.
  *
+ * Folios as large as the mapping allows are used, but the request is
+ * not extended to fit them.
+ *
  * Context: File is referenced by caller, and ractl->mapping->invalidate_lock
  * must be held by the caller at least in shared mode.  Mutexes may be held by
  * caller.  May sleep, but will not reenter filesystem to reclaim memory.
@@ -227,6 +271,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long mark = ULONG_MAX, i = 0;
 	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int max_order = mapping_max_folio_order(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -247,19 +293,13 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
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
 
@@ -268,6 +308,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	while (i < nr_to_read) {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
+		unsigned int order;
 		int ret;
 
 		if (folio && !xa_is_value(folio)) {
@@ -285,26 +326,34 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = ractl_alloc_folio(ractl, gfp_mask,
-					mapping_min_folio_order(mapping));
-		if (!folio)
-			break;
-
-		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
-		if (ret < 0) {
-			folio_put(folio);
-			if (ret == -ENOMEM)
+		order = ra_unbounded_order(index + i, nr_to_read - i,
+					   min_order, max_order);
+		for (;;) {
+			ret = ra_alloc_folio(ractl, index + i, mark, order,
+					     gfp_mask);
+			if (!ret || order == min_order)
 				break;
+			/*
+			 * -ENOMEM: memory is too fragmented for a folio this
+			 * large, or the memcg would not take it; don't ask
+			 * for that order again during this request.
+			 * -EEXIST: something already sits within the range
+			 * this folio would cover, but the index itself may
+			 * still be free in front of it.
+			 */
+			if (ret == -ENOMEM)
+				max_order = order - 1;
+			order--;
+		}
+		if (ret == -ENOMEM)
+			break;
+		if (ret) {
 			read_pages(ractl);
 			ractl->_index += min_nrpages;
 			i = ractl->_index - index;
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
@@ -456,28 +505,6 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
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

