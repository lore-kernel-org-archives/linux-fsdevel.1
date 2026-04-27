Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDD2EA749
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294904; cv=none; b=pnCakkgUPz7gHXVYxZnW+JHTgi70S9BZIGcEL1Egr4Aa5toQNoXmWQgbzraQDMchkkMQ6lb919BTlMhjro8kOWkTimMO5ixTGJoP2qSzs4iFVRS+TEVjJhNoZakv84LHp1nVLA9Ayu4ceGG4FyNGTcZMXI2JL8hYWXwWlsBgRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294904; c=relaxed/simple;
	bh=S1c9d/jr7w43ANbE7m7+/oGdlxvY8ri7HX7HICnmuTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQaXMRw8IWe+iZHEqtJiqtiBxnde8RTPUoevz5YJnmjT7tHs426OEhMoKE+K+cm88nwqkbpVI3f61gwsn0LdH1WFtq3FgR4SA3IJy0NfJtRi8MEgDswU0HuReDMsl5iEvmIrB/88jRXv1LV2iopwidLLdJc+y4QL5wMx8zM+CsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2KYPalb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2KYPalb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so127204225e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777294902; x=1777899702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKk3ZzGqPoxad8o9BetIXz6fD01VB9XTvLwJqis+UP8=;
        b=Q2KYPalbQaFr6kkwH2Lnf1ZpKfQ5wZdAgFZ2g2u3jR2bo4vNpxbOimV0gqnWgafB7/
         knpMqYtKTYIR7X3ejL6Ejhz7zHCEACMju4LyYzrYFUS5mcSitQIGdwO8QhgD8kB8c9Zh
         1XCTzQMqpdkoqt0U41P/JQhXGts8+ZET61KpiS83XyeSLO/6nbrJIMryuCm5bYQn16S6
         pPyS+d2mdlFF1D8DphND0ioRa/c1CVuxuq0EgvfFKMeQX79GBoihPYHzw20M25qBx4bE
         436jQRM6V5PTMk5N2tYOslRz/oNYTKscP6QEhjGc21v2gwgsN+9ik/O+oQYueYie5vxZ
         7f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294902; x=1777899702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKk3ZzGqPoxad8o9BetIXz6fD01VB9XTvLwJqis+UP8=;
        b=ftE5Dvz4fYo1VHx2WdSanyJMkSG3SS0TvW58EMiUW1Yoqt8vLyEOZFRHJORe359ySa
         6gnwgKCVNSC3X/fl947PG8dkI6GlmVFXjDzq/xR88yM3MKMe8MIdWsiek013PgCXaScl
         dn/dvxNmhnj4DGVSGb+SDxaCjcdBoyFTc44h+QJQ7m7uSh3yTX8Zwbt6Sm0x0IrXlmIY
         WNzoBEfjtt6+73booPcBZmvlmuupPjh5/1VFK/99xnKhlHQgjidV7xYPiOa2MvZbwwNV
         /oZYO+1n4lEjJthqIxJhAANly4TUo6uoGuGRWGB++F6ALATe0PbVmDy3JSJVEJjzpLkx
         wz6A==
X-Forwarded-Encrypted: i=1; AFNElJ9eqtyZVNeZFltx0Us9p83MHzGB+OlJdsFohTWOuCuWT2rxzsNmoH0y8j1MleyiQWbeh7FdOMxZ18kqho82@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtJtrlXdS3PAysHsmtLWvbP4YyZHswcPCvzTTXFFTli2Lpmym
	Dqv782RQ6XNSJcT0Z1il9amQHT+hEHwUkYL3e2Ow81fDkuaNH/hlEjCdHFGp0YuO0xY=
X-Gm-Gg: AeBDievDwGXukMpGf+BIiR3SPshkbAE4mPmbBuDC5BV7aaPHODSAkBiZ91jgWro9DK1
	vbOrDRYgHYqnW7UkL+lpMhspTguf8CmZb7c+vMUsxhJ/Re38DKuUqEFqlkZ91CwILMgox4rLfDf
	Kj3oGdsORItr8INZx/0ts9oFpTyciakrunYEVpRoRh4+YML7oAsHCQxVyBAVQFW4F7Y5+wBdIJj
	rXhKI293PaHm6k6v9MWxSH4KW/Z07YrFBO9Q++3NDms95H5U3WvTGwELWYg8OdG1/ZNUh1a2Q+r
	cHuaggROIImXwybx/rZhN2lUg3m+aEP3yDBev0dnyzKnkBbZMuSdHh2wlZTgtrxmFNPH3itPTS8
	yyMCx/mWq+EHV0x6eCDNEtzYga5ZpKfp4rpsGuuMSIuIVK/DDIxmFHIHrRwwt5od6AOiipvt3wG
	Yf1zxD0EJ58esPKE5e7I8KzU9KeR4TDbiQooKe+mPOniRyLZQ=
X-Received: by 2002:a05:600d:8408:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-488fb73dc6fmr477069085e9.6.1777294901488;
        Mon, 27 Apr 2026 06:01:41 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm86264355f8f.6.2026.04.27.06.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:01:40 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:01:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com
Subject: Re: [PATCH] rhashtable: give each instance its own lockdep class
Message-ID: <ae9eLXK72grTV2wd@tiehlicka>
References: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>

