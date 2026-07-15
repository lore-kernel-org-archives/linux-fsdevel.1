Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06887438479
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108428; cv=pass; b=Zy2q/OYVXotA8x8bz4tKd1SOMKkf6DAeImrWlQocZReeKcSBZiePCIp8C+IqWc66OYnVDUdnGSkXuCOX2mtO1vEUukwIJDn4SgkjCxnGBr8eCQbn3kNz0P1ooxQ0LyMwxfXOvVZGdBRVU8q9NUGvzJE5DwyhIYqGRuZq6TW7yNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108428; c=relaxed/simple;
	bh=u5x5UjFfiIypuUG/u8VBeYI24RclQQxYRKNVOEumIHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iexZpxSxWb8WoD3WLEkTJOw9EgC07wnSRXyLQKx20C45OPziTI54wZMKEEfSS/XZty5EbOCYLjb7u6kirdWGSMzCMN5+x1fDJdmnHN84kkx8EERdxWdrA8UcHhDUdWg2x+v3sb3wThl2zG1D6GcG+bVCZs0w9LgUUf/waL36Rpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4D4in7/; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4D4in7/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15c42a45adso71803666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 02:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784108416; cv=none;
        d=google.com; s=arc-20260327;
        b=HUwKmMXmrZpcJgDrGNyluIbC7TZQMd/PXubY83o40Q+GqU30XWBgfiMyaQV+IWmzUI
         +4uagLXFBE+O1ptEDEJNAdMojFUl3OgLmt+XBbNcuZXjyF9Xcbjv3Jm4oNYWPEyLp0rF
         yDcu7TpnvzOg7pm3xaq85gGCuRsajOAW0YHRuhVEKHUrbG/o/lhS+4ZZuCrbvARqU80G
         NqPlab9d/ky+n0OdcTCTPPqc4FK48n8VcjE8yQITm9dA4lJ+vuV/u9VBZwIcZhUYR2LW
         4R1PPaCipfczA6I15FBu0yqwYc2smoVplJuGnGPlQCY/Sr7VmtduyWEYna6DKJxVwcAB
         4yLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        fh=BEDRT/phgIRfdQwvOThwKuUz1smGA7LtKSJsXLmfXGs=;
        b=Q0hki4ehnmvPdAp3lY+yhlMDS81UKQM0yvAxLyFXSVzRVTeP1aTyjMzm7wBhtrzGCw
         VJIeCPTnV189D3QXI8WAV1giYjvu91+Y9S3xKG5WpyQZfXYeskF2EN4TJzow9tqLgQ8z
         hS0J/XCKDiKKoiLIfgPBRnpQC9+k+9pkdNn4Sh23jT9W7IYB92IWBsToXVa9duik/a1A
         +Qi4KMprkHCDoh+oV7zdS5u3vaQeiVcnwAQDEnBRlFJnlG6VxzKIsKlWdALWVfG3CSYm
         CN5AdmHmlj5EAYrxek4J+0YGFi/Dr32RELzI2f3spVKRBjcn+gROdXex6s2C60jWH/hD
         Vvrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784108416; x=1784713216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        b=e4D4in7/Ck70VkX4eAF5tKnxnFQv1sMZVZApngXtf0s0DtyigcrQr5S51R8GYijc7H
         jnCfC4twqFHunYGeKftAi1OCutBidgVGf4UbqEgECct5OlOwZRxe8epzr3L/O34zqthE
         cJ+ngDEazznFCLLzYdaoxMoK3kZZCG0s0bO/oqYRZfTQt+i2MA/Yx8LCRxaTnk1MVYp8
         jLQmp9z/3rqDwHAjCiM5BdcZ/VhzrWtCF6y4EXjmlrIrKa6OlsXq4okB8iyi5FH8ZprY
         NjsL6cZjf3I0rnGWj8imgDOeV0HHOJuFHdKm7nZ8zQgbTXUm2wLq7TYfizM6h3iceIVu
         xErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784108416; x=1784713216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayP+P5/Pd6BGHZjCoYBRcVoPcvH07ra6Sodaq/Yi54U=;
        b=S4TWXepxlDaMJ0Nos971TCrsjuu7wG3dFI4h/EyZ3sIsvjOPEtdkGbFRis6K6u5STW
         Yjyh+rr6alh48cpsnIejkC3mfgsybHOGwvOyVuAmNamfaR/lNPRQXcu0RIMYKmmQg/0E
         EH6dGGeLhtEPMMFMf+BW9p2X8MiR04ywkQjSOwJdn+n8b+jp5CbQqiMhJ0gIS0asviTX
         ys5dnB49MJ8i2vTdQsZo+wa9D0IZUBS8U3fszDPcIypxTCcAfc9jUbBtZ4FTu5gnew7T
         UvvcY3ex/5K+EvKb+CIM0lcBGgYF11u81uOb+POCSfcRCQyLjfRA3ljKPSu/Q2Z7Y480
         D5lg==
