Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A322773E5
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783804861; cv=none; b=I8Bn6aUWaCGc5So/AgijjSMlk7hrZsw/+Z2gd4VkLBPSn/XUnqtgKd2k6gtY28v0vwZbRu0236wUAerkFdKtvbHsHWIYOCqLYfaX6K5JaMyZA9sKLhxiX4+mDJmVq9O9a1k33LHs6HFKVJysCB9QnMlkAM0iDNqa8K8OR1UzneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783804861; c=relaxed/simple;
	bh=An2mNuOkw6P1i4zAfPOKymVhD3UUhg04jBDX4MyQ7uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np5eWotBj5mpppvpZxoshF3JVy8OVxqIFi47HmNqbXa19592E1k4csQXVrLIKHokllNBbzFBj7cPjKhapgOvFN3bwDI+a2exvzJZ5rRiRZIaB/I+uGNoOp+Pu8syfj6h22jC3aHxkYlJtMwE44hberFF3Ai7Kq6qaZ7fZNAb4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VDU6jWu4; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VDU6jWu4"
X-KPN-MessageId: 6305fb61-7d6e-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6305fb61-7d6e-11f1-bfba-00505699b430;
	Sat, 11 Jul 2026 23:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Xeac5EVu5qi4Q79F2YWykkgRu5GzQIzzrlLxl753Kqo=;
	b=VDU6jWu4Dk13vxkwScWOqAMptQTAYn4MDczcNvry5dYPEMhKs7CaqxMCr3bqO9wnBBkpNFFTCdMCl
	 c9HwLTKtlkxUwBd+xpE3eMzOQArPPm4tshM6ohEoZaywWPGWOc/B1rlME4kjSa1UN03C5m0OGtv6kY
	 ZkPDhNu6rkVowdIki6LPgqXy5nJxb/X5cEOlmZy0AHTzpep5d7Ti8UkuvqRXhQtJZ4AeWs5lJ3y083
	 MBus7KW5eRsWuEbKiNTbnNYXzY57LmT7orM93oa8ycWy5B9J1V9BvqAatHrpPs5+RMkuqMxPrJ8hC6
	 N15vHFDgrQqpLCoSEc4xhHQ017KlrmA==
X-KPN-MID: 33|MZHY6HNOvUJdXnLQtlvnu7ROFiCu5tboXf/em/FrjBzcWfhG3bSuw4SBdSdxYaT
 et/JDX/ViAKOarnHn1zF/OdiR8GsBWmM9i6qQ8uEF8UA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pFSCXz8ciqPxmrlndYSJ+cOubXeU6shJNF6QminkDJUrNcnWOiMpjQS2XAXbB5t
 hb0Rh5zz+S25nGxLpWj7XbQ==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 62d9bf51-7d6e-11f1-807d-005056998788;
	Sat, 11 Jul 2026 23:20:48 +0200 (CEST)
