Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72163D47C0
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931568; cv=pass; b=tulr+7JZDxucDLJG3zlunTXre6QQDUkxWlND39e/frpU8Nskz+hymAq8aZINb8O+u7OFwbjncFPAP45J3WCKac30hpzX8Yep7lrXXgubQ4vMs2f2QBpkEKf/XopnS0he3EhdEJU2HNQhXRle77O0ct3YR5GnvRFh7CD3W5bUBuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931568; c=relaxed/simple;
	bh=pP7up5V2g45VUYRhghvxIRpZ3OuKQZzTleHE7UwLzZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egHAF0J7x+LRlaXSrep4ELZ75NqfBkLqiwnCbr8u2ttv4H63RIFjJAfgHxoNaT7FnE5jaoUfKrpCRy3tKE2MyVg5czayXtX+vr+XVI1TuTIo4pezqOL5Janmcc6XzxG6BydDb6+KGaAkhlqkoI1FsC2FvJpctX9xv+qNSPBpcgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARCoWRjY; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARCoWRjY"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so1521788a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 04:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778931565; cv=none;
        d=google.com; s=arc-20240605;
        b=DWuT2OGHjVcFjp94hw6QMRlvEEvTNd8dPML7N/hNPmFQpNH6qi0cskA1tg7YH798xs
         vNjddstSHTwcVK23wkGC/iA5KaxP7bZT3M0WqjUUOD68Dfr1KpS+dKauBCgcPynWOwAS
         KbkqhsQNhJkOK+DWHedI7ws6A5rO6468vjtE1Efs/GAjxHA83YivatFyu7129OYH0a23
         E3L1Jjjjc7f1dtwYeb+8WgcLWvER50lAFYgr5TPOWyZAnWSscb7tVL3R7p03FqTkIPhZ
         gpP8Bv0VYn+vQyYhkKhdE2i8WNEhYrIj4d3ggf5/MO94PHphzRnzp90HJ2jTb1ziFECT
         MKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXesjocVsJEp3PAxZvkBGPK9p/dDVRrnS7phj3CBzzU=;
        fh=RLsG+lgwjhduXRI7eZ9SEnr8edABmYaHDAq8l7rwhhk=;
        b=BKYOQY81ZL+aLDwxEmmAdVfldv6r9BYRQeJbdvYe7gYVnWlA8QPj5rSpFo80REtkmr
         hRmAfmlfBrJeSLUAGIsgTqYdUNq/0NDHZ9PLT/7JDsHrMl174C9YtjiNXFT8w/OOvDjc
         1DcsSIa4Lqb1NzfrzZq0aI3ovfswVEXmMrFfEzn6x56KvQVvfpRvsvHuzzE24K/tTSx3
         Ka87P48/fWiqLZoldssYt/NNuk6wYQKlzlT3NBMuzLD6h6fAfsBTGAUUBJPlP6Ih8GRX
         gHm8SkSrSjDYLjc/QnEhDLZ5LDBwcpNt7cj/7VhRMU2K9FjbjEJt8Ojn8/xvoB5qMTYb
         asNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778931565; x=1779536365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXesjocVsJEp3PAxZvkBGPK9p/dDVRrnS7phj3CBzzU=;
        b=ARCoWRjY41G7aQGIjKzoGF8XivAIWYQwtjCTF8jxVqZQng272LL3ZzcBjok/RRcac8
         m4UwN5sDCDvnR7hAyIqrlGiS7gwBbQ3lcVHLP4qMlze5HcXGIR9OgOCuB9hgBurIH1Kt
         V8Wv80FaAfbL3FJ75hN6z0d1sIKcUPuxG6i1yaCfZtxd1o5nvIi5AFry9JRZzMAKwhs8
         kLsWHERuOagr8aQr5BInbzAB3zHsL9N3Y0i3/UIoloccInEPz7gemlK9QrhtDdedZkzg
         rSJxE/tFQ9c/dqRi8CRTZjRnBV3wZ7arlmOTo3Tl1g+khhcgYJVGbTm319CP/FUUIyzF
         QjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778931565; x=1779536365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXesjocVsJEp3PAxZvkBGPK9p/dDVRrnS7phj3CBzzU=;
        b=aCMcBVJddGF8pqTICvPfd6xdI5JQP3qSyIFaPEtr1w9QTBHsuAgiZewA09iE0auZHK
         DI3RRTswzs1Gu8T1pBRU7e+SWny30ZwE8VczkpCe9sBs1GS6UpbrEVJdRGryKSVlpRP6
         h+r/FYb+ExwRA3FN3Cj0kTdGCWgvNDioz01drTGeuN/LDb+tgdvBFJuv1Qdeh2vVTDgP
         eBNIMcmqtm+RH0c58MBeFeO9HNpT+8W54z7xvtcrqN0ifq3uMeG1oEmMRUYG0fLAQbJM
         vexYVcsAsIk28WmOUghYrh+Gh0eg5cyusrcQJ6LT1gK4lLgQKqN7+h0w3L2+PSEzYImN
         vUUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IOxN5mp/N8kKkr07OPGBlw4+54V39quw30yW17sX1sFZ45PxO+JvP4GWjemxzXnTDF2XqBdsJ+dNfHbc8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dkTIonClYZTorLvrh9kdltCE2nAcgvL8HOGfV1OTTxVQ44wb
	sLFg9JEgzXp5hlyuGo3rj6D01MEJ0E2YAQPdnzMHF2nvCvreLbMfOP5A3POSLtIHbs+xAkQySpv
	8vxPzAvtrLURuu4SdVAyGa7dBE5sI0mU=
