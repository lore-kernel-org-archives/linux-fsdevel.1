Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101B3AB273;
	Thu, 19 Mar 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909710; cv=none; b=fQNLusFLS77/lDzsqsO4JgI3//YvyGDjat/1GXlBy+77JqpqRcmE43BFzBn3LlpflxACYNZTPhz69FSXoMMWBaGDGZ9tA/BjYwUEUad8soTX9gXjpasxbnHMl9aLaS6W2DRCVZjgYOTsOI9yYXga3oyZBGvqZB4shjwRBXF3wOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909710; c=relaxed/simple;
	bh=gJsiAqOhkaBhm+63GsmvSJOq9Fiqze18XddEInlB0rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmlvJeFt487mWFFkoSEygFZuev8UWZty5eDwOwTI2ovZ0Idy+u0Z4foqinLr2Wttn6MUYLyNwKCRARLrNtjOmW1/wJWLnpESKnnWTPo/BGmZSAz+kRsH4DE5JZmQjU1KAewC0b0yv6Jfo+1J4E9gPwXP13h+dV504TGJPOA/APw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id D5DDBE039F;
	Thu, 19 Mar 2026 09:32:20 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 19 Mar 2026 09:32:19 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
Message-ID: <abuw1Z40Dg9Rp4Vj@fedora.fritz.box>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box>
 <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box>
 <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
 <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com>
 <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>

On Wed, Mar 18, 2026 at 06:32:25PM -0700, Joanne Koong wrote:
> On Wed, Mar 18, 2026 at 2:52 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> > Hi Joanne,
> >
> > On 3/18/26 22:19, Joanne Koong wrote:
> > > On Wed, Mar 18, 2026 at 7:03 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> > >>
> > >> Hi Joanne,
> > >>
> > >> I wonder, would something like this help for large folios?
> > >
> > > Hi Horst,
> > >
> > > I don't think it's likely that the pages backing the userspace buffer
> > > are large folios, so I think this may actually add extra overhead with
> > > the extra folio_test_dirty() check.
> > >
> > > From what I've seen, the main cost that dwarfs everything else for
> > > writes/reads is the actual IO, the context switches, and the memcpys.
> > > I think compared to these things, the set_page_dirty_lock() cost is
> > > negligible and pretty much undetectable.
> >
> >
> > a little bit background here. We see in cpu flame graphs that the spin
> > lock taken in unlock_request() and unlock_request() takes about the same
> > amount of CPU time as the memcpy. Interestingly, only on Intel, but not
> > AMD CPUs. Note that we are running with out custom page pinning, which
> > just takes the pages from an array, so iov_iter_get_pages2() is not used.
> >
> > The reason for that unlock/lock is documented at the end of
> > Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well we
> > don't have that, so for now these checks are modified in our branches to
> > avoid the lock. Although that is not upstreamable. Right solution is
> > here to extract an array of pages and do that unlock/lock per pagevec.
> >
> > Next in the flame graph is setting that set_page_dirty_lock which also
> > takes as much CPU time as the memcpy. Again, Intel CPUs only.
> > In the combination with the above pagevec method, I think right solution
> > is to iterate over the pages, stores the last folio and then set to
> > dirty once per folio.
> 
> Thanks for the background context. The intel vs amd difference is
> interesting. The approaches you mention sound reasonable. Are you able
> to share the flame graph or is this easily repro-able using fio on the
> passthrough_hp server?
> 
> 
Hi Joanne,

I have tried to reproduce this with passthrough_hp and I never saw it.
So my answer would be something like: I don't think so.

This happens even with large folios disabled. I was just trying to
solve it, since I figured it will be worse with large folios.

Thanks,
Horst
