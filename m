Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72F334681;
	Mon,  2 Mar 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457569; cv=none; b=C3FjieEXapLcHWSSjSP3+2+A9TAicR0xq0qvow1rQq8x7dG8NwZ4+pmuVa5AIE1w6ggERAmTkQMYrFl6t6IP9nhxJSKahntX//A3KVKT7Nl6pyKU7VgzqQQPkkS+nw4eDzEwdsGzSyk14mJvjSd8LZJfB+BjtLi+K9Sek095HqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457569; c=relaxed/simple;
	bh=szXZa/RffQNkLt0qmFKE+NwKIkBxd7BocfgKPvzRcP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsU905dtWmKwHaov4PJFX2MS7KA9wTImy4YkYUnXO2A7KhODAy0MM2L6YWCRmILiqOXPysTwZWlv7QjktwsvhRNMss3KQEfc330wd1wDkJxnvWNsaTFN/EFok3xXmJEihvR+OMNFyrMXvZCd0bPGnGcTMLbeJ5Qm7SONp66vJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id CA3C7E032E;
	Mon,  2 Mar 2026 14:19:18 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 2 Mar 2026 14:19:18 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaWNGdV6XoZZXvJW@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
 <aaVcSK1x7qTr1dlc@fedora.fritz.box>
 <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>

On Mon, Mar 02, 2026 at 12:03:35PM +0100, Miklos Szeredi wrote:
> On Mon, 2 Mar 2026 at 10:56, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> > > On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> > > > +
> > > > +       unsigned int max_count;
> > > > +       unsigned int count;
> > > > +};
> > > > +/*
> > > > + * This is a hint to the fuse server that all requests are complete and it can
> > > > + * use automatic decoding and sequential processing from libfuse.
> > > > + */
> > > > +#define FUSE_COMPOUND_SEPARABLE (1 << 0)
> > >
> > > We really need per sub-request flags, not per-compound flags.
> > >
> > > I.e:
> > >
> > > FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> > > success (nodeid, filehandle)
> > > FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> > >
> >
> > Couldn't we just save boolean flags in the fuse_args?
> > Something like 'bool is_sub_entry:1' and so on?
> 
> Sure, that's fine.
> 
> > If we have the automatic separation and call of requests in the kernel
> > when the fuse server returns ENOSYS, I don't see the point in adding this
> > to libfuse as well, since there will never be the case,  that kernel
> > doesn't support compounds but libfuse does.
> > It's either the fuse server handles the whole compound, or the kernel does.
> 
> No, I think the library is in a good position to handle compounds,
> because that can reduce the complexity in the server while keeping
> most of the performance benefits.
> 
> > My point is, we don't need to send that information anywhere.
> 
> We need to send that information in any case.  It needs to be part of
> the matching done by the server to "recognize" a certain compound,
> because the same sequence of operations could have different meaning
> if the dependencies are different.

OK, if I have to send flags, that are only present if the fuse request
is inside a compound then I would suggest that we preface the fuse request
with a small compound header, where we store that information.

I would not want to change the fuse request, especially not define the same
flags for every type of fuse requests.

Would that be acceptable?

> 
> Thanks,
> Miklos
> 

Thanks,
Horst
