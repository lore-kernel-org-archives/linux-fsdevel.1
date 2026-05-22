Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E8347BC6;
	Fri, 22 May 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468708; cv=none; b=u78ySRmjQgASckCVO+0bjAGrF76gBO7K0isVG0G5GCbDsEnmipTJNMt0Jwxxlqow72xLpnNk4Ffu2h9xz0CHEFwkqjXVa+mGeDXZfIJ3+eOhCPyx3g4UR5XlEclgN+eKU92wjTYzNRw6rlquv1YcHsnm8IRgp55Jc+ZMj1zZAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468708; c=relaxed/simple;
	bh=0U2Y/R6879n4aJJI0yjDhUERksy6mXplxbT6ZhXYLKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmxfEZnA/3XNG3T7/3CLogCrfBqPkjyE+1hqjwOsNqkBlXAWj5ncfkUsxIYOzUcqZTgzL6UyqeXLlc4e69u+xZKrEsl5BnbQSX+HbdLUtdZgY/X6qHTokU2moxOOywr66HK14glPJSGhLn9Hx2UCjNXaKamNf1ky6CrFgmijWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP1W9ij3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP1W9ij3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647231F000E9;
	Fri, 22 May 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468703;
	bh=3jGlCPbDWf7XBnBNv1sY+Y92Orx38IvmpNGBbUnaVpM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EP1W9ij3brUQaTqaHo+BD0lEWSAcFDQ1ur394RSjVHnIs511JNdrLGDTsUHnDw/0D
	 jYI+X6NKfpHdzSuAHkDcE/l8SIse9ha1wFhaNa8gFAj7GEYX+1jXlk4Jiw5iu3/K/b
	 RaM1vbfseXVuweE3wZqazr3omlhyoTBqskRWFbXuA6J38ZsXkWmzO/7BoVji98aOdb
	 QHfmIYtBotVRsZ6fN40NjsdVCl5tyi6KHvqAWnnB7BXXRb9AJKVpsQP1PzkLtiyKTc
	 BBBJyouECV6i+qbGo1gYM7jCAIFIqq8o6ZHBX4UV9M3pRp4O2F8QL6N2RCmrcfCWI2
	 88kJGhSwaZS1A==
Message-ID: <024fd2e28a2b9bce470178b8c510ed014b9bb039.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex
 in anon_pipe_write
From: Jeff Layton <jlayton@kernel.org>
To: Breno Leitao <leitao@debian.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>,  Mateusz Guzik
 <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, oleg@redhat.com, 
	axboe@kernel.dk, kernel-team@meta.com
Date: Fri, 22 May 2026 12:51:40 -0400
In-Reply-To: <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
	 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-22 at 09:44 -0700, Breno Leitao wrote:
> anon_pipe_write() takes pipe->mutex (aka "mutex protecting the whole
> thing") and then, from the per-iteration anon_pipe_get_page() helper,
> used to call alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) once per page
> while still holding it.
>=20
> That allocation can sleep doing direct reclaim and/or runs memcg
> charging, which extends the critical section and stalls a concurrent
> reader on the very same mutex.
>=20
> Just pre-alloc the required pages before the lock in an array and just po=
p
> them inside the lock.
>=20
> This can improve the pipe throughput up to 48% and reduce the
> latency in 33%, easily seen when there is memory pressure and direct
> reclaim.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/pipe.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 102 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 9841648c9cf3e..cff255217bbfe 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -111,16 +111,76 @@ void pipe_double_lock(struct pipe_inode_info *pipe1=
,
>  	pipe_lock(pipe2);
>  }
> =20
> -static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> +#define PIPE_PREALLOC_MAX 8
> +
> +struct anon_pipe_prealloc {
> +	struct page *pages[PIPE_PREALLOC_MAX];
> +	unsigned int count;
> +};
> +
> +/*
> + * Pre-allocate pages outside pipe->mutex for multi-page writes.
> + * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
> + * charging; doing it under the mutex stalls a concurrent reader.
> + *
> + * Loop alloc_page() instead of alloc_pages_bulk_*(): the bulk path refu=
ses
> + * __GFP_ACCOUNT under memcg (see commit 8dcb3060d81d "memcg: page_alloc=
:
> + * skip bulk allocator for __GFP_ACCOUNT") and silently degrades to a si=
ngle
> + * page. A per-page loop keeps memcg accounting and the task NUMA mempol=
icy
> + * honoured for every page; the per-call overhead is small compared to t=
he
> + * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
> + * in-lock alloc_page() fallback in anon_pipe_get_page().
> + */
> +static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *preal=
loc,
> +					size_t total_len)
> +{
> +	unsigned int want, i;
> +	struct page *page;
> +
> +	prealloc->count =3D 0;
> +	if (total_len <=3D PAGE_SIZE)
> +		return;
> +
> +	want =3D min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
> +		     PIPE_PREALLOC_MAX);
> +
> +	for (i =3D 0; i < want; i++) {
> +		page =3D alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> +		if (!page)
> +			break;
> +		prealloc->pages[prealloc->count++] =3D page;
> +	}

