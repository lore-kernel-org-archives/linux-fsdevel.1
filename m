Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF22206A7
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785590252; cv=pass; b=H61of3iKqXJRDWcehXc92Pd+ZVow2iH0UwDNAMXoTck+cAv9H9n+JIvglyjc88qLObEpyXLqdINCTDK7JD50LsQOLUr7fzj7WvNSMhTugkdf6E/6GXEXoZd45vsof2imxw7tLPNmhstt71EbRQA3gqFlJCaoT4u5oj0Elh+4B2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785590252; c=relaxed/simple;
	bh=p+3wATv9gqT1Zn1/OggkBwIdglDLoCM6C26XrLCxL3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auUzmj9jTkSZje6wz/XNBV5eSk01ubOM6d+l3YJ3kxSJZJa1U677wYtKcx0no7EJLp09NJuZfdybcryw74C1V2QsNN6eL4NaDWFRiOMhOydV3Yfc5baG+PEtgQ2XPulAnnCKYQZtxiM6bI8DuunfXWI/LvzCI0CQ8P5U5Q+AkCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di+Fs1q4; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di+Fs1q4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so2258547a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 06:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785590249; cv=none;
        d=google.com; s=arc-20260327;
        b=n7bE8AFp6JKvvMhB4Nah1gPzWsFmsoDFoGE01g6vPdFcf1Y9oLi5lxqKsoIOpgKxKC
         bi+iNJt3WeQa5OB2I0+/H4jbeX+HGB1vQGvCKFo9YsdZAMWE2PoOjO4+B0PZTHwVEVcX
         utp8i5Inw4MR5IOyvjxWWMcKZGIcNzQ4uroeVmiTnrjX1Ongmk/Fq+O232JLPSNJUN4t
         X8CNx9sTT39vxhX2QerPxii91nqrGbR8NCdm5mCpFAe21WmL7nt0dcx32Ub8f6irjYDW
         ba+CahNrLn8lmMOqNz8oVD305n/fVRdl2mkKfl+5RpkToTE1xKRsXfJAIwrBA1ou+imz
         U3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IEVCyI75712GoZP7FxqBBPITuc4yMlALvUlVmIPbJ34=;
        fh=qhKw0GF09mC9HI2cBe8Z4phaXvmPsSVh6g33bFm3cOg=;
        b=HcWf9hjZ7Ke3Yp+wWIL9WAnxwImnPhOc0vfzK3utqnQnuudELEvDYO7BeZBBby1IfA
         HblVqz86Z0PuDbZ49nv5RgxbEFG/geRv8OSdAlHNK20Tnv10GcgMbTbDH2NMKSP+3Ky+
         3U4uMoR3Za/PenuFXyhJ/93UBuVXlGO4aG7KlDvB61YD+lUAGOfuXcTY0TM83NG33bn/
         LuT8/YboUgTZY6gxj5Bio+P76I4JlXZc9z+uNIaT+cMItb62smXUNEysns1aquXRQi10
         4iSucr+3rmwkBQ9ZcJ0onUSL34AeOLVKw2QEWCHumMsX46qILqiYwRtH3GYEoEQMl43P
         cJOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785590249; x=1786195049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IEVCyI75712GoZP7FxqBBPITuc4yMlALvUlVmIPbJ34=;
        b=di+Fs1q46iL85p1GZRButWjrpYWdJSr2Qx68Ai4x20wcpsy4lfa1HEXp6lW1utfsPj
         e9JOIwwNemfGbVJkuMtLvyYpj29bcHr7CyXrYshvsrDJl4IXti6M9SbenH5mLFlm3Otp
         t3Oiox5iCyw0zO11nQcvMiSnRAPWPjeJfs7yDjkwo2KA2y6hBe8mF+g0EhaHs365TnbH
         E23O9WxnIJo58Bex8IEqU/2j2WoJ8Ha520ibQ7WS05E1Fj51nNr5B6mpPDRlzAENN1R0
         Tvx1rc7/uQ83Nj8OvjLo5+8ivrQUADGd3ehAtRKeG2gWoUi97wc6EKnPgtggdQE4ti8E
         56Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785590249; x=1786195049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IEVCyI75712GoZP7FxqBBPITuc4yMlALvUlVmIPbJ34=;
        b=N/AhkPrT0RjEaaX/KEDYPDJfwYnYiMPaMV756pA1CV4ya0zREptlLMyhjxRnfPd2Re
         cLy+TN90AMFBzqVjQ9g4Hl4HTKfoeIlUhZHBexiduDgGa2hhO8qw1aGPJhKFD7ov2zcB
         TSiqicPsf4bxB90P5KZuow1aH8Fizbio6bgyfMVyjVelcXlmx2fmrm+rjgkauoUFrPx3
         S7bNKfkNGRPC3NDtyiuxM3nWvG13/O7Cqn2m19L9KojVQbosM+IkrxNfLAQO3oFTQyMS
         6PmzWMTa7872ELwBZObqWSrkZqxeEkGcwpbt8fEahD9a/FMMtlOBv8LhzJBLwdh0QQt6
         f6iQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTmKmzcvMj3yIt0ZIfS8Su2dBUYIJnFsjnVgK/fuWRkAuvVWv8rFA/VbnlZG8+6p6DA+y1OTNSaLt1qvhG@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5wJ1gXnK+rZZ02AOzLhd9ja1hqERwG6cdWkCGxm6HhHS0Ub5
	Ua41Md5nRjyky9BdCHvtbCUFyChxz5tXCuEkeacAnfNploehzSwjHwVn0AOJupp7M9H0PJWyF8N
	psL5f19eF6m+BTNXrCFtaP/1rRvuR3tg=
