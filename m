Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190E28686
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776515577; cv=pass; b=Gg+4X1OMkRnaNJJy+qBnYKkjn9Vx6XI7w3EOa11M4cqXwDGpy/YMBQnhhj0Cg5ursb/ammNLbPn2E6oDED2i5dFtn/JxzMnHO8kCMNLOlQLNindh2X6zH7604ZeqHv1bxFTWaZwHGg+lR6RKoXrAGHHu4nOQeXxbFozkiYtG5wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776515577; c=relaxed/simple;
	bh=VUfg80/qDsHtBz/vbTk75VigV3mrNEJhj952T03WlJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk+WE2v5Wj9zuMHr8YEdWZMoYPpyQpkIuVQVK0sWg3JxGvnUNzCzfvmhNkwt3cjLFZPHRyMEahyEClZRIqLUvsfV9xWlsqU8RssC8fKxxd+gEBOeIA96c04M1jyjO4ooyP5bf3iQcH5T2k/L28/9Eeh5/z2RZ79LfhbI89Lenos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic5sVwHa; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic5sVwHa"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so1959650a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 05:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776515574; cv=none;
        d=google.com; s=arc-20240605;
        b=Zuj0FbkuVXNk6yG6hCPDX+3pCp0hU/dj2l/NTcZfn9Rb9tfCFAfF4X9qBW0b50GTYG
         mGSqgQBlCnBBN4xWYzF7qdh2nnel8w7Ytu4AVNXD06vmMU/PbILv9hhVkNqim5QF6agT
         W/PTm2ijKHGWpD9BEZ0TmyCdSdsOSTsz19U5HuTdcUUsu02zjdQsYQHuwv+WwmaBmvps
         FUuiBr3GlBSxeYDuQTd12pzJ6BnbzreP/Bs6GtBy3gisWpdiXK2DnA5seC8SLMeFvxos
         o2SupUaO6NPf/SLmk6uUTO68muiXLks0NgXA/XL1bsCL2QiMwX+U1FPy3ZZ8AZJCGB8X
         ytHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6w/P6ZJbl3BJESmOMpcqgt3YFOdt6ADhQkFceDWbPo=;
        fh=aFszcoOcRs6jdtt5x8IMLfS+WoBUaj6bq3VdywnX40o=;
        b=IdiL7gb03zS3Yk2vyDzcZ28ply7ckTk9U+D3L63EWJdFHUZJ9vV6Ye0S8GvxdeBF5g
         MRtxx4YhNDC1SbmT/A1ipuNLArVDnK7ZaGhNDyPHjR+tEASqRdqtczAu/vLQ6/7tkKJC
         lq2d1F1bOmtvwFTrXwv6mqiRS9YQkkt/mHBjeKjwDftnXnLQsIKs9tla6lPLX0Zk5I9g
         Hi8hGJfHT3y4mICkPoUSJ8Mejhv8pFL6enfPkcTi4aYtX4F+OZ7YmiqoQoW1TxpOwmLR
         VBiYqbmIRVoQTjSPn9vcKp5kmwfAWWi1u0QV/bkNL0CLHp12H+iYhqCDWLrNCKPjPT0Y
         f1mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776515574; x=1777120374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6w/P6ZJbl3BJESmOMpcqgt3YFOdt6ADhQkFceDWbPo=;
        b=ic5sVwHan7FuJbK+HnhGhWs2xOXiLEgDKt34QBZrWQNpxME4vzui/f6zzJuaLMSJa6
         tq6JdA+h0Wtt9NA6Rt+DeZ1IXpRsnLX4itAF/kb6t4xMbZtjixDvheZ+btjQs+ZNwHap
         A9YXWMxrNmNUSKMSUGO5NM59ACIYY0nezas7Rp+jl8Sr1LDW+ywhBS79Hm0tpnkLHPX4
         R+inJpzH5tC247CIR0G3sNuotnI9HHHkypqtta7/9YZ2stkUdfDvskCjJxWxtwME0o7k
         87977xROcu6KWdQZcc/9GOkGbu5IvSGRncFqG5ibiKFMJApFOC9CSnAGtmBkvOLXvrow
         iiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776515574; x=1777120374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6w/P6ZJbl3BJESmOMpcqgt3YFOdt6ADhQkFceDWbPo=;
        b=DSmtlIQNt3t1tYCFZYVfL2WIt8Shwtf8Zdb/CZFPsJ7FTqNsGZfuj3akclUrxCzfSQ
         1izC26tZHr39Qqh4jfqPCWCUyRgi2RPMw00M+VgVAEdH/yopdQkwMRS1o1RMf6M3039Z
         ++0kCi0okpsT7NIo5mvFO3fjN/I2Rrp9HM8Q46YyvDTAmkDoc9TS9IFcX+gTe+wa6YJp
         MfyWYhu9cf+gpO0I619cxsorsUY+yGWcUEPWRnLYGSe8+Eqdzlon86GS0n4IYqn0b+A0
         g4//ERSW2fl9EuNnGAWC5OHoFRtetaaRRoOH5XxJLftIgukk875aUfjF+2KKPmCIvzKn
         0o0g==
