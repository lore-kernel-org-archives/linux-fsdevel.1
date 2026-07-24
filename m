Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19283E1692
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919979; cv=none; b=QqAvrd1ZNRobFejPHTPRXApYLkZK3Oa6T7sz9wvn3GN24x1KFE3W4ca7lqpGYLjByS6aYZNhDhiHfyZKx7odaPjqU6noAt4TUfSwW14vfDLJClXr/XNMkziNn8TlN4rdFSdif8UjxL0ErvwaQIugD5FmWpSld21Cms0VJCuJvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919979; c=relaxed/simple;
	bh=cxSPNPKfbfVo5sIfuCMIi76ixyVKBUfblErKUkNUoRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXLHHtTF1gUYrVYjS4Og5Ss2MJ4WreZ/OEpuF0xBfZ865N+3SCVPUgxXgriQTp5cUHACdM1AOuW2xDYceINjVhuLyaW0M0fdxfl3TcluDGn9N0QpRxdSwbV8YqlXalDo5kl3AlWdeR2euckEGoTDkJsN02RqqnVXdepIVTH7FBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lK5rUtpT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lK5rUtpT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784919974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLWUlVqO/BhurIMZ+FVynldiIeb9cHctDHQyRVxGl+A=;
	b=lK5rUtpTVJ1AiFl4Tzca0LsSq5EotggWyu/IoXQiFvgX446mEbhH+eHF+hw91jFIC56rvk
	OqnfZQd6kBwvZsUIC649iHC/cu2vTRUF7CTZa02RBtoJ2voSm/z2eCryJsm769V2SNnspQ
	BiV3kbjsLq/5m5x1Spx+bTONMd9VXmE=
From: Usama Arif <usama.arif@linux.dev>
To: phillip@squashfs.org.uk,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	boris@bur.io,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] squashfs: avoid thundering-herd cache wakeups
Date: Fri, 24 Jul 2026 12:05:56 -0700
Message-ID: <20260724190556.1950693-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

squashfs_cache_get() puts a task to sleep when its block is not cached and
every cache entry is busy.  Those sleeps are non-exclusive, so a single
squashfs_cache_put() makes every waiter runnable when one entry is freed.
A wakee returns to squashfs_cache_get() only if it observes cache->unused
before the entry is reclaimed.  Such tasks can rescan and share a block
published meanwhile; later wakees see zero and queue again inside
wait_event() without rescanning.

The waste is dramatic under load.  On a Meta production host serving a
Python web application from a packaged squashfs image, a 30-second trace
caught 1,045,132 cache-release wake calls and 19,511,556 remote wakeups:
18.7 per release, although each release added only one reusable cache
entry. This was causing significant spikes in CPU usage.

Simply making the waits exclusive (i.e. using
wait_event_state_exclusive()) is not enough.  A waiter can make
progress two ways, when an entry frees (capacity), or when another task
publishes the block it wants and it shares that entry.  The only wait
condition available is cache->unused, which captures capacity but not
publication, and wake-one can release just a single sharer at a time.  A
waiter woken for capacity may also find its block already published, share
it, and leave the freed entry unclaimed, so that wake must be handed on.
A block-targeted wake and that handoff need a custom wake callback with
per-waiter state; wait_event_state_exclusive() provides neither.

Wake selectively instead.  Waiters are exclusive and keyed by requested
block: freeing an entry wakes one waiter (capacity), publishing a block
wakes every waiter for that block (sharing), and a capacity waiter that
ends up sharing hands its wake to the next waiter.  Waiters enqueue while
holding cache->lock so lookup and publication are ordered against sleeping.

The result is an ~2x increase in throughput on stat and read.
Measured on a 32-CPU VM against a read-only squashfs (gzip, per-cpu
decompressor, default 8 metadata / 3 fragment cache entries) staged in tmpfs
with caches dropped each iteration to force cold decompression:

  elbencho, 64 threads
    metadata stat      700 ->  1320 files/s    1.9x
    small-file read     40 ->    60 MiB/s      1.6x

  filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
    throughput       11,314 -> 25,186 ops/s    2.2x
    latency           11.30 ->   5.05 ms/op    2.2x lower
    sched:sched_wakeup 9.18M ->  3.44M         2.7x fewer
    context switches  12.62M ->  5.77M         2.2x fewer

