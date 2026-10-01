Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2A4DAF93;
	Thu,  1 Oct 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849352; cv=none; b=IRCpoiEiA38B0Bp9t31qrCvX5n+ZArj/bZ5Mrk4qpb27Wp9CZyn14ltPffSQO0F/RiQojX0IJMx2cfnDC2RlW0FgbS5nT6x9072ygUCbOhVgKUNrBbWYTRApamMOxBgIkvOicmgA6LJNmOA19r+sxWI/KCxT2FczoINwrEzcifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849352; c=relaxed/simple;
	bh=tKokw2iE3RGtNzyaQxgVPTmbgamXeqVk79UvjJSqXpI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p3/sqJnOC3MDNbeG9NX5DHqxNzPYREY6HxilGK8wXMdJTYY2FRmzANamjG4B/1poUDeR4MwHXkHyI2cqqypVMygMto9uRgx2euAB2vNx4cGDxd12a4NfQorUhNbvA0+kMWf0TX+v3aSsz/G0MewtF1Ge0XrL4E9RNWTXXwo1+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=afyCnUHP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSJIBf+M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="afyCnUHP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSJIBf+M"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0FD5E1D000B6;
	Thu,  1 Oct 2026 06:08:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 06:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790849338; x=1790935738; bh=1exN1pVNl0nH8EaZxIVbXqUILu70NNY4/79
	xDEwuHWQ=; b=afyCnUHP5fZih5VSR0eEclni50d7w8sHa2NhlQ4QJfRMHspk40C
	jXEDYqybHXVwO10qMNRgJr+tgKJves+2Ul0vCQR3eHKacQ8uIpu3DisNSZ53DpKN
	IAYDTaU9gd27CcBG1N1AyOEnTFyCDEnQS/jDsuGN3IZFds0LktW3Z1bwzOdv5Ks4
	4J4Yj9/NsWHD5pqMwLmeZuF0fnPKrgqLvCdVayg2eql+Gbm022vNmvMpIQ3+AX4R
	tRSWivTRVAo/F3NDppU0w2HWEkWBuy8GcrjTtc+egQ6kl5ZE6e+yvWCf2unfBkmV
	0RXixXIOMO1Qu5INylNlhseuHPD5jDyPssQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790849338; x=
	1790935738; bh=1exN1pVNl0nH8EaZxIVbXqUILu70NNY4/79xDEwuHWQ=; b=V
	SJIBf+MQ8Mv9QAlT28m40ayzJqgaTI7wkOaBG4FtU4HfOKy9qQs3dbkfd+0w/O7X
	mkMAZCpnUlJ9OuCvf8Ycy0/cW69/folWEcqS0XH4qpYYh9PflNwhWWXa94c1NpRk
	aFrcP9uzSQoq+o/uQgwfKxpyf99O+XtEvILit1mz5yFpa61bKVQoIKZDgbbV00fa
	koiTUcTbRPfYjUzGKe2Fo6xlFF5AmxJZ/KiNG1yutHpfjQ81y/XyxGZ9wi7r5Qrq
	J62hfMI1YKDcaGhT6es8ID61/zw/mhDETxpFdzMk6BfbNNQrTxynDtdhav53/Kqz
	amwcykvJ8IVXoDeMfytrg==
X-ME-Sender: <xms:OjG-arf4M31I20yLvr9YqNhZF9OjIHwJAZIE3_s2YrOiYndxodsJrA>
    <xme:OjG-apZgu70-vp7jYfUjihjMqdjdk8oy6ULCDHNScwKLHdCvCDi_stJD8Wj14I7s0
    nr8i3I7qLqF7DihS7AlWHRnjMxI20pCtSeMkwruR2BpkSHgl8A>
X-ME-Received: <xmr:OjG-agGmUclQbQR5ElhJYQolaLMvgERr5zusuSqyvrT9jWjfGTjJgMMahCFHaN9L7ML-YNOkin5CEOPkdpMlhX0Zb46r4GQ>
X-ME-Proxy-Cause: dmFkZTFEk9uk3JyGmpttT/WdPoWw4VRgtL3IL4xV4kaQoUkTgFr2DXtyPDwbRihCwibStp
    AUuLnDLRdEvJsk+WixNd0vidxW53d5M6dd3cAfBGJ19yzwP76XXgfIDAVkD6WBfqG1AKic
    UuqXFSao5idRf122vd9SSgdXs2SYiPx2CQM5TZLh+BaAD6TDN9ZJpKkQVLHkbTJ+0/hMOW
    966sMUI5chfCjvE//oy7gffpin9wpYN4LhMzciKg4FKcfgYs+eoatqt/qgjrxY3RHJaZ1X
    AXH0UkajIYQLSj29PZT5TCw+4r1i5LAppXRK715i1mCM+svQra63vlmK/Eg+CxBEGGc5n1
    uUNsLwQp8yhwIR8GopINrdYSSt+IizxkUydPZCS+oqUt51LdlwWafwwtyL7qenTUUvziVM
    WrfY1TGvhvAnmoZ/bVHKvw+FEDvvM2vllCtbfO8NlCO23b9hdEa/cmqYY/MviLv8dWirfT
    0J8EVKcJoP77wivzGPIFfBqW070U9U78KR1in65+CCzeHrac2B89KaOcfFBcPH+sZUJkxP
    p8kdhHrdYZqOyCv5wj2uesB1LkSLnNGDoY6UjiVu2TEzI1k8cSbKw2vWkV7PjH/FOdL7Rk
    htAdA7VCQQDpOfplLX/K1OYMSiu7OIHmdnY/XK9GhSJhoNS/EF1C2RuzvlZA
