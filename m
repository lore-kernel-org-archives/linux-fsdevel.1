Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795703548;
	b=snDQD+qy+wEKwUmINCC+CAlgHZq6r13ssT0SKksjG3KSObZ7csKK1KmXp4j7ZsiFXGpa
	 vi1VxuKIF7ym0S9zNb+5WDxaTXfAtqJsZtW0fxTPBmL6wgLoHgrOo527h0+KJ3wQgnna/
	 0SegrOqFLbBBgiTjmWkm0I7sE1fptXoIrkb0zkHupc4sPV43Hrbs2M0nLrFQwbwV8tfTk
	 hBr0kdQi7Wgssr6VXjUUnunUYPwudFGDJoL74CeKykVRSPX/CpQGwxsc1v941VXO4Weoz
	 cWjB6kA9RvUbiXCIugjEdr5HhW9tTBFQm6Oc2IYi68mFLXHZqs+bFZ/nr8WArO/x09A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703548;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=j4SW/ATGdEUb2uj6+KeCkCeJq4YU3jDFIbV62pOLzOIdLFSwIwwk1D+JJWy7N1i2+RJo
	 SLiYCDi74T+etFgEJl7rtr7sC+ZvZpfbsVd23JGPEqg/RGomPj5SMKlHRJMuK1pBzX1w6
	 jYsMxX/9/vedNBqyImpfFY9d8eInNDgWOhGpOUld0sp+5CxwLVNC7A4F91YhBVxtgf9gp
	 oELFDkxQfGyY3QfOfHmjx1Z5jE3fHaJSWjkMNU22B2dI881QjinI8E5ecRxrJJBfQnl5p
	 hAh5Y6v+bQmGmLjxZr6lWRB6TtC+wb8roKDrfq5KPnUXOQQADdsJd0wjny+6vTtRzmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dWhkAlm/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kAQxEPx5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D70606A338
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 14:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D70606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWhkAlm/;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kAQxEPx5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795703544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=dWhkAlm/rgUPJl3OyPpQzb7XCB7dWuPSJ07TXheuGSFN2uVe3I9XU/TzKF4kp+gW8Wzogo
	PTZD2ssp9kGpNZENFnJXmKpiZF6/3WyyuvtQBWSB2Zs1Z9N8pKOsk/IyZEj3XZVQYyZzia
	SFa3Kx2DJbJT7Un3EZazyg7sPxAXlLk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-i7ZJ2GzrNJGslLqCUeOZbw-1; Thu, 26 Nov 2026 14:32:22 +0000
X-MC-Unique: i7ZJ2GzrNJGslLqCUeOZbw-1
X-Mimecast-MFC-AGG-ID: i7ZJ2GzrNJGslLqCUeOZbw_1795703541
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b155f4eb8eso90486557b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 06:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795703541; cv=none;
        d=google.com; s=arc-20260327;
        b=P7vXbXgn/JwP7bmdGY2x3e2UvfHXs+H49WV3vK8alAgk9dGOTsl/7R96tdNgh5DjX/
         W74Of4YEWfgBqR09CT+Kplyxm+GH9KZDYUss9vjLDuHeo19jBOw/4JBlNjnp51S5xwDw
         nnNVpkF8fJk2Xe9ENzbZu5YB5kANIREVhtIuOZ5V5SrmwMQrncMIAsA0WR8QOOZ2EU+n
         23HwehkSO76TkHxHi051NCrDUm3MqCEMIDGBZVouQVSB3ymXEVR0Gu0MrHJd1AMOsUsn
         l89isDukg0mAQQ7k6VOO+or1tK+IOf7syqi6hDkUXD+6nAxJg7C0hHvF03sErARghQyW
         dnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        fh=wZrS98fhKs2SCKqx2LI1LF2nCyMlB7up4fXLYNqEA+Q=;
        b=L7q4hb2GT6EQzv9tqUB5OTQST8IAM3aCAvgLprlKykFpd8jCIUh3pyO3pUCywsWWL3
         86x1AlrziBXyJgbowx+g5F0ldbSf5Q1CqDGA5ObEpYmI+raRwDZx/kX1RnQKFpYHXxU1
         JFUu3yaG+JuNsJrrUzC3+DaUmVE5A9KeZndwR6j81QY2y58q+GcRaN3KqfngcMojYT3B
         Mc307V8EqGCuZfeoYTOUKUYiIv+PSwlNXmIBvDdJpKIUkO/8IMbd+HAKMP0efl12vXCR
         U74i4U+xH3I031dEXDOLDrUGztNZ89q3D9LIzq62CWFRLgtSqBIUSYiA+a13qLE8/bdX
         zQVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795703541; x=1796308341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        b=kAQxEPx5oasXLg4Pt+Xfz5hwvlrLHucbfaO/vKl0kanZWdof2TEW03W7Cm8+ifuGG1
         +mTWcWl0TLsimQFyQjuxmAs68b518GOVTaNyq6JkGgYJennJ5JwCRSLWVOEbVhcLd8mu
         PS0vK7WyEYOUS+8IB9DMZbz1kb2E1uvxBiBfXLbqJpz2O6Ua914XDl14FBTKKD4gjQw9
         6S0w3j1BBdWSZFqJfL+JjHQLJcdfwmhKmZNwNf+bAUj6GjY268imgron4i7nXJSKqIaC
         LEmiogljUYdXLD3VKDxp2zRY+/CXyVEpCoB/KGdCeP0z/wSfPeipbX61apofl98nNmsS
         Km6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703541; x=1796308341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        b=ZylRNr2PYlGtitt2aKvT9ZpvQtK/+rtrDHdR/fRoBcG+nS0wcBSiTMqE0LrCUZoNb8
         U47KvhmFCEcXAagwXWlkTgs3ny7bQQqY7QuEXXmf026TrPPuLtl4ZCrrW4FAHz3woCkR
         FGlLKDnVcWvxTux+iptj7d/tpAy1VqmyxwJsoBA9glSGa+hZmU5JFVNYPjB8Xf43Kqco
         FyOcsg1l5886/ZvvOAI02g1UEn9WnX/p/LnNodv3BBGpp1vuXmmkpGFhUbVikZ1KeDlL
         urOCDljsh/FocWEdNQ/1nTfqd9jrAnloom9LgxL7PgSv6ayKsAYyIpRZyAfZfJRhL7SE
         0yDw==
