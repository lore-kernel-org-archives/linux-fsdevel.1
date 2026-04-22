Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146C3CCFAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853068; cv=none; b=uwC47WhVDxUVxtdSwJD+5K15vO2ycnza+8b+j9paPw9sogTIwTdpdG875emdrl6v/9frAJmZqh0TTxFphWlOj5swA0aGo06utwl/LSTZfD0Ij16/6uP/vszWO5CmfkXJ/CrtJlmCAydBKRLANUJAv1MVgojr2wJKWNNpl6Y07OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853068; c=relaxed/simple;
	bh=j09oSqaprAvpvSToRPbBBNbbFjKJ2667d99oNnyvDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6iA0MuM54sqO+K6gaC6EqkIqGMLgj8BFdBJWyziktqxHEnA7YFvD5z0bF5+ABf/uaO/0kDAprT9WzpimEwYeyEB5fR5KwYJ1uaDlTAWTtmyhfTzRM9Q1Pqb7SECax/FbZQpSXqWad2rGeJJv1r1c6LvaTOypt/QSjD3YemoN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4CIqGcv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yeUnxR00; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bw3PRUii; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkJM8BQ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4CIqGcv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yeUnxR00";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bw3PRUii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkJM8BQ7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDA055BCEE;
	Wed, 22 Apr 2026 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csHgFapSk8aIOxl+6RBiK7kI70+b/8kr5MWyr+5PZx4=;
	b=R4CIqGcvTgLVco5uh4xs/nTyg7AduzUZfxnuWEr6XbH+oQwysNLNLGh33P27KiZyGqoPjv
	yMOBxIVj0EUJo9y8SxidX4LeN881ZZhGd+Zi086gj3F4YnFjI43xticwOiEPxK9xhv+ebo
	zv0Y4artfWt63vhH0faez1U9wrrsAMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csHgFapSk8aIOxl+6RBiK7kI70+b/8kr5MWyr+5PZx4=;
	b=yeUnxR00qvuRE2ehq4xeT+w4oJXJJEdWdi3tnptC0MBQHL2YXa+Y49IUF4mG5rTvOTA8MS
	+ssyt5c+GeadpdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csHgFapSk8aIOxl+6RBiK7kI70+b/8kr5MWyr+5PZx4=;
	b=bw3PRUiiBSZ5k8qtQDHAZlTX+WGdy0JuvnXaZgmO90OPTcWGD96ZzFDvt9G426jCOzL7WT
	gpLxmrOD0/8ejCylCkgStgqBOYf/pllobOucsGd6ZOrlqzmFcLQl3/Zc8pAc1heK/hpgyH
	ZxDfldeczTq3FySKKolc0KwxGoBs4Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csHgFapSk8aIOxl+6RBiK7kI70+b/8kr5MWyr+5PZx4=;
	b=VkJM8BQ743X0JKS9aymm+4jRJYFMKjoLr/RKI6PnU2ZgVrWggTet+gu3/NkTCtr62bFx+2
	wEwHRnuliBJ7TXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB66C593AF;
	Wed, 22 Apr 2026 10:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TCGJNT6g6GnlZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 10:17:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9BF33A0B60; Wed, 22 Apr 2026 12:17:30 +0200 (CEST)
Date: Wed, 22 Apr 2026 12:17:30 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] fs: add icount_read_once() and stop open-coding
 ->i_count loads
Message-ID: <t6o3ndrkxrwujhh7xcppth7637n4znqdbfwh7ao4b3yscn6eyi@yf4ccw2ynesu>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
 <20260421182538.1215894-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421182538.1215894-2-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 21-04-26 20:25:36, Mateusz Guzik wrote:
> Similarly to inode_state_read_once(), it makes the caller spell out
> they acknowledge instability of the returned value.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  arch/powerpc/platforms/cell/spufs/file.c |  2 +-
>  fs/btrfs/inode.c                         |  2 +-
>  fs/ceph/mds_client.c                     |  2 +-
>  fs/ext4/ialloc.c                         |  4 ++--
>  fs/hpfs/inode.c                          |  2 +-
>  fs/inode.c                               | 12 ++++++------
>  fs/nfs/inode.c                           |  4 ++--
>  fs/smb/client/inode.c                    |  2 +-
>  fs/ubifs/super.c                         |  2 +-
>  fs/xfs/xfs_inode.c                       |  2 +-
>  fs/xfs/xfs_trace.h                       |  2 +-
>  include/linux/fs.h                       | 13 +++++++++++++
>  include/trace/events/filelock.h          |  2 +-
>  security/landlock/fs.c                   |  2 +-
>  14 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 10fa9b844fcc..f6de8c1169d5 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -1430,7 +1430,7 @@ static int spufs_mfc_open(struct inode *inode, struct file *file)
>  	if (ctx->owner != current->mm)
>  		return -EINVAL;
>  
> -	if (icount_read(inode) != 1)
> +	if (icount_read_once(inode) != 1)
>  		return -EBUSY;
>  
>  	mutex_lock(&ctx->mapping_lock);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40474014c03f..7dc1b8168278 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4745,7 +4745,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
>  
>  	inode = btrfs_find_first_inode(root, min_ino);
>  	while (inode) {
> -		if (icount_read(&inode->vfs_inode) > 1)
> +		if (icount_read_once(&inode->vfs_inode) > 1)
>  			d_prune_aliases(&inode->vfs_inode);
>  
>  		min_ino = btrfs_ino(inode) + 1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b1746273f186..2cb3c919d40d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2223,7 +2223,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
>  			int count;
>  			dput(dentry);
>  			d_prune_aliases(inode);
> -			count = icount_read(inode);
> +			count = icount_read_once(inode);
>  			if (count == 1)
>  				(*remaining)--;
>  			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 3fd8f0099852..8c80d5087516 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -252,10 +252,10 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		       "nonexistent device\n", __func__, __LINE__);
>  		return;
>  	}
> -	if (icount_read(inode) > 1) {
> +	if (icount_read_once(inode) > 1) {
>  		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: count=%d",
>  			 __func__, __LINE__, inode->i_ino,
> -			 icount_read(inode));
> +			 icount_read_once(inode));
>  		return;
>  	}
>  	if (inode->i_nlink) {
> diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
> index 0e932cc8be1b..1b4fcf760aad 100644
> --- a/fs/hpfs/inode.c
> +++ b/fs/hpfs/inode.c
> @@ -184,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
>  	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
>  	struct inode *parent;
>  	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
> -	if (hpfs_inode->i_rddir_off && !icount_read(i)) {
> +	if (hpfs_inode->i_rddir_off && !icount_read_once(i)) {
>  		if (*hpfs_inode->i_rddir_off)
>  			pr_err("write_inode: some position still there\n");
>  		kfree(hpfs_inode->i_rddir_off);
> diff --git a/fs/inode.c b/fs/inode.c
> index 69e219f0cfcb..e57873136093 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -902,7 +902,7 @@ void evict_inodes(struct super_block *sb)
>  again:
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -		if (icount_read(inode))
> +		if (icount_read_once(inode))
>  			continue;
>  
>  		spin_lock(&inode->i_lock);
> @@ -1920,7 +1920,7 @@ static void iput_final(struct inode *inode)
>  	int drop;
>  
>  	WARN_ON(inode_state_read(inode) & I_NEW);
> -	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> +	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
>  
>  	if (op->drop_inode)
>  		drop = op->drop_inode(inode);
> @@ -1939,7 +1939,7 @@ static void iput_final(struct inode *inode)
>  	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
>  	 * Note we only execute this if the verdict was to drop the inode.
>  	 */
> -	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> +	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
>  
>  	if (drop) {
>  		inode_state_set(inode, I_FREEING);
> @@ -1983,7 +1983,7 @@ void iput(struct inode *inode)
>  	 * equal to one, then two CPUs racing to further drop it can both
>  	 * conclude it's fine.
>  	 */
> -	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);
> +	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
>  
>  	if (atomic_add_unless(&inode->i_count, -1, 1))
>  		return;
> @@ -2017,7 +2017,7 @@ EXPORT_SYMBOL(iput);
>  void iput_not_last(struct inode *inode)
>  {
>  	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
> -	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
> +	VFS_BUG_ON_INODE(icount_read_once(inode) < 2, inode);
>  
>  	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
>  }
> @@ -3040,7 +3040,7 @@ void dump_inode(struct inode *inode, const char *reason)
>  	}
>  
>  	state = inode_state_read_once(inode);
> -	count = atomic_read(&inode->i_count);
> +	count = icount_read_once(inode);
>  
>  	if (!sb ||
>  	    get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 98a8f0de1199..22834eddd5b1 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -608,7 +608,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
>  		inode->i_sb->s_id,
>  		(unsigned long long)NFS_FILEID(inode),
>  		nfs_display_fhandle_hash(fh),
> -		icount_read(inode));
> +		icount_read_once(inode));
>  
>  out:
>  	return inode;
> @@ -2261,7 +2261,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  	dfprintk(VFS, "NFS: %s(%s/%llu fh_crc=0x%08x ct=%d info=0x%llx)\n",
>  			__func__, inode->i_sb->s_id, inode->i_ino,
>  			nfs_display_fhandle_hash(NFS_FH(inode)),
> -			icount_read(inode), fattr->valid);
> +			icount_read_once(inode), fattr->valid);
>  
>  	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
>  		/* Only a mounted-on-fileid? Just exit */
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 24040909d184..0b66cd0fa2ff 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2843,7 +2843,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
>  	}
>  
>  	cifs_dbg(FYI, "Update attributes: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld\n",
> -		 full_path, inode, icount_read(inode),
> +		 full_path, inode, icount_read_once(inode),
>  		 dentry, cifs_get_time(dentry), jiffies);
>  
>  again:
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 9a77d8b64ffa..38972786817e 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -358,7 +358,7 @@ static void ubifs_evict_inode(struct inode *inode)
>  		goto out;
>  
>  	dbg_gen("inode %llu, mode %#x", inode->i_ino, (int)inode->i_mode);
> -	ubifs_assert(c, !icount_read(inode));
> +	ubifs_assert(c, !icount_read_once(inode));
>  
>  	truncate_inode_pages_final(&inode->i_data);
>  
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index beaa26ec62da..4f659eba6ae5 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1046,7 +1046,7 @@ xfs_itruncate_extents_flags(
>  	int			error = 0;
>  
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> -	if (icount_read(VFS_I(ip)))
> +	if (icount_read_once(VFS_I(ip)))
>  		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>  	if (whichfork == XFS_DATA_FORK)
>  		ASSERT(new_size <= XFS_ISIZE(ip));
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 1c098cfc5c00..f87c738d84b2 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1158,7 +1158,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
>  	TP_fast_assign(
>  		__entry->dev = VFS_I(ip)->i_sb->s_dev;
>  		__entry->ino = ip->i_ino;
> -		__entry->count = icount_read(VFS_I(ip));
> +		__entry->count = icount_read_once(VFS_I(ip));
>  		__entry->pincount = atomic_read(&ip->i_pincount);
>  		__entry->iflags = ip->i_flags;
>  		__entry->caller_ip = caller_ip;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b5b01bb22d12..a046ae84a227 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2217,8 +2217,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
>  	__mark_inode_dirty(inode, I_DIRTY_SYNC);
>  }
>  
> +/*
> + * returns the refcount on the inode. it can change arbitrarily.
> + */
> +static inline int icount_read_once(const struct inode *inode)
> +{
> +	return atomic_read(&inode->i_count);
> +}
> +
> +/*
> + * returns the refcount on the inode. The lock guarantees no new references
> + * are added, but references can be dropped as long as the result is > 0.
> + */
>  static inline int icount_read(const struct inode *inode)
>  {
> +	lockdep_assert_held(&inode->i_lock);
>  	return atomic_read(&inode->i_count);
>  }
>  
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index 116774886244..c8c8847bb6f6 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -190,7 +190,7 @@ TRACE_EVENT(generic_add_lease,
>  		__entry->i_ino = inode->i_ino;
>  		__entry->wcount = atomic_read(&inode->i_writecount);
>  		__entry->rcount = atomic_read(&inode->i_readcount);
> -		__entry->icount = icount_read(inode);
> +		__entry->icount = icount_read_once(inode);
>  		__entry->owner = fl->c.flc_owner;
>  		__entry->flags = fl->c.flc_flags;
>  		__entry->type = fl->c.flc_type;
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..32d560f12dbd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1278,7 +1278,7 @@ static void hook_sb_delete(struct super_block *const sb)
>  		struct landlock_object *object;
>  
>  		/* Only handles referenced inodes. */
> -		if (!icount_read(inode))
> +		if (!icount_read_once(inode))
>  			continue;
>  
>  		/*
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
