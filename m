Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AF274641
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123498; cv=none; b=qnmZhPLNtPyyBc+qc5giL9OL0K+EWK8nsi84nqZ7XHwdaWNPhlh3lWZK0jbbYlevbAozXeJ+c7tcauRStogHfMi+PTvhvKCZda+/CR997utMe9J9oJIpJ2JMdRkWQ0lTqydJvPEdPKos+9cQ2EWh0IQjTCQA1BIoQDdF+VoVd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123498; c=relaxed/simple;
	bh=Jj49RGonKfKkIbjj6px5p7zgqvPW27nT+WqzePVzlI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCtaRLydJOnC2ZfUJfCl7i7iqMV75eOA/i5ptN8RXEQhmZJiyJW8PEFVTR28WwQkgR67Fd11Eb8FzeFwrirDrTd1MVKW3FRqX6W4pp9JeB9rI6LSjlK1jnZJIrxkeLbCpqKGyYtUzmDHYAU3D8wO5eSn6dqXsFN6C0vaKVmK2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qk6NvDmb; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qk6NvDmb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786123484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BWnzMf6xGuoD0NoS6VmrxxD/V8Uqk169RaEPge3lLy0=;
	b=Qk6NvDmbYPumIhs6gbL0GY+maaVhT3AyY/bxyOq9XPuyk1QkJ2rlV3MxIMCZ7B5mkxUi4s
	iDPOxiU6TtV0xQEzcdj9Ao6Kxrue82MY9Wrk3JikiYnPi27eRse6+eAbbk8badilwTpf3K
	xy/JUf69qLN7f3kXRax44Ck+Qgxbf5w=
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
Subject: [PATCH v2] squashfs: avoid thundering-herd cache wakeups
Date: Fri,  7 Aug 2026 10:24:21 -0700
Message-ID: <20260807172421.3875982-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

squashfs_cache_get() puts a task to sleep when its block is not cached
and every cache entry is busy.  Those sleeps are non-exclusive, so the
nr_exclusive == 1 budget squashfs_cache_put() has always passed to
wake_up() is inert and one release makes every waiter runnable.  A wakee
only returns to squashfs_cache_get() if it observes cache->unused before
the entry is reclaimed; later wakees see zero and re-queue inside
wait_event() without rescanning.  One freed entry satisfies exactly one
capacity waiter, so waking the rest is waste.

On a Meta production host serving a Python web application from a
packaged squashfs image, a 30-second trace caught 1,045,132
cache-release wake calls and 19,511,556 wakeups: 18.7 per release,
although each release added only one reusable cache entry.  This was
causing significant spikes in CPU usage.

Make the waits exclusive, enqueueing while still holding cache->lock so
that a concurrent lookup either sees the waiter queued or the waiter
sees the block that lookup publishes.  Two things follow.

