Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE332FFF9D
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785003708; cv=none; b=V5IsudvqhkV2BwpFQkRmwfXM23iZGM1ROjLg1zQlAyswOR5O1MzmBa9hqD+G2AAvd+EDFD7w8gFY6IR0bnNDpIIRIjW/CIxE1DVulWxyQZcylkbPnXncNbRLTdy2SeIVaHS//jFza/0YkowKruDsdykHP79Ql1bLgiTJ2hdgtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785003708; c=relaxed/simple;
	bh=17COEp6Pw+sFOKKXbxf1ynJVagC8mrh0Qz75M5IbeNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDtbQIjUvT/qHII6jfhrjITBFvzz2diCAMOehJKtk8W8g4dAX+FH7uwYIGQ/E1uGCY7zVcrW/Oa1bcSP3bk5irIry7D92fs3pGpI5TqHE6NGsbAdOf1j0Z/hUdlqlGGm1UPu2y69/JSlDzR9XTCRCHTfG4i/m3T2ClYRLlcuSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uDcpzhx7; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uDcpzhx7"
X-KPN-MessageId: aeb9bd64-8855-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aeb9bd64-8855-11f1-861c-005056aba152;
	Sat, 25 Jul 2026 20:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=JKAv7Rcb+XF+MTf6/2o5bbMRxppJLao2u2LZeNBPHHw=;
	b=uDcpzhx7R1Dhfftos+ax8g7JM3qDGjVogjQ/l1L4Y9rkdq3w1LuW+goHBLL/WHWHklltK3/voBEpR
	 k0w/QLvpaN2KIfyJ4pMg2ABod9PuLwWHQSCdwWfBvcF+EKO55lQPXUXCdQoWwSsMBUO5d2Y1Y0viO7
	 Ok2+7r6g+7PuHZrA6FetpflUdkEYXGXU1fS5FzDJnzVcPQkU2xnQ7qv364uFVpNX8qE+bmP3scSz7b
	 xcSuGLOVgWDIPJW9fXi0wA9fsE29sLpn7G4O9PWkiC1Th7TtD1NeCpcWPp0CVkGoy19U795Jag7eh3
	 H+Sbgw0AT3Bk4DHBmLVjQVMCk6BBMMg==
X-KPN-MID: 33|6qfqhItQ4gQ5bHeJtFSjfF40qFU6dL4YnwbgV8RVeAF99lAyDpv7gAzT84HJeDM
 n2iv05l+Wxd+l9b6s5j31Io370crtYt2nea1WtsMKMbU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7H6mtHItgB5zCIATCF614+EYUstmPoLgrrw52T/gFNOaWHcagi4/WCgHU82Z3wz
 aJnTpx6QbASd67+IveF+cGQ==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ae932332-8855-11f1-a8b6-005056ab7447;
	Sat, 25 Jul 2026 20:21:40 +0200 (CEST)
Date: Sat, 25 Jul 2026 20:21:34 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 24/24] binfmt_misc: allow removing entries via
 unlink(2)
