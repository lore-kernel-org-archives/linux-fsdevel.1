Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72222423A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605217; cv=pass; b=BtepJJtIPeEHwj7/xulbAZIEuiIz1H2CpaXRqoE8SffDoHsCigLUvelFLQyMFA2gOugX383jhoDLkhjUr0qx3srC0m+H/0ay5Z334Q+pebmigZBvYT6RnboqCa2ET/3i83Nb1Lmd08jSPgJ13huAcf8dFswBP04SpcMIlClO6WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605217; c=relaxed/simple;
	bh=tSJWwq84q95ApnduCxNoUcHByxRiIYQfWDxl12c8H3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FytnRErirjQO2L88Lf7iuwo0r2mkWIIhpCfQCBNyCTRV7XlKpfCvhH4S6ack+rwKyr1UV3KjkzMtxyHxJpE4nBZ6Iqvu3L2w6+0p6rlWlg9151N6JicI+jVlFyNHaBxmq6VzI2X83SWGXNaXTRwrvpsD3J6awCSIb8ZmmFDAdds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po/q4JJl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po/q4JJl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so1319968a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 06:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783605214; cv=none;
        d=google.com; s=arc-20260327;
        b=EoVtOWmIfWjkb/Ph+xaSXTSTDy6PhMOLyvjQx6nxhccFI7qVYipRb30nWPLaGMc4z/
         srPsJUgqPWFgzZyBah7SGLGxLfrK4+mgzwERI6/MqQb9ANdQ1y1bZ+frgRqadf44sCWR
         1aaEpIR3biP3xX9W3TPSzXAjdlfpP30eMFcorSAo5Dr3srcNXUG4ebpgfT+v19mRcF73
         FsAcbuoI+Mdo/z+lvVYNSzQ0Cg2RHcWOY7vg+OpnutcfeQHDANwJS6m/fzUlbfDMV3Ea
         YBK4DMmifOclx8PB0LvDZ65l0yjoc1BFur35dQ5v/remXkwpJKCFPm//2f5B81f9T1u9
         XKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dWE9BSevR1rat9QrXZiEn6SQipPU36RTQZB/HLU9Gfc=;
        fh=56chZDCr4cKXfx6DtEazSyxc3I5m3h9rmVSgzRTRn2E=;
        b=Uz0T+6bQLoQpBmg/ZVqjU0YYMAeA3RvVBwajpen8saqsuPbLyCKpE/Xp+38RvAXg7W
         wJJoc+unr8aKmkYFftHInVrgUs4hKsv+DaIaeRIi/3iA5a0w05C6q5d7HuOvQdxT+G2U
         Gr1pvt3TtBXZgCmwSrtXfjyKFkm5agN0wIQoz25TX7aI9tcwtrDpt5gI5HW1191N4XYl
         lRFHWgI0xgS5Cfh/HluxW+5+oGOv9HUr/7v7ZVkR4C5mUNwtNjhedtrx1pvi1sgf40Ap
         5RJfzqhHFJFdEolyN0h9NzsccvO+KLnNXBESmypCZ1xMuUEKmvC+P1VNcuyxGpHpnR25
         azMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783605214; x=1784210014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dWE9BSevR1rat9QrXZiEn6SQipPU36RTQZB/HLU9Gfc=;
        b=po/q4JJlg0Aza9OsQs192HzqhPrh+jqnG91sffoRbOXx0K3CFckxU4/v/6fpYYOQ7A
         70ahNjKsUketsW1tdQcvNWoncGgpvtW9Iy1Megg0sv4u/0GaqR/aiMq+iFLJSoTtywa2
         HuRD3Blil/KBIdvxLb7w5pHqSOoDo6zL6QStpkR04qGXoe9wSwYOkcRZhge4hbKs3kFn
         8RiqaHULJUfeNRQKP2W0FVr7ExWbo9e2SSGYFjgzc0mmDhEOSp3phyBEssa0YrhqmGwR
         aDESKjMpTzKFcGpQT+dkW3go+6O+cDuLy5HdGDVvvcBKD+S7N1E9vOydQVgaULI5ufU4
         a6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605214; x=1784210014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWE9BSevR1rat9QrXZiEn6SQipPU36RTQZB/HLU9Gfc=;
        b=Euc2+ZjVj4BWL6zVYyGRhw10sQMlvmKQ+aCtsLz515amzdtl5PqY1prBFYyYGBmPhW
         BnwssTbkcXyU7s8Fpw8taSdIBCTXuajRi+HiDo4wB4zwn4Mq69jdE00jX2/H5O27V9RA
         sbHohxi8KrlZoCeixBsFAlj1yiW3tmq1Gwq7Jb5janMKY8GYVTGT1+z3ctvnq0Z+T7nd
         kcvKbeaK35A18VKvfxtXPa1Mn0ZitctF+Y+0jp9M+1yWoD/gh7SPp71F4zY2w1YHTSHY
         uQcFgNJqlgNLN/+WX0fDq7Uil4pQJsFE05nNGhzbUtntl1m130im1LSQbGPUtcihWLtI
         lC5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp2r6fA0bGCC1tQWEayD+89qbeMqbJtw3zs96gW3cWQKVtVv7JT439uRXrVcTnlqk8DPfrI7OdQ5FxQl6p8@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqz8bna8BcC4j0FgQPJpL0g8nAVv0wPA69tJrxImSOCGWTruF
	N01ijHDBEkZvqcNDS5X2oqxEi2FAZhDNBVLdY1y7w+K+wF90Etji++Vt6yP449nirE9UPapCb9/
	9bjkQKjwxF1S8IyQUtgrfihnOUD2yAz8=
