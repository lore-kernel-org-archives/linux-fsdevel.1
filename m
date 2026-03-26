Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF856472;
	Thu, 26 Mar 2026 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548116; cv=none; b=FLYDZIULTEZYr0vvHHWMz3DAZQb5aWOwFo9PrJzUkGe2ZW7J4iNUK4eUsUQ3BkllDyN+JT99CUI0ic6H2GbakGJCJ/46id9+oAtLzRgjz5K5VW5hiv/Ba31kskkDg8Dmk67b/Z9DqAjeu1NLEa0S3udtjB+4lZTMk+E/cFvHANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548116; c=relaxed/simple;
	bh=hK+86MFgRbvMlqUBpIQbALyzfb8yb+CoCBa5h/BZ7Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwu8N8ojbXfNYmqg9w3pExrQg/zkgezhR5gqoxERUCEoNXayzdACJntHXgkmPqmbMzzWlm29KtXlIg3kaMqGpBihdbRwuG3hFk7929T2fJfUuH9ymsaN5ff9OlYpm5Bl8L2m5mH2uOwX0FmooqAtAvKguC+pZXuKrh4EzTyO4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id A7754E0068;
	Thu, 26 Mar 2026 18:54:20 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 26 Mar 2026 18:54:19 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH] fuse: fix inode initialization race
Message-ID: <acVxb0TSSUgHsK5T@fedora>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
 <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
 <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora>
 <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>

On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
> On Thu, Mar 26, 2026 at 8:48 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> > > On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
> > > >
> > > >
> > > >
> > > > On 3/26/26 15:26, Christian Brauner wrote:
> > > > > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> > > > >>
> > > > >>
> > > > >> On 3/18/26 14:43, Horst Birthelmer wrote:
> > > > >>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> > >
> > > > >>>     fi->attr_version = atomic64_inc_return(&fc->attr_version);
> > > > >>> +   wake_up_all(&fc->attr_version_waitq);
> > > > >>>     fi->i_time = attr_valid;
> > > >
> > > >
> > > > While I'm looking at this again, wouldn't it make sense to make this
> > > > conditional? Because we wake this queue on every attr change for every
> > > > inode. And the conditional in fuse_iget() based on I_NEW?
> > >
> > > Right, should only wake if fi->attr_version old value was zero.
> > >
> > > BTW I have a hunch that there are better solutions, but it's simple
> > > enough as a stopgap measure.
> >
> > OK, I'll send a new version.
> >
> > Just out of curiosity, what would be a better solution?
> 
> I'm probably missing something here but why can't we just call the
> 
>         fi = get_fuse_inode(inode);
>         spin_lock(&fi->lock);
>         fi->nlookup++;
>         spin_unlock(&fi->lock);
>         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
>                                  evict_ctr);
> 
> logic before releasing the inode lock (the unlock_new_inode() call) in
> fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
> fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
> after the attributes initialization has finished.
> 
> As I understand it, fuse_change_attributes_i() would be pretty
> straightforward / fast for I_NEW inodes, as it doesn't send any
> synchronous requests and for the I_NEW case the
> invalidate_inode_pages2() and truncate_pagecache() calls would get
> skipped. (truncate_pagecache() getting skipped because inode->i_size
> is already attr->size from fuse_init_inode(), so "oldsize !=
> attr->size" is never true; and invalidate_inode_pages2() getting
> skipped because "oldsize != attr->size" is never true and "if
> (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
> fuse_init_inode() initialized the inode's mtime to attr->mtime).

You understand the pretty well, I think.
The problem I have there is that fuse_change_attributes_i() takes
its own lock.
That would be a pretty big operation to split that function.

Is that required for this small (as Miklos put it, rare) case?

If you guys want me to do that, I will.

Thanks,
Horst
