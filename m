Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795178628;
	b=p62U5QaoFW9X4nMeVhuIIv+lYbhZAkSG3sAhr2ZFytuwGjqAHjSxqBVotJ4e6H0miNiv
	 y+9E9ZqCepzX5yNzl6CUjqzU7y8h9Q2Ckac1geRRtWkQE5ziPLC3YT4MVdTG0UfBaILt3
	 T9MI8c6K2tFnbmhW1tgQpsEq8DJR3/c8rW6giN1WEM9NgJ6M4OMhssnKym+rF7y5K1BQR
	 3AYXmdFCFcVIECKhPItDJHHuV7+Vqe3rricx75bcuKdmL2LKWnGnyNWfgn34yyi3W3sAh
	 E0g+oKhgZa97yPC1WQtHnQBtTCaw8h2ovwVZJTprHlvmukqZPp0AUmDTL7BfUDtD+gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TJ+eeQ57O4kTx3qsNmiukGiIfub3RnkhaOW68+iHads=;
	b=Ggv9PdUfrQQqBIGn/HFZlMpSaPmLu+tkUGW81MRta6Y94llJ2zS96TX+/soCLeTtyWNv
	 xZIUp5+6TZUqf3UbcijTh/BMxW60z9wN2AW8K3eTNa6t9tlidGP+M5ZRop4IlgxOix+6D
	 rKThavL4Qad/jpNIa3BHHlV+jCUCWg9zyz0cRv3r6B/o4Xp9KdS8Z9pHeQV7crCYe8ieU
	 KcrUANF0SBI75HgkL1YsJ7bSlcCbCKKaQFy46bMm15R7YgnnuUbP8DgWtBpCkc8kEysjg
	 QGCnpPS+SwXsSFDUPPh07RyCRVVtz3Zg4tu2b6okIKih8ihotp0rg5k6DYEPRiGZ/bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywktutcD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D76606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D76606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywktutcD
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so869961a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 04:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795178626; cv=none;
        d=google.com; s=arc-20260327;
        b=qYdBEUVLSd2JgWRY1ZXNxlIbPy4mF1Gq51SxNjcsr2oUQC1W3RLTBrckQMAKRu804n
         aGRwy/UsEVBRz14tfSW1bhBv0hH+mPZoR+8EkfIw8MWEfIwZq+Y2DmDynspHkpvdyXJW
         zkLdOy6CiLv1czYzKhdAiSMoIE2ehMg91FdMnvEn4RpxBILxiO0uJEpNMhtmv3AnhB4D
         Qj1rLAd0UDmngOdkJgsZfPTs1Ys1eDzzDcSIdYF5hge38+udUl8Loj/9RxfxUHI7PrUi
         Xx8i5/kIbDphTXvzupzfUEgrAkMdemZpgNnGfBhlp0SIZEttrPMg4ito4YhF7MfkpQkK
         Nrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJ+eeQ57O4kTx3qsNmiukGiIfub3RnkhaOW68+iHads=;
        fh=57OX68zIk7FOfwUDlMtXi8BUGcP7fW8o8NwrcHPZb6Y=;
        b=EBW5hs9JoP0P5LXHPPserg0G5VLqxtdIXyqNw8jEpl0RmTvHbTZHikBd41H/AHP3v7
         L+y6FMrW1Pa/W2QPU5DYUUKT0eSJ1hTYK23lV4gdV9c8Qjdn+GhgSGZM+eWUH9zkRmtX
         x6ycxHk9Fz4sGgEY5TtA/3yBSjPEyRzTsEYSBZxl+LyCj0U/wxHZwyfaZaJelPSbJCoK
         q0up04Qrp/4uToV1hHuR6U8kLnXsHuTwayPLZkS31EXNoD6ZNy1WH64IA9Y4MLP05FIS
         5MvrGIVpJgRrCHnjqC5UZwwjHEJIOnlUQkMGuUz7RwTrwUizxz89tPFbNPfqHE9Qx7Tm
         xmuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795178626; x=1795783426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TJ+eeQ57O4kTx3qsNmiukGiIfub3RnkhaOW68+iHads=;
        b=ywktutcDJAVz3wdITMJbeA8rkCIaBxjC+IqdTznGfFTy/pbh+tkan3xGluUpLgfkJ3
         hVVSZAXkCQ+pBC7hhwHSNnOzNb4qzwVzHHsg1k2ItfJHdisCr6zqli1NZsr/DzwQeZAY
         Uai/H/RO0cNTqKP04YaY5pOJyOBeiFXH7wVpqGfV4YsFq3DZi4WIFlgh7UcZ7TEcGmvb
         yZZCKr/xAGSZpvj8q+PQ2YqZ4WELJhWAUcIMH1CPHJhh8Bcssoko1EEPQ/WiE/VJMfCu
         E4FzE1d1vCqzN0YH2qkptA8ki1T3ApozK/jeiSx5vV5M/qYK8v3lJlDUu/zpVZMUuas7
         yYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178626; x=1795783426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJ+eeQ57O4kTx3qsNmiukGiIfub3RnkhaOW68+iHads=;
        b=D032CNThsU7RsWjpRsVlDt1akAGjHUPscIgzf0xO3OzeWz5r7f/f6maGHUamBUJ58M
         31XFvA3DS19mCZcPIzrD0JZ+//SXEYr4S3ydafwCfXBvfM0Bv2iC37i1szjDcWk/R3A6
         TfQ3AkqiF7Y70C3YoLKajlEkhg9/G2gzredAX52xGDrd+GNhFce+onoDM0Yk57HGY0d5
         /gDNyggOTO3Pew3zV699lDF1u/uA8SPCcgPI2sy2zrSHwT1U8Iu/P3zFLCVse8297S61
         BX1FJG52jlX+BprRQ6DbBsklGdz9Rgm7p7SEeQ4poVlGvCgl8n7sp2rMflGM+D7gAUKW
         B8OA==
