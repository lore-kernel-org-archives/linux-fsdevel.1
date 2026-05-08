Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007543358D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265243; cv=pass; b=Zv9sv+SkjigDP4NuJlCZm1qDDrOKPVmKsjsCObRmSzSD3RX+0EeVoObmXMEZ2lI1BBvoGgpeihIPi/KnHMxZg+XtRM/C/57YbtWqRvqvxbgOEWvOjcVJl1/pNqaSNTpVJw2S4a4ERX+izO5iyHcpF/xioUeBQ9bP8G+UYjHzJ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265243; c=relaxed/simple;
	bh=r3XXb9IN5ZVx+jLOe7kh1RVJqYQ8qmUQn0mB+j/aYU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JME1mqFUlxmojVwlJ0gwwq/jfzCLyfI1bHeZPo7Fz4Kmplz7F1c+ywgWOXpvxCqwZJEUXDX3GzLgM6cScxWmyVGmZ6I9B2xlqfwMIfotF8j/y0GceS9xa5/BFsbG0AuPeXHOTdNcH97SvJFE1S+8MGHjHMQDos3bZszV0oKL9qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TxWul6wm; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TxWul6wm"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6948c21f72eso110008eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 11:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778265241; cv=none;
        d=google.com; s=arc-20240605;
        b=i99Soq/rV1MedqTYdnM0eKOe3S0wn60R6C3jQAw0WlPhcFuk+S6eKsYugr8ygzBnpU
         xPNR+VBaG82RWwc5BkVgQFjK6ro+YF0IpZA5HO0al/vYUozMYNXgw+0F5to2ut190+eJ
         O+1MpMcaDOi1km9ehZ1vyggdBTklHgDHtu3KBKfO0nAgv24h+xtLXiRYQExAOD7Qbls6
         XpI9m2TSJ+kcJw42BcW1Ih2DEQMtMD0Cknn1vcVzt5MO2Esk8xXXoc7WupLEqZpeMj+r
         XisgrLoPuFFz3pQsaniKlzsoVWh0jjgV3QvjD/FD9M4HArE59vnvQSA68aJUSaqia1Ur
         536Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        fh=SKMcMXPSa5mb5+XpBG3ox6mJSfMO+dz3rKheMhg5LLE=;
        b=TCLrrWASCm8Xg26hZfR6VsZbb4GnlWe3/D2mxSW1beeN4K2gCc721V5CBatAb12/kR
         7Q8msi6SXlW/cp3wfuTW3stcDSw4lIzkBOBP9gsLKyJ3tCKDJJHfVzm3UsEsIu1Ars9l
         ph56nY8tdu/EzKRmjJ2exdVVkBTN08qhBBnVtKoYUfyeY+xrSSMv8LCx5NpLhlmWYX7o
         LdzuxzcLqJBw3TmVaT+9TuXCJP6K98YElwsCvrTHPzOClPfRFcwPC97RsCX/jbfquib5
         VsvSD62HiWR28GjCi0qIIvZLwpCwQU9eGxZBP5ueijFIeOzxrBDHQgGb0HNoZTf5y3Ar
         UAqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778265241; x=1778870041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        b=TxWul6wmar2qgbWa5kCDCA71H6U0jczZrhTnPm6L8c4/LP8whI/iPF3rdICuDD81bF
         fyv/f8/I5rSWur7buHAqJ93rclHdlhHeH/No54EOKE3I732HGRuA7d0i0j4dRipSMKUg
         dtIgMhZ+LmbZ10RXAzELpiPF0n28uwZRnqdUInNVe8ruhDs0mMcN6fnDbWO0uR2ck6PR
         7Os5qAUm2LpIKDTQHpRr1pNji2/MQFVva2tZ2ZS/4tZf/uQ3qFMoLup8zxJpb0+R9T9g
         R+EOUdQjyvV00yF1A1SWaK+9ITuvkm5Kccwp7lOtW61+x5q+T6+3QS6w41L0+M4N1t2T
         Ot3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778265241; x=1778870041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8nkOfPakqBrzI3UVxelt6anKkv3W2RalwTF2aEOhdFY=;
        b=c3rPqXWxLyTDKrFdCOtN7smSiMalWxIsEJwwpMo7d3Eo8eglIrfX4/4sbYeA5iAWh4
         R8Qm03TjwTBx6w2gkoZCVitu47noSp5N3fkwVuouyBLH4eHBz3aFgh6gsTkk5jEnXxWO
         OelaG885bReawgJkomeOxfs8NNeDQnb6oEm6rqYdNiLm0ICxto0EZdmIgc3QGcG0hFeD
         HOsqvR9zrXKPCfYXndtnVKLmnICRY/z+PfuHkeIZP08Ft3eNEDjQpV2KTU+gowU/HjXo
         n2Gq3aOzdUgb69b0YmNjiudICD+gfmWGmdecwwtDTha40NBRo0wrc9yMCBGR59fNOpIE
         +sSw==
