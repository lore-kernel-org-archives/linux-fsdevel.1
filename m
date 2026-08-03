Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F240B6DF
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762330; cv=none; b=MWbBhQeurXkzLkzBt/2tAWAnVz6bDc0TibzyDd89AFrm3KFFrUzWMNQArvK5ZexwchJTSCaOCr5OtmeZQqoimoSI3rm2gimwILNckSO9n9QAiMt4mRonhZUGiZaUtLxFbmzo2BeDJMdHjxgjD4mA08KNNhFiceEqnXiYuADE/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762330; c=relaxed/simple;
	bh=1S0kEhPllGpyHf8aWNky6objCdr4MTj5ri+NkC+uz04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMWnw2qbmiQX0BAFF3fZFmzkTgZxj5BoDL5+B2Hjrv5vMwlPn1ZQwGqKqR6XJvvqGsfRGQh2z1U8oNGdLzYt9Bd0j95T/HxieEDGwCS10xYxXKPCBkpGS2o9XBbS3ejGWQyFxQLfjjVGl2o1okfegPDU1515851CweVPEaBwXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dWEuoQX7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dWEuoQX7"
Message-ID: <c51f516f-d18b-4bd6-8c42-53e9b82ae5a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785762325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04TAGoKrolGLfjaG9F67YVZlSjLDK4SqpRC2M8QESPA=;
	b=dWEuoQX78OJ2QoeNcBN+EabnBdmW+Zf37YRFe0OZJIO0Om4A60Jv/FTN6fqrwt61oy9+HG
	k5NmtrKSSatLqFPus8hxvH9jLxElvFldUxWLxKcQFEiPAt4gVxzKu6SJW5k7ktsVMdTikX
	MLYDTkgRY//naNZQSCdz3Wz8KQVUGKI=
Date: Mon, 3 Aug 2026 14:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: David Laight <david.laight.linux@gmail.com>
Cc: phillip@squashfs.org.uk, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 squashfs-devel@lists.sourceforge.net, brauner@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, jlayton@kernel.org,
 boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
 <664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
 <20260803123958.414dd2ed@pumpkin>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260803123958.414dd2ed@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 03/08/2026 12:39, David Laight wrote:
> On Mon, 3 Aug 2026 11:16:36 +0100
> Usama Arif <usama.arif@linux.dev> wrote:
> 
>> On 24/07/2026 20:05, Usama Arif wrote:
>>> squashfs_cache_get() puts a task to sleep when its block is not cached and
>>> every cache entry is busy.  Those sleeps are non-exclusive, so a single
>>> squashfs_cache_put() makes every waiter runnable when one entry is freed.
>>> A wakee returns to squashfs_cache_get() only if it observes cache->unused
>>> before the entry is reclaimed.  Such tasks can rescan and share a block
>>> published meanwhile; later wakees see zero and queue again inside
>>> wait_event() without rescanning.
>>>
>>> The waste is dramatic under load.  On a Meta production host serving a
>>> Python web application from a packaged squashfs image, a 30-second trace
>>> caught 1,045,132 cache-release wake calls and 19,511,556 remote wakeups:
>>> 18.7 per release, although each release added only one reusable cache
>>> entry. This was causing significant spikes in CPU usage.
>>>
>>> Simply making the waits exclusive (i.e. using
>>> wait_event_state_exclusive()) is not enough.  A waiter can make
>>> progress two ways, when an entry frees (capacity), or when another task
>>> publishes the block it wants and it shares that entry.  The only wait
>>> condition available is cache->unused, which captures capacity but not
>>> publication, and wake-one can release just a single sharer at a time.  A
>>> waiter woken for capacity may also find its block already published, share
>>> it, and leave the freed entry unclaimed, so that wake must be handed on.
>>> A block-targeted wake and that handoff need a custom wake callback with
>>> per-waiter state; wait_event_state_exclusive() provides neither.
>>>
>>> Wake selectively instead.  Waiters are exclusive and keyed by requested
>>> block: freeing an entry wakes one waiter (capacity), publishing a block
>>> wakes every waiter for that block (sharing), and a capacity waiter that
>>> ends up sharing hands its wake to the next waiter.  Waiters enqueue while
>>> holding cache->lock so lookup and publication are ordered against sleeping.
>>>
>>> The result is an ~2x increase in throughput on stat and read.
>>> Measured on a 32-CPU VM against a read-only squashfs (gzip, per-cpu
>>> decompressor, default 8 metadata / 3 fragment cache entries) staged in tmpfs
>>> with caches dropped each iteration to force cold decompression:
>>>
>>>   elbencho, 64 threads
>>>     metadata stat      700 ->  1320 files/s    1.9x
>>>     small-file read     40 ->    60 MiB/s      1.6x
>>>
>>>   filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
>>>     throughput       11,314 -> 25,186 ops/s    2.2x
>>>     latency           11.30 ->   5.05 ms/op    2.2x lower
>>>     sched:sched_wakeup 9.18M ->  3.44M         2.7x fewer
>>>     context switches  12.62M ->  5.77M         2.2x fewer
>>>
>>> The 2.7x cut in scheduler wakeups explains the results: it roughly doubles
>>> throughput and halves latency under contention, and is a no-op on
>>> workloads that never queue for a cache entry.
>>>
>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>> ---
>>>  fs/squashfs/cache.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 60 insertions(+), 6 deletions(-)  
>>
>> Hi,
>>
>> Just wanted to check if there are any reviews or comments on this patch?
>>
>> It is attempting to solvie a real thundering herd problem we see in our fleet.
>> It also doubles throughput for small file reads and stat for squashfs.
> 
> But it adds a priority inversion problem.
> It the task that is woken cannot be scheduled (either because if its priority
> or because it is pinned/real-time and the cpu it would be run on has preemption
> disabled, then none of the other threads can run either.
> 
> I had terrible trouble trying to get a 'thundering herd' from a
> pthread_broadcast() call....
> 
> 	David
> 

Hi,

Thanks for looking at this.

I don't think "priority inversion" fits: it needs a resource with an
owner (Documentation/locking/rt-mutex-design.rst), and here the woken
task owns nothing.  There is no handoff either - we re-test
cache->unused with no queue-position or owner check, so the freed entry
is not reserved for the wakee.  Any caller takes it immediately,
including one that never slept.  If the wakee is slow to reach a CPU,
only the wakee waits.  Nor is a wakeup to a busy CPU blocked:
try_to_wake_up() enqueues and sets need_resched, with a resched IPI on
SMP, and preempt-disabled sections are bounded.

And one squashfs_cache_put() frees exactly one entry, so at most one
waiter can progress from it however many you wake.  The broadcast just
makes the rest runnable so they can re-test cache->unused, find zero and
sleep again.  Across several hosts in the Meta fleet this is the normal
picture; one example was 19,511,556 wakeups for 1,045,132 releases in
30s, i.e. 18.7 wakeups per release that freed a single entry.

This is the same shape as 0ddad21d3e99 ("pipe: use exclusive waits when
reading or writing"): where the kernel sets wake_next_reader on the
exclusive wakeup, clears it under the pipe mutex if the pipe turned out
empty, and wakes the next reader after unlocking. That has been in since
v5.6 on the pipe read path, with TASK_INTERRUPTIBLE waiters.

Note this isn't blanket wake-one: the publish wake passes
nr_exclusive == 0, so all waiters for that block are released together,
and wake_up_all() on entry->wait_queue is untouched.
squashfs_cache_put() already passed nr_exclusive == 1 under a "wake one
up" comment; the non-exclusive waiters just made it inert.

Fair point though: the handoff is serial and FIFO ignores priority, so a
waiter inherits the latency of the one ahead of it.  I'll say so in v2.
The filebench run is 128 threads on 32 CPUs - 4x oversubscribed, which
is where that should hurt most - and mean latency went down from 11.30 to
5.05 ms/op.

Thanks,
Usama


>>
>> Thanks,
>> Usama
>>
>>
>>>
>>> diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
>>> index 67abd4dff222..5c790c204a1a 100644
>>> --- a/fs/squashfs/cache.c
>>> +++ b/fs/squashfs/cache.c
>>> @@ -45,6 +45,40 @@
>>>  #include "squashfs.h"
>>>  #include "page_actor.h"
>>>  
>>> +/*
>>> + * A NULL wake key selects one waiter for newly available capacity.  A block
>>> + * key selects every waiter which can share the newly published cache entry.
>>> + */
>>> +struct squashfs_cache_wait {
>>> +	wait_queue_entry_t wait;
>>> +	u64 block;
>>> +	bool capacity_wake;
>>> +};
>>> +
>>> +static int squashfs_cache_wake_function(wait_queue_entry_t *wait,
>>> +					unsigned int mode, int sync, void *key)
>>> +{
>>> +	struct squashfs_cache_wait *cache_wait =
>>> +		container_of(wait, struct squashfs_cache_wait, wait);
>>> +	u64 *block = key;
>>> +	int ret;
>>> +
>>> +	if (block && cache_wait->block != *block)
>>> +		return 0;
>>> +
>>> +	/* A failed wake remains queued, so finish_wait() sees the reset. */
>>> +	WRITE_ONCE(cache_wait->capacity_wake, !block);
>>> +	ret = autoremove_wake_function(wait, mode, sync, NULL);
>>> +	if (!ret)
>>> +		WRITE_ONCE(cache_wait->capacity_wake, false);
>>> +	return ret;
>>> +}
>>> +
>>> +static void squashfs_cache_wake_block(struct squashfs_cache *cache, u64 block)
>>> +{
>>> +	__wake_up(&cache->wait_queue, TASK_NORMAL, 0, &block);
>>> +}
>>> +
>>>  /*
>>>   * Look-up block in cache, and increment usage count.  If not in cache, read
>>>   * and decompress it from disk.
>>> @@ -54,6 +88,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
>>>  {
>>>  	int i, n;
>>>  	struct squashfs_cache_entry *entry;
>>> +	struct squashfs_cache_wait wait = { .block = block };
>>> +	bool consumed, pending, wake_block, wake_next;
>>>  
>>>  	spin_lock(&cache->lock);
>>>  
>>> @@ -72,9 +108,16 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
>>>  			 * go to sleep waiting for one to become available.
>>>  			 */
>>>  			if (cache->unused == 0) {
>>> +				init_wait(&wait.wait);
>>> +				wait.wait.func = squashfs_cache_wake_function;
>>>  				cache->num_waiters++;
>>> +				WRITE_ONCE(wait.capacity_wake, false);
>>> +				/* Enqueue before dropping the lock to avoid missing publish. */
>>> +				prepare_to_wait_exclusive(&cache->wait_queue,
>>> +							  &wait.wait, TASK_UNINTERRUPTIBLE);
>>>  				spin_unlock(&cache->lock);
>>> -				wait_event(cache->wait_queue, cache->unused);
>>> +				schedule();
>>> +				finish_wait(&cache->wait_queue, &wait.wait);
>>>  				spin_lock(&cache->lock);
>>>  				cache->num_waiters--;
>>>  				continue;
>>> @@ -105,8 +148,12 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
>>>  			entry->pending = 1;
>>>  			entry->num_waiters = 0;
>>>  			entry->error = 0;
>>> +			wake_block = cache->num_waiters;
>>>  			spin_unlock(&cache->lock);
>>>  
>>> +			if (wake_block)
>>> +				squashfs_cache_wake_block(cache, block);
>>> +
>>>  			entry->length = squashfs_read_data(sb, block, length,
>>>  				&entry->next_index, entry->actor);
>>>  
>>> @@ -138,7 +185,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
>>>  		 * for reuse.
>>>  		 */
>>>  		entry = &cache->entry[i];
>>> -		if (entry->refcount == 0)
>>> +		consumed = entry->refcount == 0;
>>> +		if (consumed)
>>>  			cache->unused--;
>>>  		entry->refcount++;
>>>  
>>> @@ -146,12 +194,18 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
>>>  		 * If the entry is currently being filled in by another process
>>>  		 * go to sleep waiting for it to become available.
>>>  		 */
>>> -		if (entry->pending) {
>>> +		pending = entry->pending;
>>> +		if (pending)
>>>  			entry->num_waiters++;
>>> -			spin_unlock(&cache->lock);
>>> +		/* Pass on capacity if this waiter shared rather than consumed it. */
>>> +		wake_next = READ_ONCE(wait.capacity_wake) && !consumed &&
>>> +			cache->unused && cache->num_waiters;
>>> +		spin_unlock(&cache->lock);
>>> +
>>> +		if (wake_next)
>>> +			wake_up(&cache->wait_queue);
>>> +		if (pending)
>>>  			wait_event(entry->wait_queue, !entry->pending);
>>> -		} else
>>> -			spin_unlock(&cache->lock);
>>>  
>>>  		goto out;
>>>  	}  
>>
>>
> 