X-Gm-Gg: AfdE7cnSU0ozYDipnElte+q0vRvx1lW5n4pnxV7YZO4eaLafpEYOc//mpcqkQQ7cPKj
	mXXDUD6wTDoFU8Z2tnj1sGALN4rcSF63uN/53xeV8XLaHt/Co+XAzwVV8IcSU5yyLGPT0ofHKq7
	U/QApTvIPoRFRz1s3YbgmdsJJBUUr6CKrtoH/Spttq/L4pXvqWZaYJ/OeHDUynB48AZu7/p5s7O
	coKAmUnYRsgZ1TY4pWJZCdOxBApLxdMCVgWnCCOLgYz5rWIUCS5DxmgUuZbjqurktr3/Xkfx8db
	70kjxm+7ZCzTWTBeHFwhcycuf4ai
X-Received: by 2002:a17:907:60ca:b0:c15:bcb0:fc5f with SMTP id
 a640c23a62f3a-c15ce0efc3amr274644366b.47.1783605213458; Thu, 09 Jul 2026
 06:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-b4-pipe-unification-v3-1-80cafe097681@debian.org>
In-Reply-To: <20260709-b4-pipe-unification-v3-1-80cafe097681@debian.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 9 Jul 2026 15:53:21 +0200
X-Gm-Features: AUfX_mwdBywjaEyFjHUy7mPm4JVVuAImtuYhgqLsYLFOcqqHVpkXv5Z_tN-O8tQ
Message-ID: <CAGudoHHEKHzdc6nQCNKP6jN=K7oOaeAKso83At_X_==L76Zd6w@mail.gmail.com>
Subject: Re: [PATCH v3] fs/pipe: unify the page pools into a single per-pipe pool
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, oleg@redhat.com, 
	josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org, axboe@kernel.dk, 
	shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 3:38=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Pipes keep two separate page caches:
>  a) A the per-pipe, lock-protected tmp_page[2]
>  b) An on-stack anon_pipe_prealloc burst pool of up to eight pages
>     filled before the lock
>
> Converge them into a single per-pipe pool (struct anon_pipe_prealloc
> embedded in pipe_inode_info) with the same budget as before: up to
> PIPE_PREALLOC_MAX (8) pages, trimmed back to PIPE_PREALLOC_KEEP (2)
> after each operation. tmp_page[2] is removed.
>
> Pages are still allocated and freed outside pipe->mutex; only the
> assignment into the pool is done under it.
>
> anon_pipe_prefill_and_lock() tops the pool up to the write's page count
> -- and returns with pipe->mutex held, so a write acquires the lock only o=
nce.
>
> anon_pipe_trim_pool_and_unlock() trims the pool under that same lock
> before dropping it, then frees the excess.

One nit, but probably not worth respining: the naming is slightly off
in that either both routines or neither of them should mention 'pool',
as opposed to just one side doing it.

Perhaps Christian would be kind enough to either
s/anon_pipe_prefill_and_lock/anon_pipe_prefill_pool_and_lock/ or
s/anon_pipe_trim_pool_and_unlock/anon_pipe_trim_and_unlock/

