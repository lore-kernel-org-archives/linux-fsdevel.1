Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EC4028EE
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757204; cv=none; b=nU0NM+erkx0iOcVu7L69v+ajvzMlgBrkG0waHS1j48TqzGTvJ1/vB96+mL8txMcngyhP6TRwD8Kr9tkT5nGWgc/SHktbzTF4AwYvcIgUIz7UrMdQW228h/D2kXNXrKvRffM4WtbjWlS/cm5JfoVoS0hCbot1tbf/wsTPsgo4PCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757204; c=relaxed/simple;
	bh=gFBLW616aT4qPMEI6qpCiAVmaOQ1KvRY6WE5kN0KcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1+D7irAYK8tuoEZVTvZkh2BwmRD+XzQ8555gaRBQ0LFuhrS0PGe9kxb9wFbsU0i5urabe6JWkjuhgosJeC7PnFh/gqz1RQhJiyRXv5tKFqi42BrJRI5If3Lxjojcyqh4k6rE2P/4VEyZteLlrC4ad99/HRcwEa9T1xU/8ZTqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtgmgY2x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtgmgY2x"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so20357095e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785757201; x=1786362001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUXg0pNMmZ2Ia54IXv0zOClCgTSv5CQYxeTS7yi9LSI=;
        b=CtgmgY2xh8Q2tJi7t0jhHw+kVPy2S6GVABJx8vMFiDm1q+Tffo/iuGPSW+5oRFB9s2
         gp9shUB6r/IexK/QSUjd5Nq/OWK4Ak43CJJQPw6B2WKLU4DlJKighJyfqw6mD76msSos
         IMVc5LyzXXXKefPKVWSOE5egK4zwqiIjNy/KmHLFdmAy0eVCBZWudGLgtpVEE7g+MABB
         xx819q81kQd2zdEOHdHwFAEBtL3gjqkOoU75Ii9WLS0TWq0p91gmRQNbaOPR+1//lo5M
         drqxMOIk+Q+QNVQX3L32QrM0fQN8Sei1msrQwBSmcq4me0kvwPZtCjMODjm+hnh+V0eK
         fMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757201; x=1786362001;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUXg0pNMmZ2Ia54IXv0zOClCgTSv5CQYxeTS7yi9LSI=;
        b=QLyJLl8hDQDuquGGV7+IOhoa/PJqVk9MY44QfHAYNYuuwFscp3NNdgKDeZuzGxaf3l
         0a4rAVSHKetLBLfiw3FfK0crJaUacQttrd+WsRBaJvSwdOg9EIHq9ALifb4QY03XR3R/
         HKdLGOIEpmk9DUCveQOU8hivkO7z17is3tXvqmnQaeJ2FujJSFSPsKhA7TYYuJZ9bXVP
         Nyswc+i3UXTlQBuTDlH9nWy7Q/32Y5eZr4+V0id4k3Tfcyiy3mFqPsLXw3cxI16lCnVD
         12ZJ1IsQ05L7uzGWV5JJH+Kwxi/FgHAlSUCvZmS880SJhupW3VSjE7BF0U/FvLvxt1Lo
         KCsw==
X-Forwarded-Encrypted: i=1; AHgh+Rpxu/l4MAoYNAb7TW7aKiSHMWmUNM634cRXLtNR5BTWVDPt64I89RXE8d9to/rbss8ScuWoJirALPApfvT5@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGZavO/M0VHDLfRHqW8xXomyZo4RqEfljE5ZiAdRojTU6GcnI
	CvKXwcNf8p2pw9/au6+5E8CExzLKsVj2WhFVknJVjJtYDcf3xzJHLwqi
X-Gm-Gg: AR+sD10/y9IgcQeReS1GLfIgEOTSPLfBDYWUaQB6JKzhBjILQ2InEJggfbTTQOx1d2E
	/dnXbYpa6F5eoi9UjkTFHVjuRJXfaXFOV1rhnvrEXa1zALODKUTrPY8NN8QU8kw1ReZ5h5Llpwq
	+THe5MRewux3FAsutjvdasfDN0cHSp5CRgGm4aTGHb0Rstf7W3JDEAsNK4gvB1zFiTwqHobKJI3
	5Wl0K18QuJn1VFvYc/hI+zt+NRMzztaH+WBVnTn9gyWeLp0RUnccXadFXqfE34OJN6E1iZAIFDb
	sL27aYklaP3Oh0Ra/Jim7oaVG1RAwaK8iGeCI4H22dcT9cSfsA6IBqMd2wHK/SJ685tgUTdTOl1
	kqsURZQTPlvfx5IJygysCpAZQG5KRXBxhjtxJhFOlOqWu3YdZ3E9L6eX2J0xRVjMiP30LmtiLNi
	LqOLEsDtRyMq4723jXJ+zaOuGRV0WtpxQkOgEtvZ5hvuRKumv8NY8N79Phy4y8wVe0sDgWwcjbY
	4yznnM+V2icpsu+/1v1HLpIRrNmN6+X3WV2RQ==
