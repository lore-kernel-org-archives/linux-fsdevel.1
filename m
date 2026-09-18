Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC011E0DD8;
	Fri, 18 Sep 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739874; cv=none; b=CHrk+RI7WGRxM75qxKmEXBtSHUI27eQ7gho9HXnK3ZR913Kouqd75UXzlig5Ds1uXfXzhUtmtfK8xaLqWK7fDg9yOakRohHBOnie7yACKf4nnCUDnydAtIa/aS6rD6rVa0S7Mgo5w3J0dblxJ/xMRVtGcfppdlkQXOwlwPO9uko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739874; c=relaxed/simple;
	bh=SL6DyRDnOizhao/pI5jXngSsSBV1IzDJXG0yU+8v2PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X21wb1PDAh2HFxmWdD5MAkCR9GcPX/6EJns2i1J9S2KcJWP0wAV9jCfQa+7gMvgDk00ibko9T9NQUGis40plJvDnaB0CtU1U4StPVJs6jspCpOkHucwKDdVhnqJ5dDr5kpRivHHe1m3YmJQqwVf6cFP3WrGlKmiqDxZsdiTuAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A183668BEB; Fri, 18 Sep 2026 15:57:47 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:57:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 7/7] hfsplus: switch address_space_operations on
 iomap-based support
Message-ID: <20260918135747.GA18697@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-8-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-8-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 04:39:41PM -0700, Viacheslav Dubeyko wrote:
>  /* Compare two extents keys, returns 0 on same, pos/neg for difference */
>  int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
> @@ -275,6 +276,8 @@ int hfsplus_map_extent(struct inode *inode, u32 ablock, int create,
>  		*max_blocks = hfsplus_ext_find_block(hip->first_extents,
>  						     ablock,
>  						     dblock);
> +		if (!*max_blocks)
> +			return -EIO;

What is this for?  It feels like something that should go into a
well-documented prep patch.

> @@ -342,7 +348,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  
>  	if (create) {
>  		set_buffer_new(bh_result);
> -		hip->phys_size += sb->s_blocksize;
> +		hip->phys_size = (loff_t)(iblock + 1) << sb->s_blocksize_bits;

How is this change related to iomap?

>  	if (inode->i_size > hip->phys_size) {
> -		struct address_space *mapping = inode->i_mapping;
> -		struct folio *folio;
> -		void *fsdata = NULL;
> -		loff_t size = inode->i_size;
> +		if (S_ISREG(inode->i_mode)) {
> +			res = hfsplus_iomap_cont_expand(inode, hip->phys_size,
> +							inode->i_size);
> +			if (res)
> +				return;
> +
> +			mark_inode_dirty(inode);
> +		} else {
> +			struct address_space *mapping = inode->i_mapping;
> +			struct folio *folio;
> +			void *fsdata = NULL;
> +
> +			res = hfsplus_write_begin(NULL, mapping,
> +						  inode->i_size, 0,
> +						  &folio, &fsdata);
> +			if (res)
> +				return;
> +
> +			res = generic_write_end(NULL, mapping,
> +						inode->i_size, 0, 0,
> +						folio, fsdata);
> +			if (res < 0)
> +				return;
> +
> +			mark_inode_dirty(inode);
> +		}

Is this for symlinks?  Any reason you can't pull in

  iomap: add iomap_symlink_write

that has been posted on fsdevel and use iomap for symlinks as well?

