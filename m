Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066247CC97
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069454; cv=pass; b=a9KpXiWPhgQ1Ir+KnL8Bpy274TCWsNVzcscl4A09y9uZ0LRteQ5IUV6uqAzuyENUmt7UgQeTAMLglN7/5st+jDvTNRTeDV4a3bo0z+kREr96J+cNlpHpX5t+JnzDYwXPc/hdfE6WEf2NO2dGmuQl5UGOWrKBHc7DLzJx/R0715I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069454; c=relaxed/simple;
	bh=zJPSzqQmPJS3n3RQeTTVu8hWsK3xQiP4/HsTokY0viQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzuWHkG1uw3ZVS6g4hY4QMiyCY206fExe5ilnZXDc2zyv+4DZChhSW6KmlaP7Z1Hoc35am0zT1J7HQd14NYFGjekgCkofBPAggj2FuUwfftN0DG/x9Ded5mBsp+t7mKmIITe+CgwcFnFyKzEYMwA/vgaKz+4Juiql8A0AN8JnIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHauIp8I; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHauIp8I"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9bfcbaa81eso9595066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 11:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775069452; cv=none;
        d=google.com; s=arc-20240605;
        b=DT0yqlrRfzNE/aVMeBFVeslC2OsCvW5eyMm4/LU4rQRmQAZcclabVahsdL2dZp4Ulw
         CXjSncaeDUmxoM8sGaexfpjeOhV/rQYzTMTmdEYgAxA3uAgAQopFkkR1AHGATCh3Xa5m
         SGC4BI9/Gc3kMVr7MrGXPh8Z69/hDYcq/c01wQf6DXPnKRcS3o3cYUgQq94i0HLGkmAy
         qRQygqUz9MHI8SQrZPq84vKpkPN+nFscqn6RjqA7qTjKU/1uOpotrcUEM94sYhfgUsCn
         M//W47kEMxR24w00/EwHNndNodWuKW0uPQQKl7Bc8wwFq76sBVlcHBde92vsSpIxt8Qk
         YipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkTjv/Q4ZCkEL4rXJNP+v7ZWNXS2fqJhZXj0Sj8xT7c=;
        fh=kJZOoBb7fjIpROJXVxM2hUD7IyneoFgejcsqUIh0vF0=;
        b=iazlYuOzXffKxfJGxjTVNXXicqs7M3+UHLEU5IOqQHC1VeSO1N+CLPM8GnctlQGDGZ
         23k8YnBzS9vmVBfNFxEIb7j+o2cp9hZYuBI/McewprDQOaGJGGv8tNhrPpQjYvFV50CX
         kRU4LicGUDDObJpeS0Ekxg9FCrlHvEuBVnqDfcmhxy/N2hQxNYIeAM8W/UUjRleq/uTJ
         kXeC0wP47XZu1Leh7agG5U0elRIZ7Ed3hFaF2mmZWYT10gXeSPKwOMQGEkXw5OrfxE+R
         dcdJl9kXhL9h2NSsZvBozivbXDrrQdimI6yFmgAmRolhtkrWegwwucckjVVENUCOV/fR
         9+jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775069452; x=1775674252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkTjv/Q4ZCkEL4rXJNP+v7ZWNXS2fqJhZXj0Sj8xT7c=;
        b=fHauIp8IWdksnSY7cYd75vQcjBJndiKsoiR2iZ0Uh3lI6BxXU6NCBcZbpJGAWqKnlp
         w7cj2p4zxXZ/Jz7wfddWSErJZvFn1kuXWvsivFdHYZSUtQdNPpX10kJP9OyeEOGz8m/2
         JZ/2EebMfTPr/YRDYKXqogPl8c7ujfoxNmvQgzGTb1kYeaQK/DkaqTdEH9eH+rPZqEOm
         Wei1OWMgPBjqq7t28V9sFASyrgipjzC5htv4EbJSTiOzINgXX6umK6U1PdRMfWlYRvhe
         +EXRdgrJPtx+V5u8zR5go5QRe8bBPjLQ9obN8NaBgZysetcaZnWB97CI2bunw+uKNE7G
         AZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069452; x=1775674252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkTjv/Q4ZCkEL4rXJNP+v7ZWNXS2fqJhZXj0Sj8xT7c=;
        b=kje649lYHVyKAN/N9yIWruIDfVodgLHk8X3Rswq42BLHddnZrf8pHR6mOeioU4yrVR
         YaZKpwb9+sRZ1ten2xHCZ34FtogUEZur0IOjqVhV37gz+g2mcxazZVJHxrwN+Iqb2bgj
         YjCMAAnjm3viAQ9e4X6fTlgz4hEFzCNiC+fN3vKVMJXJRNH6K/nr4GX+/Lb+3h11Z0Vq
         HL6MaYgaK5NGlKDJc3AwK7STWVOLIRV9GaIFsntzcoU46f0S6cHE6DRHDnrQBlOW1oig
         5Lqhn1AuG5H/aGyXUe7bH0PBd1FAmHrPsIWYJt/qgDY9RuP27CB9v7pmFi7YhS3uy+Xs
         1Umg==
