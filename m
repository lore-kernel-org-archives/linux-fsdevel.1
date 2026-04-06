Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17714258EFF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483140; cv=none; b=aSgvyoTD7A1SxzPS89ONaWZYIa3XXGUO8Euz2QGnuPSyZE0Kyi4wsOdsu4uYnchI35yY81gv+d9b+pRm6lrUjRZyPhsvyQ6N9dicvyYKiNpBRktSDXhqnJQIKLX0gzggf1McCuoAjLVJUm/QZLjEXtUoXMm+iB1z844SudyTRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483140; c=relaxed/simple;
	bh=CGsE1k9RAQ6gmkP4qv2bwAxuFXtdvvqitwyx0KsRKAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXHzgbpa78R9ySV0yEMhu+VdjB242+I7xtQ1wiW1X6W+M/DbTs3kRuZrajkxwBfRlQ79kfP8QcATuOhHy3oSgxtPan58D5lhcEcP61f56teBulsffkI/Wrn0ewE1g4R02n4O0nzN5Hj9u5HujWGXpjmUBewu3wEQ6yveuDW+43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=PWLhYbO+; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="PWLhYbO+"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 65DAC1CBC2;
	Mon,  6 Apr 2026 13:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 65DAC1CBC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1775483137; bh=CGsE1k9RAQ6gmkP4qv2bwAxuFXtdvvqitwyx0KsRKAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWLhYbO+jPIaSvPIIvah2PsAQfeDQ/Bn1yaXdbFFfzuiv0G1hebSUmJIHfnF8j67C
	 vK+JwFO58B6nDePaiOYBhKC5WkpR1Or5oPpdh/PnDhgACKhoyBsImwrd3E6V71a3Qr
	 gC/7+ujRIYXz6sJS82SDvUzQpgLZHeAb02CIGc7w=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id /XFvBgC502n9aA4A8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 06 Apr 2026 13:45:36 +0000
Message-ID: <c811de47-a69d-4b18-a4b8-1f274a0f0e8d@dev.snart.me>
Date: Mon, 6 Apr 2026 22:45:35 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
 chizhiling@kylinos.cn, hch@lst.de