A wakee cannot be assumed to consume the entry it was woken for: it may
find its own block published meanwhile, share that entry, and leave the
freed one unclaimed.  So a wakee which shares hands its wakeup on to the
next waiter, as commit 0ddad21d3e99 ("pipe: use exclusive waits when
reading or writing") does with wake_next_reader.

And a waiter can now sleep through a publication of the very block it
wants, which the old broadcast gave it repeated chances to notice.  So
waiters are keyed by block: publishing wakes every waiter for that block
(nr_exclusive == 0), freeing an entry wakes one.  That needs a custom
wake callback, like wake_page_function() in mm/filemap.c, which also
records which wakeup arrived so the handoff only fires for a capacity
wakee.

Broadcast is kept where more than one task can proceed - every waiter
for a published block, and the wake_up_all() on entry->wait_queue - at
the cost of walking the queue under wait_queue.lock to test the key.
Waiters are now served FIFO with a scheduling round trip per handoff
hop, so per-waiter latency changes; the filebench run below is 4x
oversubscribed, where that should hurt most.

Measured on a 32-CPU VM against a read-only squashfs (gzip,
DECOMP_MULTI_PERCPU, FILE_DIRECT, default 8 metadata / 3 fragment cache
entries) staged in tmpfs, page cache dropped each iteration to force
cold decompression:

  elbencho, 64 threads
    metadata stat        700 ->  1320 files/s    1.9x
    small-file read       40 ->    60 MiB/s      1.5x

  filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
    throughput        11,314 -> 25,186 ops/s     2.2x
    sched:sched_wakeup  27.0 ->   4.55 per op    5.9x fewer
    context switches    37.2 ->   7.64 per op    4.9x fewer

Wakeups and context switches are per operation, since the two runs did
2.2x different amounts of work.  Workloads which never queue for a cache
entry gain no wakeups.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/squashfs/cache.c          | 114 +++++++++++++++++++++++++++++++++--
 fs/squashfs/squashfs_fs_sb.h |   9 +++
 2 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 67abd4dff2222..1a95e9cbbc5a8 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -45,19 +45,82 @@
 #include "squashfs.h"
 #include "page_actor.h"
 
+/*
+ * Waiters on cache->wait_queue are keyed by the block they want, so a wakeup
+ * can name who it is for.  A NULL key is a capacity wakeup: one entry became
+ * free, so wake one waiter.  A block key is a publication wakeup: that block
+ * now has an entry, so wake every waiter which can share it.
+ */
+struct squashfs_cache_wait {
+	wait_queue_entry_t	wait;
+	u64			block;
+	bool			capacity_wake;
+};
+
+static int squashfs_cache_wake_function(wait_queue_entry_t *wait,
+					unsigned int mode, int sync, void *key)
+{
+	struct squashfs_cache_wait *cache_wait =
+		container_of(wait, struct squashfs_cache_wait, wait);
+	u64 *block = key;
+
+	if (block && cache_wait->block != *block)
+		return 0;
+
+	WRITE_ONCE(cache_wait->capacity_wake, !block);
+
+	/*
+	 * Wake and unlink unconditionally instead of using
+	 * autoremove_wake_function(), which unlinks only when it changed the
+	 * task state.  A waiter can be made runnable by something which does
+	 * not go through this queue: wake_up_process() takes TASK_NORMAL, and
+	 * a cgroup v2 thaw calls it on every task in the cgroup, as do
+	 * free_pid() on a pid namespace init and a late rcuwait_wake_up().
+	 * try_to_wake_up() then fails.  Leaving such a waiter queued with a
+	 * reason already recorded would let it act on a freed entry it was not
+	 * given, and the failure would not consume the exclusive budget, so a
+	 * second waiter would be woken for the same entry.
+	 *
+	 * list_del_init_careful() must be the last access to @cache_wait: it
+	 * releases the waiter, whose wait structure lives on its stack, and it
+	 * pairs with list_empty_careful() in finish_wait() to publish the
+	 * store above.  __wake_up_common() samples ->flags and the next entry
+	 * before calling here, so it does not touch @wait afterwards either.
+	 */
+	default_wake_function(wait, mode, sync, key);
+	list_del_init_careful(&wait->entry);
+
+	return 1;
+}
+
+static void squashfs_cache_wake_block(struct squashfs_cache *cache, u64 block)
+{
+	/* nr_exclusive == 0: wake every waiter which matches the key. */
+	__wake_up(&cache->wait_queue, TASK_NORMAL, 0, &block);
+}
+
 /*
  * Look-up block in cache, and increment usage count.  If not in cache, read
  * and decompress it from disk.
+ *
+ * A caller which finds no free entry sleeps on cache->wait_queue as an
+ * exclusive waiter, so squashfs_cache_put() releasing one entry wakes exactly
+ * one task.  Because a wakee may find its block published in the meantime and
+ * share that entry rather than claim the free one, a wakee which shares hands
+ * its wakeup on to the next waiter.
  */
 struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 	struct squashfs_cache *cache, u64 block, int length)
 {
 	int i, n;
 	struct squashfs_cache_entry *entry;
+	bool capacity_wake = false;
 
 	spin_lock(&cache->lock);
 
 	while (1) {
+		bool pending, wake_next, wake_block;
+
 		for (i = cache->curr_blk, n = 0; n < cache->entries; n++) {
 			if (cache->entry[i].block == block) {
 				cache->curr_blk = i;
@@ -72,9 +135,25 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 			 * go to sleep waiting for one to become available.
 			 */
 			if (cache->unused == 0) {
+				struct squashfs_cache_wait wait = {
+					.block		= block,
+					.capacity_wake	= false,
+				};
+
+				init_wait_func(&wait.wait,
+					       squashfs_cache_wake_function);
 				cache->num_waiters++;
+				/*
+				 * Enqueue while still holding cache->lock, so
+				 * that a concurrent lookup either sees us
+				 * queued or we see the block it publishes.
+				 */
+				prepare_to_wait_exclusive(&cache->wait_queue,
+						&wait.wait, TASK_UNINTERRUPTIBLE);
 				spin_unlock(&cache->lock);
-				wait_event(cache->wait_queue, cache->unused);
+				schedule();
+				finish_wait(&cache->wait_queue, &wait.wait);
+				capacity_wake = READ_ONCE(wait.capacity_wake);
 				spin_lock(&cache->lock);
 				cache->num_waiters--;
 				continue;
@@ -105,8 +184,18 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 			entry->pending = 1;
 			entry->num_waiters = 0;
 			entry->error = 0;
+			wake_block = cache->num_waiters > 0;
 			spin_unlock(&cache->lock);
 
+			/*
+			 * The entry is now findable, so release everybody
+			 * queued for this block to share it rather than each
+			 * waiting for an entry of their own.  They will block
+			 * on entry->wait_queue below until the read completes.
+			 */
+			if (wake_block)
+				squashfs_cache_wake_block(cache, block);
+
 			entry->length = squashfs_read_data(sb, block, length,
 				&entry->next_index, entry->actor);
 
@@ -138,20 +227,33 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
 		 * for reuse.
 		 */
 		entry = &cache->entry[i];
-		if (entry->refcount == 0)
+		if (entry->refcount == 0) {
 			cache->unused--;
+			/* This claims the capacity we were woken for. */
+			capacity_wake = false;
+		}
 		entry->refcount++;
 
 		/*
 		 * If the entry is currently being filled in by another process
 		 * go to sleep waiting for it to become available.
 		 */
-		if (entry->pending) {
+		pending = entry->pending;
+		if (pending)
 			entry->num_waiters++;
-			spin_unlock(&cache->lock);
+
+		/*
+		 * We were woken because an entry became free, but shared a
+		 * block instead of claiming it.  Hand the wakeup on, otherwise
+		 * the free entry sits unclaimed while others sleep.
+		 */
+		wake_next = capacity_wake && cache->unused && cache->num_waiters;
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
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index c01998eec1467..b87221ea9bdd6 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -12,6 +12,15 @@
 
 #include "squashfs_fs.h"
 
+/*
+ * Waiters for a cache entry sleep on wait_queue as exclusive waiters, so
+ * freeing one entry wakes one task.  See squashfs_cache_get().
+ *
+ * num_waiters is only a hint used to skip pointless wakeups: it is
+ * incremented before a task queues itself and decremented after it is woken,
+ * so it can transiently exceed the number of queued tasks.  It never
+ * undercounts them, which is what the wakeup paths rely on.
+ */
 struct squashfs_cache {
 	char			*name;
 	int			entries;

base-commit: a13307e97d5c54b65720bb71fa379960ded1e51a
-- 
2.53.0-Meta

