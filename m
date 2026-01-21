Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C3364E91;
	Wed, 21 Jan 2026 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022775; cv=none; b=YZLmFiEBbcSG5jAWFeyrWkQ9u/5CqFhSErIpjOiJxp71Kz3SOJCUnVAg6DnnwVPPAGLxihYH3k0JAgdFWFPpsIcSKTQ/QxJDY3mqFAb1m2APxWQAzYwDtpC5ioNPcBUyKU62Q+uqJfUm3p/nmde1Dh48jOUfuUo1RrApyIiT4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022775; c=relaxed/simple;
	bh=qMOz+yEkA/rkjen0l+JehhX4t4nu9fAUE9DUzbDC2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuQGc8Pd7rEYg8pzvkAqLBQF2MyP155nhFJhP5YUGgBbiELq37ZpALB0kda6Szpyh74o4zNJgoWbyN7k2dg1WwL5Q54gd4qEEsxyTyaoyy0iow0cSbnMgQxHdvgxet1WJm06gF1DL/8LOlGphTxottBg2DTzZXDH4IrICL6diQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 1F304E0430;
	Wed, 21 Jan 2026 20:12:50 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 21 Jan 2026 20:12:49 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXEjX7MD4GzGRvdE@fedora>
References: <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
 <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
 <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
 <aXEhTi2-8DRZKb_I@fedora>
 <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>

On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/21/26 20:00, Horst Birthelmer wrote:
> > On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
> >>
> >>
> > ...
> >>> The problem Luis had was that he cannot construct the second request in the compound correctly
> >>> since he does not have all the in parameters to write complete request.
> >>
> >> What I mean is, the auto-handler of libfuse could complete requests of
> >> the 2nd compound request with those of the 1st request?
> >>
> > With a crazy bunch of flags, we could probably do it, yes.
> > It is way easier that the fuse server treats certain compounds
> > (combination of operations) as a single request and handles
> > those accordingly.
> 
> Hmm, isn't the problem that each fuse server then needs to know those
> common compound combinations? And that makes me wonder, what is the
> difference to an op code then?

I'm pretty sure we both have some examples and counter examples in mind.

Let's implement a couple of the suggested compounds and we will see 
if we can make generic rules. I'm not convinced yet, that we want to
have a generic implementation in libfuse.

The advantage to the 'add an opcode' for every combination 
(and there are already a couple of those) approach is that
you don't need more opcodes, so no changes to the kernel.
You need some code in the fuse server, though, which to me is
fine, since if you have atomic operations implemented there,
why not actually use them.

The big advantage is, choice.

There will be some examples (like the one from Luis)
where you don't actually have a generic choice,
or you create some convention, like you just had in mind.
(put the result of the first operation into the input
of the next ... or into some fields ... etc.)

> 
> 
> Thanks,
> Bernd

Horst
