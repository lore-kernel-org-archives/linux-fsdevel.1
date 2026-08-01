Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E12AF1D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785590333; cv=pass; b=k/cQ3CNoFOvXSHRvTDHtuSeAeMIwGBP2vQ4L0elrefHFbEBIUPb8hAg4iRid/MhcmgMud8s/PLvfGnh1Zl4X6gXa9bGRGbTfc7heoB+PI1K544P7ljtIbHADLVch2nJHcA3fSQv3ogF6XNQWjwTKlpnC9/8N+6FDnBiWf7nGa0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785590333; c=relaxed/simple;
	bh=4NGEx+4P+2tdbtO3YxEaPAUql5Hb7dnmzv69FoH21HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5lLu6SWoMO1HFTklOcp866QSjkSuiJzrChJHOOrxvdBymzxv3iBkM815NZ/G07gMLze2cy3kq1HGrf51xTQK8pN1tCgTPh7aVHWnlnboQdYOk+PVVg1OgUSyarRgK3dh7iBd4KGd/qHn83HhH8qe+oTYgnsYBZotlZDlTCyxEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8ojHaNq; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8ojHaNq"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15e2dab83eso292061066b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 06:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785590330; cv=none;
        d=google.com; s=arc-20260327;
        b=Ca1kMmaLRacd6Bmx98+u8H1Euez8zdeZsQx04CwK+8GjSqXhe60o2nCkaVKnroXlS9
         6L2pVOC/KfFMR4+bA98sBwI5LbOEQWN69C/wrRNjScul/DKHNflBw4XtxKl/wkyQY23r
         3CPFfbq8k2YRUAH9Rba2h0z30fHsR101cSUCRk2PIXVMwpNJdgjF8TC7gnjbuGuoU0Tq
         DcjA7uB+xERQBExbIXspjXFecUiFGBima4I2uth2+JfPNGWUGjPnTQTEU7tZWvLFtRTs
         Bncs+kIqlWDZ9yCy+0u6mZO6biyEDqmgFcp6T0sQjvIvQM6lFASVEZykCVRyamcAO5Hy
         kR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iygNWQGmruOGvUaJK+fgKr93bZtocwXmBZLE9BZnrCc=;
        fh=lqpj7gVUNvG2ULC2wJEdSszDjpjRz/0yTqB0rP3Wwoc=;
        b=WirSD9+oZHr9XWQDfvyde+Yo44bJexnwsdFF3OvNNYxmIuuuLEUkyHCTFAlWQJGo9S
         S89NEbWCFhUB8bJvSS79sYwUIDDp2S9qDToFCw0RLP80BCcBMXYXiqqRx42l4NHSyi5u
         +SqfyJvLpI/R5LmIU6ff/52EvaTu60K4OqKe3yjJldLsfRcBvyUstFSbuetRxDHTvy6k
         9z0qxVkmmwv2KlLbigU9OuyoTwNk2n2LjBNYxqVJIiwovlUp4rwVvXaqaYffqQdsg7W7
         BMIAUNfeUwo/hzN2smUiOqJO9/CSQLQvGNrBIR1YK3xp3m/ldvpPKlVHW8TkVAN3nzs3
         O/yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785590330; x=1786195130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iygNWQGmruOGvUaJK+fgKr93bZtocwXmBZLE9BZnrCc=;
        b=F8ojHaNqWevvP1nvTg+/RH8zIi1NwYdd5goIk+hYzRWB8vxpzAILw+K2y0ZqX2NWfA
         IRmuQuEXu1CH/B9fGuFeKJ9ip1/1S7MTdJ9DANXlQSm5/yShTLN/sGdoNzDl6sKXvoLa
         BSU1HqD5KIumLiCIbB2h1IpNhyBnpzvQaULR00GtQh5Mc/IVGdvX1CPHWiiulGWfRg/+
         meWkal63YtiZYy4SHOHFQqwDeXhyuHml1Y8pwhRS/x24slvmdhZvJRP774De0ZwGXeyB
         SZrPMhJVPvm81OlfK96INZQ3EDmlFkvdCIIhhEtkRc3V2MLQs9c0d1lNIa1wVixJN0XB
         DXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785590330; x=1786195130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iygNWQGmruOGvUaJK+fgKr93bZtocwXmBZLE9BZnrCc=;
        b=e7Uzh/x8Nb6K99Voy27v8qgrnmc+9BDbh7HrTzGD0gXBGzorTSjDVPrxy7mP0wNSAR
         9xYzBZzoaBeHx8+h56RClki+OlIK6aNIQe45O9SRnVF1m2THkwLV5oQvKo3GbA67+K7h
         62Hs2b9/5sCTd/smwwy250W8RJ+qhOPN0WalQltceShn6ONMJg2IMiOzpYWv1dyKyEN6
         y7/tLZeQUPOTMAvFYzA/C0vucCB0SmqU4L4tB4XzmklJb0a0AvuEFb8aJz4G1UcIlmDf
         Rplj4f47CNfv2p3U+nTsEKvJE7getF8uioo+wZQ1j4+rzXCxtA4/rkgNNl9XZ/ikpz+E
         B1vw==
