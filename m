Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59429405;
	Thu, 18 Jun 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816620; cv=none; b=UnhDkMKPvCYKLG7+vXcCcXcX3ieMuK3rAoI3w2mOObndUam7A/bcevZU09yrJQBxtUOJJ0981RsWciFB2Dn8j/XysXrCFe0Kx+oZ1y4qI2yM27pv6Xts++HSrqo0vE3A8dYfvRMWNi+Ywy1IKPpnZn+1awsWTkAy3W0UjDQBhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816620; c=relaxed/simple;
	bh=3NQTV1vkqGuPXs53MpL/+aIkXL5BmNXX1wCouCI4znw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOlPtWzS52Un1zBFo3+fnktbkvvTZ0k19BnwdQxHhFhagfFmRclsG04FMRDgI3RBJtwngzjQJLEjNv2DnceGihptmX334DymyHSCOK9YNZEzbRo2fG6dQDQd6bHUplb/TERSQkO9EA2esj5n5dre8Dw6Hq6bpJbsuEyNGgcvfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nTr+cq4r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nTr+cq4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7kaykU/SUK8zqAtQcfdwiAZFRbX1SmfkrnsKvjwH3Qs=; b=nTr+cq4rtRKBqs/fnIyAu1Wz15
	YiHe3dSWQSCCoXyDDIlqtarcUVNDETafDaagQP7DmwD9LACiSae521xt56NgzJtOjTEGyPDGBN1ET
	5zXQc7dfmV/huTDgW9+1iFKrFwWZPbcAtSLDj1VhEX68MM/Xfv80U/d9Vr6LMLmGmXn5C688YWB5j
	6ZAj1rRy4KdqIp9oI/duQDxbty90jY77EBRgsfgljph/pieySPO69ibKdW5BmrbVxwbMFSgJmxixZ
	mp8Ij6yRik5y+GcQCDN43/wsSYIDL/rGU8mK/gvSOB4wInKRWKPnekqRHhPpQ8xcWGd3EkLqBNT3g
	IFYWBBDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1waJtc-00000006onY-0qhQ;
	Thu, 18 Jun 2026 21:03:32 +0000
Date: Thu, 18 Jun 2026 22:03:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	syzbot <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: rt_spin_unlock order of operations [was: Re: [syzbot] [fs?]
 KASAN: slab-use-after-free Read in shrink_dcache_tree]
Message-ID: <20260618210332.GA2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618205953.GZ2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 18, 2026 at 09:59:53PM +0100, Al Viro wrote:

> > https://docs.kernel.org/next/RCU/whatisRCU.html guarantees that
> > spinlock APIs imply RCU, and
> > https://docs.kernel.org/locking/mutex-design.html says: "This is in
> > contrast with spin_unlock() [...], which APIs can be used to guarantee
> > that the memory is not touched by the lock implementation after
> > spin_unlock()/completion_done() releases the lock.".
> > Neither of these explicitly guarantees that the RCU read-side critical
> > section (and the protection against migration?) should still hold
> > while the lock is being dropped, but I think that would fit best with
> > the explicit guarantees?
> 
> I'm trying to recall if PREEMPT_RT had been enabled in the last round of
> UAF in that area back in early April...
> 
> As far as I'm concerned, we *do* need to keep RCU read-side critical area
> all the way until the end of spin_unlock(); it very well might be the
> only thing to prevent freeing the sucker under us.

FWIW, https://lore.kernel.org/all/6a3094e7.428ffe26.258b27.0171.GAE@google.com/
looks potentially related...
