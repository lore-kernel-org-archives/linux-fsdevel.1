Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62838886F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994941; cv=none; b=jTl0lV00uEpYxWs+4UUaXv8ux7xCTRJiJmvka37wCSoohrIWpoZ96ZhtJxYjhqLBp52BRca0/Cdjzph7DaWAD/w6X2ohzapU3mIYO5oe3rhSkDybnWp6WKRDvFmeE1crMCDIGZHXtDqQF+E+3x0oJnaPUTds8rkGvs9/fywgKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994941; c=relaxed/simple;
	bh=e1ZoB80WR7/IqF0YQw8XvEvkMmXThnyLtkJhPdcmeVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvmzGrimhZMg7ggy6poEEKMCMkffS8k0SUNErErxDEZqCfcvO/n88rLf0IoEL8Y1hEJs7/foZh9kykhGozkizcH6AdlCoem7GTdOKXPRURhvVQKI3Y2uo38JXuDcsAOX343xir1nt10RPCNZcYxtBa9yeQho+uUlxQduwSrcf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=YlaC956p; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="YlaC956p"
X-KPN-MessageId: 40948ed9-8841-11f1-8f54-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 40948ed9-8841-11f1-8f54-005056992ed3;
	Sat, 25 Jul 2026 17:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=N2caielAy5YWpSfpB/EvCdmvT5rYo4ECYSr3Z0BRh1k=;
	b=YlaC956pxurcbVdpySmYk4W1hG0rWtqeLuOXN0FesBalrGE6LRXyt0jhoufOiZrHOz0O0L3kJYvMd
	 WxYGGkfFpxk9zuTbAOSGTQbn8C4w3j7TJx0nBwgC3TZxyN4MZoCMNJuNmLgkx3AMiChd5lJX12IVOx
	 ln0vlt4hW/fpPDb5EoC9k1mWJGl+mbNJS3XiFHw71jody+LyxpvLPypjZBsu688DvkdioI3C87HHV+
	 luBw1L+Hc8qF3OS5ECGQhYyVwY/DZHNJPXXyPYIqbWFRRP2PsLkH7ytlS1GIQZy8fBgxCL/0Dlt6Ww
	 fOafHXtd1rGfigOPaGsUkP/xrq0i3tQ==
X-KPN-MID: 33|B+iYy1xhRWmj0mq9FQCVTULLba/wIX0QZ4uD5umAj/VgNq3X306kFN7L7VogFfD
 aX8XwpILauRRhWBzDeDHQAdj8MRe6FiAeSh3UULWhqYA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5gvSlG1MYtR2kFh3LM/ln0e9EiGfxMcSrfPFBq1WvKYa12t7NavajxYZmyQrm61
 b9mM5EverqLBHkX+M8CEeHQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 40379afb-8841-11f1-8089-005056998788;
	Sat, 25 Jul 2026 17:55:26 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:55:24 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 17/24] binfmt_misc: factor out the entry removal