X-Forwarded-Encrypted: i=1; AL+hErFq7j5NRiEd0fBbdHHpdrTzalY+eNN8sdKIGb5F6keHYHQQsYcfSeNT8SGxs9wH3imPpvUaB8rjoW6T9n3I@vger.kernel.org
X-Gm-Message-State: APuU4Z9p/cgI4JmhJbnODWwbBo0RO2drZhvvIRrDG5EaWvWWjGxff41t
	TJhW3TSAx5N7nrqSOzC2/mgUcD6v/GxXKBvrmo+V794YsZ8XiT4X+/R9K/FA6/MmYNQl8LckvYb
	d0uwNxaNs54pIizKL9nIeyWqX86tAWhc7UjngeqmfiA==
X-Gm-Gg: AZFdTZf8I6Wpr4CsVsKuelqVz2fhcCmVU25iGpJYDs/FowI2uQKXw2lYgZegaG6v5qw
	zMtrCKTzxil8ea2OSLvpqPzTQpbAvKC27Rj2depI+HnmAgQIpLl02Sv29beNcY4SgPAdlUKw0NB
	uK2LJcbnRf+WwfGYrbaH0pzfhy851CLgHpSYurCiI1yKWIoa9AxpR7oygyr2kURGsXrzfEEOzCO
	YTOrS4HYFPiT0HePOqzSPhG0mZ3LSbfxUT5xXyOg13qnpzjez8zQMreL6XdE23FR5F6ZVgRJ5wI
	MyBP12l+86nYZpN240QslocjvBjWEpW0s7CiWr5BxPI6t5TX6YiM7WQYns0mPAqwsQoHZSiPVcc
	lBHVEroF/OrRqoA1ucaAgxtwwau0diT5RT+tlI0bFEHjwnurKPgheSX488EemTcbMyD98Rg==
X-Received: by 2002:a05:6402:280e:b0:6b7:d55:87d3 with SMTP id
 4fb4d7f45d1cf-6ba37ea7696mr1994022a12.36.1795178626027; Fri, 20 Nov 2026
 04:43:46 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119025942.2848130-1-neilb@ownmail.net> <20261119025942.2848130-3-neilb@ownmail.net>
 <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
In-Reply-To: <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 13:43:34 +0100
X-Gm-Features: Aa3M54qy76OmVkVDlQrjcASI5MLOeuOS5yDaKgdB9RmNQh5aB3uSEkS8ocfTEbE
Message-ID: <CAOQ4uxgEqDiw2=dCM_PV9kObBboCmt7ohnHehKR8cgKyvLTPUw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fsnotify: update children flags only when adding
 mask bits
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 10:48=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-11-26 13:57:02, NeilBrown wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Since we only ever set the PARENT_WATCHED flag from
> > fsnotify_recalc_mask(), there is never a need to update children flags
> > when removing mark mask bits only when adding them.
> >
> > Add a helper fsnotify_recalc_mask_and_update_children() to be called
> > in cases where updating children flags may be needed (i.e. add mark).
> >
> > Also avoid update children walk with mark spinlock held.
> > This was only done by dnotify and can be easily avoided.
> >
> > neilb: added update_children flag in fcntl_dirnotify() so we only
> >   do the update when needed.
> >
> > Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
>
> One question to Amir below. Otherwise I like it.
>
> > +/*
> > + * Recalculate mask and update children dentry PARENT_WATCHED flags if=
 the
> > + * connector started watching children.  When parent stops watching, w=
e
> > + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_pare=
nt().
> > + *
> > + * The caller must make sure connector and connector->obj cannot disap=
pear
> > + * under us.  This is achieved by holding mark->group->mark_mutex for =
a
> > + * mark on this list.  mark->lock must not be held by the caller.
> > + */
> > +void fsnotify_recalc_mask_and_update_children(
> > +                                     struct fsnotify_mark_connector *c=
onn)
> > +{
> > +     if (fsnotify_recalc_mask(conn))
> >               fsnotify_conn_set_children_dentry_flags(conn);
> >  }
> >
> > @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark=
 *mark, u32 set, u32 clear)
> >               recalc =3D true;
> >       spin_unlock(&mark->lock);
> >
> > -     if (recalc)
> > -             fsnotify_recalc_mask(mark->connector);
> > +     if (recalc && fsnotify_recalc_mask(mark->connector) && set)
>
> Amir, why is the '&& set' check here? Under normal circumstances if
> fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
> racing with other updates to the connector list of marks and in that case=
 our
> fsnotify_recalc_mask() call could be the first one that noticed the marks
> attached to the inode are now watching children and is thus resposible fo=
r
> setting children dentry flags even if 'set' was false. So I think it can =
do
> only harm...

You're right. It's wrong.

>
> And for similar reasons I believe fsnotify_recalc_mask() call in
> fanotify_remove_mark() needs to be updated to
> fsnotify_recalc_mask_and_update_children() as well. Standalone
> fsnotify_recalc_mask() is simply never safe unless it is followed by the
> update children later - perhaps make it __must_check?

Yeh... neither dnotify_flush() nor dnotify_handle_event() check return
value now. I'll need to look into that.

Thanks,
Amir.
