Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795161584;
	b=a/FdIRR4qse1z7HiC4eBlK4YPhJRAn/3wzK1EKk9PuwaT2gyGAcMpRSi5+TTz+2cVyV1
	 3WgkX83LX1jSJe7mKs/AIi2wq2rwIOABiM8LhPWGRNwxAuzOg6zMaAhmBJq7mXZX49oPO
	 eb4J+PBRpPf6H7FHco2TT7FWlmoc6f6TZyGQ33u+N9LesrznWxaLBExa9+n7DlH3yBOav
	 a0N27BNoJi3zTCEJpdsKeiWT3bJWR2Uyq8verfo3Gi2LB8kZkcHzL6xkrUNh67xHIN5wQ
	 L38UNBZ9JitIUrB2lj906616G+hSpSUqpoET78KLAJZet6Avq7JK1MlEZOGPcmE4hAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aA5k+rmEhdyHwcnWrQk+xAlhNO+jF98wTQXFKpkmDY4=;
	b=GjGJOdp8nWO6qTDKkBLxmYSqJg/EGESlR2SWq6DCEwiCSjvAI/CkKnQC2lTZPQC9Biy5
	 g85fdQs3yU8VXzlrHSh4nT1Yk4oNY/jJYabW1R1ryolbZbZCchyaL9e4kySmOtaOQttbP
	 T64jFn5wq2yOndA2uG20nBCxGQ/JtGEPT22/pjmLFvcOq/oN4bdae14xK0eE049rb8H8j
	 BPU0al+NvmEwq4F6CNyoTWzISPGqnSrsm3XgNhhuW5QvMsc8nEMCk6LIbfkHiMQroJW8Q
	 a4pl7XRnlZCSz/iVlrK2YCN8qf+ukTCdo98ODTj8Ue/Qw3BkxTQxBXtBfm94FK67ISg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e94eVXt0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D2606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 07:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e94eVXt0
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so874587a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795161583; cv=none;
        d=google.com; s=arc-20260327;
        b=OpKTFRx1bbSBiNt/uqG/IxQYS9LgXob8sonb1gijx4jGqKL7vy3L+t5MNIZALT9rso
         J9oHRspl7u0GmwpMcPjOvHMi+7hXRewubqYSPn8cx8gs4oxpj+ZtcxN40bi6KXYzGX9m
         uX1pjTaY9Yjx8L2gEC8fgaBvdr/zyMvNpUp5pR5aamRRx/sQ+BmHeZ+xpniD1FxbYwDC
         JrLRLWbaOZzcAiVHX93njDUPr4b4Hu9chppERlMokWBkOtgOGp5RMfl670bZxCf6u/SJ
         8ek03F5RiJsIlNxHdR3xB9us1Ns+lQeUaulgJapdkSbaCpi4G+jwGqHJbekNx78pVPhr
         ybcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aA5k+rmEhdyHwcnWrQk+xAlhNO+jF98wTQXFKpkmDY4=;
        fh=PC4BMMXmELzvrXbn58s2JPEggJjFo4sGiNivkn1HZz4=;
        b=MiV2pm1E2JC4/HTxRS1q39a8EK5x2R894iNRdGxJwWkX39pmS91CdvdoFM+dH8XkTr
         sfVbPRrU/WBin2GNXVLVz0zuDqRFGBPvnWKNXJfjYMmzgJCHNRps9Zz4fJLE/q22qJgF
         iXkrQnItCRD/qQeSPVeIwRGPy7gFFH67GyujyiE+DtTFSfz7sK3se7M9fZP5J7ktmD00
         byHkPFJCP2YC1WQtZfOETJsJW//UDAS8WU1obtf8vLGYXGfP+ch9AvPFRuMLQN59sDFJ
         ztSJy9HlQcTXPiWmetn8M0VJFjH751Idsw0nCLffEZ+k/qbdMBw8Dez3tHkKqvMC7dXV
         5u5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795161583; x=1795766383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aA5k+rmEhdyHwcnWrQk+xAlhNO+jF98wTQXFKpkmDY4=;
        b=e94eVXt0AbzL5sLKMSsPql7RGfCEigY0b63RU9ZpRLW8/G1/JhhN2c9Ag8L7M3LV9+
         xypY2KFpegk8RFUAV5khGlz6GdAN1hDTq7tdHUjk3qtUBW0nKJcLVw6keFB98c1n5UO/
         Oo7XoKUMlOOXJNyZCBJ9NES1NAnkYuNgPbVIjwy5WpNLgiwMjjIJ9xmnL1FRHyNCQk2C
         kAu6cL86j5Z2/toO5/ilgFbLwrfonjrR65SsVKK9UIsMJK9ePPCphYWJbQsdhjeWgHiW
         UW+kACVgdvhFYnSwFnnwMKZ4w/y4nHTKHPEFIqKyab/qmf5j83J6iYX2MWdJGXIPpOoC
         dxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161583; x=1795766383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aA5k+rmEhdyHwcnWrQk+xAlhNO+jF98wTQXFKpkmDY4=;
        b=MhS8cv4LV/M7qg7QcUByyyU8khora0aKClYnT6lIS3SAdXz/++LP/YBbf52pc4Gp0M
         nYX7Q9UmHml+d+vMrr7RADpc5+iC5dzIFXkRP6hgLHWvdSFzCfN2gGbVYfY4D0nbwCh3
         6uTugbwN/u63kMTBwPfAhbhd8peaSibgkKJVzWVbhb7tYu+iDEReSRnEQaWKZ3pk1fYL
         YrGSPyImE7p5XxXHi79AKgT/qpbu2GIwcsQ4kAByw6xILFphtlJNl/DHYUgmxu/LzX+3
         fl/F2biwxYgEQVb1xd9XAUU+aXdLhIFUIqg+lk9lgbDk6QCl19YdbeZakrmS1zi5f9Ce
         7cOg==
