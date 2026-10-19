Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB234973B1;
	Mon, 19 Oct 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406702; cv=none; b=ZT9Q5dFTQT1jLqCRoOztDB3hf91ikcd4jBwT9uLnJ5vHcVhEJXhfQf7kXHrrKfVAj5GQAeNNTWuGl43xw7TR8kJXYAVfsauH4sFxrc5iG7OPt0f5S/x3wr+JUbQjfKe+l3cSn5wc9ihrLZa4jfkhqn9MwTb0UCaARTAoFgniFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406702; c=relaxed/simple;
	bh=5fKUw3ye2dpBX7D02s0mOAzMeQdPOHkxfD4Y5oCcops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSd+QCf7P45NfxcQ14Ncui+VqkIjfq7KAohFWEDGxjg3IooOjGBgT5y6ZpQtGeQucXcDAsvAu5y3cxWodCOE1hA1kjFxwnujy5KnefqKZ2oqxIhGCn4JLeoS5d9Grs4csbWcVX7gUXZc+kEyQCD2nLk8Is26rcOFXG/ITQ9POAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JYNtwTyX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/J5cGy10; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+ASm309; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+l8kl4Yx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JYNtwTyX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/J5cGy10";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+ASm309";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+l8kl4Yx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E34F921C94;
	Mon, 19 Oct 2026 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792406694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzOS06+q7lTMT5iTkJ/yNXREo3iy8BxlycJzay+QDQM=;
	b=JYNtwTyXj+H4IOFDTZCN4PFA8TV6ausm+PjxCdi210GJ6hL/c7CnySaGyFPAKp2b1ONpmM
	G1xI37vDW6wDRcr1Aa5wOo1s0e+mOt2AMW6HzMHYhaKHtdhqyfXH6jo3d02ubHo7jD6orp
	1MGNiKf2cnrMdMCo+wwYSER2hUBzgLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792406694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzOS06+q7lTMT5iTkJ/yNXREo3iy8BxlycJzay+QDQM=;
	b=/J5cGy10RFixle1IZwG2w2AiabLRxv6QEAimh6DjFsbcjiM27rlrOmzV2eAct3gvLh2Zaq
	+F8SAW55NzTleaDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H+ASm309;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+l8kl4Yx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792406693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzOS06+q7lTMT5iTkJ/yNXREo3iy8BxlycJzay+QDQM=;
	b=H+ASm309wNdQvHJW0atUwFnEcODdzQ5y4t024qpBR92MEQVsKdKmVN0KZ61dWmOVZOm5OY
	RnhgNBuqpXcSqi0EsDBApKXkLUtW7qbp4zi7znPGKo9hfecYfgkpeVceapIC7yHWH01p/I
	gucVvGK/KR/dTUl1Rqlrwc8cIYwTVrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792406693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzOS06+q7lTMT5iTkJ/yNXREo3iy8BxlycJzay+QDQM=;
	b=+l8kl4YxKc9Oe2gZx6Ye8iZYIYaPjHeVdP/JBQWubxm9qWknXnO/Bl0JO0C8y4Z/E/OSoZ
	uL6Wv51+kRHsGqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B949A136CC;
	Mon, 19 Oct 2026 10:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rQuJI6X01WqmeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 10:44:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EEDDA1413; Mon, 19 Oct 2026 12:44:49 +0200 (CEST)
Date: Mon, 19 Oct 2026 12:44:49 +0200
From: Jan Kara <jack@suse.cz>
To: YouYou Yu <youyouyu@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Lichen Liu <lichliu@redhat.com>, Dylan Johnson <dgj@amazon.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH] quota: initialize dquot cache before mounting rootfs
Message-ID: <4x3ngu2v723xnbommkln6yjwj27qdiy53dphxp74thsbihfqcr@rehvrhj7egvk>
References: <20261015183608.22507-1-youyouyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015183608.22507-1-youyouyu@amazon.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E34F921C94
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 15-10-26 18:36:08, YouYou Yu wrote:
> Booting with CONFIG_TMPFS_QUOTA=y, an initramfs, no root= and
> "initramfs_options=usrquota" panics at boot:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:dqget+0x1ac/0x490
>   Call Trace:
>    __dquot_initialize
>    dquot_initialize
>    shmem_get_inode
>    shmem_fill_super
>    ...
>    mnt_init
>    vfs_caches_init
>    start_kernel
> 
> The rootfs is mounted from mnt_init(), but the dquot hash table and
> cache are only set up later by dquot_init(), an fs_initcall. Creating
> the root inode of a quota enabled rootfs thus dereferences the NULL
> dquot_hash in dqget().
> 
> Rename dquot_init() to dquot_cache_init() and call it from
> vfs_caches_init() before mnt_init(). The slab, percpu and early
> workqueue code it relies on is available there, and the workqueue
> rescuer and shrinker debugfs entries are set up later by their own
> subsystems. Keep the sysctl registration in an fs_initcall, as done
> for the dcache, inode and mount sysctls. This only moves existing
> allocations earlier in boot.
> 
> Fixes: 278033a225e1 ("fs: Add 'initramfs_options' to set initramfs mount options")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Dylan Johnson <dgj@amazon.com>
> Signed-off-by: Dylan Johnson <dgj@amazon.com>
> Signed-off-by: YouYou Yu <youyouyu@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>