Message-ID: <amT-nhNiupmKweJj@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-24-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-24-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:25AM +0200, Christian Brauner wrote:
> Removing a binary type handler requires echoing -1 into its entry
> file which works but is an odd interface to discover for something
> that already looks like a plain file in a filesystem. The comment on
> remove_binfmt_handler() has been suggesting a proper ->unlink()
> method for years, so add one: unlinking an entry file unhashes the
> entry from the handler list and removes the file, exactly like
> writing -1 to it does. The status and register control files refuse
> removal with EPERM the same way binderfs protects binder-control.
> Writing -1 keeps working.
> 
> Permission-wise nothing new is exposed: unlink(2) requires write
> access to the root directory which is owned by the (user namespace)
> root with mode 0755, matching the privilege needed to write to the
> 0644 entry files. The VFS calls ->unlink() with the root inode lock
> held so the existing writer serialization scheme applies unchanged,
> and eviction of the unlinked inode drops the entry reference exactly
> as for the write based removal.
> 
> Document the new way in admin-guide/binfmt-misc.rst.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  Documentation/admin-guide/binfmt-misc.rst |  3 +-
>  fs/binfmt_misc.c                          | 77 ++++++++++++++++++++++---------
>  2 files changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
> index c0a34fbf8022..306ef48f5de6 100644
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst
> @@ -133,7 +133,8 @@ or 1 (to enable) to ``/proc/sys/fs/binfmt_misc/status`` or
>  Catting the file tells you the current status of ``binfmt_misc/the_entry``.
>  
>  You can remove one entry or all entries by echoing -1 to ``/proc/.../the_name``
> -or ``/proc/sys/fs/binfmt_misc/status``.
> +or ``/proc/sys/fs/binfmt_misc/status``. A single entry can also be removed
> +by simply unlinking (``rm``) ``/proc/.../the_name``.
>  
>  
>  Hints
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 46c65a618b19..fcaad14f81a3 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -639,8 +639,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
>   * entry is removed or the filesystem is unmounted and the super block is
>   * shutdown.
>   *
> - * If the ->evict call was not caused by a super block shutdown but by a write
> - * to remove the entry or all entries via bm_{entry,status}_write() the entry
> + * If the ->evict call was not caused by a super block shutdown but by
> + * removing the entry via bm_{entry,status}_write() or unlink(2) the entry
>   * will have already been removed from the list. We keep the hlist_unhashed()
>   * check to make that explicit.
>  */
> @@ -662,6 +662,26 @@ static void bm_evict_inode(struct inode *inode)
>  	}
>  }
>  
> +/**
> + * unlink_binfmt_handler - unhash a binary type handler
> + * @misc: handle to binfmt_misc instance
> + * @e: binary type handler to unhash
> + *
> + * Adding and removing entries via bm_{entry,register,status}_write() and
> + * unlink(2) happens under the exclusively held inode lock of the root
> + * dentry keeping the list stable for writers. load_misc_binary() walks it
> + * concurrently under RCU. The entries_lock is only held around the actual
> + * unlink to serialize against bm_evict_inode() which unlinks entries
> + * during umount without holding the root inode lock.
> + */
> +static void unlink_binfmt_handler(struct binfmt_misc *misc,
> +				  struct binfmt_misc_entry *e)
> +{
> +	spin_lock(&misc->entries_lock);
> +	hlist_del_init_rcu(&e->node);
> +	spin_unlock(&misc->entries_lock);
> +}
> +
>  /**
>   * remove_binfmt_handler - remove a binary type handler
>   * @misc: handle to binfmt_misc instance
> @@ -669,29 +689,15 @@ static void bm_evict_inode(struct inode *inode)
>   *
>   * Remove a binary type handler from the list of binary type handlers and
>   * remove its associated dentry.
> - *
> - * Adding and removing entries via bm_{entry,register,status}_write()
> - * happens under the exclusively held inode lock of the root dentry keeping
> - * the list stable for writers. load_misc_binary() walks it concurrently
> - * under RCU. The entries_lock is only held around the actual unlink to
> - * serialize against bm_evict_inode() which unlinks entries during umount
> - * without holding the root inode lock.
> - *
> - * In the future, we might want to think about adding a proper ->unlink()
> - * method to binfmt_misc instead of forcing callers to use writes to files
> - * in order to delete binary type handlers. But it has worked for so long
> - * that it's not a pressing issue.
>   */
>  static void remove_binfmt_handler(struct binfmt_misc *misc,
>  				  struct binfmt_misc_entry *e)
>  {
> -	spin_lock(&misc->entries_lock);
> -	hlist_del_init_rcu(&e->node);
> -	spin_unlock(&misc->entries_lock);
> +	unlink_binfmt_handler(misc, e);
>  	locked_recursive_removal(e->dentry, NULL);
>  }
>  
> -/* Remove @e unless a concurrent write already unlinked it. */
> +/* Remove @e unless it was already removed. */
>  static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
>  {
>  	struct inode *root = d_inode(sb->s_root);
> @@ -716,6 +722,32 @@ static void bm_remove_all_entries(struct binfmt_misc *misc,
>  	inode_unlock(root);
>  }
>  
> +/**
> + * bm_unlink - remove a binary type handler via unlink(2)
> + * @dir: inode of the root directory
> + * @dentry: entry file to remove
> + *
> + * Removing the entry file removes its binary type handler, exactly like
> + * writing -1 to it does. The status and register control files can't be
> + * removed. The VFS calls this with the root inode lock held which
> + * serializes against the write based add and remove paths.
> + */
> +static int bm_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct binfmt_misc_entry *e = d_inode(dentry)->i_private;
> +
> +	if (!e)
> +		return -EPERM;
> +
> +	unlink_binfmt_handler(i_binfmt_misc(dir), e);
> +	return simple_unlink(dir, dentry);
> +}
> +
> +static const struct inode_operations bm_dir_inode_operations = {
> +	.lookup		= simple_lookup,
> +	.unlink		= bm_unlink,
> +};
> +
>  /* /<entry> */
>  
>  static int bm_entry_open(struct inode *inode, struct file *file)
> @@ -966,9 +998,12 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  	WRITE_ONCE(misc->enabled, true);
>  
>  	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
> -	if (!err)
> -		sb->s_op = &bm_super_ops;
> -	return err;
> +	if (err)
> +		return err;
> +
> +	sb->s_op = &bm_super_ops;
> +	d_inode(sb->s_root)->i_op = &bm_dir_inode_operations;
> +	return 0;
>  }
>  
>  static void bm_free(struct fs_context *fc)
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
