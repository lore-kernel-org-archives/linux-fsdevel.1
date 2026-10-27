Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072098;
	b=D4IETVqVp937qJPimvwEiOSYRd226JIQLLiLOeLSXy1HfwEYTcIefHzl+DG50tEIqCpZ
	 oCJsfnAOvYKQKSQP//dNwJZIqmc2tSIWUbQzx5cwsi2UAjmYau1U3voqW9f0O5FnJIhqV
	 ZbP1WY5whi8N9LhAcr/6jrQdz/lcoiEj3Lux2hZ4SEDMbCSSv4MFGEpuQQtpanF69ae5G
	 Fl0c3z2ivmiOcPl46cGdS76PGBGtbzHChXr85aYrHg0vKwXaHqfQ2IPgxfRf4P0lJqsZF
	 trdbDG07kzbFKkFHGysc/0UriTgofhBgKtaxw+Wllkx4GTCNq43UCwfmoMAAY6V+DbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072098;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uk6QGReRjiDayl1Cde/fxKH/7CwjPQ3056Z1gN3yMAE=;
	b=aJeyC9xlyk62u+kmLT8QXYNrWzigFzohnIjm+UezS4e6Ns1STKmN+dSrgti4u5eFM2NI
	 Y0JlihazLo+CIWdhO2cF8JnEu7ePIdbQcN3Yl/4WqUyzyScwoPK44t1bv+e3Lf6bk7pnW
	 Na9bgSz6vdJ42VIisQIHO04N8l96mQJjbDioiTEGJ+qHzsRQ4jy7qCuVPzQRw7eERDrmx
	 I/KyaNY4thFV6dfOf+dGWtVM9wLjVmueBLtn+YNMp0HHTqXvAnXHkyX4UhnUfuVP6YPzD
	 RU1D2I2ggiBy7JbPY1jndYAOH21KivDSgsgZ786BNfMYcPM3k2DQ09RpZVy81YrbMdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=I0AHn3mB;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=EMaXzrWZ;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70369606A31A;
	Tue, 27 Oct 2026 03:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70369606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=I0AHn3mB;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=EMaXzrWZ
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 46F4B26F768E;
	Tue, 27 Oct 2026 12:34:54 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793072094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uk6QGReRjiDayl1Cde/fxKH/7CwjPQ3056Z1gN3yMAE=;
	b=I0AHn3mBUQoGJ7iv2kxiNScGdMfYBaNQweuha9lNs8sN2ZLx/LXCzgAoqjcSvsnvd/fmqf
	V6QZfD5qSMLPHRuXgEqYYsRJe1KrJCq8ExTEC0k0Z7Qk1lDKRLGhLhPydyZ4HMvtKiblFl
	MSEg94RkL2XqkDHTz315DTPv0PpMekwT48Kho6Urclq7Zs0AQXc9xB9IM4Oj8QFFtzFjZA
	vQ2dKPOyaoNfEZakzkLJ9VjLZtI3nkdwhIaaYsabs0BfBErJq3X7NSayA/6StuLLeRv26q
	p8vmnfD+M1mjpipQ8gBv/l31AOpUMONIvAuLMTjWuzPc31h6lcuoFFt23vW1Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793072094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uk6QGReRjiDayl1Cde/fxKH/7CwjPQ3056Z1gN3yMAE=;
	b=EMaXzrWZGrykXpYhFCg9oxurijypd+Dy6UheMkOUN+SejYd2FtK8/Zh+sxxqga+xY0/YzQ
	ov7SCV75EZxRUbAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id BF2D6E004F7;
	Tue, 27 Oct 2026 12:34:53 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A939E22001D3; Tue, 27 Oct 2026 12:34:53 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fat: batch synchronous mirror writes
In-Reply-To: <20261026163941.495833-2-matheus.aalmeida@inf.ufrgs.br>
References: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
	<20261026163941.495833-2-matheus.aalmeida@inf.ufrgs.br>
Date: Tue, 27 Oct 2026 12:34:53 +0900
Message-ID: <874ie7ddeq.fsf@mail.parknet.co.jp>
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

