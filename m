Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801F30B51F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846165; cv=none; b=EfYgZBdPByb8HdWWVx5KQBuv0CeRhNknb56kDNuPsJfry1ewG0eMxwDgoQkv90cbl0DIXIc1dGcyEdKjw3lyIxU6bEDM+YkHvktmKcODY/HkvlmTsywTNgC5REnwYDNU1ZUYFqE5alQxLCZ0aVDSQJuPptMCpmi9ZGZc5F7cVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846165; c=relaxed/simple;
	bh=rfpCwHaIccjDe8cHLZbjYHYAs2twWtED0NhtonnmiBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYTyrCRAsuS3aGHDuo5p2YPKck+n0UWj7N8fzg1HSetBu+3xfOJNoSjy+2mncmJ/XzdmxVngfOMJF07auWuyynFcrNqgBxaMJmosgxR4NoxcgMFpHAt2MQaLUz0x0imzlhPdAZOQqwnMtED2SyWfEHgLZdAepLddN+uE9ivhSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiStht5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiStht5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E6C19421;
	Fri, 10 Apr 2026 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775846164;
	bh=rfpCwHaIccjDe8cHLZbjYHYAs2twWtED0NhtonnmiBo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CiStht5NiTG8dzTmMMLWo6KiwyidDrA+ub2+KubamRFG9LheRza8nAFcZU0bnKPap
	 eJ4uFbw42XqhKxYAHb92+LA1VMVKWJRvRVDH9OQR0i5+cdxx8eLktjVDHyFet7qTtd
	 48WCCeiUPyQK2x/Y47QwPrKqFrixoEoox3x8tNO2msuVyRB0zxl1Ihrr9t9gGYnSdW
	 v09IVW4FtoxjVYxpw5IqCTuVWkZSzemB/NHIAwN3cUUTKxFcYUGBM2sPIc6yjOcmoY
	 D+iJFnRzaxh9lZsqMZtOwm2KOWYTSJ3f4gpa+jHwxY5DV+cC9xcaHhHIPuIZssCudl
	 vad+/j/Yq1Vtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E010CE04B4; Fri, 10 Apr 2026 11:36:04 -0700 (PDT)
Date: Fri, 10 Apr 2026 11:36:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <76bc5f9a-3886-4d15-bfa6-0a299bc79b23@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <99127a4f-30bc-477f-9a84-83fa771589cc@paulmck-laptop>
 <7abf5ad83150dc51ac57e5b0c703ce9d2187dc94.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abf5ad83150dc51ac57e5b0c703ce9d2187dc94.camel@kernel.org>

