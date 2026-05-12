Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4A379C28
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571624; cv=none; b=MfRaDc+pA1rE6batXswHun3POn6DomO+9q1Xlt9+GRR6A/1G1fgvgOPH3oNcM/1tfYLO4FCp7cTHEeyd90w6JUpiw3oigdPT3b9A9702sA7i1rG+bJ7Sz6ycnBT3f2JW/hgjGxZrlWs7t+cAyyht7ABrLjjeLPMvfLGO/iBpQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571624; c=relaxed/simple;
	bh=U2MocqTuHxqIz3JSjgQhCBTyoqlgsh1ZhUDeF4sLw0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGG7G6+9KgN94LBvy7Gh8wiOLtlndsQPhqD9Dur7QhXCgMpRcPgvU8Gbz2sz2Jl1SR2Qp30VrpYEJC5D64HKUsxgsY+OGNHpX1Q2Fr+Ueqq3X6FXigDxF2uSsIxh9rWbroEvFgnn66PXVYv9Y9xtbtkSXeHpcLm6DeinbmAvKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/M1+7/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/M1+7/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6AFC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778571623;
	bh=U2MocqTuHxqIz3JSjgQhCBTyoqlgsh1ZhUDeF4sLw0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/M1+7/I8asaz4DV3lvCMmajDkPM3cv3D5TuLgAKHV4m4j2LnsOwYTNHoAutBGGHG
	 F9/9UT0y827x8xWM9KyWYHeMmi9qcdaVB3igiRCx/5auRwq8zQI6N/XpdvbojYHMBF
	 hxTQDTW3s3ES9Iz9E9Jd3NBCfliVi6I4EuVViU2J+4Sg0DyGO93TXgx7pKDZbxjRAb
	 ZSSlI60V1vn4BT3+p4yQJsYShW/JT0P2vrgz1EAhh32NhGmdv986VsdpqWr1kK8T8h
	 AGXFJWVQMcEzIxYHHaufYIxHj7yM0Jyn6bfFBCiDCywOhoc2jd779AvXAZtFrKBy9r
	 /e4F23NFXqNUA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so3295226a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 00:40:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ89X1bkbiOxqbFy7FyLP3/UwtMnYQbajeqXE5/Q5ojbBL8jT+viypRp+P8D/+Mks2hnivEE0tL9AJ8DaIMo@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9Q/mnC7ttumUAVYlmC+VBAMGnhjFzWZGU2oyrYzLxlYNskfC
	mbnFL/ZJHSb9yQP6rVJkVa3d5W8xIx7BfFVJCMVPqvDkMsVbe8DUSU6QqHojyT1AA8WF3UyjVPN
	FZGO9+V/uGlFOzQrQCy2USDOGNnftKdY=
X-Received: by 2002:a17:907:94d5:b0:bd2:2657:9b7f with SMTP id
 a640c23a62f3a-bd28fdaac5amr89193466b.44.1778571622089; Tue, 12 May 2026
 00:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-8-linkinjeon@kernel.org>
 <20260512063416.GA30619@lst.de>
In-Reply-To: <20260512063416.GA30619@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 May 2026 16:40:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-J71VsgX1NewxE1SkrMqUS+rU6FeD4Hf_ZUXHY0gAZ8w@mail.gmail.com>
X-Gm-Features: AVHnY4KRa4CnqQRuTOF_C2EFhbK9Lr9HhwL3cMjI-GsQbMeMlx508hQKQgTxP84
Message-ID: <CAKYAXd-J71VsgX1NewxE1SkrMqUS+rU6FeD4Hf_ZUXHY0gAZ8w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] exfat: add iomap buffered I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:34=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> > index 415f987afa9a..448857d4b70f 100644
> > --- a/fs/exfat/exfat_fs.h
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/backing-dev.h>
> >  #include <uapi/linux/exfat.h>
> > +#include <linux/buffer_head.h>
>
> This looks like a bug-fix for adding exfat_cluster_walk a while ago
> and not really related to this patch.
Okay, I'll split it out into a separate bug-fix patch.
>
> >  static int exfat_extend_valid_size(struct inode *inode, loff_t new_val=
id_size)
> >  {
> >       struct exfat_inode_info *ei =3D EXFAT_I(inode);
> > +     loff_t old_valid_size;
> > +     int ret =3D 0;
> >
> > +     mutex_lock(&sbi->s_lock);
> > +     old_valid_size =3D ei->valid_size;
> > +     mutex_unlock(&sbi->s_lock);
> >
> > +     if (old_valid_size < new_valid_size) {
>
> The old_valid_size value can be stale as soon the lock is dropped.
> So the lock here is not useful, but unless something else protectes
> the value the code might be racy.  Also why does this use a sb-wide
> lock for a per-inode value?
I will remove the unnecessary s_lock and change it so that it can be
protected with inode_lock.

>
> > +     if (may_alloc)
> > +             num_clusters =3D exfat_bytes_to_cluster_round_up(sbi,
> > +                             offset + length) - exfat_bytes_to_cluster=
(sbi, offset);
> > +     else
> > +             num_clusters =3D exfat_bytes_to_cluster_round_up(sbi, len=
gth);
>
> Why is the num_clusters calculation different for the read vs write case
> here?  Also shouldn't the may_alloc case also update length given that
> it is used later?
right, I will unify the num_clusters calculation logic so it is
consistent for both cases.
>
> > +     if (length > cluster_length - cluster_offset)
> > +             iomap->length =3D cluster_length - cluster_offset;
> > +     else
> > +             iomap->length =3D length;
>
> use min or min_t here?
Okay.
>
> > +     iomap->addr =3D exfat_cluster_to_phys(sbi, cluster) + cluster_off=
set;
> > +     iomap->type =3D IOMAP_MAPPED;
> > +     if (may_alloc) {
> > +             if (balloc)
> > +                     iomap->flags =3D IOMAP_F_NEW;
> > +             else if (iomap->offset + iomap->length >=3D ei->valid_siz=
e)
> > +                     iomap->flags =3D IOMAP_F_ZERO_TAIL;
> > +     } else {
> > +             if (offset >=3D ei->valid_size)
> > +                     iomap->type =3D IOMAP_UNWRITTEN;
>
> This might be a good place to explain the valid_size scheme and
> how it affects the iomap reported types/flags.
Okay, I will.
>
> > +/*
> > + * exfat_write_iomap_end - Update the state after write
> > + *
> > + * Extends ->valid_size to cover the newly written range.
> > + * Marks the inode dirty if metadata was changed.
> > + */
> > +static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff=
_t length,
> > +             ssize_t written, unsigned int flags, struct iomap *iomap)
> > +{
> > +     if (written) {
>
> Return early on !written to reduce indentation a bit?
Okay. I will change it.
>
> > +/**
> > + * exfat_iomap_read_end_io - iomap read bio completion handler for exF=
AT
> > + * @bio: bio that has completed reading
> > + *
> > + * exfat_iomap_begin() rounds up MAPPED extents to the block boundary =
of
> > + * valid_size. This ensures that any subsequent blocks are treated as
> > + * IOMAP_UNWRITTEN, but it also causes the "straddle block" containing
> > + * valid_size to be read from disk. The disk data beyond valid_size in
> > + * this block is stale and must be zeroed to prevent data leakage.
>
> We've seen this in ntfs already.  It also seems like a generally
> useful thing to do.  I wonder if we should just unconditionally
> zero non-fsverity data beyond i_size or have a flag for this
> (although that might be hard to communicate).  But let's revisit that
> after the initial merge as there are too many different series in flight
> in this area right now.
Okay, I will check it after finishing iomap works for exfat.
Thanks!
