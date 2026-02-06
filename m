Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784330F923
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410934; cv=none; b=Z6BF2BE1X0ayIN6NoAlIBaLV6xvQm82dTuHYb3vni9m5MIkWa0HbaVSPAnMSImK8M/qjtsJvm6IYdzlECV2s3UpjwzTsHfooZ3qlaOm95TxJLtSnt3aud5be3D/BWDt4FkfjEFaqEMejgLXAm4R7HZUikuiGDSPtjW3DIpdvgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410934; c=relaxed/simple;
	bh=WHaKnbzsHJXuNa4rOa1FX5upaKuI1YSx041HaP4RnMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp+uFgK7Jzv9ZuVVH6kkwsUhG33A93Mc797JMNpwzH+IQyPrnCLO4kTFlRVtai4deel/zZcswLvrEbP6/Pa85D/KRbhIsIr3ikyr4BX9++X4VR3zbrHZxaEwNceWK7fSXz6mYc8nxTERna05l8kvSgeA3npl9TEnKZ6HD2nKAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id EC97313A732;
	Fri,  6 Feb 2026 20:48:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf12.hostedemail.com (Postfix) with ESMTPA id A867A19;
	Fri,  6 Feb 2026 20:48:44 +0000 (UTC)
Date: Fri, 6 Feb 2026 14:48:43 -0600
From: John Groves <john@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, 
	"f-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <aYZOVWXGxagpCYw5@groves.net>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
 <20260206055247.GF7693@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206055247.GF7693@frogsfrogsfrogs>
X-Stat-Signature: cqk9n84z5e7475fspkci4jj389cgj9a6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A867A19
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/kbEXoXVyehn6SVX2w8GlwdBBc1cid7uU=
X-HE-Tag: 1770410924-647557
X-HE-Meta: U2FsdGVkX19D9mhWQ8I/aTYNrqgq7oodrFMv8oapLz53ClpsHbM8SBWfHQIQPJGOsS5EZ9vGD+L7vpb+Qdync9l4XQGm1UlpD4D1jSkVeVk3Q62AnISQrj3ZDgPRhiPvxNJr76sVE6DRy++UkX8hSbSGSQBtb94d8ir5bHF+zYaOBV3jM6YKW78rl9LcLE/RLLzVdkObsXg06vAdTNmJ/wl6Z8VXemTXZdinmQrxcnL646T4l5L0FpUaBfRoLxR3xxnuEVSgcYNW9Qn7l0m8LF+aP3PvM609rJQAi8aCzJpVS8WSG2rV5++YcbnzYMkFXnk4TU9UrbpenMdp6EqX+9c6eq+w2jZiOUH3a0DVoObCRZVW1Y2Y05ndgI9P+n01IcBcvbL+WdFUElGLM6FdgQ==

On 26/02/05 09:52PM, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > On Thu, Feb 5, 2026 at 4:33 AM John Groves <john@jagalactic.com> wrote:
> > >
> > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > >
> > > [ ... ]
> > >
> > > > >  - famfs: export distributed memory
> > > >
> > > > This has been, uh, hanging out for an extraordinarily long time.
> > >
> > > Um, *yeah*. Although a significant part of that time was on me, because
> > > getting it ported into fuse was kinda hard, my users and I are hoping we
> > > can get this upstreamed fairly soon now. I'm hoping that after the 6.19
> > > merge window dust settles we can negotiate any needed changes etc. and
> > > shoot for the 7.0 merge window.
> 
> I think we've all missed getting merged for 7.0 since 6.19 will be
> released in 3 days. :/
> 
> (Granted most of the maintainers I know are /much/ less conservative
> than I was about the schedule)

Doh - right you are...

> 
> > I think that the work on famfs is setting an example, and I very much
> > hope it will be a good example, of how improving existing infrastructure
> > (FUSE) is a better contribution than adding another fs to the pile.
> 
> Yeah.  Joanne and I spent a couple of days this week coprogramming a
> prototype of a way for famfs to create BPF programs to handle
> INTERLEAVED_EXTENT files.  We might be ready to show that off in a
> couple of weeks, and that might be a way to clear up the
> GET_FMAP/IOMAP_BEGIN logjam at last.

I'd love to learn more about this; happy to do a call if that's a
good way to get me briefed.

I [generally but not specifically] understand how this could avoid
GET_FMAP, but not GET_DAXDEV. 

But I'm not sure it could (or should) avoid dax_iomap_rw() and
dax_iomap_fault(). The thing is that those call my begin() function
to resolve an offset in a file to an offset on a daxdev, and then
dax completes the fault or memcpy. In that dance, famfs never knows
the kernel address of the memory at all (also true of xfs in fs-dax
mode, unless that's changed fairly recently). I think that's a pretty
decent interface all in all.

Also: dunno whether y'all have looked at the dax patches in the famfs
series, but the solution to working with Alistair's folio-ification 
and cleanup of the dax layer (which set me back months) was to create 
drivers/dax/fsdev.c, which, when bound to a daxdev in place of 
drivers/dax/device.c, configures folios & pages compatibly with 
fs-dax. So I kinda think I need the dax_iomap* interface.

As usual, if I'm overlooking something let me know...

Regards,
John

