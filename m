Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CF39BFE3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635757; cv=pass; b=YrCik8kT9/CnbuguhFu0UKyrufriF5EYdZVeKSRdiw/Llc8e6Toh96xACQJDSbfNN1cyxR24urHipu8BqNqCaLIDcAsPjFuciWsRESo1aBLQnDaQ7oH3SBpw6zLq6ov7Zv4QO/cXW6QGvmPqi73cZXwHEKJlWZbKjLGw0ibm+zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635757; c=relaxed/simple;
	bh=Anf0QJShzbULca+i+nbk1xkmotYAjvT0BLx6u0VnoS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsyornmGej4Y939LH/8wreOGehOejhk7oRyBTMYeCM8zfbo1L7cIDTu1/Ji2tbusawHAGfb89DFnZBX81pC/6tfTtg3H5hcqEMLY1ArNJJqTkcTtv2vFI9mTGOlD+jdBzU/rdzF5I2UyywNGhhYNu2tIwNtdivh3Sgb/S5vgQaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M50qj+b/; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M50qj+b/"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38dd8e7f131so36772261fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 01:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775635752; cv=none;
        d=google.com; s=arc-20240605;
        b=FCi8DJQD60tyaIIbYzzqp86BDu4YM7CMEuAXlEf1170m8nnQg/8zFis1AFJxUvs6RK
         nHoYpawDQYiOA3xcLjefSiKt64OVXSDTz1bebHBH2dIZwKBd4iK8NYIVEkpRZI5jnB0V
         ExVbsV2Z2dSmuLMjqyUMlU+wtfLJ1gW/DvbnqlfBgwrWoS9nyS7eyxWCJN+5wENTlYw7
         PAV1PXduVW96rwUl0uKH1/LVweFHwxEGsHTkZgOC/UtIx1eMe6Yq/+RxTfyct6CF1J7A
         uwTw1nSpUi671UM0PQGeI4TE5lE1JJX0RbSLCV7iiAFeEuArMhQizUZZykzg2ZRErEh8
         bLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxOAFje5nPkMc5Q034nTfNvqywtXDIriDUwzfUf+f2Q=;
        fh=u1Wnv++7sSP8smgWVazcaTOFwTOBwfuFq1Cr07aUZpY=;
        b=d3F3pMLyQRhCAysh62o/CBCWr8fMrywWXVeLwDHqFQbuFFLvGnQmXLmPnPSk3oUei0
         hH7bLuFvn0kmZQI7MTugPqFMbEpwY5XtT31PZ6lrBmb35ByNIB2BPZmQWMDJYr9b6u90
         5Ix2PHT1GT59PuW8l5fWyh79fnTkaNQHiByfjotzCM1uCsbrZThVUsvjFOnOiKj7hSDi
         auM1KFcgtxd+g/8S9F8YAopE//arx1030EA39/XeIIwqhJhmqMt8bcAYEr91O38avuyN
         HZbOKQXMUnoJJdjA+ceQmA1ZztHuABdFmWwWvt5wBqWI+wYuUZIMtY0XzdsI58ahhuUQ
         UmLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775635752; x=1776240552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxOAFje5nPkMc5Q034nTfNvqywtXDIriDUwzfUf+f2Q=;
        b=M50qj+b/VDN8hZ4uXUuzUJGmnAcW3nY5ojog7V5YkhzFRvuq/vEvZ5Fa6+Srr5lXCK
         dpuzTXFz4zTLx7K76ASMFORVzCcBHou6IrPAG0gWaUUeA1FKiQnUIC3mHclYJQQ+eqn4
         n6JbSIigLNEoy2v3L9PjYaGqUGey037CxLRNNHPS2+DOnmC5nMqqJ+l1ojBpq81PUsli
         WNC+gy6ltrVQeDnwfm8Ynw4neIR+IdAYaLyYQ532pOW5+8EE1jcp1Laq05QRnnqVg1pl
         T8WqqHnVxyPI3KyO5QHQDbQwrCtVx3A/zECh5t8sT5KRySO5CDqjMprmL7NdxWtO4bEy
         GYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635752; x=1776240552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxOAFje5nPkMc5Q034nTfNvqywtXDIriDUwzfUf+f2Q=;
        b=OKoxifUMO4GzP3by1W/hS5nc5oZM7S1fM7wb408G/NxZU90QH7fb+o0g6emvP0/F+S
         PRA4DBQMy1wuoNPVVVFdhTD/G3U1VcW05/vZ2VAHhzyVi/Rx5ENzTaRHXdNlKnaltdci
         3QoPvKBPr/do7Ln3mRIBwWaMRVvSEFovevEauiBGRHHroe3amxDvnTqbKUq4b40bWoc8
         tvZqofVNv46pKwX8eMJEdb49zLn3uKMKWPwv4GVGiTdhXzPRjpSXXdrGdfar+71Dli1Q
         C4eWlAi80hG7Ebq9/y4TByYM6CB9Lddy8UaMjq1HyEMY68JxxE/5qY7n6YvMHiCrBOA1
         ltTA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYrAVTOo2BDAZcqJcPTgnU0i3KJnXL2tuV5hFIU11LedXS/q0nR3KciQODKWXmLCWrSnY9BVScUOJloym@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbn+15kj1VjYy8VpU6qZhEfqTwtbYpY0cVHpZ+3L3BwZ9rtxSW
	6nWIX5XX76YT/m6Ai/RYjiRIT6ErngHogM06l4yPR7AtB+NWbiMyhoVmBUU5sFWVRZvj+nekncz
	mCYCTYtps3Gu5xGEN8bOeD2uTHfKTL0Q=
