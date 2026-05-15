Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D3413D8C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876309; cv=none; b=YhOr1v4FJsU6IY/gzcUeg3x1p2aBkTx663ZeuLsRLtP0T0oxrpYCuXfRCuGe++1Nt0/VPa2rj8o68ylyM5iDamuJ/PG/1kL7gaMineWDTN9ndD1iqedp9IX/N0vYR4/ym6/wYRpRcdkZNgros0Y8GZfeZ21MRhzanrzubvLx7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876309; c=relaxed/simple;
	bh=1hhJhGRBnE39H1ExGWWobqPWwKhQ+nPBRdzHBrMnTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5NN+6QQoGT2Vt3KuNhkiNHjtXI+vR8npdeX1+QadRHc8HsUqW3zMVb8rpTll9K6gjcOPi0FaX1nq8qrBAtPwDAfZCHihOqzxoMtDd33Z6xBqeyoNII51K2LS+DMijbctYXyVAORutEbnJMwuoThKTlWEWBUC8u3C4ld41B8UkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIovqBLR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIovqBLR"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-448528f4e69so92111f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876306; x=1779481106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFUMjA3Q99bNtqVvjxkvJVf5DLmJ4s9XgY1QXegt+iY=;
        b=oIovqBLR0CtMBAyoaCqKzxXaDNJN5d76PLDqiDCIXHgoAnyMY7jQS038UCH4nrskgh
         sahfXbgL3fpJ9GVHqGl64t5jiepC3kTOkaF35ndqhchM2Z6aGuQSDVLfsgi57CE2eBeL
         iNJ5TVnRZs6FFdlbLtiUZydx4TbPobkBrlASKADzNE8DBGyhJKW/Uh2gS2syoFTHQmZD
         7GlnJjgjyLQm6BYs7fZ0/DylTTpA+K3S/Prv32A9EPKLroVCz3o9cRmw1oDhV8zLgObw
         Tfah0AwIJMZLFx5jFBFux7eyZr8Syu3N7wwH4xPBhJt734OzKp+FtDu5E+10nn5ge56L
         XCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876306; x=1779481106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFUMjA3Q99bNtqVvjxkvJVf5DLmJ4s9XgY1QXegt+iY=;
        b=J+pfPsokyur7eYkQCu7WMBQWPIUCh68tanvFMuGOHWxOioqJUOEuBaTrEC4xX+1o6s
         G+KKRo0ot01Kgxi8q3v2nBgaro0bGnyYp1dvMxIJ4rTQ6BKRhQXmjEqewb+pbQGimPvd
         5BkU/TanLuv9Fl47eBh7P9ulB+FeS3XYQtB2okMs8n4wrnmRvSS84V3OqwNaS5RUWvZO
         H3RVgS74/vx5NREHybRls6onF6vuyvolaffhTrpw/Nhsfli3mCc7DEiWnwgr/XuRya+Z
         DCd1Qtexv3SPeVQu253q9YqcalCWqDsFhNlk7sIREXnVEdlS2diRF4EG0VTHSPhz3Unl
         DNFg==
X-Forwarded-Encrypted: i=1; AFNElJ/H9PyI63jJ4tCxcLC/no58GiBfMSDVZzy84GAYxXr+6ZIuvpf3YUdyPb4G3DkIWgd6qul0lulHCMZOWw0p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13CfIp8eXNsWOwjJUEUuQKp4+j327eoKXVMb7W58csRZtq/CF
	ZRCViKuW0rtyVmq+8ynEQ+Lzfaw6h/WWvBjYsGTj5H42qnf8+TZaCgTl
