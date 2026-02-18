Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37180309DAB;
	Wed, 18 Feb 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448426; cv=none; b=NbN3eknUGt1YC1lO7jzPuqBnJLFvFD3pygLkrtKHQhE+yVNCsj10st0gLjJrTthwB1rRw4wQiid/CNcGAGLeJ6aeoDscv/c58sGW3tyCV6NcA17BsrlDaoYim1XOl+cs4z8CaHLqnvJEtmTfgMAxSHMviTLDwaIqx1NE+w2muJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448426; c=relaxed/simple;
	bh=EYSqa00jjih8AtLTQdqnv5V4gC19xOTOhwOAP0aX/5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOiIp52zRM14Rqyila/JsBV0N4aetlihG2VWB4IltCrmxsB7Bc97mNvFqM5yJB+EeCbadWdkXLsXKxE/RY4D5QvWlroyESY/B2fMueaoZsHSCvjgDkBZqPg7ROfUvMwu2JF68moI9UMmS4TevrRWWwCW0an0J5lld+uRE1l4WUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D/AmnK3H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/AmnK3H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HX3w2auGRcWrSHwm914YOBvW/LnRANFaIv0iLQ3xQ2Y=; b=D/AmnK3HtLBwbimjfxerUO8TYw
	2Q7Jvu1I3Muz3gNT6Cdq0Y7d9fqzMq/SVTPyE/sTYS8gHGy5LSlOC9mOUX3gCWRnntGWZy66rRubA
	Iif405/Kn0b/2YvHko1NKnFnv0SOk6ycHoQ4fD03VRHcOaxfjSyBBLJlH4rrVHhajG54HIld3AU67
	vG6EuyQN5iaW1eiTJtLwfiteZ9kTqLwd3HD8N5sri73sczp0i/HAaNk40aADVdQwvgTBYd28s6owG
	D3e8Y0Kjo1on6lzEqBMwZICkn+axYBH2VB5kPOl4QrmTx3KZk7eSdJZSo1VhZjHSeCUMutrjzVxyD
	Ib4JxiIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsoee-00000006dmJ-2CM4;
	Wed, 18 Feb 2026 21:00:16 +0000
Date: Wed, 18 Feb 2026 21:00:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
Message-ID: <aZYoXsUtbzs-nRZH@casper.infradead.org>
References: <20260217190835.1151964-1-willy@infradead.org>
 <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>

On Tue, Feb 17, 2026 at 12:27:29PM -0800, Linus Torvalds wrote:
> I like this, but I have to say that I dislike how rwsem_add_waiter()
> in particular ends up looking.
> 
> Not because it's horrible on its own, but when you look at the
> call-sites, that function ends up being entirely pointless.

I confess, I didn't look at the callers.  Good catch; I've integrated
your suggestion and it looks better.

I was most concerned with just how ugly __rwsem_del_waiter() looked.
I had a good think about it and have an improved version.

> Somewhat similarly, I also reacted to this part:
> 
>     -#define rwsem_first_waiter(sem) \
>     -       list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
>     +#define rwsem_first_waiter(sem)        sem->first_waiter
> 
> that rwsem_first_waiter() macro used to make sense as a syntactic
> helper function. But now it really doesn't. It is literally more
> typing and *less* legible than just accessing that new
> "sem->first_waiter" field.

Yep, I did notice that too, just decided not to fix it.  Also taken
care of in the next version.

Here's all the changes I made, and I'll post a rolled-up version
next.

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4226eb0ec5da..16f3db35652a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -341,7 +341,6 @@ struct rwsem_waiter {
 	unsigned long timeout;
 	bool handoff_set;
 };
