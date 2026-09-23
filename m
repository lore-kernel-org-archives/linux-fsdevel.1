Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4C39D3EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132811; cv=pass; b=M6k/2l1EepNyvng9jlei0ebZCgWQINhbJJNtcB4ip4GffFIkBD32ZZ5FIsYd3QDQ8Z+NPRrrdM4RHCykMfGy4BkgqGIBiYUVui8gzSbNV3plHlvCCT9AQuCQZ8YCZpQE7hr6kn/T9XGlNG+23e7K1D8vxCxzmh30jucV6JVoJAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132811; c=relaxed/simple;
	bh=vT5rt2ey3w3svwWjeKYR1sh8KkF6JvEusbX1aNDa9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk5uZ9vFMtmSimxBfRFYVfKdaLekXRT7HzHfdMMEr9E3d+YETODWpjYY4/i0lsVh7prv7xkds+rmIYQyOhl303nhz15EWgbpetM/HPFPBUVix+rZen/B77sf/S3s/JoXdJlzFE/AIZxP9gENI36S2ibYSh8C0gQpJewxMBe90ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkqdbz1W; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkqdbz1W"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530e8c6fb80so76581cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 20:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790132808; cv=none;
        d=google.com; s=arc-20260327;
        b=I2DWJkhkfShSZsr1wdObVVSHB5fu9SRYRd42IRBmIuZUjF4O1U4E4qzjrhITyDJnTb
         aXohdpblEYBGxOLxcgW4/DG9orhdRLMbA9vtb+dde25jgwNn8LRnJQEnwvHhU5xzcnaO
         CauOUwlmbjXzW8wAOiWJcMGB8SAduriegeayhMxv4xbmzDZlo9xNzOov5Wob8yX8eP4g
         RRTcDaQTEzG09zgwd9BSf0N1mKTF6W8eBy1HWOxHJJfKTFoNg4lHN/Ss/HHvttt1JZvr
         DsaAMbfJR1McqaPeFjncZ7C9OtLM7bKjzbQdcW8uNI7ND86rsaIND/oquRUoQP5uYzf5
         pQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        fh=dzF2K4TPbUGxYzyKXJMM/u/2cO/SbBQpuspA3mwIfYw=;
        b=SCTmmogM9B+8NIDkq3YGTScAJ5UFouh3wz0Ek4ksA52b0jNWd1m1Zk1gG54pfPe6af
         pVJLs86rW8MkgN5LoklfGUaRU+NxIBY0XJgGVBU6JcMbAq9og1tE4Kruk7aLLRzT2/B3
         YOueeQ9qfKgUGWVpJ8o/SnWgel+/rCuZI9tOQjMny8kBTYZj3e5IfvYgqFo+AIqVcDEk
         os+nnttuHFS9hYyx0juKyHE6mqiY+64z/GS4uQWp95sz7arwRQZg5JWwA3xTbjkcJG9f
         ucoLSt7XRc2msMILqveZOybIIH83pcY8WA/zbYyYc+kdnV7QL/ro3LMc5e/ARNCaAKH3
         ek0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790132808; x=1790737608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=tkqdbz1WTh9MLZMRkwL/260pmn7Fk+2Ky3gh9XgMW/pQdnn8Qi8tZe1JrA0UAdd8if
         AqWNe+jJqpg6YfGhr6gzYK9be11OZXLGBgO+qDqS9xvaXtiohnywhDqNrR9juqksshG6
         DK/eHo1eu4aO4OK3kMIDXRrGT75jOcAU5IqZOsxHCgNiwJ+OoSrNC895Pj1THG2xtqfX
         lOtAM+3N4GwohyfYVPhrWC93snePHqnvZW2OAuN6t24Rw2TvLXLwYHCB400pr0CBcsRq
         0/2lTpP0X2FIwZhs7Zfbx1IlsiaXbT9L8YoLoEqdErjUYsq02SJg6+Sy9cu25JXweDUr
         /Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790132808; x=1790737608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=z1LxRNHdugmGHZY8x1zxkDeB38gG8RwXNA1rngwK3qrSVlMvbpzD52+1VDu1PDSesk
         +L7ya3jhHZ8rp1DmNs9YFWpmqS2GhSS0mSa57HR5M8JvSKzUQjRjxASKsJ/952V2M+lj
         Bcp7VXZO0VYLZd7b9JTWQ6MJoWQk4Mk5s3j6YZTFNyAHK5lAifVw0Mh1ukgrpIomrvoA
         6yburMzaz2x1AYcKqBAOnruFYvcMzLAxW+ZGH28Qc+7qbat7R3n13zeTYeYauO4mmoUr
         i/nYxRxZgkvLmjDB69YSoTndvtmysulnR1cQKDRJd1VXdlfstEWOrLRvqFPhgAZ5G+7J
         SAJA==
X-Forwarded-Encrypted: i=1; AKwUvBwoo+3zYzYmv2znmGBxJj4WFB45e3CEnH+toFvFgyyZjxx3XQhqVYUgKec2zDyrP8qZUkxCdsvDRna/RvzA@vger.kernel.org
X-Gm-Message-State: AFuF++nw7saJVr0chq2Tb9s3uuDigpqKo94z6c+fMQs3LaUHk4lUnw6r
	XjyRnvYUkNi837p89h/3hHY5oApD9ArryXNj5z8jq7jhjvAYBxeMnRI27gML3aJ8831WiagSLgu
	CiyGWBG0YgD/mQtSjPcoiZ3xx6T+3xKRl7fgDZtyR
