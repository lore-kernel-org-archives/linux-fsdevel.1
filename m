Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1F43B4BF
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356399; cv=none; b=KZ6SSswKdRM34PySmPrRsFAW3M+TMdsrQ78sfDDleYswL2jJL1p8uoVyWTd8z7hmKB5JD3CcZXThXdMRBHtR16c/oztwDloJ4FhC6y8/zZi9qoLDn1Z+LGOjot5lCo1WO+WjVAnqn6tWYfaC2O4rVYJ0LbyNk35fXjHdZoJKcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356399; c=relaxed/simple;
	bh=m/ksDRkiDHblFOT3BzMtF9w+5Y9lxCpTIqaEvjyou4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbFd39iZJ/6cTJnBQryAuduLeD2lb2W5Pz7OQ4CZxINcdVk87/mqvuVJJpsTHFHa9yke5BgCWfwsZ6lcTJrHAPQRPJ/KCBrOPxpfipCC2YJTI1F20NP0tUJN3jTWuS4jQ8lCt5KE579Q8aOiYOMs3wmiEOLB4KWtSBUVXXJcDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LLJCz7O6; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LLJCz7O6"
X-KPN-MessageId: fc07564b-cb34-11f1-a5a4-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fc07564b-cb34-11f1-a5a4-005056994fde;
	Sun, 18 Oct 2026 22:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=WgZPC3pmNpG/HP8ZTYZexOIgaweqpOHQMM3MrGeHL/A=;
	b=LLJCz7O6BJrLjohr6745kz9jmEgUu5Mz1zb/Zm5izTMguj0z3Agv8SgJSryYOwZRJC7cxHXiQSEZa
	 puyZUhA0P7oH4bW9B53RzkXvRoeKNWk38nqxUhIkiT4il4sCphbTo+ITsZMkcO1Pn3IZtakZpITGH/
	 y010Zzx9/Yox9Hto5yLqLOaSzxLqEzP/rRUyZ3SWXwnoZcrAfKmT1SU0qmgrchhUZBxTCc5mPbinTd
	 n6JVu8Sn3eBr7yTM8uOAclPY1WDQnZmd9BGbvxoqOkG05zBPGR/QqyuMfOx60BJNkXHMxY/bQ80dJL
	 f1m3tcP2i3pimK40jOYWOg0LpwCmK6g==
X-KPN-MID: 33|WEmjlKcV4Ctvr/fV0WaUk7b8YuEUZ9evk94P/hOf566R52TJYJuYCSJqpc5QXNx
 tRafpQq07jvKrW+wO/j38ct7BVZ/6r2MQ9/ohC+im/r8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|QFysU/6dskt2NnnhRrBEIfSFzYwTYjFWc+HXSJBTJWUiyX6RPIxq1bIweCSHZbv
 5RoBM42x2O1h4wJ8Xn/HYEg==
Received: from localhost (unknown [178.227.43.184])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fbd8fcc7-cb34-11f1-a202-00505699b758;
	Sun, 18 Oct 2026 22:46:25 +0200 (CEST)
Date: Sun, 18 Oct 2026 22:47:56 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <christian@brauner.io>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-ID: <atUkrrdfu_ihfmZ8@daedalus>
References: <20261016220029.3276154-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016220029.3276154-1-shakeel.butt@linux.dev>