X-Forwarded-Encrypted: i=1; AFNElJ/fZK1S1cPxfQ5dmEUjwu0oMQ3mgbL0cOK0UElZy/s8xunpLaFdrfgQE17kDKBKiJ/yyeZU4UNnn1S3ZLuq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4baMJW3qw4p6N0exJ2ieVjjEzoz9jKdBCqcFB3JM1cOUFjR7y
	zeItVciy1BeBzkdjt+GoY7mM39sWoYHJBfR9usqWolFDCOX25shhEU3U+gWXPybZfRt33tvw8Dh
	SivxHow3qrzXKPkj7nnFi0lc7osYCAope4ulAUNghmQ==
X-Gm-Gg: AeBDietURRlB/Qzt8BWEKUmFPYIALYeaPMGWDvwGpvAd9qgkby+bKdtnWuQbLmnPPZP
	NJBT/9dUuKmsmXZM2Dc6zLajFxKHO1cKwusABmM7Oe7jK7+Fjd7BfhI6BzCYjqIWlWk56fOzUcj
	Oi6NlGILs7+63hI4VM83PNDXK9bq008wXeVGLq1pHxA/P4exhVi+6qbIlZpHsJyT2fPI87vTXi0
	x63LFACBb7mBH6ISsYyCAG+xQG/X8T9b8gDAKS2DIofpDTpCGEbQJcVyfX9oyR/u5jijPzOCqLN
	I7RyH62m
X-Received: by 2002:a4a:c008:0:b0:696:1daf:3e97 with SMTP id
 006d021491bc7-699abb80692mr1912064eaf.2.1778265240827; Fri, 08 May 2026
 11:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508111329.329943-1-dmantipov@yandex.ru>
In-Reply-To: <20260508111329.329943-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 8 May 2026 11:33:50 -0700
X-Gm-Features: AVHnY4KYBHj_X1o9i3IsAyatyr5IiUqrj-vxG_frJgzDpEzijRG1010Eo-aP3JE
Message-ID: <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:16=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> Since 'iov_iter_extract_pages()' may allocate new pagelist if the passed
> one isn't large enough, the worst-case scenario may be:
>
> ...
> struct page *stack_pages[SMALL];
> struct page **pages =3D stack_pages;
> ...
> if (iov_iter_extract_pages(i..., &pages, ...) <=3D 0) {
>         /* Even in case of error, new pagelist may be allocated */
>         if (pages !=3D stack_pages)
>                 kvfree(pages);                                  [1]

iov_iter_extract_pages() will only allocate a pages array if the
initial struct page ** passed is NULL (see want_pages_array()). So the
condition pages !=3D stack_pages will never be true. Indeed, it looks
like *all* callers of iov_iter_extract_pages() pass a non-NULL struct
page **. Would it make sense for iov_iter_extract_pages() to require a
pre-allocated pages array and remove support for allocating one?

>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages !=3D stack_pages)
>         kvfree(pages);
> ...
> return 0;
>
> If you're unlucky so SMALL amount of pages wasn't enough and new
> pagelist was allocated, missing [1] causes the memory leak similar
> to one I've recently observed and fixed for 6.12 in [2]. So adjust
> 'iov_iter_extract_pages()' to make such a cleanup itself rather than
> rely on caller's handling on error paths, thus making [1] not needed.
>
> [2] https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yand=
ex.ru/T/#u
>
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..46dd11913df0 100644
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
>   *
>   * It may also return -ENOMEM and -EFAULT.
>   */
> @@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i=
,
>                                iov_iter_extraction_t extraction_flags,
>                                size_t *offset0)
>  {
> +       struct page **oldpages =3D *pages;
> +       int ret;

Should be ssize_t to avoid truncation?

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
> +       if (unlikely(ret) && *pages && *pages !=3D oldpages) {

iov_iter_extract_pages() returns a positive value (number of bytes
extracted) on success (even if all maxsize bytes were extracted), so I
don't think this condition is correct. Callers seem to be inconsistent
about whether they treat ret < 0 or ret <=3D 0 as the error case, which
is another argument not to handle freeing the pages array inside
iov_iter_extract_pages().

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
>
