Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958814BC03C;
	Wed,  1 Jul 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929693; cv=none; b=F1/KQm/EYFeBZBVVexs01jVmfEbTiEVLGWkkvYj4XEIHleLRmJJOJXGexuwuLDCe4gRzI/6EMRfQXcSQY4RIywpD/eLo9+FeuTcapjpVMXEnuWc9Nfa6g0kWSVxQ9Vh9JfSxdQh50Jm3gSjl8qhx6nKhuk5DyuidD/CVhxDXND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929693; c=relaxed/simple;
	bh=71YHpS/kpJ2qXKAKKTnObB1t9iEKpEChy49W7c+Ib78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIk82q7HYyU0JgUHv/B7LQAA8QuedBbQGmoMPNed48pCBsbsQERoL+U3lGGnpO8xBsdRZxQCR+bYXtrV/m3k8J3YAUwl8ebWRKFDQG8GHkQ9OFFve/Gz1v/1G70Qqns+Q5JhxtXp/ursyDh1YXekYd1qCqU+roaXKGHJin++f8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPGxeDgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPGxeDgo"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3F0081F000E9;
	Wed,  1 Jul 2026 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782929692;
	bh=5eXLaHsyzIDMsNPTsWXGX5pLUrBhOLUMluFo7Gyo1OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DPGxeDgoJtoj4mRemLwZQ6YhCnPevwe7TNRcYwzsm1Mv3XpJc4AYEEUItwU/4+pA6
	 XSp08+6t6G3vxLbLVMt0aLAf8jHP2Vdljk9OQ96qQW9zq6xbRdgfo7guJHKPMFn/kJ
	 kWi1HaYGeF3f2ENTHgM0gjXSvtRtvcEPv7rZOCSzO3wUvVadJNVRWorLeQL9FA5jdD
	 MGMHFGe6JgKY8ysKg5Qc0V13+rfN4A/Lt64wT74rXP/Pbf9F8RXEeoZQ3DUM6TtJ7b
	 qJHsZdz7ylDMOi5UnGlTzHUhEUAhfR0QGf+qTwHNGi4dO9pIdy43jcVYjoZaJxc0iD
	 dV9vGz3Qku82A==
Date: Wed, 1 Jul 2026 11:14:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	hch@infradead.org, viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v2 2/4] minix: convert address space operations to iomap
Message-ID: <20260701181451.GC6507@frogsfrogsfrogs>
References: <cover.1782619718.git.jbingham@gmail.com>
 <7060fde4f164617c58eeac616a40e5bd89b921d2.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7060fde4f164617c58eeac616a40e5bd89b921d2.1782619718.git.jbingham@gmail.com>

On Sat, Jun 27, 2026 at 10:15:54PM -0700, Jeremy Bingham wrote:
> Convert minix regular file and symlink address space operations from
> buffer_head to iomap. The new minix_aops uses iomap_dirty_folio,
> iomap_invalidate_folio, iomap_bio_read_folio, iomap_bio_readahead,
> iomap_writepages, iomap_bmap, and related iomap helpers.
> The write_begin/write_end callbacks are removed since buffered writes
> now go through iomap_file_buffered_write in file.c.
> 
> Directories keep using buffer_heads via a new minix_dir_aops, which
> retains the old block_dirty_folio, block_read_full_folio,
> block_write_begin, generic_write_end, and mpage_writepages. This is
> necessary because directory entry manipulation (minix_prepare_chunk,
> minix_write_begin) still uses the buffer_head chunk protocol.
> 
> minix_bmap is converted from generic_block_bmap to iomap_bmap.

I'd drop BMAP support entirely, unless you know of people who use LILO
and minixfs.  If all you want is swapfile activation, use
iomap_swapfile_activate... assuming that anyone actually cares about
hosting swapfiles on minixfs.

