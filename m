Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208764;
	b=Sut7fe9oR2VoleVbej+oqpRcUwzg4fvMo/iEnqogRp3Ht+yKQFoTu4yZ8DYZz3Qtelij
	 hdD3VzgNxVJ4VsPYgw9jNfzY7YhRSzyjiHs2EAK8AScgbVNUTpJuTxZav5u41+e9/GXaf
	 LgyLl1/fSbNXQRSdSa19BBD/27Qka9+hjbkRF/G4UdlHAbKZflRq7MH3yLTpaMSVXKg3q
	 MPagvkG4JSTAKspK4mboHx82nvWdkHX6kBebysok9cfKOmmuMTkJygTpuSAuVkx3XmAuB
	 l0e7wA7oo69M3GMJ5RJDKO1xY0BfwSKUCrEDIC+UewYcwQA/qIL07Ff/FnF5R+qZJOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208764;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=+AeyA3GsW+h7Ndjan9SGTE5mSdI5m/ehyckQjoYmd3s=;
	b=w03t2r+2jMnVaCAa1vslAuDLIyKlsPy4wQviovuZpmZT5P039FWAXi3AX/iMilK1pjqS
	 VZGWuaUkaloV3hlFvgIKsu2mQuFOjnrKGpQ65Ntu9Zpz9EJO+I8u4wlIk7JYeu1Ydf//u
	 s8R1+b4iAtcBI45UlGMxy2hgWeem1E7LMgSW0iLFUYh1vP6arQKx4LW8AXYkYwrSKaMwl
	 2uSnYZer3N0JjGXWQ8US866DZWJpCDSJzkHJaUTOElRONKiZ7GdUVPFpe3/N6SH8FeRBi
	 wQibzC5lHh1hR5bk6Z0Rjagg15OPDy7JcAsmw8mJNzxzuRE+b1b9bm+w83uo8DVhaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=ItU3HCd3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1N5h+fge;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E17606A6BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 21:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E17606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=ItU3HCd3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1N5h+fge
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 956E57A0401
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:05:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Nov 2026 16:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795208752; x=1795295152; bh=+AeyA3GsW+h7Ndjan9SGTE5mSdI5m/ehyck
	QjoYmd3s=; b=ItU3HCd3GW2o8ciOpMXoc4zKZASr9g7ZnRqmcMpl1O3zobbyBxo
	LO5KPM82AyonygTEpzn9DUPRXvklVpNQ26qwoy3ysQhnS60IbD7zHzteu3v0JVBl
	L6QNg2wvX7kKWe1KMsnrBciBgWqMpx6mRlmz31urANIKyXT//LPy2wOesOut+QC7
	hgXVFayFTioAlTTZ/7GvLMlSwqsy/FJQ4YazZo8iSnLdK6qYMy5DeBUVv0XGVnIX
	dHZvhMDRSdjM/t9zM5x9ZqLG5qeWFYG8EOTCPGclIUooaVEHeiA1/VyMPAglEssd
	ZqRa+rfQf5Ue0/easMUM0hNfPCW7CATwCUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795208752; x=
	1795295152; bh=+AeyA3GsW+h7Ndjan9SGTE5mSdI5m/ehyckQjoYmd3s=; b=1
	N5h+fge8FbCLFr9EPwVHCV5XB05oV6yjQWaCcNDT696j2QnPcYhIeGvwxlnQ+K7y
	zGxrOdc0RbBsUjDao7wXnsNQCy1W5pTDm6vkdj2TQa5N6wYez/KZpu/FyppGbbKn
	a55PBHGAwQSb5CfUM5cEKeqZ4VH/iYu0t2vEgbw9EaKuRg46YMTgZb40BQtvlt8P
	cDyIGaoYi9PRcyHOYxEoqqsXA7/XFlfCHzenHtu8OKl2YjphQGOusDviADNjMBvo
	gNeuqGTladn61+KdGw6w9MsgBaGaIEVBQD6ozmRM0YVMeijtaLR7v0SUjZYG7pRG
	XZDxb4vrcsctiO7CzvD2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795208752; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Xa5Bx0/Gup8L2PtTtoEaoLH0GDfxFSRI3/sXuB8CZKxB042
	B5ytyFY4VmSJoEX56fkbtHyY9bOHeWD+K1xA9pnwmm5qqvLQKw5qh2H1DpEBCRQc
	T4/b8gqkLmf11JUxACDsT4buODqHFdtjGs0J4r6CE9/IXcDd2YwgN5lyFLAWCUZc
	upA88av2vOT4ji8cKoU0IieWdNTbuOnm8lsRQjhZv0zu0AbbQR2Xz7Jr/kmDPjOH
	9s0hJzb71P3JjXgpqAHstVV6Ay1F07cYtiIqkS0JaVruMAaP2eT9zDrJYL9YciGJ
	nu4tWZTTyAt25XrXnTf8GzeQSiTuTqf92UowoEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:kc+ZdO9xCqYVSELUX3OV+rxBr0WYZA9j8TNHyqicCHg=:lldsrvYHoAC4YRaV/tLPHosiYY8w3+V0trFYkvPhglI=;
