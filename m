Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309D38F649
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786824006; cv=pass; b=hjj0xlxo3cHpUWSpMtxJtjVdo2UTYtvDmslA5tMeF8Q+UGpaD3fr6CTKNgjHc/dWwHoKi/luaHH7U0tLd71vXubzPRhzLx2HOnJbIGzwLpLiIx79LHz/YdQn5qnoH1H0HxkDql8AECGvnYFs/X9S5bYvBuFMVkx/00n0bd9yI0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786824006; c=relaxed/simple;
	bh=H0SAaDMcoUlmzvCFWtMI0+/aSNhKwVoOrwEM46qLy7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOcArBgPxMvq5/teFQtvSbkhh9a8lmykxptpHS1oDgKVxhuAu9Hbwh0oXfcYyaW6/cRv8SEIYkGJPnUF13Wlzi3nMpCZzqq3Mvo5DnIBhAW64GN3tCr+RSogAzWj6TxIHnyPOj/z0jhKK9OeD+bsErixh8+Rq1uJkRUZViVvsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgOdzVtw; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgOdzVtw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15c42a45adso468395466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 13:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786824003; cv=none;
        d=google.com; s=arc-20260327;
        b=V47niX5WpIPM7gdqGmiDBtc7x5PtgLPX4CRNBAwo2Ip1DOS4TtpdJLCIjI/0TAGGiR
         zwkoTApQn0gqVjXmL2keg4JRK0F46gjraxzbNeMaIFerpSaezLYszQqPjQnI0b5scYFE
         /lO8sGXFysf+bpxCeGT4kEystLcG0pXKD+NDiXVZ8E3kO0Kg+e+o1G3iq+PEuloAYXsC
         iC67DISvVtA+4yU+2SI7VQ7Edno7lOSJj064TIbfvjFCBa8s/GdrliB7KbgTv453mdT8
         S0aJir0Da/NdjBabquo8awyaHWWy5BZ4a1HiZvwNBydXxpMA4Yi0Nma7sxDKJz09wlt6
         YR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        fh=g4ODhJ4xrnk2uocYGz4UfFC8evhcgD36PcbnDqdqN4k=;
        b=rceF82SgLw/FqVgZnGddmY6i6Hsh76ZuJNHGV42ZCBI4Zej3tQgc9ByACYmK1P9m8V
         ml2782wRlUl56YDXoKu0poWkfDfDUCHC69qZ4i6lxlyp5pHzaO19DfVPO8hS4l2MYV5o
         JG8icZA2i1r3xVcirZu9Ywhj97o6SGWB1nAl1cj3QxmtPyzMhbcraFqVD/iHp+VVGCWg
         krSjfLDHhsAxa8XjaTzWWWDCApfP9foR4evQFFe5vmWtBiDOaJfAkNJClY6FAdzuVj7C
         P+aLPcfqABOmXexm/EkbezHJw4KiWWpwsoV9T4pDypVS1ooV790r4ogjBXYAwOCQ8i6w
         EUkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786824003; x=1787428803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        b=HgOdzVtwwD/mghUiKVMXYtiQyiY3F4/XASd4/7e/XgeHVzP0a5vea4U9y118ebA/bX
         VZaIIbEk6af2uUfz2JDKlozc/aC2dujCPY8jfGpbbHOnXdkGYGgvyx/klVAD/CPQsS2m
         k4++Rx5OBDsQwJURV3BceAzrTIah5PS9PeEsaP0jCgM2oBqdZ0sd6nB2qKkO9guy9u+n
         CQnigH+CJtCXZNtD/WBtCpE8vpBHYbkdThlTTlpeyDCrNe6p05jQx28zPVBnm+7jpglo
         euF11Asxk7C5sjxCFfSLWWff7CW6H93vSYuTTXhFqcKuKDzPgCBP66++tmLjT9WfQmP9
         1P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786824003; x=1787428803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        b=FBtl/38G8joov0OxHhDzMuWb7oFp3Wqdwev2cUGNBhObJOfDB/vyRGRnK/eotDOIHE
         Nrjs62BESAGX91vIy8nBq/SGVtLeHkeotVO/W3FtGTQX1sew8g04/gGCVRxfhpjdHBzu
         TKgNsZ1lW1Q8HCPHApc6oQ0l+8uqnJ5XxhYQK5q4cELrpGIelBzQ3gnjhXvFRetSjkZZ
         KcvDSdxrhBLvGzWNmjCsewTRpwQ+AyHUXxXpiSPS27kpvZKMmywmRY3kuFAOfGKQs9N2
         kjKyaMM7kNUM7GKJbsQPMIfwEFxZIOVQsZyR6N7e6vev5EvBsbUEj/ise0QnheU4x69H
         SwwA==
