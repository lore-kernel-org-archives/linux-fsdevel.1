Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E443E123C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844666; cv=none; b=dLyooRkIjneGV3c+ZIeIvedN6Rj6UDRTwrJBbnfGkE5g+sjVNFs2y9Wd7kVL2rwcJa7Vk+ZxEyobdVghGpz27vHKcL8ln65l+OsaLxZ0HoYPgq2ofCmFyv6EL0THndEwBF+VMirPx22OB9WATkjKkcy6SowArVbKci7zA/Wr3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844666; c=relaxed/simple;
	bh=L1ZaeNhpT1cOXMO75dSyi+IOD4egec2m4U7YEX2j6bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnoEthaPLRK3Qvy1nY5zECb5hL12408YM3w27IPzgin+3Z5ETsoEkVe9yIKRkgB4rLWzZRZrtXg0P4cwR+wekBJfbmFSee+FsZ6P6i1HUQL6qp3XjbpU70R/uRbH1vPY3lKEq2huoEC+PnphFgG+K/rUUElA0DhSpWRJC+APWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdE5nmOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdE5nmOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE4EC19421;
	Fri, 10 Apr 2026 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775844665;
	bh=L1ZaeNhpT1cOXMO75dSyi+IOD4egec2m4U7YEX2j6bc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fdE5nmOYXhuRUAj7CfGQF8qhIyAq6Vx4W0RIN9Vf0mrDIKLQv4OHM3wFgvysPhU5l
	 e8zaEapQ2cqn1gYRPO1sSLAq8sJK6J99JUdfSdn07TOVV+sthZwQIY1CWR1rIDHmqu
	 YYbvONevSLWKa+VPCq8ysinlmpNLBdPJ3c+7pqw+PzKa5ehMpmWVvvtFwOb45xZEes
	 Knq5RklVdmn1rRnUBv3PaY7MrBDOfe4Zw1jfxgDz6R3n4vNeZWHhKM3JVbrHOZH4Mq
	 NQBoxznXIklddZipwrl26i/+CbIddqpB2+XWzasQlF0Td74jth0SErR19nPJUdL8Y2
	 FGWHbUsSy2oSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5BCE6CE04B4; Fri, 10 Apr 2026 11:11:05 -0700 (PDT)
Date: Fri, 10 Apr 2026 11:11:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <a0f19c52-47d2-41d9-995a-4bbc6bb73c13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>

On Fri, Apr 10, 2026 at 10:31:32AM -0700, Linus Torvalds wrote:
> On Fri, 10 Apr 2026 at 09:27, Boqun Feng <boqun@kernel.org> wrote:
> >
> > Notice in rcu_read_unlock_special(), atomicity/preemption count is
> > checked in two ways:
> 
> Yeah, I didn't go that deep ... That code is inscrutable.

We are working to make it better, but this will be a long process.

> Raising a softirq looks pretty strangein there, since there's
> absolutely no reason to believe that the preemption-off region has
> ended before the softirq is triggered. It makes sense for the "we're
> in hardirq context", but it also does it for that (needs_exp &&
> !irqs_were_disabled()) case
> 
> So then it depends on the softirq checking it *again*. That all seems
> a bit strange.
> 
> But it looks like rcu_core_si() does do that, and then falls back to
> 
>         if (rcu_preempt_need_deferred_qs())
>                 set_need_resched_current();
> 
> and it feels like maybe the rcu_read_unlock_special() should just have
> done that itself instead of playing softirq games.
> 
> Maybe it's some off optimization, but going through the softirq code
> doesn't _feel_ like it's the right thing to do.
> 
> I don't know this code well enough to judge.

We could quite easily add another leg to the inner "if" statement
in rcu_read_unlock_special() so that it does raise_softirq_irqoff()
if in_hardirq() and set_need_resched_current() otherwise, as in the
(untested, probably doesn't even build)first  patch at the end of this
email.  My feeling is that it is not worth it, but on the other hand,
my idea of "simplicity" might or might not serve the people reading
this code.

> Let's wait to see if Al's patch actually makes any difference. It
> *shouldn't* make any difference, and maybe it doesn't. No need to
> start chasing RCU bugs that may not even be there.

Fair enough!

> Jeff?
> 
> > @Jeff, just want to confirm, this UAF can be reproduced without
> > PREEMPT_RT=y, right?
> 
> I haven't seen Jeff's config, but some of the syzbot reports that
> *may* be related have configs that look pretty normal and didn't have
> PREEMPT_RT.

And I am concerned about PREEMPT_RT, please see the second patch below.
But Sebastian will no doubt tell me the error of my ways.  My question is
"why is it safe to exit the RCU reader before the lock is fully released".
Sebastian's answer might well be that all the valid use cases for
combining locking and RCU have a lock acquisition on the free path.
Whether I believe that or not, I have no idea.  ;-)

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3c..066b6fe6b6a3f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -749,7 +749,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// GP in flight or a potential need to deboost.
 			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
 				rdp->defer_qs_pending = DEFER_QS_PENDING;
-				raise_softirq_irqoff(RCU_SOFTIRQ);
+				if (in_hardirq())
+					raise_softirq_irqoff(RCU_SOFTIRQ);
+				else
+					set_need_resched_current();
 			}
 		} else {
 			// Enabling BH or preempt does reschedule, so...

------------------------------------------------------------------------

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b45de67..fbf4deba4029c 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -79,10 +79,10 @@ void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 
 	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
 		rt_mutex_slowunlock(&lock->lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -262,17 +262,17 @@ void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
 void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
