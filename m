Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338C45A29B
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516095; cv=pass; b=pk38GdSws8op+t2RIXxWG5XhxLfeu6ev8WnBQxsB0zhqKO/dASMKOKbZG7wf/VyKwvCl6UDAMO3ZXQnB3lygyrcYey6BlYZ/d7nRfrrif0qVJHopBPRMKcwASD9o9d19+tWgb0o1auv00Khuw5Jlwz6/25A0JqbuLpJOKeLHw/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516095; c=relaxed/simple;
	bh=7lr2g0hOFws98Tw1rPDLdup5Lu5CnuXeBbo2FVvyuBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq9f+lyTQeKuj8sGRq5uikeYbvYiKJJx228d1Xlp5cqwB+Ap0dbS38f8GqZ93B0EhOgCOugWp+OqfAHbkYFTWxZo4FSrMrAZtsXW+UQngM4V/uqrhMqj8ieezGB43EUv64cNejo/lUr2SFRcxFPNh30hfpmlzoNfLNPuhDtTniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=YmYK+tOT; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="YmYK+tOT"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b015b2d792so1177357e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516087; cv=none;
        d=google.com; s=arc-20260327;
        b=GYGS2oVaaLcwdjDb/WgeNf749IoWQ4qifFoHlVydg4yDMRKy5tKn9yxW8EBTbHKEDG
         zlhYlitxjBFCtW9lqggA2D61leIlFJ/x5sUh1Rinv9dAcHJOCNn+++jXwtOZD3wv22h/
         cE/KpxM/5GWaUEM18TPrJzRt0o6YZd25lyYhlNbmzJ1LdeeJERXXuDz4zZFJVa9c8+Kn
         HJzpxW5qDH/gQ255SGZsSvEAgLPozq5z16Ke6m+NOFNdaz8iEBQqC3UJi1OPh2+SZLJp
         djC1w3gp7MQnkxOMHllx8iFxNM2tIUL+BGnpIWJ6QI9JmNv4naiewt2spVAhdz7Ya0u/
         bk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aYeChRbSSPfXWKbYkXW9f/czcjk7CTr5cofKA6xP7CY=;
        fh=hyzy+TxayWz/In4P0VKRQePECW1VB1oxFnxszjod/H0=;
        b=WPQbpVjVv/Wt8jx4EwuJEDxu9sboUyA4ayfJIBXxz+Spn0WuXZ8Md3LFUbA/gVouWX
         xrozpmIo23d0V5QwsEFRm/uhhGz2BdTSo5niN11PDSktXio/tL3+PsxcGAYYYqBmgWXL
         SNPq6XzSPi3U80yDxuLCuW9fcxABUg1a0aZgK5QhElI9Cncwv/e+rHP8C+0ecop3IBdY
         I2CE7K3sahEIBy+l2dKNWK3rDkRlnxupinxJO5eQuUt3HeWGD6CJFhpcd4SY/+J8HAP+
         IjirKAm2lxFgfDijfUA18GUZb5sL5UtnlFMbk8Dwf9IX955RH0a6gXbLH4wGo/bJsYLu
         eLqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785516087; x=1786120887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aYeChRbSSPfXWKbYkXW9f/czcjk7CTr5cofKA6xP7CY=;
        b=YmYK+tOTXBG0MUvCAo17J9cfVRGL5Yq9vq/b3uc6yjLdYA/UbIffAoilyH1MkqXchr
         VBmEvmI7azxeFhje/5FJF/nmuPWeYv/7chJUCG/JNZ52mfyIHG/9FVwvGrnI/L7TV5yP
         qHHo+wL2N9mtYwjphvfyxPDwMY5HkCjOH1THE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516087; x=1786120887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYeChRbSSPfXWKbYkXW9f/czcjk7CTr5cofKA6xP7CY=;
        b=qlgIV/rQIiCJhO4Nq38RjmPXPvO+gtFpn1ryUiYpPajNfmmkFbzYioTAhUOrxwEhxV
         lvMph3GEst4kgAKBCBWPWc1TA1TmGRZtis1Sf3gxzrTQAYqH0Nz2aB+zskV3Xx/jSVAV
         wU45Ye8tXntoEAy3cgcZhgQVBWhvsfi5ccqOPP6EAobAJlxVJCQZNByhT21g7zaN3AJ1
         soEXwD6ykGb475u1HQ+VZUYIYG4Q65IVh9qJXmqFrE6G7OjvnNiVk1PyFmIYqPcD23Pu
         vHFsHGl+lb0NaX4NYt661lEmCIu7uVtfHifeyCTJ9lbRuykZ6v6caYCZyu+DdugBM5sC
         WVmw==