>
> A huge thanks to Mateusz Guzik <mjguzik@gmail.com> who has been
> a solid collaborator.

well I wrote like twice that this kind of credit is not necessary
here, but i'm not going to insist :-P

that said, the patch reads fine to me now, so:
Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v3:
> - Squashes them into a single patch (Guzik)
> - Fold prefill and trim into one mutex acquire per write. (Guzik)
> - Link to v2: https://patch.msgid.link/20260707-b4-pipe-unification-v2-0-=
eb52bddeeefd@debian.org
>
> Changes in v2:
> - User READ_ONCE to read prealloc.count
> - Trim the pool at the reader side
> - Link to v1: https://lore.kernel.org/r/20260626-b4-pipe-unification-v1-0=
-d23fa6b1ee27@debian.org
> ---
>  fs/pipe.c                 | 171 ++++++++++++++++++++--------------------=
------
>  include/linux/pipe_fs_i.h |  21 +++++-
>  2 files changed, 93 insertions(+), 99 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec575..b14d5bb2b45a4 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -111,75 +111,95 @@ void pipe_double_lock(struct pipe_inode_info *pipe1=
,
>         pipe_lock(pipe2);
>  }
>
> -#define PIPE_PREALLOC_MAX 8
> +static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *pr=
ealloc)
> +{
> +       if (!prealloc->count)
> +               return NULL;
>
> -struct anon_pipe_prealloc {
> -       struct page *pages[PIPE_PREALLOC_MAX];
> -       unsigned int count;
> -};
> +       prealloc->count--;
> +
> +       return prealloc->pages[prealloc->count];
> +}
> +
> +/* Push a page to the prealloc pool. Returns true if added, false if ful=
l. */
> +static bool anon_pipe_prealloc_push(struct anon_pipe_prealloc *prealloc,
> +                                   struct page *page)
> +{
> +       if (prealloc->count >=3D PIPE_PREALLOC_MAX)
> +               return false;
> +       prealloc->pages[prealloc->count++] =3D page;
> +       return true;
> +}
>
>  /*
> - * Pre-allocate pages outside pipe->mutex for multi-page writes.
> - * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
> - * charging; doing it under the mutex stalls a concurrent reader.
> - *
> - * Loop alloc_page() instead of alloc_pages_bulk_*(): the bulk path refu=
ses
> - * __GFP_ACCOUNT under memcg (see commit 8dcb3060d81d "memcg: page_alloc=
:
> - * skip bulk allocator for __GFP_ACCOUNT") and silently degrades to a si=
ngle
> - * page. A per-page loop keeps memcg accounting and the task NUMA mempol=
icy
> - * honoured for every page; the per-call overhead is small compared to t=
he
> - * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
> - * in-lock alloc_page() fallback in anon_pipe_get_page().
> + * Top up the pipe's own pool, then take pipe->mutex and return with it =
held.
> + * The shortfall is allocated outside the lock; the push and the caller'=
s write
> + * then run under a single lock acquisition, avoiding a separate prefill
> + * lock/unlock cycle. anon_pipe_get_page() drains the pool instead of al=
locating
> + * under the lock.
>   */
> -static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *preal=
loc,
> -                                       size_t total_len)
> +static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, siz=
e_t total_len)
>  {
> -       unsigned int want, i;
> -       struct page *page;
> -
> -       prealloc->count =3D 0;
> -       if (total_len <=3D PAGE_SIZE)
> -               return;
> +       struct page *pages[PIPE_PREALLOC_MAX];
> +       unsigned int want, have, need, n =3D 0;
>
>         want =3D min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
>                      PIPE_PREALLOC_MAX);
> +       /* Unlocked read; the pool is refilled under the lock below. */
> +       have =3D min_t(unsigned int, READ_ONCE(pipe->prealloc.count), wan=
t);
> +       need =3D want - have;
> +
> +       if (!need) {
> +               mutex_lock(&pipe->mutex);
> +               return;
> +       }
> +
> +       while (n < need) {
> +               struct page *page =3D alloc_page(GFP_HIGHUSER | __GFP_ACC=
OUNT);
>
> -       for (i =3D 0; i < want; i++) {
> -               page =3D alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>                 if (!page)
>                         break;
> -               prealloc->pages[prealloc->count++] =3D page;
> +               pages[n++] =3D page;
>         }
> +
> +       mutex_lock(&pipe->mutex);
> +       while (n && anon_pipe_prealloc_push(&pipe->prealloc, pages[n - 1]=
))
> +               n--;
> +
> +       /*
> +        * Just flush any extra page that got affected by the TOCTOU
> +        * effect
> +        */
> +       while (n)
> +               put_page(pages[--n]);
>  }
>
> -static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *pr=
ealloc)
> +/*
> + * Called with pipe->mutex held. Trim the pool down to PIPE_PREALLOC_KEE=
P under
> + * the lock, drop it, then free the excess outside the critical section.
> + */
> +static void anon_pipe_trim_pool_and_unlock(struct pipe_inode_info *pipe)
>  {
> -       if (!prealloc->count)
> -               return NULL;
> +       struct page *excess[PIPE_PREALLOC_MAX];
> +       unsigned int nexcess =3D 0;
>
> -       prealloc->count--;
> +       while (pipe->prealloc.count > PIPE_PREALLOC_KEEP)
> +               excess[nexcess++] =3D anon_pipe_prealloc_pop(&pipe->preal=
loc);
> +       mutex_unlock(&pipe->mutex);
>
> -       return prealloc->pages[prealloc->count];
> +       while (nexcess)
> +               put_page(excess[--nexcess]);
>  }
>
> -static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
> -                                      struct anon_pipe_prealloc *preallo=
c)
> +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
>  {
>         struct page *page;
>
> -       /* Drain prealloc first to keep tmp_page[] hot for later small wr=
ites. */
> -       page =3D anon_pipe_prealloc_pop(prealloc);
> +       /* Drain the prealloc pool before allocating. Called with mutex h=
eld. */
> +       page =3D anon_pipe_prealloc_pop(&pipe->prealloc);
>         if (page)
>                 return page;
>
> -       for (int i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> -               if (pipe->tmp_page[i]) {
> -                       page =3D pipe->tmp_page[i];
> -                       pipe->tmp_page[i] =3D NULL;
> -                       return page;
> -               }
> -       }
> -
>         /* FWIW: This is called with pipe->mutex held */
>         return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  }
> @@ -187,48 +207,11 @@ static struct page *anon_pipe_get_page(struct pipe_=
inode_info *pipe,
>  static void anon_pipe_put_page(struct pipe_inode_info *pipe,
>                                struct page *page)
>  {
> -       if (page_count(page) =3D=3D 1) {
> -               for (int i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> -                       if (!pipe->tmp_page[i]) {
> -                               pipe->tmp_page[i] =3D page;
> -                               return;
> -                       }
> -               }
> -       }
> -
> -       put_page(page);
> -}
> -
> -/*
> - * Stash leftover prealloc pages in tmp_page[] so the next write to this
> - * pipe gets a hot page without entering the allocator.
> - */
> -static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
> -                                      struct anon_pipe_prealloc *preallo=
c)
> -{
> -       int i, idx;
> -
> -       if (!prealloc->count)
> +       if (page_count(page) =3D=3D 1 &&
> +           anon_pipe_prealloc_push(&pipe->prealloc, page))
>                 return;
>
> -       for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> -               if (pipe->tmp_page[i])
> -                       continue;
> -               if (!prealloc->count)
> -                       return;
> -               idx =3D --prealloc->count;
> -               pipe->tmp_page[i] =3D prealloc->pages[idx];
> -               prealloc->pages[idx] =3D NULL;
> -       }
> -}
> -
> -/* Runs after mutex_unlock() to keep put_page() out of the critical sect=
ion. */
> -static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
> -{
> -       while (prealloc->count) {
> -               prealloc->count--;
> -               put_page(prealloc->pages[prealloc->count]);
> -       }
> +       put_page(page);
>  }
>
>  static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
> @@ -485,7 +468,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *t=
o)
>         }
>         if (pipe_is_empty(pipe))
>                 wake_next_reader =3D false;
> -       mutex_unlock(&pipe->mutex);
> +       /* Consumed buffers may have refilled the pool; trim it and unloc=
k. */
> +       anon_pipe_trim_pool_and_unlock(pipe);
>
>         if (wake_writer)
>                 wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT =
| EPOLLWRNORM);
> @@ -524,7 +508,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>  {
>         struct file *filp =3D iocb->ki_filp;
>         struct pipe_inode_info *pipe =3D filp->private_data;
> -       struct anon_pipe_prealloc prealloc;
>         unsigned int head;
>         ssize_t ret =3D 0;
>         size_t total_len =3D iov_iter_count(from);
> @@ -548,9 +531,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>         if (unlikely(total_len =3D=3D 0))
>                 return 0;
>
> -       anon_pipe_get_page_prealloc(&prealloc, total_len);
> -
> -       mutex_lock(&pipe->mutex);
> +       anon_pipe_prefill_and_lock(pipe, total_len);
>
>         if (!pipe->readers) {
>                 if ((iocb->ki_flags & IOCB_NOSIGNAL) =3D=3D 0)
> @@ -607,7 +588,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>                         struct page *page;
>                         int copied;
>
> -                       page =3D anon_pipe_get_page(pipe, &prealloc);
> +                       page =3D anon_pipe_get_page(pipe);
>                         if (unlikely(!page)) {
>                                 if (!ret)
>                                         ret =3D -ENOMEM;
> @@ -671,11 +652,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter =
*from)
>                 wake_next_writer =3D true;
>         }
>  out:
> -       anon_pipe_refill_tmp_pages(pipe, &prealloc);
>         if (pipe_is_full(pipe))
>                 wake_next_writer =3D false;
> -       mutex_unlock(&pipe->mutex);
> -       anon_pipe_free_pages(&prealloc);
> +       anon_pipe_trim_pool_and_unlock(pipe);
>
>         /*
>          * If we do do a wakeup event, we do a 'sync' wakeup, because we
> @@ -956,10 +935,8 @@ void free_pipe_info(struct pipe_inode_info *pipe)
>         if (pipe->watch_queue)
>                 put_watch_queue(pipe->watch_queue);
>  #endif
> -       for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> -               if (pipe->tmp_page[i])
> -                       __free_page(pipe->tmp_page[i]);
> -       }
> +       for (i =3D 0; i < pipe->prealloc.count; i++)
> +               __free_page(pipe->prealloc.pages[i]);
>         kfree(pipe->bufs);
>         kfree(pipe);
>  }
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 7f6a92ac97047..4e2e4f44fbe5f 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -14,6 +14,9 @@
>  #define PIPE_BUF_FLAG_LOSS     0x40    /* Message loss happened after th=
is buffer */
>  #endif
>
> +#define PIPE_PREALLOC_MAX      8       /* max pages in prealloc pool */
> +#define PIPE_PREALLOC_KEEP     2       /* keep at least this many after =
trim */
> +
>  /**
>   *     struct pipe_buffer - a linux kernel pipe buffer
>   *     @page: the page containing the data for the pipe buffer
> @@ -58,6 +61,20 @@ union pipe_index {
>         };
>  };
>
> +/**
> + *     struct anon_pipe_prealloc - per-pipe page preallocation pool
> + *     @pages: array of cached pages (pool)
> + *     @count: number of pages currently in the pool
> + *
> + * Each pipe keeps a small bounded pool of preallocated pages to reduce
> + * allocation overhead during writes. The pool is bounded at PIPE_PREALL=
OC_MAX
> + * and trimmed down to PIPE_PREALLOC_KEEP after a write completes.
> + */
> +struct anon_pipe_prealloc {
> +       struct page *pages[PIPE_PREALLOC_MAX];
> +       unsigned int count;
> +};
> +
>  /**
>   *     struct pipe_inode_info - a linux kernel pipe
>   *     @mutex: mutex protecting the whole thing
> @@ -68,7 +85,7 @@ union pipe_index {
>   *     @max_usage: The maximum number of slots that may be used in the r=
ing
>   *     @ring_size: total number of buffers (should be a power of 2)
>   *     @nr_accounted: The amount this pipe accounts for in user->pipe_bu=
fs
> - *     @tmp_page: cached released page
> + *     @prealloc: per-pipe page preallocation pool
>   *     @readers: number of current readers of this pipe
>   *     @writers: number of current writers of this pipe
>   *     @files: number of struct file referring this pipe (protected by -=
>i_lock)
> @@ -99,7 +116,7 @@ struct pipe_inode_info {
>  #ifdef CONFIG_WATCH_QUEUE
>         bool note_loss;
>  #endif
> -       struct page *tmp_page[2];
> +       struct anon_pipe_prealloc prealloc;
>         struct fasync_struct *fasync_readers;
>         struct fasync_struct *fasync_writers;
>         struct pipe_buffer *bufs;
>
> ---
> base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
> change-id: 20260625-b4-pipe-unification-aba7b8525de7
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
