Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CC30566C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783805902; cv=none; b=XXPCdj63xBlemANblFR86UvAb3ExkvEyOcL+viAiBhheuXUUdKRs8b6S2XFKJigict2LxLn54TKMDm+dB83oz3rab2FNax4G8ICwOk/Ds8P6rvs759itgA7J2+6DYV97QiPnKjWrav/XW72Ry8mOalQU9nLtEZe2clEUmpXMcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783805902; c=relaxed/simple;
	bh=V2iJnFkZccH44+FQbKBoyhUXCM8mtCukj6KA25ipKPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb8YqxvQkH6t7NaWuFSXS5g41WHphLlK/WGTMtmiPEZwj+fwPKA+Tsw7WzNN3HstlGMWu58ybQZ99ENXRes5Eqiq7YOwrFI9z/st/8/hx2tNxzYhxVY3BM3eMWuwmIYTGaPb6nmRxHgO+tQi1JebmEbwMkCWocJ7AnzIJ94MICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NtgbPoJJ; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NtgbPoJJ"
X-KPN-MessageId: cf11c8de-7d70-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cf11c8de-7d70-11f1-b2a8-005056abbe64;
	Sat, 11 Jul 2026 23:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=SBJebS8jLRzRA7+SKiwlGxr0ddufRJVoJrg6ial4USo=;
	b=NtgbPoJJ4SWd+BrFbHtqhBI4aoirr1sZ7+KiVO7kuxZ6mDK5xWwoWEiV4wSTy4l4xCAeCPqpzTuZc
	 gKh7twiR3XyZoSBIkSUqJJyPkrza42oVXeJ0IaUpT9EtRb/nVRuhLZpm1o99eMX7VK79qF2/948KB4
	 V1//bK/GWYvqQxSsYYB0PhtuhWaV5OlfYm6Z4nZOM17/r1fZ+z84BNEmOXENmsP/brtXR/YB2vWdpR
	 b1IYN5lGnzcZX3NCHQ3YpOR6AXBEA7RAd8D58Yet9fEpj5iu6/LhOX7K5fqhB4Fvfm4yzezVfO1Rfl
	 Uio/VEaEwdxV2hvGLIzTtr4j/RcePVA==
X-KPN-MID: 33|qNAdK+3j9nNmPD9YkJ021KjAR0T2MYWFOKG3z7M12lNW65D1hNJygaD+35oUWnR
 6pGcnYSOP+c5lV0gkny1biYJHf+heogZtivdTsrZCct0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6GB5UOB/HSmz5cXV+uMjp+q2hlashJ9GVHX0QmFKYv18TSPm14Yv6eNJKRVKFkF
 1uVZ5W+dmBitp+cl1G9xYYg==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ce6bb879-7d70-11f1-a8b4-005056ab7447;
	Sat, 11 Jul 2026 23:38:08 +0200 (CEST)
Date: Sat, 11 Jul 2026 23:38:04 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 05/24] binfmt_misc: use RCU for the handler lookup
Message-ID: <alKzv9cAGT0yqSW6@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-5-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-5-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:06AM +0200, Christian Brauner wrote:
> Once binfmt_misc is loaded load_misc_binary() runs for every execve()
> on the system since binfmt_misc registers at the head of the formats
> list. Every exec therefore performs read_lock() and read_unlock() on
> the entries_lock of the relevant binfmt_misc instance, i.e., two
> atomic read-modify-writes on a shared cacheline. User namespaces
> without their own binfmt_misc mount fall back to an ancestor's
> instance so on container-heavy systems every exec on the machine
> typically ends up hammering the cacheline of init_binfmt_misc. On
> PREEMPT_RT the rwlock additionally turns the handler lookup into a
> sleeping lock on the exec fast path.
> 
> The lock protects very little. Entries are immutable after publication
> except for the Enabled bit which is already toggled locklessly via
> set_bit()/clear_bit() and entry lifetime is already handled by the
> users refcount via get_binfmt_handler()/put_binfmt_handler(). The read
> lock's only remaining job is to make "the entry is still linked" and
> "take a reference" atomic with respect to the unlink sites.
> 
> Switch the lookup to an RCU walk:
> 
> * Lookup walks the entry list under rcu_read_lock() and acquires a
>   reference via refcount_inc_not_zero(). The refcount can only drop to
>   zero after an entry has been unlinked so a failed increment means
>   the walk raced with an unlink. Restarting the search is bounded
>   because an unlinked entry cannot be found again.
> 
> * The unlink sites use hlist_del_init_rcu() which keeps the forward
>   pointer intact for concurrent walkers and preserves hlist_unhashed()
>   as the protection against double removal.
> 
> * The final put frees the entry via kfree_rcu() as a concurrent walker
>   may still dereference its flags, magic, mask, and inline strings.
>   They all live in the entry allocation itself and thus stay valid
>   until a grace period has elapsed. Closing the interpreter file stays
>   synchronous. It is only used with a reference already held and all
>   final puts run in process context.
> 
> * Writers remain serialized by the inode lock of the root dentry with
>   one exception. bm_evict_inode() called from generic_shutdown_super()
>   during umount unlinks entries without holding it. Keep a spinlock
>   around the unlink sites instead of relying on superblock lifetime
>   rules to make that exclusion implicit.