X-Forwarded-Encrypted: i=1; AL+hErHn3eOfJBXC2OfOacFKfiFxvol6QWs1hGQW4BBU4rYwO50VwlsdYxR4m5tDeMjSi40r9900hK0OEviz4CLz@vger.kernel.org
X-Gm-Message-State: APuU4Z8uQcGadC878Hez1sKAyroEViH7PAZgV6uK0Qh5Vh/cw7XjgPY3
	sIXtCyNPYGgixmHGbFUctExZmng3m5kRheCHW04bRfyncG4k1kPI/KtbFLoFBvCaJB/39IcP+1f
	bgyOzmDsZ5Tuvl+/RayijmmzJc0G04wrkpeYbhigcUzPModwESvoZRUHKXsSAyAazsA45TqCL6q
	V+m6Tlwri/OwyAQZXwdUvJk443Oc+izBdPbBGcbnBsFw==
X-Gm-Gg: AZFdTZfykBlwpy/lWyc9Eg3HU8FydleyPrPp8uureOEQMKdpFfZVIJCeHny3OpEkHJ8
	6Out60n8EIf9OqRHkC+sbagzxdqBv7maLul+JftpG6RE6ckyH2tng09eG2SqERop84N7QD17rnC
	QbTH5Z9jSopKsaBuAf8OIssWTDg9xCX7IhGUwq+4y0Abexo40DISAjw4L3xx2ZHbJmvgaHFBgTY
	duFWoscnO+tFsV78Uh55HtQVWbY/qaMZwUmVVbxzCPxxQ==
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id 00721157ae682-8b52042becemr71775667b3.22.1795703541307;
        Thu, 26 Nov 2026 06:32:21 -0800 (PST)
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id
 00721157ae682-8b52042becemr71775297b3.22.1795703540562; Thu, 26 Nov 2026
 06:32:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125091157.1822521-1-huangsj@hygon.cn> <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
 <awgi6a0Hayug7RJH@hsj-2U-Workstation>
