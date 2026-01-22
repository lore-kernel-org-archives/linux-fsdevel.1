Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D834CFCF;
	Thu, 22 Jan 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090064; cv=none; b=kscQqGERau3F5xVUSYssNuIMEExn1Ij4uj5SO7Y5FiWtgeIHH1TOtSXP7koJS5ab2hZ+0uV4pDaBEtqWFUHGXQCyTndlcMZGYS4Onhx5cizLwSWq8UY7fdJ1m9pt0bT5Ih3Sg2yOaAfVGu49vvBLgp4trMAhZuU1oCokyABtCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090064; c=relaxed/simple;
	bh=gONcv+6YWjod/nKEOo53IIrNKNesbY4qzuK4aJWddBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVfYFBoiqKA95gXyUnossiWm6mLBTgotlBwko/EoZzR6zkU2nv6a6SlqKmoj4wcXCR+lipgsGaDZLLHe1ZaNI4uOE8zhaeazv+hk6ioVMReJBu+cPE7J1MfGx6djVoJ3xwASjwHM+S5hWGo7ZsIEVTHAX9rFYmMMHRPSFUrxWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVuTA7TC; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVuTA7TC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769090057; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iH69wCFur78VdAz+L0r8AsGzLUkhYCtsKfI7hLzfOAk=;
	b=oVuTA7TCneAoShf8/iNQM3BBNTRgXzR4rcWcG7LMR2jisHZHTIxX8M+KIHXy03rSSICCuCt5kHCNap3yIBcJkqcsUPRpAZxB1lAXjrsnzUE6IlOFMkugNlpjJOXRuAyhvxLtdwwdEVv8lmT4DN76mjEEQkL3u8bTmYCoLPJlWc0=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxcZzn2_1769090056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 21:54:17 +0800
Message-ID: <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
Date: Thu, 22 Jan 2026 21:54:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops.
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122133718.658056-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/22 21:37, Hongbo Li wrote:
> Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops,
> and using IS_ENABLED to make it cleaner.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/inode.c    | 23 +----------------------
>   fs/erofs/internal.h | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index bce98c845a18..389632bb46c4 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -235,28 +235,7 @@ static int erofs_fill_inode(struct inode *inode)
>   	}
>   
>   	mapping_set_large_folios(inode->i_mapping);
> -	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -#ifdef CONFIG_EROFS_FS_ZIP
> -		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
> -			  erofs_info, inode->i_sb,
> -			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> -		inode->i_mapping->a_ops = &z_erofs_aops;
> -#else
> -		err = -EOPNOTSUPP;
> -#endif
> -	} else {
> -		inode->i_mapping->a_ops = &erofs_aops;
> -#ifdef CONFIG_EROFS_FS_ONDEMAND
> -		if (erofs_is_fscache_mode(inode->i_sb))
> -			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> -#endif
> -#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> -		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
> -			inode->i_mapping->a_ops = &erofs_fileio_aops;
> -#endif
> -	}
> -
> -	return err;
> +	return erofs_inode_set_aops(inode, inode, false);
>   }
>   
>   /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index ec79e8b44d3b..8e28c2fa8735 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>   	return NULL;
>   }
>   
> +static inline int erofs_inode_set_aops(struct inode *inode,
> +				       struct inode *realinode, bool no_fscache)
> +{
> +	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
> +			return -EOPNOTSUPP;
> +		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
> +			  erofs_info, realinode->i_sb,
> +			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> +		inode->i_mapping->a_ops = &z_erofs_aops;

Is that available if CONFIG_EROFS_FS_ZIP is undefined?

> +		return 0;
> +	}
> +	inode->i_mapping->a_ops = &erofs_aops;
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
> +		if (!no_fscache && erofs_is_fscache_mode(realinode->i_sb))
> +			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> +	} else {

I really don't think they are equal, could you just move
the code without any change?

Thanks,
Gao Xiang
> +		if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
> +			inode->i_mapping->a_ops = &erofs_fileio_aops;
> +	}
> +	return 0;
> +}
> +
>   int erofs_register_sysfs(struct super_block *sb);
>   void erofs_unregister_sysfs(struct super_block *sb);
>   int __init erofs_init_sysfs(void);