On Fri, Oct 16, 2026 at 03:00:29PM -0700, Shakeel Butt wrote:
> In the Meta fleet, on 6.16 with the kernfs changes queued for 7.4
> backported, we still see long cgroupfs stalls:
> 
> - oomd and below waited 72 seconds in kernfs_fop_readdir() while an out
>   of memory container created cgroups.  They resumed when the kernel OOM
>   killer killed the container's workload.
> 
> - oomd waited 15 minutes in kernfs_iop_lookup().  PID 1 waited for
>   kernfs_rwsem in cgroup_rmdir() while holding cgroup_mutex.
> 
> - A lock profiler sampling part of the fleet saw kernfs_iop_lookup()
>   hold kernfs_rwsem across memcg reclaim on 26 hosts in 29 days, for up
>   to 625 ms.
> 
> The profiler shows where these stalls come from.  kernfs_iop_lookup()
> and the export ops allocate a new inode while holding kernfs_rwsem for
> read.  The inode is charged to the caller's memcg.  If that memcg is at
> memory.max, the allocation can stay in reclaim for a long time,
> sometimes until an OOM kill.  A writer then queues on the lock and every
> new reader queues behind it.  On cgroup2 this blocks every cgroupfs user
> on the machine.
> 
> Such lookups are common in a memcg that is out of memory.  Its reclaim
> drops its kernfs dentries fast, and the files of a new cgroup have no
> inodes yet.
> 
> Allocate the inode before taking kernfs_rwsem, and free it if it is not
> used, as commit 8b64f32fee95 ("kernfs: allocate the new name outside
> kernfs_rwsem") and commit 5ad03af18434 ("kernfs: allocate the open node
> outside the open file mutex") do.  Everything else still runs under the
> lock, so a new inode is added only for an active node, and
> __kernfs_remove() still finds every inode it must clear i_nlink on, as
> commit dc1a0cc95737 ("kernfs: don't lose IN_DELETE_SELF when decoding a
> file handle") needs.
> 
> The inode goes unused when the name does not exist, the node is
> inactive, or it already has an inode.  In a VM, a lookup of a missing
> name takes about 0.35 us longer, 1.65 us instead of 1.3 us on
> cgroupfs.  Cold lookups of existing sysfs and cgroupfs files are not
> slower.
> 
> kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
> which allocates a dentry.  Hold it only around the inode lookup, as
> __kernfs_fh_to_dentry() already does.  This also gives ->get_parent the
> active test that the IN_DELETE_SELF fix left out: a parent that is
> being removed and has no inode now gets -ESTALE instead of a new inode
> with i_nlink 1.
> 
> kernfs_fill_super() preallocates the root inode the same way, so no
> inode is allocated under kernfs_rwsem any more.
> 
> Tested on a 316-CPU machine.  A task in a full 256 MB memcg with slow
> swap looks up the files of new cgroups.  Worst waits in 60 seconds:
> 
>                                   before    after
>   oomd, for kernfs_rwsem          236 ms   0.1 ms
>   below, for kernfs_rwsem         356 ms   0.8 ms
>   systemd, for kernfs_rwsem       160 ms    37 us
>   readdir of another directory    530 ms   3.9 ms
> 
> The lookup itself is still slow.  The VFS still holds its directory's
> lock, so other work in that one directory still waits.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Tejun Heo <tj@kernel.org>
> ---
> Changes since v2:
> - Allocate the inode before taking kernfs_rwsem and free it if unused,
>   instead of dropping and retaking the lock.  kernfs_iget() becomes
>   kernfs_get_inode_locked() (Tejun).
> - Do the same in kernfs_fill_super() (Tejun).
> - Describe the ->get_parent active test (Tejun).
> - Retested on another machine, numbers updated.
> 
> v2: https://lore.kernel.org/20261016164345.31618-1-shakeel.butt@linux.dev
> 
> Changes since v1:
> - dentry allocation outside kernfs_rwsem (Sashiko).
> - Couple of comments updated.
> 
> v1: https://lore.kernel.org/20261015221110.3183461-1-shakeel.butt@linux.dev
> 
>  fs/kernfs/dir.c             | 13 +++++----
>  fs/kernfs/inode.c           | 56 +++++++++++++++++++++++++++++++++++++
>  fs/kernfs/kernfs-internal.h |  4 +++
>  fs/kernfs/mount.c           | 46 +++++++++++++++++-------------
>  4 files changed, 94 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 7e65854a09e4..f3aaa89ad0f5 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -37,7 +37,7 @@ static bool __kernfs_active(struct kernfs_node *kn)
>  	return atomic_read(&kn->active) >= 0;
>  }
>  
> -static bool kernfs_active(struct kernfs_node *kn)
> +bool kernfs_active(struct kernfs_node *kn)
>  {
>  	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
>  	return __kernfs_active(kn);
> @@ -1251,9 +1251,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  	struct kernfs_node *parent = dir->i_private;
>  	struct kernfs_node *kn;
>  	struct kernfs_root *root;
> -	struct inode *inode = NULL;
> +	struct inode *inode = NULL, *new;
>  	const struct ns_common *ns = NULL;
>  
> +	/* allocate outside kernfs_rwsem, see kernfs_get_inode_locked() */
> +	new = new_inode(dir->i_sb);
> +
>  	root = kernfs_root(parent);
>  	down_read(&root->kernfs_rwsem);
>  	if (kernfs_ns_enabled(parent))
> @@ -1267,11 +1270,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  		 */
>  		if (!kernfs_active(kn)) {
>  			up_read(&root->kernfs_rwsem);
> +			iput(new);
>  			return NULL;
>  		}
> -		inode = kernfs_get_inode(dir->i_sb, kn);
> -		if (!inode)
> -			inode = ERR_PTR(-ENOMEM);
> +		inode = kernfs_get_inode_locked(dir->i_sb, kn, &new);
>  	}
>  	/*
>  	 * Needed for negative dentry validation.
> @@ -1282,6 +1284,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  	if (!IS_ERR(inode))
>  		kernfs_set_rev(parent, dentry);
>  	up_read(&root->kernfs_rwsem);
> +	iput(new);
>  
>  	/* instantiate and hash (possibly negative) dentry */
>  	return d_splice_alias(inode, dentry);
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 237dcdd73fc2..030302185933 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -256,6 +256,62 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
>  	return inode;
>  }
>  
> +static int kernfs_inode_test(struct inode *inode, void *data)
> +{
> +	return inode->i_ino == *(u64 *)data;
> +}
> +
> +static int kernfs_inode_set(struct inode *inode, void *data)
> +{
> +	inode->i_ino = *(u64 *)data;
> +	return 0;
> +}
> +
> +/**
> + * kernfs_get_inode_locked - get the inode of @kn under kernfs_rwsem
> + * @sb: super block
> + * @kn: kernfs_node to get the inode for
> + * @new: points to an inode from new_inode(@sb), or to %NULL if that failed
> + *
> + * The caller allocates *@new before taking kernfs_rwsem, as the allocation
> + * can stall in memcg reclaim.  If @kn needs a new inode, *@new is used and

I wouldn't mention memcg here per se, it is not relevant to grasp its
use. In another series I have implemented almost the same thing (but you
did it better!).

> + * set to %NULL.  Otherwise the caller frees it with iput() after dropping
> + * the lock.
> + *
> + * A new inode is added only with kernfs_rwsem held and @kn active, so
> + * __kernfs_remove() always finds it to clear i_nlink.
> + *
> + * Context: kernfs_rwsem held for read.
> + *
> + * Return: the inode, %NULL if @kn is inactive and has no inode, or
> + * ERR_PTR(-ENOMEM) if @kn needs an inode and *@new is %NULL.
> + */
> +struct inode *kernfs_get_inode_locked(struct super_block *sb,
> +				      struct kernfs_node *kn,
> +				      struct inode **new)

