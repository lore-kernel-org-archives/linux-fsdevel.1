Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362F3438BD;
	Thu, 28 May 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012716; cv=none; b=lSKFYEbsGkMsocVPhwdyzPKAneWTsXSc4arb1kLLGbUdWhOVC7Zd9kWPjXhu7L3m8j5iwF+OG5pEs+ES2g3EAqz7uwK44r3VLr+SzqphL2NvITh//sxPhccnOHRYue3wn7JjdvQ82YiznHYtXUUTDjqVfrubg+xmK5Q8h5Oklws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012716; c=relaxed/simple;
	bh=y2fEVOkK8+BTWPqocUtjh6dAlZUQsqL9ivU7tVJzRTk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H4nRt/IV1aieWGcNYlNMkbZ/wRAIuQ3XPAHqjYKuIOESnoKdC3U9g9mxUoAc2zwyv5p5g/hYidO7z3aDJJv7/Jbcj1nkmYuAkwZTDojCmtiFj84jwaWLaQKo5d3elyawtMrH+Y9zStKURgjy/T7IcSgQS3sOgxm3IJSJA7sl9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=a9jPI4Le; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eY0v7xG4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="a9jPI4Le";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eY0v7xG4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 77836EC0B16;
	Thu, 28 May 2026 19:58:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 19:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780012714; x=1780099114; bh=bWFvmWidqFBep1LtYkDfLDoKaVR/tdNpW3W
	Y2yco2vw=; b=a9jPI4Lej5gMiPSkmO7rX421MPjccBXNkn7Zwc2buP8cjoLAHqQ
	tzfoMWFt7cgPi2jeFErPilCyScKTLTfv/pDbiLnU55Sgpx2Gnf+N2HwK4E+KNDCW
	lbtfS/HRdIk4OR5BnyKWf40q2WeQhsBMtQGnKr6bqIIivJ6dzT+ZI3Qh+am6QlFP
	jHWJkof1OZwTV0Rrdt7QJgtHmzq5rWq3Z5XwUjRUB3BaGqHSAIMcvQfUExHr34o1
	px5yA2WOGHxz9O4zseWvJUdSeZuEFQXoS+apFyIuWyCG7YB8LJ9HDJxtsMyWHrb2
	ob8vOW7A4zN3Sx7GUNNm2q/at3RAZFrVGbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780012714; x=
	1780099114; bh=bWFvmWidqFBep1LtYkDfLDoKaVR/tdNpW3WY2yco2vw=; b=e
	Y0v7xG4FvehvaRS68it0PcKFSqAKY3mlK0Y9smDC1AJ6oSE6lOwLFopGOo1gMlTX
	kUr9E7skKLKHPnkyYj+jSTEkHNtYo+3rjAn2WVJC8u/wnf8+ApnwVHDSQ8FqHUiv
	C0loHU1gMLy8GPkRks36AauXvspT+iBwqGdMaAiEfwv5trBPq3A/q03z2blOQItl
	giB1KGIhklKgDrwUKmUN0fNhpl4cC+ZtjQTCVDsbjM6lHzUf70PO6N/XHBauMm/V
	feoHCoFhAZjrYG8iLxOF5e0uiEE7qDX5dfcUA8BEf/vV+Q3u2BCDckPlgwTy1ErT
	v+rg8JoCxEeOWdzkOQLDQ==
X-ME-Sender: <xms:qdYYaiBcwVNDumiTcb7CpOTwuSL5dxnWVF3IiTD5kAe-EThsxI7rwQ>
    <xme:qdYYavHZTEIVrBn2t8YpPXR93AMKSumiWKXGKxLHWm4DpDQgLYI9mTrUgQ73WiZ9K
    1LkdIbGQJseI-2yFg8wWLghDW3zeX3my0c6Qjif6FcpaTUU>