X-Gm-Gg: AeBDiet5qvXEyyD8ttCFFE/jKxTQmmkLvCOEjrriQKvFljIR85HTtsQLIgRCjD5Lo2v
	LCXohHLXXSar1qJ16OOnqQfyy2viuqwgEo/SzfHwXqS1weCEQROUe27bDgmxt1Lte/KCNCTnyjf
	jR2OGKLh3+psqzLzP6TlJELU5FWUD25JIZHJHRLvJTMTdcdqxYs+CGEY6JeApnDgMKVEGhNLYAO
	MEsFDZS/0j81y/J6wySCQvhFfrhDM64AX25cRXMf4wI0izxLwS92UM3VBcb840CVn9RoQfra6zr
	BuRWRTY=
X-Received: by 2002:a05:651c:1b04:b0:38b:e048:572 with SMTP id
 38308e7fff4ca-38d8d1dc57dmr59181801fa.0.1775635752037; Wed, 08 Apr 2026
 01:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407081442.6256-1-komlomal@gmail.com> <adXJop1d0QdH2Mwm@hyeyoo>
In-Reply-To: <adXJop1d0QdH2Mwm@hyeyoo>
From: "Denis M. Karpov" <komlomal@gmail.com>
Date: Wed, 8 Apr 2026 11:09:00 +0300
X-Gm-Features: AQROBzBgCH4RjVweEEM1TCje7jtGEZHThFkvR0yPukwiJ1tBezDT9yaTd4pJIDs
Message-ID: <CADtiZd3AcY2LwPfCkb782TaY1h50dTPpEzhfLSyMeQeXG6VXfA@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below mmap_min_addr
To: "Harry Yoo (Oracle)" <harry@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com, peterx@redhat.com, 
	pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory exte=
rnalization")
Thank you, I will add this Fixes tag in the next patch.

> Hmm but it looks bit strange to check capability for address that is
> already mapped by mmap(). Why is this required?
Actually, it's not obvious to me either, but I may miss something. My inten=
t was
to replace the current restrictive check with a more flexible one. I think
performing this check here allows us to deny invalid requests early,
before locks or VMA lookups occur.

Removing this check entirely would also allow using UFFD in cases where a t=
ask
drops privileges after the initial mmap(). This seems reasonable because th=
e
VMA already exists, i.e. kernel already allowed this mapping.

In the [BUG] thread discussion Andrea Arcangeli also suggested adding
a check for
FIRST_USER_ADDRESS to handle architectural constraints.

Andrea, could you please comment on this? Specifically, would a
check against FIRST_USER_ADDRESS sufficient here, or do we still
need to check caps?



On Wed, Apr 8, 2026 at 6:21=E2=80=AFAM Harry Yoo (Oracle) <harry@kernel.org=
> wrote:
>
> On Tue, Apr 07, 2026 at 11:14:42AM +0300, Denis M. Karpov wrote:
> > The current implementation of validate_range() in fs/userfaultfd.c
> > performs a hard check against mmap_min_addr without considering
> > capabilities, but the mmap() syscall uses security_mmap_addr()
> > which allows privileged processes (with CAP_SYS_RAWIO) to map below
> > mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> > dac_mmap_min_addr variable which can be changed with
> > /proc/sys/vm/mmap_min_addr.
> >
> > Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> > with -EINVAL for valid memory areas that were successfully mapped
> > below mmap_min_addr even with appropriate capabilities.
> >
> > This prevents apps like binary compilers from using UFFD for valid memo=
ry
> > regions mapped by application.
> >
> > Replace the rigid mmap_min_addr check with security_mmap_addr() to alig=
n
> > userfaultfd with the standard kernel memory mapping security policy.
>
> Perhaps worth adding
>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory exte=
rnalization")
>
> > Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> >
> > ---
> >  fs/userfaultfd.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index bdc84e521..dbfe5b2a0 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_r=
ange(
> >               return -EINVAL;
> >       if (!len)
> >               return -EINVAL;
> > -     if (start < mmap_min_addr)
> > -             return -EINVAL;
> >       if (start >=3D task_size)
> >               return -EINVAL;
> >       if (len > task_size - start)
> >               return -EINVAL;
> >       if (start + len <=3D start)
> >               return -EINVAL;
> > -     return 0;
> > +     return security_mmap_addr(start);
>
> Hmm but it looks bit strange to check capability for address that is
> already mapped by mmap(). Why is this required?
>
> >  }
>
> --
> Cheers,
> Harry / Hyeonggon
