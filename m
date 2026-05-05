Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A71DE894
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020961; cv=none; b=jbQrafNQ0I86WDDZ7DW6/mgaxUJ8hRca0s5PVrsZ+n/oOY2HG2feGJJBPyjYvCoAwq0wHJ2HsH8zSi4ynclnZsqhz+d1sw5DTkvhMom6cOdNFllhXCarP0HkiHBTtrKeGBbVuvEpesd5IbshnICHQ3yNYAAG4yNvAl/dxpWUMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020961; c=relaxed/simple;
	bh=WmRf2Evu2n2EfWPeDEg4udlPWdG1q+5BKrO4skAY5N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfx21Oji7Ubkz8aWaeGz0X+hB5xJUCVRgcRgtCtsWNl6X8PiDQc0NUFUT6w+8dba3ImJtm3b5V2E0IuKmOj+BcZ/FHzU/nHHmj/44dJuoww2D9d1Cz/Ev+C9psRB/VXXGKV3yhx32CfVG+enlBt2Jqm5LZIbndfP7gbZrX2AvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pr9w9jMP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pr9w9jMP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Fk8zasSaDR4SXFKTSFqllvdmufUOkwUrSuCl00CFJXY=; b=pr9w9jMPORsjBBrL5cBg40Rrec
	gSud8uQY6RVxDQ18nKTeXGvlIBd64PeAzzpwwenfu66gSlSU5gQPY23XDG+1Mi5u87G6ZyYElAdLP
	XEHSdmpsb5a6gKBDxd55m4SbhfYN0RExl6ecvyuZXVRpEK0s101BqY34gwOCcCWlNjL1/1lUq2pgB
	5ouQGsjWfbIpDCySQuTFg4c2HZOPgiOQRTmuQTrA/Wd9dfl6COGw4rHjnet8p7omSOGsz9Y9/E+H2
	ipb4TOqL2Od3lmrnbDkWKPbz11lj5r7FD+D72t8ZU/lBT8eJ/x1G9F1gyAr+U/mxWur+FoYUQNIK8
	FID1iGvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKOTg-000000095AM-33MK;
	Tue, 05 May 2026 22:42:56 +0000
Date: Tue, 5 May 2026 23:42:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
Message-ID: <20260505224256.GH3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
 <CAADWXX_dChuduyjE2=h4JsRkX1Tbjhgw47p0v9KOSbHkWCs7ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX_dChuduyjE2=h4JsRkX1Tbjhgw47p0v9KOSbHkWCs7ng@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 09:47:03AM -0700, Linus Torvalds wrote:
> On Mon, May 4, 2026 at 10:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > This one breaks rcu_read_lock() scopes in front of shrink_kill() call
> > in shrink_dentry_list() and finish_dput() call in dput(); in both
> > places we are withing ->d_lock scope, so doing that won't change
> > the RCU read-side critical areas.
> 
> Ugh.
> 
> Ok, so I see what this does and why it does it, but I still dislike
> this one intensely. That
> 
>          rcu_read_unlock();
>          rcu_read_lock();
> 
> pattern is just ugly, and I'd like to see any actual numbers that it
> makes a real latency difference.

It almost certainly doesn't; the only point is to split the changes into
equivalent transformations - the whole thing is tricky enough as it is.

> > With that done, we have all calls of shrink_kill() and finish_dput()
> > immediately preceded by rcu_read_lock(); next step will use that.
> 
> Yes, the next patch at least removes the ugly pattern. It still
> obviously *does* the same "drop and immediately re-take", just without
> making it as obvious.

Yes, and the next two steps after that drive those down into lock_for_kill(),
where we finally get the sucker off the fast path - it's not (re)taken unless
trylock on inode->i_lock fails and we have to play games with dropping and
retaking ->d_lock.

> Honestly, if this is then going to make some still later patch
> cleaner, I'd prefer 12/13 to be just combined into one "change rcu
> locking semantics to be better".
> 
> Because as-is, I think patch 12 on its own is just ugly.
> 
> It looks like patch 14 then uses the thing to clean up dentry_kill() a
> bit, so that combined patch wouldn't trigger my "this is just ugly"
> case, adn would still have a real reason for it (outside of a
> theoretical "shrink rcu region" without numbers to say why it's
> needed).

The main payoff is in #15, really.  The entire 12--17 started as a single
commit, which I fucked up on the first two attempts.  Thus the carve-up
into chunks too small for idiot me to fumble...

FWIW, an issue with large rcu_read_lock() scopes (as opposed to RCU read-side
critical areas) is that they are harder to reason about; having them cover
smaller chunks makes it a lot more obvious what each one is for.

In the fs/dcache.c after this series:
1. dentry_name_snapshot().  Protection of external name - from fetching
->d_name.name to atomic_inc_not_zero() on the external name refcount.
The paired RCU delay is somewhat subtle and needs to be documented.
In release_dentry_name_snapshot() and copy_name() it's the use
of kfree_rcu() when refcount hits zero; that's the obvious part.
In dentry_free() it's having __d_free_external() called via call_rcu(),
regardless of DCACHE_NORCU on dentry itself.

2. lock_for_kill().  Bridging over the spinlock switchover in case of
trylock failure, protecting dentry and inode from being freed.
Safety for !NORCU case: freeing of dentry is RCU-delayed due to !NORCU,
freeing of inode is RCU-delayed with 3 exceptions.  Inode must have
non-NULL ->destroy_inode(), NULL ->free_inode() and ->destroy_inode()
must do prompt freeing (the last part excludes XFS)
	* pipefs inodes (only on NORCU dentries, except for pipefs root,
which is never dropped)
	* btrfs-test inodes.  A bug, should have btrfs_test_destroy_inode()