References: <20260326115045.9525-1-linkinjeon@kernel.org>
 <20260326115045.9525-2-linkinjeon@kernel.org>
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
In-Reply-To: <20260326115045.9525-2-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 20:50, Namjae Jeon wrote:
> Add iomap support to the exfat filesystem. This patch introduces the
> necessary iomap infrastructure by adding a new iomap.c file and related
> iomap operations. The main change is converting exfat_extend_valid_size()
> to use iomap_zero_range() instead of the legacy write_begin/write_end path.
> To support this, exfat_map_cluster() is extended to return whether a new
> cluster was allocated via a balloc flag, and a new helper function
> exfat_cluster_to_phys() is added. Also, data_start_bytes is added to
> struct exfat_sb_info for easier conversion from cluster number to physical
> byte offset.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/Makefile   |   2 +-
>  fs/exfat/exfat_fs.h |  12 ++
>  fs/exfat/file.c     |  54 +++-----
>  fs/exfat/inode.c    |   9 +-
>  fs/exfat/iomap.c    | 305 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/iomap.h    |  16 +++
>  fs/exfat/super.c    |   1 +
>  7 files changed, 361 insertions(+), 38 deletions(-)
>  create mode 100644 fs/exfat/iomap.c
>  create mode 100644 fs/exfat/iomap.h
> 
> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
> index ed51926a4971..e06bf85870ae 100644
> --- a/fs/exfat/Makefile
> +++ b/fs/exfat/Makefile
> @@ -5,4 +5,4 @@
>  obj-$(CONFIG_EXFAT_FS) += exfat.o
>  
>  exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
> -	   file.o balloc.o
> +	   file.o balloc.o iomap.o
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 9fed9fb33cae..860f2e438b63 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -259,6 +259,7 @@ struct exfat_sb_info {
>  	unsigned long long FAT1_start_sector; /* FAT1 start sector */
>  	unsigned long long FAT2_start_sector; /* FAT2 start sector */
>  	unsigned long long data_start_sector; /* data area start sector */
> +	unsigned long long data_start_bytes;
>  	unsigned int num_FAT_sectors; /* num of FAT sectors */
>  	unsigned int root_dir; /* root dir cluster */
>  	unsigned int dentries_per_clu; /* num of dentries per cluster */
> @@ -432,6 +433,13 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
>  	return ((loff_t)inode->i_blocks) << 9;
>  }
>  
> +static inline loff_t exfat_cluster_to_phys(struct exfat_sb_info *sbi,
> +		unsigned int clus)
> +{
> +	return ((loff_t)(clus - EXFAT_RESERVED_CLUSTERS) << sbi->cluster_size_bits) +
> +		sbi->data_start_bytes;
> +}
> +
>  /* super.c */
>  int exfat_set_volume_dirty(struct super_block *sb);
>  int exfat_clear_volume_dirty(struct super_block *sb);
> @@ -480,6 +488,7 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
>  				unsigned long arg);
>  int exfat_force_shutdown(struct super_block *sb, u32 flags);
> +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync);
>  
>  /* namei.c */
>  extern const struct dentry_operations exfat_dentry_ops;
> @@ -543,6 +552,9 @@ int __exfat_write_inode(struct inode *inode, int sync);
>  int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
>  void exfat_evict_inode(struct inode *inode);
>  int exfat_block_truncate_page(struct inode *inode, loff_t from);
> +int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> +		unsigned int *clu, unsigned int *count, int create,
> +		bool *balloc);
>  
>  /* exfat/nls.c */
>  unsigned short exfat_toupper(struct super_block *sb, unsigned short a);
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 2daf0dbabb24..756846b774c4 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -14,9 +14,11 @@
>  #include <linux/writeback.h>
>  #include <linux/filelock.h>
>  #include <linux/falloc.h>
> +#include <linux/iomap.h>
>  
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> +#include "iomap.h"
>  
>  static int exfat_cont_expand(struct inode *inode, loff_t size)
>  {
> @@ -628,44 +630,28 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  	return blkdev_issue_flush(inode->i_sb->s_bdev);
>  }
>  
> -static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
> +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync)
>  {
> -	int err;
> -	loff_t pos;
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
> -	struct address_space *mapping = inode->i_mapping;
> -	const struct address_space_operations *ops = mapping->a_ops;
> -
> -	pos = ei->valid_size;
> -	while (pos < new_valid_size) {
> -		u32 len;
> -		struct folio *folio;
> -		unsigned long off;
> -
> -		len = PAGE_SIZE - (pos & (PAGE_SIZE - 1));
> -		if (pos + len > new_valid_size)
> -			len = new_valid_size - pos;
> -
> -		err = ops->write_begin(NULL, mapping, pos, len, &folio, NULL);
> -		if (err)
> -			goto out;
> -
> -		off = offset_in_folio(folio, pos);
> -		folio_zero_new_buffers(folio, off, off + len);
> +	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
> +	loff_t old_valid_size;
> +	int ret = 0;
>  
> -		err = ops->write_end(NULL, mapping, pos, len, len, folio, NULL);
> -		if (err < 0)
> -			goto out;
> -		pos += len;
> +	mutex_lock(&sbi->s_lock);
> +	old_valid_size = ei->valid_size;
> +	mutex_unlock(&sbi->s_lock);
>  
> -		balance_dirty_pages_ratelimited(mapping);
> -		cond_resched();
> +	if (old_valid_size < off) {
> +		ret = iomap_zero_range(inode, old_valid_size,
> +				off - old_valid_size, NULL,
> +				&exfat_write_iomap_ops, &exfat_iomap_folio_ops,
> +				NULL);
> +		if (!ret && bsync)
> +			ret = filemap_write_and_wait_range(inode->i_mapping,
> +					old_valid_size, off - 1);
>  	}
>  
> -	return 0;
> -
> -out:
> -	return err;
> +	return ret;
>  }
>  
>  static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> @@ -702,7 +688,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	}
>  
>  	if (pos > valid_size) {
> -		ret = exfat_extend_valid_size(inode, pos);
> +		ret = exfat_extend_valid_size(inode, pos, false);
>  		if (ret < 0 && ret != -ENOSPC) {
>  			exfat_err(inode->i_sb,
>  				"write: fail to zero from %llu to %llu(%zd)",
> @@ -760,7 +746,7 @@ static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
>  	new_valid_size = min(new_valid_size, i_size_read(inode));
>  
>  	if (ei->valid_size < new_valid_size) {
> -		err = exfat_extend_valid_size(inode, new_valid_size);
> +		err = exfat_extend_valid_size(inode, new_valid_size, false);
>  		if (err < 0) {
>  			inode_unlock(inode);
>  			return vmf_fs_error(err);
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index beb9ea7cca9f..cc54cce65a31 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -123,8 +123,9 @@ void exfat_sync_inode(struct inode *inode)
>   * Output: errcode, cluster number
>   * *clu = (~0), if it's unable to allocate a new cluster
>   */
> -static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> -		unsigned int *clu, unsigned int *count, int create)
> +int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> +		unsigned int *clu, unsigned int *count, int create,
> +		bool *balloc)
>  {
>  	int ret;
>  	unsigned int last_clu;
> @@ -235,6 +236,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  			}
>  		}
>  		*count = 1;
> +		*balloc = true;
>  	}
>  
>  	/* hint information */
> @@ -258,6 +260,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>  	sector_t phys = 0;
>  	sector_t valid_blks;
>  	loff_t i_size;
> +	bool balloc;
>  
>  	mutex_lock(&sbi->s_lock);
>  	i_size = i_size_read(inode);
> @@ -268,7 +271,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>  	/* Is this block already allocated? */
>  	count = EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
>  	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
> -			&cluster, &count, create);
> +			&cluster, &count, create, &balloc);
>  	if (err) {
>  		if (err != -ENOSPC)
>  			exfat_fs_error_ratelimit(sb,
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> new file mode 100644
> index 000000000000..e4135a13454f
> --- /dev/null
> +++ b/fs/exfat/iomap.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * iomap callack functions
> + *
> + * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
> + */
> +
> +#include <linux/iomap.h>
> +#include <linux/pagemap.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +#include "iomap.h"
> +
> +/*
> + * exfat_iomap_put_folio - Put folio after iomap operation
> + *
> + * Called when iomap is finished with a folio zero-fills portions of
> + * the folio beyond ->valid_size to prevent exposing uninitialized data.
> + */
> +static void exfat_iomap_put_folio(struct inode *inode, loff_t pos,
> +		unsigned int len, struct folio *folio)
> +{
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
> +	unsigned long sector_size = 1UL << inode->i_blkbits;
> +	loff_t start_down, end_up, init;
> +
> +	mutex_lock(&sbi->s_lock);
> +	start_down = round_down(pos, sector_size);
> +	end_up = (pos + len - 1) | (sector_size - 1);
> +	init = ei->valid_size;
> +
> +	if (init >= start_down && init <= end_up) {
> +		if (init < pos) {
> +			loff_t offset = offset_in_folio(folio, pos + len);
> +
> +			if (offset == 0)
> +				offset = folio_size(folio);
> +			folio_zero_segments(folio,
> +					offset_in_folio(folio, init),
> +					offset_in_folio(folio, pos),
> +					offset,
> +					folio_size(folio));
> +
> +		} else  {
> +			loff_t offset = max_t(loff_t, pos + len, init);
> +
> +			offset = offset_in_folio(folio, offset);
> +			if (offset == 0)
> +				offset = folio_size(folio);
> +			folio_zero_segment(folio,
> +					offset,
> +					folio_size(folio));
> +		}
> +	} else if (init <= pos) {
> +		loff_t offset = 0, offset2 = offset_in_folio(folio, pos + len);
> +
> +		if ((init >> folio_shift(folio)) == (pos >> folio_shift(folio)))
> +			offset = offset_in_folio(folio, init);
> +		if (offset2 == 0)
> +			offset2 = folio_size(folio);
> +		folio_zero_segments(folio,
> +				offset,
> +				offset_in_folio(folio, pos),
> +				offset2,
> +				folio_size(folio));
> +	}
> +
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	mutex_unlock(&sbi->s_lock);
> +}
> +
> +const struct iomap_write_ops exfat_iomap_folio_ops = {
> +	.put_folio = exfat_iomap_put_folio,
> +};
> +
> +/*
> + * exfat_file_write_dio_end_io - Direct I/O write completion handler
> + *
> + * Updates i_size if the write extended the file. Called from the dio layer
> + * after I/O completion.
> + */
> +static int exfat_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
> +		int error, unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +
> +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> +		i_size_write(inode, iocb->ki_pos + size);
> +		mark_inode_dirty(inode);
> +	}
> +
> +	return 0;
> +}
> +
> +const struct iomap_dio_ops exfat_write_dio_ops = {
> +	.end_io		= exfat_file_write_dio_end_io,
> +};
> +
> +/*
> + * exfat_read_iomap_begin - Begin mapping for reads
> + *
> + * Maps file range to disk location for read operations (read folio,
> + * readahead, direct I/O read, etc.).
> + *
> + * Returns IOMAP_MAPPED for areas within ->valid_size, and IOMAP_UNWRITTEN
> + * for allocated but uninitialized regions beyond ->valid_size.
> + */
> +static int exfat_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	unsigned int cluster, num_clusters = EXFAT_B_TO_CLU_ROUND_UP(length, sbi);
> +	loff_t cluster_offset, cluster_length;
> +	int err = 0;
> +	bool balloc = false;
> +
> +	mutex_lock(&sbi->s_lock);
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->offset = offset;
> +
> +	err = exfat_map_cluster(inode, EXFAT_B_TO_CLU(offset, sbi),
> +			&cluster, &num_clusters, false, &balloc);
> +	if (err)
> +		goto out;
> +
> +	cluster_offset = EXFAT_CLU_OFFSET(offset, sbi);
> +	cluster_length = EXFAT_CLU_TO_B(num_clusters, sbi);
> +	if (length > cluster_length - cluster_offset)
> +		iomap->length = cluster_length - cluster_offset;
> +	else
> +		iomap->length = length;
> +
> +	iomap->addr = exfat_cluster_to_phys(sbi, cluster) + cluster_offset;
> +	if (offset >= ei->valid_size)
> +		iomap->type = IOMAP_UNWRITTEN;
> +	else
> +		iomap->type = IOMAP_MAPPED;
> +
> +	if (!(flags & IOMAP_ZERO) && iomap->type == IOMAP_MAPPED &&
> +	    iomap->offset < ei->valid_size &&
> +	    iomap->offset + iomap->length > ei->valid_size) {
> +		iomap->length = round_up(ei->valid_size, 1 << inode->i_blkbits) -
> +			iomap->offset;
> +	}
> +
> +	iomap->flags |= IOMAP_F_MERGED;
> +out:
> +	mutex_unlock(&sbi->s_lock);
> +	return err;
> +}
> +
> +const struct iomap_ops exfat_read_iomap_ops = {
> +	.iomap_begin = exfat_read_iomap_begin,
> +};
> +
> +/*
> + * __exfat_write_iomap_begin - mapping logic for writes
> + *
> + * Maps the requested range and allocates clusters if needed.
> + */
> +static int __exfat_write_iomap_begin(struct inode *inode, loff_t offset,
> +		loff_t length, struct iomap *iomap)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	unsigned int cluster, num_clusters;
> +	loff_t cluster_offset, cluster_length;
> +	int err;
> +	bool balloc = false;
> +
> +	num_clusters = max(EXFAT_B_TO_CLU_ROUND_UP(offset + length, sbi) -
> +		EXFAT_B_TO_CLU_ROUND_UP(offset, sbi), 1);
> +	mutex_lock(&sbi->s_lock);
> +	err = exfat_map_cluster(inode, EXFAT_B_TO_CLU(offset, sbi),
> +			&cluster, &num_clusters, true, &balloc);
> +	if (err)
> +		goto out;
> +
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->offset = offset;
> +
> +	cluster_offset = EXFAT_CLU_OFFSET(offset, sbi);
> +	cluster_length = EXFAT_CLU_TO_B(num_clusters, sbi);
> +	if (length > cluster_length - cluster_offset)
> +		iomap->length = cluster_length - cluster_offset;
> +	else
> +		iomap->length = length;
> +	iomap->addr = exfat_cluster_to_phys(sbi, cluster) + cluster_offset;
> +	iomap->type = IOMAP_MAPPED;
> +	if (balloc)
> +		iomap->flags = IOMAP_F_NEW;
> +out:
> +	mutex_unlock(&sbi->s_lock);
> +	return err;
> +}
> +
> +/*
> + * exfat_write_iomap_begin - Mapping for write operations
> + *
> + * Extends ->valid_size if the write starts beyond current initialized size.
> + * Then performs actual block mapping (possibly allocating clusters).
> + */
> +static int exfat_write_iomap_begin(struct inode *inode, loff_t offset,
> +		loff_t length, unsigned int flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	int ret;
> +
> +	if (EXFAT_I(inode)->valid_size < offset) {
> +		ret = exfat_extend_valid_size(inode, offset,
> +				flags & IOMAP_DIRECT ? true : false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = __exfat_write_iomap_begin(inode, offset, length, iomap);
> +
> +	if (!(flags & IOMAP_DIRECT) && !ret &&
> +	    i_size_read(inode) < iomap->offset + iomap->length) {
> +		i_size_write(inode, iomap->offset + iomap->length);
> +		mark_inode_dirty(inode);
> +	}
> +
> +	return ret;
> +}

Might be a stupid question but, why should this be handled differently
from mkwrite? Also, dirtying the inode here seems redundant. If this is
for the device going away due to power/link failure, I wonder if the
inode would get the chance to be synced between begin() and end() for
this to be effective. Sure, the new clusters are allocated for the
mapping, but before end() is called, what's the point in updating the
isize if there's no data written to the new clusters, yet?

I don't think it matters that much anyways since exFAT is not
journalled. I'm only pointing this out because mark_inode_dirty() is not
a cheap operation.