I believe alloc_pages_bulk() is supposed to be more efficient when
allocating several pages at once like this.

> +}
> +
> +static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *pr=
ealloc)
> +{
> +	if (!prealloc->count)
> +		return NULL;
> +
> +	prealloc->count--;
> +
> +	return prealloc->pages[prealloc->count];
> +}
> +
> +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
> +				       struct anon_pipe_prealloc *prealloc)
>  {
> +	struct page *page;
> +
> +	/* Drain prealloc first to keep tmp_page[] hot for later small writes. =
*/
> +	page =3D anon_pipe_prealloc_pop(prealloc);
> +	if (page)
> +		return page;
> +
>  	for (int i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
>  		if (pipe->tmp_page[i]) {
> -			struct page *page =3D pipe->tmp_page[i];
> +			page =3D pipe->tmp_page[i];
>  			pipe->tmp_page[i] =3D NULL;
>  			return page;
>  		}
>  	}
> =20
> +	/* FWIW: This is called with pipe->mutex held */
>  	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  }
> =20
> @@ -139,6 +199,38 @@ static void anon_pipe_put_page(struct pipe_inode_inf=
o *pipe,
>  	put_page(page);
>  }
> =20
> +/*
> + * Stash leftover prealloc pages in tmp_page[] so the next write to this
> + * pipe gets a hot page without entering the allocator.
> + */
> +static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
> +				       struct anon_pipe_prealloc *prealloc)
> +{
> +	int i, idx;
> +
> +	if (!prealloc->count)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> +		if (pipe->tmp_page[i])
> +			continue;
> +		if (!prealloc->count)
> +			return;
> +		idx =3D --prealloc->count;
> +		pipe->tmp_page[i] =3D prealloc->pages[idx];
> +		prealloc->pages[idx] =3D NULL;
> +	}
> +}
> +
> +/* Runs after mutex_unlock() to keep put_page() out of the critical sect=
ion. */
> +static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
> +{
> +	while (prealloc->count) {
> +		prealloc->count--;
> +		put_page(prealloc->pages[prealloc->count]);
> +	}
> +}
> +
>  static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
>  				  struct pipe_buffer *buf)
>  {
> @@ -432,6 +524,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  {
>  	struct file *filp =3D iocb->ki_filp;
>  	struct pipe_inode_info *pipe =3D filp->private_data;
> +	struct anon_pipe_prealloc prealloc;
>  	unsigned int head;
>  	ssize_t ret =3D 0;
>  	size_t total_len =3D iov_iter_count(from);
> @@ -455,6 +548,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  	if (unlikely(total_len =3D=3D 0))
>  		return 0;
> =20
> +	anon_pipe_get_page_prealloc(&prealloc, total_len);
> +
>  	mutex_lock(&pipe->mutex);
> =20
>  	if (!pipe->readers) {
> @@ -512,7 +607,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  			struct page *page;
>  			int copied;
> =20
> -			page =3D anon_pipe_get_page(pipe);
> +			page =3D anon_pipe_get_page(pipe, &prealloc);
>  			if (unlikely(!page)) {
>  				if (!ret)
>  					ret =3D -ENOMEM;
> @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  		 * after waiting we need to re-check whether the pipe
>  		 * become empty while we dropped the lock.
>  		 */
> +		anon_pipe_refill_tmp_pages(pipe, &prealloc);
>  		mutex_unlock(&pipe->mutex);
> +		anon_pipe_free_pages(&prealloc);
>  		if (was_empty)
>  			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM=
);
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> @@ -576,9 +673,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter =
*from)
>  		wake_next_writer =3D true;
>  	}
>  out:
> +	anon_pipe_refill_tmp_pages(pipe, &prealloc);
>  	if (pipe_is_full(pipe))
>  		wake_next_writer =3D false;
>  	mutex_unlock(&pipe->mutex);
> +	anon_pipe_free_pages(&prealloc);
> =20
>  	/*
>  	 * If we do do a wakeup event, we do a 'sync' wakeup, because we

--=20
Jeff Layton <jlayton@kernel.org>
