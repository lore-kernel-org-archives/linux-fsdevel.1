Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149852;
	b=k2Wxzla0VGkICGja64y9MyKeUEkTv3AS8RTb2Ze8Foy4FAXpP2eh7TR0mag7IfpW057H
	 4GdvHGQCiaJWTyY4sZYJ0OQreFTe0q6eRY+cmz1FmC2Tpz0T0W6ekWW7muirsPN7wnigZ
	 3XdlokfbbPvQH4mC4OpScpOkT0lfvJLaapm07hPqOtu/qvoPP7ofRMIEnWRDzH2vmabTz
	 bQwDdoZEco3ist0vJg6gqLZvKX7hiixnKyuhV3RlX3bhYRYX7AAhULaFGaz8X90eiHdlx
	 B21WEHUwDyX1jUnc7XyVNn7pIL4N73m3cTrrckrz3THx747mbaKMXTrN7mSmpPdSvSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149852;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Kg+kY0M0GUuWe1c3Qkf2Hd3ul7ZQ/jQ+AqmLEzh9dIs=;
	b=fq3kJTpIaw3C+UphO45Auvh35SyNLzF+Ma1Riil5qqQ9dhfM9SlZnd5Ub9/zY3zWLyVX
	 9qlsjsLx+5p3PLstj3hgyaD/jJvcLZQA4qKksVHdYVzfBvscblAkKjbep4ievDwUpaUDj
	 lDGqgG8fpnoVXrxMtVBxI0/Lw/fgXDTkVSuHSLOdYszCSBwhnMglzxkNkTbqoTV/obz+8
	 zmxk+KFOECEzHzHdOvXOYWmljlA65Ii+lhNGHevDpe8JED6ozsGlXjUjCP9nEVh1d9tUz
	 KwKEIDXBpae/Quv1OXD/uxIT0X1WG2Oud3BJYfqfxKmhjYTvI0OeSlD9a8/MMKxachA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=TNDg+wAG;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=f2UJcdGF;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C3606A31C;
	Sun,  8 Nov 2026 14:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=TNDg+wAG;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=f2UJcdGF
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 387A820BD288;
	Sun,  8 Nov 2026 23:57:30 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794149850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg+kY0M0GUuWe1c3Qkf2Hd3ul7ZQ/jQ+AqmLEzh9dIs=;
	b=TNDg+wAG0wFAU3my1SVqzL/a54JpDjrJlX9U8fLaDLImpqPF5wUh4l6wUoSbGUKPeeqkq0
	3o9krHwUw/PBNB/DHwtMWzi83zCgysRz9XprVh4U9MxbKWqvxVz3xPDTgWo7TV4GbBvVfB
	PTxKTNl+wPZLF1uqFWzJdpQz48IHKXPLgUWuQjr3m0P5sDo3QUtswR5S7mKZTnfwjwyhsp
	1b//2X8W32yRnDrPf3pgyTUktAJ5cWko1eHOq4Jq3o2fpOMg6dNxo5U0yO5xMrKGZzjDE8
	RGW/Ii0WjFz8/ILE4Fqdn4zrCgiB/rAquTQlcqKlSoJQoPoAlT08hJKd26QcwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794149850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg+kY0M0GUuWe1c3Qkf2Hd3ul7ZQ/jQ+AqmLEzh9dIs=;
	b=f2UJcdGFalZYDf0A+RhFbfFbNQqjlJc/WzmiTMXXk3vE2pHmMOjHMrUFFKhkPEHWapzflJ
	BOE52fIMNZXQkrDQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B0DADE00042;
	Sun, 08 Nov 2026 23:57:29 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A470822001DF; Sun, 08 Nov 2026 23:57:29 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] fat: clean stale bdev buffers of newly
 allocated clusters
In-Reply-To: <20261031164326.278125-5-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-5-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 08 Nov 2026 23:57:29 +0900
Message-ID: <87ik27tlpi.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Directory I/O uses buffer_heads on the block device, which may leave
> stale buffers behind when clusters are freed and reused. The buffer_head
> I/O paths currently call clean_bdev_aliases() for newly allocated blocks,
> preventing stale buffers from overwriting new data.
>
> Buffered iomap I/O does not provide this protection. In preparation for
> the buffered iomap conversion, clean bdev aliases on newly allocated
> clusters, like exfat patch "exfat: clean stale bdev buffers of newly
> allocated clusters".
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/fatent.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index 4fa1fae5abf9..46899efa3cf8 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -523,6 +523,21 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
>  	return 0;
>  }
>  
> +/*
> + * Newly allocated clusters may still have dirty buffer_heads in the block
> + * device mapping, e.g. the dentries of a directory that was just removed.
> + * File data does not go through those buffers, so drop them; otherwise a
> + * later flush of the block device writes them over the new data.
> + */
> +static void fat_clean_bdev_aliases(struct super_block *sb,
> +				   unsigned int clu, unsigned int count)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +
> +	clean_bdev_aliases(sb->s_bdev, fat_clus_to_blknr(sbi, clu),
> +			   (sector_t)count * sbi->sec_per_clus);
> +}
> +
>  static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
>  				bool return_all)
>  {
> @@ -531,7 +546,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>  	const struct fatent_operations *ops = sbi->fatent_ops;
>  	struct fat_entry fatent, prev_ent;
>  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
> -	int i, count, err, nr_bhs, idx_clus;
> +	int i, count, err, nr_bhs, idx_clus, cont_start, cont_len;
>  
>  	lock_fat(sbi);
>  	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
> @@ -540,14 +555,20 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>  		return -ENOSPC;
>  	}
>  
> +	cont_len = 0;
>  	err = nr_bhs = idx_clus = 0;
>  	count = FAT_START_ENT;
>  	fatent_init(&prev_ent);
>  	fatent_init(&fatent);
>  	fatent_set_entry(&fatent, sbi->prev_free + 1);
>  	while (count < sbi->max_cluster) {
> -		if (fatent.entry >= sbi->max_cluster)
> +		if (fatent.entry >= sbi->max_cluster) {
> +			if (cont_len) {
> +				fat_clean_bdev_aliases(sb, cont_start, cont_len);
> +				cont_len = 0;
> +			}
>  			fatent.entry = FAT_START_ENT;
> +		}
>  		fatent_set_entry(&fatent, fatent.entry);
>  		err = fat_ent_read_block(sb, &fatent);
>  		if (err)
> @@ -573,6 +594,10 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>  					*cluster = entry;
>  				idx_clus++;
>  
> +				if (cont_len == 0)
> +					cont_start = entry;
> +				cont_len++;
> +
>  				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
>  					err = fat_flush_bhs(sb, bhs, &nr_bhs,
>  							    inode_needs_sync(inode));
> @@ -589,6 +614,9 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>  				 * so we can still use the prev_ent.
>  				 */
>  				prev_ent = fatent;
> +			} else if (cont_len) {
> +				fat_clean_bdev_aliases(sb, cont_start, cont_len);
> +				cont_len = 0;
>  			}
>  			count++;
>  			if (count == sbi->max_cluster)
> @@ -602,6 +630,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>  	err = -ENOSPC;
>  
>  out:
> +	if (cont_len)
> +		fat_clean_bdev_aliases(sb, cont_start, cont_len);

We would want to make as possible as shorter lock_fat. At least, this
part can move outside of unlock_fat(sbi)?

>  	unlock_fat(sbi);
>  	mark_fsinfo_dirty(sb);
>  	fatent_brelse(&fatent);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