Dunno, I'd say: "don't do it when it hurts"... I definitely don't think
anybody sane wants quotas on initramfs. Is this just a fuzzing result or
are you really interested in that functionality?

Instead of pulling quota into early boot I'd just refuse tmpfs mount in
this case (same result as original behavior but clearer error message :)).

								Honza

> ---
> 
> Notes:
>     Tested on v7.3-rc7, x86_64 QEMU/KVM, booting from an initramfs without root=:
>     - without this patch, initramfs_options=usrquota panics in dqget() as above
>     - with it, initramfs_options=usrquota,grpquota,usrquota_block_hardlimit=10M
>       boots, rootfs is mounted with quotas, and a non-root user is limited to
>       10M on rootfs
>     - /sys/kernel/slab/dquot, the quota_events_unbound rescuer, the fs/quota
>       sysctls and (with CONFIG_SHRINKER_DEBUG) the dquota-cache shrinker
>       debugfs entry are all created as expected
>     
>     An LLM (Claude Opus 5.5) helped drafting this changelog.
>     I reviewed the change and ran the tests above.
> 
>  fs/dcache.c              |  2 ++
>  fs/quota/dquot.c         | 10 ++++++----
>  include/linux/quotaops.h |  5 +++++
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index f44c7b39c3b..b208cbdda0f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -32,6 +32,7 @@
>  #include <linux/bit_spinlock.h>
>  #include <linux/rculist_bl.h>
>  #include <linux/list_lru.h>
> +#include <linux/quotaops.h>
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -3525,6 +3526,7 @@ void __init vfs_caches_init(void)
>  	inode_init();
>  	files_init();
>  	files_maxfiles_init();
> +	dquot_cache_init();
>  	mnt_init();
>  	bdev_cache_init();
>  	chrdev_init();
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 1c78c695d0d..cd142c9cc7e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2942,7 +2942,7 @@ static const struct ctl_table fs_dqstats_table[] = {
>  	},
>  };
>  
> -static int __init dquot_init(void)
> +void __init dquot_cache_init(void)
>  {
>  	int i, ret;
>  	unsigned long nr_hash;
> @@ -2950,8 +2950,6 @@ static int __init dquot_init(void)
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
>  
> -	register_sysctl_init("fs/quota", fs_dqstats_table);
> -
>  	dquot_cachep = kmem_cache_create("dquot",
>  			sizeof(struct dquot), sizeof(unsigned long) * 4,
>  			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> @@ -2992,7 +2990,11 @@ static int __init dquot_init(void)
>  					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
>  	if (!quota_unbound_wq)
>  		panic("Cannot create quota_unbound_wq\n");
> +}
>  
> +static int __init init_fs_dquot_sysctls(void)
> +{
> +	register_sysctl_init("fs/quota", fs_dqstats_table);
>  	return 0;
>  }
> -fs_initcall(dquot_init);
> +fs_initcall(init_fs_dquot_sysctls);
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index f9c0f9d7c9d..bbe22c22439 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -40,6 +40,7 @@ void __quota_error(struct super_block *sb, const char *func,
>  /*
>   * declaration of quota_function calls in kernel.
>   */
> +void dquot_cache_init(void);
>  int dquot_initialize(struct inode *inode);
>  bool dquot_initialize_needed(struct inode *inode);
>  void dquot_drop(struct inode *inode);
> @@ -206,6 +207,10 @@ static inline int sb_has_quota_active(struct super_block *sb, int type)
>  	return 0;
>  }
>  
> +static inline void dquot_cache_init(void)
> +{
> +}
> +
>  static inline int dquot_initialize(struct inode *inode)
>  {
>  	return 0;
> 
> base-commit: 7c6f8a2841d4eeeceacf42689cd2717fe76d9f7c
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