In-Reply-To: <awgi6a0Hayug7RJH@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 15:32:08 +0100
X-Gm-Features: Aa3M54qEByO_EHNX8OHGBPouiZLwpLPKlFRFRV9aYOI6i2TAngEySFHZ6dr1dD8
Message-ID: <CAHc6FU4KLxzoQ6NJQUnFfcbKufqwqdhfcGhva9V44K=J7HCXRg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 13:20, Huang Shijie <huangsj@hygon.cn> wrote:
> =E5=9C=A8 Wed, Nov 25, 2026 at 11:25:12PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > Huang,
> >
> > I have some thoughts ...
> >
> > On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> > > This series adds a superblock inode iterator and converts the open-co=
ded
> > > sb->s_inodes walks in the VFS to it.  The design follows the cursor-b=
ased
> > > construct proposed by Christian Brauner:
> > >
> > >   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-ka=
ntholz-241300d20168@brauner/
> > >
> > > and is the same direction as Dave Chinner's patch set:
> > >
> > >   "vfs: improving inode cache iteration scalability"
> > >   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbi=
t.com/
> > >
> > > The caller owns the iterator state and drives the walk itself:
> > >
> > >   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
> > >   while ((inode =3D sb_inode_iter_next(&iter)))
> > >           /* do stuff */;
> >
> > The pattern should be:
> >
> >   for (CLASS(...); ...; ...) {
> >       /* ... */
> >       if (/* end iteration early */)
> >           break;
> >       /* ... */
> >   }
> >
> > so that the iterator goes out of scope immediately when the loop ends.
> > Hide the details of the loop header in a macro and that this becomes:
> >
> >   for_each_inode(inode, sb) {
>
> The fs/jffs2/build.c has used this for_each_inode.
> Maybe change to for_each_sb_inode?

That's the least of all problems; just rename the jfs macro.

> >       /* inode is referenced and unlocked here */
> >   }
> >
> > Use that to convert the simple cases.
> >
> > And then we've got preconditions that are checked while the inode is
> > locked. Those can probably go in an expression:
> >
> >   for_each_inode(inode, sb, expression) {
> We still need add flags here.
>
> In evict_inodes() and hook_sb_delete(), only the expression is not enough=
.

I know, these are the two cases that check i_count before the inode is
even locked. Leave them as they are for now; we can get back to that
later.

> How about add a raw code like this:
>
>     for_each_inode_raw(inode, sb, expression, flags) {
>     }
>
> And add a macro for_each_inode:
>   #define for_each_inode(inode, sb, expression)  for_each_inode_raw(inode=
, sb, expression, 0)
>
> Most of the cases, we can use the for_each_inode.
>
> But in the evict_inodes() and hook_sb_delete() we can use the for_each_in=
ode_raw.

No. Convert the simple cases first, with iterator constructs that are
as simple as possible. Later, worry about the more complicated cases.

> >       /* expression was true */
> >       /* inode is referenced and unlocked here */
> >   }
> >
> > This unfortunately cannot be implemented on top of the
> > sb_inode_iter_next() pattern, at least not in a reasonable way, so we
> > actually shouldn't use that pattern.
> >
> > The locked iterator would look like this:
> >
> >   for_each_inode_locked(inode, sb) {
>
> I tried this way today.
>
> The macro for_each_inode_locked is complicated.
> When I tried to add more hooks to super_operations to implement the
> procfs issue, the for_each_inode_locked becomes more complicated.
>
> BTW: the procfs issue see the link:
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Introducing reasonable inode iteration constructs is a completely
separate problem from introducing per-super block inode iterators.
Please keep those issues apart.

> >       /* inode is locked here */
> >   }
> >
> > This doesn't cover all existing cases, but that's okay. Don't force
> > things into this pattern that are not a match.
> >
> > We can always extend things further if it makes sense.
> >
> > > The lock does not span iterations.  sb_inode_iter_next() takes
> > > sb->s_inode_list_lock, takes a reference on the next inode, drops the=
 lock
> > > again and hands the inode out; the reference is what keeps the cursor=
 on
> > > sb->s_inodes so that the next call can resume from it.  As the iterat=
or
> > > is a cleanup class, a caller that breaks out early does not have to c=
all
> > > sb_inode_iter_end() explicitly.
> > >
> > > Two optional channels let a caller keep its own state instead of fill=
ing in
> > > a shared context:
> > >
> > >   - iter->eligible is called with inode->i_lock held, so that a calle=
r can
> > >     reject an inode before a reference is paid for.
> > >
> > >   - iter->status carries an error out of the walk.  Setting it to a
> > >     negative value makes sb_inode_iter_next() return NULL.
> >
> > Nobody needs that. Just break out of the loop.
> >
> > > Most callers just want a referenced inode and use no flags at all.  T=
hree
> > > flags cover the walks that need something else:
> > >
> > >   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still ha=
ve a
> > >     reference, preserving the "only handle referenced inodes" rule of
> > >     landlock's sb-delete walk.
> > >
> > >   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
> > >     already reached zero, and %INO_ITER_F_NOIGET suppresses the refer=
ence.
> > >     Neither keeps the inode alive, so the caller has to make the inod=
e
> > >     unclaimable itself.
> >
> > No flags.
> If we do not add flags, we cannot convert the evict_inodes() and hook_sb_=
delete().

No flags.

> We'd better convert evict_inodes/hook_sb_delete this time, and then
> we can add more hooks to super_operations{}, such as sb_add_inode/sb_del_=
inode/sb_iter_inode.
> With these hooks in super_operations, we can add more optimization code f=
or different FSs.
> For example:
>
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
>   and
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Right. One step at a time, please.

Thanks,
Andreas

