Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910937C934
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479331; cv=pass; b=mcRJ3+R3LFJH96OedqmnAtMxsR2suQPAebUeePv6xerwB2rA35ZXMlOfNdoCSNo5/thEwW+wBxiBTstXu9hAbHzL4KBKqVQIKquMqG/vNCDfCBj0okQCxDYzcu95i5wIDtMmt+Mq2H5HgOoDwpHTSKHKPGMxpgf7PdD/jmaz7UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479331; c=relaxed/simple;
	bh=/UoHjOlN3xawNIf1F5ryX11h4JGww68rYrXSIAkZJRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZagEVrRpZ7gp9PmbeD4s8w7EhfZ1U2sDWpwLoxp3CxPtULPcG5XfqCzYsjRa6NN1SbDoRM8uk/rXo12qw/wo4T4QxyAC9WpdlILrRn58jFW6ae6UN9k+VS9ADE1yFzMvnm7vZR+4OiIGvNMy6KwU3kLHmfq2thsnqNXNrHjY2g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4SqXnXV; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4SqXnXV"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd2087858c4so1500560666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 12:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779479327; cv=none;
        d=google.com; s=arc-20240605;
        b=POoNAL34t5K0Ivlnb8EAFM0RK5Y9pcd8qsn/c9FM6uN+8OXb4SoKYTkEPhSUZ+/o51
         yzhh13HQbayIoGRo1Z+lAuhnzzf7YByhcBKwwD3buL6kuJsXkGZXuxiafEJ88/2q/uCa
         lDyBLfxIlehUecH9lFYavH4o45bMcB79f46Nql+WVAo2kMsN3j2/cnAvv/n+pMFjtlew
         +gUULDeqSzf4uUEsGjJ4km9mF92Ab9OBwiPOQdc+P7hudMDWu/THo2oZgJlstbBFePd4
         O0LGXya5vWTLW4fHA1SKxP0gl6CNilbF17+gwMtG3uJsQe4dmX7RhIr2xlE25L3PCP0w
         7cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SjTamPpbto/HfM8byrwNWfIswXwrk9jmy9Vl3IViybw=;
        fh=6IYkJSOLF+X66/pVj4NzDRu3gGLxqlIxaaBB9G+yOb8=;
        b=lPYg3aQNPI3q9Rj3XPwsmKfb8QBMAsi49uB7g/siZYcl5uHPCvSdGR7Nzotzpb47I3
         VXzIYZaPDAjehrTVKNdfjlp3X1id7FU31UPbjLI+KW2DPU1bHa+4WPe0cKu/vYWR7Un+
         el0C8KisneVdfsihInjVlQ9aWw0+S8kgKTkJA47QPtH1VXmtzZRUNKZPs9UeOgZpvm/S
         FDqvsRMIVQgBk2lnFBomDZTrE9vWWBJZRrsCfbSeCmArdICsUbrw5mlM0Mot/MUp9Z56
         lYk2ebp9ELmmSyULHODFyNr8A3j/FAzLqof3b0TexgWKUFifOI3Bw7u3O5LSgoIRKTBz
         5jxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779479327; x=1780084127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjTamPpbto/HfM8byrwNWfIswXwrk9jmy9Vl3IViybw=;
        b=g4SqXnXVLIrx0YRIQZzxbpACbqKJG8UEXPSJk8nEq8QQiERvrj47BM//x/jMoKuTps
         zW0ZKZW++GqETNxxNb+tPTYFZWQc6h/iqxB17JTLHkztEdNZJhshMEEylcHBgFwNg6P6
         Q2Kp9aURgZpApLwN8qR995VZpJKp0E1sqJOISSOs772PTD0aSXxQT9ov3ergNetA6Uz+
         /PAfLp4vWgwr5zKBsRy4IHu0XMAGFcRRYZzy2eqXarEfge0SNwQsF3yU9+vqGaEAyn1D
         JZ7/aXtdZfjLf9wpeD4hbPi/+FXD8nN2IdowVPqZqTvtSPs2UoMjR8avfUnJ1etQgZ/D
         dzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779479327; x=1780084127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjTamPpbto/HfM8byrwNWfIswXwrk9jmy9Vl3IViybw=;
        b=O9I339VNHKif3dMRLWvFgUu6Woq76CkRemWwn9qytYnJfTSVVxFnvAmzGCrev1SWX2
         Od1B2epl/hE2mckr4UP2VdVA+QjAH0SQyfAfiwu4MHYYNuvNyzY1R4lE3h5fYvexq1cp
         FdScGVUQY6V0KJyqhSf4dBczaH0eu+D4ZJAEgyAGxMlPHM+KpheNOQ1fv1wAWkYjGNFV
         2fIG16wCRV2PPHuznEgn2Aez3LuwnL8CxxcsM1n7r6HaEg7iWNqyDfuZd12PbNQo6kNM
         fwipfs8kGAU2JAH215wNeJAGIy7zF1jE09M2XQUtgSvypJqsi1ehc0hJ6mJI+yD8M0VY
         hkqw==
