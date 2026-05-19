Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C849218A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189816; cv=none; b=neIqYnVtf+MtNt0jBXUauwmTz8K/HssyrsLlqz4+defrwFU5jdl5ILlDcZb8QN6WVkqSl+5BAcHSIXjCiofKvODDfQ0PjPTiQ80WfWH3ZoCuI3Ez6yHWC5BswEco0Y0YinJCM9r91b4EHUQZUTyfyek+IB5HHrNt10D9mCQwXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189816; c=relaxed/simple;
	bh=c1ar1buYPeMuF3rLas2crUZ0VKPNbCkEeEsxLJnOJFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxKNBa3ol9sRTiFlt+CAQAONGwqd4pWd04tnYE5TRkTQw6am+CGyAysFbeOocsq2jnAX6gBDJYWQRpJezQq0H/S9saOOjilVVHNf2ku/RVHtpQjXcwkZlazja1Xf0ne3L3LG2kpvTHHNVwzxTJxfBCZKbC6gQNEyQw3nynqgv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 66F7BE02B0;
	Tue, 19 May 2026 13:23:23 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 19 May 2026 13:23:22 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>
Subject: Re: Re: [post LSFMM summary] where is fuse going?
Message-ID: <agxHTG42CTAklfSj@fedora.fritz.box>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <20260512202336.GC9544@frogsfrogsfrogs>
 <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>

On Tue, May 19, 2026 at 11:01:18AM +0200, Miklos Szeredi wrote:
> On Tue, 12 May 2026 at 22:23, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > As for fuse-iomap I'm not sure how to proceed
> 
> I will try to dedicate this week to reviewing fuse-iomap, hopefully
> without too many distractions.
> 
> >  -- in the long run I think
> > it would be cleaner if each file IO path (virtiofs dax, passthrough,
> > writeback_cache, iomap, and whatever we call the original one) had its
> > own file_operations.  But that would require us to refactor the common
> > code chunks from each file operation function into a bunch of smaller
> > functions, which I think would sharply increase the review backlog.
> 
> And so the plan is rather to basically start from scratch and do that
> form the beginning in fusex code.

In a probably misguided effort I have tried to make fusex useful for
what I nned it to be, so that at least I can try to implement compounds
for it. My conclusion is pretty much the same. I'm in favor of extra
file operations for the different 'flavors'.

> 
> Thanks,
> Miklos

My $0.02

Horst
