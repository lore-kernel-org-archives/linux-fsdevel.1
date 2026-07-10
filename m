Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC163B83FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694986; cv=none; b=EOCl5/uF74wcWO8CntVy7XL2TYcKIV9WpPCoKMwCCsuVjvDztorSI/0Msfi2m8HDLbI+pe1MCSNaxEeJvQclh1qT/L4/3I3ob8Ou0GM2knAirPgDlCm8xCqUimfqJprCKTEG5tU4Nwo2O9//vHW6HOLhOEHwtb2o8ymnIT/+heI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694986; c=relaxed/simple;
	bh=14XUhcKvhhsH3tjfWwUuL2DZp/rZswDqj++URGzSeCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+SYfWNj6yp0jbEAvTGuQpP+xJCJ8GYj0+uy45yABPgxYqduG+rM5Qzzemx+e52JnTtdHIj0cbyFBHZBd6FYnRY19B2UcqgSIjhcvIdjxisMOe23WAlbh/5llEMAq3zs4Nld1fIyR4ncodTem06kBZM0Q/s0QD8s65bVzr4GkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmU/jn0G; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmU/jn0G"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXZlxSO/l92LMpl6/wSr5Uj7XlqGnryB8RQYDio6xSg=;
	b=JmU/jn0Gt4Y7cqKt/pqB4N9AsbtjK+l0fkxsrbznBJ3RTnlOfTULLd4rAPCSiGh2BKcRnG
	RCr2Ox90kU/lZ+DtVvdN8Y/5+HoUrU581oMSjuaESOaHkPBQCJnleBEuxLk1WCTwFv17OY
	sqDUnPxa9wuAI/XuzwBXgPDmRnKAFfM=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 04/10] hugetlb: Set mapping folio order
Date: Fri, 10 Jul 2026 07:49:32 -0700
Message-ID: <20260710144932.1582955-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-5-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:32 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> hugetlbfs currently uses an fs-specific way to determine the size of
> the folios in its page cache.  Thanks to the support of block sizes
> larger than page sizes, we now support this as part of the page cache.
> It's somewhat more efficient as we have this information directly in the
> mapping rather than going from inode->i_sb->s_fs_info.  We can convert
> the rest of the hugetlb code to use this at our leisure; this is needed
> now so that we can use filemap_get_pages() unmodified.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/hugetlbfs/inode.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 216e1a0dd0b2..1760df6f2709 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -883,6 +883,16 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
>  	return inode;
>  }
>  
> +static void hugetlbfs_init_regular_inode(struct inode *inode)
> +{
> +	struct hstate *hstate = hstate_inode(inode);
> +	unsigned int order = huge_page_order(hstate);
> +
> +	inode->i_op = &hugetlbfs_inode_operations;
> +	inode->i_fop = &hugetlbfs_file_operations;
> +	mapping_set_folio_order_range(inode->i_mapping, order, order);

We are setting mapping_set_folio_order_range(), but mapping_min_folio_order()
and mapping_max_folio_order() will still return 0 if CONFIG_TRANSPARENT_HUGEPAGE
is disabled but hugetlb is enabled. I am guessing this will be tackled in
one of the following patches in the series.

> +}
> +
>  /*
>   * Hugetlbfs is not reclaimable; therefore its i_mmap_rwsem will never
>   * be taken from reclaim -- unlike regular filesystems. This needs an
> @@ -926,8 +936,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  			init_special_inode(inode, mode, dev);
>  			break;
>  		case S_IFREG:
> -			inode->i_op = &hugetlbfs_inode_operations;
> -			inode->i_fop = &hugetlbfs_file_operations;
> +			hugetlbfs_init_regular_inode(inode);
>  			break;
>  		case S_IFDIR:
>  			inode->i_op = &hugetlbfs_dir_inode_operations;
> -- 
> 2.47.3
> 
> 
