Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160986;
	b=VHVaNqM8X3owncV5slCZm/0h0mye83NM4Ax8xHnVpvtCluoJ7WL6d43A3CBgKkC5om5u
	 jaE/1b5a/v3wHcFsVAA7ks4R9cgTduS82NrBLXlKFKoOm2+Ux7KQBsEFrbc+vlPbjvBCO
	 yzX+VHjDS5QdDSyzHUbkMD/y/iQvSrPEsUjIblYRL/NknxNo/IxeabEcGCk4KWCkCfWwc
	 0Y4ngJ4qEaYakv7wog0NOWeqV2tCR1bOCWyGApPAC9EKGFHvzIKpUwQpMXIjYfklZIqhE
	 GKH3ek8rZKqU4ej/QcH+XTMeDKiuqpYW3lMPDE/E1/fsQ+qkulcuy0RU1tuvtD7Xw3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PKfh3kaU0G0rUT/geWuCPv0s5ju8c8DPCj+FrnIkKs4=;
	b=Z473jNHKHZsMYTh+sYaQMyH2kWSXuYaHv6rwduv9FbJxiJuTfuacrXRVKfQotTpCJ4El
	 +5zkJzO9srJYshKx1oFLOywM34J4YTaamUS36Y1n74Tv/lzoodelNkxnzafvN7rlimLyB
	 jCd3EaGWs4/2JvHuP5BgepxG7A8nQUvh9GQrojvhuBI+MZW5WAKsxmIPDFpik4mMX5XOE
	 XAE60enWNe23G/IGFEzgEYXhBjRENWVpw8R/Cn9vxHKErBKsiBowdS5lgMXzdV2YTUsSm
	 phGCxp80f09toJBjpEgbirxsSJCKTa8sIpquF4OCwm+HBU4HQc6o/wRCZRBXtppYHvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mW3WMEgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356E606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 07:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1356E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mW3WMEgU
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b7ddb99db4so757007a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795160984; cv=none;
        d=google.com; s=arc-20260327;
        b=MKxfm0YVgas9+lkuHR0MJaSFdj8cQ+j2fkZr8AZMCUb6q4ME2hMcKCsFdwJoOaxujh
         cD+bzUwkW2hmGUWcTiuaKXIjJyEpCNEWlUlXPOQP1YkATCZF2UTMwWS+Wo3TySUSj2Cl
         saRwhjU+htzRFqStonjzTDGRWTI7/XrTlotm86HL3WlmGm3y8boVeOysnb236cuuX9XG
         Dw42zDil2qoIyZvDJRU/yiz04WPAn0EIj00da6QbpHTSdIecwggSkuQe/BFNhkOVeqH+
         spJCP9aJBiddXVLmGnZefqAHecPeTV+GMXhwUJ6uZGWSjmm8cuDaSztxuv4dOts4vxjm
         qI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PKfh3kaU0G0rUT/geWuCPv0s5ju8c8DPCj+FrnIkKs4=;
        fh=b+tCNT4Ww3UC8qDLrkQL46EygzsYwXzJ6l+jNVeZV/Y=;
        b=o1dmMvd9InYUk1Z1iG1NE7pJdHFaPmd4c4sDJOzyi0cXTksh4o16akeI36GUa2tUHa
         4gK2F5qPTI18xYeNk20Eg5FHawk2BXTmD/xfQti12SjGd5B3K0gGT6ueYFltBJzdw1RO
         Vw1rCwlkSge+HIqNfY7nvq4wy5k/VMaSasCO7owXfoDFxrFXZ5ZJNlw9i6BNzd6rE9yd
         YJWtvA1eX36R5eHyOw9z1cHEsQ3WIfPKjbqKkYG6/aTs4dwjVWOGEccRV3raxGLai9LV
         vqLsqZ29aOZNU+qjyzqxGmOY5aAFZdfA9WKtxHv2x6R3LQ26iViylfZmvLOIt0QLsLUL
         D/+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160984; x=1795765784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PKfh3kaU0G0rUT/geWuCPv0s5ju8c8DPCj+FrnIkKs4=;
        b=mW3WMEgUD7JxWrK0tDYJP86u4bhgYy7GpbQgMpG2Wci9ADVKI/VSjhSR9kqUPb0x9W
         53uhMZ32TdRHcMos72JJdUvFUO21lPqaZyELkv2MUA7IxDz19Qc2C+m2XAEBU/dc4bQm
         2CDrdlxYF8IglAThc2xqmrXUsHCXiYicI6+Hwy1l5pRkHAOYGW2eLn9tUu0kK2oVJMvx
         7rKO0mXhF9T2TQv5dlep+6ADg4BWUVJSnBkp+jaxXiB8kArorfh1EZeqD+Qlw3jTrlFX
         1mW8fCeiZhQSD2v2JBC0YnpanTKel9Jf5FBFxb7pqUSyrwXVzBbRaV8SymAOpuMVRyo+
         UmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160984; x=1795765784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PKfh3kaU0G0rUT/geWuCPv0s5ju8c8DPCj+FrnIkKs4=;
        b=sAC3GpQDWl/r6MTFhYaLdDdDqbyePgFdVcsiVJyjtHQz22X11BfoaHJyJiOEL6GAV/
         qRWArSMLW9QYgKHn+R45ofQizn3O5IuRmqQAkL56JS8XGNvAn3zDepIzf1xliHnvcM5F
         B2XGJFokME+bjIymrPMpBBrrg9aAj83Ms5UglszppfWQuv1QyIC9YRgGV/DUCYjCcA/9
         482j+yTKzmflxT2salz9aiZmEkRnGDrhzXEq6AYKM0mGaBHEHIZ7U2omKKvWvW0RTigT
         T55X+NbYVqnQR6vLor4xxl3xga2AR4FmFzrEEaearubCGuC1koYl8Y2CSb5uJAItquvt
         hwjQ==