X-Gm-Gg: Acq92OEvR8YMKLrg7Uu7Piq67mmEqNbIuY8MkumplWm/+QVRqr+ndX9V7CDv1PrFJnK
	Thnz6c/O/1EaXTNx7+Crg4gKae7qGhLPrg+TAJmfAWxwcPDY+qkGhqRZOPB7wgBwZFKkXq1Ocas
	Gs4HL/Cm4MLdUK5YzlkXGyBWTNLbj5/CJ5rQc7SWjcsHXCmLTkZ3YCpBrZ9eIGHb2N23WAApOhv
	qVfIEygLaw7Ysq6/aN0F1fyc7LdBHl6LOA2B1t/Lel298jiltyEk1gItzW+BsZ7l3s3m/MC41+h
	2k1i2z8k/cPcZXVU+kArb1V+FHjXJhId+7v159eiCHGqrnlg2U6a
X-Received: by 2002:a05:6402:24a1:b0:67b:6d1b:475b with SMTP id
 4fb4d7f45d1cf-683b5061ec8mr3532289a12.11.1778931564807; Sat, 16 May 2026
 04:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200129.94862-1-amir73il@gmail.com> <20260515193010.056ef472@pumpkin>
 <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com> <20260516094242.77d20c92@pumpkin>
In-Reply-To: <20260516094242.77d20c92@pumpkin>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 16 May 2026 13:39:11 +0200
X-Gm-Features: AVHnY4IIzUJDUUNwZk8pBGGTtcsYaOB4q21intt2wiryj8nVT5_Dz9gZBMVu3_0
Message-ID: <CAOQ4uxjX=C6WZvW1DdJ13tJj-XBWVxgE2Q9vVvHoYqiOhqW0wQ@mail.gmail.com>
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
To: David Laight <david.laight.linux@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 10:42=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 15 May 2026 21:26:04 +0200
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 14 May 2026 22:01:29 +0200
> > > Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> ...
> > >
> > > The object code bloat would be noticeable if this were used everywher=
e.
> > > But you could make it a bit simpler:
> > >         if (__builtin_constant_p(__e))
> > >                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
> > >         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
> > >                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop and o=
ther boundary errors
> > >         (void *)__e;
> >
> > Yeh that's nicer thanks.
>
> Actually this might be better still (or just more succinct):
>         void *__e =3D (void *)error;
>         BUILD_BUG_ON(!statically_true(IS_ERR_OR_NULL(__e));

This condition is wrong but also my compiler does not evaluate
__builtin_constant_p(IS_ERR_OR_NULL(__e)) as true.

This works
BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));

I think it is enough to statically assert on ERR_PTR(EINVAL)
and no need to bother with ERR_PTR(0)

>         if (WARN_ON(!IS_ERR_OR_NULL(__e))
>                 __e =3D (void *)-EINVAL;

Oh, anything but EINVAL please - the most overloaded error value
My choice of meaningful error value would be EFAULT
because without the safe helper we would be returning an address
which is in most likelihood bad, so better be explicit about it.

>         __e;
>
> The WARN_ON() will be optimised away (valid) constants.
>

Yeh this looks nice I'll use this:

#define ERR_PTR_SAFE(error) ({                                  \
        void *__e =3D (void *)(long)(error);                      \
        BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));      \
        if (WARN_ON(!IS_ERR_OR_NULL(__e)))                      \
                __e =3D (void *)(long)-EFAULT;                    \
        __e;                                                    \
})


Thanks!
Amir.
