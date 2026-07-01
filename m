Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514564BC00F;
	Wed,  1 Jul 2026 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929218; cv=none; b=ZpFyz403xcXo+Dn6pRRJ4TF6Zp4r8GrrAx+QzKpMYTTFfAP5e8eVpI+vkUpd/zNPQZrMUmRSoMZ05AcboUC/XdwAsloqJOuRvpSl2j8AW222KWmyY9A6hSPH+Kumri/xXOB3TmL2XawA+9AFFb0VnTRO4qwqcR1uSbtxXbvRe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929218; c=relaxed/simple;
	bh=Pmhoh5TxxXTeuv5gl1ix5haTVNRimFftCHNNXDlSj1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUEeoHeDgTG2cO4XBguexCapdtG75KuHqKXBkT5A84cDYYSDlwUMFjfkQUsCJIp2c+0at/jdNT5ovH/wfZ8skAkpqUXZExiYlEdoI3Y+iCgLIMdNCtMav15nDfXv3KdL4OiUwxo7rXzR1DLxbTcwqw4kOBFheY6wJeyBk9lW2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Lc9+42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Lc9+42"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1E1F21F000E9;
	Wed,  1 Jul 2026 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782929217;
	bh=a6rlS+Kosfv3If9Om4L5MDD2wn7ZyiGSmqyoTWk658o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3Lc9+42fNL4hJP0sP3o2RngJirXha2sot70jSOnFBj6uSrrhVF2xkwM3d2vRow5f
	 b6v6087pIklr60cus4e8WHggrTQer9mu6wgxJIjvnoNoIlnDCLbTp0YX1G1HeWnIwc
	 OdCgY+hGhYoTRoOVrhPc4P9tx1lcdp1tGWrbFkC/ltoUUYF9rpdclYnJtFOuSGOMna
	 6DnPYKR7Eg5QdMRoPjwRGCEWkBwD/sAHpgo4gWZSex+VDdEdaS1al6wSrpJoby1EY6
	 hrH6GA0WdWIJSovkdiKMTqmgP7Zxp8aBkp7NYrJU+9a6Uu9BBY8z3n8KQ1mfHUVNUO
	 B3KgypeIBhjkw==
Date: Wed, 1 Jul 2026 11:06:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	hch@infradead.org, viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v2 1/4] minix: add iomap infrastructure
Message-ID: <20260701180656.GB6507@frogsfrogsfrogs>
References: <cover.1782619718.git.jbingham@gmail.com>
 <041284c8aa6d5e73e834bac9842b91885d05b982.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041284c8aa6d5e73e834bac9842b91885d05b982.1782619718.git.jbingham@gmail.com>

On Sat, Jun 27, 2026 at 10:15:53PM -0700, Jeremy Bingham wrote:
> Add an iomap implementation for minix, adapted from the out-of-tree
> xiafs module's iomap code. The xiafs module, in turn, borrowed heavily
> from minix's own code.
> 
> The iomap_begin function replaces get_block for the iomap path:
> it walks the indirect block tree, allocates blocks when needed, and
> returns the mapping in a struct iomap. The iomap_end function is a
> nop since minix has no extents or transactions to finalize.
> 
> Because minix has two filesystem versions (V1 with 16-bit block
> numbers, V2/V3 with 32-bit) that share itree_common.c via #include,
> the iomap.c file follows the same pattern. It is #included into
> itree_v1.c and itree_v2.c so it can use the version-specific block_t,
> block_to_cpu, and cpu_to_block definitions directly.
> 
> Each version gets its own iomap_ops struct (V1_minix_iomap_ops,
> V2_minix_iomap_ops) with thin wrappers around the shared
> minix_iomap_begin/minix_iomap_end. A minix_iomap_ops_ver() helper
> selects the correct ops based on the filesystem version.
> 
> minix_get_block is exported from inode.c for use by the iomap
> writeback path and the directory aops that still use buffer_heads.
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
> ---
>  fs/minix/iomap.c    | 114 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/minix/itree_v1.c |  25 +++++++++-
>  fs/minix/itree_v2.c |  17 ++++++-
>  fs/minix/minix.h    |  23 ++++++++-
>  4 files changed, 175 insertions(+), 4 deletions(-)
>  create mode 100644 fs/minix/iomap.c
> 
> diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
> new file mode 100644
> index 000000000000..7bb0439e3669
> --- /dev/null
> +++ b/fs/minix/iomap.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * iomap functions for minix. At least the first pass of this file was taken
> + * from the xiafs iomap.c, which is fitting since the xiafs module in turn
> + * borrowed heavily from the modernized minix fs kernel module.