OK, so you did address this. I missed that in my review of v2. Writes
here are rare, so the spinlock cost is low. Therefore, being explicit
about the locking outweights the cost, makes sense.

> 
> Handler removal semantics are unchanged. An exec that acquired a
> reference just before its handler was unregistered already completes
> with the removed handler today. The read lock never protected against
> that, it only made the window smaller.
> 
> With this an exec that matches no binfmt_misc entry, the common case,
> no longer writes to any shared cacheline at all.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c        | 59 +++++++++++++++++++++++++++++--------------------
>  include/linux/binfmts.h |  2 +-
>  kernel/user.c           |  2 +-
>  3 files changed, 37 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 89da2d4e7f91..bd7790a1317b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -24,6 +24,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/namei.h>
>  #include <linux/mount.h>
> +#include <linux/rculist.h>
>  #include <linux/fs_context.h>
>  #include <linux/syscalls.h>
>  #include <linux/fs.h>
> @@ -59,6 +60,7 @@ typedef struct {
>  	struct dentry *dentry;
>  	struct file *interp_file;
>  	refcount_t users;		/* sync removal with load_misc_binary() */
> +	struct rcu_head rcu;
>  } Node;
>  
>  static struct file_system_type bm_fs_type;
> @@ -86,6 +88,8 @@ static struct file_system_type bm_fs_type;
>   * Search for a binary type handler for @bprm in the list of registered binary
>   * type handlers.
>   *
> + * The caller must hold the RCU read lock.
> + *
>   * Return: binary type list entry on success, NULL on failure
>   */
>  static Node *search_binfmt_handler(struct binfmt_misc *misc,
> @@ -95,7 +99,7 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
>  	Node *e;
>  
>  	/* Walk all the registered handlers. */
> -	hlist_for_each_entry(e, &misc->entries, node) {
> +	hlist_for_each_entry_rcu(e, &misc->entries, node) {
>  		char *s;
>  		int j;
>  
> @@ -134,7 +138,10 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
>   * @bprm: binary for which we are looking for a handler
>   *
>   * Try to find a binfmt handler for the binary type. If one is found take a
> - * reference to protect against removal via bm_{entry,status}_write().
> + * reference to protect against removal via bm_{entry,status}_write(). The
> + * refcount of an entry can only drop to zero once it has been unlinked and
> + * a restarted search cannot find an unlinked entry again so the retry loop
> + * is bounded.
>   *
>   * Return: binary type list entry on success, NULL on failure
>   */
> @@ -143,11 +150,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
>  {
>  	Node *e;
>  
> -	read_lock(&misc->entries_lock);
> -	e = search_binfmt_handler(misc, bprm);
> -	if (e)
> -		refcount_inc(&e->users);
> -	read_unlock(&misc->entries_lock);
> +	guard(rcu)();
> +	do {
> +		e = search_binfmt_handler(misc, bprm);
> +	} while (e && !refcount_inc_not_zero(&e->users));
>  	return e;
>  }
>  
> @@ -166,7 +172,8 @@ static void put_binfmt_handler(Node *e)
>  			exe_file_allow_write_access(e->interp_file);
>  			filp_close(e->interp_file, NULL);
>  		}
> -		kfree(e);
> +		/* Lockless walkers may still dereference this entry. */
> +		kfree_rcu(e, rcu);
>  	}
>  }
>  
> @@ -679,10 +686,10 @@ static void bm_evict_inode(struct inode *inode)
>  		struct binfmt_misc *misc;
>  
>  		misc = i_binfmt_misc(inode);
> -		write_lock(&misc->entries_lock);
> +		spin_lock(&misc->entries_lock);
>  		if (!hlist_unhashed(&e->node))
> -			hlist_del_init(&e->node);
> -		write_unlock(&misc->entries_lock);
> +			hlist_del_init_rcu(&e->node);
> +		spin_unlock(&misc->entries_lock);
>  		put_binfmt_handler(e);
>  	}
>  }
> @@ -701,9 +708,9 @@ static void bm_evict_inode(struct inode *inode)
>   */
>  static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
>  {
> -	write_lock(&misc->entries_lock);
> -	hlist_del_init(&e->node);
> -	write_unlock(&misc->entries_lock);
> +	spin_lock(&misc->entries_lock);
> +	hlist_del_init_rcu(&e->node);
> +	spin_unlock(&misc->entries_lock);
>  	locked_recursive_removal(e->dentry, NULL);
>  }
>  
> @@ -754,9 +761,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		 * via bm_{entry,register,status}_write() inode_lock() on the
>  		 * root inode must be held.
>  		 * The lock is exclusive ensuring that the list can't be
> -		 * modified. Only load_misc_binary() can access but does so
> -		 * read-only. So we only need to take the write lock when we
> -		 * actually remove the entry from the list.
> +		 * modified. Only load_misc_binary() can access the list
> +		 * concurrently and it does so under RCU. So entries_lock only
> +		 * needs to be held when an entry is actually unlinked to
> +		 * serialize against bm_evict_inode() during umount which
> +		 * unlinks without holding inode_lock.