X-Forwarded-Encrypted: i=1; AHgh+RrPeY8k5uKRbMyY/MrjyBX+1iKmQf+emympAue124tzl1ycK7zzDn+u3NqiIB6ilO63NOVNNd35jjH8RG1p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VWVXfhtphqxPy/3QX6Mk1JYAE4Wm3Qt5xInaovgCpyXSoAmO
	9zoXZgQGtLQ6U9+EiE1ei2ZiWqHZak4Xgu2EfTldsOjtBbZK3UNlstFthW8fU8OLKaw3YIOpcU9
	ihrJOZuDrRpjrl8zsI0saNwiRqC1Hri4=
X-Gm-Gg: AR+sD10aewWlBKBlthwDQRfP3HTW56cTD6l8SEEOCvWSViCbQZ/DGUW5eoHO0VS4ZT7
	iu2JCS7K8N2dtBVpsKiOtIU80RFltPPqPAeaPhW94Zq44M7KgE0G/9VzaSD2+pvA/pQRquL/irN
	KKBYnmhe8T93vzimN5Cqn6Nb5KLWihra9sTH1s7Ql7ZiS2f44znWVN5EKUM0rWOPPy5VVMWiVDE
	Mxua3mC56IjbUBAN2sWvK+GlVyz5G3CfNRTwwo08gg7X9taZfb3hg15oZuTrlXbtUDh+pMiEr0v
	OMvBFdDm3/rIQN1HmT1iVgrBQBoXuI7moHcdLzQj57Qc/QnMvIBht4Rw
X-Received: by 2002:a17:907:7b8f:b0:c1a:25cc:e585 with SMTP id
 a640c23a62f3a-c212a26746cmr765316466b.5.1786824002104; Sat, 15 Aug 2026
 13:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
 <20260802015801.2426818-1-yjkwon0026@snu.ac.kr> <gc2bqp2c3a6emhshpewjalti2j26a5zsrmd6s4gopzvmofklqw@xjnfn4tbaktb>
In-Reply-To: <gc2bqp2c3a6emhshpewjalti2j26a5zsrmd6s4gopzvmofklqw@xjnfn4tbaktb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Aug 2026 21:59:50 +0200
X-Gm-Features: AcwNN1VACDe4mHrw2k0mqD7AUeiw0lt5GsWsA2spzXTFlTeJDU7MkFWcw0jVPJ4
Message-ID: <CAOQ4uxhuFVKmBP0gq1o302p=eLk+wyuDsjJJ-w14gKQcVcX4_A@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: Fix stale object mask after concurrent mark updates
To: Jan Kara <jack@suse.cz>
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:54=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 02-08-26 10:58:00, Youngjae Kwon wrote:
> > When a mark gets a new event bit, fanotify and inotify may avoid
> > recalculating the object mask if the cached aggregate already contains =
that
> > bit. This is racy with a recalculation triggered by a concurrent update=
 to