X-Gm-Gg: Acq92OFz4TN1iBRn7b5BwDt/wofbb+wlyZBGPvg1Y3CYwc8qTz1K/kAE6vjcngFdyOQ
	Wn8G1V3ePYuTME2eL+6e5AbmGudEtaassi6l4SrILsTQE4wPCTm7aLDPh+aoUaSrtyYQK7su5AM
	8R+glnHhVKk9z1YgnY1WUJ2ssY1sKlEXko9OnfA79S/CSc8a1vtfAVGYgR4hlOKczSoI3BMzLf4
	4Kj+Z/+GtgHAskYSe0Gjy6tVgGcAYkormBxyKaxNLLghEX5lTJuElrFsJJ34uipLuAsHQT80aIo
	j896mKFSXFShLhv1Ia/I1/7g3AkwFAnP3AtalRaU5klbIRG+XeYIREKDu+Y6yZanDMmh1p3z28p
	+OaKuMiBNqkAPkC0UgI2h6yBO7wIw4FCEzWn9s1gnBSbCyH0FEB+xK68+XYFA1TVNkroYQHMet4
	bIB7mexTf81lQFgVa1KDkKt1UDOjApRIoJEB1fGHTeMgmHAr8qS7++ZsZxdYAyP1s4jau8dII4l
	/qaNWrj3w==
X-Received: by 2002:a05:6000:1ace:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-45e5c58906amr7599545f8f.10.1778876306213;
        Fri, 15 May 2026 13:18:26 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm16413483f8f.30.2026.05.15.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:18:25 -0700 (PDT)
Date: Fri, 15 May 2026 22:18:19 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
 <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>

On Fri, May 15, 2026 at 03:28:44AM -0700, Breno Leitao wrote:
> anon_pipe_write() takes pipe->mutex and then, from the per-iteration
> anon_pipe_get_page() helper, used to call alloc_page(GFP_HIGHUSER |
> __GFP_ACCOUNT) once per page while still holding it. That allocation
> can sleep doing direct reclaim and/or runs memcg charging, which extends
> the critical section and stalls a concurrent reader on the very same
> mutex.
> 
> Bulk pre-allocate DIV_ROUND_UP(total_len, PAGE_SIZE) pages (up to
> PIPE_PREALLOC_MAX (8)) pages outside the mutex when total_len >=
> PAGE_SIZE, using alloc_pages_bulk().  (Under memcg, alloc_pages_bulk()
> with __GFP_ACCOUNT might return less pages than requested, but, this is
> still a win, given some pages allocation is moved outside of the
> lock).
> 
> Pass the array into anon_pipe_get_page(), which now consumes from
> tmp_page[] first, then from the prealloc array, and only as a last
> resort falls back to alloc_page() under the mutex (reached only for
> writes larger than 8 pages, where the prealloc cap is exhausted).
> 
> Doing this in one bulk call before the lock keeps the fast path's
> mutex held for a single, write-bounded critical section -- no extra
> mutex_unlock/_lock cycles -- so it avoids the per-page lock-handoff
> overhead that a per-page drop-and-retake design would introduce, while
> still moving the typical multi-page allocation off the critical
> section. Unused prealloc pages are pushed to the pipe's tmp_page[]
> cache (or freed) before unlock, so a subsequent write to the same
> pipe gets a hot cached page rather than paying for an alloc again.
> 
> Sub-PAGE_SIZE writes are unchanged: the merge path handles them
> without ever needing a fresh page, so it is not worth speculatively
> allocating for them.
> 
> This can improve the pipe throughput up to 48% and reduce the latency in
> 33%.


This change is quite a hammer.

Do you have a real workload where there are multiple processes issuing
large ops to the same pipe on both reader and writer side?

The only workload I'm aware of sharing the pipe between more than just
one reader and one writer is anything with make, but that is mostly
operating on 1-byte ops.

I'm asking because this would be better implemented taking into account
how many pages are hanging out in the tmp_page array. With only one
writer and one reader there is no concern someone will steal the pages.

Preferably the tmp_page array would grow to accomodate more memory, but
admittedly this runs into a problem where a pipe can linger unused
indefinitely while hoarding several pages. As in, some shrinking
mechanism would be needed so that's probably a no-go and preallocation
is the way to go for now.

