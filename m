Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666628;
	b=49ArijeaJVY4E39ll+4ez5ayjpLMXfafWroo7qXUlhq+edJu27VY1GigjnierzYnZ+r7
	 Tf0G2pRbVLRdoxGVQbUCJdNylJnmeWwGCzHSi9P3M74fklSYIX9uQkSGr+c4qqbDLB5Hq
	 IZgukloUzcMyCcPC4fKjsw8LE25x0CjfRNa3AmI4RfMsMFT0DFkPu4cjpz8Qi7KZ9uJol
	 YA6+5lCRMefzv/QehYpMdR/WResSU9alDYXkW0eGdffZzAIVcrqPAX1sVWNKfI+AtiCz0
	 FMJyV2TJ3a4/EmlryW1pjGv4fqXNPZNWBfFgmlmYuzapCBPENB3+hQzT9xeuP5ojqHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666628;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=FAyjraBBb9RMWkHn1WdC+mM+XPjw7nXzI5R/bAWnv5c=;
	b=lGFkQ/B6pXFgqEVmxHtMWCdEFLOMvnak+SCjqPXmfIMqKNHieW4EMGISf1JmUqOdJT1L
	 XwunTD+gFX4AATm9UhB9fzRBEkwBIHvFtUkWay0c/kElMKal+wNWGJgACTUT+hNVAUu2K
	 i9LVVkUOG5VmJrkxSM0C14OFkAv53aFlC5+g2ubJJVIX1vCt9Zi3dPtSzJGcLv9TyOE+g
	 7uamY3RKOHbudPufEPEX42DymoyEC3fO8N1wNlOB4VieFVspv8QMR6HNrdp1yEUroPl6b
	 qAVDYsc3TWA0D2pRxMC2D9FCIU377rHnT+Zpu0UdCt4rPDpqoxCxATqA12ULpykWD4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LTbsAFvx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FdLwxh0r;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LTbsAFvx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FdLwxh0r;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DB7606A31D;
	Thu, 22 Oct 2026 10:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DB7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LTbsAFvx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FdLwxh0r;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LTbsAFvx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FdLwxh0r
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31F9C1F801;
	Thu, 22 Oct 2026 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792666626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAyjraBBb9RMWkHn1WdC+mM+XPjw7nXzI5R/bAWnv5c=;
	b=LTbsAFvxmNN/VbDwsM8gor2tT4swuPGtz2A/2Zzok4D+U5lr4zjXMKJFumgtNmYR8cAzwz
	FA/QSoYGPv6a09iJUqCH2NDBeZ0DuKYtqugl2/v2V3KMbkIAzkqiUxVQxMy994EyOrq3rq
	jMsyESVuTICrkOKJZycBThGubTO4vW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792666626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAyjraBBb9RMWkHn1WdC+mM+XPjw7nXzI5R/bAWnv5c=;
	b=FdLwxh0rTUNtNG/OdXWB+WyqMooLT1kYGgelPbqfsGvwqMfNBDOTTteS+N97XV35RgFOZK
	mKFrxox4AWl1sbAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792666626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAyjraBBb9RMWkHn1WdC+mM+XPjw7nXzI5R/bAWnv5c=;
	b=LTbsAFvxmNN/VbDwsM8gor2tT4swuPGtz2A/2Zzok4D+U5lr4zjXMKJFumgtNmYR8cAzwz
	FA/QSoYGPv6a09iJUqCH2NDBeZ0DuKYtqugl2/v2V3KMbkIAzkqiUxVQxMy994EyOrq3rq
	jMsyESVuTICrkOKJZycBThGubTO4vW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792666626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAyjraBBb9RMWkHn1WdC+mM+XPjw7nXzI5R/bAWnv5c=;
	b=FdLwxh0rTUNtNG/OdXWB+WyqMooLT1kYGgelPbqfsGvwqMfNBDOTTteS+N97XV35RgFOZK
	mKFrxox4AWl1sbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07457134E6;
	Thu, 22 Oct 2026 10:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CyMVNQHs2WquSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:57:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8BEEDA1417; Thu, 22 Oct 2026 12:57:01 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:57:01 +0200
From: Jan Kara <jack@suse.cz>
To: YouYou Yu <youyouyu@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Lichen Liu <lichliu@redhat.com>, Dylan Johnson <dgj@amazon.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH v2] quota: initialize dquot cache before mounting rootfs
Message-ID: <oqejyckyaveuwypy3z7jv75qotfmcymzs7upabb4uif6ko7jgr@c6t4myvo56vn>
References: <20261021181217.20171-1-youyouyu@amazon.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021181217.20171-1-youyouyu@amazon.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 18:12:17, YouYou Yu wrote:
> On some systems, a tmpfs backed rootfs is extensively used throughout
> system's lifecycle. tmpfs quotas are needed to limit per user rootfs
> usage. However, booting with CONFIG_TMPFS_QUOTA=y, an initramfs, no root=
> and "initramfs_options=usrquota" panics at boot:
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

Thanks! I've added the patch to my tree.

								Honza

> ---
> 
> Notes:
>     v2:
>     - Mention the use case in the changelog (Jan)
>     
>     v1:
>     https://lore.kernel.org/all/20261015183608.22507-1-youyouyu@amazon.com/
>     
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