X-Forwarded-Encrypted: i=1; AHgh+RqczfQz96wJwbwuGjeta7456EsYyahK/dEXe4SR91l27FmQBu2TX4yNJ/0YQVB5hy0zuReQgkDxGhRjTIBl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2CIz+E6GPu2raEkPATK6jZisZnqYWEPXhB8scfVD4O4akVf4
	IktnOW55ZvJtxwgnwW26OTJtQ/sz6pFndkC6zFpL+Ehv2+qTCOE9R8MYkbS6D8f2Zabh9MlHtXO
	oVdPmOgFYAdDOd11hgvmvsS5OntrDLgJQVOvYpwgTpA==
X-Gm-Gg: AR+sD136N5nz7Fb4jRuBDDuHg3So78lnEkeEOOnbFIFZp944+qVZeYxoUUi5Pwo49gF
	IjL/qFVrrbGQkEiizN9aGMdRs+o7gftarQ2uxN1obMS0ZEpZaYloJB9YeF5ikK4wJ+re38C/u2I
	VPqQ8VJHPzLE85tV6TqeiwwOVYUaqbW1guhNyGxaH0HZlOUQTn2XfJYpEsoAvnWjwNM5tL84Ugn
	lkZReZpmOW3LJiIccM0Wwc1AQmWZFLao0ZdacJgHWJW5I5XIY64WfLOgDFUDp8sUv5Bv/qbm0PA
	k30UOcvnrbnEBvlJtAJUW1YdMHYBqVxSoGlgz+8xwgKSa0Du4vq1kAv5ggoMgB6aLBaDMiAkBjq
	s
X-Received: by 2002:a05:6512:1092:b0:5b0:ce5:a04f with SMTP id
 2adb3069b0e04-5b2e4f93e8amr65433e87.61.1785516087036; Fri, 31 Jul 2026
 09:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
 <20260730152241.444632-1-yjkwon0026@snu.ac.kr> <yxm3q5glchsjgr3pudmcy2vtn3umneardtcnvbuxyfn4oaiuqq@77aualjjutwn>
In-Reply-To: <yxm3q5glchsjgr3pudmcy2vtn3umneardtcnvbuxyfn4oaiuqq@77aualjjutwn>
From: =?UTF-8?B?wq3qtozsmIHsnqwgLyDtlZnsg50gLyDsoITquLDCt+ygleuztOqzte2Vmeu2gA==?= <yjkwon0026@snu.ac.kr>
Date: Sat, 1 Aug 2026 01:41:13 +0900
X-Gm-Features: AUfX_myIYJBLZt1nPJDglDu80ps26Dq0mvcuZYB35jjsFoZjvKXRXDSK1Qedm6w
Message-ID: <CACwKKmDrTKHRZczEk4z-gO+yZNXgvEgFDzKFfJSUMR4oK5VA6A@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Fix stale object mask after concurrent mark updates
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Honza,

The last line can affect the result, but it only narrows the race.

send_to_group() can clear mark->ignore_mask without mark->lock. Suppose a
mark has FS_MODIFY in its normal mask and FS_ACCESS in a non-surviving
ignore mask. After old_mask is read, FS_MODIFY clears the ignore mask and
a concurrent recalculation scans the mark without FS_ACCESS. The add then
puts FS_ACCESS in the normal mask, making new_mask equal to old_mask. If
the scan publishes before the aggregate check, the last line catches it.
If it publishes afterward, the check sees the old aggregate, skips, and
the scan then publishes a mask without FS_ACCESS.

A raw mark->mask comparison catches this case but misses FAN_MARK_IGNORE
updates. The inotify old/new check has the same structural problem: its
replace path temporarily sets mark->mask to zero, which a concurrent scan
can observe. If the final mask equals the old mask, the updater skips and
the scan can publish an aggregate without that mark's bits.

