Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977D261B92
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852421; cv=none; b=MQIyoTLqrByBGEEcNNL1tSS1lg6yvujGC8Amy2WiBF9isryvFImLy2tvX6Ocxyw6F0H9khr2DyptCvykg2qgvcKU3GSsm7+/R7DftUnfKgBL1SyRvxDPBNs1z/zuOeLY0cWzqiXCC0qMCaGPzhQ8thw73zS5TjXvo9kW+8Qs0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852421; c=relaxed/simple;
	bh=QbaGypw7p3uvzJBOE5OWmhmsxfgS56mgyR7bktugYa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSL4UEpIYDpllrk3SC/HkBTsvD6p55W7dwPMHDB2B+x6koMx6y/45eutSVpE0CQIM/O0TjO7xVP4Yw3VPMZ8zQdjNuMPwibDFQBEBBHaDmueC3UorvR9XBx92LI77KivvRnU3rgrlKMaRldvbHcLEH1P1clDU9XhKVf7Lyf76lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i8q6mnII; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i8q6mnII"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UsVWIGKtUHKoMFQvUUypoGXttoFtkrJK4AxYpLs04zE=; b=i8q6mnIIP6T6+6NQJy45zNhq6f
	FbmXNPi6zuL70Ig0GoSNR0EGetvb/Ug1r+RlEO9iO/3VXh0SV9f7a0FIcpQKv5e0L8fEmHs8+8OMH
	HQaA5YpXj8iHCLduOROH0jpcyKIHgtjmjLfOZ0kdF/+5+VCron0KGhJZzHT98ukiOM7ujGT32/WXe
	S22CH3oDf5mf9Y1LD9sK/zZNMjQc+sKpK3Zrt2iAjmP37pLL5LvsQnd7OkZa1Eh8lnVy6rYtqre3M
	RNvIwaG3dFJvDopDKYLqpYHYwLMquR+lnJyEL79SaljJxuWknfFcPL9JWZvymv6LKqNq/ciADc7Rv
	OHTWu3Sg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBIOa-00000007a0o-3LAH;
	Fri, 10 Apr 2026 20:24:04 +0000
Date: Fri, 10 Apr 2026 21:24:04 +0100
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
Message-ID: <20260410202404.GW3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <20260410185243.GU3836593@ZenIV>
 <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 12:30:13PM -0700, Linus Torvalds wrote:

> The reason it exists is because lock_for_kill() can drop d_lock(), but
> that's in the unlikely case that we cn't just immediately get the
> inode lock.
> 
> So honestly, I think that rcu_read_lock() should be inside
> lock_for_kill(), rather than in the caller as a "just in case things
> go down".

Yup, in the cascade of followups I've mentioned...

> IOW, that code basically now not only does that typically unnecessary
> rcu locking (and then unlocking), it does so *because* it knows about
> the subtle internal behavior of lock_for_kill().
> 
> In contrast, if we put it inside lock_for_kill(), all we need is a
> fairly straightforward comment along the lines of
> 
>   "we're dropping the spinlock in order to take the inode lock, but
> the caller may be depending on RCU behavior so we need to take the rcu
> read lock first".
> 
>  that would turn strange illogical code that also generates worse code
> into straightforwardly explained code that also performs better.
> 
> Ok, so "performs better" is kind of exaggerated, in that obviously the
> extra rcu_read_lock/unlock sequences aren't exactly expensive, but
> still - I feel it's a win-win to just do this differently.
> 
> Or am I missing somethign else?

Mostly that fast_dput() calling conventions would need to change a bit
as well.

With the above as step 1,

Step 2: fold lock_for_kill() into shrink_kill().  Result: 2 call sites of
lock_for_kill() left, shrink_kill() becomes
static inline void shrink_kill(struct dentry *victim)
{
	while (lock_for_kill(victim)) {   
		rcu_read_unlock();
		victim = __dentry_kill(victim);
		if (!victim)
			return;
		rcu_read_lock();
	}
	spin_unlock(&victim->d_lock);
	rcu_read_unlock();
}
shrink_dentry_list() and shrink_dentry_tree() calling shrink_kill()
without bothering with lock_for_kill().

Step 3: note that both call sites of lock_for_kill() are followed with the
same sequence - drop ->d_lock + rcu_read_unlock on failure,
rcu_read_unlock + __dentry_kill() on success.  And these are the
only callers of __dentry_kill().  Moreover, NULL from __dentry_kill()
means "bugger off" in both callers.  So add

struct dentry *dentry_kill(dentry)
{
	if (!lock_for_kill(dentry)) {
		spin_unlock(&dentry->d_lock);
		rcu_read_unlock();
		return NULL;
	}
	rcu_read_unlock();
	return __dentry_kill(dentry);
}
and convert both callers to that:
static inline void shrink_kill(struct dentry *victim)
{
	while ((victim = dentry_kill(victim)) != NULL)
		rcu_read_lock();
}
and
static void finish_dput(struct dentry *dentry)
{
	while ((dentry = dentry_kill(dentry)) != NULL) {
		if (retain_dentry(dentry, true)) {
			spin_unlock(&dentry->d_lock);
			return;
		}
		rcu_read_lock();
	}
}

