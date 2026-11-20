Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158803;
	b=ZEGCj/we+cP56j0Dekbs5+gGDTRQVHaqzvgEE7DZT13co6d9HqKzSISOb5JY5hly31Uo
	 Uv6N3Y8mAk3rqHhkE8bcHLHsEjpQQbH7lmPV67eoL7WK+/37ZbWQQs0LY9E/ox8Ly2yl+
	 ZyVb9usDeHEUJ71IyuybzmKknTZmEeNaq4XRVdGJa7Q+pDn0t8PKdp02kvTJ9J5pBOfHV
	 bZMUPmE3K6DUuNzoXHDevlg9fQ4fU7Ux9wE0TJPGXFr1xnDu/eNGFbgpL+Z9nyllLCqqI
	 auQHJlR55I8pmimqO6wDKx2h7Sunvj/1anf2ClDMF3/id0x53a5rVYMrK+W4fwEJ6sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158803;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kZQzvHKBduvj4k06mztFdI7Vu7rinwTx7rH7toSVvdE=;
	b=0T44NAyR477gikQTjUg7uqErmbNLyMziqtWLj6RokFvpxqRj7E8IP7XFhQ9s8nxwIbkB
	 Cbcyq1acGAq+naHEcI6QEHeLcN3WjcmoROqNkTvRN64Nhf4tvajI0v5dROvXfyOQ31EV0
	 4uvolP+FqDoyS0eNs7+xVWwTX46hDMQv3ekfDjiqmiqjM5Q/433rV9PTWTWlv6bgoq/MC
	 gN9b4P246SD+o5RYaywgnEHvwjz7duQYy/cQCQ7aCkAn2oz3ZIXNPsgM99skqrLcOlI9p
	 qmqLYRO7XjEDaEmFGrcDHRva1sr0xSYDx11wUy3YLL4vWI6+WKaQU9G/Ox5bpApp97g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=ikKENCl5;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+1QAv9C0;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E854606A337;
	Fri, 20 Nov 2026 07:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E854606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=ikKENCl5;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+1QAv9C0
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 3A6D420BD28A;
	Fri, 20 Nov 2026 16:13:19 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1795158799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZQzvHKBduvj4k06mztFdI7Vu7rinwTx7rH7toSVvdE=;
	b=ikKENCl5YGrpax08VQk29Io1r7qye9QDKoNgMYAA1j6zowZdb66GgO0/Y1sOpSTyvqbrZy
	yNwog6YSetHKrEwrilg9Jj6Z1N/l7GBkT5jXoPjNytZR3Ncf06X+oCOxnsMyMhOUTN3cAY
	xKcLshufGnmnL5YL/CUBz2fiZaJnDLqKeCb0CLjzdT2VKUIA6Rj7om+bZc1taTSCNbSSty
	fzQif77ew89Q4kXx8eslqPMVs/3PLQlx/mc120XGyjfPH7jZ8o8X6lJnGpGziRPbIyET+d
	7K0IqAz7POFymQDlSf5marqiGhYoG8mXGzEM7TspxYrG7dYhm0An3BnBhu/A8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1795158799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZQzvHKBduvj4k06mztFdI7Vu7rinwTx7rH7toSVvdE=;
	b=+1QAv9C0sY8yS5PKAXFLSFhuJ9WuicUD6A9DibL/RPvyxviuZR50bYYkxBsqTC3it1lMlH
	buB7xzzmw31pD8Ag==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B605FE00850;
	Fri, 20 Nov 2026 16:13:18 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A49B7220021D; Fri, 20 Nov 2026 16:13:18 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/8] fat: support FIEMAP
In-Reply-To: <20261118020150.1023865-2-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
	<20261118020150.1023865-2-matheus.aalmeida@inf.ufrgs.br>
Date: Fri, 20 Nov 2026 16:13:18 +0900
Message-ID: <87zev4ynzl.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Hi,

https://sashiko.dev/#/patchset/20261118020150.1023865-1-matheus.aalmeida%40inf.ufrgs.br

