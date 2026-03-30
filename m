Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEB3ACF12
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860430; cv=none; b=KFAsIwaq/8haxYh640UrQQXtOq6jark2r/jb4SFOb7vzNgQiIiQqrzTGroPNye5g4eNncImIg3b2y6rcLLkc4zUXR15HgJAyN69x556hjWQSF26zJyLRiVAkcf1YZYW0Fs+z4OJqwbFMVAUyiehIy6QumR8/A/P2DAzGxBgsm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860430; c=relaxed/simple;
	bh=9to3yYVQxNR5EDXryCeIMWXSbASvLRuKow+/Vk1cgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbDEf+ZQI0FRAYnryRVXCpRMq5p5aQxeG22Q8CsbuqPyydcMzJutn++EZknoRiQ+TdhkRC2AXiEEISoJIwunPNOkGMXmJtgVxQ4eLlcGyOZWN5LL1Lsmt8M4kaMSSkzmU6ggLkJXV2tbkJ6PiPtGFUDwe5Rnnv+fjwTW3+eteVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LA6VQFaV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBINRr61; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LA6VQFaV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBINRr61; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LA6VQFaV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBINRr61";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LA6VQFaV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBINRr61"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D8DE4D52A;
	Mon, 30 Mar 2026 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774860427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYhoeW0NFpo5IAxaIFd6DR9KWgqeYG6AEskDAveakJY=;
	b=LA6VQFaVx0w/eZmAds2cYKlNPRgBHDHaVSdCTySNLLMRvcpSCoEPjUmK382fhUMFtMq3aK
	p8xxRd5+rzJGN8AJzVqSCTwzM1+ji3HkEYgchNu43Jl4MdlQ0ZdVVX0PBgLRYjVkMusveT
	2772OM3izXyWUxmC8c4wTEIcZnz7NfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774860427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYhoeW0NFpo5IAxaIFd6DR9KWgqeYG6AEskDAveakJY=;
	b=sBINRr61DxAIlfLJ+NVIh4IJr14uA0khCNO2ZZVquFF3oCsa0hMbtmix3k++KiiSzsq/HO
	LPdnpF6MOcMVZJCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774860427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYhoeW0NFpo5IAxaIFd6DR9KWgqeYG6AEskDAveakJY=;
	b=LA6VQFaVx0w/eZmAds2cYKlNPRgBHDHaVSdCTySNLLMRvcpSCoEPjUmK382fhUMFtMq3aK
	p8xxRd5+rzJGN8AJzVqSCTwzM1+ji3HkEYgchNu43Jl4MdlQ0ZdVVX0PBgLRYjVkMusveT
	2772OM3izXyWUxmC8c4wTEIcZnz7NfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774860427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYhoeW0NFpo5IAxaIFd6DR9KWgqeYG6AEskDAveakJY=;
	b=sBINRr61DxAIlfLJ+NVIh4IJr14uA0khCNO2ZZVquFF3oCsa0hMbtmix3k++KiiSzsq/HO
	LPdnpF6MOcMVZJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671314A0A2;
	Mon, 30 Mar 2026 08:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKUkGYs4ymmSdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Mar 2026 08:47:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4200CA0A9E; Mon, 30 Mar 2026 10:47:07 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:47:07 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hide file and bfile caches behind runtime const
 machinery
Message-ID: <pvio7phmvc657ez2abb4tzv27w5eo7jfjjg4qx3liojb4qjppq@nk777j5bjt6w>
References: <20260328173728.3388070-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328173728.3388070-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