X-Forwarded-Encrypted: i=1; AFNElJ9abzeeGOj6F9WA24BSp/dlWkBU8+8npw7odPjYCcH+sjiFyqgRpp9B0srlZ78HxxnIKuY/xG2qmLK/joht@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzmTAyP76HXpWQ+C3MJdXF7Rf+j4v4Ff7/hPvwBk6X8pSCQ46
	RgU9csdhUQAirLULRFUDjlN0lSHtWg5sXd/H8Oaj5CReuSvJOI3iO01RMoA7S9nC/6x+snNYr8g
	GAATAeMn70zdU2jdzQZvO0xxg8Tb/Eys=
X-Gm-Gg: Acq92OFVie9lqbj0zMgyNREvMXGA//1joHdsQhTMQa9I6RKk3WzXdnDv7qVmHIJQW1q
	Kr3pvpzeF/VXD/C/5Xdtxj+hNV5SIUPNOsM44ow3NggfeYETwrdJFP+WAUczfpQ0OqgR730hchj
	Fc4XswjGoxQU5hQKwFavVzmd881LArirwsyMIVf8TAd/tjkDJpeAkMG+NIOAC+oauJeMxYwrKiT
	Fi7qD0Nn4FGm5KqDQEi0m3ouRkluGDjLhbUJcxzGcj7/1gdp+zzsbLGa6+t3xJrGQWYAhJL1yw1
	ZlBfpxW+qUDLQdLWW6KnMtDKSgNKCqppiwrHN4s=
X-Received: by 2002:a17:907:cf8c:b0:bd4:8bb6:3d52 with SMTP id
 a640c23a62f3a-bdd279d1b3bmr310255666b.36.1779479327364; Fri, 22 May 2026
 12:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org> <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