X-Gm-Gg: AR+sD12iUE84zseO0mO/3iyvjrOX7CUPfzOzPOIZT+73zl04nW5F4BxaMg60e2s0j89
	zOdmU99LsUYbf5iIZiG2GbBcxmNGpHEht3zNspo/A9ncdQkF8IgNPw76RKk+Sfh72bFheeth6+J
	7ceIao9TWAzVoh4Oql9siDynDpkEs5B9zeYet9tz6aIxZgsB5SoY1Jh81mDMrn+Qa6yOI9SJnRv
	Mt2WNnfvuy92h/Tx1fRSXe+uo1LhfgQWCJr10mQB8dQnl9C3DQVLSJ3BNa4QzVRtzjlk1hK007n
	d7iOvY8F3Eg1PNkPnTPYl5mElHWhFiaLo6/+j5L14I1t9w==
X-Received: by 2002:a05:6402:52c7:b0:697:decc:7f89 with SMTP id
 4fb4d7f45d1cf-6a0a7c9c9a5mr2203903a12.10.1785590248557; Sat, 01 Aug 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
 <20260730152241.444632-1-yjkwon0026@snu.ac.kr> <yxm3q5glchsjgr3pudmcy2vtn3umneardtcnvbuxyfn4oaiuqq@77aualjjutwn>
 <CACwKKmDrTKHRZczEk4z-gO+yZNXgvEgFDzKFfJSUMR4oK5VA6A@mail.gmail.com>
In-Reply-To: <CACwKKmDrTKHRZczEk4z-gO+yZNXgvEgFDzKFfJSUMR4oK5VA6A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 15:17:17 +0200
X-Gm-Features: AUfX_mxaGuOvol_1j8BHbqVOv0eM9sl-rYp5X0W8TjjAo6eXZswD2pobjDQw8EA
Message-ID: <CAOQ4uxjE8TSqz2NcQHMEgun7K7tUUGVWKL4+8Crxz3CHVGPxwQ@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Fix stale object mask after concurrent mark updates
To: =?UTF-8?B?wq3qtozsmIHsnqwgLyDtlZnsg50gLyDsoITquLDCt+ygleuztOqzte2Vmeu2gA==?= <yjkwon0026@snu.ac.kr>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:41=E2=80=AFPM =C2=AD=EA=B6=8C=EC=98=81=EC=9E=AC /=
 =ED=95=99=EC=83=9D / =EC=A0=84=EA=B8=B0=C2=B7=EC=A0=95=EB=B3=B4=EA=B3=B5=
=ED=95=99=EB=B6=80
<yjkwon0026@snu.ac.kr> wrote:
>
> Hi Honza,
>
> The last line can affect the result, but it only narrows the race.
>
> send_to_group() can clear mark->ignore_mask without mark->lock. Suppose a
> mark has FS_MODIFY in its normal mask and FS_ACCESS in a non-surviving
> ignore mask. After old_mask is read, FS_MODIFY clears the ignore mask and
> a concurrent recalculation scans the mark without FS_ACCESS. The add then
> puts FS_ACCESS in the normal mask, making new_mask equal to old_mask. If
> the scan publishes before the aggregate check, the last line catches it.
> If it publishes afterward, the check sees the old aggregate, skips, and
> the scan then publishes a mask without FS_ACCESS.
>
> A raw mark->mask comparison catches this case but misses FAN_MARK_IGNORE
> updates.

I think you should use raw mark->mask comparison in the normal add case.
That should be enough to prevent races from NOT sending a due event.

You can do unconditional recalc on update of ignore_mask, which is a more
rare use case.

> The inotify old/new check has the same structural problem: its
> replace path temporarily sets mark->mask to zero, which a concurrent scan
> can observe. If the final mask equals the old mask, the updater skips and
> the scan can publish an aggregate without that mark's bits.
>
> I will therefore make recalculation unconditional after every successful
> fanotify add/update

That seems like an unnecessary overkill.
It feels wrong to me to kill the optimization of the common use case
for esoteric corner use cases.

> and every update of an existing inotify watch. The

Not that I think that update of inotify watch mask is worth optimizing,
but seems that the temporary set to zero can easily be fixed:

