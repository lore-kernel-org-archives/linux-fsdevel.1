Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814181AA8;
	Sun, 10 May 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420010; cv=none; b=etY3HaaiZxo+HVUrM+zZMJtDDJkLDS6FmiS+fvor1DV5BZCP5H1EJs66PKCxwl1X5kQaeXX/UYTsTP7U1xt61zqsYdZFdyHKuxE6+F6Rgc1+1vxYG+9jgBeBsc7QGURgFxKkOzbUp7BDs8iybzb/uAcNNKBsbahHIPRTE9CFNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420010; c=relaxed/simple;
	bh=3Aoz4EcBiMUV6gEW+Nj/pXRil3RMqSm/oYbST37H3bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiIsCG7n2nP8Bswqal7ebQlISZ67BU3fW9u+FM6Fl69Dp5KYu7lFdW9PMCJGtklVYd/A+Tq6WZq+T/X+/p7WuSA4UTlaVjLen+nF2/xqA2EV5v9VQRluZCJEA6IriA+x4HYJSnn/MehnrX/d2kXY7X0WE8uba+6M6ss92T98t58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yawl5X19; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yawl5X19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hfiG0izlaooaJ+r1+WYjSf08/f/5tdF3g2n1Z6Agr9k=;
	b=Yawl5X19GxSMRbNoY04s38SHoVbP6wBy3jxT9Or+aabu9mXkMIyzFc1/NXLKCe
	fFn1i0RM0Dvv5dZw/s8sL3pfUxKTon3OwmrXgRXc8gs6WS7SxOexb/PnqWzj5wMM
	FYpNIH+cF1CAHXhNeWbyg/Er+7/JfWpfdRlRjgMjXKdxM=
Received: from [192.168.5.141] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD335DuiABqQKBJAg--.2554S2;
	Sun, 10 May 2026 21:32:31 +0800 (CST)
Message-ID: <ef3f055d-1d3e-4467-a835-37c52585fcad@163.com>
Date: Sun, 10 May 2026 21:32:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] exfat: add support for multi-cluster allocation
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me,
 chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
References: <20260507124238.7313-1-linkinjeon@kernel.org>
 <20260507124238.7313-5-linkinjeon@kernel.org>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20260507124238.7313-5-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD335DuiABqQKBJAg--.2554S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKry7Aw1DAFy3tw4fuFW3ZFb_yoWxGFyDpr
	47Ka15JrZ5Xa4kur1Fqr4DXa4F9w18GFyUCay7Ar1jqF9FvrnY9F1Dtry3ZF1kCa18WF4j
	qFyY9r18uwsxGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5b1nUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+A-3lWoAiO+u7wAA3Z