X-Forwarded-Encrypted: i=1; AL+hErG+B7LMZmVMZCcWBTBE0qVHqIcGL2sofmx+OvxOQefHjM9x95uIrDTaJ0dV1rRLGKad++qsquyBOWy6+ZQO@vger.kernel.org
X-Gm-Message-State: APuU4Z/VK/ILhjBlT/UAAoPo5RM+dZ484NfZTTo6gVwTR6jVLVbdwu5f
	f9j7/YbcoIDKVDM6ENTtq/4Z6spjjvW8cZMzoTSk+6MH+/IyqyRLm6TYVp3tw/P21IuvPU2dYiD
	IHCssjz/gf845ZWhJaWf/1TqoaXaNFWc=
X-Gm-Gg: AZFdTZd92ugzsq9IiKVZxubvebbuIy5DMugkA5n14D53s+olw0YnK5U+x+9HIVfPKl2
	XystVOZl8OQhzOWqeVybNLuv4zvIy6l7supWiJLtsLmOpYxYcmyAvodRdMMuB8ef60L9fzJKOZX
	DbY6YQg2DGa80zWSgrytQCMYOatCb40Jzw1DP+ZEAidLiS7IFttHNrJ9sJbdSesp8ddler/bw5y
	u4sr4rZ1UTcddb13yCymOo91OWvJCbbF7K1mZF2PlnlK4CWGDowTbwUhRBP/Va+hElOTrR48nEz
	29Hk6OyI80v28EpICPviJuRnTKhGZwJdkAwe2xUc98HUX2SkTBGiON/X9L0LG3lOhdJAz7L1gwi
	HfdAtEIfl6nAp3frcqExoxHV1woF+Jmstu4JrtQgiZdShq13jc3hFOugW2Thtc5jiL9mBBg==
X-Received: by 2002:a05:6402:51d4:b0:6b5:8cb3:5e19 with SMTP id
 4fb4d7f45d1cf-6ba37e8826emr1567455a12.38.1795160983956; Thu, 19 Nov 2026
 23:49:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119025942.2848130-1-neilb@ownmail.net> <20261119025942.2848130-5-neilb@ownmail.net>
 <CAOQ4uxgan=mpQ9yHOyZwZZp8E69+oH3uaPJ5CBkP7Z5BCO-5jA@mail.gmail.com> <179513093550.1728055.17648674323193416652@noble.neil.brown.name>