X-Forwarded-Encrypted: i=1; AJvYcCVWAAeupuuFgDmQIO28rSmJK0p94nt06ErpXjkPqXRKCwzqXnKdkg0rL+95ybNN0loztWNfAM5n33RAF2wj@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSNy7PTYwr7Ojgw3urngla4ncsmDl774jal9/rnQsToZBrZUp
	tE9+6AhY0KdX6X7RBbavLDK9xwjYDxlewWnbZ3Pap8eN40A5RlTbhZIWQ+q/FdXIQ31+fFYIgud
	gOI4IVjwXHqUamyGxtdzwmEcGRQreac8=
X-Gm-Gg: ATEYQzxMjkObJ9llnvS/PuqCEY6VU6xxR82mAFrKvrDvzdMPQ4HGnRnADTgvvrMhCjU
	fTsXUBDQ4s2f/xBXlL2ZOHTJQmTb62Essch7m8JlP8P5T5/GGGG8yVEKCbm8ZTFEaKRPRljvb5V
	BX5XTSaTs/OL2EsVOALGsivxwMqXaIbG7oT70HsEWFDQgjb8qW4h9NVILbN8kSIRvJoukKaNh4v
	emSJBenP/vfthFLpttechhDA/l5CIB6TvR5469VDVsssGc2Hj80M2Cy6t8cbrQ4QIoUVhKwfLw5
	pbjGvybRLvVLDPG/PGjVU8WJAAOzR1xNVpZh1tg=
X-Received: by 2002:a17:907:2da5:b0:b9c:2f0b:dd4d with SMTP id
 a640c23a62f3a-b9c2f0c0af4mr174834366b.47.1775069451455; Wed, 01 Apr 2026
 11:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331160851.3854954-1-mjguzik@gmail.com> <20260331160851.3854954-4-mjguzik@gmail.com>
 <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
In-Reply-To: <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Apr 2026 20:50:39 +0200
X-Gm-Features: AQROBzAuNYQmwJlz2HlnliwXbS0WxCcartkUxwQICnxrOZUJ5-t85ww1HBFeFMQ
Message-ID: <CAGudoHEBkMu=mY12U6WmXDReY5EUXehP6wG45XmLyQ5qHiMA3w@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] fs: handle potential filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 7:45=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 31-03-26 18:08:50, Mateusz Guzik wrote:
> > f2fs and ntfs play games where they transitioning the refcount 0->1 and=
 release
>
> I don't see ntfs providing .drop_inode at all in current Linu's kernel? T=
he
> f2fs case is indeed ugly and a gross hack. But I don't see easy way how t=
o
> fix that for now.
>

This was generated against next-20260327, then:
fs/ntfs/super.c:        .drop_inode     =3D ntfs_drop_big_inode,

[snip]
                                 /* To avoid evict_inode call
simultaneously */
                                 atomic_inc(&inode->i_count);
                                 spin_unlock(&inode->i_lock);

> > the inode spinlock, allowing other threads to grab a ref of their own.
> >
> > They also return 0 in that case, making this problem harmless.
> >
> > However, should they start using the I_DONTCACHE machinery down the roa=
d
> > while retaining the above, iput_final() will get a race where it can
> > proceed to teardown an inode with references.
> >
> > The easiest way out for the time being is to future-proof it by
> > predicating caching on the count.
> >
> > Developing better ->drop_inode semantics and sanitizing all users is
> > left as en exercise for the reader.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/inode.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index e397a4b56671..013470e6d144 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
> >       else
> >               drop =3D inode_generic_drop(inode);
> >
> > -     if (!drop &&
> > -         !(inode_state_read(inode) & I_DONTCACHE) &&
> > -         (sb->s_flags & SB_ACTIVE)) {
> > +     /*
> > +      * FIXME: there are ->drop_inode hooks playing nasty games releas=
ing the
> > +      * spinlock and temporarily grabbing refs, in turn opening a poss=
ibility
> > +      * someone else will sneak in and grab a ref while it happens.
> > +      *
> > +      * If such a hook returns 0 (=3D=3D don't drop) it ends being up =
harmless as long
> > +      * as the inode is not marked with I_DONTCACHE. Otherwise we are =
proceeding
> > +      * with teardown despite references being present.
> > +      *
> > +      * Damage-control the problem by including the count in the decis=
ion. However,
> > +      * assert no refs showed up if the hook decided to drop the inode=
.
> > +      */
>
> Would be better to format the comment to fit 80 columns...
>
> > +     if (drop)
> > +             VFS_BUG_ON_INODE(icount_read(inode) !=3D 0, inode);
> > +
> > +     if (unlikely(icount_read(inode) > 0) ||
> > +         (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
> > +         (sb->s_flags & SB_ACTIVE))) {
>
> Any reason why you want to gracefully handle the buggy filesystem code? I=
f
> a filesystem playing games with .drop_inode starts using I_DONTCACHE, it
> will BUG_ON below which is good enough I'd say. I don't think we need to
> handle buggy fs drivers any better...
>

That depends on what you consider buggy. is what they are doing now a
bug or at least "not supported"?

*technically* these is no bug at the moment in that both filesystems
don't want to whack the inode in this case.

Ultimately the goal here is to catch the problematic combination early
instead of getting weird crashes later.

That said, I have no strong opinion on handling this vs straight up BUG() o=
ut.
