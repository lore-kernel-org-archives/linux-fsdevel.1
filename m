Received: from sxplsmtpa04-05.prod.sxb1.secureserver.net (sxplsmtpa04-05.prod.sxb1.secureserver.net [188.121.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A51AF0BB
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315552; cv=none; b=r/WimLkJJoWpR0MZGxBCFEpOuU654SHAh2AvChPtCFkR+Mm0fMtsdC9nV1AlA/Q24zNNE/jxr/hIv8zbKOzxNN1Tl2xEP55BaznVj0BvALNiaB/nJZQrwmuXTo2CiFwhWTjBzM9u/ivENP0ljowFm5dgsV8xaSmiSG2ol2z/Hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315552; c=relaxed/simple;
	bh=wUazQWvbqGQYm2OYDhmtH6nMr485wb99rgo7eUz7Ht4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4mHdMQgM8rUYtaenvrZv/BywcxLIrwttcvsaNke1pZi8igOHQjpnnlAG0ZnfBkR8g5NhmFG1vGm1nsE76MvGR7iq5iaHnuaos1+FdKni298yyXVDeHf7gbwYmCTbctaF7xnE8pR6A2bqO68LDGQxpAHrDmRP1Q8ZCESQJUe6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b=OT9CeYe0; dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b=rO0kJ1ei; arc=none smtp.client-ip=188.121.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b="OT9CeYe0";
	dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b="rO0kJ1ei"
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id tC9gwvyFckA4ztC9hwZrUu; Sun, 09 Aug 2026 22:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1786315091;
	bh=AOzmmy/+yJhh5D1zb7HMWSUog2xZ0R2gKFDteUG3RnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OT9CeYe0kVCM/Rnko9oIdmHnPjaRx4QaO4ws4y/6UiCDAetrGQMXoqgAWDmeZNMcF
	 fyk2LFklXhLtCk3DwNGYPHaLTesgaXCogNN+/MA8QGOSL8zjtXvlj8yCWcfE4SeiIg
	 Ob0XnFASvkIPSfiNtBPEa4ZZ1ILCrWD23h4qLtUOM7zUfxQLOMfDtCtgfIed1PTKC2
	 w57pGMCjmt6cMmwRjUA4fyEHR/XY6Z01Rwn9QfP7Hx08nzm1lMcF5hirMc7/HqSt7e
	 BZAUK/2mkrR/uEZvUYCOcHZfsW7VyDuDZd8FfuqHW951NCbBE87jJJHZ683gmczqt7
	 V4mqqdGe7TdYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1786315091;
	bh=AOzmmy/+yJhh5D1zb7HMWSUog2xZ0R2gKFDteUG3RnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rO0kJ1eirUoU0pxWAZErKR/rnxDe3UJy8LaNrc6i49qyuaGNDsEnna8B3V1PwjeLv
	 g8ePeKBMFc1dSD4x4Kr4V6XBJwZot3dTdxp/qiFBdsH4x7+CH4foMAL8M8crvXCBjV
	 GZWcwRqoy9lhfkASRVJvvg1ZgibwDZPMfCj0KWVaPRVxztR/YprH32rN4Zdd2jb2z+
	 AN1kE/Tq8C7VgmPI/k6evB2SrXPxEDxbhI7CqSfwUmKM64sYFuPhzO6gaRkjO+tyWe
	 0xlndiutSVWviiVxzuywfUWWBx74W2/xi0xUvX7rH2ZFR+cWPC9pzHPQNB5W0ehxgl
	 LokZjbxYO9Y2w==
X-CMAE-Analysis: v=2.4 cv=SdhOnvRu c=1 sm=1 tr=0 ts=6a790152
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FXvPX3liAAAA:8 a=uv5Gj36uXf3UX4Z9gggA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: df46d3daf9d6ca5edd96087b970c2a77:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <f03dc086-220f-4aca-92ce-dd3184a100a6@squashfs.org.uk>
Date: Sun, 9 Aug 2026 23:43:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] squashfs: avoid thundering-herd cache wakeups
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260807172421.3875982-1-usama.arif@linux.dev>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20260807172421.3875982-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFrSreGN7kD4nScn1hRimI2EzLHj3uFiJ+oo/msYBHRh0N8V+8oF1fhaPFLHM6d892eGd0yen8PeP5rP1uHODKiscx/f/ZjI2cN3Z2Q0xczaZUW/hq/4
 nKbLH1mwxpm28mzbIcoaAqgFzE41/0njzOcgH1Vj1rc8C17MR6vzdOmm1oFgnKL1nrJsSlyL06EVcJS3vgDIx54oC4ZTk6/EqhgLrwA3+JS7FzZOD6tzM2J9
 mYUisj1J1B+5pt0tkVdSkm1oTu9x/Oc4t0GnVbQ98vr+e1he4cCTMQnBGSPbof0qwM9ucfMTa65xC0QZIBXyIchLueowB+1SD2/3WasCoChOFCXvSKLsx+Gg
 mbCbULDZdfqcnRrsknBjmmyM7hegZE+UVlBQVO/chFJbdtwty64LO/NuwRY48SEKganRo7333VTQAg+nhfnQBvsfM1xnEVsiJeRwrNzQLOQ8vFrk8roaDNXO
 oujhS38wfb7EiSh/nSAnrmT9tjVhKPVGKwN1w/OjJ0BPYkTDdCH0OblgN7w=



On 07/08/2026 18:24, Usama Arif wrote:
> squashfs_cache_get() puts a task to sleep when its block is not cached
> and every cache entry is busy.  Those sleeps are non-exclusive, so the
> nr_exclusive == 1 budget squashfs_cache_put() has always passed to
> wake_up() is inert and one release makes every waiter runnable.  A wakee
> only returns to squashfs_cache_get() if it observes cache->unused before
> the entry is reclaimed; later wakees see zero and re-queue inside
> wait_event() without rescanning.  One freed entry satisfies exactly one
> capacity waiter, so waking the rest is waste.
> 
> On a Meta production host serving a Python web application from a
> packaged squashfs image, a 30-second trace caught 1,045,132
> cache-release wake calls and 19,511,556 wakeups: 18.7 per release,
> although each release added only one reusable cache entry.  This was
> causing significant spikes in CPU usage.
> 
> Make the waits exclusive, enqueueing while still holding cache->lock so
> that a concurrent lookup either sees the waiter queued or the waiter
> sees the block that lookup publishes.  Two things follow.
> 
> A wakee cannot be assumed to consume the entry it was woken for: it may
> find its own block published meanwhile, share that entry, and leave the
> freed one unclaimed.  So a wakee which shares hands its wakeup on to the
> next waiter, as commit 0ddad21d3e99 ("pipe: use exclusive waits when
> reading or writing") does with wake_next_reader.
> 
> And a waiter can now sleep through a publication of the very block it
> wants, which the old broadcast gave it repeated chances to notice.  So
> waiters are keyed by block: publishing wakes every waiter for that block
> (nr_exclusive == 0), freeing an entry wakes one.  That needs a custom
> wake callback, like wake_page_function() in mm/filemap.c, which also
> records which wakeup arrived so the handoff only fires for a capacity
> wakee.
> 
> Broadcast is kept where more than one task can proceed - every waiter
> for a published block, and the wake_up_all() on entry->wait_queue - at
> the cost of walking the queue under wait_queue.lock to test the key.
> Waiters are now served FIFO with a scheduling round trip per handoff
> hop, so per-waiter latency changes; the filebench run below is 4x
> oversubscribed, where that should hurt most.
> 
> Measured on a 32-CPU VM against a read-only squashfs (gzip,
> DECOMP_MULTI_PERCPU, FILE_DIRECT, default 8 metadata / 3 fragment cache
> entries) staged in tmpfs, page cache dropped each iteration to force
> cold decompression:
> 
>    elbencho, 64 threads
>      metadata stat        700 ->  1320 files/s    1.9x
>      small-file read       40 ->    60 MiB/s      1.5x
> 
>    filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
>      throughput        11,314 -> 25,186 ops/s     2.2x
>      sched:sched_wakeup  27.0 ->   4.55 per op    5.9x fewer
>      context switches    37.2 ->   7.64 per op    4.9x fewer
> 
> Wakeups and context switches are per operation, since the two runs did
> 2.2x different amounts of work.  Workloads which never queue for a cache
> entry gain no wakeups.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>   fs/squashfs/cache.c          | 114 +++++++++++++++++++++++++++++++++--
>   fs/squashfs/squashfs_fs_sb.h |   9 +++
>   2 files changed, 117 insertions(+), 6 deletions(-)

Very nice performance improvement.  Thanks.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

