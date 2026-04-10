Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00089288AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848914; cv=none; b=GGAvT+ca3XR1dXHLFfL65558qaVjfCzmIgxCZtyGH4j04J5AchUbJu2nN2EmHQ1ANkTfUZR3iqcQsbDhICCZQuu0QleH9shTYrJlLahzubisGsyTYUC1MyLnR9H+oYilWfG716zMsm+plAnLebxG7sjjwdab4rp8rEXeXGynY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848914; c=relaxed/simple;
	bh=5vGr9oQtA8IpUOo77wt7fh8H0zOR2OzxrdC2fZgVaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMFNU4VjP40qXehp//EdQmwgeKb/+Xb4ls6vB3qny5CoGdHT3Cqzrc939nUQTK7lQTI+6AE8fIaXvABrLz3OgHWqixD3GsG/3aFWp2sfxLjWz9ZGIEne8VhKGH8n+6kyaEtnzeeKzp7Jpqq+nRz7u5TCMzi3XdCIWwZ1HflawzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGQDTy/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGQDTy/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF019C19421;
	Fri, 10 Apr 2026 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775848913;
	bh=5vGr9oQtA8IpUOo77wt7fh8H0zOR2OzxrdC2fZgVaYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LGQDTy/NQydSmPkmFH/zs/MHb8UJtRW0R3mzYDJAijZ/QsJOQHgZvDqEkd2wun7Xa
	 14WNyiSomxBja2+xsT21KQAIhQjIkHW+6Zvy9JhiQIjTk2Jb5TwUw3/t8YAuUCt6Wo
	 KjQyxj27DHCDz8HJ+OfWBcPzPXLSBJoKDboTs36ostnWkbU2Rn0bI/X8oqsXdhwWQy
	 /OpFhZaG9P/dCZdCDe6wG9mhB2Ip9A7DR31qCiyD1rMoU+zUCRWJInmv/hBfyCn8WA
	 XOPEPsIycyEftBHEp8dchtvdRH7SIGZpkzcCG6GQyJWWFKkNllUZFuKaraH1vH6SfM
	 DMZYMMAp/zQ9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69553CE04B4; Fri, 10 Apr 2026 12:21:53 -0700 (PDT)
Date: Fri, 10 Apr 2026 12:21:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <4e59837d-567b-4678-8a15-e933def32fcb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <20260410185243.GU3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410185243.GU3836593@ZenIV>

On Fri, Apr 10, 2026 at 07:52:43PM +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> > [ Adding RCU maintainers to the participants: see
> > 
> >   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/
> > 
> >  and the fairly long thread associated with it  for context ]
> > 
> > On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > [this may or may not be the source of UAFs caught by Jeff and by Helge]
> > 
> > Hmm.
> > 
> > I think this patch may indeed fix the problem, and I don't mind how it looks.
> > 
> > But while I think the patch looks fine, I am still quite unhappy about
> > it if it matters - because we have very much documented that spinlocks
> > in themselves are also RCU read locks:
> > 
> >         Note that anything that disables bottom halves, preemption,
> >         or interrupts also enters an RCU read-side critical section.
> >         Acquiring a spinlock also enters an RCU read-side critical
> >         sections, even for spinlocks that do not disable preemption,
> >         as is the case in kernels built with CONFIG_PREEMPT_RT=y.
> >         Sleeplocks do *not* enter RCU read-side critical sections.
> > 
> > so *if* this makes a difference, I think it's actually implying that
> > there's something wrong with our "rcu_read_unlock()" implementation,
> > and that it doesn't nest properly.
> > 
> > Because our documentation also makes it very clear that this should
> > all work as-is, and your patch should be a complete no-op. Just a few
> > lines later in that core RCU doc, we have
> > 
> >         Note that RCU read-side critical sections may be nested and/or
> >         overlapping.
> > 
> > so the order of the spin_unlock() and the rcu_read_unlock() *should*
> > be entirely immaterial, and the order of unlocking simply shouldn't
> > matter.
> > 
> > So it may indeed be that relying on the ordering of RCU read unlock
> > matters for the case of explicit unlocks and the implicit unlocks by a
> > spinlock, but that's not great.
> > 
> > Does the rcu_read_unlock() code perhaps only check the RCU count, not
> > the atomicity count? That would explain it, and looking at
> > __rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
> > case (rcu_preempt_read_exit() seems to only check
> > rcu_read_lock_nesting).
> > 
> > This is most likely dependent on kernel config options, and it may all
> > be unavoidable becasue RCU might not even have a way to tell that it's
> > still in a critical region without preemption counts etc.
> > 
> > But if it's unavoidable, we need to update the docs about this gotcha,
> > and we need to have some tooling scan our existing code for this
> > documentation change.
> > 
> > RCU people - what do you think?
> 
> FWIW, I wonder if we would be better off with the following:
> 
> void shrink_dentry_list(struct list_head *list)
> {
> 	while (!list_empty(list)) {
> 		struct dentry *dentry;
>  
> 		dentry = list_entry(list->prev, struct dentry, d_lru);
> 		spin_lock(&dentry->d_lock);
> 		d_shrink_del(dentry);
> 		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
> 			// killed while on shrink list, freeing left to us
> 			spin_unlock(&dentry->d_lock);
> 			dentry_free(dentry);
> 			continue;
> 		}
> 		rcu_read_lock();
> 		if (!lock_for_kill(dentry)) {
> 			spin_unlock(&dentry->d_lock);
> 			rcu_read_unlock();
> 			continue;
> 		}
> 		shrink_kill(dentry);
> 	}
> }
> 
> because in that case both callers of shrink_kill() have the same form - the
> other one is
> 			if (!lock_for_kill(v)) {
> 				spin_unlock(&v->d_lock);
> 				rcu_read_unlock();
> 			} else {
> 				shrink_kill(v);
> 			}
> and we could fold lock_for_kill() into shrink_kill(), with a nice series of
> cleanups becoming possible after that, especially if we can rely upon
> spinlock acting as RCU read-side critical in all cases...

If there is a case where a spinlock fails to act as an RCU read-side
critical section, then we have a bug that needs to be fixed.

							Thanx, Paul

> Interesting...
