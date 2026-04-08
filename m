Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DA381AE1;
	Wed,  8 Apr 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687979; cv=none; b=Qxc4tE1cYHmDyj4fmfpuLw6iAkLm9ixPRQd/JmoCVzUX6bRkhSos6xhDidH3dDxT79bQ1i4gRuGcuPu36tf0QQkp/SYyrHhD1iJWWlUQn7tvd5kh+/EpWDkv/q/CWFDRjR/rrmCpAZi79tqFbnLAyFpk1qxUJEEgdNgSbYzgXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687979; c=relaxed/simple;
	bh=zO8cpU69Yo/rBxVo/fXsWUSGEVR23yKIgYCAeS7fU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ+wME9e/07K+bzpVstYCJ5RuQt/xI465hLBqfWmrxMC4XD+FmVsdwdKn1qwI73uFmJrTtPTAnIK6urA0Fvb09C3d1jObieVnJZbNi0xYm8cL8Yh6H3Qx4npx0akh9Ss0/pWUh/JhZGs77HGg2AyIK6rm/U6BJw7NXTgTuWB35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c8TFaHC3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c8TFaHC3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wAA/I8qZGdGrm1OkqAgxfqOSto1/4h7OXUBnrqJ9dJQ=; b=c8TFaHC3/2QHNtdhh8nX+LWfkD
	Wk54/8lK0jmZwgkQUXbZbq7d1X01tfl8su0C9GHEUrQ8nfdRq0VQI4N6ZWOf9v3T5ilHTh019kPEN
	f8ov7TGxF/pWdqma7VYKTkKIZ7ZSPUbJWMJz2x6EtGtOXzXTJlXfDuh8JK/4UbFni8cAkPxmH3fuZ
	u4CEaLEtjeM8ww28TTyPq/A0hJ9cWe2wekRvuKzv8fLiRJKMrAqVIjqfWY4VOt48G5R1zbdCV7iXs
	FsebcsQp+TLC7iHSsQdt0UCgCwcXcOkqc0QiB3qoT4YiL4YvmwIKa4O95espxvz03Zgs3KwGNvxp0
	3M3CGW1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAbcF-00000000wUD-45mY;
	Wed, 08 Apr 2026 22:43:20 +0000
Date: Wed, 8 Apr 2026 23:43:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	clm@meta.com, gustavold@meta.com
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
Message-ID: <20260408224319.GJ3836593@ZenIV>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
 <20260408064251.GE3836593@ZenIV>
 <f44d1047296ede580c69bdad8e527ac8294746ec.camel@kernel.org>
 <20260408192620.GI3836593@ZenIV>
 <10d8499d60824f319e32f52fd6a196b3645f6652.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d8499d60824f319e32f52fd6a196b3645f6652.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 08, 2026 at 05:05:41PM -0400, Jeff Layton wrote:

> > ... and it still offers zero explanation of the path from livelock to
> > UAF.  It may or may not be real, but there's nothing in all that verbiage
> > even suggesting what it might be.  And proposed analysis is flat-out
> > wrong.
> > 
> > As for the livelock, see viro/vfs.git #work.dcache-busy-wait (in -next
> > as of today).
> 
> Thanks for taking a look, Al. We'll keep looking at this thing and see
> if we can collect more info, and come up with a better theory of the
> crash. I'll dig deeper into the vmcore tomorrow.

OK...  FWIW, on the trees up to 7.0-rc7:
	* dentry passed to select_collect2() must be still attached to
the tree (no DCACHE_DENTRY_KILLED on it)
	* caller holds ->d_lock on that dentry.
	* in case when its ->d_lockref.count is positive, it's busy (at least
at the moment) and there's nothing to be done; move on.
	* in case when its ->d_lockref.count is negative, it's getting killed
right now.  That's a busy-wait case - we ignore it on this pass, but remember
that we'll need to rescan.
	* in case when its ->d_lockref.count is 0 and it's not on a shrink list:
it's evictable, move it to data.dispose, no problem.
	* in case when its ->d_lockref.count is 0 and it *is* on a shrink list:
try to steal it.  We can't do that from the d_walk() callback itself - it's
a non-blocking environment, to start with, so no evictions are possible there.
What we can do is to have it returned to shrink_dcache_tree() - grab rcu_read_lock()
to make sure it won't get freed (it hasn't reached dentry_unlist(), let alone
dentry_free(), so the grace period for freeing hasn't started yet) and tell d_walk()
to stop and return to caller immediately.
	Note that we deliberately return without rcu_read_unlock() - that's what
protects the victim from getting freed under us.  Other thread might or might not
get around to starting the eviction of the victim, but whether it does that or not,
it won't get around to freeing it.
	In shrink_dcache_tree() we grab ->d_lock on the victim again (it had been
dropped by d_walk() when the callback returned).  Then we call lock_for_kill(),
which starts with checking that ->d_lockref.count is 0.  If it isn't, there's
nothing to be done to that sucker; it either went busy (in which case we should
ignore it and move on) or somebody (likely the owner of the shrink list it had
been on) got around to evicting it; in the latter case we need to wait until
the damn thing is killed.  *IF* refcount is still 0, we carefully acquire the
->i_lock on its inode (if any).  Note that we are still holding rcu_read_lock(),
so it can't get freed under us even if we have to drop and regain ->d_lock.
We do need to recheck that refcount is still zero if we do that, obviously.
	Failing lock_for_kill() is either due to dentry becoming busy (and thus
to be skipped) or due to dentry having been passed to __dentry_kill().  In
the latter case we busy-wait, same as we'd do if we saw negative ->d_lockref.count
in select_collect2().
	Successful lock_for_kill() is followed by evicting the sucker;
we do *not* remove it (or its ancestors, if it had been the only thing
holding them busy) from whatever shrink list they'd been on.  Anything on
shrink lists gets reduced to the state of passive chunk of memory no
longer connected to filesystem objects, marked with DCACHE_DENTRY_KILLED
and left for the owner of shrink list to free once it gets around to that.
There's no urgency anymore -
		rcu_read_lock();
		if (!lock_for_kill(dentry)) {
			bool can_free;
			rcu_read_unlock();
			d_shrink_del(dentry);
			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
			spin_unlock(&dentry->d_lock);
			if (can_free)
				dentry_free(dentry);
			continue;
		}
on the shrink_dentry_list() side will have lock_for_kill() return false
(->d_lockref.count already negative), remove the sucker from the list,
see DCACHE_DENTRY_KILLED on it, unlock the sucker and free it.  Note that
nothing in that sequence touches any fs objects - it's just a disposal of
inert chunk of memory now.
	Note that we can't be stealing from ourselves - if anything had
been added to data.dispose, d_walk() sees D_WALK_QUIT or D_WALK_NORETRY
and either buggers off immediately or sets retry to false.  It won't
restart walking the tree in either case, so there's no way for the same
dentry to be revisited by it.

	Having one shrink_dentry_tree() steal from another is OK - see
the conditions when shrink_dentry_list() and __dentry_kill() are calling
dentry_free() (called 'can_free' in both).

	Getting rid of busy-wait is handled with fairly small modification
to that: select_collect2() treats negative refcount same as it would
treat 0-and-on-shrink-list case and shrink_dcache_tree() checks if the
victim has negative refcount and no DCACHE_DENTRY_KILLED yet.  In that
case it adds a local object (struct completion_list node) to a list hanging
off dentry->waiters, evicts whatever else it might've collected, then waits
for dentry_unlist() on the victim to have called complete() on the
node.completion for everything on ->waiters.
	The rest of the logics is unchanged - if victim is not in the
middle of eviction, we try to steal it, etc., same as in the mainline.