X-Received: by 2002:a05:600c:1393:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4980c649c54mr233126965e9.1.1785757200362;
        Mon, 03 Aug 2026 04:40:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm34347619f8f.27.2026.08.03.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:40:00 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:39:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: phillip@squashfs.org.uk, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 squashfs-devel@lists.sourceforge.net, brauner@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, jlayton@kernel.org,
 boris@bur.io, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
Message-ID: <20260803123958.414dd2ed@pumpkin>
In-Reply-To: <664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
References: <20260724190556.1950693-1-usama.arif@linux.dev>
	<664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 11:16:36 +0100
Usama Arif <usama.arif@linux.dev> wrote:

> On 24/07/2026 20:05, Usama Arif wrote:
> > squashfs_cache_get() puts a task to sleep when its block is not cached and
> > every cache entry is busy.  Those sleeps are non-exclusive, so a single
> > squashfs_cache_put() makes every waiter runnable when one entry is freed.
> > A wakee returns to squashfs_cache_get() only if it observes cache->unused
> > before the entry is reclaimed.  Such tasks can rescan and share a block
> > published meanwhile; later wakees see zero and queue again inside
> > wait_event() without rescanning.
> > 
> > The waste is dramatic under load.  On a Meta production host serving a
> > Python web application from a packaged squashfs image, a 30-second trace
> > caught 1,045,132 cache-release wake calls and 19,511,556 remote wakeups:
> > 18.7 per release, although each release added only one reusable cache
> > entry. This was causing significant spikes in CPU usage.
> > 
> > Simply making the waits exclusive (i.e. using
> > wait_event_state_exclusive()) is not enough.  A waiter can make
> > progress two ways, when an entry frees (capacity), or when another task
> > publishes the block it wants and it shares that entry.  The only wait
> > condition available is cache->unused, which captures capacity but not
> > publication, and wake-one can release just a single sharer at a time.  A
> > waiter woken for capacity may also find its block already published, share
> > it, and leave the freed entry unclaimed, so that wake must be handed on.
> > A block-targeted wake and that handoff need a custom wake callback with
> > per-waiter state; wait_event_state_exclusive() provides neither.
> > 
> > Wake selectively instead.  Waiters are exclusive and keyed by requested
> > block: freeing an entry wakes one waiter (capacity), publishing a block
> > wakes every waiter for that block (sharing), and a capacity waiter that
> > ends up sharing hands its wake to the next waiter.  Waiters enqueue while
> > holding cache->lock so lookup and publication are ordered against sleeping.
> > 
> > The result is an ~2x increase in throughput on stat and read.
> > Measured on a 32-CPU VM against a read-only squashfs (gzip, per-cpu
> > decompressor, default 8 metadata / 3 fragment cache entries) staged in tmpfs
> > with caches dropped each iteration to force cold decompression:
> > 
> >   elbencho, 64 threads
> >     metadata stat      700 ->  1320 files/s    1.9x
> >     small-file read     40 ->    60 MiB/s      1.6x
> > 
> >   filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
> >     throughput       11,314 -> 25,186 ops/s    2.2x
> >     latency           11.30 ->   5.05 ms/op    2.2x lower
> >     sched:sched_wakeup 9.18M ->  3.44M         2.7x fewer
> >     context switches  12.62M ->  5.77M         2.2x fewer
> > 
> > The 2.7x cut in scheduler wakeups explains the results: it roughly doubles
> > throughput and halves latency under contention, and is a no-op on
> > workloads that never queue for a cache entry.
> > 
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> >  fs/squashfs/cache.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 60 insertions(+), 6 deletions(-)  
> 
> Hi,
> 
> Just wanted to check if there are any reviews or comments on this patch?
> 
> It is attempting to solvie a real thundering herd problem we see in our fleet.
> It also doubles throughput for small file reads and stat for squashfs.

