Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00F346AE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617192; cv=pass; b=hU1eXm0RC5BFFVyohh6I2iNmyDnmNH6qXuclXZqXH1SLe3Hj0NuDfoj4xsz7uvWGd0QbD8mDTHrhKcTrYxf1n4igSVswJaEI0ioZvcR5R42t8UgtkI1kDYlHeZUt5LlJYnaOKYspWVt5g0wR/C26+zt650vUwO6bmuTdP8xRvew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617192; c=relaxed/simple;
	bh=1ZYm13QgUoFPUQXQ4kS2+jYygS3x3D5t4qOkUCv7AKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjseqbMkQsfmtZSISAME2uTBkNBpey77XNMn2a46QARyCkYI+eO+HXY8se7Ir2na8TD0cBE5METr9Y9raB2cY7GLNza45sJ1oEUa4NXPQxCOL3ICL7q7Tajce4CccbJKuzI4lC9y4qjOkT4aH50tFswbTDFEZ5F1Y2c/kcRSt3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MctGJyx5; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MctGJyx5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so3105185f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778617189; cv=none;
        d=google.com; s=arc-20240605;
        b=SqaIrRItVxNMjRVdeWODhedFO/iZ5LkQTUYWoVFvkuGlkZAl8fSn/GCS6nlzRYt77Z
         1IudVENj3Xhy3Ko9P6FHMDjQU782pK+xIyyNGXNS4q6Tvs13jeGzNZ6aLGqs/6qrtN32
         Zno4SfPY1O9OwirC2IJUotA2JzGvAQqN0CghcE2SjQy3BoDFdOxYIfWSkDl1ng9NNdGL
         lL1JVA3fWtkZudeSKbA7jTP2R0uYMJMQtuAK11NIT7/vSab1sp8rAWb6noGVXnxSCjgw
         q0CNQUOzbwBMsu6gZ8Ntvsy1wiOOcGpbFUxCsAbsj+TA2FtCkkcjGIicE7hswdhVmQ+w
         ZZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Da8Mvrwof7iCCmp8lbUMxECOvSGSCwZitv6kUIUXo9g=;
        fh=FMzr2wctD7iubpJQVvdQ8rOyWVhHY0u6f6qTVC80XGc=;
        b=kRcbeaydg+Xp/ZSuW7L0+qk10c50xGgfJ49p+uXI+i8QVJfPZaMvCruB5ag9dRDXCP
         rUS0U//zFBL6KFQG4wwv/vCZI4y7nlLUdVUfl7Fs8goyh+JAKyvUwe/BrfQ3Mb7+EPqS
         RHAgxjXlXvQFEvux4EalkQrqjNTuE7KebBJ9X5zEzoZVMEATLvuS0yH1penSxOFgPhDw
         MqYY2KX+s5UNq4tnWH1N5ySpjgWNmv7/DdZWhqepusJeNFAoi4nS25S1wLltZQ1jSf3w
         DApJAvx/gxrwRsvUj30xOx9Xpzu3WKUYTTo792SrI8onH2hDrzFIt4kxI9dzUtb5wraL
         ZRjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617189; x=1779221989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da8Mvrwof7iCCmp8lbUMxECOvSGSCwZitv6kUIUXo9g=;
        b=MctGJyx54EjJmqDTZ+Atz6LgKlVMzfUqPd0L5fsfdU6URsHVpKx7w+G/vjcHLBLjhT
         7klU8Ii9eHJotuUiy9o4gfLKYcyqVROwOZrptDSdqD0CuQW1+OTR9nRQRBLoLHNDujbs
         3vUyiwilDoM/k0nDZZCeG8FwB4rQV0I5R9JgZSB+n5vrFKT6SbVK75s34wzKfOBfnJZR
         5g/q55I8ZqJ03D6uBjhtLB1nwtvbepllKvZAnzcnUASLmGQyothHS/x81BPz1wBaVW7o
         1fvopbHnczu5OnT4r1b+oIwrmKqOSWuqmgOfJvP/f058S14AEM4IEBN9JWdrEq72hvqx
         Ch3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617189; x=1779221989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Da8Mvrwof7iCCmp8lbUMxECOvSGSCwZitv6kUIUXo9g=;
        b=RuF73oyC3B5syNyUYZIyp9r3pVtyGNPyhLCnTG4OV3lKanMWYgZHf6MvwYfx1GZBeF
         1h7G/dHSinJfaoRfrg/HS5cXghqL+uOvfH5PAt/kDuSC3PSn0x8qsU1BYggis6n+nhOw
         sHCQH2TeYnZghEbLosLimbLKVQj+njXcT0bgb7DUa20tDNjitt+kLmYDQlTTuSEiueZ0
         KFq8t8bAWzf/QUYtcgK+K36BV88dKiHCrvmY20EL8SMQW0uyHFN7s+GY+1XEHtHX2TDY
         GbWAykA1zxCNXoIl/reVZsj3dQ389/IaZLnD1e37az/aEEP4Z8wST7ymstKWoTjwb7Rr
         l0kw==
