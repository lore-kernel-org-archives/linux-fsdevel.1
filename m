Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA83A782F;
	Wed, 13 May 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702603; cv=none; b=rvq8OLO8RyzfQQYr/cpEAuFFlUphbu9BVdWXPS3/AsDGDJmOu/9pECiyt+lNKB0xuMcPrJBTwp/bBj1T+1qUAXif8ri+X24Yr3m2NqRx8Aq6mCWnwsDr8E5/36IIcY+wdsIxd//76gyikJBoeoSoxYiFSY31qdyrQGW3t7mGZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702603; c=relaxed/simple;
	bh=oHFpqXxFjRgaX2WjZSUjZFrZB+VcyYrq17R7zHFSsHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdDoHo8rKx2KAcR4lhmjRzKo5LJfBjhkW5fDScnMb4jvWEFMCTL6syBVOreMh0qphPk1AaAUjQNaW38f4RsFkZnkCMP6DVFZHib72FtJUv2qwNo7ZPal3dnj0zfULYDM+lFyL31TGUbPriewIF7rasRqv2C8BScD4WDi0a+Bl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edSoo6q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edSoo6q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E63C19425;
	Wed, 13 May 2026 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702603;
	bh=oHFpqXxFjRgaX2WjZSUjZFrZB+VcyYrq17R7zHFSsHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edSoo6q3lYOIz7jtD4HPovsRbcc59CJnZr+/MmLtn8Qgb3gRTR+rru1zA85eZMuhg
	 kaZJTK5Br7Meiz/UPbjN7iKY1L24/vOWHWeG5tVrRAg81xij9Q8Y/cBKmE+l5usVaY
	 9wd6zhNmiJ6AY09if6p3t88wviVzwr5b6hdGPvrxm2eQQbKhPaasQrvGR/NAr3TM50
	 pmctI0Y+cGdt1B9bS2erTuoe6NZX6pWEMXeiZDmes9ZRg1hryPAe2mYfYeykeHb6U3
	 G9Bk2C+yaxg8kJyWrXAHyeolhLgJQ9uFE36+70ggb3RsO1fxHO75NnfsTSkqHjgDeS
	 HJBNLE6t9bstg==
