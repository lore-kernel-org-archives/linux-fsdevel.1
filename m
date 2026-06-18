Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E5343D8F;
	Thu, 18 Jun 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816407; cv=none; b=szxeyurRE/uLQ66zaUmkQMbML8mTuJkqmqmCbpIGwHX6/i2YSL+OpZxstgksDJpsv6u4m01JFRYWd3orh7W6IT6zFGQfXafO9IdZJ1pwMJtBTima+0p0Ry2mpw67JIJbTtqg4G04VBwGp82uOhahNf7FMxpA5gADqBmnHkCFC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816407; c=relaxed/simple;
	bh=Qki7vY9EQlMoHYS/Uhv7gzc/4uP9HP0GFtjhdY1sXm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og0ETI7MFLiL9xC3BxjwVDy4CH8Jj5NuxGX1Xl79Agepb8KSB/YtGPlz3hvv2PISJSC06ug91p2oKSUZ96nQ/s68wGFxCdC6sdveW/0joVMHRV8oq80e8whiXSNKfOzisp4+gQv9QJ1JoC9MXvp+WQKIm+T6lsqpBp+pCB66xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KJ2kxOZ0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KJ2kxOZ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GREhmPjVWYMgQw8GowbxTpmvX1B6gDhBpWW7jAOVqAk=; b=KJ2kxOZ0W7v7t++8QidtvuLkJh
	BKwCpyHQmJWfNKeDSFWRydEA1ghzXqkVATIQSDFGDo4E8o3kiRiv6oYnFNBMftP3KDXqSU2U1uGaL
	DvGGtd1G9ddpgadKwPnZgWxhiDES1Om/U0GMXxZUWp8YY49o6xqBBNTGBIDyhwflqW6nDVak743dB
	1vn0Y/aZoF5Tx/a7dIi3eJKMMk0Bm/woxTI6AT0uUzdyf9okp47j6YAEW+cOjNrST80ApQnGRq62s
	kAFZ6QEPgL0fhZVuTeOyTXhbW8PAFNxQ78rmtOb4iTa863kwVXIQ3v4xGNYePm/4SZg/Zuje2LnbH
	sly0vBaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1waJq5-00000006miR-1iLQ;
	Thu, 18 Jun 2026 20:59:53 +0000
Date: Thu, 18 Jun 2026 21:59:53 +0100
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
Message-ID: <20260618205953.GZ2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 18, 2026 at 08:44:32PM +0200, Jann Horn wrote:
> I think this is more of a bug in RT spinlocks than a VFS bug, though
> it's a bit murky.
> 
> rt_spin_unlock() looks like this:
> 
> void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
> {
>         spin_release(&lock->dep_map, _RET_IP_);
>         migrate_enable();
>         rcu_read_unlock();
> 
>         if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
>                 rt_mutex_slowunlock(&lock->lock);
> }
> 
> Note how the RCU read-side critical section and the protection against
> migration end *before* the lock is actually released, which means this
> can UAF if the RCU read-side critical section implied by the spinlock
> is the only thing keeping the lock alive. While non-RT spinlocks do
> this the other way around (do_raw_spin_unlock() before
> preempt_enable()):
> 
> static inline void __raw_spin_unlock(raw_spinlock_t *lock)
>         __releases(lock)
> {
>         spin_release(&lock->dep_map, _RET_IP_);
>         do_raw_spin_unlock(lock);
>         preempt_enable();
> }
> 
> https://docs.kernel.org/next/RCU/whatisRCU.html guarantees that
> spinlock APIs imply RCU, and
> https://docs.kernel.org/locking/mutex-design.html says: "This is in
> contrast with spin_unlock() [...], which APIs can be used to guarantee
> that the memory is not touched by the lock implementation after
> spin_unlock()/completion_done() releases the lock.".
> Neither of these explicitly guarantees that the RCU read-side critical
> section (and the protection against migration?) should still hold
> while the lock is being dropped, but I think that would fit best with
> the explicit guarantees?

I'm trying to recall if PREEMPT_RT had been enabled in the last round of
UAF in that area back in early April...

As far as I'm concerned, we *do* need to keep RCU read-side critical area
all the way until the end of spin_unlock(); it very well might be the
only thing to prevent freeing the sucker under us.