if (replace) {
    fsn_mark->mask =3D inotify_arg_to_mask(inode, arg);
    fsn_mark->flags =3D (fsn_mark->flags & ~INOTIFY_MARK_FLAGS)
                    | inotify_arg_to_flags(arg);
} else {
    fsn_mark->mask |=3D inotify_arg_to_mask(inode, arg);
    fsn_mark->flags |=3D inotify_arg_to_flags(arg);
}

Perhaps there is still a data race here and not worth the trouble
of discussing it at all..

Thanks,
Amir.

> fanotify remove path can remain unchanged because it only reduces the
> calculated mask; inotify removal has no analogous conditional skip.
>
> I will send a v2 implementing this.
>
> Thanks,
> Youngjae Kwon
>
> 2026=EB=85=84 7=EC=9B=94 31=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:27,=
 Jan Kara <jack@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Fri 31-07-26 00:22:41, Youngjae Kwon wrote:
> > > When a mark gets a new event bit, fanotify and inotify avoid recalcul=
ating
> > > the object mask if the cached aggregate already contains that bit. Th=
is is
> > > racy with a recalculation triggered by a concurrent update to another=
 mark
> > > on the same connector.
> > >
> > > The concurrent scan can read the mark before the new bit is added, wh=
ile
> > > the updater reads the old aggregate before that scan publishes its re=
sult.
> > > The updater then skips recalculation and the scan publishes a mask wi=
thout
> > > the bit, leaving the object mask stale after both updates complete.
> > >
> > > This can be reproduced with two fanotify groups watching the same ino=
de:
> > > one thread removes FAN_MODIFY from one existing mark while another th=
read
> > > adds FAN_MODIFY to the other mark. After both fanotify_mark() calls r=
eturn,
> > > writes can fail to produce FAN_MODIFY for the group whose mark now co=
ntains
> > > the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> > > equivalent inotify interleaving loses IN_MODIFY events.
> > >
> > > Always request recalculation when an existing mark's calculated mask
> > > actually changes. For fanotify, compare fsnotify_calc_mask() before a=
nd
> > > after normal-mask, ignore-mask, and flag updates. Keep the cached agg=
regate
> > > check for unchanged updates, and keep the flag helper's inode-referen=
ce
> > > handling.
> > >
> > > Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNK=
H=3DX3LmoXMqakYqJaNw@mail.gmail.com/
> > > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > > Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_ma=
sk in fanotify_add_mark")
> > > Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> >
> > Looks mostly good, just one question below:
> >
> > >       spin_lock(&fsn_mark->lock);
> > > +     old_mask =3D fsnotify_calc_mask(fsn_mark);
> > >       if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> > >               fsn_mark->mask |=3D mask;
> > >       else
> > >               fsn_mark->ignore_mask |=3D mask;
> > >
> > > -     recalc =3D fsnotify_calc_mask(fsn_mark) &
> > > -             ~fsnotify_conn_mask(fsn_mark->connector);
> > > -
> > > -     recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> > > +     recalc =3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> > > +     new_mask =3D fsnotify_calc_mask(fsn_mark);
> > > +     recalc |=3D old_mask !=3D new_mask;
> > > +     recalc |=3D new_mask & ~fsnotify_conn_mask(fsn_mark->connector)=
;
> >
> > How could this last line ever change anything? If old_mask =3D=3D new_m=
ask,
> > then it would look like a bug that some bit from the new_mask (and thus
> > old_mask) isn't already included in the aggregate connector mask?
> >
> > I can fix this up on commit but I want to understand why you've kept th=
e
> > line here just in case I'm missing something...
> >
> >                                                                 Honza
> >
> > >       spin_unlock(&fsn_mark->lock);
> > >
> > >       return recalc;
> > > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/ino=
tify_user.c
> > > index ed37491c1..c44f2daa1 100644
> > > --- a/fs/notify/inotify/inotify_user.c
> > > +++ b/fs/notify/inotify/inotify_user.c
> > > @@ -565,17 +565,8 @@ static int inotify_update_existing_watch(struct =
fsnotify_group *group,
> > >       new_mask =3D fsn_mark->mask;
> > >       spin_unlock(&fsn_mark->lock);
> > >
> > > -     if (old_mask !=3D new_mask) {
> > > -             /* more bits in old than in new? */
> > > -             int dropped =3D (old_mask & ~new_mask);
> > > -             /* more bits in this fsn_mark than the inode's mask? */
> > > -             int do_inode =3D (new_mask & ~READ_ONCE(inode->i_fsnoti=
fy_mask));
> > > -
> > > -             /* update the inode with this new fsn_mark */
> > > -             if (dropped || do_inode)
> > > -                     fsnotify_recalc_mask(fsn_mark->connector);
> > > -
> > > -     }
> > > +     if (old_mask !=3D new_mask)
> > > +             fsnotify_recalc_mask(fsn_mark->connector);
> > >
> > >       /* return the wd */
> > >       ret =3D i_mark->wd;
> > > --
> > > 2.50.1
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> >
> >