reduced to the call of btrfs_drop_extent_map_range(), with ->free_inode
set to btrfs_free_inode, same as for btrfs proper.  Not triggered due to
the very limited use of those suckers - it's never exposed to userland and
self-tests don't step into that fun.
	* bpffs inodes.  A bug.  Another manifestation of the same bug had
been reported by folks doing fuzzing; I'd posted a completely untested fix
about a week ago, need to return to it (Alexey replied with "Feel free to
take it into your tree directly", I didn't get around to testing it yet).

Safety for NORCU case: we only get there if dentry refcount had
been dropped to zero by ourselves; no other thread will be calling
dentry_kill() on that dentry *or* making it negative.  IOW, neither
dentry nor inode are going to be even scheduled for freeing until after
we return.

3. fast_dput().  Protected area from attempted decrement of refcount
to either having grabbed ->d_lock or to deciding that we are done
and returning true, protecting dentry from being freed.  Safety for
!NORCU: dentry freeing is RCU-delayed; if it's already scheduled by
the time we have grabbed ->d_lock, we'll observe a negative number
in ->d_lockref.count, drop ->d_lock and that'll be our last access to
dentry.  Safety for NORCU: if decrement succeeds and yields non-zero,
we are not touching dentry anymore.  If it succeeds and yields zero, no
other thread will be able to increment the refcount, so no other thread
will be able to drive it back to zero.  As the result, no other thread
will even attempt to call dentry_kill(), let alone free the sucker.
The comment in front is stale - will update.

4. dget_parent().  Protects candidate parent from freeing.  Protected area
from fetching ->d_parent to lockref_get_not_zero() on its refcount.
Safety: NORCU dentries are never anyone's parents (and argument of
dget_parent() is held by the caller).  For !NORCU dentries freeing
is RCU-delayed.

5. dget_parent().  Protects candidate parent from freeing.  Protected area
from fetching ->d_parent to grabbing ->d_lock on it.  Safety: same as the
previous one.  FWIW, I wonder if this
	rcu_read_lock();
	ret = dentry->d_parent;
	spin_lock(&ret->d_lock);
	if (unlikely(ret != dentry->d_parent)) {
		spin_unlock(&ret->d_lock);
		rcu_read_unlock();
		goto repeat;
	}
	rcu_read_unlock();
would be better off as
	rcu_read_lock();
	ret = dentry->d_parent;
	spin_lock(&ret->d_lock);
	rcu_read_unlock();
	if (unlikely(ret != dentry->d_parent)) {
		spin_unlock(&ret->d_lock);
		goto repeat;
	}
Or, for that matter, as
	scoped_guard(rcu) {
		// grab ->d_parent->d_lock safely
		// NORCU dentries can't be anyone's parents
		ret = dentry->d_parent;
		spin_lock(&ret->d_lock);
	}
	// dentry->d_parent is not stable; however, the result of comparison is
	// - the set of children is stabilized by ->d_lock
	if (unlikely(ret != dentry->d_parent)) {
		spin_unlock(&ret->d_lock);
		goto repeat;
	}

5. d_walk().  Bridging over from ->d_lock on dentry to ->d_lock on
this_parent (aka dentry->d_parent, fetched under dentry->d_lock),
protecting this_parent from being freed.  NORCU dentries are never
parents, so freeing this_parent is RCU-delayed.

6. select_collect2().  Found dentry that isn't busy and can't be placed
into our shrink list; need to return it to caller's caller, protecting
it from being freed.  We are in ->d_lock scope, but that'll end in the
caller, so we need to extend the RCU read-side critical area all the
way into shrink_dcache_tree() (caller's caller).  The end of scope is
in shrink_dcache_tree(), after it has grabbed ->d_lock.  NORCU dentries
are never passed to d_walk() callbacks, so freeing is RCU-delayed.

7. shrink_dcache_for_umount().  Bridging over from ->s_roots_lock to
->d_lock, protecting the secondary root we'd found from being freed; NORCU
dentries are never anyone's secondary roots, so freeing is RCU-delayed.

8. __d_lookup().  Protects hlist_bl_for_each_entry_rcu traversal of the hash
chain.  All ->d_hash modifications are done by RCU-aware primitives (and
serialized on chain's bitlock), NORCU dentries are never hashed, so freeing
of anything we walk into is RCU-delayed.

9. d_alloc_parallel().  Scope from __d_lookup_rcu() to lockref_get_not_dead().
Protects the hash chain traversal in __d_lookup_rcu() from being disrupted
under us and its result from being freed under us; NORCU dentries are never
returned by __d_lookup_rcu().

10. d_alloc_parallel().  Bridges over from the bitlock of in-lookup
hash chain to ->d_lock, protects the found match from being freed.
->d_lock nests outside of the chain's bitlock, so we need to transfer.
Nothing on the in-lookup hash chains is NORCU, so freeing is RCU-delayed.

11. is_subdir().  Somewhat excessive - we only need it around the lockless
call of d_ancestor(), to protect ->d_parent involved from freeing.

Additionally we have two functions that rely upon rcu_read_lock() held
by the caller: __d_lookup_rcu(), __d_lookup_rcu_op_compare().  Both
use it to protect the hash chain traversal (with the same iterator as
__d_lookup()); again, hash chain modifications are all by RCU-aware primitives
and no NORCU dentries are ever hashed, so nothing we walk through can be freed
under us.  The latter provides RCU read-side critical area for ->d_compare(),
protecting dentry argument, the external name (if any) and whatever objects
the method itself might need (if any).

d_same_name() and dentry_cmp() are interesting - they rely either upon
being called in RCU read-side critical area, protecting dentry and external
name (if any) from being freed along with whatever objects required by
->d_compare() (in case of d_same_name()) OR upon being called with dentry
having name and parent stable and an active reference to superblock held
by the caller.