> The minix_get_block function is exported (non-static) so the
> directory aops can still use it for block_write_begin and
> mpage_writepages.
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
> ---
>  fs/minix/inode.c | 86 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 78 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index c30cc590698d..2ba6766fce51 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -436,7 +436,32 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> -static int minix_get_block(struct inode *inode, sector_t block,
> +static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
> +	struct folio *folio, u64 pos, unsigned int len, u64 end_pos)
> +{
> +	int error;
> +
> +	if (pos < wpc->iomap.offset ||
> +			pos >= wpc->iomap.offset + wpc->iomap.length) {
> +		if (INODE_VERSION(wpc->inode) == MINIX_V1)
> +			error = V1_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
> +				&wpc->iomap, NULL);
> +		else
> +			error = V2_minix_iomap_begin(wpc->inode, pos, len, IOMAP_WRITE,
> +				&wpc->iomap, NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	return iomap_add_to_ioend(wpc, folio, pos, end_pos, len);
> +}
> +
> +static const struct iomap_writeback_ops minix_writeback_ops = {
> +	.writeback_range = minix_writeback_range,
> +	.writeback_submit = iomap_ioend_writeback_submit,
> +};
> +
> +int minix_get_block(struct inode *inode, sector_t block,
>  		    struct buffer_head *bh_result, int create)
>  {
>  	if (INODE_VERSION(inode) == MINIX_V1)
> @@ -445,17 +470,45 @@ static int minix_get_block(struct inode *inode, sector_t block,
>  		return V2_minix_get_block(inode, block, bh_result, create);
>  }
>  
> -static int minix_writepages(struct address_space *mapping,
> +/* The old minix_writepages, preserved for directory operations. */
> +static int minix_block_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
>  	return mpage_writepages(mapping, wbc, minix_get_block);
>  }
>  
> +static int minix_writepages(struct address_space *mapping,
> +		struct writeback_control *wbc)
> +{
> +	struct iomap_writepage_ctx wpc = {
> +		.inode = mapping->host,
> +		.wbc = wbc,
> +		.ops = &minix_writeback_ops,
> +	};
> +	return iomap_writepages(&wpc);
> +}
> +
>  static int minix_read_folio(struct file *file, struct folio *folio)
> +{
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(folio->mapping->host);
> +
> +	iomap_bio_read_folio(folio, ops);
> +	return 0;
> +}
> +
> +/* The old minix_read_folio, preserved for directory operations. */
> +static int minix_block_read_folio(struct file *file, struct folio *folio)
>  {
>  	return block_read_full_folio(folio, minix_get_block);
>  }
>  
> +static void minix_readahead(struct readahead_control *rac)
> +{
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(rac->mapping->host);
> +
> +	iomap_bio_readahead(rac, ops);
> +}
> +
>  int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
>  {
>  	return __block_write_begin(folio, pos, len, minix_get_block);
> @@ -487,19 +540,36 @@ static int minix_write_begin(const struct kiocb *iocb,
>  
>  static sector_t minix_bmap(struct address_space *mapping, sector_t block)
>  {
> -	return generic_block_bmap(mapping,block,minix_get_block);
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(mapping->host);
> +
> +	return iomap_bmap(mapping, block, ops);
>  }
>  
> -static const struct address_space_operations minix_aops = {
> -	.dirty_folio	= block_dirty_folio,
> -	.invalidate_folio = block_invalidate_folio,
> +const struct address_space_operations minix_aops = {
> +	.dirty_folio	= iomap_dirty_folio,
> +	.invalidate_folio = iomap_invalidate_folio,
>  	.read_folio = minix_read_folio,
> +	.readahead = minix_readahead,
>  	.writepages = minix_writepages,
> +	.migrate_folio = filemap_migrate_folio,
> +	.bmap = minix_bmap,
> +	.is_partially_uptodate = iomap_is_partially_uptodate,
> +	.release_folio = iomap_release_folio,
> +	.error_remove_folio = generic_error_remove_folio,
> +};
> +
> +/* A special aops for directories that keeps using the buffer head chunks, at
> + * least for the time being.
> + */
> +static const struct address_space_operations minix_dir_aops = {
> +	.dirty_folio = block_dirty_folio,
> +	.invalidate_folio = block_invalidate_folio,
> +	.read_folio = minix_block_read_folio,
>  	.write_begin = minix_write_begin,
>  	.write_end = generic_write_end,
>  	.migrate_folio = buffer_migrate_folio,
>  	.bmap = minix_bmap,
> -	.direct_IO = noop_direct_IO

I forget, does one have to set FMODE_CAN_ODIRECT if the address_space
operations don't supply a ->direct_IO function?

--D

> +	.writepages = minix_block_writepages,
>  };
>  
>  static const struct inode_operations minix_symlink_inode_operations = {
> @@ -516,7 +586,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
>  	} else if (S_ISDIR(inode->i_mode)) {
>  		inode->i_op = &minix_dir_inode_operations;
>  		inode->i_fop = &minix_dir_operations;
> -		inode->i_mapping->a_ops = &minix_aops;
> +		inode->i_mapping->a_ops = &minix_dir_aops;
>  	} else if (S_ISLNK(inode->i_mode)) {
>  		inode->i_op = &minix_symlink_inode_operations;
>  		inode_nohighmem(inode);
> -- 
> 2.47.3
> 
> 
