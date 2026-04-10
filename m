Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233706FBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846940; cv=none; b=S7OIvBgONu8ngxzyI+jYegCkfpMdve4PruH/Z96PWXl7SKvdaZdUsn84GDi0JSI4Rmbs5wH24Ai7K9HHUWacjubNlkrYWxS+b22LgZdsYaVGEDzHMCLv7rQ5KR5URcwrxCtnIZslBYR7iQVppLcCUQlNejQTdaGuDdJEBl/xlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846940; c=relaxed/simple;
	bh=GkYuxB04ku2Vml7cKEXxtwc9/mGeLPmahRzLewP+mCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsKe1fFD2OWQj4pmvRO2mdVfgGOJ6D8KudCjWRXP6nu0O7rnO2B4aKWOsEUzx7yhmzk2e3+A7GwpmSMuZrgpUd1VP37cAx2ESzoP9hefLT5qLwULq69GSpWcDN/EyfYEHOiSqKKsB4g9R62baCZyk99ZKv/iOLynQOgKctaiXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wiPXN4LM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wiPXN4LM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/sFb0Dk3PalF7do8kdaNDr/Fr039OLBsE1tS1MbawFQ=; b=wiPXN4LMNU3G5DFjxXrGYtu/jW
	k/E1J9uR9inbg9+xOOJZ4Q2e7bSvWPDN+VdGwTxo4il76JtIHkgDaqdgvuK9nr+XwvOtbJIDQB9sM
	xn7JFqfIcuGq9hVj1VRQoIlI8sM/tEtomtEfvXgvbozpyCzdz5D/c4UrNk9E/gSwI7Lsm845gr98d
	/KgyTJgXmN3/Vd7C1Gq40wkH7qaHfCsQZO81urtTpEEMnVjD0UNEYFmfEYeLFUp8RK7rl2pBklFtT
	iisv90th04dMb3wiK7DjTEBh3EGD0xkIfmZkHi+JpFtyHbA6NN7qLziUYw0ELj/69QZvSb6ajjhVP
	T339Zi2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBGyB-00000007QOc-3Mgi;
	Fri, 10 Apr 2026 18:52:43 +0000
Date: Fri, 10 Apr 2026 19:52:43 +0100
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
Message-ID: <20260410185243.GU3836593@ZenIV>
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
Sender: Al Viro <viro@ftp.linux.org.uk>

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

FWIW, I wonder if we would be better off with the following:

void shrink_dentry_list(struct list_head *list)
{
	while (!list_empty(list)) {
		struct dentry *dentry;
 
		dentry = list_entry(list->prev, struct dentry, d_lru);
		spin_lock(&dentry->d_lock);
		d_shrink_del(dentry);
		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
			// killed while on shrink list, freeing left to us
			spin_unlock(&dentry->d_lock);
			dentry_free(dentry);
			continue;
		}
		rcu_read_lock();
		if (!lock_for_kill(dentry)) {
			spin_unlock(&dentry->d_lock);
			rcu_read_unlock();
			continue;
		}
		shrink_kill(dentry);
	}
}

because in that case both callers of shrink_kill() have the same form - the
other one is
			if (!lock_for_kill(v)) {
				spin_unlock(&v->d_lock);
				rcu_read_unlock();
			} else {
				shrink_kill(v);
			}
and we could fold lock_for_kill() into shrink_kill(), with a nice series of
cleanups becoming possible after that, especially if we can rely upon
spinlock acting as RCU read-side critical in all cases...

Interesting...