I will therefore make recalculation unconditional after every successful
fanotify add/update and every update of an existing inotify watch. The
fanotify remove path can remain unchanged because it only reduces the
calculated mask; inotify removal has no analogous conditional skip.

I will send a v2 implementing this.

Thanks,
Youngjae Kwon

2026=EB=85=84 7=EC=9B=94 31=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:27, J=
an Kara <jack@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri 31-07-26 00:22:41, Youngjae Kwon wrote:
> > When a mark gets a new event bit, fanotify and inotify avoid recalculat=
ing
> > the object mask if the cached aggregate already contains that bit. This=
 is
> > racy with a recalculation triggered by a concurrent update to another m=
ark
> > on the same connector.
> >
> > The concurrent scan can read the mark before the new bit is added, whil=
e
> > the updater reads the old aggregate before that scan publishes its resu=
lt.
> > The updater then skips recalculation and the scan publishes a mask with=
out
> > the bit, leaving the object mask stale after both updates complete.
> >
> > This can be reproduced with two fanotify groups watching the same inode=
:
> > one thread removes FAN_MODIFY from one existing mark while another thre=
ad
> > adds FAN_MODIFY to the other mark. After both fanotify_mark() calls ret=
urn,
> > writes can fail to produce FAN_MODIFY for the group whose mark now cont=
ains
> > the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> > equivalent inotify interleaving loses IN_MODIFY events.
> >
> > Always request recalculation when an existing mark's calculated mask
> > actually changes. For fanotify, compare fsnotify_calc_mask() before and
> > after normal-mask, ignore-mask, and flag updates. Keep the cached aggre=
gate
> > check for unchanged updates, and keep the flag helper's inode-reference
> > handling.
> >
> > Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNKH=
=3DX3LmoXMqakYqJaNw@mail.gmail.com/
> > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask=
 in fanotify_add_mark")
> > Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
>
> Looks mostly good, just one question below:
>
> >       spin_lock(&fsn_mark->lock);
> > +     old_mask =3D fsnotify_calc_mask(fsn_mark);
> >       if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> >               fsn_mark->mask |=3D mask;
> >       else
> >               fsn_mark->ignore_mask |=3D mask;
> >
> > -     recalc =3D fsnotify_calc_mask(fsn_mark) &
> > -             ~fsnotify_conn_mask(fsn_mark->connector);
> > -
> > -     recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> > +     recalc =3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> > +     new_mask =3D fsnotify_calc_mask(fsn_mark);
> > +     recalc |=3D old_mask !=3D new_mask;
> > +     recalc |=3D new_mask & ~fsnotify_conn_mask(fsn_mark->connector);
>
> How could this last line ever change anything? If old_mask =3D=3D new_mas=
k,
> then it would look like a bug that some bit from the new_mask (and thus
> old_mask) isn't already included in the aggregate connector mask?
>
> I can fix this up on commit but I want to understand why you've kept the
> line here just in case I'm missing something...
>
>                                                                 Honza
>
> >       spin_unlock(&fsn_mark->lock);
> >
> >       return recalc;
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inoti=
fy_user.c
> > index ed37491c1..c44f2daa1 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -565,17 +565,8 @@ static int inotify_update_existing_watch(struct fs=
notify_group *group,
> >       new_mask =3D fsn_mark->mask;
> >       spin_unlock(&fsn_mark->lock);
> >
> > -     if (old_mask !=3D new_mask) {
> > -             /* more bits in old than in new? */
> > -             int dropped =3D (old_mask & ~new_mask);
> > -             /* more bits in this fsn_mark than the inode's mask? */
> > -             int do_inode =3D (new_mask & ~READ_ONCE(inode->i_fsnotify=
_mask));
> > -
> > -             /* update the inode with this new fsn_mark */
> > -             if (dropped || do_inode)
> > -                     fsnotify_recalc_mask(fsn_mark->connector);
> > -
> > -     }
> > +     if (old_mask !=3D new_mask)
> > +             fsnotify_recalc_mask(fsn_mark->connector);
> >
> >       /* return the wd */
> >       ret =3D i_mark->wd;
> > --
> > 2.50.1
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
>
