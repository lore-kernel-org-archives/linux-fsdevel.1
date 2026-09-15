Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FC38F248;
	Tue, 15 Sep 2026 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439659; cv=none; b=JzotSkBAJ9iavolzYuVLdMQdc0+Li3GWXvHkL//foLPHtLEi/Ti+jtf5dQypmfp/Wy8Q/BwhSMEdpIImWVZhGiPw4oLGFfh3v3FHYuO/15nENU79mD0h8+8oIXUjbGDhh4yAWK2XoLZfoVbfrd3fTUNkBPvu18l3XH/bzj01c74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439659; c=relaxed/simple;
	bh=fM13z+ilcXTw+5+0wC8p5TkmbveOs7tvssNbyuoey/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkEvypTvGvuQ/JuCwuAUGb1b6lkY25vn8AozdyTYaG+BNThAkXb1n9pplrugz4gBHZVLdjCWhymyquOscJ9pyE3Do43bHpyQKTjHdMEireW/lrhEMjPUzXfB/tOlbKI8PyMdh4gjr0d0w61MbO3R+x0/FOGnPTLzUSou4KzggSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F13qASLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F13qASLZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3D51B1F000FF;
	Tue, 15 Sep 2026 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439649;
	bh=3sH7X/SbqUMNyEPvhN5PL+68iH9tnev2ns/TtOK0rL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F13qASLZym8p7hStKVdJ3zSn0bgiNZFrK2WHPNvaUlQu01XVcZ6J5YeQMhavXDSfN
	 PXTjQBzBR6YlIAm4Pnq5YgoDDbitNpDOhXy6W8R6YFJqJFdFdPSY2EQjRN6z7QO7nS
	 1XesNA1AtsIxq1kQoJwIey1fEKemj4Mfas9fDYXChAZzyalasnNGENQSGhlukXa45C
	 WBxP/RVbECPmsy8FvP+dSsGXy3eiXO6hPnZu3CXn32Lgb5pMAF2Ym73HpwzdE8CdiY
	 JiJk7UMX1Qm1jnvv+PGroggBD5gBbjv2iHWU2k1ln8XUyPpDkTS2ar9TzSoGR2Xz3t
	 pt20fUwUC1ppg==
Date: Mon, 14 Sep 2026 19:34:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org
Subject: Re: [PATCH v4 2/7] hfsplus: rework hfsplus_get_block() logic
Message-ID: <20260915023408.GD6244@frogsfrogsfrogs>
References: <20260914233941.2966421-1-slava@dubeyko.com>
 <20260914233941.2966421-3-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-3-slava@dubeyko.com>

On Mon, Sep 14, 2026 at 04:39:36PM -0700, Viacheslav Dubeyko wrote:
> Split the extent-lookup/allocate logic out of hfsplus_get_block() into
> a new hfsplus_map_extent(), which reports the mapping as
> (dblock, max_blocks, balloc) instead of filling in a buffer_head.
> hfsplus_get_block() becomes a thin wrapper around it for the
> buffer_head-based callers (B-tree metadata, symlinks).
> 
> No functional change to the existing buffer_head path. This is
> preparation for the iomap-based regular file I/O path added in a
> later patch, which will call hfsplus_map_extent() directly.
> 
> cc: Christoph Hellwig <hch@lst.de>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
>  fs/hfsplus/extents.c    | 118 +++++++++++++++++++++++++++++-----------
>  fs/hfsplus/hfsplus_fs.h |   2 +
>  2 files changed, 87 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d18..ffd52ad8867c 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -48,18 +48,29 @@ static void hfsplus_ext_build_key(hfsplus_btree_key *key, u32 cnid,
>  	key->ext.pad = 0;
>  }
>  
> -static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off)
> +/*
> + * hfsplus_ext_find_block() - find contiguous sequence of block
> + *
> + * Find the disk allocation block for 'off' within an 8-entry
> + * extent record, and the number of further allocation blocks
> + * that are contiguous with it in the same extent entry.
> + */
> +static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off,
> +				 u32 *dblock)

Hmm.  Does this function take an hfs+ extent and a file block offset
within that extent as inputs?  And are its outputs the physical block
number in @dblock, and the block count as the return value?

(Wow, TN1150 is still available!)

It's sorta too bad that this code doesn't just return a mapping
structure with some nice names to make the code easier to understand,
but, eh, whatever.  Old fs code isn't always pretty. :)