X-Forwarded-Encrypted: i=1; AHgh+RrgJkCjPk4mXSp1qx0gJkb1GqO4TLUdoEEB/gVegeABtO8YVUMmklU1nnWEXn4JkWewXtdV8lccuJM9jIB+@vger.kernel.org
X-Gm-Message-State: AOJu0YzkObGHsmSbdrVv6hFDeLMYlgggujiOReO3MnaBlZY/Ns0ApjqX
	WnG4P5in6i88HYzrDXXByCD8zWycxjhT2xL9Eda76Q6QmYKiwRp1aVkjvZpFGR+Gg+Jfcz3RrlL
	hBMPZfbe+va2hUkfrym0K8Juh7w/ARRW8JqTM
X-Gm-Gg: AR+sD10ttSkvK9Xo1Cj4wYhE1tUKMWEs2oLp/rfNs+GNOoEPJJNyADKrWYSbRwTEF1U
	+bffcScFkrvyEiPQWg9whzbleiQi8FHxV/6CcFcyzQDowY2t35UHK5dz873Gbtnjioe2CX099gN
	yNOt75WwCQ75Zbh3QojWICdhiOaSNSHjP2jIpC13mV6/BS7mqHYDulSKx1aLxXcwYb7ibc8ov+L
	VIyON7yfBi25xnax7QHX3pvZDHFicsDFr2Ai0nU+0XB6tM0+6MkFrzFFNLQDrZe/XlDZ1loESMy
	Kd/BK0MfQteRh08BoApHcRnc7F2O3MtmX+v45K5+Gq11sqNkOG2TBL+yiw==
X-Received: by 2002:a17:907:3f86:b0:c17:40e5:3d75 with SMTP id
 a640c23a62f3a-c1fe81b07a4mr211595266b.16.1785590329982; Sat, 01 Aug 2026
 06:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730150407.328731-1-yjkwon0026@snu.ac.kr> <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 15:18:38 +0200
X-Gm-Features: AUfX_myFcd7kIGfVu3WLvnW9nBz37p2pVP5x2QYjnErGq5HPIwzoE0nOAMbfnV4
Message-ID: <CAOQ4uxh3Z-F6VKAZoF2cRnVL1r_XqxJxTFyW-P3q_yet98o+Ww@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: Fix stale object mask after concurrent mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 8:00=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
 wrote:
>
> When a mark gets a new event bit, fanotify and inotify avoid recalculatin=
g
> the object mask if the cached aggregate already contains that bit. This i=
s
> racy with a recalculation triggered by a concurrent update to another mar=
k
> on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while
> the updater reads the old aggregate before that scan publishes its result=
.
> The updater then skips recalculation and the scan publishes a mask withou=
t
> the bit, leaving the object mask stale after both updates complete.
>
> This can be reproduced with two fanotify groups watching the same inode:
> one thread removes FAN_MODIFY from one existing mark while another thread
> adds FAN_MODIFY to the other mark. After both fanotify_mark() calls retur=
n,
> writes can fail to produce FAN_MODIFY for the group whose mark now contai=
ns
> the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> equivalent inotify interleaving loses IN_MODIFY events.
>
> Always recalculate the connector mask after successfully updating an
> existing fanotify mark

Please don't use this big hammer.
See comments on v1.

Thanks,
Amir.

> or inotify watch. In fanotify, FS_MODIFY handling
> may clear ignore_mask concurrently without taking mark->lock, so
> calculated mask snapshots are not reliable. In inotify, replacing a watch
> temporarily sets mark->mask to zero, so a concurrent scan can observe zer=
o
> even when the old and final masks are equal. Mark updates are expected to
> be infrequent, so avoid these racy optimizations.
>
> Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNKH=3D=
X3LmoXMqakYqJaNw@mail.gmail.com/
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask i=
n fanotify_add_mark")
> Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> ---
> Changes in v2:
> - Always recalculate after a successful fanotify mark add/update or updat=
e of
>   an existing inotify watch.
> - Drop the fanotify calculated-mask and cached-aggregate checks; neither =
can
>   close the race with concurrent ignore-mask clearing.
> - Make fanotify_mark_update_flags() return void; its recalculation
>   bookkeeping and the now-redundant first-time guard are no longer needed=
.
> - Drop the inotify old/new mask check because the replace path can expose=
 a
