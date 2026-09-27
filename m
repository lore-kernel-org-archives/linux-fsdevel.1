Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D533BBD7;
	Sun, 27 Sep 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521377; cv=none; b=hs96YQq7QEfRH8Bp3VrwawRvk292B1WKP0FBqdfCR4ycRqnQ4rCqg0nn3bs9z/Jpsuv+XCPZH2DiGUCJrTWghxIB/xfwI0NMqtAIY9jkAPoXJDKfCGp7BzvC1zz6nOA5PzyVEX34TZtSIgxNZPylHmtV4AZFBqaEU50TIaeA1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521377; c=relaxed/simple;
	bh=PppzuyuNGK/qAAPWZ9KIftvn7u0zaNnD+n0UTuk6xKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPYE3SxoDAdzmY/iGpbSdFAd5Iq98irzoIMWMar9Dta/bQdodfxsWPyD06gOkAcT6aP+edayiQ3Mu/26ZMV+8Rq3d6nLSv6p4+RGcdWI/Bt2VpWNhnoxObNNUfZn2g8gL39qGAwcX1cTnuLHT9nWJkpRHu3fxVV815DPO/FnWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0PQupfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0PQupfY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7C4071F000FF;
	Sun, 27 Sep 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521374;
	bh=e/AsFYq3szCHk8UVMvL0kaKqjKNqfq7QCKLc+kTueJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h0PQupfYaz5spUdIQIUcydEvh8K1bZKZCjLB74FKZnLlchhzOSpsNGTCF50tM6qwe
	 ld0ZLca+c8C5amYFZWOjJvz+X9odBhkTUnivBHVXHqu5hUd0abSYWTWQh6Fw6+Ewua
	 6y/WAlSjmjiKLS1voAEBqTJnKfToCGnTSC8SXaZwEaZ+jqUmxsWwQW+A3ue+VY5rHa
	 WxolOVe/1IHuNMLU94nZ6A6r2wTjtBCXOiwsChjPoytBfX+XuZmEi+oWHBaWyYfCFd
	 3i6yvwdbnybpsA1BezycMP34LSpfLVGjtGcV5ytgSwFnXunMtabtCNEgkojR9KiRdx
	 aSBW8BvLdBjQQ==
Date: Sun, 27 Sep 2026 08:02:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	hch@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	ansgar.loesser@kom.tu-darmstadt.de
Subject: Re: [PATCH v5 2/2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag
 to FIDEDUPERANGE
Message-ID: <20260927150254.GF6244@frogsfrogsfrogs>
References: <20260926043836.3301898-1-matthias.goergens@gmail.com>
 <20260926043836.3301898-3-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926043836.3301898-3-matthias.goergens@gmail.com>

On Sat, Sep 26, 2026 at 12:38:36PM +0800, Matthias Goergens wrote:
> Deduplication tools such as duperemove, bees and rmlint advance their
> file offsets by the bytes_deduped the kernel returns for each
> FIDEDUPERANGE call.
> 
> vfs_dedupe_file_range() passes REMAP_FILE_CAN_SHORTEN, so
> generic_remap_checks() may round the length down to a block multiple,
> but the ioctl still reports the requested length in bytes_deduped. The
> caller cannot tell that the tail of its request was left alone: rmlint
> 2.10.3 on btrfs (4 KiB blocks) deduping a 100000-byte file against a
> 250000-byte file with the same prefix is told bytes_deduped=100000
> with status SAME while only 98304 bytes were actually shared; its loop
> ends and it reports the pair fully deduplicated. duperemove and bees
> advance the same way, and jdupes advances by its own requested length
> without reading the field; all of them skip such a tail.
> 
> Add FILE_DEDUPE_RANGE_REPORT_PROGRESS for file_dedupe_range.flags:
> with it, bytes_deduped is the length the filesystem actually
> deduplicated when status is FILE_DEDUPE_RANGE_SAME, and 0 on
> FILE_DEDUPE_RANGE_DIFFERS or error. Callers advance by it as today,
> but must treat 0 as "stop or subdivide", not retry unchanged. One
> cause of SAME with 0 is a sub-block request that does not end at both
> files' EOF, which the generic range preparation shortens to nothing.
> On DIFFERS there is no sound progress or mismatch offset to report, so
> 0 leaves subdividing to the caller, as rmlint already does.
> 
> The default cannot change: commit 4a57a8400075 ("vf/remap: return the
> amount of bytes actually deduplicated") did exactly that and was
> reverted the next day; among deployed callers, duperemove re-queues a
> request while its status is 0 and would re-issue the same sub-block
> request forever.
> 
> Without the flag nothing changes.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matthias.goergens@gmail.com/
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  fs/remap_range.c        |  4 +++-
>  include/uapi/linux/fs.h | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 26afbbbfb10c..63f1b6f90c16 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -503,7 +503,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  	if (!(file->f_mode & FMODE_READ))
>  		return -EINVAL;
>  
> -	if (same->reserved1 || same->reserved2)
> +	if (same->reserved1 || (same->flags & ~FILE_DEDUPE_RANGE_REPORT_PROGRESS))
>  		return -EINVAL;
>  
>  	off = same->src_offset;
> @@ -555,6 +555,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  			info->status = FILE_DEDUPE_RANGE_DIFFERS;
>  		else if (deduped < 0)
>  			info->status = deduped;
> +		else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
> +			info->bytes_deduped = deduped;

Very good!  I'm glad this is resolved now.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		else
>  			info->bytes_deduped = len;
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 34c6f219462a..c61bc98909cc 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -178,13 +178,22 @@ struct file_dedupe_range_info {
>  	__u32 reserved;		/* must be zero */
>  };
>  
> +/* flags for struct file_dedupe_range */
> +/*
> + * Without this flag, bytes_deduped is the requested length on success,
> + * even if the filesystem deduplicated fewer bytes (e.g. after shortening
> + * the request to a block boundary).  With this flag, bytes_deduped is
> + * the number of bytes actually deduplicated.
> + */
> +#define FILE_DEDUPE_RANGE_REPORT_PROGRESS (1U << 0)
> +
>  /* from struct btrfs_ioctl_file_extent_same_args */
>  struct file_dedupe_range {
>  	__u64 src_offset;	/* in - start of extent in source */
>  	__u64 src_length;	/* in - length of extent */
>  	__u16 dest_count;	/* in - total elements in info array */
>  	__u16 reserved1;	/* must be zero */
> -	__u32 reserved2;	/* must be zero */
> +	__u32 flags;		/* in - FILE_DEDUPE_RANGE_* flags */
>  	struct file_dedupe_range_info info[];
>  };
>  
> -- 
> 2.55.0
> 
> 
