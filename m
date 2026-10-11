Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840436194B;
	Sun, 11 Oct 2026 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745074; cv=none; b=if8DZ4/ClElvfNCZ/nB1rgUl5/h8fqKlPp5DUIANy3WVdPWYm8S+zjqJ1sBGLfCvYdnW4z+gsIQVKiIAnPtArm1oUYCfAXNSTe98prrvuW1wCUbpl7sF5pFQPbnG6hWOXBkBUNYB6MFy07pRcasIxx9cZHIEUr8DGYt0Stvwa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745074; c=relaxed/simple;
	bh=REl+tppxvSHabgdSvrzG8Ka/zUm84pDQokIz7/Unu5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcjzBu23Py1Njw8NCn0TswfgARNcE2kxHTuUejwXv/xJrVht4traVClQanlqg/RQ/d0Pd/6ZTeA0zqVkyTKlfnC7+QHuBOaePkpcd6gp7QP5p1pRRMTultkVZUFWn+Z4EgkNKifdIqkXR8NZYIWhgYHF120zxOmHKDUVCy/rUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=r4gjlvfy; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=MY253s+b; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="r4gjlvfy";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="MY253s+b"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id D2D70209679B;
	Mon, 12 Oct 2026 03:57:49 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791745069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozaGIn1BmAHL8GW0iF0GtmkWIVrQ/+b8AEY9wpf79k=;
	b=r4gjlvfyGEHb+f/x9llx63L0il5YuSerZhUiircHs/jsHSzYU2XwLVP883vgJg0uGSknmw
	p4eZmYEVKXu5Dq4CqSKOxLmYIQCi0I+wBcI8sq+wVBa0e0+QiiD+vaj5Hu6EX59NBzpkPR
	KNw93Q9I47eH18wyRUXdaKTnDUC/9N5VgHjhr30/SCmq5c6Z8596mAXoHYsXM7CFwgQifn
	qlR60fpCZHEgKkGutChxb6zDGKyQ8606bxIkVM48U/ShgzXgR1vi9kfP5XK/+qWnFDyhvr
	u2eORFXHJRJlaVOyhU+3h8hnWT44mku3TNQasKDwu9UyyYKPV3TcfWMFEF49Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791745069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozaGIn1BmAHL8GW0iF0GtmkWIVrQ/+b8AEY9wpf79k=;
	b=MY253s+bIxiRHlo4+hHok0W8opt2L9D2CqLShx5rHJTm5VqdsS675TOvnN2bd0v3zYnT3D
	fuh7V/jHwPfgbOCA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 63ABFE00134;
	Mon, 12 Oct 2026 03:57:49 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 509A122000EE; Mon, 12 Oct 2026 03:57:49 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fat: return only first cluster when allocating
In-Reply-To: <20261008020941.55784-3-matheus.aalmeida@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
	<20261008020941.55784-3-matheus.aalmeida@inf.ufrgs.br>
Date: Mon, 12 Oct 2026 03:57:49 +0900
Message-ID: <87zewkkqtu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> fat_alloc_clusters() returns every allocated cluster number in an array.
> For larger allocations, like growing a file, this array would need to be
> very large.
>
> Make fat_alloc_clusters() return only the first allocated cluster in the
> chain. Update fat_add_new_entries() to follow the chain when it needs
> the second cluster.

This would be more common case than fallocate(), so penalize this part
would not be good.

Thanks.

> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/dir.c    | 20 +++++++++++++++++++-
>  fs/fat/fat.h    |  2 +-
>  fs/fat/fatent.c | 17 +++++++++--------
>  3 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 35bdb6294..672d5e392 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1245,6 +1245,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  	sector_t blknr, start_blknr, last_blknr;
>  	unsigned long size, copy;
>  	int err, i, n, offset, cluster[2];
> +	struct fat_entry fatent;
>  
>  	/*
>  	 * The minimum cluster size is 512bytes, and maximum entry
> @@ -1255,10 +1256,26 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  	*nr_cluster = (size + (sbi->cluster_size - 1)) >> sbi->cluster_bits;
>  	BUG_ON(*nr_cluster > 2);
>  
> -	err = fat_alloc_clusters(dir, cluster, *nr_cluster);
> +	err = fat_alloc_clusters(dir, &cluster[0], *nr_cluster);
>  	if (err)
>  		goto error;
>  
> +	if (*nr_cluster > 1) {
> +		fatent_init(&fatent);
> +		cluster[1] = fat_ent_read(dir, &fatent, cluster[0]);
> +		fatent_brelse(&fatent);
> +		if (cluster[1] == FAT_ENT_EOF || cluster[1] == FAT_ENT_FREE) {
> +			fat_fs_error(sb,
> +				     "%s: invalid cluster chain (i_pos %lld)",
> +				     __func__, MSDOS_I(dir)->i_pos);
> +			cluster[1] = -EIO;
> +		}
> +		if (cluster[1] < 0) {
> +			err = cluster[1];
> +			goto error_ent;
> +		}
> +	}
> +
>  	/*
>  	 * First stage: Fill the directory entry.  NOTE: This cluster
>  	 * is not referenced from any inode yet, so updates order is
> @@ -1313,6 +1330,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  error_nomem:
>  	for (i = 0; i < n; i++)
>  		bforget(bhs[i]);
> +error_ent:
>  	fat_free_clusters(dir, cluster[0]);
>  error:
>  	return err;
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 61338413d..75ac0239a 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -393,7 +393,7 @@ extern int fat_ent_read(struct inode *inode, struct fat_entry *fatent,
>  			int entry);
>  extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
>  			 int new, int wait);
> -extern int fat_alloc_clusters(struct inode *inode, int *cluster,
> +extern int fat_alloc_clusters(struct inode *inode, int *first_cluster,
>  			      int nr_cluster);
>  extern int fat_free_clusters(struct inode *inode, int cluster);
>  extern int fat_count_free_clusters(struct super_block *sb);
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index bfab8eab5..4970b1f14 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -488,14 +488,14 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
>  	return 0;
>  }
>  
> -int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
> +int fat_alloc_clusters(struct inode *inode, int *first_cluster, int nr_cluster)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>  	const struct fatent_operations *ops = sbi->fatent_ops;
>  	struct fat_entry fatent, prev_ent;
>  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
> -	int i, count, err, nr_bhs, idx_clus;
> +	int i, count, err, nr_bhs, clusters_done;
>  
>  	lock_fat(sbi);
>  	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
> @@ -504,7 +504,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  		return -ENOSPC;
>  	}
>  
> -	err = nr_bhs = idx_clus = 0;
> +	err = nr_bhs = clusters_done = 0;
>  	count = FAT_START_ENT;
>  	fatent_init(&prev_ent);
>  	fatent_init(&fatent);
> @@ -531,8 +531,9 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  				if (sbi->free_clusters != -1)
>  					sbi->free_clusters--;
>  
> -				cluster[idx_clus] = entry;
> -				idx_clus++;
> +				if (!clusters_done)
> +					*first_cluster = entry;
> +				clusters_done++;
>  
>  				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
>  					err = fat_flush_bhs(sb, bhs, &nr_bhs,
> @@ -542,7 +543,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  				}
>  				fat_collect_bhs(bhs, &nr_bhs, &fatent);
>  
> -				if (idx_clus == nr_cluster)
> +				if (clusters_done == nr_cluster)
>  					goto out;
>  
>  				/*
> @@ -575,8 +576,8 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>  	for (i = 0; i < nr_bhs; i++)
>  		brelse(bhs[i]);
>  
> -	if (err && idx_clus)
> -		fat_free_clusters(inode, cluster[0]);
> +	if (err && clusters_done)
> +		fat_free_clusters(inode, *first_cluster);
>  
>  	return err;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