X-ME-Sender: <xms:L7YAa0bY9X1yeHA3vgXNPETUmu7WJt7DF8xMzI4IjPX37irHQl40Lg>
    <xme:L7YAax_aN8mIJbKKoO7Xpmms97qn4Wn8o3xe9vDnZsFsNztfuagJJzJSB884PN1JY
    qQ7u41GEd_O19ZZRHCLwaHp5nrCJ45I3srW94pvuKPIKTUqrRU>
X-ME-Received: <xmr:L7YAaymOcVjBYXAsJdyr2W1XUhTrMyrLMqGdqOH7BHQL_KqnmeZc55g5XyvaBs76claPyYBsPE4GkLsGdDWvqEGv1HUmzEY>
X-ME-Proxy-Cause: dmFkZTEb0dTkWXMqRbTXjMevlFhv0AxcVkQYTz2cYB8+Tzj+wlcOd4JFvhCwzdO+SAWZb+
    YDW9CA7sDVc6HJ2QvDI12PxTeIssMiQZkuYBzGK+F1ZO7QpsEisp8P060TPsNYWxds+SN8
    QttxlBHoYGLsrXqS2guJCfiSsvj0lIUXQVozPNkte8bYdRpEmIrdnGqDFHHxDk14RTgr7/
    MlEKIVpYDEsCrfrOpxrCoHZnvGe2RQfGuRG8U4+YtYJYiVq3hUCZHepuwvCAxD7z1qe2qO
    gYcx5YRfKav5biDoQYNPvLjvf0djL1gae914XD78DUvGXdx/mINLBUJ29xL3Un1w/KwjPQ
    Ih3D8dARiLPluHIX8nR3/ZpN5sbaqS7CWds+xVX+/nZE2H/bddk8QhjRU7NaJNNuIGppkG
    Vuc6EaMiWFECYX0ESl+IPN4hxzO7ZwiulJiEP4G/IrCzOEvuIjoypyNazMvR3vWVLwjpAw
    o8pTT21SzSM6kLHyZRgeY3lh7c+wTjNSEgUWFjYNKM0Oy4Kg3RU0JifjuGd+lLLuZtbVKW
    10Os7wfnH7JFB/zCv0kedQxIhWDogbtU44Rss2Sx9f0Ye0QLFtfiS9qF6H6CzK1FgPMrTO
    yTm5T7pXHWLBoXIpkuvr1QMk8rfE3WDEt4cPMZg+vdDoURup0xbWS7CzYiJQ