On Fri, Apr 10, 2026 at 02:26:47PM -0400, Jeff Layton wrote:
> On Fri, 2026-04-10 at 10:32 -0700, Paul E. McKenney wrote:
> > On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> > > [ Adding RCU maintainers to the participants: see
> > > 
> > >   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/
> > > 
> > >  and the fairly long thread associated with it  for context ]
> > > 
> > > On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > 
> > > > [this may or may not be the source of UAFs caught by Jeff and by Helge]
> > > 
> > > Hmm.
> > > 
> > > I think this patch may indeed fix the problem, and I don't mind how it looks.
> > > 
> > > But while I think the patch looks fine, I am still quite unhappy about
> > > it if it matters - because we have very much documented that spinlocks
> > > in themselves are also RCU read locks:
> > > 
> > >         Note that anything that disables bottom halves, preemption,
> > >         or interrupts also enters an RCU read-side critical section.
> > >         Acquiring a spinlock also enters an RCU read-side critical
> > >         sections, even for spinlocks that do not disable preemption,
> > >         as is the case in kernels built with CONFIG_PREEMPT_RT=y.
> > >         Sleeplocks do *not* enter RCU read-side critical sections.
> > > 
> > > so *if* this makes a difference, I think it's actually implying that
> > > there's something wrong with our "rcu_read_unlock()" implementation,
> > > and that it doesn't nest properly.
> > > 
> > > Because our documentation also makes it very clear that this should
> > > all work as-is, and your patch should be a complete no-op. Just a few
> > > lines later in that core RCU doc, we have
> > > 
> > >         Note that RCU read-side critical sections may be nested and/or
> > >         overlapping.
> > > 
> > > so the order of the spin_unlock() and the rcu_read_unlock() *should*
> > > be entirely immaterial, and the order of unlocking simply shouldn't
> > > matter.
> > > 
> > > So it may indeed be that relying on the ordering of RCU read unlock
> > > matters for the case of explicit unlocks and the implicit unlocks by a
> > > spinlock, but that's not great.
> > > 
> > > Does the rcu_read_unlock() code perhaps only check the RCU count, not
> > > the atomicity count? That would explain it, and looking at
> > > __rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
> > > case (rcu_preempt_read_exit() seems to only check
> > > rcu_read_lock_nesting).
> > > 
> > > This is most likely dependent on kernel config options, and it may all
> > > be unavoidable becasue RCU might not even have a way to tell that it's
> > > still in a critical region without preemption counts etc.
> > > 
> > > But if it's unavoidable, we need to update the docs about this gotcha,
> > > and we need to have some tooling scan our existing code for this
> > > documentation change.
> > > 
> > > RCU people - what do you think?
> > 
> > Adding to Boqun's email:
> > 
> > The https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV URL
> > has preemption disabled (right, Jeff?)
> > 
> 
> Not as familiar with this part of the kernel, but I think that's
> correct:
> 
> # zgrep PREEMPT /proc/config.gz 
> CONFIG_PREEMPT_NONE_BUILD=y
> CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_LAZY is not set
> # CONFIG_PREEMPT_RT is not set
> # CONFIG_PREEMPT_DYNAMIC is not set
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Thank you, Jeff!

Yes that has preemption entirely disabled, so RCU readers do nothing but
disable and enable preemption.  Except that it is everywhere disabled,
so the order of the rcu_read_unlock() and the spin_unlock() should
not matter.  (Famous last words!)

							Thanx, Paul

> > , in which case rcu_read_lock()
> > is just preempt_disable() and rcu_read_unlock() is just preempt_enable().
> > All the spinlocks also disable and enable preemption, so if you have
> > something like this:
> > 
> > 	rcu_read_lock();
> > 	do_something();
> > 	spin_lock(...);
> > 	do_something_else();
> > 	rcu_read_unlock();
> > 	do_yet_another_thing();
> > 	spin_unlock(...);
> > 
> > Then there should not be any calls to schedule() between the initial
> > rcu_read_lock() and the final spin_unlock().  But this is just
> > preempt_disable() doing its job, not much to do with RCU.
> > 
> > And repeating Boqun's email:
> > 
> > Now if this is a preemptible kernel, things are more involved.
> > However, in this case we know that the kernel has been built with
> > CONFIG_PREEMPT_COUNT=y.  So rcu_read_unlock_special() can sample
> > preempt_count() and set preempt_bh_were_disabled is then true if either
> > preemption or softirq are disabled.  Then irqs_were_disabled is set if
> > interrupts were disabled on entry.  If either are set, the inner pair of
> > "if" statements set up to defer the end of the read-side critical section.
> > If this is important, which it might be, I will go through this in more
> > detail later.
> > 
> > Otherwise, the call to rcu_preempt_deferred_qs_irqrestore() at the end
> > of rcu_read_unlock_special() immediately ends the RCU read-side critical
> > section.
> > 
> > And more adding to Boqun's email:
> > 
> > Now, CONFIG_PREEMPT_RT=y is a special case, because "spinlocks"
> > are preemptible.  So __rt_spin_lock() and __rt_spin_trylock() both do
> > rcu_read_lock() and rt_spin_unlock() does rcu_read_unlock().  So that
> > should be covered via RCU nesting along with the rcu_read_unlock_special()
> > checks for disabled interrupts, softirq, and preemption.
> > 
> > And rcutorture tests random overlapping of RCU readers with all those
> > disabled regions.  But it might still be missing something.  And I
> > will add spinlocks to the mix in addition to the preemption disabling.
> > 
> > In the meantime, is there something more specific that I should be
> > looking at?
> > 
> > 						Thanx, Paul
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
