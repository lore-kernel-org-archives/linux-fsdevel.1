Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A60515968;
	Tue, 13 Oct 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897454; cv=none; b=lo0AfRF44yGG8Rw33z7DYNtapMyAhZbxBOQzRRlGGkXtNd13eUXKMbLvqjobMTU1r7kSipdXElWrHF67ZOu+MC3XBeBCgOYBNb1szcN1Hw01gKXmIVnIp71+8JSBoG7XaoUc7auVqS4OIpBZ1dpMyTumqVK83DImVHohdyPkv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897454; c=relaxed/simple;
	bh=M5bb2vuxIRX0JCYXwwLTaUqn1FwIZqc8uMadChtrgmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9NKn/IK7jlTT+IxTmymDW4bqQjeLpY+ukGUVQEVWmpEoF7YfWeg24+HieTNip2xIzCt1npc1CU9oI+i+Fw7TOvAlxejRD91wVe69QbH+Tf9kpQn6CP7pnzpYZBIAFAaHLNeN/PmqkmgqK153mxuBoigYcD2TojObLDDpq+4SCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=qdXCvWfD; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ybe1AGUB; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="qdXCvWfD";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ybe1AGUB"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id BAB8F26F7697;
	Tue, 13 Oct 2026 22:17:29 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791897449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMOGi9Alv0yO8V9KRbfuZjnW9LLoZol04WAXwOWhrBA=;
	b=qdXCvWfDUsNwY2vcZvD5tJpF8lSsxDurxwiw0t0RCG0Gv7uj91eKjtB+VMox1nRTsEz/4T
	EAmfadyGhH9fp235dKXPJl5H1LRkYyoSQ7j0pSh62cmnYEX196CKv+a6HrmazyR9+IGRks
	64p1ojzkRjFOC6b9GATdLoSxx5BZSuliCWSvRPKuB7dlLitBqyQpXtWH1TR+uQIqkYaUXD
	mzeniZoVivkbr62xZWD+YbH4Vol0rBbdDCaNnJvwoG/wV3UPMd1n0tPvAv2fW7ArwIUCDs
	0jDAzL9c1S8lGd7umjtbxTvC+ZikCoM2XDYunyrI7B9tJFaq2rzUSwC/b6dqZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791897449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMOGi9Alv0yO8V9KRbfuZjnW9LLoZol04WAXwOWhrBA=;
	b=ybe1AGUBnQpV6AAXjn4ods+7+Z42zJc2hrX/4RHCwW5noqmqk+fTp9P91cGQuVhANnmCjm
	uVpLQX9hVOmF6KDw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 4A039E00149;
	Tue, 13 Oct 2026 22:17:29 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 3DA2522000A7; Tue, 13 Oct 2026 22:17:29 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fat: support adding multiple clusters
In-Reply-To: <20261012171106.146243-3-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
	<20261012171106.146243-3-matheus.aalmeida@inf.ufrgs.br>
Date: Tue, 13 Oct 2026 22:17:29 +0900
Message-ID: <87h5ipn3iu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> fat_add_cluster() currently adds only one cluster to a file's chain,
> requiring multiple calls when adding more clusters.
>
> Add a fat_alloc_chain() helper that allocates a cluster chain
> but only returns the first cluster. Extend fat_add_cluster()
> to add multiple clusters in a single call and rename it to
> fat_add_clusters() to reflect the new behavior.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Looks good. Thanks.

> ---
>  fs/fat/fat.h    |  3 ++-
>  fs/fat/fatent.c | 18 ++++++++++++++++--
>  fs/fat/file.c   |  2 +-
>  fs/fat/inode.c  |  8 ++++----
>  4 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 61338413d..b18385461 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -395,6 +395,7 @@ extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
>  			 int new, int wait);
>  extern int fat_alloc_clusters(struct inode *inode, int *cluster,
>  			      int nr_cluster);
> +int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster);
>  extern int fat_free_clusters(struct inode *inode, int cluster);
>  extern int fat_count_free_clusters(struct super_block *sb);
>  extern int fat_trim_fs(struct inode *inode, struct fstrim_range *range);
> @@ -440,7 +441,7 @@ static inline unsigned long fat_dir_hash(int logstart)
>  {
>  	return hash_32(logstart, FAT_HASH_BITS);
>  }
> -extern int fat_add_cluster(struct inode *inode);
> +extern int fat_add_clusters(struct inode *inode, int nr_cluster);
>  
>  /* fat/misc.c */
>  extern __printf(3, 4) __cold
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index bfab8eab5..8897a5dd5 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -488,7 +488,8 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
>  	return 0;
>  }
>  
> -int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
> +static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
> +				bool return_all)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> @@ -531,7 +532,10 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  				if (sbi->free_clusters != -1)
>  					sbi->free_clusters--;
>  
> -				cluster[idx_clus] = entry;
> +				if (return_all)
> +					cluster[idx_clus] = entry;
> +				else if (!idx_clus)
> +					*cluster = entry;
>  				idx_clus++;
>  
>  				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
> @@ -581,6 +585,16 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  	return err;
>  }
>  
> +int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
> +{
> +	return __fat_alloc_clusters(inode, cluster, nr_cluster, true);
> +}
> +
> +int fat_alloc_chain(struct inode *inode, int *cluster, int nr_cluster)
> +{
> +	return __fat_alloc_clusters(inode, cluster, nr_cluster, false);
> +}
> +
>  int fat_free_clusters(struct inode *inode, int cluster)
>  {
>  	struct super_block *sb = inode->i_sb;
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 1c835ca5f..41d49e9de 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -292,7 +292,7 @@ static long fat_fallocate(struct file *file, int mode,
>  
>  		/* Start the allocation.We are not zeroing out the clusters */
>  		while (nr_cluster-- > 0) {
> -			err = fat_add_cluster(inode);
> +			err = fat_add_clusters(inode, 1);
>  			if (err)
>  				goto error;
>  		}
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index f775a004c..141276fcf 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -101,16 +101,16 @@ static struct fat_floppy_defaults {
>  },
>  };
>  
> -int fat_add_cluster(struct inode *inode)
> +int fat_add_clusters(struct inode *inode, int nr_cluster)
>  {
>  	int err, cluster;
>  
> -	err = fat_alloc_clusters(inode, &cluster, 1);
> +	err = fat_alloc_chain(inode, &cluster, nr_cluster);
>  	if (err)
>  		return err;
>  	/* FIXME: this cluster should be added after data of this
>  	 * cluster is writed */
> -	err = fat_chain_add(inode, cluster, 1);
> +	err = fat_chain_add(inode, cluster, nr_cluster);
>  	if (err)
>  		fat_free_clusters(inode, cluster);
>  	return err;
> @@ -152,7 +152,7 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
>  	 */
>  	if (!offset && !(iblock < last_block)) {
>  		/* TODO: multiple cluster allocation would be desirable. */
> -		err = fat_add_cluster(inode);
> +		err = fat_add_clusters(inode, 1);
>  		if (err)
>  			return err;
>  	}

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
