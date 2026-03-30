Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FD395DA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852706; cv=none; b=A6x4aoTMjf2cWxR5q0H9nzNJf8xnTcUcdtDrQHFxxlc+Q+viMpLILu7Oa7O8TQOl4bAfVmrwo3vm3kBUUR0BpvdAKyFLbwqbpx4IoLVjJnPAwl4zV/nSGzgbeHDE+vPX80oVfzKjtJVWJS3XNcUUVEy4OdjT+teBgKdZS1FSQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852706; c=relaxed/simple;
	bh=J7ZJrC+sjPz6DrVD9daqFfgQfAEmebijPrnYgul25CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQkTroUQKlD6j7CKvLmnTfXXFo42gjmjGD2bKcltNqmsr279FzzWyT8XrUjt9g3A2Rriqyg+iaaxrC1VB7kQbdN+RMMLU9iPULs5FBZuo4+zKMv79mc3eKzkVOw/Ew5E7Xy1dahyzc2k1ohH6wfIb9hvxUUbdk5WZNM7uxSmXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F8BC68BFE; Mon, 30 Mar 2026 08:38:21 +0200 (CEST)
Date: Mon, 30 Mar 2026 08:38:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
Message-ID: <20260330063821.GC5897@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326115045.9525-4-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> -#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
> +#define EXFAT_CLU_TO_B(b, sbi)		((loff_t)(b) << (sbi)->cluster_size_bits)

This should be a prep patch.

>  	if ((attr->ia_valid & ATTR_SIZE) &&
>  	    attr->ia_size > i_size_read(inode)) {
> +		loff_t old_size = i_size_read(inode);
> +
>  		error = exfat_cont_expand(inode, attr->ia_size);
> +		if (!error && attr->ia_size > old_size &&
> +		    old_size % PAGE_SIZE != 0) {
> +			loff_t len = min_t(loff_t,
> +					round_up(old_size, PAGE_SIZE) - old_size,
> +					attr->ia_size - old_size);
> +			error = iomap_zero_range(inode, old_size, len,
> +					NULL, &exfat_read_iomap_ops,
> +					&exfat_iomap_folio_ops, NULL);
> +		}

Why is this needed for iomap?  Shouldn't explicit zeroing on size change
be a prep patch?

>  	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
>  		return -EIO;
>  
> -	err = __generic_file_fsync(filp, start, end, datasync);
> +	err = file_write_and_wait_range(filp, start, end);
>  	if (err)
>  		return err;
>  
> +	if (!datasync)
> +		err = __exfat_write_inode(inode, 1);
> +	write_inode_now(inode, !datasync);

This seems to have lost the i_state check to see if a sync
is needed before __exfat_write_inode.  Also doing write_inode_now
plus the explicit inode sync seems duplicate.  Last but not least
I don't understand how this is related to iomap?

> +	ssize_t ret;
> +
> +	ret = iomap_dio_rw(iocb, from, &exfat_write_iomap_ops,
> +			&exfat_write_dio_ops, 0, NULL, 0);
> +	if (ret == -ENOTBLK)
> +		ret = 0;
> +	else if (ret < 0)
> +		goto out;
> +
> +	if (iov_iter_count(from)) {
> +		loff_t offset, end;
> +		ssize_t written;
> +		int ret2;
> +
> +		offset = iocb->ki_pos;
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		written = iomap_file_buffered_write(iocb, from,
> +				&exfat_write_iomap_ops, &exfat_iomap_folio_ops,
> +				NULL);
> +		if (written < 0) {
> +			ret = written;
> +			goto out;
> +		}
> +
> +		ret += written;
> +		end = iocb->ki_pos + written - 1;
> +		ret2 = filemap_write_and_wait_range(iocb->ki_filp->f_mapping,
> +				offset, end);
> +		if (ret2) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +		if (!ret2)
> +			invalidate_mapping_pages(iocb->ki_filp->f_mapping,
> +					offset >> PAGE_SHIFT,
> +					end >> PAGE_SHIFT);
> +	}

Eventually we should factor this code int oa common helper.  Not needed
for this submission, though.

>  {
> -	int err;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> -	struct exfat_inode_info *ei = EXFAT_I(inode);
> -	loff_t new_valid_size;
> +	vm_fault_t ret;
>  
>  	if (!inode_trylock(inode))
>  		return VM_FAULT_RETRY;
>  
> -	new_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
> -	new_valid_size = min(new_valid_size, i_size_read(inode));
> -
> -	if (ei->valid_size < new_valid_size) {
> -		err = exfat_extend_valid_size(inode, new_valid_size, false);

Why is this moving out?  I think the zeroing changes in this patch
are really something that should be split out and explained in the
commit log for better understanding and bisectability.

> +static int exfat_file_open(struct inode *inode, struct file *filp)
> +{
> +	int err;
> +
> +	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> +		return -EIO;

This doesn't look iomap-related.

> +
> +	err = generic_file_open(inode, filp);
> +	if (err)
> +		return err;
> +
> +	filp->f_mode |= FMODE_CAN_ODIRECT;

This should go into the previous patch.

