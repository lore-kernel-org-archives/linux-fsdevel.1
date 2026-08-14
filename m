Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899F3630B0;
	Fri, 14 Aug 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724224; cv=none; b=YImeG73UETyvyWUjiDgf40AosSxMFDMfC5pXQxgIPEmlws+lH4BaIMMfKxCzAoU6yTN2cxxIdXoEIadDX5xxooV1CzdA5mKyJ4i4IUWJbE5hracx00z48p2sRMIX1X9znqTbH8opG3AM4KaF3OKfKJ3sHZe6hHCRlt19SXhyVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724224; c=relaxed/simple;
	bh=fB27XMefhaD3IaMeKoL/S6K9iT7qo4VEIYLhqf1TmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnE3kBBeYwFGZvoWFVrX91dLo1qAeDkI93X/BB7t4qQlPh8t2jiWMSKiDZiE4zvE2k2tcN7sP0JIJ4as2iR8jz+9RJ9MySHtpsA/U78T9JirspksEePnI2jZzVJk0kcTYhtZCOTD/gsh1YAH9dbKRgm+kIbMZM8F2LxQYFXWc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCnXften; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCnXften"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C4B581F000E9;
	Fri, 14 Aug 2026 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786724217;
	bh=3cfVlO+2CpkcTaWcQfxmRrUy3uWoJEOFYArVHlGtZBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCnXften8kvJ98GEQsJcrgf5KeichzIwOHXQ5TV8QR8bHuIKjpWp0qmA6QeGfrJGJ
	 D5nPR78BbVpj/bvx/mtMxhkaa9t+7aQEqDVWDKZnkAItcZU2i0yYlqQwbkbCr3+DTI
	 /8Fs1svVZR9cFPmLwE8JwHBZCAW1UPpYcgDzACLqrSjEqJEp4rtbMHxuj15NRwZwrh
	 Hh3XEYZ/fg9BgH/FTA6o4xMJfesA26Gtegr963aVYDKLx0sRipqPQAk6828fHmmdSY
	 TZ+HgIQx2sKz/rdOX2CilBsXz9WDnBbwgnbuOhQT8iia39KXzSteo0ldl6jeAgHTX+
	 pqmtqalG7UxQw==
Date: Fri, 14 Aug 2026 09:16:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de, david@fromorbit.com,
	amir73il@gmail.com
Subject: Re: [PATCH v2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to
 FIDEDUPERANGE
Message-ID: <20260814161657.GN3560084@frogsfrogsfrogs>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
 <20260814082326.3756669-1-matthias.goergens@gmail.com>
 <20260814082326.3756669-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814082326.3756669-2-matthias.goergens@gmail.com>

On Fri, Aug 14, 2026 at 04:23:26PM +0800, Matthias Goergens wrote:
> FIDEDUPERANGE reports the requested length in bytes_deduped even when
> the filesystem shortens a destination range and deduplicates fewer
> bytes.  This predates the VFS hoisting of the ioctl (the btrfs ioctl
> behaved the same way), and changing the default would change an ABI
> that deployed consumers such as duperemove depend on: they advance
> their offsets by bytes_deduped and expect the historical semantics.
> 
> Add a flag to opt into the truthful behaviour: with
> FILE_DEDUPE_RANGE_REPORT_PROGRESS set, bytes_deduped reports the bytes
> actually deduplicated, and a non-zero request shortened to zero fails
> per destination with -EINVAL instead of reporting success with no
> progress.  Unknown flag bits are rejected.
> 
> The flag leaves every existing caller's behaviour unchanged and lets
> new callers request accurate progress reporting.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matthias.goergens@gmail.com/
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  fs/remap_range.c        | 7 ++++++-
>  include/uapi/linux/fs.h | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 26afbbbfb10c2..16192ec19bb6d 100644
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
> @@ -555,6 +555,11 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  			info->status = FILE_DEDUPE_RANGE_DIFFERS;
>  		else if (deduped < 0)
>  			info->status = deduped;
> +		else if ((same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS) &&
> +			 !deduped && len)
> +			info->status = -EINVAL;

Thinking about this (deduped == 0 && len > 0) case some more -- the
filesystem didn't return EBADE (aka FILE_DEDUPE_RANGE_DIFFERS), which
means that len wasn't long enough for the filesystem to do any
interesting work.  For example, if you try to dedupe two 65 byte files
when the blocksize is 4k, the generic_remap_check* functions can change
65 to 0, and that's what we get here.

Seeing as we've now a new flag to play with, do we really need to return
EINVAL here?  Only new code will use the new flag, so we don't have to
worry about old code; and the flag has already established that
info->bytes_deduped is the quantity of deduplication achieved, *not* the
amount by which to bump the source/dest offset for the next call.  So
passing out zero here should be ok.

Hmm.

Waitaminute, we have *two* output fields -- status and bytes_deduped.
There are three different cases that I can see:

1) If an operational error occurs, we set info->status to the negative
error number and bytes_deduped is 0.

