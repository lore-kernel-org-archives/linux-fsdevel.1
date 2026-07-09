Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDE3FE37B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594026; cv=none; b=trsyTQ1t+jP63QIbr3r3iDWPDB3CBPF+P1mAwG3BLghcVwHF7VRnqfE05so12x+aP1asCPKMAIgW+oOthmMxa0A2ifJef2CCveQHY71F83bT5k0XjyNiy4DSQ2sQIA9eHmiw4nWiKcuoRN0P+Sj1KGG3e9pN5eCHMnKI+RkSnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594026; c=relaxed/simple;
	bh=njCTzKtz+uBCrx6vZINFeWCwFjS1u8L6pqJFfFPI6Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hewmZjjxAwmtWXD7LsqPqpaMxl+XNIRJUTR12WpZxQ7+hQpCvk1MrbhOKOugz5KtSXhDokVMDLcuPgDp0XyD9tNCosTWbk+2V8PHw3K6sVW/WP1Jy6PsJxKTNsTp+Xkb7bV32TsFB2txOiyvaLAxI9MS7FV34/Gy6kceEI2fDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LHax4I++; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LHax4I++"
X-KPN-MessageId: 800399e9-7b83-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 800399e9-7b83-11f1-bfba-00505699b430;
	Thu, 09 Jul 2026 12:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=bGJ85lyswz7H64xtvY5/lRfspGPNd2ggZFXYklBEsPY=;
	b=LHax4I++KvfSgL9NuLOWgUBi1dfXl9X3IosCb1GxBkAbIGL2f2dlLrJSeiFzbg+QiEW0V47NkRzq3
	 Rs4Nl7mCCVAftibeBO9ZLF7qdZyCqb6mVNnegpeTAlxjorYgBmJt6qPoie/AqYB2+rU8BNf5xoLkqh
	 vq0Ryn2I4NzfcvZdaIfNg1mpmScg6enr21HYD19aYY6AkilsJmDdS5U7rFpuygwN/WHyqCQIaAJ9LQ
	 gOvFVE53tBcdXMf8dd6JilWVKJH8NH0erer1AFbGDMmm2TU2GADXDjctwhzgzjCXTCfxzY8UEYGkK+
	 jlq8NgcYJQULnSHcMT9XJ6C30W1Ze8A==
X-KPN-MID: 33|Vyna2IAIRpXftOMbMqP6NqzZyURmWe8oFc0pLlwGSvZSEqYbTpQHIRsO8K0Lhws
 E4SrZkDx5lbEZTQwgeBHdRz3qyevteVA8v/DX8wE7H/c=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WJIhhbMH98XZmzCvbPYv+WbbgljD0xEfauBx5MLe1WkAfyP0v4F9Laeasb8Upk2
 bRjkEFy6OwW11LBqA8EOzxQ==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7fbcdffa-7b83-11f1-87f1-00505699b758;
	Thu, 09 Jul 2026 12:46:54 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:46:48 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH 1/3] binfmt_misc: convert entry list to an hlist
Message-ID: <ak90aO482k7p5fdz@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
References: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
 <20260708-work-binfmt_misc-locking-v1-1-a009dd5b56db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-work-binfmt_misc-locking-v1-1-a009dd5b56db@kernel.org>

On Wed, Jul 08, 2026 at 06:51:16PM +0200, Christian Brauner wrote:
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
> index 84349fcb93f1..34de1b01e9c2 100644
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
> @@ -654,8 +654,8 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
>   *
>   * If the ->evict call was not caused by a super block shutdown but by a write
>   * to remove the entry or all entries via bm_{entry,status}_write() the entry
> - * will have already been removed from the list. We keep the list_empty() check
> - * to make that explicit.
> + * will have already been removed from the list. We keep the hlist_unhashed()
> + * check to make that explicit.

Right. That's a good idea. The code reads a bit confusing because of the
two ways we may end up in bm_evict_inode(), but that isn't an issue of
this patch specifically.

>  */
>  static void bm_evict_inode(struct inode *inode)
>  {
> @@ -668,8 +668,8 @@ static void bm_evict_inode(struct inode *inode)
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
> @@ -690,7 +690,7 @@ static void bm_evict_inode(struct inode *inode)
>  static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
>  {
>  	write_lock(&misc->entries_lock);
> -	list_del_init(&e->list);
> +	hlist_del_init(&e->node);
>  	write_unlock(&misc->entries_lock);
>  	locked_recursive_removal(e->dentry, NULL);
>  }
> @@ -746,7 +746,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		 * read-only. So we only need to take the write lock when we
>  		 * actually remove the entry from the list.
>  		 */
> -		if (!list_empty(&e->list))
> +		if (!hlist_unhashed(&e->node))
>  			remove_binfmt_handler(i_binfmt_misc(inode), e);
>  
>  		inode_unlock(inode);
> @@ -790,7 +790,7 @@ static int add_entry(Node *e, struct super_block *sb)
>  	d_make_persistent(dentry, inode);
>  	misc = i_binfmt_misc(inode);
>  	write_lock(&misc->entries_lock);
> -	list_add(&e->list, &misc->entries);
> +	hlist_add_head(&e->node, &misc->entries);
>  	write_unlock(&misc->entries_lock);
>  	simple_done_creating(dentry);
>  	return 0;
> @@ -863,8 +863,9 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
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
> @@ -890,7 +891,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		 * read-only. So we only need to take the write lock when we
>  		 * actually remove the entry from the list.
>  		 */
> -		list_for_each_entry_safe(e, next, &misc->entries, list)
> +		hlist_for_each_entry_safe(e, next, &misc->entries, node)
>  			remove_binfmt_handler(misc, e);
>  
>  		inode_unlock(inode);
> @@ -965,7 +966,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
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

I can't really comment on whether the cache bouncing is really as
significant a problem to warrant moving to RCU, but your argument makes
sense to me.

At any rate I see no issues here or with the RCU change. For this one,
feel free to add:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

Will look a bit more carefully at the RCU change later today/tomorrow.