-#define rwsem_first_waiter(sem)	sem->first_waiter
 
 enum rwsem_wake_type {
 	RWSEM_WAKE_ANY,		/* Wake whatever's at head of wait list */
@@ -364,36 +363,19 @@ enum rwsem_wake_type {
  */
 #define MAX_READERS_WAKEUP	0x100
 
-static inline void
-rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
-{
-	struct rwsem_waiter *first = sem->first_waiter;
-	lockdep_assert_held(&sem->wait_lock);
-	if (first) {
-		list_add_tail(&waiter->list, &first->list);
-	} else {
-		INIT_LIST_HEAD(&waiter->list);
-		sem->first_waiter = waiter;
-	}
-	/* caller will set RWSEM_FLAG_WAITERS */
-}
-
 static inline
 bool __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
-	if (sem->first_waiter == waiter) {
-		if (list_empty(&waiter->list)) {
-			sem->first_waiter = NULL;
-			return true;
-		} else {
-			sem->first_waiter = list_first_entry(&waiter->list,
-					struct rwsem_waiter, list);
-			list_del(&waiter->list);
-		}
-	} else {
-		list_del(&waiter->list);
+	if (list_empty(&waiter->list)) {
+		sem->first_waiter = NULL;
+		return true;
 	}
 
+	if (sem->first_waiter == waiter)
+		sem->first_waiter = list_first_entry(&waiter->list,
+				struct rwsem_waiter, list);
+	list_del(&waiter->list);
+
 	return false;
 }
 
@@ -453,7 +435,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 * Take a peek at the queue head waiter such that we can determine
 	 * the wakeup(s) to perform.
 	 */
-	waiter = rwsem_first_waiter(sem);
+	waiter = sem->first_waiter;
 
 	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
 		if (wake_type == RWSEM_WAKE_ANY) {
@@ -612,8 +594,6 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 		      struct wake_q_head *wake_q)
 		      __releases(&sem->wait_lock)
 {
-	bool first = rwsem_first_waiter(sem) == waiter;
-
 	wake_q_init(wake_q);
 
 	/*
@@ -621,7 +601,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 	 * the first waiter, we wake up the remaining waiters as they may
 	 * be eligible to acquire or spin on the lock.
 	 */
-	if (rwsem_del_waiter(sem, waiter) && first)
+	if (rwsem_del_waiter(sem, waiter) && sem->first_waiter == waiter)
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	if (!wake_q_empty(wake_q))
@@ -638,7 +618,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
-	struct rwsem_waiter *first = rwsem_first_waiter(sem);
+	struct rwsem_waiter *first = sem->first_waiter;
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -1030,7 +1010,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 {
 	long adjustment = -RWSEM_READER_BIAS;
 	long rcnt = (count >> RWSEM_READER_SHIFT);
-	struct rwsem_waiter waiter;
+	struct rwsem_waiter waiter, *first;
 	DEFINE_WAKE_Q(wake_q);
 
 	/*
@@ -1071,7 +1051,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	if (!sem->first_waiter) {
+	first = sem->first_waiter;
+	if (!first) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
 		 * by a writer, this reader can exit the slowpath and return
@@ -1087,8 +1068,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 			return sem;
 		}
 		adjustment += RWSEM_FLAG_WAITERS;
+		INIT_LIST_HEAD(&waiter.list);
+		sem->first_waiter = &waiter;
+	} else {
+		list_add_tail(&waiter.list, &first->list);
 	}
-	rwsem_add_waiter(sem, &waiter);
 
 	/* we're now waiting on the lock, but no longer actively locking */
 	count = atomic_long_add_return(adjustment, &sem->count);
@@ -1146,7 +1130,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
-	struct rwsem_waiter waiter;
+	struct rwsem_waiter waiter, *first;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1165,10 +1149,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_add_waiter(sem, &waiter);
 
-	/* we're now waiting on the lock */
-	if (rwsem_first_waiter(sem) != &waiter) {
+	first = sem->first_waiter;
+	if (first) {
+		list_add_tail(&waiter.list, &first->list);
 		rwsem_cond_wake_waiter(sem, atomic_long_read(&sem->count),
 				       &wake_q);
 		if (!wake_q_empty(&wake_q)) {
@@ -1181,6 +1165,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			raw_spin_lock_irq(&sem->wait_lock);
 		}
 	} else {
+		INIT_LIST_HEAD(&waiter.list);
+		sem->first_waiter = &waiter;
 		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
