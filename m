Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE404F3912
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483778; cv=pass; b=vEw5MIvcg3wJNa2YOd7MydABs3C5cA6Ph+1pgssGSyHSzQkgVBqepPRjozz0A1BrBhgZ0fMQhxRniaPS8WbzPQY9Mwr9gDl5DgbnnGdS/VwQ2YILWXApnQaZr5lwbpcmdxBUA1XzMikqKEAHK7sJMtZLIz8C+ZpF+gb9RfI/lLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483778; c=relaxed/simple;
	bh=IHB3LC0rNoKz5cxHKJp0l28SgMAXvrRsSm2CxCU28mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMtceSoi6ecUMRnrmLcBHU7Oy9livjy7vngmAIn97K1QruauARiaQcg52KQrIyb0EeJ5vhMuSDBi+TOnZ/W5lwxveiqWRn2rCMTwYwA9iY0FNvBqKci94Cqm5Eek/nyUsZ0Jj4Glfvz1babG2bjZC7TyzZZZx6UcA0+yMYNQAUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKy6nqf4; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKy6nqf4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3156e7705cso669339766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 11:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483770; cv=none;
        d=google.com; s=arc-20260327;
        b=J6QxbR//9krklf3aYcpUMaSYJLxJ0Phrrab3jvn4yB6fjb45alJBbnuTwfGm6Mu+wc
         YYLqaNNOX6CirurpyFlAytQvzwCvWo/ZORYxc68X31OnqnafOGOVsveNoN03NilietlO
         HjPqYTXte8kjPwvatofvp0xT8XYTIpi3UlcHX2ZHsNH9hGnG7z/TwVqYnO3kTjLUw5Zz
         uSYhVy/hceHQ2xM3dav4Hn77/GLnf1vborcQiM4Dzt7IP2iM3pDPMVfaKt29oYzaXLvL
         3sTK9WU2grtV2QvlXqEBOgmksOI56FkpXoDaW/e3mtPI+oAVKgTcmo93p9HZ7KxPK+HS
         aGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6IuYjlepm9J2tShQSO68HEsdwbgtH2/b+EQaLyhTtw=;
        fh=W48O02G0dJ1YvpaAja0g0uVq8VgVKjNaLDHwWFg8aJc=;
        b=C+Du5K15kC93+fJ4MXDCvmV0uctfispUZ6LbWAOS4k6VPNWR9PIOqNu9ykPsMNKtZu
         slERYHfaT8jS/UY+NcZzrunSkUo4WSXldVtLiNKfGLv0Di06JrbX7tXzwmCrnjis67VV
         A1fSyxHqBMYLT6/FwoO/i6lfKldk7pcczHJWfPo1UaWcfiYvs611yXCodYKwdmiIj6Tl
         0XHyyXRpoND6/G2PfVPHKDd+hYZrnYKfVcObz162nce1Sgnj3XigSNJigkLh5XO8cn3a
         lFkk578q27Alan5Nfo/2njs3BSfj9ih/XjMGht8Vmq3wfDRTUAOp+g6JNONMH5L0nbnl
         LGwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483770; x=1792088570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6IuYjlepm9J2tShQSO68HEsdwbgtH2/b+EQaLyhTtw=;
        b=pKy6nqf4JtQ9cs67N5WTvspg/Ro4eZBBHjifhS50siI5gXP8PbWDNOVky0EA7nIgSh
         enIC0qzjAJSa/mLjDFXzHahaZfjAOq8FaftGusjT/Ct70i0m0lAxPZA/1UHbnjJk7ACi
         0WUtuPftxgqgGrSehuCbcuhEMass2SpiK41a9lUiSqIC1v1PZNEXlr/EQpy3zZ2PT4rX
         bURjHrecy5d39HEMl53Mg78qOswQZgdEyeicaEevYW8vFnSKkfJBzAFG2nY2vGHg7k24
         u7nbxMib59YMIewvp+oy5yGaRdXbO2gR1nj78SPF19LZAiU3JUStGHQNKPnJ8gXVu+BF
         /4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483770; x=1792088570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6IuYjlepm9J2tShQSO68HEsdwbgtH2/b+EQaLyhTtw=;
        b=yOqp9xNCMOccICRej6j7E7bOEVb+32n8b1TrWY6kW8J8y5qviPONTI6BSwdQAtSgMy
         w4IsXYcZFothuYajHS1ankeWcbi/WthyNi+KU1z1PqkF1OmWBFYzffexovnp0VdKuSKi
         2cGa56Somlik2Z+WR4vvI8ZuW7of6yCN1n/3Q0miaGYdtN8IWuPEg4US9JseMLH0cD+4
         kwnvQf9UU/CpD2GzJ0aADyDfrjgLcblrxIKDEYcEkLCEw3KUuUJJrhi8lYfQPKRhpHKO
         0oearRDE2BIRxt0kCl0p2F47KCaRSXuTfPGQMTaKDXGWfkqa2+E/zDIgL7kN1jZg1nFJ
         /DPA==
X-Forwarded-Encrypted: i=1; AKwUvBwWw35DnJxBSlDEo2CSqV9JxkSuLDfiIoLM8z55ako5/VLXdFziXvzRjBzUqVRbjQiK9hg7NCtlva6VwFqa@vger.kernel.org
X-Gm-Message-State: AFuF++mDLjhP+yUGQSSM6iwXfSTd3CbDDPZEpwXTtkrennbFH7KRL2Ep
	mdjyUZhKVSOtUQtWDu35r7zSNdJc1PSneFfdkhO3S+xYNQurw+UXiXl0EEQlvJuCDv/vSU8li/L
	TCxTPa9pKUIhEID2jAkJT9MpWdYNOCxFbEg==
