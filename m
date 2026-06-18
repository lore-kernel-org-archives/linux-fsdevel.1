Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FF258EF9;
	Thu, 18 Jun 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821503; cv=none; b=NfB7Va4kvUYUsZ0vHew1bgh6UZza9Rh1qKUNBzEItQj14eHKL680nFkbAPMbjJs80p4kS/T5L5ANoUSJq281oR8mhHggDiMEX35sraKkBpCMhGy18R0ZdAf/IJmVCbqGC5X1x6tX6uar7Ox3KWRwuh/aKcWurJEQOUh0othxby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821503; c=relaxed/simple;
	bh=QW91CGDZHJspKkTF3oZ+LZRWRbQ+LuaEKE79HUBCPS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qkgpVmY1eNE8vITVErk1jPQJYpWnMjhnJASGcZaYugdX7AchEzB1vLBwK1LWXEX9cMEKD9APIRTwnUVacm6XNai3syxM14YMXzW1jP77aiTcVKJu0KHxREsSLMbWWdfjVBNfqTkb/QsWBGhwCmIklrv88uZsyztk/Kp3kvKK2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpyfkENq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpyfkENq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4911F000E9;
	Thu, 18 Jun 2026 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781821502;
	bh=L+l9XJHFO/nCFpJw3vhSjG3OvRRbqQWXRkgwTsavaPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CpyfkENqGTfbbck69Dv9hFSCDOTKwdJjcpcqw6J3u7YfxXbCsnBUF//x7cuZwASRj
	 YG47B1fHTJDb64O2CwyHrXH+ZDC+Uy5ecp+bQpPvzvSvB/bjUBOB0l142z+DvoBApm
	 DD/WojiXdhESg9M9z3rF3qWrrFoJaIlw9Gz1y9yEwqApdUaIwG2jr3nWaO2A/Y1YvX
	 A/o7uLsyPklFqM7+b8auAWKy0AYvt+JKxFFO30rLgz6uhYIhNHonsqgdwy6BhA0E9g
	 otct5ePaBhVsW6Cd8OAT/TVeTVeJ46fexnFi4iE/6+iTFlUWJMDzrGqPBpEH4NVQTq
	 UMI1UTJwHVhFg==
From: Thomas Gleixner <tglx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, syzbot
 <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, kernel list
 <linux-kernel@vger.kernel.org>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: rt_spin_unlock order of operations [was: Re: [syzbot] [fs?]
 KASAN: slab-use-after-free Read in shrink_dcache_tree]
In-Reply-To: <20260618210332.GA2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV> <20260618210332.GA2636677@ZenIV>
Date: Fri, 19 Jun 2026 00:24:58 +0200
Message-ID: <87wlvvcwqt.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 18 2026 at 22:03, Al Viro wrote:

> On Thu, Jun 18, 2026 at 09:59:53PM +0100, Al Viro wrote:
>> > https://docs.kernel.org/next/RCU/whatisRCU.html guarantees that
>> > spinlock APIs imply RCU, and
>> > https://docs.kernel.org/locking/mutex-design.html says: "This is in
>> > contrast with spin_unlock() [...], which APIs can be used to guarantee
>> > that the memory is not touched by the lock implementation after
>> > spin_unlock()/completion_done() releases the lock.".
>> > Neither of these explicitly guarantees that the RCU read-side critical
>> > section (and the protection against migration?) should still hold
>> > while the lock is being dropped, but I think that would fit best with
>> > the explicit guarantees?
>> 
>> I'm trying to recall if PREEMPT_RT had been enabled in the last round of
>> UAF in that area back in early April...
>> 
>> As far as I'm concerned, we *do* need to keep RCU read-side critical area
>> all the way until the end of spin_unlock(); it very well might be the
>> only thing to prevent freeing the sucker under us.

Right. That's clearly a bug in rt_spin_unlock(). I think I wrote it that
way for symmetry vs. lock(), which is obviously wrong.

Fix below.

Thanks,

        tglx
---
Subject: locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
From: Thomas Gleixner <tglx@kernel.org>
Date: Thu, 18 Jun 2026 23:32:43 +0200

rt_spin_unlock() releases the RCU protection before unlocking the
lock. That opens the door for the following UAF scenario:

 T1					T2
 spin_lock(&p->lock);		rcu_read_lock();
 invalidate(p);			p = rcu_dereference(ptr);
 rcu_assign_pointer(ptr, NULL);	if (!p) return; // Not taken
 spin_unlock(&p->lock);		spin_lock(&p->lock)
 				   lock(&lock->lock);
				   rcu_read_lock();
 kfree_rcu(p);			rcu_read_unlock();
				....
				spin_unlock(&p->lock)
				  rcu_read_unlock(); // Ends grace period
 rcu_do_batch()
   kfree(p);
			 UAF ->	  rt_mutex_cmpxchg_release(&lock->lock...)

Regular spinlocks keep preemption disabled accross the unlock operation,
which provides full RCU protection, but the RT substitution fails to
resemble that.

Move the rcu_read_unlock() invocation past the unlock operation to match
the non-RT semantics and add a comment explaining why rcu_read_unlock()
must come last.

This makes it asymmetric vs. rt_spin_lock(), but that's harmless as the
caller needs to hold RCU read lock across the lock operation. The
migrate_enable() call stays before the unlock operation because there is
no per CPU operation in the unlock path which would require migration to
be kept disabled.

Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
Decoded-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/locking/spinlock_rt.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -79,10 +79,27 @@ void __sched rt_spin_unlock(spinlock_t *
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 
 	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
 		rt_mutex_slowunlock(&lock->lock);
+
+	/*
+	 * This must be last to prevent the following UAF:
+	 *
+	 * T1					T2
+	 * spin_lock(&p->lock);			rcu_read_lock();
+	 * invalidate(p);			p = rcu_dereference(ptr);
+	 * rcu_assign_pointer(ptr, NULL);	if (!p) return;
+	 * spin_unlock(&p->lock);		spin_lock(&p->lock);
+	 * kfree_rcu(p);			rcu_read_unlock();
+	 *					....
+	 *					spin_unlock(&p->lock)
+	 *					  rcu_read_unlock(); // Ends grace period
+	 * rcu_do_batch()
+	 *   kfree(p);
+	 *			    UAF ->	  rt_mutex_cmpxchg_release(&p->lock.lock...)
+	 */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
