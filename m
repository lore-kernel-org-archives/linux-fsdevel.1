Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9823FB067;
	Wed, 17 Jun 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702008; cv=none; b=McX++8rdBMuBv9nt3HXC1jdLqk4DKXi9UqWalm7n3UGtFzafK/PX26woK52SsrpAu3tC4JKLDz3aHX+Sr30FuPiih0oeTnB+OKP0k+joqolt1zSP8A8E9d3pYBvlHuSQ79jxpSmAYEloFeb9iRYso8Ni/4U1lNpd8XkHh5Lv1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702008; c=relaxed/simple;
	bh=uLIkjIH6UA6lUNjHG6Eld99VahjKT91mHOOhBEpCmsg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Ft14QSCxIcrcYelBshE6ELDxJFE5yZvKcrhSnXkKPA/w5dhY5fBSrnT4adNICVJwCX6a/0r9F1Ik1T+W0giEBhgFtsuD7i57Zq5xhMvyiN4mT5M872nSHiubGnac9jMuRDtJWJrMZg/lllavz5g+0nxM7VOknXWy23GayBFj7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnKO/8iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnKO/8iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EBE1F00A3A;
	Wed, 17 Jun 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702007;
	bh=sIJFllTN+ErYFl3rqOHR1loUOoaBeehdkIbcMx1CiWg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QnKO/8iV3A84vXXc+p4ooKjr5IBSJzT4kH2Q9zrQAfuaU04/jfrI+ykOf6mvz5dCr
	 9xF3hNopn8Ye4ENZZjtaTTqTJ64ElL6yhU6n8ObJrUjQ9v2ppJOR3FvA/4qJHk0jBy
	 vnsBSQc/TuWLzCBvOOMEh5Lz8bTzRST8wxGv6N9qtiq3AfLqpCXjk1z3so2eyXNqTf
	 IFWJRzfhIU8Xt5AsekQPsbN+O6Nw1MBV3N3xSmmYXhRW/SaXuovqHrHBmeOi0WIMV+
	 Nz6oQFAkLEF0vi2exig+eLDGX+AXW7SFR7ps6wP6653R8SJqQ6QLubnggBTcJyPpJq
	 iNgsyxR4Qn3zg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] pidfs: pin stashed dentry for pid lifetime to fix
 repeat-open regression
From: Christian Brauner <brauner@kernel.org>
To: "A. Sterling" <adam.sterling@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612110529.80055-1-adam.sterling@gmail.com>
References: <20260612110529.80055-1-adam.sterling@gmail.com>
Date: Wed, 17 Jun 2026 15:13:21 +0200
Message-Id: <178170200118.647694.12090464785182538286.b4-review@b4>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=8213; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uLIkjIH6UA6lUNjHG6Eld99VahjKT91mHOOhBEpCmsg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZzS3NN9q6/1+Ilf3vfpeP9gZOK9Scmz4f4Lzcv+hm7
 2+mHyvvdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkfycjw+cFoivLzdYc4avX
 LdG0X1i9mzWmKIHjmeIqjeUrKt9NymX4X/p+1rWVL0w/TjizLkMn9PjW3573I0XeBrzMFK0QtV5
 lxgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Commit cb12fd8e0dab ("pidfd: add pidfs") moved pidfds from anonymous
