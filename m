Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45AD36F8E7;
	Tue, 23 Jun 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209546; cv=none; b=iwAFUFiF/0aoKi66Y3PxqegRvn9JMIpRZgq4ONUmnSw+KJ/ZggwQjEsvhxwjmZJX/XrQHy4HVUvlJgu4GlSMzQMk8n954J69HJ0HCHjU8lcosR2nQHeSQB+rN2sq++lzFpwdVkwNRBj2QteOGRIJ4P22sDy9hLzEWwuUDD5nT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209546; c=relaxed/simple;
	bh=IigXZUbc+KpXcyvTvRUdWH4lx5mR9SZ0eb4SKuvvUxc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rgmUTFYqqPpCpjmyj4j7FLF8BjnqWBqQ7VpSd0rl/g0/Vyl5ZS1iRKkzdkd+bRVN7+jttykYko93NYBgsopzzOBiY2dMTixaa5nfTdPQqjUC+xPwtukNW6UZHn7wFYUdf2X+qps6+afD56CN2VCWwke+Re2DfsHxmOEztEDiCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HchcVgLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HchcVgLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BCD1F000E9;
	Tue, 23 Jun 2026 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209544;
	bh=hD4LUxSkBn7pYsanw0vckHycDCWpdV/RCWEIXGmwrvU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HchcVgLgt0Mlr8Z8AoqIb1Icw6uhwMmmrg1FRk+kPQEwyAQ9ITHUcRzI3ZpgzXyz5
	 RSYLwNfLxkgfFFxtqg2SBbSdKRA4apBE3TRu3IgHPQZ6EAiKOuuXAzNpOtJKpbRHvt
	 Ge8DBQ7yUsCbtBqap18Bih3bm3lG53J40RRS9CS1Stg8bMUOVqIkkzE+X6C9+9Tr/s
	 ZkE0HU6I3rfoEv/NINdZWlruIXXJORFMZKfrVl3Peq3LWRemzuRoMyO9fTTSoLrqEO
	 5Ojtb09uSL2cRJb/l0EQ+8daqTSkmGG/QycHDOeeG6Y63NVHCfB7ZIC80MJvlqq1K6
	 NdP1IvnCrCVbQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] cramfs: bound the XIP direct-mapping reads to the
 image size
From: Christian Brauner <brauner@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Nicolas Pitre <nico@fluxnic.net>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260607064146.302647-1-hexlabsecurity@proton.me>
References: <20260607064146.302647-1-hexlabsecurity@proton.me>
Date: Tue, 23 Jun 2026 12:12:18 +0200
Message-Id: <20260623-hektik-nullnummer-beiwagen-99e6b5a59fb4@brauner>
X-Mailer: b4 0.16-dev-8bbda
X-Developer-Signature: v=1; a=openpgp-sha256; l=4089; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IigXZUbc+KpXcyvTvRUdWH4lx5mR9SZ0eb4SKuvvUxc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZxbBnxi72ecs7iy1XXoK58+j0/T8aNa7FSl1bXLU0l
 a+DNU2io5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKhtYwMm4TKeKcy2Zadkm57
 0HyAY/p3tmA3/5ZzwjP+eCUsFkw7wMjwjNl4UtTT9o/33mcWFoZFNbs+fejz56LZ5G23maXsfnQ
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> The physically-mapped (XIP) fast path dereferences the linear filesystem
> image directly using offsets taken from the on-disk inode.  Unlike the
> normal read path (cramfs_direct_read()), cramfs_get_block_range() and
> cramfs_last_page_is_shared() do not check those offsets against the image
> size before dereferencing:
> 
> 	blockptrs = (u32 *)(sbi->linear_virt_addr + OFFSET(inode) + pgoff * 4);
> 	first_block_addr = blockptrs[0] & ~CRAMFS_BLK_FLAGS;
> 
> OFFSET(inode) (the inode data offset) and the block pointers are read
> from the untrusted on-disk image.  A crafted cramfs image with the
> CRAMFS_FLAG_EXT_BLOCK_POINTERS feature and an out-of-range inode offset
> makes the block-pointer read -- and the subsequent tail-data scan in
> cramfs_last_page_is_shared() -- dereference memory outside the mapped
> image.  mmap()ing a regular file on such an image then faults in the
> kernel (page fault in cramfs_physmem_mmap()).
> 
> Bound every linear-image dereference in the XIP path to sbi->size, the
> same way cramfs_direct_read() already does, and fall back to the bounded
> paging path on any out-of-range access.
> 
> Fixes: eddcd97659e3 ("cramfs: add mmap support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 4edbfccd0bbe..014072a65c5b 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -298,13 +298,22 @@ static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
>  {
>  	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
>  	int i;
> -	u32 *blockptrs, first_block_addr;
> +	u32 *blockptrs, first_block_addr, data_addr;
>  
>  	/*
>  	 * We can dereference memory directly here as this code may be
>  	 * reached only when there is a direct filesystem image mapping
>  	 * available in memory.
> +	 *
> +	 * The block pointer array lives at OFFSET(inode) inside the image.
> +	 * OFFSET() and the block pointers are taken from the (untrusted)
> +	 * on-disk inode, so bound every access to the image the same way
> +	 * cramfs_direct_read() does before dereferencing it.
>  	 */
> +	if (OFFSET(inode) > sbi->size ||
> +	    ((u64)pgoff + *pages) * 4 > sbi->size - OFFSET(inode))
> +		return 0;
> +
>  	blockptrs = (u32 *)(sbi->linear_virt_addr + OFFSET(inode) + pgoff * 4);
>  	first_block_addr = blockptrs[0] & ~CRAMFS_BLK_FLAGS;
>  	i = 0;
> @@ -324,7 +333,14 @@ static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
>  	} while (++i < *pages);
>  
>  	*pages = i;
> -	return first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
> +
> +	/* The mapped data range must also lie within the image. */
> +	data_addr = first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
> +	if (data_addr > sbi->size ||
> +	    (u64)*pages * PAGE_SIZE > sbi->size - data_addr)
> +		return 0;
> +
> +	return data_addr;
>  }
>  
>  #ifdef CONFIG_MMU
> @@ -345,9 +361,21 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
>  	if (!partial)
>  		return false;
>  	last_page = inode->i_size >> PAGE_SHIFT;
> +
> +	/*
> +	 * The block pointer and the tail data are read directly from the
> +	 * image at offsets derived from the untrusted on-disk inode; bound
> +	 * both accesses to the image.  On any overflow treat the last page
> +	 * as shared so the caller falls back to the bounded paging path.
> +	 */
> +	if (OFFSET(inode) > sbi->size ||
> +	    ((u64)last_page + 1) * 4 > sbi->size - OFFSET(inode))
> +		return true;
>  	blockptrs = (u32 *)(sbi->linear_virt_addr + OFFSET(inode));
>  	blockaddr = blockptrs[last_page] & ~CRAMFS_BLK_FLAGS;
>  	blockaddr <<= CRAMFS_BLK_DIRECT_PTR_SHIFT;
> +	if (blockaddr > sbi->size || sbi->size - blockaddr < PAGE_SIZE)
> +		return true;
>  	tail_data = sbi->linear_virt_addr + blockaddr + partial;
>  	return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;


This screems a little for a shared litle static inline helper...

-- 
Christian Brauner <brauner@kernel.org>
