Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1840DFA1
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868463; cv=none; b=iceMvbKrsB8KuWK2Zya7RL4X7NrciAQxwj6o7ya+Abq8MA12TjLTRe1CmYvUfBpoyZ0MCJOBydk1IkiFY6kPKMPcCieDfQlDWNPAVeB05S5EbozwS7fM6GlfSz6zvfqcIMPyaONpN22oZeSG8V0g/gGO1cu8L+CXmTc0gJ1bisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868463; c=relaxed/simple;
	bh=GjUA1w4uy+gJaHsD5UtzxhvUZSEiijs9oqNYb4aAHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Miq6h4peRM1L+uziThxNaPY90UTaNkR3Elp6zy38vwwP+ywgmDBZ5TDrDDuyTaTX+RjX+TJSxfKY1iwOQLKLz+DlMKA6+W0/yg7q80VfSVZXAoTU782UKfnXBbnbM2PZ1gzsrJeVhrJ5xyEc5uqOGgWEq+ps0Lgk6AFDP58so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WadT0o+s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WadT0o+s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HGSc/FpeQlKx0OfBbWoN1HFGfC+ie72LFhc28NitwGU=; b=WadT0o+s+z0wrvGKAeuw4pRBBl
	qGXL274XAMfh/qQNZVV1Qf5nxjhzLXuYvNPIKQcsoQWEnqkDa/l13teTycqJPYt2KMXELZKloGSIg
	wuV+vB6/b7mHuQN4N6Pokk4o5p4hkdRQJzdJPMqQBuFPHk2rSQTIajHrr3OB8lC4nU0JZikwDFukQ
	E1+Arsr0+4EqUA605Z9lacNpRQbKJUt150Hsurkzru8R2hgJtohvS1YTUFetwwdNMDRDIeK6LBxTZ
	6j/2gAQk8iJimJU45F9GZSHqs0ZZANYi7ywPfTQodw7U0FiVKAJL7AIIBrfN670YrIrDlBvINWdvx
	hO6Yc8xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBMZK-000000083Jn-1LLq;
	Sat, 11 Apr 2026 00:51:26 +0000
Date: Sat, 11 Apr 2026 01:51:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <20260411005126.GA3836593@ZenIV>
References: <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
 <20260410212403.GY3836593@ZenIV>
 <adl2dMjN2hmVvORh@mozart.vkv.me>
 <20260410230553.GZ3836593@ZenIV>
 <admIGCR-xGfKgIQ-@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <admIGCR-xGfKgIQ-@mozart.vkv.me>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 04:30:32PM -0700, Calvin Owens wrote:

> Yes exactly, I was trying a lot of different pathological behaviors and
> that was the first pattern I found that triggered the d_walk() spin
> consistently.
> 
> Initially I made the reproducer ignore itself in /proc. But it turns out
> to be much more reliable if it *doesn't*. I realized it was opening its
> own children's files in /proc/*/fd/*, and the children were also opening
> other /proc files, which is what made me suspect the magic symlinks.
> 
> > IOW, you are opening a random mix of files, both procfs and ones some processes
> > had opened, then exiting.  That triggers invalidation of your /proc/*, with
> > a _lot_ of shite that needs to be taken out.  It might be triggering a livelock
> > or a UAF somewhere in dcache or it might be something entirely different -
> > no idea at that point.  I'll look further into that, but I wouldn't be surprised
> > if it turns out to be entirely unrelated.  Would be easier to deal with if the
> > mix had been more predictable, but we have what we have...
> 
> I'm sure I can narrow down the reproducer more, I'll try a bit.

No need...  Just have parent and child share descriptor table, then let parent
wait for child and child do
	char buf[128], buf2[128];
	int fd = 0, n;
	do {
		n = fd;
		sprintf(buf, "/proc/self/fdinfo/%d", fd);
		fd = open(buf, 0);
	} while (fd >= 0);
	for (int i = 0; i <= n; i++) {
		sprintf(buf, "/proc/self/fd/%d", i);
		readlink(buf, buf2, sizeof(buf2));
	}
and that's it.

That's a nice demonstration of how nasty conditions can be arranged for
d_invalidate(); *plenty* of busy dentries in the tree (to the tune of
several millions), with some evictables scattered here and there.
If you get enough busy stuff to wade through until you find an eviction
candidate, you'll get select_collect() return D_WALK_QUIT as soon as you
get a single evictable sucker.  Of course, then you need to restart
the whole thing - with the same pile of busy ones to get through.  Repeat
for every single evictable left in there.

No memory corruption involved, just a fuckton of rescans ;-/
It *is* recoverable - you just need to flush caches hard enough and that'll
unwedge the sucker.

IMO that's a very convincing argument for not using shrink_dcache_parent()
in d_invalidate().

That goes back to 2.1.65 - very early in dcache history.  Back then (and
until about 2014, IIRC) it had been "try to evict the subtree, unhash
if they are all gone, fail otherwise"; these days it's worse, since
d_invalidate() is not allowed to fail.

"Rescan if we have found something and ran out of timeslice" is there since
2005 mingo's 116194f29f13 "[PATCH] sched: vfs: fix scheduling latencies in
prune_dcache() and select_parent()" - latency problems prior to that got
traded for this "rescan the same pile of busy stuff for each evictable"
pathological behaviour.

FWIW, it doesn't have to be on procfs - you can arrange for something similar
with fuse.

Joy...