But it adds a priority inversion problem.
It the task that is woken cannot be scheduled (either because if its priority
or because it is pinned/real-time and the cpu it would be run on has preemption
disabled, then none of the other threads can run either.

I had terrible trouble trying to get a 'thundering herd' from a
pthread_broadcast() call....

	David

> 
> Thanks,
> Usama
> 
> 
> > 
> > diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
> > index 67abd4dff222..5c790c204a1a 100644
> > --- a/fs/squashfs/cache.c
> > +++ b/fs/squashfs/cache.c
> > @@ -45,6 +45,40 @@
> >  #include "squashfs.h"
> >  #include "page_actor.h"
> >  
> > +/*
> > + * A NULL wake key selects one waiter for newly available capacity.  A block
> > + * key selects every waiter which can share the newly published cache entry.
> > + */
> > +struct squashfs_cache_wait {
> > +	wait_queue_entry_t wait;
> > +	u64 block;
> > +	bool capacity_wake;
> > +};
> > +
> > +static int squashfs_cache_wake_function(wait_queue_entry_t *wait,
> > +					unsigned int mode, int sync, void *key)
> > +{
> > +	struct squashfs_cache_wait *cache_wait =
> > +		container_of(wait, struct squashfs_cache_wait, wait);
> > +	u64 *block = key;
> > +	int ret;
> > +
> > +	if (block && cache_wait->block != *block)
> > +		return 0;
> > +
> > +	/* A failed wake remains queued, so finish_wait() sees the reset. */
> > +	WRITE_ONCE(cache_wait->capacity_wake, !block);
> > +	ret = autoremove_wake_function(wait, mode, sync, NULL);
> > +	if (!ret)
> > +		WRITE_ONCE(cache_wait->capacity_wake, false);
> > +	return ret;
> > +}
> > +
> > +static void squashfs_cache_wake_block(struct squashfs_cache *cache, u64 block)
> > +{
> > +	__wake_up(&cache->wait_queue, TASK_NORMAL, 0, &block);
> > +}
> > +
> >  /*
> >   * Look-up block in cache, and increment usage count.  If not in cache, read
> >   * and decompress it from disk.
> > @@ -54,6 +88,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
> >  {
> >  	int i, n;
> >  	struct squashfs_cache_entry *entry;
> > +	struct squashfs_cache_wait wait = { .block = block };
> > +	bool consumed, pending, wake_block, wake_next;
> >  
> >  	spin_lock(&cache->lock);
> >  
> > @@ -72,9 +108,16 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
> >  			 * go to sleep waiting for one to become available.
> >  			 */
> >  			if (cache->unused == 0) {
> > +				init_wait(&wait.wait);
> > +				wait.wait.func = squashfs_cache_wake_function;
> >  				cache->num_waiters++;
> > +				WRITE_ONCE(wait.capacity_wake, false);
> > +				/* Enqueue before dropping the lock to avoid missing publish. */
> > +				prepare_to_wait_exclusive(&cache->wait_queue,
> > +							  &wait.wait, TASK_UNINTERRUPTIBLE);
> >  				spin_unlock(&cache->lock);
> > -				wait_event(cache->wait_queue, cache->unused);
> > +				schedule();
> > +				finish_wait(&cache->wait_queue, &wait.wait);
> >  				spin_lock(&cache->lock);
> >  				cache->num_waiters--;
> >  				continue;
> > @@ -105,8 +148,12 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
> >  			entry->pending = 1;
> >  			entry->num_waiters = 0;
> >  			entry->error = 0;
> > +			wake_block = cache->num_waiters;
> >  			spin_unlock(&cache->lock);
> >  
> > +			if (wake_block)
> > +				squashfs_cache_wake_block(cache, block);
> > +
> >  			entry->length = squashfs_read_data(sb, block, length,
> >  				&entry->next_index, entry->actor);
> >  
> > @@ -138,7 +185,8 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
> >  		 * for reuse.
> >  		 */
> >  		entry = &cache->entry[i];
> > -		if (entry->refcount == 0)
> > +		consumed = entry->refcount == 0;
> > +		if (consumed)
> >  			cache->unused--;
> >  		entry->refcount++;
> >  
> > @@ -146,12 +194,18 @@ struct squashfs_cache_entry *squashfs_cache_get(struct super_block *sb,
> >  		 * If the entry is currently being filled in by another process
> >  		 * go to sleep waiting for it to become available.
> >  		 */
> > -		if (entry->pending) {
> > +		pending = entry->pending;
> > +		if (pending)
> >  			entry->num_waiters++;
> > -			spin_unlock(&cache->lock);
> > +		/* Pass on capacity if this waiter shared rather than consumed it. */
> > +		wake_next = READ_ONCE(wait.capacity_wake) && !consumed &&
> > +			cache->unused && cache->num_waiters;
> > +		spin_unlock(&cache->lock);
> > +
> > +		if (wake_next)
> > +			wake_up(&cache->wait_queue);
> > +		if (pending)
> >  			wait_event(entry->wait_queue, !entry->pending);
> > -		} else
> > -			spin_unlock(&cache->lock);
> >  
> >  		goto out;
> >  	}  
> 
> 

