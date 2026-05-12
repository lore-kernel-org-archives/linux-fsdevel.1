Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE63E0758
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607986; cv=pass; b=VvkkMxqx3Prz/esP0umgw6qFYJFdyyLErv19J/GdECf34wwvTiVPos06dmSjhOcHw2U/bdSx1xxcU4PbMsO+kSBNHYtPl/d3axgKCsXwlMQn1mEvuvjx8pdOQHlEf6ruzrqM1qAyajAiia130r4SU2EqenSbaIjN8NHvy8BHGB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607986; c=relaxed/simple;
	bh=Mrgr6G0kHwIbc8j4jUJh1eocVZ1V3eXYBjlfyutvb4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2zKnjGYBC0mYmQY4bfxyICvUBoAcDYZewLZ0dq4e1OqDMzgDswrfEJudaYqeMZ3V3+PYPhFLg7ISjrGiDJVAM78AhE3FWHbtBX1vOAGcWVZOJa81TSu99PyeDD52sg7f4BQ8Oyyf0gLRjVoEnZSXxUjgbUmxMDDM1989LRLMmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Iwo0uzcF; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Iwo0uzcF"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6949872d84cso249281eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 10:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778607984; cv=none;
        d=google.com; s=arc-20240605;
        b=iLKNpHKjsrK8rIEJVHgkUqDa06B4syElw5NrSf9nthFNSGs6ctZMOBW8+YYO2zGK40
         6OXJFP34m4Rlvy9lHapCYT2792HOO+Md9t/Di3yu6kQ2ptUdzWwUIbKQUAwwDb3IzOI4
         A9rraNUPU1Ys9heVfojiVdLxX8uY07rzQm7YKtyKdnwPf8nCGBePcwykRQVeYxDc3cUj
         Qwi2xnJl5CgxHtoqaEVnVSgkwlNT9hwohTF4nGcjdLMho2kajoNfTYYh4MSFYBIs0MEj
         XKRxfR6l187Yd9yPwkOyJQpP8U7B4q+v6nM6jPN3sBVHCgZNsONz+YkiFikeSxxUTkfX
         iaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        fh=1I9oyA3IVjtP+g/TYnpzTc/2vMpAmCv2Rmfa9i0U0wo=;
        b=MzJbtEVcBKybK27ClDtcbWj4fM+N6U50fU1XoLGLUlyH4mWL8IFHfT1ytsdG2nQ0Lp
         luP9I0eKK2NSkn9cjR3qw9JX7ByfDCGGdTwMCAq+BxT0lgUDlq1NlZ4cfyNjbwNS0jRW
         5ecGVWIElOfZiiwLIn+D+w4TAjLUcXkA6sflOUqbHbeInaRnySBAQw2Nv+NzqA0tUT43
         OmbpJhIS/T3BC5fsFQXWzrTc+dzAVPLg8HT3og+Y8ONCkfEi5RNth5Mrlh+LmVtX5fpP
         252ukj5Ch3cp4GuO2W1tzdBaoCdHr9w7Z7dgs1OBi6wBtSXa045D9M/6hVsXDs6YPRAZ
         TCCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778607984; x=1779212784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=Iwo0uzcFki397oJwDPOoTKXwX1nbJ21i+0UA23U/HMR1954yhI51NNMAwSbN4+VuAY
         JCXwclucYyC6+XY6eamugvaLMwtAe73F/1ZKE0FMYgABDLRlJmcmbtDv6f8kAsnNyP0B
         GHAQpFkyVIdLRQMF/ttQ/E82YQKEEtPKUGqASLbdD4SlXL6bnDHUOLV4cHdPY5sPegC2
         w5k0PJkKe9L4bz1VFL2llk0m/UghXimx+DsxXv1Woqhqj8X4BL60MgWGjZDp24zc24Tw
         Ydvr5JBrTbMfECbIJnwlkhFqI0o8ZPsq0nKoQekxU1kiixc9vhXp5CKrvxJTJkSzTPHt
         ECmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607984; x=1779212784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=XPfVsR93CG9pULIbHrKvj6vBMoHGpXZWR1XQ6iAeBT+62H8XzaCq5lP8b+FVPSCTT/
         rCR9VQDZJwQIQJKfkyRzQrJFl7dhq3ctnsDACene+g7nWMANlhxndfrChL+aktw6qm9c
         LTN3CTTIUbuJ9SUgZZ1+hMlgH65uCYxAC40Ywj7lPZUGDt75U7bEkf2IX2NR0j2Ty6+x
         L2hq9YKoS49f8PhNz7ZjOiiv9KRqA3Qp3MpvP50WWOhqR8SHLwm4YGBgBmlN5ck38Wsv
         ieI8hr8M1uRCjLW/41dUHwiPZ7TLYreIGhjfznJXDz7+BDKCrhxzwxxLJC6jB0CzLGZH
         09PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9z+fLMRfVIp4j4jwGR7Nra+Eofqe7EjwYy0qSfLHECgLCq8yZ/Pn3xS0NWpbixVl8oBKLID+RFl+7rBOpB@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLr9NVBPuwkbHn9jOrPXw7sgF4OPlu4OFhXQ33+POrgyOnGBL
	nwlcfTHU+OV5KX4Wy8a3pgBA/A4gXx5/c7+QetpmjY5k6fSPv1MsYhSAh6TVxUwypB9mXpnh+vs
	9n1/lS8ioYCM5JZ3Pu3YiRgkzaspQ/YN/xWj29iL/6A==
