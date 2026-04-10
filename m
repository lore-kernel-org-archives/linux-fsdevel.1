Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C463932DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842362; cv=none; b=DoAPJez8HY8nt3vkNcRLIbdsddPERPDi/15Nix+xWJCRdmMmWrz4y3UuTElJTApvIsoTE3VAb0rrWtQP7z33nu0HBESXhrscez1thoRHivLZAQbJ6eA9u9fNaaDU9ieANTFbMnj2yZzerjtC3lk+0yxSG2LaZrD1kpINSxgcq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842362; c=relaxed/simple;
	bh=mBx8E3ZncoPBSLiVT4kKu0b59Z3LiAvYVG6GVf7j7Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObzF4NQk7JeBVSm6rfXKfHRsGhCoTEF3FL1WZp4gEAOnrcFtetKbr78n3LVeIDW4+mlC6VXloEMZzxlKfLJJddAltjRkPURSsSa93DXoXzdC65UGX2PMjek/kh1QMH1Dvnxo/2cKufAI0y3IPwOtUCuLHM7XieB0ZtMf1T2iYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAhxZAvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAhxZAvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDFC19424;
	Fri, 10 Apr 2026 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775842362;
	bh=mBx8E3ZncoPBSLiVT4kKu0b59Z3LiAvYVG6GVf7j7Kc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jAhxZAvGy1B36XipFRiCb1VeH5N5D8ik7wOI5uHKgUkWsof+n0c/MLGFWH6C6OqCg
	 bwscE0KLl7JNG7NxBH8NIEyWDZVoTSoEr3F0htf1WXaz9mVkG0EfJnHIWtmu7w5cLm
	 ziYiK6cuAdFTxpB5V3fkrjw12yrVwrnN3GZnb/OHDIjSA+wEgi2HIgyaj31qlYf/No
	 XTrcMSYKSkg4I9WDURlDHG0TEw0QmiN3RgJg4Glb+/OlbWUd3RyqGtvZfGu3oWiJyd
	 DDMouo4ldwYd7HCZHQoRJHrkYbKM2/3b3DeNP9H6nEwnrRK9227nw/T7SwVRoIs9UG
	 wr1e3GDYuT4dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 155C0CE04B4; Fri, 10 Apr 2026 10:32:42 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:32:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <99127a4f-30bc-477f-9a84-83fa771589cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>

On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> [ Adding RCU maintainers to the participants: see
> 
>   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/
> 
>  and the fairly long thread associated with it  for context ]
> 
> On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [this may or may not be the source of UAFs caught by Jeff and by Helge]
> 
> Hmm.
> 
> I think this patch may indeed fix the problem, and I don't mind how it looks.
> 
> But while I think the patch looks fine, I am still quite unhappy about
> it if it matters - because we have very much documented that spinlocks
> in themselves are also RCU read locks:
> 
>         Note that anything that disables bottom halves, preemption,
>         or interrupts also enters an RCU read-side critical section.
>         Acquiring a spinlock also enters an RCU read-side critical
>         sections, even for spinlocks that do not disable preemption,
>         as is the case in kernels built with CONFIG_PREEMPT_RT=y.
>         Sleeplocks do *not* enter RCU read-side critical sections.
> 
> so *if* this makes a difference, I think it's actually implying that
> there's something wrong with our "rcu_read_unlock()" implementation,
> and that it doesn't nest properly.
> 
> Because our documentation also makes it very clear that this should
> all work as-is, and your patch should be a complete no-op. Just a few
> lines later in that core RCU doc, we have
> 
>         Note that RCU read-side critical sections may be nested and/or
>         overlapping.
> 
> so the order of the spin_unlock() and the rcu_read_unlock() *should*
> be entirely immaterial, and the order of unlocking simply shouldn't
> matter.
> 
> So it may indeed be that relying on the ordering of RCU read unlock
> matters for the case of explicit unlocks and the implicit unlocks by a
> spinlock, but that's not great.
> 
> Does the rcu_read_unlock() code perhaps only check the RCU count, not
> the atomicity count? That would explain it, and looking at
> __rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
> case (rcu_preempt_read_exit() seems to only check
> rcu_read_lock_nesting).
> 
> This is most likely dependent on kernel config options, and it may all
> be unavoidable becasue RCU might not even have a way to tell that it's
> still in a critical region without preemption counts etc.
> 
> But if it's unavoidable, we need to update the docs about this gotcha,
> and we need to have some tooling scan our existing code for this
> documentation change.
> 
> RCU people - what do you think?

Adding to Boqun's email:

The https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV URL
has preemption disabled (right, Jeff?), in which case rcu_read_lock()
is just preempt_disable() and rcu_read_unlock() is just preempt_enable().
All the spinlocks also disable and enable preemption, so if you have
something like this:

	rcu_read_lock();
	do_something();
	spin_lock(...);
	do_something_else();
	rcu_read_unlock();
	do_yet_another_thing();
	spin_unlock(...);

Then there should not be any calls to schedule() between the initial
rcu_read_lock() and the final spin_unlock().  But this is just
preempt_disable() doing its job, not much to do with RCU.

And repeating Boqun's email:

Now if this is a preemptible kernel, things are more involved.
However, in this case we know that the kernel has been built with
CONFIG_PREEMPT_COUNT=y.  So rcu_read_unlock_special() can sample
preempt_count() and set preempt_bh_were_disabled is then true if either
preemption or softirq are disabled.  Then irqs_were_disabled is set if
interrupts were disabled on entry.  If either are set, the inner pair of
"if" statements set up to defer the end of the read-side critical section.
If this is important, which it might be, I will go through this in more
detail later.

Otherwise, the call to rcu_preempt_deferred_qs_irqrestore() at the end
of rcu_read_unlock_special() immediately ends the RCU read-side critical
section.

And more adding to Boqun's email:

Now, CONFIG_PREEMPT_RT=y is a special case, because "spinlocks"
are preemptible.  So __rt_spin_lock() and __rt_spin_trylock() both do
rcu_read_lock() and rt_spin_unlock() does rcu_read_unlock().  So that
should be covered via RCU nesting along with the rcu_read_unlock_special()
checks for disabled interrupts, softirq, and preemption.

And rcutorture tests random overlapping of RCU readers with all those
disabled regions.  But it might still be missing something.  And I
will add spinlocks to the mix in addition to the preemption disabling.

In the meantime, is there something more specific that I should be
looking at?

						Thanx, Paul