X-Gm-Gg: AYBFou1321CK5DT66e8vS5KZ3o8uXW22S2sbeTiF0RMTNchuSzKaX01Pl003RXPQEJW
	Mybm7ZiEZ5Lb1dwiOxRF+MfSaegPR/Q97vkkynNoJtyp9QAoC20IS4TE+YZfd7513hLsrMUGxKx
	TLf0bU3ZqJfuyNg+svcxls3t/w6MB5St5w/2O3Tt6nOXS5MO7t1SdSFXIlAauMI/LRXTu27dI28
	1EC6NZ5CoFcv4AN6ScOFLUB3clGyvolpqx+d3coCf1+Y32FHQa8D+ET4XfwYgIcUAc8csyvXQtu
	6YJXeGnq7tvucTPwVEgKWH8gpzPuO12uR1jLXJE26Zhec5CGJoMv2prYAIT3d+6I
X-Received: by 2002:ac8:5d92:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-532ef021d33mr4455851cf.10.1790132807938; Tue, 22 Sep 2026
 20:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922023541.51532-1-hao.ge@linux.dev>
In-Reply-To: <20260922023541.51532-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Sep 2026 20:06:35 -0700
X-Gm-Features: AclHuK_Ckf9BkzjT2yz5Z9Ieaus86uHwwpQxqkJxhDMBAS12Kru5JUofGg3dI-k
Message-ID: <CAJuCfpEFxn6peTwkE=orOuhSBchmuziYK1Xt75iwJo59rqYUQA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix missing alloc tagging of direct mempool allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 7:37=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
> adding a mempool") added a mempool for the folio_queues and made the
> request, subrequest and folio_queue allocations distinguish between
> writeback and everything else.  Writeback is part of memory reclaim
> and must not fail due to ENOMEM, so it allocates under GFP_NOFS
> through mempool_alloc(), which may dip into the pool's reserve and,
> if that runs empty, wait for elements to be returned.  The
> GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
> the pool's ->alloc() callback directly instead.
>
> The direct call, however, skips the alloc_hooks() wrapper that the
> mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
> and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof(=
)
> and rely on current->alloc_tag having been set by the caller.  With
> CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy this leads to
>
>     current->alloc_tag not set
>     WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_allo=
c_hook
>     alloc_tag was not set
>     WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free=
_hook
>
> at allocation and free time respectively, as reported when reading
> files on a CIFS mount.  The allocations are also missing from
> /proc/allocinfo.
>
> Wrap the direct ->alloc() invocations in alloc_hooks() with the new
> netfs_mempool_alloc_noreserve() helper.  The GFP_KERNEL paths keep their
> failable allocation semantics, they just get tagged now.
>
> Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by addin=
g a mempool")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@=
mailbox.org/
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  fs/netfs/internal.h       | 3 +++
>  fs/netfs/objects.c        | 4 ++--
>  fs/netfs/rolling_buffer.c | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index c79c8e69d60c..08ba7f0ebff0 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -45,6 +45,9 @@ extern mempool_t netfs_request_pool;
>  extern mempool_t netfs_subrequest_pool;
>  extern mempool_t netfs_folioq_pool;
>
> +#define netfs_mempool_alloc_noreserve(_pool, _gfp)                      =
       \
> +       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

I think this macro should reside in include/linux/mempool.h and not be
netfs-specific. Something like:

#define mempool_alloc_noreserve(_pool, _gfp)                             \
       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

> +
>  #ifdef CONFIG_PROC_FS
>  static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
>  {
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 7f6a3e912602..0b509c93d4af 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>
>                 rreq =3D mempool_alloc(mempool, gfp);
>         } else {
> -               rreq =3D mempool->alloc(gfp, mempool->pool_data);
> +               rreq =3D netfs_mempool_alloc_noreserve(mempool, gfp);
>                 if (!rreq)
>                         return ERR_PTR(-ENOMEM);
>         }
> @@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(st=
ruct netfs_io_request *rreq
>         struct kmem_cache *cache =3D mempool->pool_data;
>
>         if (rreq->gfp =3D=3D GFP_KERNEL)
> -               subreq =3D mempool->alloc(rreq->gfp, mempool->pool_data);
> +               subreq =3D netfs_mempool_alloc_noreserve(mempool, rreq->g=
fp);
>         else
>                 subreq =3D mempool_alloc(mempool, rreq->gfp);
>         if (!subreq)
> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
> index 424e77a9a109..54867ceaa205 100644
> --- a/fs/netfs/rolling_buffer.c
> +++ b/fs/netfs/rolling_buffer.c
> @@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rre=
q_id, gfp_t gfp,
>         struct folio_queue *fq;
>
>         if (gfp =3D=3D GFP_KERNEL)
> -               fq =3D netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.poo=
l_data);
> +               fq =3D netfs_mempool_alloc_noreserve(&netfs_folioq_pool, =
gfp);
>         else
>                 fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
>         if (fq) {
> --
> 2.25.1
>
>