On Mon 27-04-26 13:09:57, Christian Brauner wrote:
> syzbot reported a possible circular locking dependency between
> &ht->mutex and fs_reclaim:
> 
>   CPU0 (kswapd0)                    CPU1 (kworker)
>   --------------                    --------------
>   fs_reclaim                        ht->mutex
>     shmem_evict_inode                 rhashtable_rehash_alloc
>       simple_xattrs_free                bucket_table_alloc(GFP_KERNEL)
>         rhashtable_free_and_destroy       __kvmalloc_node
>           mutex_lock(&ht->mutex)            might_alloc -> fs_reclaim
> 
> The two halves of the splat refer to two different events on
> &ht->mutex.
> 
> The kswapd0 path is unambiguous: shmem_evict_inode at mm/shmem.c:1429
> calls simple_xattrs_free(), which calls rhashtable_free_and_destroy()
> on the per-inode simple_xattrs rhashtable being torn down with the
> inode.
> 
> The previously-recorded ht->mutex -> fs_reclaim edge comes from
> rht_deferred_worker -> rhashtable_rehash_alloc ->
> bucket_table_alloc(GFP_KERNEL) -> __kvmalloc_node ->
> might_alloc -> fs_reclaim. That stack stops at generic library code:
> there is no subsystem-specific frame above rht_deferred_worker, so
> the splat does not identify which rhashtable's worker recorded the
> edge -- only that some rhashtable in the system did.
> 
> Whether or not that recording happened on the same simple_xattrs ht
> that is now being destroyed, the predicted deadlock cannot occur:
> rhashtable_free_and_destroy() does cancel_work_sync(&ht->run_work)
> before taking ht->mutex, so the deferred worker cannot be running on
> the instance being torn down. If the recording was on a different
> rhashtable instance, the two ht->mutex acquisitions are on distinct
> mutex objects and cannot deadlock either.
> 
> Lockdep flags a cycle regardless because mutex_init(&ht->mutex) lives
> on a single source line in rhashtable_init_noprof(), so every
> ht->mutex in the kernel shares one static lockdep class. Lockdep
> matches by class, not by instance, and collapses all of these into
> one node.
> 
> Lift the lockdep key out of rhashtable_init_noprof() and into the
> caller. The user-visible rhashtable_init_noprof() /
> rhltable_init_noprof() identifiers become macros that declare a
> per-call-site static lock_class_key.
> 
> Reported-by: syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/69e798fe.050a0220.24bfd3.0032.GAE@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/rhashtable-types.h | 22 ++++++++++++++++++----
>  lib/rhashtable.c                 | 17 ++++++++++-------
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
> index 015c8298bebc..841021c67d3d 100644
> --- a/include/linux/rhashtable-types.h
> +++ b/include/linux/rhashtable-types.h
> @@ -131,12 +131,26 @@ struct rhashtable_iter {
>  	bool end_of_table;
>  };
>  
> -int rhashtable_init_noprof(struct rhashtable *ht,
> -		    const struct rhashtable_params *params);
> +int __rhashtable_init_noprof(struct rhashtable *ht,
> +		    const struct rhashtable_params *params,
> +		    struct lock_class_key *key);
> +#define rhashtable_init_noprof(ht, params)				\
> +({									\
> +	static struct lock_class_key __key;				\
> +									\
> +	__rhashtable_init_noprof(ht, params, &__key);			\
> +})
>  #define rhashtable_init(...)	alloc_hooks(rhashtable_init_noprof(__VA_ARGS__))
>  
> -int rhltable_init_noprof(struct rhltable *hlt,
> -		  const struct rhashtable_params *params);
> +int __rhltable_init_noprof(struct rhltable *hlt,
> +		  const struct rhashtable_params *params,
> +		  struct lock_class_key *key);
> +#define rhltable_init_noprof(hlt, params)				\
> +({									\
> +	static struct lock_class_key __key;				\
> +									\
> +	__rhltable_init_noprof(hlt, params, &__key);			\
> +})
>  #define rhltable_init(...)	alloc_hooks(rhltable_init_noprof(__VA_ARGS__))
>  
>  #endif /* _LINUX_RHASHTABLE_TYPES_H */
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6074ed5f66f3..fb13749d824a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -1025,8 +1025,9 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
>   *	.obj_hashfn = my_hash_fn,
>   * };
>   */
> -int rhashtable_init_noprof(struct rhashtable *ht,
> -		    const struct rhashtable_params *params)
> +int __rhashtable_init_noprof(struct rhashtable *ht,
> +		    const struct rhashtable_params *params,
> +		    struct lock_class_key *key)
>  {
>  	struct bucket_table *tbl;
>  	size_t size;
> @@ -1036,7 +1037,7 @@ int rhashtable_init_noprof(struct rhashtable *ht,
>  		return -EINVAL;
>  
>  	memset(ht, 0, sizeof(*ht));
> -	mutex_init(&ht->mutex);
> +	mutex_init_with_key(&ht->mutex, key);
>  	spin_lock_init(&ht->lock);
>  	memcpy(&ht->p, params, sizeof(*params));
>  
> @@ -1087,7 +1088,7 @@ int rhashtable_init_noprof(struct rhashtable *ht,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
> +EXPORT_SYMBOL_GPL(__rhashtable_init_noprof);
>  
>  /**
>   * rhltable_init - initialize a new hash list table
> @@ -1098,15 +1099,17 @@ EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
>   *
>   * See documentation for rhashtable_init.
>   */
> -int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
> +int __rhltable_init_noprof(struct rhltable *hlt,
> +			   const struct rhashtable_params *params,
> +			   struct lock_class_key *key)
>  {
>  	int err;
>  
> -	err = rhashtable_init_noprof(&hlt->ht, params);
> +	err = __rhashtable_init_noprof(&hlt->ht, params, key);
>  	hlt->ht.rhlist = true;
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(rhltable_init_noprof);
> +EXPORT_SYMBOL_GPL(__rhltable_init_noprof);
>  
>  static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
>  				void (*free_fn)(void *ptr, void *arg),
> 
> ---
> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
> change-id: 20260427-work-rhashtable-lockdep-cb0356367073

-- 
Michal Hocko
SUSE Labs