Even then, this can definitely be integrated much better instead of
being open-coded.

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/pipe.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 9841648c9cf3e..7a1517d15107a 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -111,7 +111,11 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
>  	pipe_lock(pipe2);
>  }
>  
> -static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> +#define PIPE_PREALLOC_MAX 8
> +
> +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
> +				       struct page **prealloc,
> +				       unsigned int *prealloc_n)
>  {
>  	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
>  		if (pipe->tmp_page[i]) {
> @@ -121,6 +125,14 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
>  		}
>  	}
>  
> +	if (*prealloc_n) {
> +		unsigned int idx = --(*prealloc_n);

This is some nasty golfing.

Instead, you could have something like:
struct tmp_page_prealloc {
	struct page *pages;
	unsigned int count;
};


then...

> +		struct page *page = prealloc[idx];
> +
> +		prealloc[idx] = NULL;
> +		return page;
> +	}
> +
>  	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  }
>  
> @@ -438,6 +450,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t chars;
>  	bool was_empty = false;
>  	bool wake_next_writer = false;
> +	struct page *prealloc[PIPE_PREALLOC_MAX] = { NULL };
> +	unsigned int prealloc_n = 0;
>  

	struct tmp_page_prealloc tpp = {};

>  	/*
>  	 * Reject writing to watch queue pipes before the point where we lock
> @@ -455,6 +469,26 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (unlikely(total_len == 0))
>  		return 0;
>  
> +	/*
> +	 * Bulk pre-allocate up to PIPE_PREALLOC_MAX pages outside pipe->mutex
> +	 * for writes that span at least one full page. alloc_page() with
> +	 * GFP_HIGHUSER may sleep doing reclaim and runs memcg charging, so
> +	 * doing it under the mutex extends the critical section and stalls
> +	 * the reader. The merge path handles sub-PAGE_SIZE writes without
> +	 * needing a fresh page; for writes larger than PIPE_PREALLOC_MAX
> +	 * pages, anon_pipe_get_page() falls back to a single alloc_page()
> +	 * under the mutex for the remainder. Unused prealloc pages are
> +	 * returned to the pipe's tmp_page[] cache (or freed) before unlock.
> +	 */
> +	if (total_len >= PAGE_SIZE) {
> +		unsigned int want = min_t(unsigned int,
> +					  DIV_ROUND_UP(total_len, PAGE_SIZE),
> +					  PIPE_PREALLOC_MAX);
> +
> +		prealloc_n = alloc_pages_bulk(GFP_HIGHUSER | __GFP_ACCOUNT,
> +					      want, prealloc);
> +	}
> +

This should move to a dedicated routine, perhaps:
	anon_get_page_prealloc(pipe, &tmp_page_prealloc);

then it can also easily decide how much to prealloc based on existing
state

>  	mutex_lock(&pipe->mutex);
>  
>  	if (!pipe->readers) {
> @@ -512,7 +546,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			struct page *page;
>  			int copied;
>  
> -			page = anon_pipe_get_page(pipe);
> +			page = anon_pipe_get_page(pipe, prealloc, &prealloc_n);
>  			if (unlikely(!page)) {
>  				if (!ret)
>  					ret = -ENOMEM;
> @@ -576,6 +610,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		wake_next_writer = true;
>  	}
>  out:
> +	while (prealloc_n)
> +		anon_pipe_put_page(pipe, prealloc[--prealloc_n]);

this results in put_page() calls under the mutex, still extending the hold time

you could split this into 2 ops, for example:
+	anon_pipe_cache_pages(pipe, &tmp_page_prealloc);
  	if (pipe_is_full(pipe))
  		wake_next_writer = false;
  	mutex_unlock(&pipe->mutex);
+	anon_pipe_free_pages(pipe, &tmp_page_prealloc);

All that aside, I have no idea about performance impact on arm64, but
there is *definitely* some throughput lost based on the fact that memory
copy is restarted per page. I presume arm64 has an equivalent of amd64's
SMAP which again will not be free and is paid for every time as well.
