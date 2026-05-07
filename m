Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D037318EF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139293; cv=none; b=SUO5z0ReIDgd3kgCfRO5tdLF+sNk+Q9sb69rBGUo1uvE28UQaEUXJ38GGkT1LkwVFInNV2T2iFCUUeVWAR9AKMp07AL9uscWIhzR6DZkYHQBlngVtBy5ZQvg1iJsWZhPja/BNHUrva9PHRjO9wcAsEDWlDte/lke3xivLf1p/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139293; c=relaxed/simple;
	bh=IRTMdRRonapVss1kZgGBRxKcE26PGoCpqAFz1mXB6dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtpxnXhYhLn7/JmJnf0MZwLiC+zf8s+VQ1oqY3saAzP7Nd03cSUwK+/VXAzerxTCuHTpuC3X9N7ngDL05oeHw0Y9RnnWErK/8kbnHCKsZLwxEU+bDaYz3othSEijbWh4a+WABj776v7pfhpRsx1uGpAKHwMklwco38e4VhMh0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=biN4qvN7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="biN4qvN7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4NC3/U/PI2qCFaDUfH8pFijEKJutbAmPpV8/2hNVBSE=; b=biN4qvN7fXWEzveK2xyEjS5a3T
	wao5FxjtUVq5i6ryH4hDcuuJ+jh5U8x+uitF33+5tkIJJ3ut+TSpvYJmrjJUgf/0hv51cNzSPzcxI
	g80hM8kO9DDNNRTIo5fSJh6/rMqxJo3fNIoK87yoK0L+7ZJo3sFQcuDGufJ3tL6RP5D17UF0YyO2x
	6TDrgPRs+cMpy3Bkk/upp28yZovLTeSK/9MyY3QgAyZx4i2+2omd3uh/oVR6wrAnEWO7PG2sF2ufY
	O68VmfmbN8SIH5nM/DutAH10yMbBVDfTnP1t4Zpv2/d7M4lYTGjJcmpKLg8l7kxgRhlqR4DJKXb3J
	DeSFDmag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKtGI-00000002gcR-2diP;
	Thu, 07 May 2026 07:35:11 +0000
Date: Thu, 7 May 2026 08:35:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
Message-ID: <20260507073510.GL3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
 <CAADWXX_dChuduyjE2=h4JsRkX1Tbjhgw47p0v9KOSbHkWCs7ng@mail.gmail.com>
 <20260505224256.GH3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505224256.GH3518998@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 11:42:56PM +0100, Al Viro wrote:
> > Honestly, if this is then going to make some still later patch
> > cleaner, I'd prefer 12/13 to be just combined into one "change rcu
> > locking semantics to be better".
> > 
> > Because as-is, I think patch 12 on its own is just ugly.
> > 
> > It looks like patch 14 then uses the thing to clean up dentry_kill() a
> > bit, so that combined patch wouldn't trigger my "this is just ugly"
> > case, adn would still have a real reason for it (outside of a
> > theoretical "shrink rcu region" without numbers to say why it's
> > needed).
> 
> The main payoff is in #15, really.  The entire 12--17 started as a single
> commit, which I fucked up on the first two attempts.  Thus the carve-up
> into chunks too small for idiot me to fumble...

Does the following look sane to you?  That's pretty much #12--#15 combined,
with hopefully saner commit message.

