Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0A388384
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288254; cv=pass; b=r/t+41Ud31UNVYdnfC93Vb7cpRAIm0JLIbq/7l3Qoj5ygpGOOYTw5kGu4mP6Te210kQAYJxUFnKtOHnxjRRE5z41xqM/qUpLst0qMpFf5EUcHvHRAE65hJz3GH1mWtouQcFo0Nur/x5CWYvJxhv4VTAJKxgGR6wOQYKypVFMb7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288254; c=relaxed/simple;
	bh=UL6TZf+3heM5DCOnpB5ptNmAhsG3QCnXWAbyEUz5w30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBf+KUHdC4dRAEJj+Fl0HGkV5TjxXck59QvKc40IMzW0+xFeV40cSMP/eit6hLkz7Ksa5KSIj6uqqWGlnx5oLl2J250UpiR5lEOQ6zhv2x1RVZoj/Gki02+F12XhGGeVWOFLgfz8BmDvZ6DGif05FKKl+pz6pXoF5x2H6faLHLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PG4E3Abg; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PG4E3Abg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0c45c580so65561981cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 04:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784288252; cv=none;
        d=google.com; s=arc-20260327;
        b=Brp7I7RphX4hDGjydU/FxiHlbPdZVAc1nBcO/ul/fsfau5O7Y055KANBzBw/qSvoxR
         P9bRKZLYmaMTFfr0NH4rOS/Y5pkJH4eoz9SnP7DTCA+ECSzi+O+B6npOUljwWU4cnlOL
         DRQ3gyltwuubzAWtpzYxutZUQwvGC+IyrOccU3UivH4zkdsHgZj4TpZLVa2Sr6vWoGWW
         hX4R1wI+JYCTyA0IKJHIBElTy0qPrT86EPNLRMcI7eJMcwmrylVxZxajZ6aZD2ByWy7g
         SDOXnHp8QKD64AXBRqbbHB3xoNasNd8DZCxHxQxtiCyOMdh9rb8t/gYRZgWl24A5KlNd
         x6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M/WKle9INspGcKeZEAUvoWlk64PP7npmg8L5RRcuESM=;
        fh=mHXm86DIuK4YYDpb29So4EW+pNnFwIKdrzmRFMm/his=;
        b=KK4V7Oe6G26Id/fq7oxVCP5dyz3M0s1X6oSJzhlDfYU/t1ESt62JMv7wwVgR1rnvj6
         oGKF6vjALZZNRJePXlD/JC16nECn/aJWJsGPkY7JwqfeMTaXRD1XIS6NjSGFsAHChSF6
         +9hbM0TiyZAMwTEQFd3u8TfoVD8DRPmQd1swK6eTuiNQGkNyq+RnGKm+Tdqu4LtOufDH
         m1PyodRbZ50Ej4YO2jkLnIEteoIHoc5XmK5bwpljwqU3oNBUPWxMLAAcQ35Ep+Skb5VE
         9qHJfVFX9dh/NWRTjq8euB0w5zkCsJldWwn6nIgwBRiHcO9i69TThmgpJGRpE0OdfY1Q
         doTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784288252; x=1784893052; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/WKle9INspGcKeZEAUvoWlk64PP7npmg8L5RRcuESM=;
        b=PG4E3Abg5vFnRvGrJ+ehfAj3o45zDLNU9ielZRJmaUOdtlJycU5prbEi5omg2gIOd5
         YP4M7cPBgoQjSIZ6omv5Esgc5xloXqjvThPU3CivDq40ahITrfz1zezx0ApPe3uJTy8J
         jrwlmj0530KUdjqcCFS48HPIUNbrqiZ+f54VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784288252; x=1784893052;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/WKle9INspGcKeZEAUvoWlk64PP7npmg8L5RRcuESM=;
        b=WxXq/wlwCMySs8XlI5K0pPPT4nyRbnmiJhkp5lvk/FzLHLHC2nYzejQknp0B9j6rzM
         1vZhxUX85XFCnE1+rLDjUTsKGgq5DkBD31ZUxfnSgkr15Kcmc1m92u/DkDPlMss50sKl
         U3Nh/Xv/QjlvE2iYGC8aCs4BzY9xAhQfU6Ecs5H4paiuF8M4R2d7NQrYgrENlMMrOwl7
         uWPbHZ+GPn1MG7+OTDi+18mrXuRJGXserK3BmQZkulglT5Gjje0+5e/gdRhW85+YFJkA
         i872C6SnEHYmxsCAJumwuEN3O5MXMwkPNQ2PcBmxcX9kkrQCe59FOI1sF69N0zeRdesx
         KPgw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/bnySQ5ve+QB1CM1fElRxOWdQmV4tRlNMIdito8frL1RHq2Zmq+tcGhKitLk0/STQAvSI837FVBo+Bl44@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJIxI5TlWKIipem7/dA4WAuxFN6E9MJz3v5HZUWXTaTxlgOXr
	cyN9vnpSfs0j0LHARCyiOC6DMGmksTpmgExWLlNh/RCoPtBId1hNCzQ4RxO37tYRodQNt/WEZ+z
	YUxpjAkpvJtbjhalCcMV7+VBB9uMBhKXUJaVPiiL+Ww==