X-Forwarded-Encrypted: i=1; AFNElJ+k67qv+trlx0cRDaswtIKOxwF68AnMRr8sdi519HdecJNvYel7C9JHn0SlyC58LZy1CYGwgNrgqJpbNWhK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Hv9qwFD2ZNnBYt+3qrrdfPNGdQHesSomNIYEgMxaGoZQbEVF
	yxzB+r/fY8CSig8KH+Mnj36KReDj+r28o5sRO3AUeG6flMeNZYIJy9ocGLweo1pQ576saCX8nyy
	qhLWro2i8PDpVEe0fEwR2Th72pK5IuMU=
X-Gm-Gg: AeBDiesYPIs+rwVkOaLCkywO7NxJ2WMME6a73qIv6oqBU4Bf1zEidkojD1vdOc38XCI
	eE3g3XBtJWq2BOiAmVDF2W+pel9QsJ0bGES8q26pOeN+nhuxjpX0L4IXgACEq7BFzyZGUjt16Ul
	djNy2Z5OQhW+sJ+eIMK/zmnh42pWsX2UAObSYXn04RujQsxngcKcce1YTKjAdKIJB3+1/Y7BFJV
	/oPhP3nTeELGvtCsR0se1hWK2aQnoz3EnN4MgcCm8k72jtb3/gUs0AXY//YVtycb8cCVe15+Vkh
	WV8UrxxImYi0S8XVZ2VIc7AJoC0LW/npj3JDOt32BhwgvCpAzyC2O3m5e/bU
X-Received: by 2002:a05:6402:21d8:b0:66b:3cb7:f638 with SMTP id
 4fb4d7f45d1cf-672bfd855cemr2362478a12.10.1776515574049; Sat, 18 Apr 2026
 05:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331160851.3854954-1-mjguzik@gmail.com> <20260331160851.3854954-5-mjguzik@gmail.com>
 <4fhhn57gzilze4bgkwinanbfovd3iez2s7ajujiob3kkpu6kcy@ic55f5utqogs>
In-Reply-To: <4fhhn57gzilze4bgkwinanbfovd3iez2s7ajujiob3kkpu6kcy@ic55f5utqogs>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 18 Apr 2026 14:32:42 +0200
X-Gm-Features: AQROBzDr-OV5oGSyFxQiHP4FztLnzgvk_FWT43e9457m9EZ-xAPg_lAsp3-eRbQ
Message-ID: <CAGudoHFLT3qDQ703Ttmu6ZgPAiSeaXpEtND12+8tdVa=RYqAag@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] fs: allow lockless ->i_count bumps as long as it
 does not transition 0->1
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 7:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 31-03-26 18:08:51, Mateusz Guzik wrote:
> > With this change only 0->1 and 1->0 transitions need the lock.
> >
> > I verified all places which look at the refcount either only care about
> > it staying 0 (and have the lock enforce it) or don't hold the inode loc=
k
> > to begin with (making the above change irrelevant to their correcness o=
r
> > lack thereof).
> >
> > I also confirmed nfs and btrfs like to call into these a lot and now
> > avoid the lock in the common case, shaving off some atomics.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> Nice!
>
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 9ceab142896f..b63450ebb85c 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2033,6 +2033,10 @@ void d_instantiate_new(struct dentry *entry, str=
uct inode *inode)
> >       __d_instantiate(entry, inode);
> >       spin_unlock(&entry->d_lock);
> >       WARN_ON(!(inode_state_read(inode) & I_NEW));
> > +     /*
> > +      * Paired with igrab_try_lockless()
> > +      */
> > +     smp_wmb();
> >       inode_state_clear(inode, I_NEW | I_CREATING);
> >       inode_wake_up_bit(inode, __I_NEW);
> >       spin_unlock(&inode->i_lock);
>
> It's a bit sad you're reintroducing part of the barries you've removed in
> a27628f43634 ("fs: rework I_NEW handling to operate without fences") but =
I
> guess it's worth it.
>