commit f6c6d2194a4911619a4ab8011953fbf2ec202778
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Apr 11 03:24:28 2026 -0400

    simplify safety for lock_for_kill() slowpath
    
    rcu_read_lock() scopes in dentry eviction machinery are too wide
    and badly structured; we end up with too many of those, quite
    a few essentially identical.  Worse, quite a few of the function
    involved are not neutral wrt that, making them harder to reason about.
    
    rcu_read_lock() scope is not the only thing establishing an
    RCU read-side critical area - spin_lock scope does the same and
    they can be mixed - the sequence
            rcu_read_lock()
            ...
            spin_lock()
            ...
            rcu_read_unlock()
            ...
            rcu_read_lock()
            ...
            spun_unlock()
            ...
            rcu_read_unlock()
    is an unbroken RCU read-side critical area.
    
    Use of that observation allows to simplify things.  First of all,
    lock_for_kill() relies upon being in an unbroken RCU read-side
    critical area.  It's always called with ->d_lock held, and normally
    returns without having ever dropped that spinlock.  We would not
    need rcu_read_lock() at all, if not for the slow path - if trylock
    of inode->i_lock fails, we need to drop and retake ->d_lock.
    
    Having all calls of lock_for_kill() inside an rcu_read_lock() scope
    takes care of that, but to show that lock_for_kill() slow path is safe,
    we need to demonstrate such rcu_read_lock() scope for any call chain
    leading to lock_for_kill().  Which is not fun, seeing that there are
    10 such scopes, with 5 distinct beginnings between them.
    
    Case 1: opens in dput() proceeds through fast_dput() grabbing ->d_lock,
    returning false into dput() and there a call of finish_dput() which calls
    dentry_kill(), which calls lock_for_kill(); ends in dentry_kill(), either
    right after lock_for_kill() success or right after dropping ->d_lock
    on lock_for_kill() failure.  ->d_lock is held continuously all the way
    into lock_for_kill().
    
    Case 2: opens in dentry_kill(), where we proceed to the same call of
    dentry_kill() as in case 1.  ->d_lock is held since before the
    beginning of the scope and all the way into lock_for_kill().
    
    Case 3: opens in select_collect2(), proceeds through the return to
    d_walk() and to shrink_dcache_tree() where we grab ->d_lock and
    proceed to call shrink_kill(), which calls dentry_kill(), then as
    in the previous scopes.
    
    Case 4: opens in shrink_dentry_list(), followed by call of shrink_kill(),
    then same as in case 3.  ->d_lock is held since before the beginning
    of the scope and all the way into lock_for_kill().
    
    Case 5: opens in shrink_kill(), where it's immediately followed by
    call of dentry_kill(), then same as in the previous scopes.  ->d_lock
    is held since before the beginning of the scope all the way into
    lock_for_kill().
    
    Note that in cases 2, 4 and 5 the slow path of lock_for_kill() is the
    only part of rcu_read_lock() scope that is not covered by spinlock
    scopes.  In case 1 we have the area in fast_dput() as well and in
    case 3 - the return path from select_collect2() and chunk in shrink_dcache_tree()
    up to grabbing ->d_lock.
    
    Seeing that the reasons we need rcu_read_lock() in these additional
    areas are completely unrelated to lock_for_kill() slow path, the things
    get much more straightforward with
            * explicit rcu_read_lock() scope surrounding the area in slow path
    of lock_for_kill() where ->d_lock is not held
            * shrink_dentry_list() dropping rcu_read_lock() as soon as it has
    grabbed ->d_lock.
            * dput() dropping rcu_read_lock() just before calling finish_dput().
            * rcu_read_lock() calls in finish_dput(), shrink_kill() and
    shrink_dentry_list() are removed, along with rcu_read_unlock() calls in
    dentry_kill().
    
    RCU read-side critical areas are unchanged by that, safety of lock_for_kill()
    slow path is trivial to verify and a bunch of rcu_read_lock() scopes either
    gone or become easier to describe.
    
    Incidentally, all calls of fast_dput() are immediately preceded by rcu_read_lock()
    and followed by rcu_read_unlock() now, which will allow to simplify those on
    the next step...
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/dcache.c b/fs/dcache.c
index 0943a17eccbc..4a657bcd5b4f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -763,6 +763,7 @@ static bool lock_for_kill(struct dentry *dentry)
 	if (!inode || likely(spin_trylock(&inode->i_lock)))
 		return true;
 
+	rcu_read_lock();
 	do {
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&inode->i_lock);
@@ -772,6 +773,7 @@ static bool lock_for_kill(struct dentry *dentry)
 		spin_unlock(&inode->i_lock);
 		inode = dentry->d_inode;
 	} while (inode);
+	rcu_read_unlock();
 	if (likely(!dentry->d_lockref.count))
 		return true;
 	if (inode)
@@ -783,10 +785,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 {
 	if (unlikely(!lock_for_kill(dentry))) {
 		spin_unlock(&dentry->d_lock);
-		rcu_read_unlock();
 		return NULL;
 	}
-	rcu_read_unlock();
 	return __dentry_kill(dentry);
 }
 
@@ -931,14 +931,12 @@ static inline bool fast_dput(struct dentry *dentry)
 
 static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
-	__releases(RCU)
 {
 	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
-		rcu_read_lock();
 	}
 }
 
@@ -978,6 +976,7 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 		return;
 	}
+	rcu_read_unlock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -988,7 +987,6 @@ void d_make_discardable(struct dentry *dentry)
 	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(d_make_discardable);
@@ -1217,7 +1215,7 @@ EXPORT_SYMBOL(d_prune_aliases);
 static inline void shrink_kill(struct dentry *victim)
 {
 	while ((victim = dentry_kill(victim)) != NULL)
-		rcu_read_lock();
+		;
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1233,7 +1231,6 @@ void shrink_dentry_list(struct list_head *list)
 			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		rcu_read_lock();
 		shrink_kill(dentry);
 	}
 }
@@ -1669,6 +1666,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 			struct dentry *v = data.victim;
 
 			spin_lock(&v->d_lock);
+			rcu_read_unlock();
 			if (v->d_lockref.count < 0 &&
 			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
 				struct completion_list wait;
@@ -1676,7 +1674,6 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				// it becomes invisible to d_walk().
 				d_add_waiter(v, &wait);
 				spin_unlock(&v->d_lock);
-				rcu_read_unlock();
 				if (!list_empty(&data.dispose))
 					shrink_dentry_list(&data.dispose);
 				wait_for_completion(&wait.completion);