X-Gm-Gg: AYBFou32Ipla2VSFicbqk2wa9/RgA+0gYwZFZxgh8BQPLGXXK7Zjo0Rq0O20QvMJoNK
	F0l4xdivPaQ5aaNv29NakSNUdN6w43LsByB1y69Rwx01DVDgUkhiIAJAIsGPWZ01DrjixEgU385
	iioWOMPEonKYnyX6Wa9JtHWcISNAH1kLWvX4c7Ca8wVK2D0itiI6Jhtn9rmNfhZZCZAvaoEyJ0u
	zYuKgaiqCCKksPqg7te6GIN+fG5Kx35NvOH/+jQeY9IcuOolrllCXOZf//0vlIpoS5ng/RjnGUl
	8ka1jCVcy1RvYvgJSH636DvtzQjMvFIr6n888YnGm4tvx0aFhEbaR5EUQzEkzt4w9oi09gAdeJz
	R+WJl0vTDWtHV5d3DWv6Xdw==
X-Received: by 2002:a17:907:c17:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c317c1135ffmr637885666b.37.1791483770211; Thu, 08 Oct 2026
 11:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913144918.1606123-1-mjguzik@gmail.com> <20260913144918.1606123-3-mjguzik@gmail.com>
 <178943070662.207413.9700024518083440241@noble.neil.brown.name> <178943102713.207413.2253649379310238579@noble.neil.brown.name>
In-Reply-To: <178943102713.207413.2253649379310238579@noble.neil.brown.name>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 8 Oct 2026 20:22:35 +0200
X-Gm-Features: AclHuK9PjIDNTzYHuq2NzBxckIwx6kIlW8DTgQLrmsTci4q13qkhbpb_q_eTIls
Message-ID: <CAGudoHGZ_4AhKKBb8ves8r8ztCCCfjtS8nhF0PTyMYHn2119bw@mail.gmail.com>
Subject: Re: [PATCH 02/10] fs: add path_create(), path_move() and path_clone()
To: NeilBrown <neil@brown.name>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:10=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Tue, 15 Sep 2026, NeilBrown wrote:
> > On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> > >  fs/namei.c           | 29 +++++++++++++++++++++++++++++
> > >  include/linux/path.h | 14 ++++++++++++--
> > >  2 files changed, 41 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index ca4f5e3be99a..c8754c7ba8be 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permissi=
on_may_exec(struct mnt_idmap *id
> > >     return security_inode_permission(inode, mask);
> > >  }
> > >
> > > +/**
> > > + * path_create - WRITEME
> > > + * @path: path to get the reference to
> > > + * @mnt: WRITEME
> > > + * @dentry: WRITEME
> > > + *
> > > + * Create a path object using the given vfsmount and dentry pair whi=
le incrementing
> > > + * the reference count on both.
> > > + */
> > > +void path_create(struct path *path, struct vfsmount *mnt, struct den=
try *dentry)
> > > +{
> > > +   path->mnt =3D mntget(mnt);
> > > +   path->dentry =3D dget(dentry);
> > > +}
> > > +EXPORT_SYMBOL(path_create);
> > > +
> > > +/**
> > > + * path_clone - WRITEME
> > > + * @path: path to get the reference to
> > > + *
> > > + * Given a path increment the reference count to the dentry and the =
vfsmount.
> > > + */
> > > +void path_clone(const struct path *src, struct path *dst)
> > > +{
> > > +   dst->mnt =3D mntget(src->mnt);
> > > +   dst->dentry =3D dget(src->dentry);
> > > +}
> > > +EXPORT_SYMBOL(path_clone);
> > > +
> > >  /**
> > >   * path_get - get a reference to a path
> > >   * @path: path to get the reference to
> > > diff --git a/include/linux/path.h b/include/linux/path.h
> > > index 7ea389dc764b..8a621e0e1921 100644
> > > --- a/include/linux/path.h
> > > +++ b/include/linux/path.h
> > > @@ -10,8 +10,18 @@ struct path {
> > >     struct dentry *dentry;
> > >  } __randomize_layout;
> > >
> > > -extern void path_get(const struct path *);
> > > -extern void path_put(const struct path *);
> > > +void path_create(struct path *, struct vfsmount *, struct dentry *);
> > > +void path_clone(const struct path *, struct path *);
> > > +void path_get(const struct path *);
> > > +void path_put(const struct path *);
> > > +
> > > +static inline void path_move(struct path *src, struct path *dst)
> >
> > Oh ...  this is backwards.  At least is it backwards compared to
> > memmove().  I understand different people will read "move" differently
> > and would prefer to avoid it.
> > Can we do without it?  You only seem to use it in one place.
> >
> > How would you feel about:
> >
> >  struct path path_move_from(struct path *src)
> >  {
> >       struct path ret =3D *src;
> >       src->mnt =3D NULL;
> >       src->dentry =3D NULL;
> >       return ret;
> >  }
> >
> > and then use
> >
> >  file->__f_path =3D path_move_from(path);
> >
> > ??
>
> And then of course there is path_clone() which looks backwards to me.
> Can we just change path_get() to return the path, like a lot of
> FOO_get() functions do, and use
>    newpath =3D path_clone(old_path);
> ??

Apologies, I got busy with other stuff and completely forgot about
this patchset.

My issue with the proposed approach is that it prevents the routine
from taking a look at the target.

While the content can be considered uninitialized (and thus arbitrary)
at first, the code can be hacked up so that when the kernel is
compiled with CONFIG_DEBUG_VFS the struct is extended with a magic
number denoting it is populated. Then a repeat call to populate it can
produce a splat.

I'm not married to "clone" and "move" terminology, which I only used
because of Rust.

Would "path_dup" and "path_transfer" be clear enough for you as far as
direction goes?