The 2.7x cut in scheduler wakeups explains the results: it roughly doubles
throughput and halves latency under contention, and is a no-op on
workloads that never queue for a cache entry.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/squashfs/cache.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 67abd4dff222..5c790c204a1a 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -45,6 +45,40 @@
 #include "squashfs.h"
 #include "page_actor.h"
 
+/*
+ * A NULL wake key selects one waiter for newly available capacity.  A block
+ * key selects every waiter which can share the newly published cache entry.
+ */
+struct squashfs_cache_wait {
+	wait_queue_entry_t wait;
+	u64 block;
+	bool capacity_wake;
+};
+
+static int squashfs_cache_wake_function(wait_queue_entry_t *wait,
+					unsigned int mode, int sync, void *key)
+{
+	struct squashfs_cache_wait *cache_wait =
+		container_of(wait, struct squashfs_cache_wait, wait);
+	u64 *block = key;
+	int ret;
+
+	if (block && cache_wait->block != *block)
+		return 0;
+
+	/* A failed wake remains queued, so finish_wait() sees the reset. */
+	WRITE_ONCE(cache_wait->capacity_wake, !block);
+	ret = autoremove_wake_function(wait, mode, sync, NULL);
+	if (!ret)
+		WRITE_ONCE(cache_wait->capacity_wake, false);
+	return ret;
+}
+
+static void squashfs_cache_wake_block(struct squashfs_cache *cache, u64 block)
+{
+	__wake_up(&cache->wait_queue, TASK_NORMAL, 0, &block);
+}
+
 /*
  * Look-up block in cache, and increment usage count.  If not in cache, read
  * and decompress it from disk.
@@ -54,6 +88,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 {
 	int i, n;
 	struct squashfs_cache_entry *entry;
+	struct squashfs_cache_wait wait = { .block = block };
+	bool consumed, pending, wake_block, wake_next;
 
 	spin_lock(&cache->lock);
 
@@ -72,9 +108,16 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 			 * go to sleep waiting for one to become available.
 			 */
 			if (cache->unused == 0) {
+				init_wait(&wait.wait);
+				wait.wait.func = squashfs_cache_wake_function;
 				cache->num_waiters++;
+				WRITE_ONCE(wait.capacity_wake, false);
+				/* Enqueue before dropping the lock to avoid missing publish. */
+				prepare_to_wait_exclusive(&cache->wait_queue,
+							  &wait.wait, TASK_UNINTERRUPTIBLE);
 				spin_unlock(&cache->lock);
-				wait_event(cache->wait_queue, cache->unused);
+				schedule();
+				finish_wait(&cache->wait_queue, &wait.wait);
 				spin_lock(&cache->lock);
 				cache->num_waiters--;
 				continue;
@@ -105,8 +148,12 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 			entry->pending = 1;
 			entry->num_waiters = 0;
 			entry->error = 0;
+			wake_block = cache->num_waiters;
 			spin_unlock(&cache->lock);
 
+			if (wake_block)
+				squashfs_cache_wake_block(cache, block);
+
 			entry->length = squashfs_read_data(sb, block, length,
 				&entry->next_index, entry->actor);
 
@@ -138,7 +185,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 		 * for reuse.
 		 */
 		entry = &cache->entry[i];
-		if (entry->refcount == 0)
+		consumed = entry->refcount == 0;
+		if (consumed)
 			cache->unused--;
 		entry->refcount++;
 
@@ -146,12 +194,18 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 		 * If the entry is currently being filled in by another process
 		 * go to sleep waiting for it to become available.
 		 */
-		if (entry->pending) {
+		pending = entry->pending;
+		if (pending)
 			entry->num_waiters++;
-			spin_unlock(&cache->lock);
+		/* Pass on capacity if this waiter shared rather than consumed it. */
+		wake_next = READ_ONCE(wait.capacity_wake) && !consumed &&
+			cache->unused && cache->num_waiters;
+		spin_unlock(&cache->lock);
+
+		if (wake_next)
+			wake_up(&cache->wait_queue);
+		if (pending)
 			wait_event(entry->wait_queue, !entry->pending);
-		} else
-			spin_unlock(&cache->lock);
 
 		goto out;
 	}
-- 
2.53.0-Meta

