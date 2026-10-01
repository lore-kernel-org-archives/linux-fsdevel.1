Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8752CCC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869364; cv=none; b=P8KWyR+IiBg8nCGWP4ydt4xyqukeBWQsyKpBtcaxhiAf1u02cmgR9a7lEQPFqGkII6Z4D808ub4hFIeycKLt7GKHwobAMvM0QJMFFRT+Bgvl1EHUpsBfMBCJdJHO6oXNyMS51vIsegfr2WtMGQ4jXj+pO7/mCxBXIwbNQ96y+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869364; c=relaxed/simple;
	bh=s0uqrlzfEovdMYYmWO3V0cXdBVLMH121ur+Zt2+XQxg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ERjTGVYZz/7jQkCnmSqxFYrsTlhFZ++B7reyUlW93V5wl5C832Nu4y6fLfzlnkaRTjzngi7H7qEPU5B9KUbi+x7Z55sLJH208NVqWdhCbP9ESg2p3XzOzNekDVBriNZg7jF5TTCluVIxchYek0h5wZbRSfPcV823QBPnczcgn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=W7HnVUjl; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="W7HnVUjl"
X-KPN-MessageId: b9c3d6a0-bdae-11f1-bfbc-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b9c3d6a0-bdae-11f1-bfbc-00505699b430;
	Thu, 01 Oct 2026 17:42:36 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b9c424a0-bdae-11f1-9235-00505699891e;
	Thu, 01 Oct 2026 17:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=pufbjWZ2bZVanFp3ehIV9u9uVyrHeClJtwBhjp4HFB8=;
	b=W7HnVUjlj4Bi4RACE8YEBjUx5w7Dp32YYn9qIUPghu2yrgpO5IkQFtBYEDXKWHsUJ/A37AZR8oZoF
	 czCVJ+a0+enLbN/y6zEgq1xEaTwq8UK1wDktdyfVHzW8+79Uq06IFrT+WFDu4h/IC1yUZg+r33nc9P
	 zI/aM6RmOS+gh61CPtO4vBk9V4+dsFUn6IJw+zbvK7ZJ5gOBOaS0VVo/A8tL5ApK4yPJKt2d83K0vF
	 ukBio0mwue5p0SeGtpDtZBpwJA8kKPAkoNJAwoe7CGWxAmax1POlU/s+w8gjPtvbvW7sYj4dwtiCwe
	 RTKKi56af2uqp1FbAfJWx0bRjDyME2w==
X-KPN-MID: 33|xXmJQbOIUW6WkkYwA0eOZ5kNnf0tpV9MMlzmzsN9TNDzPdA2xeM/u21I24Dec/6
 6y4b3OTr5+1BBC1JqRYHwU/9Ldbxb0BWvXjobNHP3B/c=
X-CMASSUN: 33|OEgeru7VRMCbyzLTcde9nf7GoiI0AKJkmr6MXmXrRv1kEwG+z+piYrCbULOriO8
 EYp0+tXp310g/BQOGJZ/A9g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b9b89491-bdae-11f1-8edd-00505699eff2;
	Thu, 01 Oct 2026 17:42:36 +0200 (CEST)
Date: Thu, 1 Oct 2026 17:42:36 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Message-ID: <1000409963.929534.1790869356300@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
 <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
 <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl>
 <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
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


> Op 01-10-2026 11:29 CEST schreef Amir Goldstein <amir73il@gmail.com>:
>=20
> =20
> On Thu, Oct 1, 2026 at 12:16=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> >
> >
> > > Op 30-09-2026 05:45 EDT schreef Amir Goldstein <amir73il@gmail.com>:
> > >
> > >
> > > On Wed, Sep 30, 2026 at 12:15=E2=80=AFAM NeilBrown <neilb@ownmail.net=
> wrote:
> > > >
> ...
> > > > The problem with this approach is that open(.., O_CREAT|O_DIRECTORY=
)
> > > > might create the directory, then return -EOPNOTSUPP.  This is weird=
 and
> > > > I'd rather it not be visible.
> > > >
> > > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather i=
t
> > > > remain a -EINVAL on any filesystem which doesn't completely support
> > > > the functionality.
> > > >
> > >
> > > Joining late to this party so apologies in advance if my questions
> > > have already been addressed.
> > >
> > > I agree with Neil's statement above, but IMO, the atomic_open() fs
> > > match the description of "doesn't completely support the functionalit=
y."
> > > Therefore, I think that rather than success if directory exists, they
> > > should also return -EINVAL/-EOPNOTSUPP consistently (see below).
> > >
> >
> > The issue with this is that if you want per fs atomic_open() opt-in (in
> > contrast to either implementing all instances in one release or disabli=
ng
> > all), you have the issue that your lookup now depends on the caching st=
atus
> > of the directory dentry.
> >
> > If that dentry is in cache, and positive, d_lookup() earlier in lookup_=
open()
> > makes it return early:
> >
> >         if (dentry->d_inode) {
> >                 /* Cached positive dentry: will open in do_open(). */
> >                 goto out;
> >         }
> >
> > So you get your lookup. But if the same dentry is not in cache, now you
> > suddenly get -EINVAL. I thought that behavior was more unwanted then
> > what I eventually settled on, namely to strip the O_CREAT bit.
> >
>=20
> Maybe I am missing something, but I think you misunderstand me.
> What I mean is - if directory inode has a ->atomic_open() op,
> bail early with -EINVAL/-EOPNOTSUPP, because this is a network
> filesystem that does not support atomic O_CREATE|O_DIRECTORY
> and in most likelihood never will support it.
>=20
> This gating criteria is not dependent on cache state,
> which is what we wanted.
>=20

No in that case I think I've understood you (or maybe still not?) My
point is that we can't do that if we want to be able to individually
support O_CREAT|O_DIRECTORY for some ->atomic_open fs. If we bail early
the how can say only NFS support it at some point? You get into the
situation where everybody needs to have support or no one.

Does that make sense, or do I still misunderstand you point?

> The justification of using ->d_revalidate() as another opt-out
> is that existence of ->d_revalidate() means that the state known
> to dcache is only semi-reliable, so making atomic create/open
> promises is problematic (O_EXCL for example).
>=20

I must admit I don't know too much about what the revalidate step is for.
What does semi-reliable mean here? That the dcache might have returned a
dentry that has timed out in some sense and does not reflect the actual
state of the fs?

But if we force O_EXCL like Neil suggested, is that a problem? You'd only
get an fd if you actually created the thing.

I should really start to learn and contribute to an actual fs that is used
instead of just staying at the VFS level. It would make understanding all
these subtleties easier...

> The problem is that some fs (overlayfs/ext4/f2fs) register
> a mostly-noop  ->d_revalidate() so I proposed how to deal with those.
>=20
> Thanks,
> Amir.
