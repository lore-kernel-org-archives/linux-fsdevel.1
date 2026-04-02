Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3C1E47CC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107977; cv=none; b=ov3CmCPbP4DEqtbfwN2OoXZ+6HzQwlK4tzbKa0RtQ5tgpHXvyib/yAQGo6qqA73jmIckUzn0MUqBzcUR44EcVFESuPt/ysQuAtE28ZU7q0wspGhUT59gmj2DgbSnKlpnY/pLe/J9PnKdZ9XqOTaDHXdcozHIp18jLCIBTYMlgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107977; c=relaxed/simple;
	bh=gz429iH/4/H6DVa9oQKpsqWSjDXp20VPKwb3KppaZhU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gRciDW5+t93R9qskySsE8pHF7Z5m0Ovzs/7IYo6iRqCYnp3RUe0sYPbDYbXTrYMJUGQecc87qVdcIYfJipbx+P9lUfZhs1FYkM02+ZRzay33f0Qi9Rgwlks3aQy1gC5b8GG3dE4oYMenwYUH5YJVfazOcIDNhafVly+Rjqh57aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP0MHV3N; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP0MHV3N"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c742d4df00cso749640a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775107976; x=1775712776; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRFBKSpSHKyHlG8XDr6gP3xZPR/EkJqxIz7CoY+pJCs=;
        b=jP0MHV3NZv4VxUnj1p5+m6o3FrGwLtpwNhLBWXV2kiOOBczOeeuSQZQMrvM+DZK0dF
         CdZ5RAtnG0X6vlJatdgCL/COEnth6nCGl4xSGd7P1ABGo/iiHxGi4cIAnAZcRm9wM99I
         djEnLbnwq6getp9nuc+pfJH1VGFOSMPOgnsfvi3HlmJEykz20MhHuB0m2a45h2m+blaV
         3kHdfanrL/iGXexa8KzFF+shWhXz2W1axnofTxJVWTzNO62r3SaxT0HWa9+XuXKYh4Ei
         yIu+Z9BqC/fMSPtFRQgBgBLxHXgU4F9lvI2fWNnnSucDZfbPi/5cpIKY+zzkKuUEtvUj
         w4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775107976; x=1775712776;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRFBKSpSHKyHlG8XDr6gP3xZPR/EkJqxIz7CoY+pJCs=;
        b=SL/drFsojVCOEgFyTFWP0D5FDOUs2bmLHjvFXrHthWTHgcRHX2NbnEL7NSrIAiFO4z
         Ak7Ww5a8ldyHNUSo0yO7vdFc+o3FHBWQHK1+HYwbPiG3DpGQUEjJB91AU3RZy1rn6GNF
         zDahk0K3lwhpIqcdc+hSxibO07/4EvKxtZLDIpci4pf5INVNf0p4bPsNOtwL9WIkHUBk
         VYCLEcaTf0GNFi+i1u92n+hQBczMwy0YTr4+6ymE7wMgRNH/fK+Auh9FK2qOmtlitYZU
         X1lqy2O8kHNCNmv62SOI6gj6fHKquJD8IxWubr2cFQlKcARNGmabDPm1cvQK62ZCAJ/q
         MprA==
X-Gm-Message-State: AOJu0YzSAj8lF2OZtIfOHAUqrvjheCTDbpH3WQVx8VIcohSqIAhTALZb
	mx9NP1UMEvBKpVnlP79VtPC7gIo+mFxP1lcMdZq4HbyACcuzzupEkjCH
