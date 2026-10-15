Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DF59B68C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096861; cv=none; b=aHS0t3UUng6Vu5JFk732J5ghyovsGobAOPbxkYqRB1NqnBaRQ0lzlv+Ynxi4VkoJF49+FbCwSjyuhvxmO0/sQLNiF/HVT0Un+YK+DTwvMfnv89ztKvulyWt1ktlnDfKuk+abPBd/kUBV0wZAYh6MdCssPBL/oSuUxSMIcVQOCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096861; c=relaxed/simple;
	bh=NJMJDAPBRBkct471Wro+FMvrvMYioG104cWEwPkZBSc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ll9v2yf2aYhQ/4N/otNxS1EDm9z1r3jU8eMjH3jSgrDqMwZXNRJkgcXycHT44SUsYib1PKuQcz30Y0tLxseP+5cgCAcwUxP8ymGs9o9r0yTuSFGIg3pW4rRl7ezu70vTOYK3pEuK4Kmw3zGLRaIoXp5QH9dP92iyDBl9mQNPx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Uxix3Xim; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WF5neYDZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Uxix3Xim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WF5neYDZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 442101D00147
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 16:40:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 16:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792096855; x=1792183255; bh=zKCp6IMcnp6RSJAmgT+JnqwK9aVqwoNitsu
	z6nazjkY=; b=Uxix3XimMXZYub5na8efZzOJoQWPYa0Nmhe15LBI7vvqfXMllnd
	LZi23Oh/7lChvJLVevERLZTLQuzM3msPDI9Ds1tOfYBUPU3Qb8br3ANAndITCTWt
	+45tJdrCb2srSq0FgMl3sRQIw/FPU2qT4wDjwiGbJUnVT1h9njknXX7Fw6pKsCQ5
	5EZZLack2p+rq2RNrDVLCw8/y8J18FKj91zxIDd0QVNVpuSAlon0+4+60IJp+4zv
	ajV2UUV6BZ0aAos8IHsYzixdpDZN3V7IDJ8x0gSUKZHoSB+Oj1vF0rwoC+rpRlRr
	QgoWSZh4FquNpuS4s4fnIUozDtRw9ZSmUWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792096855; x=
	1792183255; bh=zKCp6IMcnp6RSJAmgT+JnqwK9aVqwoNitsuz6nazjkY=; b=W
	F5neYDZA5fEIQElTEBIsCuK3yEaMpDoXwksKZoCx56JMiDh2DAlKURr7WA0FnqUL
	fTp/xOA/rSGSQqHMKlP1bgDWs9RiPPQVsSwKNSHjT8upHg6VsAlEltguYmSJTTRd
	RFYKqNSvOqiRoZlh/jbQTUvoQf4A6vTPw01H0vZqzJ7bxnaFEhIi3Nq2FoK+G0h6
	HhtWWCdf5FcLEu8atRZXMFZil+/xMZa5XiOzL+ejyTLr/4efC+UxhMt+gsRctPkY
	KlT8X1vDLEFBOEh90bKyceIRzkiIBCAhSaMm/Vc2boIzzSYALKUtBuKXE+z/6brY
	4NlrvBOSFndRxdd5qJTEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792096855; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:F63kLw7Tf4fHw7XTlpp554+RHxZZGX/VFxBmDrxFE1ZxaeF
	mii9AOIRaesmTN9Q9ybj0tKVN6vfPKJw8K7grTkb3WYUwLVzvbq5cnDbCuzuVsgj
	tNlpvFoEH7lK/DGXZkX8O39RJ86X+Os9j/IhTX8djLdgw9B2+PIskKOfSi/TNOZW
	73z7WfX8xi42+wQiLMvu8q9UJc0dEHftoju4GwGcYnHDSNZI8s84L6+JHIU7fJno
	7CgJOlv6nTpG3EioeMtZG9POy5Pn5L+EPPZhkRaZ/krT0P7WVNM2js5Qa+d7+nio
	A+zOVH4AvXBUEyJRYWym96M3KnWS02HL3KpbHkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:oxp8d2jsMMLGzF6YYg1aHc3Ck6W2MSTY68hX1WXkjS0=:NJMJDAPBRBkct471Wro+FMvrvMYioG104cWEwPkZBSc=;
