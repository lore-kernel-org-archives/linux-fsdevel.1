Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBF39BFEC
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357841; cv=none; b=LIfd65mq8Xz7UROklwYUKmk905K/HG4gAWJqUvPVINcDnUGMtb9QUKx0kgUT721F3SpSjbTXJ+zmg2Rb5CdSDQJ17A88JptUJHjgawFq4HoZnUjeYBAYjje+xas5L2Flz4Lr1EdiKwLbYe5ZiMGRecusOqrAoN60u1nk/K0xOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357841; c=relaxed/simple;
	bh=oqOD90cvP560lV3808f3OJ16n01uvBDzZIhAL7iROIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+sdGXmAV+FynfakO8s1onXZzHYLT4LUF0O+S7n5qSPZQRdHOR4dlH8e/cgGsWuSpW2wBO4GSR8dI0EVaZ6PV2wYymoxz2mIOD12O3tffVzxQxYB9VNbkl+nl6MvzkJxQqAPerKsYNR5EiadKgmuLFU+MXZc1namXhxT1D+6D/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPHo/Lq5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPHo/Lq5"
Message-ID: <23a6115a-b508-4601-a304-04d05fce9426@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786357835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcX4iYDIG4tZ3Zi5HXRelDg76qaqUVIxBiMwmC/d7oI=;
	b=MPHo/Lq5X9VQ3XIXo5xua3gevUEIQVC+So0erk4/1nGqWktTs6H2Bim4UVE0ZQ/M+v+VdK
	kcRoVjzuE+5ctznmRvE1MNrAzyzQg4LsHlDDELVxGtndLTvT79jGCmdVeps6KEWplfnn2v
	sP2tKYnKaxbdV4c1CNqG5emfEaXtZJ8=
Date: Mon, 10 Aug 2026 11:30:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] squashfs: avoid thundering-herd cache wakeups
To: Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260807172421.3875982-1-usama.arif@linux.dev>
 <f03dc086-220f-4aca-92ce-dd3184a100a6@squashfs.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <f03dc086-220f-4aca-92ce-dd3184a100a6@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 09/08/2026 23:43, Phillip Lougher wrote:
> 
> 
> On 07/08/2026 18:24, Usama Arif wrote:
>> squashfs_cache_get() puts a task to sleep when its block is not cached
>> and every cache entry is busy.  Those sleeps are non-exclusive, so the
>> nr_exclusive == 1 budget squashfs_cache_put() has always passed to
>> wake_up() is inert and one release makes every waiter runnable.  A wakee
>> only returns to squashfs_cache_get() if it observes cache->unused before
>> the entry is reclaimed; later wakees see zero and re-queue inside
>> wait_event() without rescanning.  One freed entry satisfies exactly one
>> capacity waiter, so waking the rest is waste.
>>
>> On a Meta production host serving a Python web application from a
>> packaged squashfs image, a 30-second trace caught 1,045,132
>> cache-release wake calls and 19,511,556 wakeups: 18.7 per release,
>> although each release added only one reusable cache entry.  This was
>> causing significant spikes in CPU usage.
>>
>> Make the waits exclusive, enqueueing while still holding cache->lock so
>> that a concurrent lookup either sees the waiter queued or the waiter
>> sees the block that lookup publishes.  Two things follow.
>>
>> A wakee cannot be assumed to consume the entry it was woken for: it may
>> find its own block published meanwhile, share that entry, and leave the
>> freed one unclaimed.  So a wakee which shares hands its wakeup on to the
>> next waiter, as commit 0ddad21d3e99 ("pipe: use exclusive waits when
>> reading or writing") does with wake_next_reader.
>>
>> And a waiter can now sleep through a publication of the very block it
>> wants, which the old broadcast gave it repeated chances to notice.  So
>> waiters are keyed by block: publishing wakes every waiter for that block
>> (nr_exclusive == 0), freeing an entry wakes one.  That needs a custom
>> wake callback, like wake_page_function() in mm/filemap.c, which also
>> records which wakeup arrived so the handoff only fires for a capacity
>> wakee.
>>
>> Broadcast is kept where more than one task can proceed - every waiter
>> for a published block, and the wake_up_all() on entry->wait_queue - at
>> the cost of walking the queue under wait_queue.lock to test the key.
>> Waiters are now served FIFO with a scheduling round trip per handoff
>> hop, so per-waiter latency changes; the filebench run below is 4x
>> oversubscribed, where that should hurt most.
>>
>> Measured on a 32-CPU VM against a read-only squashfs (gzip,
>> DECOMP_MULTI_PERCPU, FILE_DIRECT, default 8 metadata / 3 fragment cache
>> entries) staged in tmpfs, page cache dropped each iteration to force
>> cold decompression:
>>
>>    elbencho, 64 threads
>>      metadata stat        700 ->  1320 files/s    1.9x
>>      small-file read       40 ->    60 MiB/s      1.5x
>>
>>    filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
>>      throughput        11,314 -> 25,186 ops/s     2.2x
>>      sched:sched_wakeup  27.0 ->   4.55 per op    5.9x fewer
>>      context switches    37.2 ->   7.64 per op    4.9x fewer
>>
>> Wakeups and context switches are per operation, since the two runs did
>> 2.2x different amounts of work.  Workloads which never queue for a cache
>> entry gain no wakeups.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>>   fs/squashfs/cache.c          | 114 +++++++++++++++++++++++++++++++++--
>>   fs/squashfs/squashfs_fs_sb.h |   9 +++
>>   2 files changed, 117 insertions(+), 6 deletions(-)
> 
> Very nice performance improvement.  Thanks.
> 
> Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
> 

Thanks Phillip!

Regards,
Usama
