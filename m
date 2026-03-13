Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD633A014
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425821; cv=pass; b=Eju+L3JIlQALca4WuIcL2Z4nmOMQLQ+RIxn8I6o6ttdmdBqDYljyskjg+mhppHICoYicWK+XaKBr3tLF40nqB6Alsne0RSKKi2b/NU6uQGmxkGzIuswIK/NlM7eTlP8ycSRXGgEWbqgiY4T3EOPR8mKOGmm+dJCT4p5FPq+D9QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425821; c=relaxed/simple;
	bh=81sp5zNkDtyZLrdzHy5yloVVn0+NQgQiuMTp78Oi9dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0Tyk0ugi7Dz7qKcMBv91A11SIJMv1HO90aNfVIQUznpDnNGtU9h/lFqybWlw/IkqpGn5skyMA7v++VM5FEt5Xj8c/4+EiNHxuyVNEiA9wmqbLcUL00H+3HIx4NvYHuVxG4GIRXBcZk+6d/pU94LSHIvsr+0FbyzTZRYTAUq3Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fqZRp3H4; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fqZRp3H4"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40947c81b31so129376fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 11:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773425818; cv=none;
        d=google.com; s=arc-20240605;
        b=KxPWMaiply/ZGX5ftDRZJ6xjGZDvX53qrOaWUSjGiRKPHgd/Du262n8ETmgc1OqXoc
         rFsET1rdjaPmxFfSsncbN+nV4McFzW7mrsDbyfArnqYbFxOeG9pVUFJsQB7czGMIkC5+
         kcmQMzH2YV4qeMXfobhAkML9hwP1f/ppOtzvlmEi3ifKOtwJKLRSTNBfYqg1v6GZax57
         sstveKkOOcCzVbTrYXLhzyLH/OSk6Jq0g2SJmp5TUp7AADiP1FQ7Fi6MoOgOuPa26ko1
         mqfooQASLmvls6A9HCKwkTiXf+o2kX+tg4By5NU9mPM98ukuwT9WuNSsX5sl2rDTVx+m
         kB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        fh=UKrdPltYRLg20iOoZPQaUaqc4Zkbogt8s/NEhWSyInA=;
        b=JprOz3xqRhsSxuVxuNCas6HesUygTPh+uiUr98dMiNvtUa2Y+DFDiffDgtO0JzUHmy
         HaU7+9A9EmI8faB/IuXVMDwvLV6m1rZfMbQoMHLtlXuYxt0GMFh8rDi8gWd8vwbeed+h
         zWsa1cK+2j5PsRjWuQqayU5lecqU/Xyz/w1XoYC3HhzijvIEtDQtY3fBdNFYj6B8BH7z
         sOzzI5HmqQv2wLfeQ7qFoLU5RoLvaFZkCXqF2yn1WcH0fnZou6EwoEJ7aGAakemNLmKJ
         5cTqIcbvzZ9Fe8py6u4tLFj+Fc36ZXOYgHET995v/q13V6WzQRodOACyiW0j4tK+DyLJ
         EzLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773425818; x=1774030618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        b=fqZRp3H4badoIgOP7mVMTCfYx8U6W7Jw4zUbWA2BQWba3T9XM4a+INz/dssQhlP7sH
         bKfD9JHOr70kdAwxy96gjG7awVh/RHilMiW6ZfMQN8syr2xj+PDmGaTLxg94XYoyGPSl
         uu4Nc78ShNN48U8159m3aZqQUM40sgYcZIx/xGihTL2/efJFdKRkzMtWHu2+3hSm6IbQ
         dSHIYbQs3cCnqwoyvMppFpXp0D6eluqUCWGvxnC2aJ5u+JuSw+BTxgsRNTrZK+91reRg
         tyoqaMFOLNzVbIpNprmLEKyOymc+ZdpCUElk2hH/ee0qRSLwGLtirfUnNAqGP4tCDhbC
         gUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773425818; x=1774030618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJh8pcYYm6MwFOo/3jxeUJum1ZJ3UrkzGjcdUD3bWUY=;
        b=l/ZEddvVlDA2B0F9MACBusj8dnZJFlJnmIF6E0TqnURUaC3K1QDoNJbXR1JM4j4fQy
         79EPx9TYW9qsR4YguXBKAmnWInIUMDGVCdo6hYF4RU5adpkDUiG1BH1AeWWDUomyRzdF
         birLc9j5HoitElZShdzO8KygtWaAUd7J61SF/a1l/iFUuMS8YmwIRv339zYuOZu3Tku+
         4C56zlMx4ZbSFKnabgjthDTBldxqZq4NQMTlKZjox2K9R2XNH1y5eelSJAj3XCj9HSP8
         VBsd4WUepjIoNGJ59ej2KUGmwDORNYcbpW3wzl7/hVOUEpz3R2JwGn5yod0FPsHJyVk+
         0PNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqkLFZKpmAPH6AVmXiQ9Yvngs13vRPYJ2EACI6uyRa6N62hwBOUAlP65Vpe4S+ojz6T2FEcLm/43auAuc0@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZazDfPC/qppVNOs1bC10MwUxr3XOUuwvKKHX69lPrV/DiQml
	GKNCJTVzMvQTCGxS7ZGVEJH/88fvlzDodUaiachY1mYSicEhQSMtYdUaawaxdDQXZtU7FQeAUiC
	TC8UHbWMgSUlXi+aqqskiZoDQlJhNenSJ1RhrcEO8BXytSG08SbXCiMk=