Looks like there is the review by sashiko. Could you check if you can
find the real bug with it?

(BTW, 5 hour fsx test looks like passed.)

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Implement support for ->fiemap() using iomap_fiemap(). Add a read-only
> fat_iomap_begin() and a fat_get_cont_clusters() helper for finding
> contiguous clusters.

Looks like this is still not working well for range lookup.

E.g.

   - it left { .fcluster = 0, .dcluster = 10, .nr_conrig = 0 } cache
     It adds unnecessary cache for i_start
   - it doesn't use the cache if cache is "cluster < cache.fcluster &&
     cluster+nr_cont >= cache.fcluster" (cache partially hit at latter
     part of looking range)

etc.

I hacked the cache.c to test it easier in userspace to help
something. The attached program (cache-test.tar.gz) may help you to
experiment/test this.

Thanks.


--=-=-=
Content-Type: application/gzip
Content-Disposition: attachment; filename=cache-test.tar.gz
Content-Transfer-Encoding: base64

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
aAEA
--=-=-=
Content-Type: text/plain


>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/Kconfig  |  1 +
>  fs/fat/Makefile |  2 +-
>  fs/fat/cache.c  | 85 +++++++++++++++++++++++++++++++++++++++++--------
>  fs/fat/fat.h    |  5 +++
>  fs/fat/file.c   | 12 +++++++
>  fs/fat/iomap.c  | 73 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 163 insertions(+), 15 deletions(-)
>  create mode 100644 fs/fat/iomap.c
>
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 25fae1c83..d31d7866c 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -2,6 +2,7 @@
>  config FAT_FS
>  	tristate
>  	select BUFFER_HEAD
> +	select FS_IOMAP
>  	select NLS
>  	select LEGACY_DIRECT_IO
>  	help
> diff --git a/fs/fat/Makefile b/fs/fat/Makefile
> index 2b0341126..238668f03 100644
> --- a/fs/fat/Makefile
> +++ b/fs/fat/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_FAT_FS) += fat.o
>  obj-$(CONFIG_VFAT_FS) += vfat.o
>  obj-$(CONFIG_MSDOS_FS) += msdos.o
>  
> -fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o
> +fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o iomap.o
>  vfat-y := namei_vfat.o
>  msdos-y := namei_msdos.o
>  
> diff --git a/fs/fat/cache.c b/fs/fat/cache.c
> index 1b87354e2..18a0bb500 100644
> --- a/fs/fat/cache.c
> +++ b/fs/fat/cache.c
> @@ -76,7 +76,7 @@ static int fat_cache_lookup(struct inode *inode, int fclus,
>  			    struct fat_cache_id *cid,
>  			    int *cached_fclus, int *cached_dclus)
>  {
> -	static struct fat_cache nohit = { .fcluster = 0, };
> +	static struct fat_cache nohit = { .fcluster = -1, };
>  
>  	struct fat_cache *hit = &nohit, *p;
>  	int offset = -1;
> @@ -130,9 +130,6 @@ static void fat_cache_add(struct inode *inode, struct fat_cache_id *new)
>  {
>  	struct fat_cache *cache, *tmp;
>  
> -	if (new->fcluster == -1) /* dummy cache */
> -		return;
> -
>  	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
>  	if (new->id != FAT_CACHE_VALID &&
>  	    new->id != MSDOS_I(inode)->cache_valid_id)
> @@ -217,14 +214,32 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
>  	cid->nr_contig = 0;
>  }
>  
> -int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
> +static int fat_cache_contig_end(struct inode *inode, int fclus, int dclus,
> +				int end)
> +{
> +	struct fat_cache *p;
> +
> +	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
> +	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
> +		if (p->fcluster > fclus && p->fcluster <= end &&
> +		    p->dcluster - p->fcluster != dclus - fclus)
> +			end = p->fcluster - 1;
> +	}
> +	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
> +
> +	return end;
> +}
> +
> +static int __fat_get_cluster(struct inode *inode, int cluster, int *fclus,
> +			     int *dclus, int *nr_cont)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>  	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
>  	struct fat_entry fatent;
>  	struct fat_cache_id cid;
> -	int nr;
> +	int last = nr_cont ? cluster + *nr_cont - 1 : cluster;
> +	int fcluster, dcluster, nr;
>  
>  	BUG_ON(MSDOS_I(inode)->i_start == 0);
>  
> @@ -236,16 +251,11 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
>  			__func__, MSDOS_I(inode)->i_pos, *dclus);
>  		return -EIO;
>  	}
> -	if (cluster == 0)
> +	if (last == 0)
>  		return 0;
>  
> -	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
> -		/*
> -		 * dummy, always not contiguous
> -		 * This is reinitialized by cache_init(), later.
> -		 */
> -		cache_init(&cid, -1, -1);
> -	}
> +	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0)
> +		cache_init(&cid, 0, *dclus);
>  
>  	fatent_init(&fatent);
>  	while (*fclus < cluster) {
> @@ -276,6 +286,29 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
>  		if (!cache_contiguous(&cid, *dclus))
>  			cache_init(&cid, *fclus, *dclus);
>  	}
> +
> +	if (nr_cont) {
> +		fcluster = min(last, cid.fcluster + cid.nr_contig);
> +		if (fcluster < last)
> +			last = fat_cache_contig_end(inode, cluster, *dclus, last);
> +		dcluster = *dclus + fcluster - cluster;
> +		while (fcluster < last) {
> +			nr = fat_ent_read(inode, &fatent, dcluster);
> +			if (nr < 0)
> +				goto out;
> +			if (nr != dcluster + 1) {
> +				if (nr != FAT_ENT_EOF && nr != FAT_ENT_FREE) {
> +					fat_cache_add(inode, &cid);
> +					cache_init(&cid, fcluster + 1, nr);
> +				}
> +				break;
> +			}
> +			fcluster++;
> +			dcluster++;
> +			cid.nr_contig++;
> +		}
> +		*nr_cont = fcluster - cluster + 1;
> +	}
>  	nr = 0;
>  	fat_cache_add(inode, &cid);
>  out:
> @@ -283,6 +316,30 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
>  	return nr;
>  }
>  
> +int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
> +{
> +	return __fat_get_cluster(inode, cluster, fclus, dclus, NULL);
> +}
> +
> +int fat_get_cont_clusters(struct inode *inode, int cluster, int *nr)
> +{
> +	int ret, fclus, dclus;
> +
> +	if (!MSDOS_I(inode)->i_start)
> +		return -EIO;
> +
> +	ret = __fat_get_cluster(inode, cluster, &fclus, &dclus, nr);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == FAT_ENT_EOF) {
> +		fat_fs_error(inode->i_sb,
> +			     "%s: request beyond EOF (i_pos %lld)",
> +			     __func__, MSDOS_I(inode)->i_pos);
> +		return -EIO;
> +	}
> +	return dclus;
> +}
> +
>  static int fat_bmap_cluster(struct inode *inode, int cluster)
>  {
>  	struct super_block *sb = inode->i_sb;
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 07ab49490..a21fbca12 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -3,6 +3,7 @@
>  #define _FAT_H
>  
>  #include <linux/buffer_head.h>
> +#include <linux/iomap.h>
>  #include <linux/nls.h>
>  #include <linux/hash.h>
>  #include <linux/ratelimit.h>
> @@ -321,6 +322,7 @@ static inline void fatwchar_to16(__u8 *dst, const wchar_t *src, size_t len)
>  extern void fat_cache_inval_inode(struct inode *inode);
>  extern int fat_get_cluster(struct inode *inode, int cluster,
>  			   int *fclus, int *dclus);
> +int fat_get_cont_clusters(struct inode *inode, int cluster, int *nr);
>  extern int fat_get_mapped_cluster(struct inode *inode, sector_t sector,
>  				  sector_t last_block,
>  				  unsigned long *mapped_blocks, sector_t *bmap);
> @@ -489,6 +491,9 @@ void fat_cache_destroy(void);
>  extern const struct export_operations fat_export_ops;
>  extern const struct export_operations fat_export_ops_nostale;
>  
> +/* fat/iomap.c */
> +DECLARE_IOMAP_ITER_NEXT(fat_iomap_next);
> +
>  /* helper for printk */
>  typedef unsigned long long	llu;
>  
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 70583e791..7712cfa2b 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -637,9 +637,21 @@ int fat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL_GPL(fat_setattr);
>  
> +static int fat_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		      u64 start, u64 len)
> +{
> +	int err;
> +
> +	inode_lock_shared(inode);
> +	err = iomap_fiemap(inode, fieinfo, start, len, fat_iomap_next);
> +	inode_unlock_shared(inode);
> +	return err;
> +}
> +
>  const struct inode_operations fat_file_inode_operations = {
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
>  	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
> +	.fiemap		= fat_fiemap,
>  };
> diff --git a/fs/fat/iomap.c b/fs/fat/iomap.c
> new file mode 100644
> index 000000000..4073dc996
> --- /dev/null
> +++ b/fs/fat/iomap.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FAT iomap support
> + *
> + * Copyright (C) 2026 Matheus Alves de Almeida
> + */
> +
> +#include "fat.h"
> +
> +static int __fat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			     unsigned int flags, struct iomap *iomap)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	int start_cluster, end_cluster, nr_cluster, ret;
> +	loff_t curr_size = i_size_read(inode);
> +	loff_t aligned_offset;
> +
> +	iomap->flags = 0;
> +	start_cluster = offset >> sbi->cluster_bits;
> +	aligned_offset = (u64)start_cluster << sbi->cluster_bits;
> +
> +	/*
> +	 * Return IOMAP_HOLE if we are beyond any kind of disk allocation, or
> +	 * past EOF unless writing or reporting.
> +	 */
> +	if (inode_get_bytes(inode) <= offset ||
> +	    (curr_size <= aligned_offset &&
> +	     !(flags & (IOMAP_WRITE | IOMAP_REPORT)))) {
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->offset = offset;
> +		iomap->length = length;
> +		iomap->type = IOMAP_HOLE;
> +		return 0;
> +	}
> +
> +	/*
> +	 * We need to separate normal data clusters and
> +	 * uninitialized FALLOC_FL_KEEP_SIZE clusters.
> +	 */
> +	if (curr_size <= aligned_offset) {
> +		iomap->type = IOMAP_UNWRITTEN;
> +		length = min(offset - aligned_offset + length,
> +			     inode_get_bytes(inode) - aligned_offset);
> +	} else {
> +		iomap->type = IOMAP_MAPPED;
> +		length = min(offset - aligned_offset + length,
> +			     curr_size - aligned_offset);
> +	}
> +
> +	end_cluster = (aligned_offset + length - 1) >> sbi->cluster_bits;
> +	nr_cluster = end_cluster - start_cluster + 1;
> +	ret = fat_get_cont_clusters(inode, start_cluster, &nr_cluster);
> +	if (ret < 0)
> +		return ret;
> +
> +	iomap->addr = (u64)fat_clus_to_blknr(sbi, ret) << sb->s_blocksize_bits;
> +	iomap->offset = aligned_offset;
> +	iomap->length = (u64)nr_cluster << sbi->cluster_bits;
> +	iomap->flags |= IOMAP_F_MERGED;
> +	iomap->bdev = sb->s_bdev;
> +
> +	return 0;
> +}
> +
> +static int fat_iomap_begin(struct inode *inode, loff_t offset,
> +			   loff_t length, unsigned int flags,
> +			   struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return __fat_iomap_begin(inode, offset, length, flags, iomap);
> +}
> +
> +DEFINE_IOMAP_ITER_NEXT(fat_iomap_next, fat_iomap_begin);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=--