In-Reply-To: <179513093550.1728055.17648674323193416652@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 08:49:32 +0100
X-Gm-Features: AclHuK92Odp_LX6Yi_Upic4sX2AvoYnwQkl4O4i6nLgkGpqLV9L63P1FdN9RHzY
Message-ID: <CAOQ4uxjECTaXaeH_cfgikrWF3jrg-knhSJuC0voVxdajAzH5-Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:29=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Fri, 20 Nov 2026, Amir Goldstein wrote:
> > On Thu, Nov 19, 2026 at 4:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
>
> > > +
> > > +/**
> > > + * d_next_sibling_sched - return next sibling, but schedule() first
> > > + * @child:  current child
> > > + *
> > > + * This behaves like d_next_sibling(), but drops the parent d_lock
> > > + * and calls cond_resched() to avoid any soft-lockup.  A cursor
> > > + * is inserted as place holder.
> > > + *
> > > + * Caller must hold the parents d_lock, and must hold a counted
> > > + * reference on the parent.
> > > + *
> > > + * Returns: the next sibling, or %NULL if there is none.
> > > + */
> > > +struct dentry *d_next_sibling_sched(struct dentry *child)
> > > +__must_hold(&child->d_parent->d_lock)
> > > +{
> > > +       struct dentry cursor;
> > > +
> > > +       /* always skip cursors to ensure we make some real progress *=
/
> > > +       while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> > > +               child =3D d_next_sibling(child);
> > > +       if (!child)
> > > +               return child;
> >
> > Why is this skip loop here and not after the resched?
> >
> > As this is written, if the caller passed @child which is another cursor=
,
> > now child the next real dentry after another cursor and hlist_add_behin=
d()
> > below will insert our cursor after the real dentry.
>
> You are right of course - that is the wrong way to address the problem.
>
> I think moving the test into d_next_positive(), like with this
> incremental patch, will work better.
>

Oh yeh, that's much better.

> Thanks!
> NeilBrown
>
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index bacb218400a8..46aca619a9a3 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2095,6 +2095,9 @@ static void d_init_cursor(struct dentry *dentry, st=
ruct dentry *parent)
>   * Caller must hold the parents d_lock, and must hold a counted
>   * reference on the parent.
>   *
> + * @child should not be a cursor, else two threads could potentially
> + * live-lock, each only stepping over each others cursors.
> + *
>   * Returns: the next sibling, or %NULL if there is none.
>   */
>  struct dentry *d_next_sibling_sched(struct dentry *child)
> @@ -2102,12 +2105,6 @@ __must_hold(&child->d_parent->d_lock)
>  {
>         struct dentry cursor;
>
> -       /* always skip cursors to ensure we make some real progress */
> -       while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> -               child =3D d_next_sibling(child);
> -       if (!child)
> -               return child;
> -
>         d_init_cursor(&cursor, child->d_parent);
>         hlist_add_behind(&cursor.d_sib, &child->d_sib);
>         spin_unlock(&cursor.d_parent->d_lock);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 7150ecd81d72..c384b0f8743e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -697,7 +697,10 @@ struct dentry *d_next_sibling_sched(struct dentry *c=
hild);
>  static inline struct dentry *d_next_positive(struct dentry *child)
>  {
>         do {
> -               if (need_resched())
> +               /* Don't schedule on cursors to ensure we make some real

Hurts my eyes. Please add a newline. or shorten to ...ensure we make progre=
ss */

> +                * progress between scheduling

the between scheduling part is kind of obvious

> +                */
> +               if (need_resched() && !(child->d_flags & DCACHE_DENTRY_CU=
RSOR))
>                         child =3D d_next_sibling_sched(child);
>                 else
>                         child =3D d_next_sibling(child);
>

Thanks,
Amir.
