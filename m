Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292003A0E85
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853886; cv=none; b=g2/B4lHTY7EKE4EIytrJo9ne2/S80tm6oL02fled7LmMApH2oTbBn2xPvy9FtLx8rdysGcVWi92vGRczHgBBlKHsKKIm4JxOEW9+3/KNCDExfVJTJCnahsy36GdQszr1HRTCT4SvC2YPvnkJ5K9mmyZYzTagMC7zV/bjtHnUWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853886; c=relaxed/simple;
	bh=0p3Ko31bzwfSNyNGrLXP268oNSNwrA3v6cliRlfs/uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJiSJkhXy2O1zJk0e0GG1jqOHDm+wrbKjKi+UKs2rVGgJ39fttWN6xkZcHOfNN4h+buW6jdHCnObW0MPWSgODU5bQbLKwVtsbQ2OLfhi9HQ3l7rw4gJT0ZK0nIu5t9Dkf9WSqtjgbw5Ly/zkcrGLvmC0O/yaSfBbeNWedPRQTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QyDGem6h; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QyDGem6h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=irQCmteu/BYcOw+eIAq8CUup6WOGMZxDZW8YMrec950=; b=QyDGem6hORbgsZkXMjd7Qk1nD2
	J+paenGyaCIYBW4uCK33P+yfKGqrkwcfqF6BjcmREDxPJA9CAB26XXC3EPO/8+dN8S+x6jnHKhrXB
	5Z2cFRxGzkNzFqdeXswOyC5WW6KG+eocVkdcvTUISp7HBl8TCVB17v+n/UIDql0K3SL8FEuQFEXzy
	cnva+4U4PB1YHGdGbxcNC2UW9o4A/4fmUWqSrhnTVdWwyozCua8nvmWAhAYNk14iyLpzzFT5Jfx+O
	of0LAQlBarohwYe9z5flxC/+wIOWW7rdQdgIWrfIsEiRwtCvyiNYm3W1Egm5uIwto/By3vGJq4LqR
	htNWwOBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBImD-00000007cT9-36PB;
	Fri, 10 Apr 2026 20:48:29 +0000
Date: Fri, 10 Apr 2026 21:48:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <20260410204829.GX3836593@ZenIV>
References: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <20260410185243.GU3836593@ZenIV>
 <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
 <20260410202404.GW3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410202404.GW3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 09:24:04PM +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 12:30:13PM -0700, Linus Torvalds wrote:
> 
> > The reason it exists is because lock_for_kill() can drop d_lock(), but
> > that's in the unlikely case that we cn't just immediately get the
> > inode lock.
> > 
> > So honestly, I think that rcu_read_lock() should be inside
> > lock_for_kill(), rather than in the caller as a "just in case things
> > go down".
> 
> Yup, in the cascade of followups I've mentioned...
> 
> > IOW, that code basically now not only does that typically unnecessary
> > rcu locking (and then unlocking), it does so *because* it knows about
> > the subtle internal behavior of lock_for_kill().
> > 
> > In contrast, if we put it inside lock_for_kill(), all we need is a
> > fairly straightforward comment along the lines of
> > 
> >   "we're dropping the spinlock in order to take the inode lock, but
> > the caller may be depending on RCU behavior so we need to take the rcu
> > read lock first".
> > 
> >  that would turn strange illogical code that also generates worse code
> > into straightforwardly explained code that also performs better.
> > 
> > Ok, so "performs better" is kind of exaggerated, in that obviously the
> > extra rcu_read_lock/unlock sequences aren't exactly expensive, but
> > still - I feel it's a win-win to just do this differently.
> > 
> > Or am I missing somethign else?
> 
> Mostly that fast_dput() calling conventions would need to change a bit
> as well.
> 
> With the above as step 1,
[snip]

FWIW, I would really like to figure out what the hell is going on with
those UAF; livelock elimination (which is clearly needed as well -
there's an easy way to turn that livelock into hard lock reliably eating
a CPU on an SMP box) is likely to hide whatever the bug is.  And it
does look like RCU bugs are not the cause of what Jeff is occasionally
seeing - not with their config.  So there's something else going on ;-/
Jeff's reports are 6.11--6.13; Helge's parisc ones are 6.16--6.19.
If they are using the stock debian parisc kernel, it's PREEMPT_NONE
config (AFAICS) and in that case RCU is not the cause there as well...

Back to trying to put together a proof of correctness and see where
it breaks ;-/  If nothing else, that should give a set of assertion
checks to try and slap on top of the kernels involved...