X-Forwarded-Encrypted: i=1; AL+hErGKjmb3hXZumApZER4RP3ZgYln10caps18ObgxkPUmyaaU8rMc32+11L9A2a+8kavXye4kfRiEnC18ZHijz@vger.kernel.org
X-Gm-Message-State: APuU4Z99UNk2oGL5+UkLpAdPVZT1iVuIOik9L3d/rO4tcMttB0iuZy9R
	Y/hKgI8/2YAUabBXABXyoV0ENBLKd4/+gSqJdonqghkRDfE0LLjjBqYi//58tMJ743r19+uGGyy
	Pzd9CdOYuHpxEjx6L4ryUbTNV+9SKgLM=
X-Gm-Gg: AZFdTZcIbKDMeZCeW/Kv6XTMdDRQZWu34s0/o2LB+8UKZu9x1QyXqokIiQTWZWH/lSJ
	crrqEzjNt4Aj0121dHRVnUO8XAbljPnZ9xMqKnpS78U/r9gsbJd5jzatcqzzeg9vHPHDWiM5Mlv
	do9VQ9m+97qOp/g1X6QU3C0Y+h+m8orVI5e7pRwGhIrrUKexmL0z5mvWH2ncG3OienSvDjfOcpj
	l9vVsie8sHmmcazds1yzFlU8bsvmsR+z8m1ZWSa+6Hy+Imvw7MkQAQptBHXAmZoYJCAt1HS3OsH
	WfUurgYoswq2DXUdcEPeq3iAMss7buCfCUAhHTPV5cA7EJUwvQDUdAUHiFj/yC/jazvskj4uwPS
	HCromY1lfVQuzte6qxZxkLzOs5X8v9cLWnqnmFMJ5qLSmlSziRh1YTNOCi33HPzy8Rlbg4g==
X-Received: by 2002:a05:6402:2745:b0:6ba:1347:5cf with SMTP id
 4fb4d7f45d1cf-6ba37cc07e6mr1431968a12.2.1795161582368; Thu, 19 Nov 2026
 23:59:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119025942.2848130-1-neilb@ownmail.net> <20261119025942.2848130-2-neilb@ownmail.net>
