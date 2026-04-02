Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2776317161
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139756; cv=none; b=Ttlku8HCuJBrCBqEjoY+4quPDPfxvVy8HOBhxsOSZi+rJp4cDMVsEyMayqYmyzvVFj3DsTsgcCPFJfWZNxGiPJAZFvBn9/4RIMiXhgf/V63QuqM+wGKwQ5M74ScTKXuWPTIaloiRh9toJJkJEW6JNCjY77aGzMCces/Y1BWiKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139756; c=relaxed/simple;
	bh=XHsbLw3hfuduL6LkRbrraTVAFvrmCq+QFnFURsH5Y5g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Wx9PEtM9gx2srGnKhkLSwObPPltHVJCgqlTHYCA4p6VUPvhojYcAXorNjagwOiS8tzW3S0zFlTvsCO25LH4Z8WJyf+fInJ8oJgDPRzt7NVWQF1h8TDrEAOJM2VHYIkySh5kp+LRD7POQBetKtjHCfRsyVLvlLdAP0dqe8J+0fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T0QKlz+x; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T0QKlz+x"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260402142226epoutp0169f2665a4fcff043df71c78a50ee4a82~ikDGyICYo2359223592epoutp01H
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 14:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260402142226epoutp0169f2665a4fcff043df71c78a50ee4a82~ikDGyICYo2359223592epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1775139746;
	bh=UjT7UOmE7fjSPqx+xu4oYPi80HZ0sioGFyrqHVvM0lE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=T0QKlz+xUX01r5EWIbp4EyomGwtuXAM/0rs5nnKGhaVZH62KUHjTqvDPHZERHbHjL
	 lyBZgTl0T6ATOryJJ+h1g47e0N5EBnwk6rBQL/jXTCVgQkk+7tuSSA+WpAehvhoci1
	 m+wIsJPPLcsQnTkLC5gUCZqkZ+e+06jeiL4tIvVs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260402142225epcas1p1093ff01e6b69a1b71686b0a82965b9c8~ikDGAD4B93053530535epcas1p1x;
	Thu,  2 Apr 2026 14:22:25 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.115]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fmkZn1PKDz6B9m4; Thu,  2 Apr
	2026 14:22:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260402142224epcas1p1ac5426d61bc5218e120eb00872f42f7c~ikDFHqQHs2328223282epcas1p1H;
	Thu,  2 Apr 2026 14:22:24 +0000 (GMT)
