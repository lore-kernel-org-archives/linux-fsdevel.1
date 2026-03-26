Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB361A0BD0;
	Thu, 26 Mar 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537023; cv=none; b=ZoPL0g9kD9PYU91sf42Kmwb6JMEWFLwnZmclRzZ6QGghurLHsnoFz01N0nRu4Ci9tDY4WaAHo5H38NL08Hz8ZZ24pWtzQJ8Xi3h3z62tt0nD4ReGkG9BAyAYHdDfD5u/aHktM5NXOC2pfEoCLRi7M9WoU86oapvXFQ9bRCpqwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537023; c=relaxed/simple;
	bh=d2x13RLN/oMC+wU/51SZmCZyLlSvvjmQRBk8pKaW5r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ9sHIHwpbRJxed+qEQ+F/uc/+MdirV/JXLOsbwwXy54e+UsXhJBSwq8rq2nTqBidrjMHAyQNNxsmc6teKufbeZNVoDzh5r8iD6ueqto5bs5JSM8fksNSnc28LuiHumnmHmZgZQQkPhnB6t9AdpWAYhFZ9OE9hsjY+TUipHqYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id AA306E00F0;
	Thu, 26 Mar 2026 15:56:58 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 26 Mar 2026 15:56:58 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH] fuse: fix inode initialization race
Message-ID: <acVIc0fXasKIptC8@fedora>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <CAJfpegu9hjgwmCtM3xF6rjhY6jSvLnH+8wkr6a++RMPNDUpgWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu9hjgwmCtM3xF6rjhY6jSvLnH+8wkr6a++RMPNDUpgWw@mail.gmail.com>

On Thu, Mar 26, 2026 at 03:51:18PM +0100, Miklos Szeredi wrote:
> On Wed, 18 Mar 2026 at 14:45, Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> > invalidation can arrive while an inode is being initialized, causing
> > the invalidation to be lost.
> >
> > Add a waitqueue to make fuse_reverse_inval_inode() wait when it
> > encounters an inode with attr_version == 0 (still initializing).
> > When fuse_change_attributes_common() completes initialization, it
> > wakes waiting threads.
> 
> This should be relatively rare, right?  In that case a single global
> waitq and wake_up_all() would be better, imo.

Well it depends on the use case. We send relatively many notifications
since they are bound to the DLM system and thus to changes done by a lot
of clients and so it happens that you get an invalidation while still
creating the inode.

What is wrong with one per connection?

> 
> Thanks,
> Miklos