Is this the "modernized" minix fs kernel module??

xiafs hasn't been in the kernel for years; I see little point in
mentioning an externally maintained driver inside the kernel source.

> + */
> +
> +/*
> + * minix_iomap_begin - map a file range to disk blocks. It acts as a replacement
> + * for get_block in itree_common.c, at least in the important ways, and is
> + * adapted from it, but it uses iomap instead of buffer_head. This is taken
> + * directly from the out-of-tree xiafs iomap changes, and the exfat iomap
> + * changes were an inspiration for that.
> + */
> +static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	unsigned int blkbits = sb->s_blocksize_bits;
> +	sector_t iblock = offset >> blkbits;
> +	int create = flags & IOMAP_WRITE;
> +
> +	/* Mostly taken from modern-xiafs itree.c get_block with elements from
> +	 * similar exfat operations.
> +	 */
> +	int offsets[DEPTH];
> +	Indirect chain[DEPTH];
> +	Indirect *partial;
> +	int depth = block_to_path(inode, iblock, offsets);
> +	int left;
> +	int err = -EIO;
> +
> +	sector_t phys;
> +
> +	/* block is beyond max file size */
> +	if (depth == 0)
> +		goto out;
> +
> +	iomap->bdev = inode->i_sb->s_bdev;
> +
> +reread:
> +	partial = get_branch(inode, depth, offsets, chain, &err);
> +
> +	/* Simplest case - block found, no allocation needed */
> +	if (!partial) {
> +		/* Bit of a weird order, but it'll make sense when you get to
> +		 * the bottom.
> +		 */
> +		iomap->flags = IOMAP_F_MERGED;
> +got_it:
> +		phys = block_to_cpu(chain[depth - 1].key);
> +		partial = chain+depth-1;
> +		/* Set up the iomap struct before cleaning up */
> +		iomap->type = IOMAP_MAPPED;
> +		iomap->addr = (u64)phys << blkbits;
> +		iomap->length = 1 << blkbits;
> +		iomap->offset = (u64)iblock << blkbits;
> +		goto cleanup;
> +	}
> +
> +	/* Next simple case - plain lookup or failed read of indirect block */
> +	if (!create || err == -EIO) {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->length = 1 << blkbits;
> +		iomap->offset = (u64)iblock << blkbits;
> +		iomap->flags = 0;
> +cleanup:
> +		while (partial > chain) {
> +			brelse(partial->bh);
> +			partial--;
> +		}

Uhhh ... these three ought to be factored out into separate helpers to
(a) clean up @chain, (b) set up a IOMAP_MAPPED mapping, and (c) set up a
IOMAP_HOLE mapping.  Don't write a pile of spaghetti goes.

Also kinda surprised that you set IOMAP_F_MERGED but don't try to look
forward to find adjacent blocks?

> +out:
> +		return err;
> +	}
> +
> +	/*
> +	 * Indirect block might be removed by truncate while we were
> +	 * reading it. Handling of that case (forget what we've got and
> +	 * reread) is taken out of the main path.

/me wonders how we'd be racing with setattr?

--D

> +	 */
> +	if (err == -EAGAIN)
> +		goto changed;
> +
> +	left = (chain + depth) - partial;
> +	err = alloc_branch(inode, left, offsets + (partial - chain), partial);
> +	if (err)
> +		goto cleanup;
> +
> +	if (splice_branch(inode, chain, partial, left) < 0)
> +		goto changed;
> +
> +	/* Successful allocation, mapping it. */
> +	iomap->flags = IOMAP_F_NEW;
> +	goto got_it;
> +
> +changed:
> +	while (partial > chain) {
> +		brelse(partial->bh);
> +		partial--;
> +	}
> +	goto reread;
> +}
> +
> +/*
> + * minix_iomap_end ends up being a nop; since minix doesn't have any extents or
> + * transactions to worry about, there isn't anything to update here. The on-disk
> + * indirect blocks get dirtied in minix_iomap_begin.
> + */
> +static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> +	ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +	return 0;
> +}
> diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
> index 1fed906042aa..58c29f4443d3 100644
> --- a/fs/minix/itree_v1.c
> +++ b/fs/minix/itree_v1.c
> @@ -49,6 +49,18 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
>  }
>  
>  #include "itree_common.c"
> +/* NOTA BENE:
> + *
> + * This is icky to me, but at the same time having it be a standalone C file
> + * that's compiled to object form and linked separately like it is in xiafs is
> + * much nastier in minix because of the different versions of the minix fs that
> + * have some very, very different aspects, like the size of block_t. I don't
> + * like it, but since minix already has this pattern where a common itree file
> + * is included in the itree_v1 and itree_v2(and v3) files, I'm including iomap.c
> + * in these files as well. It does at least avoid exporting some currently
> + * static functions that aren't needed anywhere but itree_common.c and iomap.c.
> + */
> +#include "iomap.c"
>  
>  int V1_minix_get_block(struct inode * inode, long block,
>  			struct buffer_head *bh_result, int create)
> @@ -61,7 +73,18 @@ void V1_minix_truncate(struct inode * inode)
>  	truncate(inode);
>  }
>  
> -unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
> +unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
>  {
>  	return nblocks(size, sb);
>  }
> +
> +int V1_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> +}
> +
> +const struct iomap_ops V1_minix_iomap_ops = {
> +	.iomap_begin = V1_minix_iomap_begin,
> +	.iomap_end   = minix_iomap_end,
> +};
> diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
> index 9d00f31a2d9d..fc7a5ae8fa1c 100644
> --- a/fs/minix/itree_v2.c
> +++ b/fs/minix/itree_v2.c
> @@ -57,6 +57,10 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
>  }
>  
>  #include "itree_common.c"
> +/* See the note in itree_v1 in a comment that starts "NOTA BENE" for an
> + * explanation for why iomap.c is included here.
> + */
> +#include "iomap.c"
>  
>  int V2_minix_get_block(struct inode * inode, long block,
>  			struct buffer_head *bh_result, int create)
> @@ -69,7 +73,18 @@ void V2_minix_truncate(struct inode * inode)
>  	truncate(inode);
>  }
>  
> -unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
> +unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
>  {
>  	return nblocks(size, sb);
>  }
> +
> +int V2_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return minix_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> +}
> +
> +const struct iomap_ops V2_minix_iomap_ops = {
> +	.iomap_begin = V2_minix_iomap_begin,
> +	.iomap_end   = minix_iomap_end,
> +};
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index f2025c9b5825..77e503cca97f 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -5,6 +5,7 @@
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/minix_fs.h>
> +#include <linux/iomap.h>
>  
>  #define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
>  #define MINIX_V1		0x0001		/* original minix fs */
> @@ -69,6 +70,8 @@ extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
>  extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
>  extern unsigned V1_minix_blocks(loff_t, struct super_block *);
>  extern unsigned V2_minix_blocks(loff_t, struct super_block *);
> +extern int minix_get_block(struct inode *inode, sector_t block,
> +		    struct buffer_head *bh_result, int create);
>  
>  struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
>  int minix_add_link(struct dentry*, struct inode*);
> @@ -80,10 +83,20 @@ int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
>  struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
>  ino_t minix_inode_by_name(struct dentry*);
>  
> +extern int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
> +	loff_t length, unsigned int flags, struct iomap *iomap,
> +	struct iomap *srcmap);
> +extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
> +	loff_t length, unsigned int flags, struct iomap *iomap,
> +	struct iomap *srcmap);
> +
> +extern const struct address_space_operations minix_aops;
>  extern const struct inode_operations minix_file_inode_operations;
>  extern const struct inode_operations minix_dir_inode_operations;
>  extern const struct file_operations minix_file_operations;
>  extern const struct file_operations minix_dir_operations;
> +extern const struct iomap_ops V1_minix_iomap_ops;
> +extern const struct iomap_ops V2_minix_iomap_ops;
>  
>  static inline struct minix_sb_info *minix_sb(struct super_block *sb)
>  {
> @@ -95,11 +108,17 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
>  	return container_of(inode, struct minix_inode_info, vfs_inode);
>  }
>  
> -static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
> +static inline unsigned int minix_blocks_needed(unsigned int bits, unsigned int blocksize)
>  {
>  	return DIV_ROUND_UP(bits, blocksize * 8);
>  }
>  
> +static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode *inode)
> +{
> +	return (INODE_VERSION(inode) == MINIX_V1) ?
> +		&V1_minix_iomap_ops : &V2_minix_iomap_ops;
> +}
> +
>  #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
>  	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
>  
> @@ -129,7 +148,7 @@ static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
>   * big-endian 16bit indexed bitmaps
>   */
>  
> -static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
> +static inline int minix_find_first_zero_bit(const void *vaddr, unsigned int size)
>  {
>  	const unsigned short *p = vaddr, *addr = vaddr;
>  	unsigned short num;
> -- 
> 2.47.3
> 
> 