Step 4: note that callers of shrink_kill() and finish_dput()
have dentry->d_lock held.  We can (assuming there's no RCU
bugs) drop the lock before calling them and grab it the
first thing in.  Moreover, we can shift grabbing it into
lock_for_kill(), leaving these
static inline void shrink_kill(struct dentry *victim)
{
	while ((victim = dentry_kill(victim)) != NULL)
		;
}
and
static void finish_dput(struct dentry *dentry)
{
	while ((dentry = dentry_kill(dentry)) != NULL) {
		if (retain_dentry(dentry, true)) {
			spin_unlock(&dentry->d_lock);
			return;
		}
	}
}
resp., with the callers becoming
void dput(struct dentry *dentry)
{
	if (!dentry)
		return;
	might_sleep();
	rcu_read_lock();
	if (likely(fast_dput(dentry))) {
		rcu_read_unlock();
		return;
	}
	rcu_read_unlock();
	finish_dput(dentry);
}

void d_make_discardable(struct dentry *dentry)
{
        spin_lock(&dentry->d_lock);
        WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
        dentry->d_flags &= ~DCACHE_PERSISTENT;
        dentry->d_lockref.count--;
        finish_dput(dentry);
}

void shrink_dentry_list(struct list_head *list)
{
        while (!list_empty(list)) {
                struct dentry *dentry;
 
                dentry = list_entry(list->prev, struct dentry, d_lru);
                spin_lock(&dentry->d_lock);
                d_shrink_del(dentry);
		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED) {
                        spin_unlock(&dentry->d_lock);
			dentry_free(dentry);
			continue;
		}
                shrink_kill(dentry);
	}
}

and, in shrink_dentry_list(),
                        spin_lock(&v->d_lock);
			rcu_read_unlock();	// now held by ->d_lock
                        if (v->d_lockref.count < 0 &&
                            !(v->d_flags & DCACHE_DENTRY_KILLED)) {
                                struct completion_list wait;
                                // It's busy dying; have it notify us once
                                // it becomes invisible to d_walk().
                                d_add_waiter(v, &wait);
                                spin_unlock(&v->d_lock);
                                if (!list_empty(&data.dispose))
                                        shrink_dentry_list(&data.dispose);
                                wait_for_completion(&wait.completion);
                                continue;
                        }
			shrink_kill(v);

lock_for_kill() has grown a call of rcu_read_lock() in the very beginning,
will be gone shortly.

Step 5: pull the followup rcu_read_unlock() (and dropping ->d_lock on
failure) into lock_for_kill(); again, that assumes no RCU bugs there:
static bool lock_for_kill(struct dentry *dentry)
{
        struct inode *inode = dentry->d_inode;
 
        if (unlikely(dentry->d_lockref.count)) {
		spin_unlock(&dentry->d_lock);
                return false;
	}
 
        if (!inode || likely(spin_trylock(&inode->i_lock)))
                return true;
 
	rcu_read_lock();
        do {   
                spin_unlock(&dentry->d_lock);
                spin_lock(&inode->i_lock);
                spin_lock(&dentry->d_lock);
                if (likely(inode == dentry->d_inode))
                        break;
                spin_unlock(&inode->i_lock);
                inode = dentry->d_inode;
        } while (inode);
	rcu_read_unlock();
        if (likely(!dentry->d_lockref.count))
                return true;
        if (inode)
                spin_unlock(&inode->i_lock);
	spin_unlock(&dentry->d_lock);
        return false;
}

and in dentry_kill()
{
	if (!lock_for_kill(dentry))
		return NULL;
	return __dentry_kill(dentry);
}

Step 6: fold __dentry_kill() into dentry_kill().

Step 7: both callers of fast_dput() are identical:
        rcu_read_lock();
        if (likely(fast_dput(dentry))) {
                rcu_read_unlock();
                return;
        }
	rcu_read_unlock();
(in dput() and dput_to_list()).  Pull rcu_read_lock() and rcu_read_unlock()
into fast_dput(); ends up with 5 lines added there.  Result (with comments
skipped) is
static inline bool fast_dput(struct dentry *dentry)
{
        int ret;
 
	rcu_read_lock();		// added
        ret = lockref_put_return(&dentry->d_lockref);
 
        if (unlikely(ret < 0)) {
                spin_lock(&dentry->d_lock);
		rcu_read_unlock();	// added
                if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
                        spin_unlock(&dentry->d_lock);
                        return true;
                }
                dentry->d_lockref.count--;
                goto locked;
        }
        if (ret) {
		rcu_read_unlock();	// added
                return true;
	}
        if (retain_dentry(dentry, false)) {
		rcu_read_unlock();	// added
                return true;
	}
        spin_lock(&dentry->d_lock);
	rcu_read_unlock();		// added
locked:
        if (dentry->d_lockref.count || retain_dentry(dentry, true)) {
                spin_unlock(&dentry->d_lock);
                return true;
        }
        return false;
}

Callers become
void dput(struct dentry *dentry)
{
	if (!dentry)
		return;
	might_sleep();
	if (likely(fast_dput(dentry)))
		return;
	finish_dput(dentry);
}
and
void dput_to_list(struct dentry *dentry, struct list_head *list)
{
	if (likely(fast_dput(dentry)))
		return;
	to_shrink_list(dentry, list);
	spin_unlock(&dentry->d_lock);
}
resp.