> fat_mirror_bhs() currently synchronizes buffer-by-buffer on synchronous
> mounts, serializing I/O and degrading performance.
>
> Make fat_mirror_bhs() batch dirty buffer heads and use fat_sync_bhs()
> to sync several at once. Add a fat_brelse_array() helper that releases
> buffer heads in an array.
>
> Benchmarking was done under QEMU/KVM with a virtio-blk device using
> cache=directsync. Each result is the arithmetic mean of 10 samples.
>
> start = now_ns();
> for (unsigned i = 0; i < count; i++) {
> 	fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
> }
> elapsed = now_ns() - start;
>
> Sync-mounted FAT32 using count=16 files:
> File size    Cluster size    Before    After    Improvement
> 256MiB       512B            49.81s    12.26s   4.06x
> 1MiB         512B            0.198s    0.057s   3.50x
> 256MiB       4096B           7.060s    1.640s   4.31x
> 1MiB         4096B           0.073s    0.028s   2.60x
>
> Asynchronous mounts were also benchmarked with no noticeable performance
> change.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/fat.h    |  1 +
>  fs/fat/fatent.c | 80 +++++++++++++++++++++++++++++++++++--------------
>  fs/fat/misc.c   |  6 ++++
>  3 files changed, 64 insertions(+), 23 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 1d051d0628b6..204c7b87108f 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -479,6 +479,7 @@ void fat_truncate_time(struct inode *inode, struct timespec64 *now,
>  int fat_update_time(struct inode *inode, enum fs_update_time type,
>  		unsigned int flags);
>  extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
> +void fat_brelse_array(struct buffer_head *bhs[], int n);
>  
>  int fat_cache_init(void);
>  void fat_cache_destroy(void);
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index 8897a5dd522d..d42b5324531a 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -376,42 +376,76 @@ int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
>  	return ops->ent_get(fatent);
>  }
>  
> -/* FIXME: We can write the blocks as more big chunk. */
> -static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> -			  int nr_bhs)
> +static int fat_mirror_one(struct super_block *sb, struct buffer_head **bhs,
> +			  int nr_bhs, int target)
>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	sector_t backup_fat = sbi->fat_length * target;
> +	/*
> +	 * Use the value of MAX_BUF_PER_PAGE for 4K pages. This reduces stack
> +	 * usage on large-page architectures as callers may already have a
> +	 * MAX_BUF_PER_PAGE-sized array in their stack.
> +	 */
> +	struct buffer_head *dirty[8];
>  	struct buffer_head *c_bh;
> -	int err, n, copy;
> +	int err, n, nr_dirty;
>  
> +	nr_dirty = 0;
>  	err = 0;
> -	for (copy = 1; copy < sbi->fats; copy++) {
> -		sector_t backup_fat = sbi->fat_length * copy;
> -
> -		for (n = 0; n < nr_bhs; n++) {
> -			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> -			if (!c_bh) {
> -				err = -ENOMEM;
> -				goto error;
> +	for (n = 0; n < nr_bhs; n++) {
> +		c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> +		if (!c_bh) {
> +			err = -ENOMEM;
> +			goto error;
> +		}
> +		/* Avoid race with userspace read via bdev */
> +		lock_buffer(c_bh);
> +		memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> +		set_buffer_uptodate(c_bh);
> +		unlock_buffer(c_bh);
> +		mmb_mark_buffer_dirty(c_bh,
> +			&MSDOS_I(sbi->fat_inode)->i_metadata_bhs);
> +		if (sb->s_flags & SB_SYNCHRONOUS) {
> +			dirty[nr_dirty] = c_bh;
> +			++nr_dirty;
> +			if (nr_dirty == ARRAY_SIZE(dirty)) {
> +				err = fat_sync_bhs(dirty, nr_dirty);
> +				fat_brelse_array(dirty, nr_dirty);
> +				nr_dirty = 0;
> +				if (err)
> +					goto error;
>  			}
> -			/* Avoid race with userspace read via bdev */
> -			lock_buffer(c_bh);
> -			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> -			set_buffer_uptodate(c_bh);
> -			unlock_buffer(c_bh);
> -			mmb_mark_buffer_dirty(c_bh,
> -				&MSDOS_I(sbi->fat_inode)->i_metadata_bhs);
> -			if (sb->s_flags & SB_SYNCHRONOUS)
> -				err = sync_dirty_buffer(c_bh);
> +		} else {
>  			brelse(c_bh);
> -			if (err)
> -				goto error;
>  		}
>  	}
> +
>  error:
> +	if (nr_dirty) {
> +		int err2 = fat_sync_bhs(dirty, nr_dirty);
> +		if (!err)
> +			err = err2;
> +		fat_brelse_array(dirty, nr_dirty);
> +	}
> +
>  	return err;
>  }
>  
> +static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> +			  int nr_bhs)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	int copy;
> +
> +	for (copy = 1; copy < sbi->fats; copy++) {
> +		int err = fat_mirror_one(sb, bhs, nr_bhs, copy);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
>  		  int new, int wait)
>  {
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 0d04228f916e..b6a9e2e122cd 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -365,3 +365,9 @@ int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
>  	}
>  	return err;
>  }
> +
> +void fat_brelse_array(struct buffer_head *bhs[], int n)
> +{
> +	while (--n >= 0)
> +		brelse(bhs[n]);
> +}

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