> > another mark on the same connector.
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
> > For normal fanotify additions, recalculate whenever the raw mark mask
> > changes. The normal mask is not cleared asynchronously, so an unchanged
> > addition cannot introduce missing interest. Always recalculate ignore-m=
ask
> > updates because FS_MODIFY handling may clear the ignore mask without ta=
king
> > mark->lock, making snapshot comparisons unreliable.
> >
> > Always recalculate after updating an existing inotify watch. Its replac=
e
> > path temporarily sets mark->mask to zero, so a concurrent scan can obse=
rve
> > zero even when the old and final masks are equal. Assigning the replace=
ment
> > mask directly would avoid the transient zero, but existing-watch update=
s
> > are infrequent, so unconditional recalculation is simpler.
> >
> > Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNKH=
=3DX3LmoXMqakYqJaNw@mail.gmail.com/
> > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask=
 in fanotify_add_mark")
> > Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
>
> Thanks the patch looks good to me, I've added it to my tree. Amir, are yo=
u
> happy with the changes like this?

Sorry for the late reply.
Was on vacation.
Yes, this seems fine to me.

Thanks,
Amir.


>
>                                                                 Honza
>
> > ---
> > Changes in v3:
> > - Preserve the normal fanotify duplicate-add fast path by recalculating
> >   only when the raw normal mask actually changes.
> > - Recalculate fanotify ignore-mask updates unconditionally because the
> >   ignore mask may be cleared concurrently without mark->lock.
> > - Keep v2's unconditional recalculation for existing inotify watch upda=
tes.
> >
> > I will send backports for stable kernels through 7.0.y after this lands=
.
> >
> >  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
> >  fs/notify/inotify/inotify_user.c   | 15 +--------------
> >  2 files changed, 8 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 9ee373ff5..9c27db2b7 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1321,16 +1321,18 @@ static bool fanotify_mark_update_flags(struct f=
snotify_mark *fsn_mark,
> >  static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> >                                     __u32 mask, unsigned int fan_flags)
> >  {
> > +     __u32 old_mask;
> >       bool recalc;
> >
> >       spin_lock(&fsn_mark->lock);
> > -     if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> > +     if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
> > +             old_mask =3D fsn_mark->mask;
> >               fsn_mark->mask |=3D mask;
> > -     else
> > +             recalc =3D old_mask !=3D fsn_mark->mask;
> > +     } else {
> >               fsn_mark->ignore_mask |=3D mask;
> > -
> > -     recalc =3D fsnotify_calc_mask(fsn_mark) &
> > -             ~fsnotify_conn_mask(fsn_mark->connector);
> > +             recalc =3D true;
> > +     }
> >
> >       recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> >       spin_unlock(&fsn_mark->lock);
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inoti=
fy_user.c
> > index ed37491c1..5f19c24ec 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsn=
otify_group *group,
> >  {
> >       struct fsnotify_mark *fsn_mark;
> >       struct inotify_inode_mark *i_mark;
> > -     __u32 old_mask, new_mask;
> >       int replace =3D !(arg & IN_MASK_ADD);
> >       int create =3D (arg & IN_MASK_CREATE);
> >       int ret;
> > @@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct f=
snotify_group *group,
> >       i_mark =3D container_of(fsn_mark, struct inotify_inode_mark, fsn_=
mark);
> >
> >       spin_lock(&fsn_mark->lock);
> > -     old_mask =3D fsn_mark->mask;
> >       if (replace) {
> >               fsn_mark->mask =3D 0;
> >               fsn_mark->flags &=3D ~INOTIFY_MARK_FLAGS;
> >       }
> >       fsn_mark->mask |=3D inotify_arg_to_mask(inode, arg);
> >       fsn_mark->flags |=3D inotify_arg_to_flags(arg);
> > -     new_mask =3D fsn_mark->mask;
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
> > +     fsnotify_recalc_mask(fsn_mark->connector);
> >
> >       /* return the wd */
> >       ret =3D i_mark->wd;
> > --
> > 2.50.1
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
