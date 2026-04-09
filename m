Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034E31D75E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761110; cv=none; b=f7zW6PJ0cQYCTdlxb++l1YLO/aXenQRCSFfajQ5eN/b00nYdEeAvrf1/xfFm+bqSmBnCfxxhXxBkDWKJHLGLG9z+Hy1BO5oTEF7ZzRBfDbPKjcJWNCV7AKcw71F32l9wDfUaVz+VdD/YvXq4OSUa/F2r8lq9NFUHy7cFZTwjKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761110; c=relaxed/simple;
	bh=tjtKsM6a8yIitonLoXJxoRPAtTxc8c3GOpyjQTNKUDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZQocmblplsOd39MqrYGYMoya1+/GDcGwViTEpblsCYG317Pxj2VGmJzoKJbE+hDhHgn7Vtz+Jx17+ZMRUR2A3TZmd20LT6KAqmREfDJaoE2XhFkH+OHvMvkBFMVfIXDTBkYhBgwER0PK7R2dyEl73Ph+lx9alI+jfdZr+SK0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q/Lz8dX7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q/Lz8dX7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W+0p8fXOFYKbX5mKdQ3Z/0hkjMrbNvDzmtxn7rjtNoY=; b=q/Lz8dX72KkGEtZC4dLt9xlVB7
	Umh9VKUaR+FT8QlJRbPToJo7sWJBi7+I6Fzo+fWIZq2p8HgsItI1GFUDxjn/wyyHN6IPh4AjM1pab
	M8N33ZK70ynvLd1fg/wAISELcWYu9Acz/Y3ea3T1wbEZ9JObXF2UdviyA7ONg7UicHEgvounE/ueU
	QrinjbxZFGSbd2BUhNAtmZmhrf5HZ84hq+KWWYPRPfEWCo/aaaNNSYzLz1z2dcdbQld6ZCOJec/jQ
	6qgkNV8C5du5TKoPX50iGyyYdwPwUaC1cRVfmwYwFOv1skyoEcV+yxjPuc2u0MNAn8g/P2sl9u8Pp
	opreJcTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAudp-000000043Fn-0IJO;
	Thu, 09 Apr 2026 19:02:13 +0000
Date: Thu, 9 Apr 2026 20:02:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v3 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
Message-ID: <20260409190213.GQ3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 09, 2026 at 12:51:38PM -0400, Jeff Layton wrote:

> I can also confirm that this fixes the livelock we were seeing as a
> precursor to this UAF [1]. I'm still not 100% sure how that livelock
> leads to a UAF. Claude thinks is has to do with the livelock making the
> loop outlive an RCU grace period.

Claude is full of substance likely to cause CoC complaints when mentioned,
film at 11.  I agree with the "livelock opens up some window" part,
what with the stack traces there, but I very much doubt that mechanism
has anything to do with the stuff on a shrink list staying around from
one iteration to another.  The thing is, *nothing* is held between the
iterations of loop in there; data.dispose is empty at the end of the loop
body in all cases and reference in data.victim is not retained either
across the iterations either.  We do have a weird RCU use pattern there,
all right (unbalanced acquire in select_collect2() paired with drop in
the caller of caller of select_collect2()), but the scope is neither
long nor extended by the livelock - in that case the function between
shrink_dentry_tree() and select_collect2() (d_walk()) is told to drop
the locks and return to its caller immediately.

What I suspect might be getting opened up is the possibility
of d_invalidate() (e.g. from pathname resolution trying
to walk into /proc/<pid>/...) hitting in the middle of
proc_invalidate_siblings_dcache().

Incidentally, one thing to check would be whether anything on affected
boxen had things mounted under /proc/<pid>/... - that would give
some idea whether detach_mounts() (and namespace_unlock() with its
handling of the list of mountpoints) might be needed in the mix.

> I did eventually find a vmcore and was able to confirm some things:
> 
> - in the freed/reallocated dentry, most of the fields are clobbered,
> but the d_lru list pointers seemed to be intact. That tells me that the
> sucker was added to the shrink list after being freed and reallocated.
> That means that the WARN_ON_ONCE() wouldn't have caught this anyway.
> 
> - there was some list corruption too: it looked like there were two
> different (on-stack) list heads in the list. There were also some
> dentries in there that were outside the shrin

?
 
> Note that this was an older (v6.13-based) kernel though, and it's
> possible there are other unfixed bugs in here.
> 
> I'm currently trying to reproduce the UAF using that mdelay() based
> fault injection patch on something closer to mainline.