This took me a while to understand, but it seems reasonable to me so
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  {
>  	int i;
>  	u32 count;
>  
> -	for (i = 0; i < 8; ext++, i++) {
> +	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++) {
>  		count = be32_to_cpu(ext->block_count);
> -		if (off < count)
> -			return be32_to_cpu(ext->start_block) + off;
> +		if (off < count) {
> +			*dblock = be32_to_cpu(ext->start_block) + off;
> +			return count - off;
> +		}
>  		off -= count;
>  	}
>  	/* panic? */
> +	*dblock = 0;
>  	return 0;
>  }
>  
> @@ -68,7 +79,7 @@ static int hfsplus_ext_block_count(struct hfsplus_extent *ext)
>  	int i;
>  	u32 count = 0;
>  
> -	for (i = 0; i < 8; ext++, i++)
> +	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++)
>  		count += be32_to_cpu(ext->block_count);
>  	return count;
>  }
> @@ -225,37 +236,46 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
>  	return res;
>  }
>  
> -/* Get a block at iblock for inode, possibly allocating if create */
> -int hfsplus_get_block(struct inode *inode, sector_t iblock,
> -		      struct buffer_head *bh_result, int create)
> +/*
> + * hfsplus_map_extent() - find or allocate a sequence of allocation blocks
> + *
> + * Looks up the allocation block at 'ablock' for inode, extending the
> + * file (via hfsplus_file_extend(), in clump_blocks-sized chunks) when
> + * 'create' is set and 'ablock' lies beyond the current allocation.
> + *
> + * On success, *dblock is the disk allocation block backing 'ablock',
> + * and *max_blocks is the number of further allocation blocks that are
> + * contiguous with it (i.e. the remaining length of the extent entry
> + * that contains 'ablock'), which may be smaller than the whole file's
> + * remaining allocation when the fork is fragmented across several
> + * extent entries. If a new extent had to be allocated to satisfy the
> + * request, *balloc (when non-NULL) is set to true.
> + */
> +int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
> +			u32 *dblock, u32 *max_blocks, bool *balloc)
>  {
> -	struct super_block *sb = inode->i_sb;
> -	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
>  	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
> -	int res = -EIO;
> -	u32 ablock, dblock, mask;
> -	sector_t sector;
> -	int was_dirty = 0;
> +	int was_dirty;
> +	int res;
>  
> -	/* Convert inode block to disk allocation block */
> -	ablock = iblock >> sbi->fs_shift;
> +	if (balloc)
> +		*balloc = false;
>  
> -	if (iblock >= hip->fs_blocks) {
> +	if (ablock >= hip->alloc_blocks) {
>  		if (!create)
> -			return 0;
> -		if (iblock > hip->fs_blocks)
>  			return -EIO;
> -		if (ablock >= hip->alloc_blocks) {
> -			res = hfsplus_file_extend(inode, false);
> -			if (res)
> -				return res;
> -		}
> -	} else
> -		create = 0;
> +		res = hfsplus_file_extend(inode, false);
> +		if (res)
> +			return res;
> +		if (balloc)
> +			*balloc = true;
> +	}
>  
>  	if (ablock < hip->first_blocks) {
> -		dblock = hfsplus_ext_find_block(hip->first_extents, ablock);
> -		goto done;
> +		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
> +						     ablock,
> +						     dblock);
> +		return 0;
>  	}
>  
>  	if (inode->i_ino == HFSPLUS_EXT_CNID)
> @@ -274,11 +294,44 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  		mutex_unlock(&hip->extents_lock);
>  		return -EIO;
>  	}
> -	dblock = hfsplus_ext_find_block(hip->cached_extents,
> -					ablock - hip->cached_start);
> +	*max_blocks = hfsplus_ext_find_block(hip->cached_extents,
> +					     ablock - hip->cached_start,
> +					     dblock);
>  	mutex_unlock(&hip->extents_lock);
>  
> -done:
> +	if (was_dirty)
> +		mark_inode_dirty(inode);
> +
> +	return 0;
> +}
> +
> +/* Get a block at iblock for inode, possibly allocating if create */
> +int hfsplus_get_block(struct inode *inode, sector_t iblock,
> +		      struct buffer_head *bh_result, int create)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
> +	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
> +	u32 ablock, dblock, mask, max_blocks;
> +	sector_t sector;
> +	int res;
> +
> +	/* Convert inode block to disk allocation block */
> +	ablock = iblock >> sbi->fs_shift;
> +
> +	if (iblock >= hip->fs_blocks) {
> +		if (!create)
> +			return 0;
> +		if (iblock > hip->fs_blocks)
> +			return -EIO;
> +	} else
> +		create = 0;
> +
> +	res = hfsplus_map_extent(inode, ablock, create, &dblock, &max_blocks,
> +				  NULL);
> +	if (res)
> +		return res;
> +
>  	hfs_dbg("ino %llu, iblock %llu - dblock %u\n",
>  		inode->i_ino, (long long)iblock, dblock);
>  
> @@ -292,9 +345,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  		hip->phys_size += sb->s_blocksize;
>  		hip->fs_blocks++;
>  		inode_add_bytes(inode, sb->s_blocksize);
> -	}
> -	if (create || was_dirty)
>  		mark_inode_dirty(inode);
> +	}
>  	return 0;
>  }
>  
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1e5b58e6a13f..67586382269b 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -436,6 +436,8 @@ int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
>  int hfsplus_ext_write_extent(struct inode *inode);
>  int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  		      struct buffer_head *bh_result, int create);
> +int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
> +			u32 *dblock, u32 *max_blocks, bool *balloc);
>  int hfsplus_free_fork(struct super_block *sb, u32 cnid,
>  		      struct hfsplus_fork_raw *fork, int type);
>  int hfsplus_file_extend(struct inode *inode, bool zeroout);
> -- 
> 2.43.0
> 
> 