X-ME-Sender: <xms:VzrRamb6IgvX4vrpZy6gXzvhHhMDt0jCfBBKsDwIFzTZ67lvabTyOw>
    <xme:VzrRarpFsnPmqv4KYze7RERBmLCXX-qn2pXRkr5WezlZmeHt_0rRDg_iywz-ugR_j
    N2JZotV1y82aRThHL7pW4QE7z3u3lIhrKd219R1BMdRvCW71pY>
X-ME-Received: <xmr:VzrRajOoSOwUlRKOxr_o_9LhVRoK8irl5XZY-tlbpRUyglCDoq9JOIunDq89Dd4oI4Rz6PLmcGVyVi9mmli_INi14hIaSys>
X-ME-Proxy-Cause: dmFkZTGw5/xefO5pPuTaamR1oNosedwhl2Hauxp4GFxbScZufefgblu8VRPofYKTRwW/2o
    tkLwbqIBZVL3pfSwQwoFHTRRG+2j+vz1F77Ddqb16piZ4MIOgP2SxeAmrN1TdzbVrSbPnw
    f/DWRRT9h+2nRgz0zvZO00XJ9+9UlAhlI/VZX78C6sx0WoBr1lVmsK4O1qXAzPOoGB1mUf
    zprhydxfIQ3lAEIFYE0acZ+joJBIZ3uSuIbFHT5YveHEe1NlU4OlqtvWh8RnA7XNer7lV1
    t9ODbvCoq9HQV0km28zwFXGa2MFNMfsIuyqKnRMUlbGh6rfPTWWP6YmHSbMZ36dO9W42P5
    005u0crhnd8RliwUB4uuOU6ecf9VQJ9HBDTApA1vnLEMO/sdbte8zNMBDaD9eYkXlS6ywY
    2hIO42gcB9dsBovvkDaumyDJIimyXGKVtYmrXSy02Rb+5uMIRrpcujv4oDrwyLtkFEy9By
    Vx7Y6oZ4KNGB+O+bTMeopHHpL7JKAnhBxX3C0Nj/9nTkOCDqV+9o/vEjV80LWSaV9vQBhU
    lHNomOKctSp7igBNDmwZlyPxxZXO0cvW0V4V5WM8qU9MVWC+Jx1NIcWdmv3L9CDuViAyct
    AE2J+BKYxwa47ecrvrdPokXHiOT/1h1fkhfhNcuirr3/CMhshLrQBMAmY6EA
X-ME-Proxy: <xmx:VzrRaurdwLlYDfOh58fFDZQHDdm2KKs186BmPsvSAa9FbYkJLQ7d1w>
    <xmx:VzrRageN6yU69tMYwW9ZSF1x9_HQpFryddMNDJ277hapBUS2MdXffQ>
    <xmx:VzrRasS1wCzO8PMmRXES3f4OIvFjmEHCM-ycvqG86G5XEWGgl9kr9g>
    <xmx:VzrRahbY5S1c2dcgImuw0gSzzuC1dKTUcl0Eno0KOmi50C8JoTS4QA>
    <xmx:VzrRamwMYVWP4SsPSfZniRvCv5yAL3Qf3PlYKXkXJ-c0yDfllg5GqDDK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:40:53 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] fs: add path_create(), path_move() and path_clone()
In-reply-to:
 <CAGudoHGZ_4AhKKBb8ves8r8ztCCCfjtS8nhF0PTyMYHn2119bw@mail.gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-3-mjguzik@gmail.com>
  <178943070662.207413.9700024518083440241@noble.neil.brown.name>
  <178943102713.207413.2253649379310238579@noble.neil.brown.name>
  <CAGudoHGZ_4AhKKBb8ves8r8ztCCCfjtS8nhF0PTyMYHn2119bw@mail.gmail.com>