Date: Sat, 11 Jul 2026 23:20:50 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 04/24] binfmt_misc: convert entry list to an hlist
Message-ID: <alKzLtO46jszVrfy@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-4-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-4-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:05AM +0200, Christian Brauner wrote:
> The upcoming conversion of the handler lookup to RCU walks cannot use
> list_del_init(): reinitializing the forward pointer of a removed entry
> would make a concurrent lockless walker standing on that entry loop
> back onto it indefinitely. The removal paths do rely on
> reinitialization though because bm_{entry,status}_write() and
> bm_evict_inode() need to detect whether an entry has already been
> unlinked.
> 
> hlists support exactly this pattern: hlist_del_init_rcu() keeps the
> forward pointer of the removed entry intact for concurrent walkers and
> only zeroes ->pprev with hlist_unhashed() serving as the linked test.
> 
> Convert the entry list to an hlist now while keeping the rwlock so the
> subsequent RCU conversion is a pure locking change. hlist_add_head()
> inserts at the head just as list_add() did so lookup precedence
> between registered handlers is unchanged.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c        | 25 +++++++++++++------------
>  include/linux/binfmts.h |  2 +-
>  kernel/user.c           |  2 +-
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index b7664d90eb8f..89da2d4e7f91 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -48,7 +48,7 @@ enum {Enabled, Magic};
>  #define MISC_FMT_OPEN_FILE (1UL << 28)
>  
>  typedef struct {
> -	struct list_head list;
> +	struct hlist_node node;
>  	unsigned long flags;		/* type, status, etc. */
>  	int offset;			/* offset of magic */
>  	int size;			/* size of magic/mask */
> @@ -95,7 +95,7 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
>  	Node *e;
>  
>  	/* Walk all the registered handlers. */
> -	list_for_each_entry(e, &misc->entries, list) {
> +	hlist_for_each_entry(e, &misc->entries, node) {
>  		char *s;
>  		int j;
>  
> @@ -666,8 +666,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
>   *
>   * If the ->evict call was not caused by a super block shutdown but by a write
>   * to remove the entry or all entries via bm_{entry,status}_write() the entry
> - * will have already been removed from the list. We keep the list_empty() check
> - * to make that explicit.
> + * will have already been removed from the list. We keep the hlist_unhashed()
> + * check to make that explicit.
>  */
>  static void bm_evict_inode(struct inode *inode)
>  {
> @@ -680,8 +680,8 @@ static void bm_evict_inode(struct inode *inode)
>  
>  		misc = i_binfmt_misc(inode);
>  		write_lock(&misc->entries_lock);
> -		if (!list_empty(&e->list))
> -			list_del_init(&e->list);
> +		if (!hlist_unhashed(&e->node))
> +			hlist_del_init(&e->node);
>  		write_unlock(&misc->entries_lock);
>  		put_binfmt_handler(e);
>  	}
> @@ -702,7 +702,7 @@ static void bm_evict_inode(struct inode *inode)
>  static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
>  {
>  	write_lock(&misc->entries_lock);
> -	list_del_init(&e->list);
> +	hlist_del_init(&e->node);
>  	write_unlock(&misc->entries_lock);
>  	locked_recursive_removal(e->dentry, NULL);
>  }
> @@ -758,7 +758,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		 * read-only. So we only need to take the write lock when we
>  		 * actually remove the entry from the list.
>  		 */
> -		if (!list_empty(&e->list))
> +		if (!hlist_unhashed(&e->node))
>  			remove_binfmt_handler(i_binfmt_misc(inode), e);
>  
>  		inode_unlock(inode);
> @@ -802,7 +802,7 @@ static int add_entry(Node *e, struct super_block *sb)
>  	d_make_persistent(dentry, inode);
>  	misc = i_binfmt_misc(inode);
>  	write_lock(&misc->entries_lock);
> -	list_add(&e->list, &misc->entries);
> +	hlist_add_head(&e->node, &misc->entries);
>  	write_unlock(&misc->entries_lock);
>  	simple_done_creating(dentry);
>  	return 0;
> @@ -875,8 +875,9 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  {
>  	struct binfmt_misc *misc;
>  	int res = parse_command(buffer, count);
> -	Node *e, *next;
> +	struct hlist_node *next;
>  	struct inode *inode;
> +	Node *e;
>  
>  	misc = i_binfmt_misc(file_inode(file));
>  	switch (res) {
> @@ -902,7 +903,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		 * read-only. So we only need to take the write lock when we
>  		 * actually remove the entry from the list.
>  		 */
> -		list_for_each_entry_safe(e, next, &misc->entries, list)
> +		hlist_for_each_entry_safe(e, next, &misc->entries, node)
>  			remove_binfmt_handler(misc, e);
>  
>  		inode_unlock(inode);
> @@ -977,7 +978,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!misc)
>  			return -ENOMEM;
>  
> -		INIT_LIST_HEAD(&misc->entries);
> +		INIT_HLIST_HEAD(&misc->entries);
>  		rwlock_init(&misc->entries_lock);
>  
>  		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 2c77e383e737..071da63f2b48 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -101,7 +101,7 @@ struct linux_binfmt {
>  
>  #if IS_ENABLED(CONFIG_BINFMT_MISC)
>  struct binfmt_misc {
> -	struct list_head entries;
> +	struct hlist_head entries;
>  	rwlock_t entries_lock;
>  	bool enabled;
>  } __randomize_layout;
> diff --git a/kernel/user.c b/kernel/user.c
> index 7aef4e679a6a..c6a2bfb4d918 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -23,7 +23,7 @@
>  
>  #if IS_ENABLED(CONFIG_BINFMT_MISC)
>  struct binfmt_misc init_binfmt_misc = {
> -	.entries = LIST_HEAD_INIT(init_binfmt_misc.entries),
> +	.entries = HLIST_HEAD_INIT,
>  	.enabled = true,
>  	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
>  };
> 
> -- 
> 2.53.0
> 

I'll just go from this series again:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
