Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50A1E1DE5;
	Fri, 29 May 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047474; cv=none; b=qMNHdI98tdjDEU3WWyG9EI4u5QUQQyzcqN3YnnEQ7W9WuE22sKzUza1Z8UOTfaImnBpCpq2x6ZxajWFa0aDXYMNJMG55kJl7BpG7KvfXm/b6aXrSvfSU+ryxJ6pKnj3sAz9ouNp1lhgzwmC2Ona9nL6eceONtmh/qtuUVxp5yas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047474; c=relaxed/simple;
	bh=lKyvn1vjLwMTUmb4QPCrBcXgizJNstSYP3q0OIymy+Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SRz6/UAYayCgkqmNPnYh3spi9wQnzJZEP9OWEOhGgdH46quuBkKw4Gw0JcG9xUpYMUn5l0nVr98yExHxl2teXEdmC8diakWf8H4KVnIlXj3QSGirG1rT4eSyuQVe0mjkoCK9x5pOJaMEkoV9Rp4k0chLzTNohEUo5yHsST3nyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=g0DtxZtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6qlF0Iz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="g0DtxZtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6qlF0Iz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 28BC51D0011F;
	Fri, 29 May 2026 05:37:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 29 May 2026 05:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780047470; x=1780133870; bh=GCwCW8NQzZyUc8DaiRXllbO9PxwGTUxUF8d
	yEE3Em/I=; b=g0DtxZtWw2OCi2/3SePOflpJ5EmS+yfkAGZ9SaW/e6DM80qG/2D
	4zekPd9b102fbOtjSMu3ZQNAt4psqQ2VwJkghDRCP8D65OjWEJOR2k0FrXwKhRAa
	3W64D5nFItyiKnKxEC3PyKBOzFskabr/BV6u7K00P1Hsu42xGfNPexDHvkkgdlvv
	qaFifr7/RDjp05jMBJfG29MR46pP4zTNKL+4xUPmNa51NG29tKAWmlNjLSMpJZtN
	vdjU+lbZfw3cTlcCJY6h82VytLhj/ML0wR4lsxcvU9MvfTOrmd78A9DE69bva9LG
	0A4ktkrH9AWCaFaEUbNTP3BwhzBafvhq8tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780047470; x=
	1780133870; bh=GCwCW8NQzZyUc8DaiRXllbO9PxwGTUxUF8dyEE3Em/I=; b=G
	6qlF0Iz9sdwl8sWXWbKM7xDTGaiOOvQMF3oB0QVIaHdI9X6CTzhK22xD9SSWO4bk
	DLZ9Y2Vuj5jqNThbe1d8OGkg00jEK9LMOmCsGj5lmaTVrX5Et7gSBbV5/e2RsVyr
	eO77olFXf+PLgX73Az0EnHMz3f0ASJllawcXHiHNDEW7Lf1Yt8D8+Ia0jd3ZSw+C
	RaDN8D0YooPneJ237z6ZWsUe+isZM5Vw/hI8kQGLvB/JyJA+wHKT5XFFVOLreKd4
	V/58THWZ2SxGfcUNcetzz+kEtbxl8e1s96VPFpvrlWZJiF0f5VJX/b6KJmMjjuxY
	ZcqbFxsM0GyU/+rSJMgkw==
X-ME-Sender: <xms:bl4ZavXwMg-AGdpXq1q8HBSF0fQJeJjzYtEHzhixeLflU9vMqX2gYg>
    <xme:bl4ZakKd1EzmKxUY7SM0dOfs0ziE9IPDuTD1TOAruTXu2mN31Mj1tAWAASPKUTvax
    -YfH4ll4xkV0A19InW4PExCMLH2Nrlp_pBy7pBxS8g2hrMvAg>
X-ME-Received: <xmr:bl4Zav15TmR8cjVMZC-xS_enlLobogVu5Qgy4CNWHx29JEGKKDzn3wUkqm7VWSjN6q9Zu-c7ovgstfsMwjEhk4QEFjCg14U>
X-ME-Proxy-Cause: dmFkZTGuq3kdAv6cYx99cwwzOG+tslvuukIGeN0/gEW8/OmqogAn2p/zEa+9L/GfUC4PJN
    tyiuXXBrP4JzZ4PTeYwPQaug0MggFqVdEFmfYcL1xuXnEcTMi3mVoLL1aJqfxv8Pi8M2nb
    w9+yxm1Wq8gXZ2vkWXlVGuWM/hRnf0bCaztkEj0e8Bvn5revSqCZPYjgQN7ZyZKyg3rBa6
    cTJZkiAQcbFiotlKfb5jhgB8e2qMhceqwQQ4i+XD76dJLZ5EjQiUWDgu/qIZwZlMFSekf/
    lBMb0YtfISg9iBCtCjZk18PDnMd4sGJmV1WD6e4YvsdoKn2qWgmADt56hw0COYcd9SmoTp
    a9uTD7CnEmASJQpBT3ULQASJaJHLLsJQPN10pGB7D0szfw4/4Kgup2B3L/WVmIoYBw3sN5
    htopfhWHLnFw0UPTYJKDYVBCvBDAy1uBMWe9axq1H1sHub9wxXwQRz24tVyUqgl/x92y8i
    EWUf7DxCDdRXVlBDHg7/icywWwPSlIwMo21U+0kiiutUMiw3Bfa2ilp3FXSuHy3uzkVr8V
    qO/OaR0x+n2Vej2hWQXdINi/n0STjLRWiHA5nsspNGbNLESR5LQ36XZukRRJCBfsIiwRdL
    jfNX8orRmufWPMR3W8FyHb7WBqG7cAr5Fk8DxA6VRyH98Zwytms7Jhkl908g
