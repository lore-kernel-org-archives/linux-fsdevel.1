Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483503;
	b=jJd2zXxnw+Jd/5AVeMCkkPUqRmkCh9G7ZnVhD1gv0VSHvU5OPlTMfsTKjSIqhxHEnwga
	 NisY+SvXzRC5nkTgBbJYhfaJ2D7cAprc8M5SaRQSRhUvi5vlS8Ckpvu+/I9vwkYmrbnia
	 oZ7aF1WeF7ZrHa4mXgzxYRz25Y/IgtrYvbFRyAg/4S6IggmfPYxjEshljPA3auLEgSf4e
	 C8PZQFlOAFPjArly0CUo6OG86xL9RZDoins2o+I0JJhwPQBlePoliDX5YdEz4ryLkrRX2
	 /UT1+qIzx4HL/Vr/kpLwyVDtwsmVngQrcyo6fcjLtX01YU746GYhKIBbj027nntNZtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483503;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=5FsDSMA6fxJBuntLYG/LjyqgMH3Y6kpISBAL9tvJpfc=;
	b=m0W19EuuoGdwlHxMWGRwS5z8xMKeuuFemu/ophp3k4wl+1rbu9dLQRgHbkGudNNqdhGA
	 kNAfmXYOyFcoGhDod1E1WcgsJSAfSIZHYxVnNLMEmGYR+HgaLdrC8QpxuVvjGlBRi0zyB
	 fZB49q8wa70qPgc1rT1j0NvqaFGLl21fdHHUi0e5is+2W6MG0kdI+jWQLkt4XgPwbbeKK
	 sM4Nc3lhy9amH1ZHB3nGdSRJoRuwd8Amus3uX4t1ZSCbi+V2f70qKkcG4J9xhhxWTY/qv
	 Wxq3/3ky5/C4ceMUgGJ+7D95sEk16W1qzQu8SrBoZv4Y2iaKalaCkcc2OxeM9xSfZbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=aNeEjB1x;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A19606A881
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A19606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=aNeEjB1x
X-KPN-MessageId: 8ae7435e-de8d-11f1-9601-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8ae7435e-de8d-11f1-9601-00505699b430;
	Thu, 12 Nov 2026 12:38:12 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 8af91bed-de8d-11f1-ae21-00505699891e;
	Thu, 12 Nov 2026 12:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=5FsDSMA6fxJBuntLYG/LjyqgMH3Y6kpISBAL9tvJpfc=;
	b=aNeEjB1x5cWu7BhCdmEVUY7VFtGXCT0VmuuxuB3aekejoa3av+zmb3c405XI4/oYPVQuFXUqbE6EZ
	 NLEw2mR+Hwn1yU0PrkVtb1lrs1jl9zZiZBi+F3mFTVIAFaJba0wufmMqhUGzvmMUho0dPrgiRdS3x9
	 S50Z4PfkY7gprf+/W3KZetAxI5htQv2mMsqKp3jQPWly6CEG3laNCxYEmBWEA9RTIrmn2gXTzZdbKR
	 ocjuYFk8JjVofaifWR2wVbmnub9/UyuHHiim73Z/Brm4Nw3xnL7csNpz796kChUuoFoS8j7v7esDZO
	 Ur5N/CAi0Sj5mH6634/EF2wZ+pAs9Kg==
X-KPN-MID: 33|2+vDyH4OXdN38qtkYOT+fPNPC4ztGaWjRoC0LbwKICMaeeVA/6x8u4X/3h2LhRY
 arh2Vg9KZln7JxoHkzfvLn1QVSd2rQnC83VeNyFQ+MBs=
X-CMASSUN: 33|/WZBbSwudrjS3w98xBPonvubAiZ8tBiuQ3ptJhMrbg2ZWwlauINAyBi5MsQOq+k
 l4Q1W6X/Olmwv1qh7IQ6sgA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 8aecd3aa-de8d-11f1-aa48-005056995d6c;
	Thu, 12 Nov 2026 12:38:12 +0100 (CET)