2) If the file ranges starting at src_offset/dest_offset can be
deduplicated, we set info->status to FILE_DEDUPE_RANGE_SAME and set
info->bytes_deduped to the number of bytes that were deduplicated.

3) If the file ranges cannot be deduplicated, we set info->status to
FILE_DEDUPE_RANGE_DIFFERS and ... do nothing with info->bytes_deduped,
so it remains 0.

In cases 2 and 3, userspace is likely to want to try again with any
remaining file range.

For case 2 this is trivial: add bytes_deduped to src_offset and
dest_offset; subtract it from src_length; and call the kernel again.
In other words, the kernel replies "ok I dedupe'd 72k of data" and the
program advances the file offsets by 72k and asks the kernel to try
again.

For case 3 there isn't currently any obvious way for the ioctl code to
communicate how far userspace should advance the file offsets before
calling again.  Most likely (since only blocks can be remapped) that
quantity is i_blocksize, but then userspace has to figure out what that
is -- is it statvfs' f_blocksize?  Or statx' stx_blksize?

What if we just did that work for userspace?

	if (deduped == -EBADE) {
		info->status = FILE_DEDUPE_RANGE_DIFFERS;
		if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
			info->bytes_deduped = i_blocksize(src);
	} else if (deduped < 0) {
		info->status = deduped;
	} else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
		info->bytes_deduped = deduped;
	} else {
		info->bytes_deduped = len;
	}

And then the manpage can say:

FILE_DEDUPE_RANGE_REPORT_PROGRESS
	If this flag is set, the output value of status and
	bytes_deduped are redefined as follows:

	If an operational error occurred, status contains the negative
	error number.  bytes_deduped field is set to zero.

	If status is FILE_DEDUPE_RANGE_DIFFERS, this is the number of
	bytes that were examined but could not be deduplicated.

	If status is FILE_DEDUPE_RANGE_SAME, this is the number of bytes
	that were successfully deduplicated at the start of the provided
	file ranges.

	The intent here is that a userspace program could use
	bytes_deduplicated to advance the input file ranges in
	preparation for another kernel call.  In both cases, a zero
	value for bytes_deduped means that no further work is possible.

What do you think of that?

> +		else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
> +			info->bytes_deduped = deduped;
>  		else
>  			info->bytes_deduped = len;
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bd87262f2e349..abee40359bfd5 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -179,12 +179,14 @@ struct file_dedupe_range_info {
>  };
>  
>  /* from struct btrfs_ioctl_file_extent_same_args */
> +#define FILE_DEDUPE_RANGE_REPORT_PROGRESS 0x1

Nitpicking: This should be (1U << 0), not 0x1, because 0x1 is treated as
a signed int and the flags field is unsigned.

--D

> +
>  struct file_dedupe_range {
>  	__u64 src_offset;	/* in - start of extent in source */
>  	__u64 src_length;	/* in - length of extent */
>  	__u16 dest_count;	/* in - total elements in info array */
>  	__u16 reserved1;	/* must be zero */
> -	__u32 reserved2;	/* must be zero */
> +	__u32 flags;		/* FILE_DEDUPE_RANGE_* flags; was reserved2 */
>  	struct file_dedupe_range_info info[];
>  };
>  
> -- 
> 2.55.0
> 
> 
