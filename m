Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D87481230;
	Mon, 18 May 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120238; cv=none; b=YFiGlBxkQTe6cr8qMsTOevbvBTG5pIs0O1KQyY67Wr3g0xvaXhHKTJo6zTEFZoLVrtsLLc5T6oXQrDCecG0N2ZzBrWzhxJ+Ls0VdfDA+lFzE6YRtKxng8XafkC5lV4uNdIZXBwFRUaQB6mNdxBg8vhMynxMUy61ecfh6qZCg4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120238; c=relaxed/simple;
	bh=LfR2vPm7O7NKloOsCpdZdF46QTHyJeCTEdYbxW22vDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgY9DEoyxOnk1lU7bNHbIQ2Q4vwP8TOu0Efh7kGkYfvRAM09hHxZhYYsu6l08Kh+bXFtI9cPZB1PXCoNbEkXL/c5XOsX8vHvcleKnLqEUAFrg89c1iCMAYIi5iIO8l2T7IcKi/R1oMHayYoM6jRkJeazRKMz1bhgat5AtQGXsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb/n9o98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb/n9o98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E312DC2BCB7;
	Mon, 18 May 2026 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120236;
	bh=LfR2vPm7O7NKloOsCpdZdF46QTHyJeCTEdYbxW22vDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bb/n9o9894ZAactKOdw514J+FyzWp9QH13KxVIT3ZtagSqMkuoE6c1/Fmwctp4ib7
	 1QkCtjqSqVhZxaVjfS/Tyec7c5NjvNxm3WUeeO80CXXKLaefJgHrLPZjcL+XQekFXO
	 7YDcOYfTEiAdQlzbSW2TbxXE2ONTsqAH6oN5mdgQUhnLCZJ6ROWs7NUU82MhPArAY3
	 ocD4EBd6m9xdGcs7qfmarq3y9o18nQFsyjjbqabuQGXYnhaW1y6nfUw6sYXFr9lcdp
	 SYC2N+FK+Rk9lpzA0Byh4/eAfsODMdQ7L9nzWBsiqRChwkzeajEvSosgaB1/mhCmAC
	 dCg9mcy4vzYgg==
Date: Mon, 18 May 2026 09:03:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com,
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Subject: Re: [PATCH v4 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
Message-ID: <20260518160356.GH9568@frogsfrogsfrogs>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
 <20260518114705.9601-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518114705.9601-2-linkinjeon@kernel.org>

On Mon, May 18, 2026 at 08:46:55PM +0900, Namjae Jeon wrote:
> In filesystems that maintain a separate Valid Data Length, such as exFAT
> and NTFS, a partial write may start at or beyond the current valid_size and
> extend it. In this case, the region after the previous valid_size but
> within the same filesystem block is considered unwritten.
> 
> This patch introduces IOMAP_F_ZERO_TAIL. When this flag is set in iomap,
> __iomap_write_begin() will zero only the tail portion while preserving any
> valid data before it in the same block.
> 
> Without this tail zeroing, stale data in the unwritten portion of the block
> can remain in the page cache. Subsequent reads can then return incorrect
> contents from that region.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

AFAICT, the "valid size" means "all space between valid_size and i_size
is unwritten", and that's why you need the tail of the block to be
zeroed, right?

So if, say, the fsblock size is 4k and valid_size is 80k; and I initiate
a pwrite of 300 bytes at 121k, exfat will do its own zeroing to bump
valid_size up to 121k, right?  Then the actual iomap_write call will
copy the 300 bytes into the pagecache, and now it needs ZERO_TAIL to
zero the rest of the pagecache from (121k + 300) to 124k, correct?

(What I'm probing for is, there's no need for a ZERO_HEAD at this time
because exfat has to take care of that, right?)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++++
>  include/linux/iomap.h  | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d7b648421a70..44046c648df4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -836,6 +836,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  				return -EIO;
>  			folio_zero_segments(folio, poff, from, to, poff + plen);
>  		} else {
> +			const struct iomap *iomap = iomap_iter_srcmap(iter);
>  			int status;
>  
>  			if (iter->flags & IOMAP_NOWAIT)
> @@ -853,6 +854,9 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  						  len, status, GFP_NOFS);
>  			if (status)
>  				return status;
> +
> +			if (iomap->flags & IOMAP_F_ZERO_TAIL)
> +				folio_zero_segment(folio, to, poff + plen);
>  		}
>  		iomap_set_range_uptodate(folio, poff, plen);
>  	} while ((block_start += plen) < block_end);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2c5685adf3a9..750602e18750 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -67,6 +67,9 @@ struct vm_fault;
>   * bio, i.e. set REQ_ATOMIC.
>   *
>   * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
> + *
> + * IOMAP_F_ZERO_TAIL indicates the remainder of the block after the data
> + * written should be zeroed.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -86,6 +89,7 @@ struct vm_fault;
>  #else
>  #define IOMAP_F_INTEGRITY	0
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
> +#define IOMAP_F_ZERO_TAIL	(1U << 10)
>  
>  /*
>   * Flag reserved for file system specific usage
> -- 
> 2.25.1
> 