> inodes to a pseudo filesystem, with the intent that pid->stashed would
> cache the dentry+inode across multiple pidfd_open() calls for the same
> struct pid.  Commit b28ddcc32d8f ("pidfs: convert to path_from_stashed()
> helper") realized that intent via the stashed_dentry_get() fast-path.
> 
> In practice the stash cache never hits for serial open/close patterns.
> pidfs dentries are anonymous (d_alloc_anon) and the superblock raises
> DCACHE_DONTCACHE, so dput() at close() drops the refcount to zero and
> immediately destroys the dentry.  __dentry_kill -> d_prune ->
> stashed_dentry_prune cmpxchg()es pid->stashed back to NULL, and the
> last iput() runs pidfs_evict_inode().  The next pidfd_open() finds an
> empty stash slot and reallocates both the inode (new_inode_pseudo +
> simple_inode_init_ts + sops->init_inode) and the dentry (d_alloc_anon
> + d_instantiate + cmpxchg into the stash slot).
> 
> Measured with a small benchmark that times a single pidfd_open()
> syscall on a live process, best-of-k per run (written for this
> investigation as part of an extended fork of the LEBench suite,
> Ren et al. SOSP'19; the test is not part of upstream LEBench).
> QEMU/KVM x86_64 guest, 5 runs per kernel, RSD <1%, kernels v5.19
> to v7.1-rc2:
> 
>                             v5.19   v6.0    v6.9 (pidfs)   v7.1-rc2
>   pidfd_open kbest (us)      0.40   0.39          [step]       0.50
> 
> i.e. ~25% slower than the pre-pidfs anon_inode baseline, persistent
> through current.  The cost is a kmem_cache_alloc on inode_cachep + a
> clock read (simple_inode_init_ts) + a kmem_cache_alloc on dentry_cache
> per call, all of which can be elided when the stash cache hits.
> 
> With this patch applied to v7.1-rc4 (same guest, median kbest
> across 5 boots, kernels built with the pidfd selftest config
> requirements enabled):
> 
>                             v7.1-rc4 stock   v7.1-rc4 + patch
>   pidfd_open kbest (us)          0.489           0.349  (-28.6%)
> 
> All eight buildable pidfd kselftest suites (41 tests, including the
> file_handle suite that exercises the stashed-dentry path with
> CLONE_NEWUSER children) pass identically on the stock and patched
> kernels.
> 
> The patched kernel is faster than the pre-pidfs anon_inode baseline
> (0.40 us at v5.19/v6.0): a stash hit reuses the cached dentry and
> inode outright, where the anon_inode path still performed per-call
> file setup against the shared inode.
> 
> Fix by holding an extra reference to the stashed dentry for as long as
> the task is alive.  pidfs_alloc_file() takes a dget() on the first
> successful path_from_stashed() per pid, recorded by a new
> PIDFS_ATTR_BIT_STASH_PINNED bit in pid->attr->attr_mask.  pidfs_exit()
> -- which already runs in sleepable context from release_task() --
> drops the reference.
> 
> pidfs_alloc_file() is reachable after pidfs_exit() has already run:
> SO_PEERPIDFD and SCM_PIDFD hold struct pid references on sockets and
> can allocate pidfds for already-reaped peers (the PIDFD_STALE path).
> A pin taken on that path could never be dropped, since pidfs_exit()
> will not run again.  Both the pin and the unpin therefore take
> pid->wait_pidfd.lock -- the lock pidfs_exit() already uses to
> synchronize with pidfs_register_pid() -- and the pin is skipped once
> PIDFS_ATTR_BIT_EXIT is set:
> 
>   - pin before exit's unpin section: the unpin sees the bit, drops
>     the reference.  Balanced.
>   - exit's unpin section before the pin attempt: PIDFS_ATTR_BIT_EXIT
>     is set before the unpin section, so the later allocation observes
>     it under the lock and does not pin.  Stale allocations behave as
>     they do today (per-call inode+dentry), which is acceptable: the
>     cache targets live processes.
> 
> The unpin's dput() runs outside the lock (pidfs_exit() is sleepable;
> dput must not run under a spinlock).  While pinned, the reference
> keeps the dentry alive, so stashed_dentry_prune() cannot run and
> pid->stashed still points at the pinned dentry when pidfs_exit()
> reads it.
> 
> Unpinning at pidfs_free_pid() instead is not possible: the pinned
> dentry holds the inode, the inode holds a pid reference
> (pidfs_evict_inode() does put_pid()), so the pid refcount cannot
> reach zero while the pin is held and pidfs_free_pid() would never
> run.
> 
> Memory cost is one inode (~800 B) + one dentry (~200 B) per pid that
> has ever had a pidfd allocated, held until release_task() instead of
> until the last fd close.  Bounded by pid_max.  Tasks that never have
> a pidfd allocated are unaffected.
> 
> The existing VFS_WARN_ON_ONCE(pid->stashed) assertion in
> pidfs_free_pid() is preserved: the exit-time dput triggers the
> existing teardown chain (__dentry_kill -> stashed_dentry_prune ->
> pidfs_evict_inode) before pidfs_free_pid runs.
> 
> Fixes: cb12fd8e0dab ("pidfd: add pidfs")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: A. Sterling <adam.sterling@gmail.com>
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index aaa609ddab04..49585e763ccb 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -46,8 +46,9 @@ void pidfs_get_root(struct path *path)
>  }
>  
>  enum pidfs_attr_mask_bits {
> -	PIDFS_ATTR_BIT_EXIT	= 0,
> -	PIDFS_ATTR_BIT_COREDUMP	= 1,
> +	PIDFS_ATTR_BIT_EXIT		= 0,
> +	PIDFS_ATTR_BIT_COREDUMP		= 1,
> +	PIDFS_ATTR_BIT_STASH_PINNED	= 2,
>  };
>  
>  struct pidfs_anon_attr {
> @@ -717,6 +718,7 @@ void pidfs_exit(struct task_struct *tsk)
>  {
>  	struct pid *pid = task_pid(tsk);
>  	struct pidfs_attr *attr;
> +	struct dentry *unpin = NULL;
>  #ifdef CONFIG_CGROUPS
>  	struct cgroup *cgrp;
>  #endif
> @@ -757,6 +759,23 @@ void pidfs_exit(struct task_struct *tsk)
>  	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
>  	smp_wmb();
>  	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
> +
> +	/*
> +	 * Drop the per-pid stash reference taken by pidfs_alloc_file()
> +	 * (see PIDFS_ATTR_BIT_STASH_PINNED).  The wait_pidfd.lock guard
> +	 * orders this against the pin in pidfs_alloc_file(): once
> +	 * PIDFS_ATTR_BIT_EXIT is visible under the lock, no new pin can
> +	 * be taken.  dput() runs outside the lock; on the final
> +	 * reference it triggers __dentry_kill -> stashed_dentry_prune
> +	 * -> pidfs_evict_inode, the existing teardown path.
> +	 */
> +	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
> +		if (test_and_clear_bit(PIDFS_ATTR_BIT_STASH_PINNED,
> +				       &attr->attr_mask))
> +			unpin = READ_ONCE(pid->stashed);
> +	}
> +	if (unpin)
> +		dput(unpin);
>  }
>  
>  #ifdef CONFIG_COREDUMP
> @@ -1125,6 +1144,32 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  
>  	VFS_WARN_ON_ONCE(!pid->attr);
>  
> +	/*
> +	 * Pin the stashed dentry for the lifetime of the task so that
> +	 * repeat pidfd_open() on the same pid reuses the cached dentry
> +	 * + inode instead of reallocating both each time.  Anonymous
> +	 * pidfs dentries don't enter the dcache LRU (DCACHE_DONTCACHE),
> +	 * so without an explicit reference the dput() at close()
> +	 * immediately destroys the dentry and, via
> +	 * stashed_dentry_prune, the inode.
> +	 *
> +	 * Skip the pin once PIDFS_ATTR_BIT_EXIT is set: pidfs_exit()
> +	 * has run (or is running) and will not run again, so a
> +	 * reference taken now could never be dropped (stale
> +	 * allocations via SO_PEERPIDFD reach here after
> +	 * release_task()).  The wait_pidfd.lock guard makes the EXIT
> +	 * check and the pin atomic against the unpin in pidfs_exit().
> +	 */
> +	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
> +		struct pidfs_attr *attr = pid->attr;
> +
> +		if (!IS_ERR_OR_NULL(attr) &&
> +		    !test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask) &&
> +		    !test_and_set_bit(PIDFS_ATTR_BIT_STASH_PINNED,
> +				      &attr->attr_mask))
> +			dget(path.dentry);


Anywhere pidfs_alloc_file() is called where cleanup doesn't pass through
pidfs_exit() will permanently leak the dentry. That needs to be fixed.

-- 
Christian Brauner <brauner@kernel.org>