Date: Fri, 16 Oct 2026 07:40:49 +1100
Message-id: <179209684921.1724252.1564933708455367197@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 09 Oct 2026, Mateusz Guzik wrote:
> On Tue, Sep 15, 2026 at 2:10=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Tue, 15 Sep 2026, NeilBrown wrote:
> > > On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> > > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > > ---
> > > >  fs/namei.c           | 29 +++++++++++++++++++++++++++++
> > > >  include/linux/path.h | 14 ++++++++++++--
> > > >  2 files changed, 41 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index ca4f5e3be99a..c8754c7ba8be 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permissi=
on_may_exec(struct mnt_idmap *id
> > > >     return security_inode_permission(inode, mask);
> > > >  }
> > > >
> > > > +/**
> > > > + * path_create - WRITEME
> > > > + * @path: path to get the reference to
> > > > + * @mnt: WRITEME
> > > > + * @dentry: WRITEME
> > > > + *
> > > > + * Create a path object using the given vfsmount and dentry pair whi=
le incrementing
> > > > + * the reference count on both.
> > > > + */
> > > > +void path_create(struct path *path, struct vfsmount *mnt, struct den=
try *dentry)
> > > > +{
> > > > +   path->mnt =3D mntget(mnt);
> > > > +   path->dentry =3D dget(dentry);
> > > > +}
> > > > +EXPORT_SYMBOL(path_create);
> > > > +
> > > > +/**
> > > > + * path_clone - WRITEME
> > > > + * @path: path to get the reference to
> > > > + *
> > > > + * Given a path increment the reference count to the dentry and the =
vfsmount.
> > > > + */
> > > > +void path_clone(const struct path *src, struct path *dst)
> > > > +{
> > > > +   dst->mnt =3D mntget(src->mnt);
> > > > +   dst->dentry =3D dget(src->dentry);
> > > > +}
> > > > +EXPORT_SYMBOL(path_clone);
> > > > +
> > > >  /**
> > > >   * path_get - get a reference to a path
> > > >   * @path: path to get the reference to
> > > > diff --git a/include/linux/path.h b/include/linux/path.h
> > > > index 7ea389dc764b..8a621e0e1921 100644
> > > > --- a/include/linux/path.h
> > > > +++ b/include/linux/path.h
> > > > @@ -10,8 +10,18 @@ struct path {
> > > >     struct dentry *dentry;
> > > >  } __randomize_layout;
> > > >
> > > > -extern void path_get(const struct path *);
> > > > -extern void path_put(const struct path *);
> > > > +void path_create(struct path *, struct vfsmount *, struct dentry *);
> > > > +void path_clone(const struct path *, struct path *);
> > > > +void path_get(const struct path *);
> > > > +void path_put(const struct path *);
> > > > +
> > > > +static inline void path_move(struct path *src, struct path *dst)
> > >
> > > Oh ...  this is backwards.  At least is it backwards compared to
> > > memmove().  I understand different people will read "move" differently
> > > and would prefer to avoid it.
> > > Can we do without it?  You only seem to use it in one place.
> > >
> > > How would you feel about:
> > >
> > >  struct path path_move_from(struct path *src)
> > >  {
> > >       struct path ret =3D *src;
> > >       src->mnt =3D NULL;
> > >       src->dentry =3D NULL;
> > >       return ret;
> > >  }
> > >
> > > and then use
> > >
> > >  file->__f_path =3D path_move_from(path);
> > >
> > > ??
> >
> > And then of course there is path_clone() which looks backwards to me.
> > Can we just change path_get() to return the path, like a lot of
> > FOO_get() functions do, and use
> >    newpath =3D path_clone(old_path);
> > ??
>=20
> Apologies, I got busy with other stuff and completely forgot about
> this patchset.

Yes, life happens - sorry for my delay, I nearly forgot :-(

>=20
> My issue with the proposed approach is that it prevents the routine
> from taking a look at the target.
>=20
> While the content can be considered uninitialized (and thus arbitrary)
> at first, the code can be hacked up so that when the kernel is
> compiled with CONFIG_DEBUG_VFS the struct is extended with a magic
> number denoting it is populated. Then a repeat call to populate it can
> produce a splat.

I certainly see the value in these sorts of checks, but I don't think
they should be added by instrumenting the C code.  Rather it is a job
for a static analyser such as smatch.
There are lots and lots of places in the kernel where we assign a
pointer to a variable.  Changing all those to ptr_assign(var, val)
so that we can redefine ptr_assign() to check that var is NULL
would be horrible.
You seem to be suggesting doing exactly that for struct path, which is
simply 2 pointers.

I don't think the cost is worth it, when a similar effect can be
achieved in other ways.

>=20
> I'm not married to "clone" and "move" terminology, which I only used
> because of Rust.
>=20
> Would "path_dup" and "path_transfer" be clear enough for you as far as
> direction goes?
>=20

It's not about the names, it is the design.
Any function which is given two pointers of the same type and has a
purpose of moving/copying/cloning from one to the other hits the same
problem: which direction does it go: left-to-right or right-to-left?
Some people will expect one, other will expect the other.  It is no-win.
I would always assume the same order as strcpy(), but others may not.

Contrast with
   foo =3D xxx(bar)

Here there is no ambiguity at all.

Thanks,
NeilBrown