X-Gm-Gg: AfdE7ckyANYqSectlS8ABbKZ8ANp4ea2e0CWfrT/6CywV8vQQDI4QvAaYx8GpJHBDG/
	aoTb0rIMHPgHiGHX96OEnsty1nCnQT7PsotA++eTZFjrFtjxUMeThSG80KwIx3ygyvtZJkyJZci
	KYUXDs8zfndPAULazw/DTdgOLzSQrdWHy+hfrheB6Tjo25NAxBYjdLPdIH0JUUfHe/Bn56p4pTl
	r7ZnA88iy9UNewm6vJGhUf+LxMUSPo6YvAtO7sg0+teljtNYctANFGyWm9UBZSQVMFJZdwsywJY
	/FukhowSnrt18E2/XyIYOyG+Xg==
X-Received: by 2002:ac8:58d5:0:b0:516:e974:6f72 with SMTP id
 d75a77b69052e-5213e082509mr18061701cf.50.1784288252106; Fri, 17 Jul 2026
 04:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708021705.3436-1-liwang@kylinos.cn>
In-Reply-To: <20260708021705.3436-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Jul 2026 13:37:19 +0200
X-Gm-Features: AUfX_mzUI1XT_r283KHrMDpMUvHWG_cxv7M6WMx-QeDcYaAP0TajkE8zN4SvBJg
Message-ID: <CAJfpegs-JKBU5OD9jj0z4fvvzdvA0j=CCCwCpYL+iFQ3SS6u7w@mail.gmail.com>
Subject: Re: [PATCH] fuse: drop redundant err assignments in fuse_dev_do_write()
To: Li Wang <liwang@kylinos.cn>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 04:17, Li Wang <liwang@kylinos.cn> wrote:
>
> After fuse_copy_one() succeeds, err is set to -EINVAL before validating
> oh.len. When oh.len equals nbytes, err is already -EINVAL, so the extra
> assignments before the notification and oh.error checks are redundant.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..7813f6214d0e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1887,7 +1887,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>                  * Only allow notifications during while the connection is in an
>                  * initialized and connected state
>                  */
> -               err = -EINVAL;
>                 if (!fch->initialized || !fch->connected)
>                         goto copy_finish;

Sorry, I won't apply this.  It's neither an optimization  (the
compiler will remove the assignment) nor makes the code more readable
(moves the error value further from where the error happens).

If we have a series of error conditions with the same error values,
then omitting the "err = ..." each time is valid, but this time
there's definite documentation value in redoing the assignment.

Thanks,
Miklos