Date: Wed, 13 May 2026 13:03:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 26/33] fuse: implement inline data file IO via iomap
Message-ID: <20260513200322.GP9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205707.4101881.7117774253873164905.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205707.4101881.7117774253873164905.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:30:28AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
> in response to an inline data mapping.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.c |  213 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 205 insertions(+), 8 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index 807d84a2139362..b9531ad5ab5180 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -398,6 +398,156 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
>  	return ret;
>  }
>  
> +static inline int fuse_iomap_inline_alloc(struct iomap *iomap)
> +{
> +	ASSERT(iomap->inline_data == NULL);
> +	ASSERT(iomap->length > 0);
> +
> +	iomap->inline_data = kvzalloc(iomap->length, GFP_KERNEL);
> +	return iomap->inline_data ? 0 : -ENOMEM;
> +}
> +
> +static inline void fuse_iomap_inline_free(struct iomap *iomap)
> +{
> +	kvfree(iomap->inline_data);
> +	iomap->inline_data = NULL;
> +}
> +
> +/*
> + * Use the FUSE_READ command to read inline file data from the fuse server.
> + * Note that there's no file handle attached, so the fuse server must be able
> + * to reconnect to the inode via the nodeid.
> + */
> +static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
> +				  loff_t count, struct iomap *iomap)
> +{
> +	struct fuse_read_in in = {
> +		.offset = pos,
> +		.size = count,
> +	};
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	FUSE_ARGS(args);
> +	ssize_t ret;
> +
> +	if (BAD_DATA(!iomap_inline_data_valid(iomap))) {
> +		fuse_iomap_inline_free(iomap);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	args.opcode = FUSE_READ;
> +	args.nodeid = fi->nodeid;
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(in);
> +	args.in_args[0].value = &in;
> +	args.out_argvar = true;
> +	args.out_numargs = 1;
> +	args.out_args[0].size = count;

Codex reminds me that it's possible for count > iomap->length, which
means that we can arbitrarily overwrite kernel memory here.

> +	args.out_args[0].value = iomap_inline_data(iomap, pos);
> +
> +	ret = fuse_simple_request(fm, &args);
> +	if (ret == -ENOSYS)
> +		ret = 0;
> +	if (ret < 0) {
> +		fuse_iomap_inline_free(iomap);
> +		return ret;
> +	}
> +	/* no readahead means something bad happened */
> +	if (ret == 0) {
> +		fuse_iomap_inline_free(iomap);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Use the FUSE_WRITE command to write inline file data from the fuse server.
> + * Note that there's no file handle attached, so the fuse server must be able
> + * to reconnect to the inode via the nodeid.
> + */
> +static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
> +				   loff_t count, struct iomap *iomap)
> +{
> +	struct fuse_write_in in = {
> +		.offset = pos,
> +		.size = count,
> +	};
> +	struct fuse_write_out out = { };
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	FUSE_ARGS(args);
> +	ssize_t ret;
> +
> +	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
> +		return -EFSCORRUPTED;
> +
> +	args.opcode = FUSE_WRITE;
> +	args.nodeid = fi->nodeid;
> +	args.in_numargs = 2;
> +	args.in_args[0].size = sizeof(in);
> +	args.in_args[0].value = &in;
> +	args.in_args[1].size = count;

Here too.

> +	args.in_args[1].value = iomap_inline_data(iomap, pos);
> +	args.out_numargs = 1;
> +	args.out_args[0].size = sizeof(out);
> +	args.out_args[0].value = &out;
> +
> +	ret = fuse_simple_request(fm, &args);
> +	if (ret == -ENOSYS)
> +		ret = 0;
> +	if (ret < 0) {
> +		fuse_iomap_inline_free(iomap);
> +		return ret;
> +	}
> +	/* short write means something bad happened */
> +	if (out.size < count) {
> +		fuse_iomap_inline_free(iomap);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Set up inline data buffers for iomap_begin */
> +static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
> +				 loff_t pos, loff_t count,
> +				 struct iomap *iomap, struct iomap *srcmap)
> +{
> +	int err;
> +
> +	if (opflags & IOMAP_REPORT)
> +		return 0;
> +
> +	if (fuse_is_iomap_file_write(opflags)) {
> +		if (iomap->type == IOMAP_INLINE) {
> +			err = fuse_iomap_inline_alloc(iomap);
> +			if (err)
> +				return err;
> +		}
> +
> +		if (srcmap->type == IOMAP_INLINE) {
> +			err = fuse_iomap_inline_alloc(srcmap);
> +			if (!err)
> +				err = fuse_iomap_inline_read(inode, pos, count,
> +							     srcmap);
> +			if (err) {
> +				fuse_iomap_inline_free(iomap);
> +				return err;
> +			}
> +		}

Just from code inspection this fails to handle a pure overwrite of
inline data correctly if the inline file data wasn't already in cache
and the write was to a subset of the file data.

> +	} else if (iomap->type == IOMAP_INLINE) {
> +		/* inline data read */
> +		err = fuse_iomap_inline_alloc(iomap);
> +		if (!err)
> +			err = fuse_iomap_inline_read(inode, pos, count, iomap);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
>  			    unsigned opflags, struct iomap *iomap,
>  			    struct iomap *srcmap)
> @@ -467,12 +617,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
>  		fuse_iomap_from_server(iomap, read_dev, &outarg.read);
>  	}
>  
> +	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
> +		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
> +					    srcmap);
> +		if (err)
> +			goto out_write_dev;
> +	}
> +
>  	/*
>  	 * XXX: if we ever want to support closing devices, we need a way to
>  	 * track the fuse_backing refcount all the way through bio endios.
>  	 * For now we put the refcount here because you can't remove an iomap
>  	 * device until unmount time.
>  	 */
> +out_write_dev:
>  	fuse_backing_put(write_dev);
>  out_read_dev:
>  	fuse_backing_put(read_dev);
> @@ -511,8 +669,32 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_mount *fm = get_fuse_mount(inode);
> +	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
> +	struct iomap *srcmap = &iter->srcmap;
>  	int err;
>  
> +	if (srcmap->inline_data)
> +		fuse_iomap_inline_free(srcmap);
> +
> +	if (iomap->inline_data) {
> +		if (fuse_is_iomap_file_write(opflags) && written > 0) {
> +			err = fuse_iomap_inline_write(inode, pos, written,
> +						      iomap);
> +			fuse_iomap_inline_free(iomap);
> +			if (err)
> +				return err;
> +
> +			spin_lock(&fi->lock);
> +			fi->i_disk_size = max(fi->i_disk_size, pos + written);
> +			spin_unlock(&fi->lock);
> +		} else {
> +			fuse_iomap_inline_free(iomap);
> +		}
> +
> +		/* fuse server should already be aware of what happened */
> +		return 0;
> +	}
> +
>  	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
>  		struct fuse_iomap_end_in inarg = {
>  			.opflags = fuse_iomap_op_to_server(opflags),
> @@ -1462,7 +1644,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  					  unsigned int len, u64 end_pos)
>  {
>  	struct inode *inode = wpc->inode;
> -	struct iomap write_iomap, dontcare;
>  	ssize_t ret;
>  
>  	if (fuse_is_bad(inode)) {
> @@ -1475,23 +1656,39 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
>  
>  	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
> +		struct iomap_iter fake_iter = { };
> +		struct iomap *write_iomap = &fake_iter.iomap;
> +
>  		ret = fuse_iomap_begin(inode, offset, len,
> -				       FUSE_IOMAP_OP_WRITEBACK,
> -				       &write_iomap, &dontcare);
> +				       FUSE_IOMAP_OP_WRITEBACK, write_iomap,
> +				       &fake_iter.srcmap);
>  		if (ret)
>  			goto discard_folio;
>  
> +		if (BAD_DATA(write_iomap->type == IOMAP_INLINE)) {
> +			/*
> +			 * iomap assumes that inline data writes are completed
> +			 * by the time ->iomap_end completes, so it should
> +			 * never mark a pagecache folio dirty.
> +			 */
> +			fuse_iomap_end(inode, offset, len, 0,
> +				       FUSE_IOMAP_OP_WRITEBACK,
> +				       write_iomap);
> +			ret = -EIO;
> +			goto discard_folio;
> +		}
> +
>  		/*
>  		 * Landed in a hole or beyond EOF?  Send that to iomap, it'll
>  		 * skip writing back the file range.
>  		 */
> -		if (write_iomap.offset > offset) {
> -			write_iomap.length = write_iomap.offset - offset;
> -			write_iomap.offset = offset;
> -			write_iomap.type = IOMAP_HOLE;
> +		if (write_iomap->offset > offset) {
> +			write_iomap->length = write_iomap->offset - offset;
> +			write_iomap->offset = offset;
> +			write_iomap->type = IOMAP_HOLE;
>  		}
>  
> -		memcpy(&wpc->iomap, &write_iomap, sizeof(struct iomap));
> +		memcpy(&wpc->iomap, write_iomap, sizeof(struct iomap));

If the srcmap was inline, then we just leaked the buffer here by
forgetting to call fuse_iomap_end.  But I think a better option now
would be to use the conventional iomap_iter loop that everything else
does:

	struct iomap_iter iter = {
		.inode		= inode,
		.pos		= offset,
		.len		= len,
		.flags		= FUSE_IOMAP_OP_WRITEBACK,
	};

	while ((ret = iomap_iter(&iter, ops)) > 0) {
		memcpy(&wpc->iomap, &iter.iomap, sizeof(struct iomap));
		iomap_iter_advance(&iter, iomap_length(&iter));
		iter.status = -ECANCELED;
	}
	if (ret < 0 && ret != -ECANCELED)
		goto discard_folio;

--D

>  	}
>  
>  	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> 
> 