On 5/7/26 8:42 PM, Namjae Jeon wrote:
> Currently exfat_map_cluster() allocates and returns only one cluster
> at a time even when more clusters are needed. This causes multiple
> FAT walks and repeated allocation calls during large sequential writes
> or when using iomap for writes. This change exfat_map_cluster() and
> exfat_alloc_cluster() to be able to allocate multiple contiguous
> clusters.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>   fs/exfat/dir.c      |  2 +-
>   fs/exfat/exfat_fs.h |  2 +-
>   fs/exfat/fatent.c   | 26 ++++++++++++++++----------
>   fs/exfat/file.c     |  2 +-
>   fs/exfat/inode.c    | 23 ++++++-----------------
>   fs/exfat/namei.c    |  2 +-
>   6 files changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index ca9d707220df..37f324399b6b 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -295,7 +295,7 @@ int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
>   
>   	exfat_chain_set(clu, EXFAT_EOF_CLUSTER, 0, ALLOC_NO_FAT_CHAIN);
>   
> -	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode));
> +	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode), false);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 9c8ab3df7a42..6e7fd6822b01 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -497,7 +497,7 @@ int exfat_clear_volume_dirty(struct super_block *sb);
>   	exfat_cluster_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)
>   
>   int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
> -		struct exfat_chain *p_chain, bool sync_bmap);
> +		struct exfat_chain *p_chain, bool sync_bmap, bool contig);
>   int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
>   int exfat_ent_get(struct super_block *sb, unsigned int loc,
>   		unsigned int *content, struct buffer_head **last);
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index 45b0b754a2e4..a917c954bd23 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -419,7 +419,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
>   }
>   
>   int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
> -		struct exfat_chain *p_chain, bool sync_bmap)
> +		struct exfat_chain *p_chain, bool sync_bmap, bool contig)
>   {
>   	int ret = -ENOSPC;
>   	unsigned int total_cnt;
> @@ -470,14 +470,20 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
>   
>   	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
>   	       EXFAT_EOF_CLUSTER) {
> -		if (new_clu != hint_clu &&
> -		    p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> -			if (exfat_chain_cont_cluster(sb, p_chain->dir,
> -					p_chain->size)) {
> -				ret = -EIO;
> -				goto free_cluster;
> +		if (new_clu != hint_clu) {
> +			if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +				if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +							     p_chain->size)) {
> +					ret = -EIO;
> +					goto free_cluster;
> +				}
> +				p_chain->flags = ALLOC_FAT_CHAIN;
> +			}
> +
> +			if (contig && p_chain->size > 0) {
> +				hint_clu--;
> +				goto done;
>   			}
> -			p_chain->flags = ALLOC_FAT_CHAIN;
>   		}
>   
>   		/* update allocation bitmap */
> @@ -507,9 +513,9 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
>   		last_clu = new_clu;
>   
>   		if (p_chain->size == num_alloc) {
> +done:
>   			sbi->clu_srch_ptr = hint_clu;
> -			sbi->used_clusters += num_alloc;
> -
> +			sbi->used_clusters += p_chain->size;
>   			mutex_unlock(&sbi->bitmap_lock);
>   			return 0;
>   		}
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index b7a4964631a0..15b9d6a1766a 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -56,7 +56,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
>   	clu.flags = ei->flags;
>   
>   	ret = exfat_alloc_cluster(inode, new_num_clusters - num_clusters,
> -			&clu, inode_needs_sync(inode));
> +			&clu, inode_needs_sync(inode), false);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 1246713567a5..7b09d94ac464 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -137,9 +137,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>   	unsigned int num_to_be_allocated = 0, num_clusters;
>   
>   	num_clusters = exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
> -
> -	if (clu_offset >= num_clusters)
> -		num_to_be_allocated = clu_offset - num_clusters + 1;
> +	if (clu_offset > num_clusters ||
> +	    *count > num_clusters - clu_offset)
> +		num_to_be_allocated = clu_offset + *count - num_clusters;

We need to truncate *count for read operations so that it does not 
extend beyond EOF. Otherwise, xfstests generic/003 will fail.


thanks,

>   
>   	if (!create && (num_to_be_allocated > 0)) {
>   		*clu = EXFAT_EOF_CLUSTER;
> @@ -182,7 +182,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>   		}
>   
>   		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu,
> -				inode_needs_sync(inode));
> +				inode_needs_sync(inode), true);
>   		if (ret)
>   			return ret;
>   
> @@ -216,20 +216,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>   		}
>   
>   		*clu = new_clu.dir;
> +		*count = new_clu.size;
>   
> -		inode->i_blocks +=
> -			exfat_cluster_to_sectors(sbi, num_to_be_allocated) >> 9;
> -
> -		/*
> -		 * Move *clu pointer along FAT chains (hole care) because the
> -		 * caller of this function expect *clu to be the last cluster.
> -		 * This only works when num_to_be_allocated >= 2,
> -		 * *clu = (the first cluster of the allocated chain) =>
> -		 * (the last cluster of ...)
> -		 */
> -		if (exfat_cluster_walk(sb, clu, num_to_be_allocated - 1, ei->flags))
> -			return -EIO;
> -		*count = 1;
> +		inode->i_blocks += exfat_cluster_to_sectors(sbi, new_clu.size);
>   		if (balloc)
>   			*balloc = true;
>   	}
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 752fbec9316b..87e55c5c1bf4 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -341,7 +341,7 @@ int exfat_find_empty_entry(struct inode *inode,
>   		}
>   
>   		/* allocate a cluster */
> -		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
> +		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode), false);
>   		if (ret)
>   			return ret;
>   