X-Gm-Gg: ATEYQzy0ahEPjNhITQay25C1JaXQkFfXQCOyCY7yLY4e8PVwKna6uORsh4mZMBPdlgp
	xpsBXTq5Np18APPKN0mN5XD6J5ecurRaAWhjfFUPhzKuL/Eg1Ht9E7oPs4OYeZ24pCkDe8jiaTI
	+rJfWZ1M/sBx6cKwn8z1pOv1Y4HX8jjLZ2nKYg0kzruLj91+DbNwIxAeU+pA3VuOwpYaOoFB2b6
	TsZhGgGa45Naepy/QeSbrY+YImsa8MkF/Y6Ewm58lKQWcVunwPkhM35Lf4EqsPID5Isdb59Oz5u
	2M6Badyds++7XNT7fp3RzIC+VS9mxOl1dbrJWlFjVGmAz051fJ9pXpzTsa6ff3A2lzMtnq5kI0h
	7KGEy96Eqf2M9dhI/QpHBzOmGWCwenpridEKbCUVeqUYlyE6tNVBd+yMU7CmxF6UrbMrO2A6EbQ
	zgD9Ac9BCt9ySR2Z+Qr9VUNQewTCE7cvW5
X-Received: by 2002:a05:6a20:914d:b0:39b:84c9:3861 with SMTP id adf61e73a8af0-39f16ff7c5cmr1220958637.14.1775107974173;
        Wed, 01 Apr 2026 22:32:54 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm1745312b3a.18.2026.04.01.22.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:32:53 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <msnitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/4] mm: fix IOCB_DONTCACHE write performance with rate-limited writeback
In-Reply-To: <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
Date: Thu, 02 Apr 2026 10:13:42 +0530
Message-ID: <ikaam0ox.ritesh.list@gmail.com>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org> <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Jeff Layton <jlayton@kernel.org> writes:

> IOCB_DONTCACHE calls filemap_flush_range() with nr_to_write=LONG_MAX
> on every write, which flushes all dirty pages in the written range.
> Under concurrent writers this creates severe serialization on the
> writeback submission path, causing throughput to collapse to ~47% of
> buffered I/O with multi-second tail latency.

Yes, between concurrent writers, I agree with the theory.


> Even single-client
> sequential writes suffer: on a 512GB file with 256GB RAM, the
> aggressive flushing triggers dirty throttling that limits throughput
> to 575 MB/s vs 1442 MB/s with rate-limited writeback.

I am not sure if this 2.5x performance penalty in a "single" sequential
writer is due to throttling logic. On giving it some thoughts, I suspect
if this is because, the submission side and the completion side both
takes the xa_lock and hence could be contending on that.

For e.g. since this patch skips doing the flush the second time, (note
that writeback is active when the same writer dirtied the page during
previous write), this allows the writer to do more work of writing data
to page cache pages, instead of waiting on the xa_lock which the
completion callback could be holding (folio_end_writeback() -> folio_end_dropbehind())

If I see Peak Dirty data from the link you shared [1] in single writer case...

Mode                    MB/s	p50 (ms)	p99 (ms)	p99.9 (ms)	Peak Dirty	Peak Cache
dontcache (unpatched)	1179	3.2	    103.3	    170.9	    14 MB	    4.7 GB
dontcache (patched)	1453	5.4	    43.8	    57.4	    36 GB	    45 GB

... this too shows that the submission side is writing more dirty pages,
then the completion side able to write it... 

I suspect this contention (between submission and completion) could more
in IOCB_DONTCACHE case, since the completion side also removes the folio
from the page cache within the same xa_lock, which is not the same with
normal buffered writes.

Maybe a perf callgraph showing the contention would be nicer thing to add
here [1] ;). 

[1]: https://markdownpastebin.com/?id=96249deb897a401ba32acbce05312dcc