X-ME-Proxy: <xmx:OjG-ankaTVwqPTBTn-DJDcU9UjVeXc4uwaViGWo4W2RFfaSDHRY1NA>
    <xmx:OjG-ajc_d9_d6LEzsDn-CgrMhWCOqXQ_XSfP6q091gsukW2fuYn4bQ>
    <xmx:OjG-alEnKjim8kVH2V64YVDkGooKQC_aIYbHPYNmSlvzv50ez0t1vQ>
    <xmx:OjG-apievBWibxg3mUiihLvtaz39PjAyAuo_57VESATUnvvr_CCseg>
    <xmx:OjG-ahzBmFsCSMQGJbFCUAp-Wz07_KiW9-9z_Pw4cqlUzooSY33FqXvb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 06:08:55 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <aleksa@amutable.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Theodore Tso" <tytso@mit.edu>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to:
 <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
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
Date: Thu, 01 Oct 2026 20:08:50 +1000
Message-id: <179084933040.37859.13445625413196658440@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 01 Oct 2026, Amir Goldstein wrote:
> On Thu, Oct 1, 2026 at 12:16=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
> >
> >
> > > Op 30-09-2026 05:45 EDT schreef Amir Goldstein <amir73il@gmail.com>:
> > >
> > >
> > > On Wed, Sep 30, 2026 at 12:15=E2=80=AFAM NeilBrown <neilb@ownmail.net> =
wrote:
> > > >
> ...
> > > > The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
> > > > might create the directory, then return -EOPNOTSUPP.  This is weird a=
nd
> > > > I'd rather it not be visible.
> > > >
> > > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > > > remain a -EINVAL on any filesystem which doesn't completely support
> > > > the functionality.
> > > >
> > >
> > > Joining late to this party so apologies in advance if my questions
> > > have already been addressed.
> > >
> > > I agree with Neil's statement above, but IMO, the atomic_open() fs
> > > match the description of "doesn't completely support the functionality."
> > > Therefore, I think that rather than success if directory exists, they
> > > should also return -EINVAL/-EOPNOTSUPP consistently (see below).
> > >
> >
> > The issue with this is that if you want per fs atomic_open() opt-in (in
> > contrast to either implementing all instances in one release or disabling
> > all), you have the issue that your lookup now depends on the caching stat=
us
> > of the directory dentry.
> >
> > If that dentry is in cache, and positive, d_lookup() earlier in lookup_op=
en()
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

NFS can certainly support O_CREATE|O_DIRECTORY.  The MKDIR request
creates a directory and returns the file-handle of the directory that
was created.  I think other network filesystems return the identity of
the created thing - or fail if it already existed.  That is enough for
full support.

The only cases where I think I think there is any doubt of support is
kernfs and tracefs because they don't return the inode.  tracefs is
interesting because it drops and retakes the parent lock so it isn't
immediately clear what atomicity is available, though it doesn't support
rename at all so maybe there is no interesting race.

>=20
> This gating criteria is not dependent on cache state,
> which is what we wanted.
>=20
> The justification of using ->d_revalidate() as another opt-out
> is that existence of ->d_revalidate() means that the state known
> to dcache is only semi-reliable, so making atomic create/open
> promises is problematic (O_EXCL for example).

The idea of using ->d_revalidate as a gate is certainly interesting.
Apart from the interaction with case-insensitivity, if we initially only
supported filesystems that don't have ->d_revalidate, I think we would get
coverage for enough filesystems to be interesting.  We could then take a
bit more time to think through the rest of the picture.

I don't think O_EXCL is at all problematic.  ->mkdir() is already
required to return -EEXIST if the directory already exists.

>=20
> The problem is that some fs (overlayfs/ext4/f2fs) register
> a mostly-noop  ->d_revalidate() so I proposed how to deal with those.

Presumably the fs would provide two dentry_operations structures and
choose which to pass to set_default_d_op() when creating the superblock.
Doing that would even provide slightly better performance in the
case where no d_revalidate is needed.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20