X-Forwarded-Encrypted: i=1; AFNElJ/lflY3KLmGcNRUalx0Nn9Sof2dRhoDZDH3BvoUajA7lMoKK830II06zmadsU2tSYFrgCibBvVS4KmMMQod@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2O4rv97JrhJ0CQNWY3aDO1pi12o0s5OlDdE8T/uV0I+EhmKS
	968zEsaktNUSJFESm7gUqGw1MhXjzZglf1QJDaff0D3bwQEJfeTOtFU3ka8W218MJxYK4V+UUBR
	1zFpYXkh6KXmp2itR+hUEUQiK+Di7Z1Y=
X-Gm-Gg: Acq92OGArPm0pF0YTo6gtwEVpiRqMIOoeIjkegY8ZNfFixnw4Wtuaj3lRjZbst1P6xv
	T0wWeQzwp2jTEM7TsddpDFgEM2IVS5nw4lClYe1fbKDXciAv7O+mHr6uoGgbazu2RSVfGynbaXf
	ygsz4rsibrcn/6qCXx9d3QgEsziM6a2GIy4GPM+jN/AgF2iqem8ycH2CAsqN35UW3YR0nhbuBhc
	LYJrw5RIoxKf+JwhauCBoDr2BX4lOyYMdKSg601ItioxcWpkk0+kI7UoTBAwMggjvlVivRz90Ax
	10dQYw==
X-Received: by 2002:a05:6000:1845:b0:452:d03a:7abe with SMTP id
 ffacd0b85a97d-45c58a71008mr414085f8f.17.1778617189446; Tue, 12 May 2026
 13:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509102337.272593-1-liwang@kylinos.cn> <20260511101337.746510-1-liwang@kylinos.cn>
In-Reply-To: <20260511101337.746510-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 May 2026 13:19:37 -0700
X-Gm-Features: AVHnY4KTYlhO38g2ohBnPgIyYLi_mlUcjvNYEJ7VKclIdoTNKsd2T79sjkoKxU8
Message-ID: <CAJnrk1ZvPgibucnGx6CXnVgA6sWR=RcvFeX=mUqZpdvUkNyLgw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: propagate async RELEASE queue errno in fuse_file_put()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:14=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> fuse_file_put() queues asynchronous FUSE_RELEASE via fuse_simple_backgrou=
nd().
> When queueing fails, the failure branch always passed -ENOTCONN into
> fuse_release_end(). fuse_simple_background() can however fail for multipl=
e
> reasons with different return values, such as -ENOMEM or -EINTR. Pass the
> actual negative errno into fuse_release_end(). A similar pattern occurs
> when fuse_send_readpages() calls fuse_readpages_end(). In that case,
> if sending the request fails, fuse_readpages_end() is invoked
> directly using the error value returned by the sending function as an arg=
ument.
> Furthermore, the same applies to fuse_async_req_send() calling
> fuse_aio_complete_req(). This patch aligns with those cases.
>
> The parameter "error" is currently unused in fuse_release_end().
> While removing it seems like the better choice, however, while fuse_file_=
put()
> calls fuse_release_end() directly if sending the async request fails, it =
also
> registers fuse_release_end() as the success callback. Consequently,
> fuse_release_end() must strictly adhere to the callback signature; removi=
ng
> any parameter would trigger a compilation error. Add an explicit
> (void)error in fuse_release_end() so builds that enable
> -Wunused-parameter (for example make W=3D3) stay clean.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
> Changes since v1:
> - Amend commit message to clarify the reasoning behind the code changes.
>
>  fs/fuse/file.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3bdab8d03373..8b7badb7721a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -96,6 +96,8 @@ static void fuse_release_end(struct fuse_args *args, in=
t error)
>  {
>         struct fuse_release_args *ra =3D container_of(args, typeof(*ra), =
args);
>
> +       (void)error;
> +
>         iput(ra->inode);
>         kfree(ra);
>  }
> @@ -117,6 +119,8 @@ static void fuse_file_put(struct fuse_file *ff, bool =
sync)
>                         fuse_simple_request(ff->fm, args);
>                         fuse_release_end(args, 0);
>                 } else {
> +                       int err;
> +
>                         /*
>                          * DAX inodes may need to issue a number of synch=
ronous
>                          * request for clearing the mappings.
> @@ -124,9 +128,10 @@ static void fuse_file_put(struct fuse_file *ff, bool=
 sync)
>                         if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
>                                 args->may_block =3D true;
>                         args->end =3D fuse_release_end;
> -                       if (fuse_simple_background(ff->fm, args,
> -                                                  GFP_KERNEL | __GFP_NOF=
AIL))
> -                               fuse_release_end(args, -ENOTCONN);
> +                       err =3D fuse_simple_background(ff->fm, args,
> +                                                    GFP_KERNEL | __GFP_N=
OFAIL);
> +                       if (err)
> +                               fuse_release_end(args, err);
>                 }

Hi Li,

I'm not sure I see how this change is needed since fuse_release_end()
does nothing with the error arg today. afaict the (void)error pattern
isn't typical in-kernel since W=3D3 isn't a standard build target. I
think it might be best to just keep the existing code as is to reduce
churn, and then if fuse_release_end() later in the future gets updated
to use the error arg, this would make more sense as part of that
change.

Thanks,
Joanne

>                 kfree(ff);
>         }
> --
> 2.34.1
>