X-ME-Received: <xmr:qdYYapMm0bVsXdv4WF761e1DQCjuAAwFqA15tudLJSpo3W7X7vLyHVVmTO3-PaGRYPOykqvYVrCvdVMfQwSTv4g-5ELMHU4>
X-ME-Proxy-Cause: dmFkZTEIhFFii/hMfqqs+EenVdWXEGhjah+JkaFPLtZcio/EcACmKbHC/DfNoHDF8BGQ2v
    PG0khgvdFceuL+C1Ejz5x9JtpVAG+jrqgLHtwiipVA526HjeSpWRKm32KyzorYe45uGaUF
    Pi6wAjAyr1jg5/CRAzglwrJvgtkWGe+Qiffu20EGW+cGn4kWH9T1SP8jngnjADnWYmNn2H
    ord3+NB6FeHOlRQ/eX6FynhE5Nb5R5qGNPnM34HhOg7KYDDaBKPkOdM0v5HsyWfi9ZwJ8y
    oaWDV00lcedb1yNFJWPA4ooX9KRH0dSu0mf+G3e2rkKHlsNRPV3VKg3+D2X6SdzuuJh5Hc
    S2J0d2Kd+b4XnLjFQdmTdxK6betVC8z2aUBnhelKsjPHrAIZJztZtAM93IjDaLztPUNr2N
    XW3UaBs0r44Sjfh7NWK9QaXG4oQQI5sipd5MVO0Xh99qSq3/q5wU7rfPQzbx8whqrW5y6O
    cJPeruccVyk6n8k2pYUxw8b8m+6twgxr5+n4AwZOpafCRvKhQeGwmyastBYYoh6WUzOpii
    /cP9DTttuomXWCV20arIrEi5o1dLETQZf4xYE1eVoPO/NJ7NrukN/a35TgsRVLI315WEE/
    ZATFPPhagibx9JzUITF9DwWg8ukoRTnh9h7ylG/QvKMh/PcsBz2cfqfj/YHg
X-ME-Proxy: <xmx:qdYYag40xmlHSsOzmDmX3DPkNcsis3lYyFnHQuZjyo9aGoU5-c7oaA>
    <xmx:qdYYasjtkL6SEj8dhl2frNKgDWJOq3tOvw8rH257AasklyfJgUdRHQ>
    <xmx:qdYYalekWA8_BXClDhEtvhkc1pHm1gKyFKaAKFiewVyUbYTnsSTNuQ>
    <xmx:qdYYakwfn-fUolxVc_-XAsnoW1eqeylrd42Omcw2RzWNMRcvB28mXw>
    <xmx:qtYYagYR9kuQpEAHoHWyw1-27M9fv4K2L7EsWYHBIIqB6c9vA75ma_0d>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 19:58:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
  <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
  <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
  <177992025109.3379282.17157116761998684695@noble.neil.brown.name>
  <20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner>
Date: Fri, 29 May 2026 09:58:29 +1000
Message-id: <178001270913.3379282.7350422637224934642@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 28 May 2026, Christian Brauner wrote:
> On Thu, May 28, 2026 at 08:17:31AM +1000, NeilBrown wrote:
> > On Wed, 27 May 2026, Christian Brauner wrote:
> > > >=20
> > > > I'm not convinced the change to EOPNOTSUPP is a good idea.  It should
> > > > be a separate patch so that it can be reviewed separately.
> > > >=20
> > > > EOPNOTSUPP is documented as
> > > >        EOPNOTSUPP      Operation not supported on socket (POSIX.1-200=
1).
> > > >=20
> > > > and we have no sockets here!
> > >=20
> > > Sorry, not even userspace tooling indicates that this has anything to do
> > > with sockets.
> > >=20
> > >     > which errno
> > >     /usr/bin/errno
> > >=20
> > >     > errno ENOTSUP
> > >     ENOTSUP 95 Operation not supported
> > >    =20
> > >     > errno EOPNOTSUPP
> > >     EOPNOTSUPP 95 Operation not supported
> >=20
> > $ man 3 errno | grep EOPNOT
> >      EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> >                      (ENOTSUP and EOPNOTSUPP have the same value on Linux=
,  but
>=20
> (ENOTSUP and EOPNOTSUPP have the same value on Linux, but according to POSI=
X.1 these error values should be distinct.)
>=20
> Consistency be damned, I guess.
>=20
> And if we start caring about POSIX again we should probably remove 90%
> of our newer apis. It's irrelevant what the standard says. It matters
> what we do in practice. Taking a tour through the kernel and trying to
> prove that there's any 1:1 relationship between socket operations and
> EOPNOTSUPP fails. Equally, going through large userspace projects to see
> whether they treat EOPNOTSUPP as even vaguely socket related also fails.
>=20
> Even glibc treats EOPNOTSUPP as the universal "not supported" sentinel
> and raises it even independent of what the kernel returns. One example I
> distincly remember is the fchmodat() AT_SYMLINK_NOFOLLOW userspace
> emulation it had to do.
>=20
> Maybe I really misunderstand the motivation for this discussion. But
> this feels a bit like wasting time on something that we've already
> established a while ago.
>=20

Maybe someone should update the man-page?

My main point was not that EOPNOTSUPP was a poor choice, but that an API
change needs to be managed properly (and I'm not sure it is worth it in
this case).

Thanks,
NeilBrown