On Sat 28-03-26 18:37:28, Mateusz Guzik wrote:
> s/cachep/cache/ for consistency with namei and dentry caches.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c                         |  2 +-
>  fs/file_table.c                   | 31 +++++++++++++++++++------------
>  include/asm-generic/vmlinux.lds.h |  4 +++-
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 384c83ce768d..2c81c0b162d0 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -200,7 +200,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
>  	/*
>  	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
>  	 * and kvmalloc() will warn if the allocation size is greater than
> -	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
> +	 * INT_MAX, as filp_cache objects are not __GFP_NOWARN.
>  	 *
>  	 * This can happen when sysctl_nr_open is set to a very high value and
>  	 * a process tries to use a file descriptor near that limit. For example,
> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..c40ec1be2899 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -30,6 +30,8 @@
>  
>  #include <linux/atomic.h>
>  
> +#include <asm/runtime-const.h>
> +
>  #include "internal.h"
>  
>  /* sysctl tunables... */
> @@ -38,8 +40,10 @@ static struct files_stat_struct files_stat = {
>  };
>  
>  /* SLAB cache for file structures */
> -static struct kmem_cache *filp_cachep __ro_after_init;
> -static struct kmem_cache *bfilp_cachep __ro_after_init;
> +static struct kmem_cache *__filp_cache __ro_after_init;
> +#define filp_cache runtime_const_ptr(__filp_cache)
> +static struct kmem_cache *__bfilp_cache __ro_after_init;
> +#define bfilp_cache runtime_const_ptr(__bfilp_cache)
>  
>  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
>  
> @@ -74,9 +78,9 @@ static inline void file_free(struct file *f)
>  	put_cred(f->f_cred);
>  	if (unlikely(f->f_mode & FMODE_BACKING)) {
>  		path_put(backing_file_user_path(f));
> -		kmem_cache_free(bfilp_cachep, backing_file(f));
> +		kmem_cache_free(bfilp_cache, backing_file(f));
>  	} else {
> -		kmem_cache_free(filp_cachep, f);
> +		kmem_cache_free(filp_cache, f);
>  	}
>  }
>  
> @@ -234,13 +238,13 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
>  			goto over;
>  	}
>  
> -	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
> +	f = kmem_cache_alloc(filp_cache, GFP_KERNEL);
>  	if (unlikely(!f))
>  		return ERR_PTR(-ENOMEM);
>  
>  	error = init_file(f, flags, cred);
>  	if (unlikely(error)) {
> -		kmem_cache_free(filp_cachep, f);
> +		kmem_cache_free(filp_cache, f);
>  		return ERR_PTR(error);
>  	}
>  
> @@ -268,13 +272,13 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
>  	struct file *f;
>  	int error;
>  
> -	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
> +	f = kmem_cache_alloc(filp_cache, GFP_KERNEL);
>  	if (unlikely(!f))
>  		return ERR_PTR(-ENOMEM);
>  
>  	error = init_file(f, flags, cred);
>  	if (unlikely(error)) {
> -		kmem_cache_free(filp_cachep, f);
> +		kmem_cache_free(filp_cache, f);
>  		return ERR_PTR(error);
>  	}
>  
> @@ -295,13 +299,13 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
>  	struct backing_file *ff;
>  	int error;
>  
> -	ff = kmem_cache_alloc(bfilp_cachep, GFP_KERNEL);
> +	ff = kmem_cache_alloc(bfilp_cache, GFP_KERNEL);
>  	if (unlikely(!ff))
>  		return ERR_PTR(-ENOMEM);
>  
>  	error = init_file(&ff->file, flags, cred);
>  	if (unlikely(error)) {
> -		kmem_cache_free(bfilp_cachep, ff);
> +		kmem_cache_free(bfilp_cache, ff);
>  		return ERR_PTR(error);
>  	}
>  
> @@ -593,14 +597,17 @@ void __init files_init(void)
>  		.freeptr_offset = offsetof(struct file, f_freeptr),
>  	};
>  
> -	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
> +	__filp_cache = kmem_cache_create("filp", sizeof(struct file), &args,
>  				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
>  				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
> +	runtime_const_init(ptr, __filp_cache);
>  
>  	args.freeptr_offset = offsetof(struct backing_file, bf_freeptr);
> -	bfilp_cachep = kmem_cache_create("bfilp", sizeof(struct backing_file),
> +	__bfilp_cache = kmem_cache_create("bfilp", sizeof(struct backing_file),
>  				&args, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
>  				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
> +	runtime_const_init(ptr, __bfilp_cache);
> +
>  	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
>  }
>  
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1e1580febe4b..4f8e734c4336 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -975,7 +975,9 @@
>  		RUNTIME_CONST(shift, d_hash_shift)			\
>  		RUNTIME_CONST(ptr, dentry_hashtable)			\
>  		RUNTIME_CONST(ptr, __dentry_cache)			\
> -		RUNTIME_CONST(ptr, __names_cache)
> +		RUNTIME_CONST(ptr, __names_cache)			\
> +		RUNTIME_CONST(ptr, __filp_cache)			\
> +		RUNTIME_CONST(ptr, __bfilp_cache)
>  
>  /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
>  #define KUNIT_TABLE()							\
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