Date: Thu, 12 Nov 2026 12:38:12 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Message-ID: <1984940723.1098701.1794483492769@kpc.webmail.kpnmail.nl>
In-Reply-To: <20261111215058.1837351-1-shakeel.butt@linux.dev>
References: <20261111215058.1837351-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH v4] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 11-11-2026 16:50 EST schreef Shakeel Butt <shakeel.butt@linux.dev>:
> 
>  
> In the Meta fleet, on 6.16 with the kernfs changes from 7.4 backported,
> we still see long cgroupfs stalls:
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
> Allocate the inode before taking kernfs_rwsem, as kernfs_iop_mkdir()
> already does, and attach it under the lock with
> kernfs_get_inode_locked().  That helper adds a new inode only for an
> active node, so __kernfs_remove() still finds every inode it must clear
> i_nlink on, as commit dc1a0cc95737 ("kernfs: don't lose IN_DELETE_SELF
> when decoding a file handle") needs.
> 
> The inode goes unused when the name does not exist, the node is
> inactive, or it already has an inode.  In a VM, a lookup of a missing
> name takes about 1 us longer, 4.5 us instead of 3.5 us on cgroupfs.
> Cold lookups of existing sysfs and cgroupfs files take 2 to 3% longer.
> 
> kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
> which allocates a dentry.  Hold it only around the inode lookup, as
> __kernfs_fh_to_dentry() already does.  This also gives ->get_parent the
> active test that the IN_DELETE_SELF fix left out: a parent that is being
> removed now gets -ESTALE.  Before, it got an inode anyway, possibly a
> new one whose i_nlink __kernfs_remove() never cleared.
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
> Suggested-by: Tejun Heo <tj@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> 
> Christian, this depends on Jori's series in vfs-7.5.directory.  Could you
> take it on top of it?  Greg, you asked to wait for -rc1 and for testing
> in -next.  Are you OK with this going through the vfs tree?
> 
> Changes since v3:
> - Rebased on vfs-7.5.directory.  Use the kernfs_get_inode_locked() that
>   Jori added there for kernfs_iop_mkdir().
> - ->get_parent: a parent that is being removed now gets -ESTALE even if
>   it already has an inode, because the helper tests the node first.
> - New cost numbers. v3 costs the same as v4 in it.
> - Kept Tejun's ack, as the approach he suggested is unchanged.
> 
> v3: https://lore.kernel.org/20261016220029.3276154-1-shakeel.butt@linux.dev
> 
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
>  fs/kernfs/dir.c   | 12 ++++++++++--
>  fs/kernfs/inode.c |  3 +++
>  fs/kernfs/mount.c | 49 +++++++++++++++++++++++++++++------------------
>  3 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index e72783843edb..fb1dcf35d900 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
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
> @@ -1267,9 +1270,13 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  		 */
>  		if (!kernfs_active(kn)) {
>  			up_read(&root->kernfs_rwsem);
> +			iput(new);
>  			return NULL;
>  		}
> -		inode = kernfs_get_inode(dir->i_sb, kn);
> +		if (new) {
> +			inode = kernfs_get_inode_locked(new, kn);
> +			new = NULL;
> +		}
>  		if (!inode)
>  			inode = ERR_PTR(-ENOMEM);
>  	}
> @@ -1282,6 +1289,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>  	if (!IS_ERR(inode))
>  		kernfs_set_rev(parent, dentry);
>  	up_read(&root->kernfs_rwsem);
> +	iput(new);
>  
>  	/* instantiate and hash (possibly negative) dentry */
>  	return d_splice_alias(inode, dentry);
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 9cc1a56740b9..53b1a2796e0b 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -269,6 +269,9 @@ static int kernfs_inode_test(struct inode *inode, void *data)
>   * while the inode is inserted and __kernfs_remove() always finds it to
>   * clear its i_nlink.  @inode is consumed.
>   *
> + * The caller allocates @inode before taking kernfs_rwsem, because the
> + * allocation can block in reclaim and hold up other users of the lock.
> + *
>   * Returns the inode now attached to @kn, which is @inode unless one was
>   * already hashed for it (e.g. by a file handle decode), or NULL if @kn
>   * is no longer active.
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..05e8ec1ee7fa 100644
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
> @@ -124,32 +124,32 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
>  		return NULL;
>  	}
>  
> +	new = new_inode(sb);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
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
> +			inode = kernfs_get_inode_locked(new, kn);
> +			new = NULL;
> +			kernfs_put(kn);
> +		}
>  	}
>  
> +	iput(new);
>  	return d_obtain_alias(inode);
>  }
>  
> @@ -171,9 +171,17 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
>  {
>  	struct kernfs_node *kn = kernfs_dentry_node(child);
>  	struct kernfs_root *root = kernfs_root(kn);
> +	struct inode *inode, *new;
>  
> -	guard(rwsem_read)(&root->kernfs_rwsem);
> -	return d_obtain_alias(kernfs_get_inode(child->d_sb, kernfs_parent(kn)));
> +	new = new_inode(child->d_sb);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	scoped_guard(rwsem_read, &root->kernfs_rwsem) {
> +		inode = kernfs_get_inode_locked(new, kernfs_parent(kn));
> +	}
> +
> +	return d_obtain_alias(inode);
>  }
>  
>  static const struct export_operations kernfs_export_ops = {
> @@ -294,7 +302,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  {
>  	struct kernfs_super_info *info = kernfs_info(sb);
>  	struct kernfs_root *kf_root = kfc->root;
> -	struct inode *inode;
> +	struct inode *inode, *new;
>  	struct dentry *root;
>  
>  	info->sb = sb;
> @@ -314,8 +322,11 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  	sb->s_shrink->seeks = 0;
>  
>  	/* get root inode, initialize and unlock it */
> +	new = new_inode(sb);
> +	if (!new)
> +		return -ENOMEM;
>  	down_read(&kf_root->kernfs_rwsem);
> -	inode = kernfs_get_inode(sb, info->root->kn);
> +	inode = kernfs_get_inode_locked(new, info->root->kn);
>  	up_read(&kf_root->kernfs_rwsem);
>  	if (!inode) {
>  		pr_debug("kernfs: could not get root inode\n");
> 
> base-commit: ecdfc51a6a78aaf1c4ac1d8b6ea199cc2ed020ac
> -- 
> 2.53.0-Meta

Does this compile? I added a bool parameter to kernfs_get_inode_locked(),
for this patch to be able to do a lookup first, but you haven't added that.
I think you want to set lookup=true everywhere, right?

Thanks,
Jori.
