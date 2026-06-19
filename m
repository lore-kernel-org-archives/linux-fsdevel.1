Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B72388E55;
	Fri, 19 Jun 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873533; cv=none; b=qkQZmtZLveAJ4C+yRyYw7/Liijng6+yh962L+bOJangGEhqKMMgLUuRzg31130oO8b1KzdZRe/bGDcOm9yBtbJGKUlcK6WGe4DRWo+jwSlhb3OeIBQeq1/oiOck4lno4bpoeM5VdMfAKmSosSJV96g3U/Lj+ag/9AiqLkBozPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873533; c=relaxed/simple;
	bh=oYT31CBlCxCpc6xThKnVetlCAF58DlciS+vj5RcEa84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwWY3pKNi7OZQgpEWVp3+xQiaaBlocTON53uRWp4p5yFXpYVhsfG92SvUjECmuxsnulGgZMIlFnK+jXEmY+Vgx1m4hzkcR/33O/3ed51mYwV9Jl7Ezu9Snp6pLYWt/nQ8HShqIgRRbnGttHjsmKiPp/G1O5EZA4jF2/Y8SfpMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+3n4uol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+3n4uol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C11F000E9;
	Fri, 19 Jun 2026 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781873531;
	bh=atTqWW3hh3503BaULDDfHG09FiyYQu6lzxC5VSiBFLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G+3n4uolD9AMQLWIveCneDjyG72qW3HDIEUGRoMs+1N06prtnNtdj9pC/5dr/2H6X
	 7qb1CD4M41O497lexhkFwHH2VgZqmfycIPjvs6VqeHNoi7R4lXBDPzKueqtqqlTTzs
	 APBtqKSwRSzt85gRW6J2MMxhN2Qmz0nNuJ5V1/dIQv7mOpPmJINvHqOkAsSmYVZbOZ
	 M+jmmjUTYh+yKEyL8L86p40sdnBUMGX1ydKQF5m/0rfH7fmtOIGIif9OHn0l1ex8g5
	 0AOzK1uCsoY/N1o9hUm0qFbq2kKIidRNKelukvo8U/9PAcWXTFa0haxHx1W5mkQaoY
	 hkF0LgbgVMbBw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, syzbot
 <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, kernel list
 <linux-kernel@vger.kernel.org>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH V2] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()
In-Reply-To: <87mrwqd7eu.ffs@fw13>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV> <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13> <20260619083916.UMjUHmaq@linutronix.de>
 <87mrwqd7eu.ffs@fw13>
Date: Fri, 19 Jun 2026 14:52:08 +0200
Message-ID: <87jyrud75z.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

rt_spin_unlock() releases the RCU protection before unlocking the
lock. That opens the door for the following UAF scenario:

 T1					T2
 spin_lock(&p->lock);		rcu_read_lock();
 invalidate(p);			p = rcu_dereference(ptr);
 rcu_assign_pointer(ptr, NULL);	if (!p) return;
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
resemble that. Same applies for the rwlock substitution.

Move the rcu_read_unlock() invocation past the unlock operations to match
the non-RT semantics. This makes it asymmetric vs. rt_xxx_lock(), but
that's harmless as the caller needs to hold RCU read lock across the lock
operation. The migrate_enable() call stays before the unlock operation
because there is no per CPU operation in the unlock path which would
require migration to be kept disabled.

Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
Decoded-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
V2: Fold the corresponding rwlock changes - Sebastian
---
 kernel/locking/spinlock_rt.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

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
 
@@ -262,17 +279,21 @@ void __sched rt_read_unlock(rwlock_t *rw
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
 void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
