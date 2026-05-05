Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D830DECE
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017247; cv=none; b=JXd+BDogv/QVuCwwdP0d2EfQOsfFO9nHZcsSdtIoBxUaDpPOtpXI93nQw1xdVDQJcUf0L5+LmN6HfGAQq7T74cnpbBDb4M5QFGfUVg3AZFMZF/z5gYb0Jm3Wvdbzrna5f/QyDQjgML+pn4vCRpaNbEBICGVZLmoxQ5eVQoG2VyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017247; c=relaxed/simple;
	bh=XHGhTsSXAxX2gpK0Tt63tJG+t1j0ddwA4q9CQzHkixY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr/NnRTpHbchs2pUIYj+lcbXOiksrCXbtat09EPpU3d+6+PaNXre85sPh/WzFT3zzF7GB47dQzxHYM5m6/pVyP+9/y4iMQDdKHkPFlDlVGsj9g6OVOuHl9jGAT6sCi+/LKPyZ+76xk54ZcZIPPzXJAUPGYaOB4C5X/HeJEvLm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb9zUxjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb9zUxjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9468C2BCB4;
	Tue,  5 May 2026 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017247;
	bh=XHGhTsSXAxX2gpK0Tt63tJG+t1j0ddwA4q9CQzHkixY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nb9zUxjFFd0d6DU2Ur4DP0CTHR3Dub/t0JkjWXXiZOUzySo9PxyITgOoiV8k3m2sp
	 MxiK+Pq49pCZNoBNf2oeksJTGec7TZlmfqr288asbqzDosbzxQdhoVStg48yao4B0o
	 67LKTrtWCPqXAeVnFI1UA2XI6yU4J2rfj01/Z8gbZpee51UBeMt9UKKN0bzSGlROZc
	 EP3nc+AbBdUQx9Qny03/BEDKxHMKeJgliVQy1TsrjaAOFKHxQHvpzhkNz7cF6tO5fr
	 yhbOXocXr7OuZ8zrsGhv7VidE2C7t9h6t8ikAul2K70R97df+T6DXasNnZs+Tg0p/2
	 7jkjQ5bJC6P8g==
Date: Tue, 5 May 2026 23:40:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <afpj3FBrvHer0E6Y@pavilion.home>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505200501.GF3518998@ZenIV>

(Adding other RCU folks in Cc)


Le Tue, May 05, 2026 at 09:05:01PM +0100, Al Viro a écrit :
> On Tue, May 05, 2026 at 10:01:39AM -0700, Linus Torvalds wrote:
> 
> > If we had a function that was "transfer spinlock without dropping RCU
> > read lock", and we'd use that as an _optimization_ (maybe we could
> > avoid all the preemption count games and testing for whether there are
> > active RCU events etc), that would make sense to me.
> >
> > At that point it would *all* become "we rely on the spinlock to hold
> > RCU read locking", and it wouldn't mix locking models. So I think such
> > an operation might make sense on its own.
> 
> Definitely; we have the same "bridge two spin_lock scopes together into
> a contiguous RCU read-side critical area" elsewhere as well.  Hell,
> 
> 	rcu_read_lock();
> 	do {
> 		spin_unlock(&dentry->d_lock);
> 		spin_lock(&inode->i_lock);
> 		spin_lock(&dentry->d_lock);
> 		if (likely(inode == dentry->d_inode))
> 			break;
> 		spin_unlock(&inode->i_lock);
> 		inode = dentry->d_inode;
> 	} while (inode);
> 	rcu_read_unlock();
> 
> in lock_for_kill() might be better off as
> 
> 	do {
> 		transfer_spinlock_with_rcu(&dentry->d_lock, &inode->i_lock);
> 		spin_lock(&dentry->d_lock);
> 		if (likely(inode == dentry->d_inode))
> 			break;
> 		spin_unlock(&inode->i_lock);
> 		inode = dentry->d_inode;
> 	} while (inode);
> 
> Explicit rcu_read_lock() uses don't explain what's really going on; in this
> form it's "we can't take ->i_lock under ->d_lock, but we need an unbroken
> RCU read-side critical area for memory safety".  The same goes for d_walk()
> use ("can't take parent's ->d_lock under child's one"), as well as in
> shrink_dcache_for_umount() ("can't take ->d_lock under ->s_roots_lock")
> and I wouldn't be surprised to see other instances of the same pattern.
> 
> I would really prefer to have all explicit rcu_read_lock() in fs/dcache.c
> clearly documented ;-/

And the calls to rcu_read_lock() / rcu_read_unlock() are _usually_ cheap enough
that their explicit calls should go unnoticed over an implicit spinlock RCU
critical section. Ok rcu_read_unlock() has its slowpath but it would otherwise
trigger randomly when implicit read side are used (context switch, interrupts,
etc...)

Also rcu_read_lock() has the advantage to tell clearly that we are doing an RCU read
side (and its uses indeed claim to be documented) here while relying on spinlocks to do
that is fine but implicit and more error-prone when there are tricky things
like spinlock transfers: better don't ask for trouble.

So I would say that we should probably avoid introducing such an API if possible.

> FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side critical
> area, according to https://lwn.net/Articles/652156/; would be nice to have
> the history mentioned in D/RCU/whatisRCU.rst - at least to the level of
> "once upon a time one *did* need an explicit rcu_read_lock() in addition
> to spin_lock() - spin_lock() or preempt_disable() alone was not enough;
> that has changed in <...>".
> 
> I'm not familiar enough with that code for that kind of archaeology ;-/
> Could somebody help with that?  Paul?

That's quite outdated. Now preempt disabled, IRQs disabled, and spinlocks
are all implicit RCU read sides. On non RT spinlocks disable preemption and
on RT they call rcu_read_lock() internally.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