I understand this is intended to have some kind of ownership semantics,
but I must say for such a simple function, I find the contract quite
complex to check. Do we really need an out parameter here?

> +{
> +	u64 ino = kernfs_ino(kn);
> +	struct inode *inode;
> +
> +	lockdep_assert_held_read(&kernfs_root(kn)->kernfs_rwsem);
> +
> +	inode = ilookup(sb, ino);
> +	if (inode || !kernfs_active(kn))
> +		return inode;
> +	if (!*new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	inode = inode_insert5(*new, ino, kernfs_inode_test, kernfs_inode_set,
> +			      &ino);
> +	if (inode == *new) {
> +		kernfs_init_inode(kn, inode);
> +		*new = NULL;
> +	} else if (!inode) {
> +		inode = ERR_PTR(-ENOMEM);
> +	}
> +	return inode;
> +}
> +
>  /*
>   * The kernfs_node serves as both an inode and a directory entry for
>   * kernfs.  To prevent the kernfs inode numbers from being freed
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 1609c1519698..bf8752434b34 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -186,6 +186,9 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
>  		       u32 request_mask, unsigned int query_flags);
>  ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
>  int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
> +struct inode *kernfs_get_inode_locked(struct super_block *sb,
> +				      struct kernfs_node *kn,
> +				      struct inode **new);
>  
>  /*
>   * dir.c
> @@ -194,6 +197,7 @@ extern const struct dentry_operations kernfs_dops;
>  extern const struct file_operations kernfs_dir_fops;
>  extern const struct inode_operations kernfs_dir_iops;
>  
> +bool kernfs_active(struct kernfs_node *kn);
>  struct kernfs_node *kernfs_get_active(struct kernfs_node *kn);
>  void kernfs_put_active(struct kernfs_node *kn);
>  int kernfs_add_one(struct kernfs_node *kn);
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index c15ba6357162..3633cf3b6bef 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -99,8 +99,8 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
>  					    int fh_type, bool get_parent)
>  {
>  	struct kernfs_super_info *info = kernfs_info(sb);
> +	struct inode *inode = ERR_PTR(-ESTALE), *new;
>  	struct kernfs_node *kn;
> -	struct inode *inode;
>  	u64 id;
>  
>  	if (fh_len < 2)
> @@ -124,32 +124,29 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
>  		return NULL;
>  	}
>  
> +	new = new_inode(sb);
> +
>  	/*
> -	 * Hold kernfs_rwsem across the lookup as well as kernfs_get_inode().
> -	 * __kernfs_remove() deactivates the subtree and clears i_nlink on its
> -	 * inodes under the write lock, so under the read lock either
> -	 * kernfs_find_and_get_node_by_id() refuses the node, or the inode is
> -	 * in the inode hash before the ilookup() pass goes looking for it.
> +	 * Hold kernfs_rwsem from the lookup through kernfs_get_inode_locked().
> +	 * Then __kernfs_remove() either finds the inode to clear i_nlink, or
> +	 * the node is already inactive and no inode is created.
>  	 */
>  	scoped_guard(rwsem_read, &info->root->kernfs_rwsem) {
>  		kn = kernfs_find_and_get_node_by_id(info->root, id);
> -		if (!kn)
> -			return ERR_PTR(-ESTALE);
> -
> -		if (get_parent) {
> +		if (kn && get_parent) {
>  			struct kernfs_node *parent;
>  
>  			parent = kernfs_get_parent(kn);
>  			kernfs_put(kn);
>  			kn = parent;
> -			if (!kn)
> -				return ERR_PTR(-ESTALE);
>  		}
> -
> -		inode = kernfs_get_inode(sb, kn);
> -		kernfs_put(kn);
> +		if (kn) {
> +			inode = kernfs_get_inode_locked(sb, kn, &new);
> +			kernfs_put(kn);
> +		}
>  	}
>  
> +	iput(new);
>  	return d_obtain_alias(inode);
>  }
>  
> @@ -171,9 +168,16 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
>  {
>  	struct kernfs_node *kn = kernfs_dentry_node(child);
>  	struct kernfs_root *root = kernfs_root(kn);
> +	struct inode *inode, *new;
> +
> +	new = new_inode(child->d_sb);
> +	scoped_guard(rwsem_read, &root->kernfs_rwsem) {
> +		inode = kernfs_get_inode_locked(child->d_sb, kernfs_parent(kn),
> +						&new);
> +	}
>  
> -	guard(rwsem_read)(&root->kernfs_rwsem);
> -	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_parent(kn)));
> +	iput(new);
> +	return d_obtain_alias(inode);
>  }
>  
>  static const struct export_operations kernfs_export_ops = {
> @@ -294,7 +298,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  {
>  	struct kernfs_super_info *info = kernfs_info(sb);
>  	struct kernfs_root *kf_root = kfc->root;
> -	struct inode *inode;
> +	struct inode *inode, *new;
>  	struct dentry *root;
>  
>  	info->sb = sb;
> @@ -314,10 +318,12 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  	sb->s_shrink->seeks = 0;
>  
>  	/* get root inode, initialize and unlock it */
> +	new = new_inode(sb);
>  	down_read(&kf_root->kernfs_rwsem);
> -	inode = kernfs_get_inode(sb, info->root->kn);
> +	inode = kernfs_get_inode_locked(sb, info->root->kn, &new);

What are you serializing against here? I've been looking at this as well
recently, and I thought we could just get rid of the locking here. But
on second look, I am not so sure what is correct.

Is there anything that serializes kernfs_get_tree() with root node
removal?

>  	up_read(&kf_root->kernfs_rwsem);
> -	if (!inode) {
> +	iput(new);
> +	if (IS_ERR_OR_NULL(inode)) {
>  		pr_debug("kernfs: could not get root inode\n");
>  		return -ENOMEM;
>  	}
> -- 
> 2.53.0-Meta
> 

Thanks,
Jori.