X-Gm-Gg: Acq92OGoc6YXJsumjRzfzYjE5bvpp0lel8m8Bldt2oDXuwHLFWvUhXuVp8p/Al5bANv
	Yh4X5B5Q2a67goz0+Nw132h0xW1eir5cxoCWSpCZ28PJFUOBpyD45i4kJAVkoR1AquR/GzCS3hg
	SubUADrM/3h8WQLCGR9R7wSKYNu3XRdjygstz3HtW9RVVUnd2vSQwokhheaH9Bf2DoUI+iWgr61
	ExXm93C98pTITrfZLYZKTJNBT+wTeCNJCAkX++K6nz3ckPpWc4WHmhttWPRSG0O3jV9gCujP1AV
	fSp9EXJG
X-Received: by 2002:a4a:ba84:0:b0:696:1d76:9dc with SMTP id
 006d021491bc7-6999a3b813fmr6694789eaf.3.1778607983722; Tue, 12 May 2026
 10:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512170525.357573-1-dmantipov@yandex.ru>
In-Reply-To: <20260512170525.357573-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 10:46:11 -0700
X-Gm-Features: AVHnY4KWcjBva7nw0Ibsy4xgzTd5kc75h1GtStF_42Kjh1hgALO9DNt1vTHxy7Y
Message-ID: <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
Subject: Re: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Users of 'iov_iter_extract_pages()' may provide small, likely
> stack-allocated, array of pages by itself and then reject to
> use it if it's considered too small. In such a case, passing
> NULL pointer means that 'iov_iter_extract_pages()' should
> allocate array of pages internally (via 'want_pages_array()').
> An overall scenario may be:
>
> ...
> struct page *stack_pages[SMALL];
> struct page **pages =3D stack_pages;
> ...
> if (not_enough_pages(SMALL))
>         pages =3D NULL;

The example is a bit over-complicated, this can just be:
struct page **pages =3D NULL;

> ...
> if (iov_iter_extract_pages(..., &pages, ...) <=3D 0) {
>         /* Even in case of error, new array of pages may be allocated */
>         if (pages !=3D stack_pages)

And these checks could be simplified to just if (pages)

>                 kvfree(pages);                                  [1]
>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages !=3D stack_pages)
>         kvfree(pages);
> ...
>
> That is, if you're unlucky so SMALL amount of pages wasn't enough and
> new array of pages was allocated, missing [1] causes the memory leak.
>
> Currently 'bio_integrity_map_user()' seems the only place where such
> a leak looks possible. Older kernels may have more. In particular,
> 6.12.x has this type of leak in 'bio_map_user_iov()', and it was
> found with syzkaller and reproduced experimentally.
>
> So adjust 'iov_iter_extract_pages()' to make cleanup [1] itself rather
> than rely on caller's handling on error paths.
>
> Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list fro=
m an iterator")
> Cc: stable@vger.kernel.org
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: fix commit message and issues observed by Sashiko
> ---
>  lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..30c5baccc6a9 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1807,7 +1807,8 @@ static ssize_t iov_iter_extract_user_pages(struct i=
ov_iter *i,
>   *  (*) Use with ITER_DISCARD is not supported as that has no content.
>   *
>   * On success, the function sets *@pages to the new pagelist, if allocat=
ed, and
> - * sets *offset0 to the offset into the first page.
> + * sets *offset0 to the offset into the first page. On error, new pageli=
st
> + * is freed if was allocated, and *@pages sets back to its original valu=
e.

Clarify that "error" includes a length of 0 but not a positive length?

Also not sure it's necessary to say "freed if allocated"; from the
caller's perspective, it just looks like it was never allocated.

>   *
>   * It may also return -ENOMEM and -EFAULT.
>   */
> @@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i=
,
>                                iov_iter_extraction_t extraction_flags,
>                                size_t *offset0)
>  {
> +       struct page **oldpages =3D *pages;

I think a bool would suffice, as pages will only be allocated if the
initial *pages was NULL.

> +       ssize_t ret;
> +
>         maxsize =3D min_t(size_t, min_t(size_t, maxsize, i->count), MAX_R=
W_COUNT);
>         if (!maxsize)
>                 return 0;
>
>         if (likely(user_backed_iter(i)))
> -               return iov_iter_extract_user_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_kvec(i))
> -               return iov_iter_extract_kvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_bvec(i))
> -               return iov_iter_extract_bvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_folioq(i))
> -               return iov_iter_extract_folioq_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       if (iov_iter_is_xarray(i))
> -               return iov_iter_extract_xarray_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       return -EFAULT;
> +               ret =3D iov_iter_extract_user_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_kvec(i))
> +               ret =3D iov_iter_extract_kvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_bvec(i))
> +               ret =3D iov_iter_extract_bvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_folioq(i))
> +               ret =3D iov_iter_extract_folioq_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else if (iov_iter_is_xarray(i))
> +               ret =3D iov_iter_extract_xarray_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else
> +               ret =3D -EFAULT;
> +
> +       if (unlikely(ret <=3D 0) && *pages && *pages !=3D oldpages) {

The mismatch between ret <=3D 0 here and ret < 0 in
bio_integrity_map_user() would result in a use-after-free in the ret
=3D=3D 0 case, no? I guess this should be fixed by the "block:
bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
that landed today.

Best,
Caleb

> +               kvfree(*pages);
> +               *pages =3D oldpages;
> +       }
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
>
> --
> 2.54.0
>