X-Forwarded-Encrypted: i=1; AHgh+RqdDChEM4/E45NYhqsJriDCD+97sSZNXYH72hsu+va0QSSUsrfgSbBT1BzQJEzWILUY+7t/W5uRodQg9n9q@vger.kernel.org
X-Gm-Message-State: AOJu0YysigKUmFdc5jeMvop7VUPvFrQFfsCf0GmuVgGo3qYvzXkJaIaA
	ngEmb3JfAnt9LMdqEd0mwHLxgtUktENvJFwCrabFxZe8lKEXc/HERR9rhaRQq6CCV9iAs6m9wgq
	5h8C/Opq3Zooo5pKEvi+FBt8MJdZzdfA=
X-Gm-Gg: AfdE7cntUTjfEOezPSUKkmw/ddHlcngiQLRZSFZ6Sgwl7LtbMFfI+teeMsG3q0TAQ5O
	pEtYiLVFNBJ4Wn/uvHhzE0CyL2eY/qAR8FV7xrC5ANTHZNjtAg3Utzxq4VcfkcTJehjswR1YnXi
	r8nF0lXba5SZgRDpg444b5AlpncllLPXdTaK2Quo+fFrkRlv1vJadFqkHD9EwcV9zmOZIEwZI+A
	TNCGigC1gzGScDhntxAtex8SHAWa5ljD7hYplnBUKecl+MNjuzvCeWfdLKeGdr6U7JR5UIU9A==
X-Received: by 2002:a17:907:6e86:b0:c08:5bdb:e904 with SMTP id
 a640c23a62f3a-c161e89a8f7mr791839866b.9.1784108416323; Wed, 15 Jul 2026
 02:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713220932.413004-1-amir73il@gmail.com> <20260713220932.413004-2-amir73il@gmail.com>
 <20260715-seilschaft-fahrbahn-talstation-6c45445d2535@brauner>
In-Reply-To: <20260715-seilschaft-fahrbahn-talstation-6c45445d2535@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Jul 2026 11:40:05 +0200
X-Gm-Features: AUfX_mxOzjZVXHNjf0PogjbfsvYj10SoFZT144LLQab9SavhtKt6eUxVr6kJ1c4
Message-ID: <CAOQ4uxh0J6CMCeUYRQX7buf+SHp2Az4kvWWvtMk9A1h-tqhmmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > The ACL_DONT_CACHE state is meant to be a constant state for the inode
> > for filesystems that want to opt out of posix acl caching.
> >
> > Commit facd61053cff1 ("fuse: fixes after adapting to new posix acl api"=
)
> > used this facility to opt out of posix acl caching for fuse inodes with
> > fuse server that does not negotiate FUSE_POSIX_ACL (fc->posix_acl).
> >
> > The commit also takes care to gate the forget_all_cached_acls() call in
> > fuse_set_acl() on fc->posix_acl because there is no need for it, but
> > there are other placed in fuse code which call forget_all_cached_acls()
> > unconditional to fc->posix_acl and those cause the loss of the
> > ACL_DONT_CACHE state.
> >
> > This is not only a functional bug. Properly timed, a get_acl() from thi=
s
> > fuse filesystem can return a stale cached value, as was observed in tes=
ts,
> > because set_acl() does not invalidate the unintentional acl cache.
> >
> > We could fix this in fuse, but it actually makes no sense for the vfs
> > helper forget_cached_acl() to invalidate the ACL_DONT_CACHE state, so
> > let it not do that to fix fuse and future users of ACL_DONT_CACHE.
> >
> > Fixes: facd61053cff1 ("fuse: fixes after adapting to new posix acl api"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index b4bfe4ddf64e..3dc62c1c2708 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -93,6 +93,13 @@ static void __forget_cached_acl(struct posix_acl **p=
)
> >  {
> >       struct posix_acl *old;
> >
> > +     /*
> > +      * ACL_DONT_CACHE is expected to be a "const" value and xchg it w=
ith
> > +      * ACL_NOT_CACHED would enable acl caching for the inode -
> > +      * clearly not what the caller has intended.
> > +      */
> > +     if (READ_ONCE(*p) =3D=3D ACL_DONT_CACHE)
> > +             return;
>
> Still on vacation this week but I took a glimpse:
>
> If this isn't what the caller intended, having ACL_DONT_CACHE end up
> should be treated like a bug. So shouldn't this then be a WARN_ON_ONCE()
> and return?

The caller has requested to *forget* any *cached* *acl*.
The value ACL_DONT_CACHE means that there are no cached acls to forget
so the call is a success.
Therefore, WARN_ON is not called for IMO.

Sorry to interrupt vacation.
Let's continue when you get back.

Thanks,
Amir.