X-Gm-Gg: ATEYQzyz7Zv+0Webd9cTDD37BD5+oB5kiM91o0i7BZYRteeEVd4q4xQ1IMQ0+VBaKeR
	PerHLHBuKN6V15klcOSF5tb3J0S3S90N7L0scW2jQlEGjM1gBVUaaUILAYke2jxgtAtnvLWp5/c
	hu9fxk6q19co+ZJxtrT1Cs198XCR1zxg8DNY4rUg97OcabBP9dTerfFbXXs6FRjCLxRBLxIgDnw
	MKkZ952fyOP6Yn5elOZPG1wOjLhXUJ7VsKhdk/ZrS76y1pt3JVkcN2PJU783zEwqPyczct3wkLK
	xhSJ4Hyb
X-Received: by 2002:a05:6870:e186:b0:417:a04:483 with SMTP id
 586e51a60fabf-417b917bb56mr1813486fac.1.1773425817616; Fri, 13 Mar 2026
 11:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313181038.30018-1-objecting@objecting.org> <20260313181038.30018-2-objecting@objecting.org>
In-Reply-To: <20260313181038.30018-2-objecting@objecting.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 13 Mar 2026 11:16:46 -0700
X-Gm-Features: AaiRm53-iiRo_M1nzFAeOe7YzEsf-F26qWNLVbcxgzTWdi6WMPQJIZGAwqXxCTs
Message-ID: <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
Subject: Re: [PATCH 1/7] lib/iov_iter: fix missing allocation failure check in iov_iter_extract_bvec_pages()
To: objecting@objecting.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:12=E2=80=AFAM Josh Law <objecting@objecting.org>=
 wrote:
>
> When iterating bvec pages for direct I/O submission on a block device
> under heavy memory pressure, want_pages_array() can return 0 if the
> internal kvmalloc_objs() call fails.  Every other call site in the file
> (iter_folioq_get_pages, iter_xarray_get_pages, iov_iter_extract_kvec_page=
s,
> iov_iter_extract_user_pages, __iov_iter_get_pages_alloc) checks for this
> and returns -ENOMEM, but iov_iter_extract_bvec_pages() does not.
>
> When the allocation fails, *pages is left NULL and maxpages is set to 0,
> but the while loop still enters because bi.bi_size is nonzero.  The
> subsequent (*pages)[k++] =3D bv.bv_page dereferences the NULL pointer,
> causing a kernel oops.
>
> This was found through code review comparing the error handling patterns
> across all want_pages_array() call sites in the file and noticing the
> one that was inconsistent.
>
> Add the same !maxpages check present at every other call site.
>
> Signed-off-by: Josh Law <objecting@objecting.org>

Don't think you can object to the Developer=E2=80=99s Certificate of Origin=
 if
you want your patches in the kernel.

Best,
Caleb

> ---
>  lib/iov_iter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0a63c7fba313..852f9ed40e5c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1628,6 +1628,8 @@ static ssize_t iov_iter_extract_bvec_pages(struct i=
ov_iter *i,
>         bi.bi_bvec_done =3D skip;
>
>         maxpages =3D want_pages_array(pages, maxsize, skip, maxpages);
> +       if (!maxpages)
> +               return -ENOMEM;
>
>         while (bi.bi_size && bi.bi_idx < i->nr_segs) {
>                 struct bio_vec bv =3D bvec_iter_bvec(i->bvec, bi);
> --
> 2.34.1
>
>