>
> Replace the filemap_flush_range() call in generic_write_sync() with a
> new filemap_dontcache_writeback_range() that uses two rate-limiting
> mechanisms:
>
>   1. Skip-if-busy: check mapping_tagged(PAGECACHE_TAG_WRITEBACK)
>      before flushing.  If writeback is already in progress on the
>      mapping, skip the flush entirely.  This eliminates writeback
>      submission contention between concurrent writers.
>
>   2. Proportional cap: when flushing does occur, cap nr_to_write to
>      the number of pages just written.  This prevents any single
>      write from triggering a large flush that would starve concurrent
>      readers.
>
> Both mechanisms are necessary: skip-if-busy alone causes I/O bursts
> when the tag clears (reader p99.9 spikes 83x); proportional cap alone
> still serializes on xarray locks regardless of submission size.
>
> Pages touched under IOCB_DONTCACHE continue to be marked for eviction
> (dropbehind), so page cache usage remains bounded.  Ranges skipped by
> the busy check are eventually flushed by background writeback or by
> the next writer to find the tag clear.

Yes, but the next writer may not write the dirty pages, of the previous
writer which skipped the flush call right (even if it finds the tag
clear)? Because filemap_dontcache_writeback_range( ) passes the range
and nr_to_write that means, unless the previous writer dirtied the same
range, the new writer won't be able to write the dirty pages of the
previous writer correct? So, it is mainly only the background writeback
now, which will flush this dirty pages of the writer which skipped the
flush (unless of course a fsync/sync call is made).

But having said that, I agree, this patch series is a nice performance
improvement overall :)

>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fs.h |  7 +++++--
>  mm/filemap.c       | 29 +++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25ec12b00ac1df17a952d9116b88047..53e9cca1b50a946a1276c49902294c3ae0ab3500 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2610,6 +2610,8 @@ extern int __must_check file_write_and_wait_range(struct file *file,
>  						loff_t start, loff_t end);
>  int filemap_flush_range(struct address_space *mapping, loff_t start,
>  		loff_t end);
> +int filemap_dontcache_writeback_range(struct address_space *mapping,
> +		loff_t start, loff_t end, ssize_t nr_written);
>  
>  static inline int file_write_and_wait(struct file *file)
>  {
> @@ -2645,8 +2647,9 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
>  		struct address_space *mapping = iocb->ki_filp->f_mapping;
>  
> -		filemap_flush_range(mapping, iocb->ki_pos - count,
> -				iocb->ki_pos - 1);
> +		filemap_dontcache_writeback_range(mapping,
> +				iocb->ki_pos - count,
> +				iocb->ki_pos - 1, count);
>  	}
>  
>  	return count;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 406cef06b684a84a1e0c27d8267e95f32282ffdc..af2024b736bef74571cc22ab7e3cde2c8e872efe 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -437,6 +437,35 @@ int filemap_flush_range(struct address_space *mapping, loff_t start,
>  }
>  EXPORT_SYMBOL_GPL(filemap_flush_range);
>  
> +/**
> + * filemap_dontcache_writeback_range - rate-limited writeback for dontcache I/O
> + * @mapping:	target address_space
> + * @start:	byte offset to start writeback
> + * @end:	last byte offset (inclusive) for writeback
> + * @nr_written:	number of bytes just written by the caller
> + *
> + * Rate-limited writeback for IOCB_DONTCACHE writes.  Skips the flush
> + * entirely if writeback is already in progress on the mapping (skip-if-busy),
> + * and when flushing, caps nr_to_write to the number of pages just written
> + * (proportional cap).  Together these avoid writeback contention between
> + * concurrent writers and prevent I/O bursts that starve readers.
> + *
> + * Return: %0 on success, negative error code otherwise.
> + */
> +int filemap_dontcache_writeback_range(struct address_space *mapping,
> +		loff_t start, loff_t end, ssize_t nr_written)
> +{
> +	long nr;
> +
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		return 0;
> +
> +	nr = (nr_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
> +			WB_REASON_BACKGROUND);

Was this rebased against some other tree? I couldn't find it in
linux-next. I think, that last argument is wrong. 

> +}
> +EXPORT_SYMBOL_GPL(filemap_dontcache_writeback_range);
> +
>  /**
>   * filemap_flush - mostly a non-blocking flush
>   * @mapping:	target address_space
>
> -- 
> 2.53.0