In-Reply-To: <20261119025942.2848130-2-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 08:59:30 +0100
X-Gm-Features: AclHuK8z9GrtZEu_wntP7i6NsuYSR0h-8HuMM7V7cKM0I-uLZ7WO8s4PozWdTVI
Message-ID: <CAOQ4uxgK7FL9WSEF4U3Ba=-tVyEBfe+2EFprSywS6W=guBSqsg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] VFS: don't count references through ->d_parent
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 4:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> The number of negative child dentries that a given dentry can have is
> effectively unbounded, so counting the references through ->d_parent can
> overflow ->d_lockref.count.
>
> We only use this count so that we can know when there are no remaining
> references including from children.  However most children appear on the
> ->d_children list and the few remaining children (inactive
> DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> is held on the parent.
>
> So if we count whether d_children is nonempty (i.e.  dget() when it
> becomes non-empty, dput() when it comes empty) and require children not
> on ->d_children to have a reference on the parent some other way (which
> they already do), then ->d_lockref.count will not overflow and we can
> still know exactly when all references, including through ->d_parent,
> are gone.
>
> __d_move() allows that dentries might not be on any d_children list as
> is the case for IS_ROOT() dentries.  Rather than track when this is the
> case we dget() either parent if they have an empty d_children before
> children are moved around, then dput() if they turn out to be empty
> afterwards.  This will increment dentry if it IS_ROOT(), and then
> decrement it afterwards, and will decrement the refcount on old_parent
> if its ->d_children becomes empty.
>
> To help with this, dput_dlock() is added which warns rather than
> decrementing to zero (which should never happen).
>
> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first child added, and so never needs to adjust the refcount on the
> parent.  If it remains on the list until dput() it could be the last
> child to be removed, in which case normal handling applies in
> dentry_unlist() (where it has been moved from dentry_kill().  When a
> cursor is deliberately removed from the d_children list the refcount
> must be decremented if that leaves the list empty.
>
> hlist_move_behind() and hlist_move_before() are added to simplify moving
> a cursor within the d_children list.  This results in some duplicate code
> as they share a common prefix with d_detach_cursor() (hlist_del)
> which is currently factored out.  We can expect the compiler to optimise
> this away and don't need to clutter the C code with it.
>
> autofs compares d_count() with the number of known children of a dentry
> to detect if there are any concurrent references to a dentry.  These
> comparisons must be changed to reflect that we now only count "one" for
> any children rather than "one" for each child.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/autofs/expire.c     | 25 ++++++++++++++++---------
>  fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
>  fs/internal.h          | 10 ++++++++++
>  fs/libfs.c             | 14 +++++++-------
>  include/linux/dcache.h | 17 ++++++++++++++++-
>  include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
>  6 files changed, 112 insertions(+), 24 deletions(-)
>
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..cd276bce28c9 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -208,15 +208,18 @@ static int autofs_tree_busy(struct vfsmount *mnt,
>                         }
>                 } else {
>                         struct autofs_info *ino =3D autofs_dentry_ino(p);
> -                       unsigned int ino_count =3D READ_ONCE(ino->count);
> +                       unsigned int use_count;
> +
> +                       /* allow for 1 if there are any children */
> +                       use_count =3D READ_ONCE(ino->count) > 0;
>
>                         /* allow for dget above and top is already dgot *=
/
>                         if (p =3D=3D top)
> -                               ino_count +=3D 2;
> +                               use_count +=3D 2;
>                         else
> -                               ino_count++;
> +                               use_count++;
>
> -                       if (d_count(p) > ino_count) {
> +                       if (d_count(p) > use_count) {
>                                 top_ino->last_used =3D jiffies;
>                                 dput(p);
>                                 return 1;
> @@ -321,7 +324,7 @@ static struct dentry *should_expire(struct dentry *de=
ntry,
>                                     unsigned int how)
>  {
>         struct autofs_info *ino =3D autofs_dentry_ino(dentry);
> -       unsigned int ino_count;
> +       unsigned int use_count;
>
>         /* No point expiring a pending mount */
>         if (ino->flags & AUTOFS_INF_PENDING)
> @@ -375,9 +378,11 @@ static struct dentry *should_expire(struct dentry *d=
entry,
>         if (!(how & AUTOFS_EXP_LEAVES)) {
>                 /* Not a forced expire? */
>                 if (!(how & AUTOFS_EXP_FORCED)) {
> +                       /* dentry has any children? */
> +                       use_count =3D READ_ONCE(ino->count) > 0;
>                         /* ref-walk currently on this dentry? */
> -                       ino_count =3D READ_ONCE(ino->count) + 1;
> -                       if (d_count(dentry) > ino_count)
> +                       use_count +=3D 1;
> +                       if (d_count(dentry) > use_count)
>                                 return NULL;
>                 }
>
> @@ -392,9 +397,11 @@ static struct dentry *should_expire(struct dentry *d=
entry,
>
>                 /* Not a forced expire? */
>                 if (!(how & AUTOFS_EXP_FORCED)) {
> +                       /* dentry has any children? */
> +                       use_count =3D READ_ONCE(ino->count) > 0;
>                         /* ref-walk currently on this dentry? */
> -                       ino_count =3D READ_ONCE(ino->count) + 1;
> -                       if (d_count(dentry) > ino_count)
> +                       use_count +=3D 1;
> +                       if (d_count(dentry) > use_count)
>                                 return NULL;
>                 }
>

AI review claims that ino->count starts at 1 and (ino->count > 0) is
always true,
so use_count should be:

                       use_count =3D READ_ONCE(ino->count) > 1;

It sounds right, but I did not look closely.

Thanks,
Amir.
