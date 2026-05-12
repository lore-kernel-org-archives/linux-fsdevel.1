Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C7395AC3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581793; cv=none; b=QO4PKq1wG24mw1RI8g2XXQlsZpXkhzMplqvO+F1lFfIVV06xfFfatfKStcrkWqlh/o1Yfsg9N3rGFUOSH+4YTNjihsf8ddaVPVeokRsjtbjgwnX8LSlBH2uF4L3aw+LBJgUngGsWgY0NlSgqq4rDH5ZkLzFafHGoSbJ0vfSoH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581793; c=relaxed/simple;
	bh=rp6bG8E3xOg7ugAANrtrc1XMOQKpGXXs+CIJXJ2yZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDquJ+SWmsxHjlB8oO3EQcX/sbuyXuGDEQWGIAyEmmhp1oA49747QVwCuARZnqX9Z5+6x6efJYPtMd+LX5X0b6aGgtBv2p+oyLfs05+8BIp/ifkgVCrgdKck4Ujsr5/NuPJqSPxMWS9mFBHt+hR7l8aGyzIDSwZuSYwM6zt9Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (139-140-067-156.ip-addr.inexio.net [156.67.140.139])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 54E9BE0183;
	Tue, 12 May 2026 12:29:43 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 12 May 2026 12:29:42 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH] fuse: add fusex filesystem
Message-ID: <agL_Wt6GrgUW22LB@fedora.fritz.box>
References: <20260429102058.1362965-1-mszeredi@redhat.com>
 <afxK2HSiwY32KaWw@fedora>
 <CAJfpegvYM2bdAJJHaqydxRzyVPNwOU95-MS5F+YrnOkJR+6yNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvYM2bdAJJHaqydxRzyVPNwOU95-MS5F+YrnOkJR+6yNg@mail.gmail.com>

On Tue, May 12, 2026 at 10:11:16AM +0200, Miklos Szeredi wrote:
> On Thu, 7 May 2026 at 10:37, Horst Birthelmer <horst@birthelmer.de> wrote:
> 
> > Where do you see the biggest challenge for this. To me, it doesn't look impossible to add that,
> > but I'm sure I'm missing a lot in this context.
> 
> The biggest challenge I see is API design.  I'd really like to have a
> simple and consistent API for this.

OK, that is a valid goal, I guess.

I have tried to come up with a fusex 'module' that does all operations over
io-uring since it is a lot easier to just support one way of transport.

Then I have written a very primitive passthrough to test the user space
interface and I can get it to work with some small changes to the interface
mostly due to the small header space on the ring.

I have done this to check how fast I can have something workable with the 
new interface since I'm supposed to add compound commands.

Do you think it is worth pursuing further?

> 
> First task: need to document the current interface, which is long
> overdue.  Here's a start:
> 
> https://docs.google.com/document/d/1SInG6nc5dF-db3WtCqFOnRDCY1jRl5JQ0Toiryn2PRc/edit?usp=sharing
> 
> This needs refinement, i.e. try to document by cache type, how is the
> cache used, invalidated, etc.
> 
> Thanks,
> Miklos
