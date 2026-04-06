Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FB37107E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775480989; cv=none; b=E3gzdXVXqkYBGckWeQ2nw77jNNdcGAoDjA2CGeHGv4+UPYrxF9mh3sDPGylz7Al4VKzjEF9A5ysjMD7D/Wa8f2G85EQzUrQqPDzzzmIhPbcc+Ef0DUrD6c5cToHloUM8FxOtzLIELlsjr/fkTVy8VotLKpjzHZ3niCAbsQccUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775480989; c=relaxed/simple;
	bh=nHHJCyocQW/NMjnxuNLq+t95fxnJmhuaOHrB3ATOz0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7bPUZiz+Z8FqGN6h8ZNV2RrGCFR5ASLuffo8DaErQuVN+iYuGAjLeiE3yPNAM5luIwqf9YFlGZNkuGsldnsK20s/j6UOAD4nMz5rj8mzd5O/qCDnShplsWxACG47+dDncqdQmKbGsib8FY3+yO48uFXEsWSAi9ivXUklgSAIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=SzxfUJNN; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="SzxfUJNN"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 85AA61CBC2;
	Mon,  6 Apr 2026 13:09:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 85AA61CBC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1775480985; bh=nHHJCyocQW/NMjnxuNLq+t95fxnJmhuaOHrB3ATOz0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzxfUJNNkc+7OtrWIv9p/S08VBe5yc2eG1REDdv2yvowdacb6JIzBL9X4rRCMbYPV
	 2TqrPh7gWmfFd5mOc/atp7aVOm0EjuLehLFIkHKhOVv2P6k/w6FYVdyO/YCsvZiseS
	 8VDuMf4DxDO64P32uNh8RzIRdlTnrQiDDLZT+e54=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 5uMwDpiw02m6Zg4A8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 06 Apr 2026 13:09:44 +0000
Message-ID: <149dabc5-5e88-4589-aec6-fd22925ce974@dev.snart.me>
Date: Mon, 6 Apr 2026 22:09:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, hch@lst.de,
 chizhiling@163.com
References: <20260326115045.9525-1-linkinjeon@kernel.org>
 <20260326115045.9525-4-linkinjeon@kernel.org>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260326115045.9525-4-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 20:50, Namjae Jeon wrote:
> Add full buffered I/O support using the iomap framework to the exfat
> filesystem. This replaces the old exfat_get_block(), exfat_write_begin(),
> exfat_write_end(), and exfat_block_truncate_page() functions with their
> iomap equivalents. Buffered writes now use iomap_file_buffered_write(),
> read uses iomap_bio_read_folio() and iomap_bio_readahead(), and writeback
> is handled through iomap_writepages().
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/exfat_fs.h |   3 +-
>  fs/exfat/file.c     | 160 +++++++++++++++++++--------
>  fs/exfat/inode.c    | 261 ++++----------------------------------------
>  3 files changed, 142 insertions(+), 282 deletions(-)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 860f2e438b63..54da001a8f55 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -87,7 +87,7 @@ enum {
>  /*
>   * helpers for cluster size to byte conversion.
>   */
> -#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
> +#define EXFAT_CLU_TO_B(b, sbi)		((loff_t)(b) << (sbi)->cluster_size_bits)

I think type casting should be left to the users of the macro. These
helper macros are quite dangerous in case of (ex)FAT because integer
overflows are unchecked for shift op. The on-disk format is 32 bit but
the kernel has switched over to "all-64-bit".

That particular macro is used in dirent update code and, in particular,
in exfat_map_cluster():

    inode->i_blocks += EXFAT_CLU_TO_B(num_to_be_allocated, sbi) >> 9;

The type of i_blocks is blkcnt_t, which is unsigned. loff_t is signed.
exFAT got away with it because Linux write calls expand the size of
files no more than 0x7ffff000 bytes and the size of dir is limited to
256MB. However, someone could come in and decide to use
exfat_map_cluster() to allocate more than this limit.

I don't think we can win because of the inherent discrepency between the
on-disk format and the kernel interface. How the calculated value is
used cannot be safely assumed.

>  #define EXFAT_B_TO_CLU(b, sbi)		((b) >> (sbi)->cluster_size_bits)
>  #define EXFAT_B_TO_CLU_ROUND_UP(b, sbi)	\
>  	(((b - 1) >> (sbi)->cluster_size_bits) + 1)
> @@ -551,7 +551,6 @@ struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
>  int __exfat_write_inode(struct inode *inode, int sync);
>  int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
>  void exfat_evict_inode(struct inode *inode);
> -int exfat_block_truncate_page(struct inode *inode, loff_t from);
>  int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  		unsigned int *clu, unsigned int *count, int create,
>  		bool *balloc);
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 2a9263b4433b..5f85e2e0a71e 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -337,7 +337,18 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
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
>  		if (error || attr->ia_valid == ATTR_SIZE)
>  			return error;
>  		attr->ia_valid &= ~ATTR_SIZE;
> @@ -384,7 +395,10 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	exfat_truncate_inode_atime(inode);
>  
>  	if (attr->ia_valid & ATTR_SIZE) {
> -		error = exfat_block_truncate_page(inode, attr->ia_size);
> +		inode_dio_wait(inode);
> +		error = iomap_truncate_page(inode, attr->ia_size, NULL,
> +				&exfat_read_iomap_ops,
> +				&exfat_iomap_folio_ops, NULL);
>  		if (error)
>  			goto out;
>  
> @@ -619,10 +633,14 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
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
> +
>  	err = sync_blockdev(inode->i_sb->s_bdev);
>  	if (err)
>  		return err;
> @@ -648,12 +666,56 @@ int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync)
>  				NULL);
>  		if (!ret && bsync)
>  			ret = filemap_write_and_wait_range(inode->i_mapping,
> -					old_valid_size, off - 1);
> +							   old_valid_size,
> +							   off - 1);
>  	}
>  
>  	return ret;
>  }
>  
> +static ssize_t exfat_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
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
> +out:
> +	return ret;
> +}

There's nothing to clean up upon error here. Suggest removing goto. I
noticed that gotos are generally removed where appropriate in this
serious of patches, but it looks like you've missed this bit.