Message-ID: <amTcOh-bqBGgp8me@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-17-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-17-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:18AM +0200, Christian Brauner wrote:
> Both write handlers open-code the same removal dance - grab the root
> inode lock, unlink, unlock - each carrying a verbatim copy of the
> same eleven-line locking comment, and bm_entry_write() reuses its
> inode variable for the root inode halfway through to pull it off.
> Move the dance into bm_remove_entry() and bm_remove_all_entries()
> and the locking rules into the kernel-doc of remove_binfmt_handler()
> which both helpers wrap.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 84 +++++++++++++++++++++++++++-----------------------------
>  1 file changed, 40 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 1f2b1d136819..d6bc2abc4a7f 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -686,11 +686,19 @@ static void bm_evict_inode(struct inode *inode)
>   * @e: binary type handler to remove
>   *
>   * Remove a binary type handler from the list of binary type handlers and
> - * remove its associated dentry. This is called from
> - * binfmt_{entry,status}_write(). In the future, we might want to think about
> - * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
> - * to use writes to files in order to delete binary type handlers. But it has
> - * worked for so long that it's not a pressing issue.
> + * remove its associated dentry.
> + *
> + * Adding and removing entries via bm_{entry,register,status}_write()
> + * happens under the exclusively held inode lock of the root dentry keeping
> + * the list stable for writers. load_misc_binary() walks it concurrently
> + * under RCU. The entries_lock is only held around the actual unlink to
> + * serialize against bm_evict_inode() which unlinks entries during umount
> + * without holding the root inode lock.
> + *
> + * In the future, we might want to think about adding a proper ->unlink()
> + * method to binfmt_misc instead of forcing callers to use writes to files
> + * in order to delete binary type handlers. But it has worked for so long
> + * that it's not a pressing issue.
>   */
>  static void remove_binfmt_handler(struct binfmt_misc *misc,
>  				  struct binfmt_misc_entry *e)
> @@ -701,6 +709,31 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
>  	locked_recursive_removal(e->dentry, NULL);
>  }
>  
> +/* Remove @e unless a concurrent write already unlinked it. */
> +static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
> +{
> +	struct inode *root = d_inode(sb->s_root);
> +
> +	inode_lock_nested(root, I_MUTEX_PARENT);
> +	if (!hlist_unhashed(&e->node))
> +		remove_binfmt_handler(i_binfmt_misc(root), e);
> +	inode_unlock(root);
> +}
> +
> +/* Remove all entries of the binfmt_misc instance @misc belonging to @sb. */
> +static void bm_remove_all_entries(struct binfmt_misc *misc,
> +				  struct super_block *sb)
> +{
> +	struct inode *root = d_inode(sb->s_root);
> +	struct binfmt_misc_entry *e;
> +	struct hlist_node *next;
> +
> +	inode_lock_nested(root, I_MUTEX_PARENT);
> +	hlist_for_each_entry_safe(e, next, &misc->entries, node)


I do wonder, we are relying on superblock lifetime rules to make this
iteration safe afais, and the reason we take the spinlock at all is to
not implicitly rely on that, but then here we do that anyway. But this
is already an assumption in the old code too, so

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

> +		remove_binfmt_handler(misc, e);
> +	inode_unlock(root);
> +}
> +
>  /* /<entry> */
>  
>  static int bm_entry_open(struct inode *inode, struct file *file)
> @@ -732,24 +765,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
>  	case BM_CMD_REMOVE:
> -		inode = d_inode(inode->i_sb->s_root);
> -		inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -		/*
> -		 * In order to add new element or remove elements from the list
> -		 * via bm_{entry,register,status}_write() inode_lock() on the
> -		 * root inode must be held.
> -		 * The lock is exclusive ensuring that the list can't be
> -		 * modified. Only load_misc_binary() can access the list
> -		 * concurrently and it does so under RCU. So entries_lock only
> -		 * needs to be held when an entry is actually unlinked to
> -		 * serialize against bm_evict_inode() during umount which
> -		 * unlinks without holding inode_lock.
> -		 */
> -		if (!hlist_unhashed(&e->node))
> -			remove_binfmt_handler(i_binfmt_misc(inode), e);
> -
> -		inode_unlock(inode);
> +		bm_remove_entry(e, inode->i_sb);
>  		break;
>  	default:
>  		return res;
> @@ -865,9 +881,6 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  {
>  	struct binfmt_misc *misc;
>  	int res = parse_command(buffer, count);
> -	struct hlist_node *next;
> -	struct inode *inode;
> -	struct binfmt_misc_entry *e;
>  
>  	misc = i_binfmt_misc(file_inode(file));
>  	switch (res) {
> @@ -878,24 +891,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		WRITE_ONCE(misc->enabled, true);
>  		break;
>  	case BM_CMD_REMOVE:
> -		inode = d_inode(file_inode(file)->i_sb->s_root);
> -		inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -		/*
> -		 * In order to add new element or remove elements from the list
> -		 * via bm_{entry,register,status}_write() inode_lock() on the
> -		 * root inode must be held.
> -		 * The lock is exclusive ensuring that the list can't be
> -		 * modified. Only load_misc_binary() can access the list
> -		 * concurrently and it does so under RCU. So entries_lock only
> -		 * needs to be held when an entry is actually unlinked to
> -		 * serialize against bm_evict_inode() during umount which
> -		 * unlinks without holding inode_lock.
> -		 */
> -		hlist_for_each_entry_safe(e, next, &misc->entries, node)
> -			remove_binfmt_handler(misc, e);
> -
> -		inode_unlock(inode);
> +		bm_remove_all_entries(misc, file_inode(file)->i_sb);
>  		break;
>  	default:
>  		return res;
> 
> -- 
> 2.53.0
> 