This makes it sound as if this serialization is strictly required,
instead of just for clarity. Unmount cannot happen while we are holding
a struct file into that mount, correct?

>  		 */
>  		if (!hlist_unhashed(&e->node))
>  			remove_binfmt_handler(i_binfmt_misc(inode), e);
> @@ -801,9 +810,9 @@ static int add_entry(Node *e, struct super_block *sb)
>  
>  	d_make_persistent(dentry, inode);
>  	misc = i_binfmt_misc(inode);
> -	write_lock(&misc->entries_lock);
> -	hlist_add_head(&e->node, &misc->entries);
> -	write_unlock(&misc->entries_lock);
> +	spin_lock(&misc->entries_lock);
> +	hlist_add_head_rcu(&e->node, &misc->entries);
> +	spin_unlock(&misc->entries_lock);
>  	simple_done_creating(dentry);
>  	return 0;
>  }
> @@ -899,9 +908,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		 * via bm_{entry,register,status}_write() inode_lock() on the
>  		 * root inode must be held.
>  		 * The lock is exclusive ensuring that the list can't be
> -		 * modified. Only load_misc_binary() can access but does so
> -		 * read-only. So we only need to take the write lock when we
> -		 * actually remove the entry from the list.
> +		 * modified. Only load_misc_binary() can access the list
> +		 * concurrently and it does so under RCU. So entries_lock only
> +		 * needs to be held when an entry is actually unlinked to
> +		 * serialize against bm_evict_inode() during umount which
> +		 * unlinks without holding inode_lock.
>  		 */
>  		hlist_for_each_entry_safe(e, next, &misc->entries, node)
>  			remove_binfmt_handler(misc, e);
> @@ -979,7 +990,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  			return -ENOMEM;
>  
>  		INIT_HLIST_HEAD(&misc->entries);
> -		rwlock_init(&misc->entries_lock);
> +		spin_lock_init(&misc->entries_lock);
>  
>  		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
>  		smp_store_release(&user_ns->binfmt_misc, misc);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 071da63f2b48..7e7333b7bb0f 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -102,7 +102,7 @@ struct linux_binfmt {
>  #if IS_ENABLED(CONFIG_BINFMT_MISC)
>  struct binfmt_misc {
>  	struct hlist_head entries;
> -	rwlock_t entries_lock;
> +	spinlock_t entries_lock;
>  	bool enabled;
>  } __randomize_layout;
>  
> diff --git a/kernel/user.c b/kernel/user.c
> index c6a2bfb4d918..21bafdc11379 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -25,7 +25,7 @@
>  struct binfmt_misc init_binfmt_misc = {
>  	.entries = HLIST_HEAD_INIT,
>  	.enabled = true,
> -	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
> +	.entries_lock = __SPIN_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
>  };
>  EXPORT_SYMBOL_GPL(init_binfmt_misc);
>  #endif
> 
> -- 
> 2.53.0
> 

At any rate,

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

PS. Let me know if me reviewing is welcomed or not. Obviously I can't
review with the same depth and oversight as you, Jan, Al or Neil, but it is
a good excuse to learn more VFS code and I intend to continue
contributing to it, so I should also do some reviews. This series seems
like a good candidate to start...
