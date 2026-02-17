Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D512D0C7B;
	Tue, 17 Feb 2026 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313173; cv=none; b=O0exMIqooAW+JQWS/K5Yrb9xxTzZwjpw/loS5OtC06YucoREgS0KRmERb+OnyQtfl8dxy/qkgDvRLZPSjq3SJyx3Bm8Neqfz0BN6pmhFhz3kM1XByvuzj/DHkv3T+SzIwlR7xytJf4FTjXiHYmfnspkF0MKNl0dE2n/xT6kiZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313173; c=relaxed/simple;
	bh=YECGY6qz6BTUj4LMbm/Bc/JxzeLCd/SUG8MblRqkiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwgy11NkB4LdfBf2/aSyda6LpVnV4Ri6zYKonuuj6wURr8tnrbDtgPubQ71O/EhfMi28JbyLfkcZxTlSwTuF/nYXITZGh9yb8ljZIAyytvh+xcxFF47TyY3xX9vSakQHKUJ0oVBrEi9cmpAGKt0OWFKRBdxsxQIBEvuqa1ZPgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id AD5A5E0557;
	Tue, 17 Feb 2026 08:26:02 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 17 Feb 2026 08:26:02 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aZQXcVNAlpyy4LH1@fedora.fritz.box>
References: <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
 <aZC0WdZKA7ohRuHN@fedora>
 <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
 <CAJfpeguOWLd-WvYMU3oTYPTq_3ZXfdUEX6eD0+M6FNZYc-qw1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguOWLd-WvYMU3oTYPTq_3ZXfdUEX6eD0+M6FNZYc-qw1Q@mail.gmail.com>

On Mon, Feb 16, 2026 at 04:22:13PM +0100, Miklos Szeredi wrote:
> On Mon, 16 Feb 2026 at 12:43, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sat, 14 Feb 2026 at 18:51, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > > Which part would process those interdependencies?
> 
> Another interesting question is which entity is responsible for
> undoing a partial success?
> 
> E.g. if in a compound mknod succeeds while statx fails, then the
> creation needs to be undone.   Since this sort of partial failure
> should be rare, my feeling is that this should be done by the kernel
> to avoid adding complexity to all layers.
> 
> This could be a problem in a distributed fs, where the ephemeral
> object might cause side effects.  So in these cases the server needs
> to deal with partial failures for maximum correctness.

I completely agree, that the kernel has to handle this.
And I think that the implementation of the particular compound
(like the function fuse_open_and_getattr() in the current example
has to deal with this)
These are the cases where we cannot have an automatic decoding deal
with the error since we don't have the information and data of the 
actual semantics.

> 
> Thanks,
> Miklos
> 