Received: from W11PB11713 (unknown [10.91.160.69]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260402142224epsmtip22963e88112489b4401935f518304c44d~ikDFEf1741156411564epsmtip29;
	Thu,  2 Apr 2026 14:22:24 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Chi Zhiling'" <chizhiling@163.com>, "'Namjae Jeon'"
	<linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "'Chi
 Zhiling'" <chizhiling@kylinos.cn>, <cpgs@samsung.com>,
	<sj1557.seo@samsung.com>
In-Reply-To: <20260401071138.114836-4-chizhiling@163.com>
Subject: RE: [PATCH v2 3/6] exfat: use exfat_fat_walk helper to simplify fat
 entry walking
Date: Thu, 2 Apr 2026 23:22:23 +0900
Message-ID: <015c01dcc2ac$1ffd7520$5ff85f60$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ5qCPwvmfl60NVQmEFKdnXq9EFoQKGLqHJAn8VS+K0ad0jQA==
Content-Language: ko
X-CMS-MailID: 20260402142224epcas1p1ac5426d61bc5218e120eb00872f42f7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260401071219epcas1p382c16d770872794223bf7d67c79f401a
References: <20260401071138.114836-1-chizhiling@163.com>
	<CGME20260401071219epcas1p382c16d770872794223bf7d67c79f401a@epcas1p3.samsung.com>
	<20260401071138.114836-4-chizhiling@163.com>

Hi, Chi Zhiling,
> Replace the custom exfat_walk_fat_chain() function and open-coded FAT 
> chain walking logic with the exfat_fat_walk() helper across 
> exfat_find_location, __exfat_get_dentry_set, and exfat_map_cluster.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  fs/exfat/dir.c   | 39 +++------------------------------------
>  fs/exfat/inode.c | 11 ++---------
>  2 files changed, 5 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 7619410d668e..cfc6f16a5fb2 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -562,38 +562,6 @@ int exfat_put_dentry_set(struct 
> exfat_entry_set_cache *es, int sync)
>  	return err;
>  }
> 
> -static int exfat_walk_fat_chain(struct super_block *sb,
> -		struct exfat_chain *p_dir, unsigned int byte_offset,
> -		unsigned int *clu)
> -{
> -	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	unsigned int clu_offset;
> -	unsigned int cur_clu;
> -
> -	clu_offset = EXFAT_B_TO_CLU(byte_offset, sbi);
> -	cur_clu = p_dir->dir;
> -
> -	if (p_dir->flags == ALLOC_NO_FAT_CHAIN) {
> -		cur_clu += clu_offset;
> -	} else {
> -		while (clu_offset > 0) {
> -			if (exfat_get_next_cluster(sb, &cur_clu))
> -				return -EIO;
> -			if (cur_clu == EXFAT_EOF_CLUSTER) {

The intentional exfat_fs_error() call for chain damage conditions is lost.
Instead of removing the error handling for this condition, it had better be
moved to exfat_find_location().

Other than this, the rest of the patchset looks excellent.
Thanks.

> -				exfat_fs_error(sb,
> -					"invalid dentry access beyond EOF
> (clu : %u, eidx : %d)",
> -					p_dir->dir,
> -					EXFAT_B_TO_DEN(byte_offset));
We lost 
> -				return -EIO;
> -			}
> -			clu_offset--;
> -		}
> -	}
> -
> -	*clu = cur_clu;
> -	return 0;
> -}
> -
>  static int exfat_find_location(struct super_block *sb, struct 
> exfat_chain *p_dir,
>  			       int entry, sector_t *sector, int *offset)  {
@@ -
> 603,7 +571,8 @@ static int exfat_find_location(struct super_block *sb, 
> struct exfat_chain *p_dir
> 
>  	off = EXFAT_DEN_TO_B(entry);
> 
> -	ret = exfat_walk_fat_chain(sb, p_dir, off, &clu);
> +	clu = p_dir->dir;
> +	ret = exfat_fat_walk(sb, &clu, EXFAT_B_TO_CLU(off, sbi), 
> +p_dir->flags);
>  	if (ret)
>  		return ret;
> 
> @@ -792,9 +761,7 @@ static int __exfat_get_dentry_set(struct 
> exfat_entry_set_cache *es,
>  		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
>  			unsigned int clu = exfat_sector_to_cluster(sbi,
sec);
> 
> -			if (p_dir->flags == ALLOC_NO_FAT_CHAIN)
> -				clu++;
> -			else if (exfat_get_next_cluster(sb, &clu))
> +			if (exfat_fat_walk(sb, &clu, 1, p_dir->flags))
>  				goto put_es;
>  			sec = exfat_cluster_to_sector(sbi, clu);
>  		} else {
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> beb9ea7cca9f..817d9a135bb6 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -225,15 +225,8 @@ static int exfat_map_cluster(struct inode *inode, 
> unsigned int clu_offset,
>  		 * *clu = (the first cluster of the allocated chain) =>
>  		 * (the last cluster of ...)
>  		 */
> -		if (ei->flags == ALLOC_NO_FAT_CHAIN) {
> -			*clu += num_to_be_allocated - 1;
> -		} else {
> -			while (num_to_be_allocated > 1) {
> -				if (exfat_get_next_cluster(sb, clu))
> -					return -EIO;
> -				num_to_be_allocated--;
> -			}
> -		}
> +		if (exfat_fat_walk(sb, clu, num_to_be_allocated - 1, ei-
> >flags))
> +			return -EIO;
>  		*count = 1;
>  	}
> 
> --
> 2.43.0