X-ME-Proxy: <xmx:bl4ZahJAtEJDinFJBa-la_tmwluq-KMwy6Vuq8BqjAoUCDcXOSuhWQ>
    <xmx:bl4ZaqhLBWHfi4DqGKp3hLM364wd1g9cnfQdzZ-CeD1TaqnUfgMH9w>
    <xmx:bl4ZahCeHFnfkmeNbpiZnxlmmpfIuJ-dD1bSVTQ-hGVAb3xvPv80Ew>
    <xmx:bl4Zas4VstGrAU-DJ4OKlR-MR9nmBg2tItTj25-tEmUKlaHjDZ8wAw>
    <xmx:bl4ZargDt0IK3NEX-2qet-5V8nRNwu-9jRXe5Sn_RQcbAfu0wYDs6VAs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 05:37:47 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To:
 "Christian Brauner" <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260529-einmieten-fotoreporter-marken-c57a623b2ee7@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
  <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
  <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
  <177992025109.3379282.17157116761998684695@noble.neil.brown.name>
  <20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner>
  <178001270913.3379282.7350422637224934642@noble.neil.brown.name>
  <20260529-einmieten-fotoreporter-marken-c57a623b2ee7@brauner>
Date: Fri, 29 May 2026 19:37:43 +1000
Message-id: <178004746374.1689052.14081871977516845300@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 29 May 2026, Christian Brauner wrote:
> On Fri, May 29, 2026 at 09:58:29AM +1000, NeilBrown wrote:
> > On Thu, 28 May 2026, Christian Brauner wrote:
> > > On Thu, May 28, 2026 at 08:17:31AM +1000, NeilBrown wrote:
> > > > On Wed, 27 May 2026, Christian Brauner wrote:
> > > > > >=20
> > > > > > I'm not convinced the change to EOPNOTSUPP is a good idea.  It sh=
ould
> > > > > > be a separate patch so that it can be reviewed separately.
> > > > > >=20
> > > > > > EOPNOTSUPP is documented as
> > > > > >        EOPNOTSUPP      Operation not supported on socket (POSIX.1=
-2001).
> > > > > >=20
> > > > > > and we have no sockets here!
> > > > >=20
> > > > > Sorry, not even userspace tooling indicates that this has anything =
to do
> > > > > with sockets.
> > > > >=20
> > > > >     > which errno
> > > > >     /usr/bin/errno
> > > > >=20
> > > > >     > errno ENOTSUP
> > > > >     ENOTSUP 95 Operation not supported
> > > > >    =20
> > > > >     > errno EOPNOTSUPP
> > > > >     EOPNOTSUPP 95 Operation not supported
> > > >=20
> > > > $ man 3 errno | grep EOPNOT
> > > >      EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> > > >                      (ENOTSUP and EOPNOTSUPP have the same value on L=
inux,  but
> > >=20
> > > (ENOTSUP and EOPNOTSUPP have the same value on Linux, but according to =
POSIX.1 these error values should be distinct.)
> > >=20
> > > Consistency be damned, I guess.
> > >=20
> > > And if we start caring about POSIX again we should probably remove 90%
> > > of our newer apis. It's irrelevant what the standard says. It matters
> > > what we do in practice. Taking a tour through the kernel and trying to
> > > prove that there's any 1:1 relationship between socket operations and
> > > EOPNOTSUPP fails. Equally, going through large userspace projects to see
> > > whether they treat EOPNOTSUPP as even vaguely socket related also fails.
> > >=20
> > > Even glibc treats EOPNOTSUPP as the universal "not supported" sentinel
> > > and raises it even independent of what the kernel returns. One example I
> > > distincly remember is the fchmodat() AT_SYMLINK_NOFOLLOW userspace
> > > emulation it had to do.
> > >=20
> > > Maybe I really misunderstand the motivation for this discussion. But
> > > this feels a bit like wasting time on something that we've already
> > > established a while ago.
> > >=20
> >=20
> > Maybe someone should update the man-page?
>=20
> Yeah, someone did yesterday actually and it was merged the same day.

That's very efficient!!   Thanks Askar!

NeilBrown

>=20
> > My main point was not that EOPNOTSUPP was a poor choice, but that an API
> > change needs to be managed properly (and I'm not sure it is worth it in
> > this case).
>=20
> Right. That's certainly a valid concern!
>=20

