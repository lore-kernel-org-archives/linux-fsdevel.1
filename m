Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E829D294;
	Tue, 12 May 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567675; cv=none; b=F2yuFpMGhoMFfNyw/jy/1StnzE0LfiolI85Rk6fgpxLDzIU0cnHZhLJ7OVwD7HgKdTWE5v3ff34kJ0uaaNEbe8W7SzeL5PFQYhx54EyGteyJLIbqSALaD2nFZZgYXyHwwNn5K+IibkxFJkLQuO1KJz4+/jBGSxnkjJ1qL5j7yPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567675; c=relaxed/simple;
	bh=vAJ08LqnqcEI512wQOM8Hhpse5y9rT3R6tZoe3MyFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbejjEymwh+snlJQXtpDSBmYR+U3D3iqYY3ocX4LCIm1moMPOcHyYZ82BjkbFF13IMgpJ/mrT4ecaDVJnIDo9NPzgeTYFMhlPn+yGxv22ySwXKUNS/4CjwQeR53Lj3XmczWt5XX176mRLOwlX7iW44LTbtagOH3kPtudMja0Znw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D0826732A; Tue, 12 May 2026 08:34:17 +0200 (CEST)
Date: Tue, 12 May 2026 08:34:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] exfat: add iomap buffered I/O support
Message-ID: <20260512063416.GA30619@lst.de>
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-8-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507124238.7313-8-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 415f987afa9a..448857d4b70f 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -12,6 +12,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
>  #include <uapi/linux/exfat.h>
> +#include <linux/buffer_head.h>

This looks like a bug-fix for adding exfat_cluster_walk a while ago
and not really related to this patch.

>  static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
>  {
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	loff_t old_valid_size;
> +	int ret = 0;
>  
> +	mutex_lock(&sbi->s_lock);
> +	old_valid_size = ei->valid_size;
> +	mutex_unlock(&sbi->s_lock);
>  
> +	if (old_valid_size < new_valid_size) {

The old_valid_size value can be stale as soon the lock is dropped.
So the lock here is not useful, but unless something else protectes
the value the code might be racy.  Also why does this use a sb-wide
lock for a per-inode value?

> +	if (may_alloc)
> +		num_clusters = exfat_bytes_to_cluster_round_up(sbi,
> +				offset + length) - exfat_bytes_to_cluster(sbi, offset);
> +	else
> +		num_clusters = exfat_bytes_to_cluster_round_up(sbi, length);

Why is the num_clusters calculation different for the read vs write case
here?  Also shouldn't the may_alloc case also update length given that
it is used later?

> +	if (length > cluster_length - cluster_offset)
> +		iomap->length = cluster_length - cluster_offset;
> +	else
> +		iomap->length = length;

use min or min_t here?

> +	iomap->addr = exfat_cluster_to_phys(sbi, cluster) + cluster_offset;
> +	iomap->type = IOMAP_MAPPED;
> +	if (may_alloc) {
> +		if (balloc)
> +			iomap->flags = IOMAP_F_NEW;
> +		else if (iomap->offset + iomap->length >= ei->valid_size)
> +			iomap->flags = IOMAP_F_ZERO_TAIL;
> +	} else {
> +		if (offset >= ei->valid_size)
> +			iomap->type = IOMAP_UNWRITTEN;

This might be a good place to explain the valid_size scheme and
how it affects the iomap reported types/flags.

> +/*
> + * exfat_write_iomap_end - Update the state after write
> + *
> + * Extends ->valid_size to cover the newly written range.
> + * Marks the inode dirty if metadata was changed.
> + */
> +static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> +		ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +	if (written) {

Return early on !written to reduce indentation a bit?

> +/**
> + * exfat_iomap_read_end_io - iomap read bio completion handler for exFAT
> + * @bio: bio that has completed reading
> + *
> + * exfat_iomap_begin() rounds up MAPPED extents to the block boundary of
> + * valid_size. This ensures that any subsequent blocks are treated as
> + * IOMAP_UNWRITTEN, but it also causes the "straddle block" containing
> + * valid_size to be read from disk. The disk data beyond valid_size in
> + * this block is stale and must be zeroed to prevent data leakage.

We've seen this in ntfs already.  It also seems like a generally
useful thing to do.  I wonder if we should just unconditionally
zero non-fsverity data beyond i_size or have a flag for this
(although that might be hard to communicate).  But let's revisit that
after the initial merge as there are too many different series in flight
in this area right now.

