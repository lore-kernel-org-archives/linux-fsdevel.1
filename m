Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373A31195B;
	Fri, 19 Jun 2026 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833024; cv=none; b=AvD4iaw1ocBPZDJBqMdfYeD4OU0gi3Nx4OtuTT6qnGE8dLH0+E6XONXkatPrkPgSahLmtDGJPtMJ7VwtoCDPJyYVvS7uRr029Pp/tnqvP8HyChGipl1IxKQI1A/FFHcmK6RrtywJoJ28BoFXDyisex8vCrSJV44nKucYS1T5OUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833024; c=relaxed/simple;
	bh=M/fNhuS9P6r1x8xA0MUb0hR09//Vml+U8aBw179XTLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz0xTWHj99i0Eg5lwlk97v0qKgO4GFMd7jO+2Uugb7GOiqIIH+SJN6rJvDqJh1YRMpEsVxyHMmHogkm8qxdgklXYddW+X8hpD2xsNxhiVZUSN4cxqwUk7rOkOCaA7vLN/Is8TpcNYeDCat00HZON1PfJPZuOAZ50J9zH08cMAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nLMmAI0f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nLMmAI0f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+MHbnixRF5Q6fYceTIEC3xH+JiaPYUKl68ye2PyI+28=; b=nLMmAI0fHApYxfRjPav3iCH9Wz
	3LyOkv/dVhuMTnEgUZnZ6Sa6No1u4KzkWrN905ba4rZvujM779rJfG6MeUV6yO/A3YZzfv8gvNPSj
	EpRoSpZw3jz5TrqNWUUMLn50coaj7LcVyS+VJlBfeTEb9wItjOqm0JeBVBqRujqaOalIOCIg410W+
	F8fGYdhS/hHJXqbyvepi/0r2Qp8t9t/nY6cGudn5wymOHzWl3mj8Wp+Fk7v5OatkRAY+DA3Q59tTF
	x9qusRsJdUqJAE1R06MbP0aBn1eXqfk6Fu9RQuLCk8MUTuMGr+mmk5ENlJl+pNy7ceKw1fID5e41M
	zAc9wmKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1waOA8-00000008WxH-2JiD;
	Fri, 19 Jun 2026 01:36:53 +0000
Date: Fri, 19 Jun 2026 02:36:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
	Jeff Layton <jlayton@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: rt_spin_unlock order of operations [was: Re: [syzbot] [fs?]
 KASAN: slab-use-after-free Read in shrink_dcache_tree]
Message-ID: <20260619013652.GC2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV>
 <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlvvcwqt.ffs@fw13>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 19, 2026 at 12:24:58AM +0200, Thomas Gleixner wrote:
> Subject: locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
> From: Thomas Gleixner <tglx@kernel.org>
> Date: Thu, 18 Jun 2026 23:32:43 +0200
> 
> rt_spin_unlock() releases the RCU protection before unlocking the
> lock. That opens the door for the following UAF scenario:
> 
>  T1					T2
>  spin_lock(&p->lock);		rcu_read_lock();
>  invalidate(p);			p = rcu_dereference(ptr);
>  rcu_assign_pointer(ptr, NULL);	if (!p) return; // Not taken
>  spin_unlock(&p->lock);		spin_lock(&p->lock)
>  				   lock(&lock->lock);
> 				   rcu_read_lock();
>  kfree_rcu(p);			rcu_read_unlock();
> 				....
> 				spin_unlock(&p->lock)
> 				  rcu_read_unlock(); // Ends grace period
>  rcu_do_batch()
>    kfree(p);
> 			 UAF ->	  rt_mutex_cmpxchg_release(&lock->lock...)
> 
> Regular spinlocks keep preemption disabled accross the unlock operation,
> which provides full RCU protection, but the RT substitution fails to
> resemble that.
> 
> Move the rcu_read_unlock() invocation past the unlock operation to match
> the non-RT semantics and add a comment explaining why rcu_read_unlock()
> must come last.
> 
> This makes it asymmetric vs. rt_spin_lock(), but that's harmless as the
> caller needs to hold RCU read lock across the lock operation. The
> migrate_enable() call stays before the unlock operation because there is
> no per CPU operation in the unlock path which would require migration to
> be kept disabled.
> 
> Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
> Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
> Decoded-by: Jann Horn <jannh@google.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: stable@vger.kernel.org

IIRC, something very similar being mentioned in dentry UAF threads back in April...
<digs around>
https://lore.kernel.org/all/a0f19c52-47d2-41d9-995a-4bbc6bb73c13@paulmck-laptop/

There it covered rt_read_unlock() and rt_write_unlock() as well; AFAICS both are
in the same situation and at that point there's nothing left held to prevent
the RCU callbacks from running.

Said that, this is _not_ the same thing Jeff had been hitting - config in
question didn't have RT_PREEMPT, so there was something separate  ;-/
