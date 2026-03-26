Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC21A683B;
	Thu, 26 Mar 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539955; cv=none; b=c4UGj/PMvcuDHnouNsDqpLNRaGjxRtFuiJBN6/ZNqwfr5oDNOhyIWSocXVp/kZXlXaOp84YXcFGWpdhFJbbHYD3aQC+TiotC0+ncrzune9u4fC2TdsoXYj2QZQhyw7MmEAqKaUsVXa47RrdWX2VdhxSgNp1qDzUOVuqS+JoFMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539955; c=relaxed/simple;
	bh=jkyAvIUs4NLagD+o1pV9/gpfEx5eKG3Y0zImm8ZbYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0KdBNXh/7Ek6hQJXjnil8ijbC7CV80YQ5JRv3JYQvkvRb0tTq1uJ5cQYa/21gnPaws7wrO8LBhAz0l6HZh2P68e/gvmuUGd2CQLBw50Up7TvgHTe9iGCmVVGLYxKEqfkvM6Dtc+kkTMwoIWGhLg+wpE2l8hklYKfv0SUz3CbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id E54D1E03CB;
	Thu, 26 Mar 2026 16:45:51 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 26 Mar 2026 16:45:51 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH] fuse: fix inode initialization race
Message-ID: <acVUeX54PDFfApI2@fedora>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
 <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
 <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>

On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> >
> >
> > On 3/26/26 15:26, Christian Brauner wrote:
> > > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> > >>
> > >>
> > >> On 3/18/26 14:43, Horst Birthelmer wrote:
> > >>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> 
> > >>>     fi->attr_version = atomic64_inc_return(&fc->attr_version);
> > >>> +   wake_up_all(&fc->attr_version_waitq);
> > >>>     fi->i_time = attr_valid;
> >
> >
> > While I'm looking at this again, wouldn't it make sense to make this
> > conditional? Because we wake this queue on every attr change for every
> > inode. And the conditional in fuse_iget() based on I_NEW?
> 
> Right, should only wake if fi->attr_version old value was zero.
> 
> BTW I have a hunch that there are better solutions, but it's simple
> enough as a stopgap measure.

OK, I'll send a new version.

Just out of curiosity, what would be a better solution?

> 
> Thanks,
> Miklos

Thanks,
Horst
