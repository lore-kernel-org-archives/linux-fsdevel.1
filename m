Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000244;
	b=JScCRfmlsldaxmR3zWAcwiZia6shRzXv01W9QY9NZtfVcZ1C2Zn1NRaTRNTEnAqrikKM
	 FqHV3SXpbEQHwlqYwYIZbEeWXIdJxZaIOd5mWkTfs3baMurqJFzHC/jRmQ0d4uKDClPz3
	 Yi2/KTlSQ5vmABx2wMKGnm5t6Wk37hTIIFZK1naBUL9S3mPHMj8Why097YkEvZW0B+12b
	 09Egj/b729grbtVckvyNxjSqGQVCbQlzTNxrhZkrgtw0FZ4HvGDiPu0LYQ/sJiHlSD5sE
	 aU95WBPbg7nkXXO03GAQDdSbIatuPIqqZKCSpXYX8GiWkWQktGSmFHSiR0dhh55PVDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000244;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2vp3QjJ817iw+uy+pcrWq/RDVWdRNpTEg9ybL2+diMQ=;
	b=su1btq3Wyx+hHcGsBn2grUHpgdK9IOA343moc4mbQuJGtqk6d5UB54z6/0rIe3YDVlF5
	 OG6tejVA4b+zm9ljKVPA8RtKy6vJ8HDf7EoVcUIAv7XI1ovPJ3VgIiDyvSdRGmO50cIoo
	 ozXfosY4oOZTnynIXY4g1IWihjLZ1HteFjilXqz+rhUf7jK/FH/cKBwV3Tf6JasDrVdyB
	 wf9nOy8Pi56UCQyvXt9+W83gBxvgfRyODOPVimyLuDOLJdRLoixqFEdXxtOWva7Q3Lgx2
	 DpLOoP3gUQFET4Ly3oJsT8ozbSN/pkYpKJhSxFw4g1sc7YvV2McI9lnm6klgw39ITgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=tcpGJ6HM;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=NJG1i8Px;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0730606A31E;
	Mon, 26 Oct 2026 07:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0730606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=tcpGJ6HM;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=NJG1i8Px
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4F44426F7658;
	Mon, 26 Oct 2026 16:37:13 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793000233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vp3QjJ817iw+uy+pcrWq/RDVWdRNpTEg9ybL2+diMQ=;
	b=tcpGJ6HMXlfIONcreIbHlyJFH5AsaoMz+8VE0snqTbIhrEakFRC7ts1VvQBNSa8PjqPA+9
	mVDLlbb2/1esUdIvvk+X7WYhRiU74HMKlDFzXoCBxaX75j4QRYC8mOS7a7StSqJZ2XS97l
	bN0bS8AlTdRZN3z4b5GVqJzdaIfLPZE5+GD/8irrNfcISYUBZI6GJ8123nnZYxoLjNv+6m
	zjq77ZvGS1IrJDYOi93yF05wfX4MCgX64VvoI2kvxUTWYBQq0l8/p25et9Cb8w45bNdIWo
	jMU0HLo0ptObmtp6HIDv4ZMj6l9uIZY0kjlNrUAo5eJJt/neBpeBPLEZe2NUXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793000233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vp3QjJ817iw+uy+pcrWq/RDVWdRNpTEg9ybL2+diMQ=;
	b=NJG1i8PxSDqk+iaOWqE1F/2WQENTpl4yyUDuMM/eiX+0Ua1TxhMuwmPMJNo8+IjkKfndI0
	7bp70YMMYKRhOoDg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id C5802E00171;
	Mon, 26 Oct 2026 16:37:12 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B8565220019C; Mon, 26 Oct 2026 16:37:12 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fat: batch synchronous mirror writes
In-Reply-To: <20261025191006.407209-2-matheus.aalmeida@inf.ufrgs.br>
References: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
	<20261025191006.407209-2-matheus.aalmeida@inf.ufrgs.br>
Date: Mon, 26 Oct 2026 16:37:12 +0900
Message-ID: <87ecdchpzr.fsf@mail.parknet.co.jp>
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
> ---
>  fs/fat/fat.h    |  1 +
>  fs/fat/fatent.c | 81 +++++++++++++++++++++++++++++++++++--------------
>  fs/fat/misc.c   |  6 ++++
>  3 files changed, 65 insertions(+), 23 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index b18385461de8..5086c35230ac 100644
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
> index 8897a5dd522d..4fa1fae5abf9 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -376,39 +376,74 @@ int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
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
> +	int err, err2, n, nr_dirty;
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
> +		err2 = fat_sync_bhs(dirty, nr_dirty);

		int err2 = fat_sync_bhs(dirty, nr_dirty);

I'd like to see err2 as local.

> +		if (!err)
> +			err = err2;
> +		fat_brelse_array(dirty, nr_dirty);
> +	}
> +
> +	return err;
> +}
> +
> +static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> +			  int nr_bhs)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	int err, copy;
> +
> +	err = 0;
> +	for (copy = 1; copy < sbi->fats; copy++) {
> +		err = fat_mirror_one(sb, bhs, nr_bhs, copy);
> +		if (err)
> +			break;
> +	}
> +
>  	return err;

		int err = fat_mirror_one(sb, bhs, nr_bhs, copy);
		if (err)
			return err;
	}

	return 0;

very minor (either is ok actually)

>  }
>  
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index e79762cf1975..f8f89b947baf 100644
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

I'd like this is noop if n == 0, possibly easier to use and safer in future.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
