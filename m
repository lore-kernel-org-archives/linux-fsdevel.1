Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006339659E;
	Tue, 19 May 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183471; cv=none; b=M5ux6XujWczk1sQS2Zt6ghZ2Tu3jili4suy0Qd4wWqesAmDq7j3c1qL1vKCHviIaumGEXMPFd+WF3rMSGhIyqitEUYj8EPgRSbU2aMBRfl2jW7e+XrrkxLivYJPK5vsxMsg/Ho7tRSOSa/fuCAn4tLP9o/u6CobsenYGW4Swc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183471; c=relaxed/simple;
	bh=qjJbhwbpB2r3eqeVSLWwgsDFXxcY2IZQt64WACn8mCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls6uvJPAVabjnBinZn+3GQGjhXmszKXyiJTdbzW3pSlOk+Y8Uiswof/BbkRqw7807HmBdxODhffvw5sPspJd0iZy9kneivxBwHmsOqiGx8abi/SfNXt84nokwxEacc6Aodlt+CwjXZzw5oBN8tELb4L2lVOSRtnvvqXj4hP7Vtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 606E4E0A2D;
	Tue, 19 May 2026 11:37:39 +0200 (CEST)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 19 May 2026 11:37:38 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <agwpRu1CWU4X0ytf@fedora.fritz.box>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
 <agj5JkPZ7eNbFueR@casper.infradead.org>
 <aglh7SrXWbYgD3nA@fedora.fritz.box>
 <mptmd2qxgqwkhfrq5dgwomysdnwoy6fnztr3ibrvbbsb7hvrv3@peg7mojzfucy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mptmd2qxgqwkhfrq5dgwomysdnwoy6fnztr3ibrvbbsb7hvrv3@peg7mojzfucy>

On Tue, May 19, 2026 at 10:45:09AM +0200, Jan Kara wrote:
> Hi Horst!
> 
> On Sun 17-05-26 09:57:41, Horst Birthelmer wrote:
> > On Sun, May 17, 2026 at 12:09:26AM +0100, Matthew Wilcox wrote:
> > > On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> > > > There was a discussion at LSFMM about servers with too many cached
> > > > negative dentries.
> > > > That gave me the idea to keep the dentries in general limited
> > > > if the system administrator needs it to.
> > > 
> > > I feel you should link to the dozens of previous attempts at this kind
> > > of thing to show that you're aware that this has been tried before and
> > > you're doing something meaningfully different.
> 
> <snip>
> 
> > As a conclusion, I think I have an uncommon perspective on the cache entries
> > since I don't usually work on vfs but argue from the perspective of a fuse server
> > Where the kernel makes us waste resources. This hurts way more in the FUSE context
> > than in a 'normal' file system.
> > I have taken the look at the dentry cache just because people told me that this
> > has to be solved in the vfs (and I agree). I actually have a somewhat hacky patch
> > to do this from fuse and only for the fuse sb.
> 
> So I'm a bit confused here. The changelog speaks only about negative
> dentries (and that's what the change also concentrates on). OTOH you've
> mentioned multiple times that you are not really interested in limiting
> negative dentries but rather positive ones because you have a problem with
> cached inodes. So can you perhaps formulate what is exactly the problem
> you're trying to solve?

Maybe the changelog was a bit misleading here.
I did of course prefer negative entries, since that could bring down the 
number of cached entries. In retrospect that was probably a mistake but I 
was somewhat afraid if I don't reduce those, too, someone would shurely
point out that it would be easier to cut those, since they are not really
used anyway, and would be cheap to free.

This was only to be more useful than just solving _my_ problem. Maybe not
a good approach, I don't know yet.

> 
> Also you mention that cached (positive) dentries and inodes are a wasted
> memory when they aren't used. That is certainly a valid view, OTOH you can
> never predict future so you don't really know what will get used in the
> future and thus will be useful. That's why we currently side with the idea
> that memory that isn't used for something is wasted and unless there's
> something to use the memory for, we cache dentries & inodes & page cache in
> it.
> 
> If I remember correctly the discussion we had at LSF, the problem why inode
> caching is a problem for you, although there's enough free memory and no
> memory pressure, is that these cached inodes pin memory on the other end of
> the FUSE communication channel and there we are getting short on memory. Is
> this what you're trying to solve?

You remember our conversation correctly and have masterfully summerized it in 
the passage above. Yes, that is what I'm trying to solve.

The problem we are facing is, that the fuse server has to keep a lot of private
data and some data for locks (DLM) for the cached inodes and dentries.
(inodes are even more expensive due to byte range locking)

So my idea was to NOT keep unused (and negative) entries around.
Letting the admin set the limit where the kernel starts to clean, was just
for convenience. If it was up to me I would like to set this in the initial
negotiation in FUSE during mount.

The waste of memory for me is not in the kernel but in the fuse server. The
kernel is just the master of what we have to keep, and thus the kernel moved
to the center of attention.

In short:
all caching in the kernel hurts us since we have to keep our private data
for all positive dentries, and I want to get the most for the amount pain.

OTOH caching meta data is really useful but you have to have a good prediction
on what to keep. As we cannot predict that on either side of the kernel,
throwing away the unused parts when they get out of hand seemed like a good idea.

After the discussions here it seems like everybody has his own interpretation on
what useful data to cache is.
I'm really inclined to think about letting the lower layers decide what useful
cached data should be.

In this context probably a fuse server message as a notification for which data
it thinks can be thrown out, similar to the FORGET call but in the other direction
and if the kernel agrees it really sends a FORGET and we can clean up on the other
side.

> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks a lot for looking at this,
I really appreciate it!
... and I hope I could clarify, what I was trying to do.

Horst