X-ME-Proxy: <xmx:L7YAa-wSa1fV45N3-iDtj4gcl-hRx5xSrY5ua4ge91ufY-EWwDsbMQ>
    <xmx:L7YAa05GpwYyudD6P-IObG6PbgX16Q1CUh71JPUBD5alQ4gMitt4lA>
    <xmx:L7YAa2W57KPdFze_WkJF06SbeciWNtoCaE7ociNOVB2sj5I_JjWYWQ>
    <xmx:L7YAa0KqfsLb_IMIbTLWuoG3a7QaVU5ipJkZ3eH7dSNwhktWtfK1gA>
    <xmx:MLYAazpucyEn037sLrolaqLLpvpjsk7O_ydD8W2Fy4WRf_8J1gy1Onaa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 16:05:48 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Jake Edge" <jake@lwn.net>
Subject: Re: [PATCH v5 1/5] VFS: don't count references through ->d_parent
In-reply-to:
 <CAOQ4uxgK7FL9WSEF4U3Ba=-tVyEBfe+2EFprSywS6W=guBSqsg@mail.gmail.com>
References: <20261119025942.2848130-1-neilb@ownmail.net>
  <20261119025942.2848130-2-neilb@ownmail.net>
  <CAOQ4uxgK7FL9WSEF4U3Ba=-tVyEBfe+2EFprSywS6W=guBSqsg@mail.gmail.com>