In-Reply-To: <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 22 May 2026 21:48:34 +0200
X-Gm-Features: AVHnY4KgBXvyBNU6QbNL7Mc36DJq7cwJqPP3Ok4mTlxAnVRZmoYkpIZkIWkzn94
Message-ID: <CAGudoHFZkzXjzYcTxzmaMbLg0Sfh49sTcqiCoMVh9KU-d3eP4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shakeel.butt@linux.dev, jlayton@kernel.org, oleg@redhat.com, axboe@kernel.dk, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:44=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> anon_pipe_write() takes pipe->mutex (aka "mutex protecting the whole
> thing") and then, from the per-iteration anon_pipe_get_page() helper,
> used to call alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) once per page
> while still holding it.
>
> That allocation can sleep doing direct reclaim and/or runs memcg
> charging, which extends the critical section and stalls a concurrent
> reader on the very same mutex.
>
> Just pre-alloc the required pages before the lock in an array and just po=
p
> them inside the lock.
>
> This can improve the pipe throughput up to 48% and reduce the
> latency in 33%, easily seen when there is memory pressure and direct
> reclaim.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/pipe.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 102 insertions(+), 3 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 9841648c9cf3e..cff255217bbfe 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -111,16 +111,76 @@ void pipe_double_lock(struct pipe_inode_info *pipe1=
,
>         pipe_lock(pipe2);
>  }
>
> -static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> +#define PIPE_PREALLOC_MAX 8
> +
> +struct anon_pipe_prealloc {
> +       struct page *pages[PIPE_PREALLOC_MAX];
> +       unsigned int count;
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
> +                                       size_t total_len)
> +{
> +       unsigned int want, i;
> +       struct page *page;
> +
> +       prealloc->count =3D 0;
> +       if (total_len <=3D PAGE_SIZE)
> +               return;
> +
> +       want =3D min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
> +                    PIPE_PREALLOC_MAX);
> +
> +       for (i =3D 0; i < want; i++) {
> +               page =3D alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> +               if (!page)
> +                       break;
> +               prealloc->pages[prealloc->count++] =3D page;
> +       }
> +}
> +
> +static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *pr=
ealloc)
> +{
> +       if (!prealloc->count)
> +               return NULL;
> +
> +       prealloc->count--;
> +
> +       return prealloc->pages[prealloc->count];
> +}
> +
> +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
> +                                      struct anon_pipe_prealloc *preallo=
c)
>  {
> +       struct page *page;
> +
> +       /* Drain prealloc first to keep tmp_page[] hot for later small wr=
ites. */
> +       page =3D anon_pipe_prealloc_pop(prealloc);
> +       if (page)
> +               return page;
> +
>         for (int i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
>                 if (pipe->tmp_page[i]) {
> -                       struct page *page =3D pipe->tmp_page[i];
> +                       page =3D pipe->tmp_page[i];
>                         pipe->tmp_page[i] =3D NULL;
>                         return page;
>                 }
>         }
>
> +       /* FWIW: This is called with pipe->mutex held */
>         return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  }
>
> @@ -139,6 +199,38 @@ static void anon_pipe_put_page(struct pipe_inode_inf=
o *pipe,
>         put_page(page);
>  }
>
> +/*
> + * Stash leftover prealloc pages in tmp_page[] so the next write to this
> + * pipe gets a hot page without entering the allocator.
> + */
> +static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
> +                                      struct anon_pipe_prealloc *preallo=
c)
> +{
> +       int i, idx;
> +
> +       if (!prealloc->count)
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> +               if (pipe->tmp_page[i])
> +                       continue;
> +               if (!prealloc->count)
> +                       return;
> +               idx =3D --prealloc->count;
> +               pipe->tmp_page[i] =3D prealloc->pages[idx];
> +               prealloc->pages[idx] =3D NULL;
> +       }
> +}
> +
> +/* Runs after mutex_unlock() to keep put_page() out of the critical sect=
ion. */
> +static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
> +{
> +       while (prealloc->count) {
> +               prealloc->count--;
> +               put_page(prealloc->pages[prealloc->count]);
> +       }
> +}
> +
>  static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
>                                   struct pipe_buffer *buf)
>  {
> @@ -432,6 +524,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  {
>         struct file *filp =3D iocb->ki_filp;
>         struct pipe_inode_info *pipe =3D filp->private_data;
> +       struct anon_pipe_prealloc prealloc;
>         unsigned int head;
>         ssize_t ret =3D 0;
>         size_t total_len =3D iov_iter_count(from);
> @@ -455,6 +548,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>         if (unlikely(total_len =3D=3D 0))
>                 return 0;
>
> +       anon_pipe_get_page_prealloc(&prealloc, total_len);
> +
>         mutex_lock(&pipe->mutex);
>
>         if (!pipe->readers) {
> @@ -512,7 +607,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>                         struct page *page;
>                         int copied;
>
> -                       page =3D anon_pipe_get_page(pipe);
> +                       page =3D anon_pipe_get_page(pipe, &prealloc);
>                         if (unlikely(!page)) {
>                                 if (!ret)
>                                         ret =3D -ENOMEM;
> @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>                  * after waiting we need to re-check whether the pipe
>                  * become empty while we dropped the lock.
>                  */
> +               anon_pipe_refill_tmp_pages(pipe, &prealloc);
>                 mutex_unlock(&pipe->mutex);
> +               anon_pipe_free_pages(&prealloc);
>                 if (was_empty)
>                         wake_up_interruptible_sync_poll(&pipe->rd_wait, E=
POLLIN | EPOLLRDNORM);
>                 kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> @@ -576,9 +673,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter =
*from)
>                 wake_next_writer =3D true;
>         }
>  out:
> +       anon_pipe_refill_tmp_pages(pipe, &prealloc);
>         if (pipe_is_full(pipe))
>                 wake_next_writer =3D false;

maybe the new call would be nicer moved below pipe_is_full, but that's
just cosmetics

>         mutex_unlock(&pipe->mutex);
> +       anon_pipe_free_pages(&prealloc);
>
>         /*
>          * If we do do a wakeup event, we do a 'sync' wakeup, because we
>
> --
> 2.54.0
>

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
