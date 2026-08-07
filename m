Received: from sxplsmtpa04-04.prod.sxb1.secureserver.net (sxplsmtpa04-04.prod.sxb1.secureserver.net [188.121.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85772BE043
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120888; cv=none; b=WJktSgMYhHRNkMJRjBYo5qQiYG5KSNwDPK0cz/W16v4epIu/S0nBi8eaAygU9bMCsuRa597hqdJ3nP1+TSrjfsARJVCE6jW+pJ/fIPKBzIuoeTQP9w2CBvlWq8JXGvWJSWrqRgTz8d6ShjhQLEPvP52SkoFbhS2WfyVijwc2xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120888; c=relaxed/simple;
	bh=fJPzeCS2NKXqRWmnv0UbEKKCrMUirTWpALVZ7SbogpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEAc9C99C5Mr2S8hQi3JcYmr9irOMqwUcoMdIUtGfF/QHzliOd2JFzndo2AUzFmA7I8L6Ad1l3pH8N/FkxOUK7F1pLiwyFOAHLQkYXtMhnHO2d54uYlpzOcSUPQ3AGZ4lfp0bOfnNjGzknkdMlhKJ/6dh3Q0AamB2Nx02NJilr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b=jh6HOxC6; dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b=idL75SJg; arc=none smtp.client-ip=188.121.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b="jh6HOxC6";
	dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b="idL75SJg"
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id sMw1wtKAdFndAsMw3wfDHx; Fri, 07 Aug 2026 15:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1786118200;
	bh=iUW+n07tKCnuJGbTqP7GoavXIDdaWSes/c26PK0IhrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jh6HOxC6yS1G8yBOfcrJoyZU5bSqq4TGhQb7ZUPtCMl9aesKS22cySpRa57Ufdw4p
	 32TbBbZQoG5oTNfHOdeucIFbal0wcMz8URNvumfIsHsppUToOUpBgF6Opw8S4fvubA
	 R9QQqtABTfuN6IpIR8mSPp+4DYUi8njjKzngwADefe1zr8u1YHzetSnGquvXrTAMoh
	 O5R4RY2fMDfLqzDQbzQi7ogRP6M5pxJtf/zExy9FMsDUHqkg4/YwxiianKPcw3Ppv1
	 xmXDUt9u3FaDQG0cHDpLWbgsmCiogSc0xcKTkCOZurPzLaBfnsax3JeX7CKsNJy0Wi
	 vJIXxvqyoV8MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1786118200;
	bh=iUW+n07tKCnuJGbTqP7GoavXIDdaWSes/c26PK0IhrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=idL75SJgZBjX4xqKqPnwS46bwiI5fX46erF7jwIe8QuRafsXa0rTqDFf0b64lVnv1
	 R+rB1IuLwvz34rVi1tWD1wvi/3AB9Tfu9OTW+sc5fkGEsSOXVr/Mh7P4Z4kJEXe1Be
	 R3sxRv8bW6NwXSTpS4OaagVX6gbbqUDG1DDFVxdGkBZ8Xc4BnR/Sg2M+4quWwpCWv0
	 RVpi1jD4xkaP3hOJSi0ZCCRxEWkYEbupysgJRp86cbzyS6whj0CnOI4FpgfaW9DZR6
	 lpk8eyXdelMiosMe7wG6Mr6D0cO7nnTxsPR0xWUn3BgleRxlLJrFI+S7dsORsCh7DU
	 EYYAY0l/JSvtw==
X-CMAE-Analysis: v=2.4 cv=Y5VBWheN c=1 sm=1 tr=0 ts=6a760037
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=c92rfblmAAAA:8 a=FXvPX3liAAAA:8 a=VwQbUJbxAAAA:8
 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=ij-RcgZyvwWuXYiz9aMA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=e2CUPOnPG4QKp8I52DXD:22
Feedback-ID: 1cd59531474cef23836056c1d21566b6:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
Date: Fri, 7 Aug 2026 17:01:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20260724190556.1950693-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKQLQzZM9qe1T2IkN6r5M1oP3ce9yF7WaCHE8VMIsrdDu1fa0mjSlYsLNifd5yGvPEznFI4TOcVQF6AnIoWUOXe2K/a4Glmlo1q4QfFyTN6VON+T2kHX
 kQfikOQppShIFPbFnluI0sTevSDXmFZLwMCK6r7FNJYgj1q8vf3sTqCXejPpYqYYomhZ0BO9/hvp3RN6wkUx5yMk6fLSzeGdfDxdNJaZZxrUw9xzZUqToKNl
 2+RogdPa+ZZ7tMjvNrjFC/qSqrU+Yt+9rB/jFBei2w4EcA9vqMnKEC5Jdl9qiXDFCW8ReYj+Yv8/SE+DNNeQ2GV3fXjRBPX5JKhEz6Fe3BXQWEKuElQ+wfuj
 Ktj9YQ0ztgEH/iOMMr1ITI6eKbjOJjMsQW6JjXITX/O35W0zlUfYwin2DpJKg22g+QEQjYoNb+fvHSJ6sqp05n/I9qB87rfy1u93LPkwpqvF5aQx0erbL4H1
 CrKAqonpCCX9NTFA44SEdS5oxZu6lCblmYegEBgxDCY0YjFKWxKzh29Dm4Q=


On 24/07/2026 20:05, Usama Arif wrote:
> squashfs_cache_get() puts a task to sleep when its block is not cached and
> every cache entry is busy.  Those sleeps are non-exclusive, so a single
> squashfs_cache_put() makes every waiter runnable when one entry is freed.
> A wakee returns to squashfs_cache_get() only if it observes cache->unused
> before the entry is reclaimed.  Such tasks can rescan and share a block
> published meanwhile; later wakees see zero and queue again inside
> wait_event() without rescanning.
> 
> The waste is dramatic under load.  On a Meta production host serving a
> Python web application from a packaged squashfs image, a 30-second trace
> caught 1,045,132 cache-release wake calls and 19,511,556 remote wakeups:
> 18.7 per release, although each release added only one reusable cache
> entry. This was causing significant spikes in CPU usage.
> 
> Simply making the waits exclusive (i.e. using
> wait_event_state_exclusive()) is not enough.  A waiter can make
> progress two ways, when an entry frees (capacity), or when another task
> publishes the block it wants and it shares that entry.  The only wait
> condition available is cache->unused, which captures capacity but not
> publication, and wake-one can release just a single sharer at a time.  A
> waiter woken for capacity may also find its block already published, share
> it, and leave the freed entry unclaimed, so that wake must be handed on.
> A block-targeted wake and that handoff need a custom wake callback with
> per-waiter state; wait_event_state_exclusive() provides neither.
> 
> Wake selectively instead.  Waiters are exclusive and keyed by requested
> block: freeing an entry wakes one waiter (capacity), publishing a block
> wakes every waiter for that block (sharing), and a capacity waiter that
> ends up sharing hands its wake to the next waiter.  Waiters enqueue while
> holding cache->lock so lookup and publication are ordered against sleeping.
> 
> The result is an ~2x increase in throughput on stat and read.
> Measured on a 32-CPU VM against a read-only squashfs (gzip, per-cpu
> decompressor, default 8 metadata / 3 fragment cache entries) staged in tmpfs
> with caches dropped each iteration to force cold decompression:
> 
>    elbencho, 64 threads
>      metadata stat      700 ->  1320 files/s    1.9x
>      small-file read     40 ->    60 MiB/s      1.6x
> 
>    filebench, 128 threads, open+read+stat+close (mean of 3x 30s)
>      throughput       11,314 -> 25,186 ops/s    2.2x
>      latency           11.30 ->   5.05 ms/op    2.2x lower
>      sched:sched_wakeup 9.18M ->  3.44M         2.7x fewer
>      context switches  12.62M ->  5.77M         2.2x fewer
> 
> The 2.7x cut in scheduler wakeups explains the results: it roughly doubles
> throughput and halves latency under contention, and is a no-op on
> workloads that never queue for a cache entry.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>   fs/squashfs/cache.c | 66 ++++++++++++++++++++++++++++++++++++++++-----

>   1 file changed, 60 insertions(+), 6 deletions(-)
> 

Hi Usama,

Sashiko (the new patch reviewing AI) failed to apply and review your patch.

See https://sashiko.dev/#/patchset/20260724190556.1950693-1-usama.arif%40linux.dev

I have been dealing with this issue all week because Sashiko also rejected my
patch sent this week.

https://sashiko.dev/#/patchset/20260805175900.600140-1-phillip%40squashfs.org.uk

After quite a bit of investigation, it appears the problem is Sashiko is applying
the patches against the squashfs-next-git URL listed in the MAINTAINERS file.

Unfortunately that squashfs-next.git tree is unused and twelve years out of date
(last updated 2014).

See

https://lore.kernel.org/all/267938f6-8212-4ddc-9055-452f9d166010@squashfs.org.uk/

and

https://lore.kernel.org/all/anUi3bkwfM8teo_R@debarbos-thinkpadt14gen5.rmtusma.csb/


But as it stands your patch and mine are going nowhere because Andrew won't
pull any patch that has not passed Sashiko.

See

https://lwn.net/Articles/1064830/


I can see two ways of getting past this issue, and get Sashiko to approve the patches.

1.  Wait until my patch to the MAINTAINERS file goes through and then send a V2
     patch.  Unfortunately, that may take months.

2. The URL mentioned in the last email details how Sashiko chooses the baseline.
    See https://github.com/sashiko-dev/sashiko/pull/398/files.  Apparently the
    first thing it uses is any base-commit: trailer in the patch body.  So if
    you put a base-commit: in your patch it should force Sashiko to use the Linus
    Torvald's development kernel.

For info about base-commit: tags see

https://people.kernel.org/monsieuricon/all-patches-must-include-base-commit-info

I'm going to resend my patch with a base-commit: tag to see if it makes
a difference to Sashiko.

Phillip