>   temporary zero mask even when the old and final masks are equal.
>
> I will send backports for stable kernels through 7.0.y after this lands.
>
>  fs/notify/fanotify/fanotify_user.c | 35 ++++++++----------------------
>  fs/notify/inotify/inotify_user.c   | 15 +------------
>  2 files changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9ee373ff5..a3648cec5 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1276,12 +1276,11 @@ static int fanotify_remove_mark(struct fsnotify_g=
roup *group,
>         return 0;
>  }
>
> -static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
> +static void fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
>                                        unsigned int fan_flags)
>  {
>         bool want_iref =3D !(fan_flags & FAN_MARK_EVICTABLE);
>         unsigned int ignore =3D fan_flags & FANOTIFY_MARK_IGNORE_BITS;
> -       bool recalc =3D false;
>
>         /*
>          * When using FAN_MARK_IGNORE for the first time, mark starts usi=
ng
> @@ -1293,20 +1292,15 @@ static bool fanotify_mark_update_flags(struct fsn=
otify_mark *fsn_mark,
>                 fsn_mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS;
>
>         /*
> -        * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may le=
ad to
> -        * the removal of the FS_MODIFY bit in calculated mask if it was =
set
> -        * because of an ignore mask that is now going to survive FS_MODI=
FY.
> +        * Setting FAN_MARK_IGNORED_SURV_MODIFY may remove FS_MODIFY from=
 the
> +        * calculated mask if it was included only to clear the ignore ma=
sk.
>          */
> -       if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
> -           !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) =
{
> +       if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY))
>                 fsn_mark->flags |=3D FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODI=
FY;
> -               if (!(fsn_mark->mask & FS_MODIFY))
> -                       recalc =3D true;
> -       }
>
>         if (fsn_mark->connector->type !=3D FSNOTIFY_OBJ_TYPE_INODE ||
>             want_iref =3D=3D !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IR=
EF))
> -               return recalc;
> +               return;
>
>         /*
>          * NO_IREF may be removed from a mark, but not added.
> @@ -1314,28 +1308,19 @@ static bool fanotify_mark_update_flags(struct fsn=
otify_mark *fsn_mark,
>          */
>         WARN_ON_ONCE(!want_iref);
>         fsn_mark->flags &=3D ~FSNOTIFY_MARK_FLAG_NO_IREF;
> -
> -       return true;
>  }
>
> -static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> +static void fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>                                       __u32 mask, unsigned int fan_flags)
>  {
> -       bool recalc;
> -
>         spin_lock(&fsn_mark->lock);
>         if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
>                 fsn_mark->mask |=3D mask;
>         else
>                 fsn_mark->ignore_mask |=3D mask;
>
> -       recalc =3D fsnotify_calc_mask(fsn_mark) &
> -               ~fsnotify_conn_mask(fsn_mark->connector);
> -
> -       recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> +       fanotify_mark_update_flags(fsn_mark, fan_flags);
>         spin_unlock(&fsn_mark->lock);
> -
> -       return recalc;
>  }
>
>  struct fan_fsid {
> @@ -1502,7 +1487,6 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>                              struct fan_fsid *fsid)
>  {
>         struct fsnotify_mark *fsn_mark;
> -       bool recalc;
>         int ret =3D 0;
>
>         fsnotify_group_lock(group);
> @@ -1534,9 +1518,8 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>                         goto out;
>         }
>
> -       recalc =3D fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
> -       if (recalc)
> -               fsnotify_recalc_mask(fsn_mark->connector);
> +       fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
> +       fsnotify_recalc_mask(fsn_mark->connector);
>
>  out:
>         fsnotify_group_unlock(group);
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify=
_user.c
> index ed37491c1..5f19c24ec 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         struct inotify_inode_mark *i_mark;
> -       __u32 old_mask, new_mask;
>         int replace =3D !(arg & IN_MASK_ADD);
>         int create =3D (arg & IN_MASK_CREATE);
>         int ret;
> @@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct fsn=
otify_group *group,
>         i_mark =3D container_of(fsn_mark, struct inotify_inode_mark, fsn_=
mark);
>
>         spin_lock(&fsn_mark->lock);
> -       old_mask =3D fsn_mark->mask;
>         if (replace) {
>                 fsn_mark->mask =3D 0;
>                 fsn_mark->flags &=3D ~INOTIFY_MARK_FLAGS;
>         }
>         fsn_mark->mask |=3D inotify_arg_to_mask(inode, arg);
>         fsn_mark->flags |=3D inotify_arg_to_flags(arg);
> -       new_mask =3D fsn_mark->mask;
>         spin_unlock(&fsn_mark->lock);
>
> -       if (old_mask !=3D new_mask) {
> -               /* more bits in old than in new? */
> -               int dropped =3D (old_mask & ~new_mask);
> -               /* more bits in this fsn_mark than the inode's mask? */
> -               int do_inode =3D (new_mask & ~READ_ONCE(inode->i_fsnotify=
_mask));
> -
> -               /* update the inode with this new fsn_mark */
> -               if (dropped || do_inode)
> -                       fsnotify_recalc_mask(fsn_mark->connector);
> -
> -       }
> +       fsnotify_recalc_mask(fsn_mark->connector);
>
>         /* return the wd */
>         ret =3D i_mark->wd;
> --
> 2.50.1