Date: Sat, 21 Nov 2026 08:05:45 +1100
Message-id: <179520874523.1728055.4306587281979546862@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 20 Nov 2026, Amir Goldstein wrote:
> On Thu, Nov 19, 2026 at 4:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > The number of negative child dentries that a given dentry can have is
> > effectively unbounded, so counting the references through ->d_parent can
> > overflow ->d_lockref.count.
> >
> > We only use this count so that we can know when there are no remaining
> > references including from children.  However most children appear on the
> > ->d_children list and the few remaining children (inactive
> > DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> > is held on the parent.
> >
> > So if we count whether d_children is nonempty (i.e.  dget() when it
> > becomes non-empty, dput() when it comes empty) and require children not
> > on ->d_children to have a reference on the parent some other way (which
> > they already do), then ->d_lockref.count will not overflow and we can
> > still know exactly when all references, including through ->d_parent,
> > are gone.
> >
> > __d_move() allows that dentries might not be on any d_children list as
> > is the case for IS_ROOT() dentries.  Rather than track when this is the
> > case we dget() either parent if they have an empty d_children before
> > children are moved around, then dput() if they turn out to be empty
> > afterwards.  This will increment dentry if it IS_ROOT(), and then
> > decrement it afterwards, and will decrement the refcount on old_parent
> > if its ->d_children becomes empty.
> >
> > To help with this, dput_dlock() is added which warns rather than
> > decrementing to zero (which should never happen).
> >
> > When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> > added "before" or "behind" an existing child, so it will never be the
> > first child added, and so never needs to adjust the refcount on the
> > parent.  If it remains on the list until dput() it could be the last
> > child to be removed, in which case normal handling applies in
> > dentry_unlist() (where it has been moved from dentry_kill().  When a
> > cursor is deliberately removed from the d_children list the refcount
> > must be decremented if that leaves the list empty.
> >
> > hlist_move_behind() and hlist_move_before() are added to simplify moving
> > a cursor within the d_children list.  This results in some duplicate code
> > as they share a common prefix with d_detach_cursor() (hlist_del)
> > which is currently factored out.  We can expect the compiler to optimise
> > this away and don't need to clutter the C code with it.
> >
> > autofs compares d_count() with the number of known children of a dentry
> > to detect if there are any concurrent references to a dentry.  These
> > comparisons must be changed to reflect that we now only count "one" for
> > any children rather than "one" for each child.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/autofs/expire.c     | 25 ++++++++++++++++---------
> >  fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
> >  fs/internal.h          | 10 ++++++++++
> >  fs/libfs.c             | 14 +++++++-------
> >  include/linux/dcache.h | 17 ++++++++++++++++-
> >  include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
> >  6 files changed, 112 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> > index 5c2d459e1e48..cd276bce28c9 100644
> > --- a/fs/autofs/expire.c
> > +++ b/fs/autofs/expire.c
> > @@ -208,15 +208,18 @@ static int autofs_tree_busy(struct vfsmount *mnt,
> >                         }
> >                 } else {
> >                         struct autofs_info *ino =3D autofs_dentry_ino(p);
> > -                       unsigned int ino_count =3D READ_ONCE(ino->count);
> > +                       unsigned int use_count;
> > +
> > +                       /* allow for 1 if there are any children */
> > +                       use_count =3D READ_ONCE(ino->count) > 0;
> >
> >                         /* allow for dget above and top is already dgot */
> >                         if (p =3D=3D top)
> > -                               ino_count +=3D 2;
> > +                               use_count +=3D 2;
> >                         else
> > -                               ino_count++;
> > +                               use_count++;
> >
> > -                       if (d_count(p) > ino_count) {
> > +                       if (d_count(p) > use_count) {
> >                                 top_ino->last_used =3D jiffies;
> >                                 dput(p);
> >                                 return 1;
> > @@ -321,7 +324,7 @@ static struct dentry *should_expire(struct dentry *de=
ntry,
> >                                     unsigned int how)
> >  {
> >         struct autofs_info *ino =3D autofs_dentry_ino(dentry);
> > -       unsigned int ino_count;
> > +       unsigned int use_count;
> >
> >         /* No point expiring a pending mount */
> >         if (ino->flags & AUTOFS_INF_PENDING)
> > @@ -375,9 +378,11 @@ static struct dentry *should_expire(struct dentry *d=
entry,
> >         if (!(how & AUTOFS_EXP_LEAVES)) {
> >                 /* Not a forced expire? */
> >                 if (!(how & AUTOFS_EXP_FORCED)) {
> > +                       /* dentry has any children? */
> > +                       use_count =3D READ_ONCE(ino->count) > 0;
> >                         /* ref-walk currently on this dentry? */
> > -                       ino_count =3D READ_ONCE(ino->count) + 1;
> > -                       if (d_count(dentry) > ino_count)
> > +                       use_count +=3D 1;
> > +                       if (d_count(dentry) > use_count)
> >                                 return NULL;
> >                 }
> >
> > @@ -392,9 +397,11 @@ static struct dentry *should_expire(struct dentry *d=
entry,
> >
> >                 /* Not a forced expire? */
> >                 if (!(how & AUTOFS_EXP_FORCED)) {
> > +                       /* dentry has any children? */
> > +                       use_count =3D READ_ONCE(ino->count) > 0;
> >                         /* ref-walk currently on this dentry? */
> > -                       ino_count =3D READ_ONCE(ino->count) + 1;
> > -                       if (d_count(dentry) > ino_count)
> > +                       use_count +=3D 1;
> > +                       if (d_count(dentry) > use_count)
> >                                 return NULL;
> >                 }
> >
>=20
> AI review claims that ino->count starts at 1 and (ino->count > 0) is
> always true,
> so use_count should be:
>=20
>                        use_count =3D READ_ONCE(ino->count) > 1;

Yes, ino->count does start at 1.  So it is the number of children plus
1.
autofs_empty() is true when "->count < 2" which confirms that.
So I would need
               use_count =3D (READ_ONCE(ino->count) > 1) + 1;
to match how ino->count was being used before.
Or maybe
               use_count =3D !autofs_empty(ino) + 1;
??

I guess the "+1" could be seen as the reference added by
d_make_persistent().
Then we need to account for various dget()s, hence the +1 or +2 etc.

I'll fix that up - thanks.

NeilBrown


>=20
> It sounds right, but I did not look closely.
>=20
> Thanks,
> Amir.
>=20