Note the most problematic full fence is still gone, so not a big deal imo.

> > +/*
> > + * igrab_try_lockless - special inode refcount acquire primitive for t=
he inode hash
> > + * (don't use elsewhere!)
>
> Why is this special for inode hash? Because of I_NEW & I_CREATING checks?
> Then I'd call this function igrab_from_hash() or something like that and
> integrate there also all the i_state checking and waiting common between
> find_inode() and find_inode_fast().
>

I was looking at deduplicating find_inode stuff and doing other clean
ups (notably pulling in waiting on I_NEW inodes into it), I don't like
the idea of making churn changes in this area with this patchset
though -- the hash code has proven itself to be weirdly eroror-prone,
so I want to keep everything incremental and submit further rework
later.




>
>                                                                 Honza
>
> > + *
> > + * It provides lockless refcount acquire in the common case of no prob=
lematic
> > + * flags being set and the count being > 0.
> > + *
> > + * There are 4 state flags to worry about and the routine makes sure t=
o not bump the
> > + * ref if any of them is present.
> > + *
> > + * I_NEW and I_CREATING can only legally get set *before* the inode be=
comes visible
> > + * during lookup. Thus if the flags are not spotted, they are guarante=
ed to not be
> > + * a factor. However, we need an acquire fence before returning the in=
ode just
> > + * in case we raced against clearing the state to make sure our consum=
er picks up
> > + * any other changes made prior. atomic_add_unless provides a full fen=
ce, which
> > + * takes care of it.
> > + *
> > + * I_FREEING and I_WILL_FREE can only legally get set if ->i_count =3D=
=3D 0 and it is
> > + * illegal to bump the ref if either is present. Consequently if atomi=
c_add_unless
> > + * managed to replace a non-0 value with a bigger one, we have a guara=
ntee neither
> > + * of these flags is set. Note this means explicitly checking of these=
 flags below
> > + * is not necessary, it is only done because it does not cost anything=
 on top of the
> > + * load which already needs to be done to handle the other flags.
> > + */
> > +static bool igrab_try_lockless(struct inode *inode)
> > +{
> > +     if (inode_state_read_once(inode) & (I_NEW | I_CREATING | I_FREEIN=
G | I_WILL_FREE))
> > +             return false;
> > +     /*
> > +      * Paired with routines clearing I_NEW
> > +      */
> > +     if (atomic_add_unless(&inode->i_count, 1, 0)) {
> > +             VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEIN=
G | I_WILL_FREE), inode);
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >  /**
> >   * ilookup5_nowait - search for an inode in the inode cache
> >   * @sb:              super block of file system to search
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 07363fce4406..119e0a3d2f42 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2234,8 +2234,8 @@ static inline int icount_read_once(const struct i=
node *inode)
> >  }
> >
> >  /*
> > - * returns the refcount on the inode. The lock guarantees no new refer=
ences
> > - * are added, but references can be dropped as long as the result is >=
 0.
> > + * returns the refcount on the inode. The lock guarantees no 0->1 or 1=
->0 transitions
> > + * of the count are going to take place, otherwise it changes arbitrar=
ily.
> >   */
> >  static inline int icount_read(const struct inode *inode)
> >  {
> > --
> > 2.48.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
