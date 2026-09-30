Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F113AFCF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806623; cv=none; b=ThSzUN1l10yE8gc3LAOGiOfma8ARUYEOkoKpRSMjS/QoN1y2kqKoZR36m1nT01XDFZ0JuYXfWnMflqT2HKueNXDHM5aUod8cXTObxq/ibBdnGXUho+KEKYrqWGDmdo036h/AExFox//klrRuZqFLAl9d3W9vBQSUkvLnmuwQiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806623; c=relaxed/simple;
	bh=UshugKQAvaGDsg8iFn8IJGpBlNxskL8A+CQ8T/k2mqw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Dg0S3YebPV8cw+NDo1Igi2VGCLgW7LxFQwsvJayTi6SrCyGZOiwIYvGwLkrkXEi1Gscr7EiQPMI08OTWTAQx1JDDE0dELwOtE0irKzfZsOqIvQh+KpekfjQDefqPtAXUjsXQt+GVkTcPiNKlxM+KbEiQpuBm15cHOF45VTEaa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=gyh8GbHG; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="gyh8GbHG"
X-KPN-MessageId: a241252b-bd1c-11f1-8f57-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a241252b-bd1c-11f1-8f57-005056992ed3;
	Thu, 01 Oct 2026 00:16:50 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a24002c9-bd1c-11f1-b3ef-0050569977a2;
	Thu, 01 Oct 2026 00:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=+xRCAFcTQy+MaIWANTSWhWiw56yfuFYWNUV0J6l9VzU=;
	b=gyh8GbHGzVRYlhv7pg5cZeourMwAQUFHWPpNiig60P76Qiv1wnVk5AFYeVPHgcJG9SOQ5YwPBgVr1
	 +zt7xd5rvf0DF6GkSBPG9ZmuJK3g/UjNekSN9p/e5p9N/9K2YQ+8RZccM7PJts958TpfltgoxtvggP
	 lfdUS6cne06NTB3QPd8CYAnzVPz0zJc62TTjJfyg9kZgRFpR3bi6bfUP6iMBo2iap3MspzFW2o5BU2
	 QflthVlBHiw44zkLJrHiSljPSQ/oM90KTo0hvpSVKWluu7K515Zqk/AtTwAFgh26LUw3sGdnB1M4GJ
	 uq/nTywRDSfWd9zTbRt965mD/L/T/QQ==
X-KPN-MID: 33|LFjqSkyYy4gTYuMyoP7lupMQaEGSvV9ir+NHUHX3CHUR2U3JzOx0aljw1JUwWRx
 ujT6mAOuebQ1wd0UiVEWyjo7iGkUASoVuEaeHMAzVi1M=
X-CMASSUN: 33|TE+lF3zvUWMEHJI0TOn0TI9D3dv/PBz8QUNaxDQN5PgTsIo3fldpGpeFQUofB9d
 BiflcOzDrWUWtHYudGNm1pQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a233d4f3-bd1c-11f1-8edd-00505699eff2;
	Thu, 01 Oct 2026 00:16:50 +0200 (CEST)
Date: Thu, 1 Oct 2026 00:16:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Message-ID: <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
 <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal


> Op 30-09-2026 05:45 EDT schreef Amir Goldstein <amir73il@gmail.com>:
>=20
> =20
> On Wed, Sep 30, 2026 at 12:15=E2=80=AFAM NeilBrown <neilb@ownmail.net> wr=
ote:
> >
> > On Tue, 29 Sep 2026, Jori Koolstra wrote:
> > > > Op 19-09-2026 02:01 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > >
> > > > >
> > > > > nfsd_create_locked() used to do that before vfs_mkdir() could ret=
urn a
> > > > > dentry, but it doesn't any more.  The reason was because
> > > > > d_splice_alias() on might return a different dentry.
> > > > > In this case we want the same dentry, but we need to do a lookup =
on it.
> > > > >
> > > > > I'd rather fix this in kernfs, but maybe that is a longer-term go=
al.
> > > > >
> > > > > The comment in kernfs_dop_revalidate() suggests the we should d_d=
rop()
> > > > > the negative dentry and d_alloc_parallel() a new one and ->lookup=
 that.
> > > > > I'm not certain that is needed if we keep the parent locked, but =
we
> > > > > would need to be certain.
> > > > > We at least need to d_drop() the dentry before ->lookup as ->look=
up
> > > > > cannot handle hashed dentries and a hashed-negative dentry is pas=
sed
> > > > > to ->mkdir.
> > > > >
> > > > > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs =
....
> > > > > probably not.
> > > > >
> > > > > Summary: I think that if vfs_mkdir() returns NULL (success) but t=
he
> > > > > dentry is negative, we need to d_drop() and call ->lookup with a =
big
> > > > > comment about kernfs.  But we need to double-check that this will=
 do the
> > > > > right thing with ->d_time (I think it will).
> > > > > We also need to think carefully about races with
> > > > > kernfs_dop_revalidate(), which could happen concurrently with the
> > > > > ->lookup.
> > > >
> > > > I've thought a bit more about this ...  I think that doing a lookup=
 after
> > > > the vfs_mkdir() results in a negative is a bit ugly.  It assumes th=
ings
> > > > about the fs that I would rather not assume.
> > > >
> > > > I would rather have the current proposed code check for a negative
> > > > dentry, and fail with -EIO or similar.
> > > >
> > >
> > > I just noticed that there's precedent for this in overlayfs in super.=
c:
> > >
> > >               /* Weird filesystem returning with hashed negative (ker=
nfs)? */
> > >               err =3D -EINVAL;
> > >               if (d_really_is_negative(work))
> > >                       goto out_dput;
> > >
> > > Shall we just do this for current kernel release, then we can add sup=
port
> > > later if wanted.
> > >
> > > (But let's do EOPNOTSUPP instead of EINVAL)
> > >
> > > What do you think?
> >
> > The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
> > might create the directory, then return -EOPNOTSUPP.  This is weird and
> > I'd rather it not be visible.
> >
> > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > remain a -EINVAL on any filesystem which doesn't completely support
> > the functionality.
> >
>=20
> Joining late to this party so apologies in advance if my questions
> have already been addressed.
>=20
> I agree with Neil's statement above, but IMO, the atomic_open() fs
> match the description of "doesn't completely support the functionality."
> Therefore, I think that rather than success if directory exists, they
> should also return -EINVAL/-EOPNOTSUPP consistently (see below).
>=20

The issue with this is that if you want per fs atomic_open() opt-in (in
contrast to either implementing all instances in one release or disabling
all), you have the issue that your lookup now depends on the caching status
of the directory dentry.

If that dentry is in cache, and positive, d_lookup() earlier in lookup_open=
()
makes it return early:

=09if (dentry->d_inode) {
=09=09/* Cached positive dentry: will open in do_open(). */
=09=09goto out;
=09}

So you get your lookup. But if the same dentry is not in cache, now you
suddenly get -EINVAL. I thought that behavior was more unwanted then
what I eventually settled on, namely to strip the O_CREAT bit.

Best,
Jori.
