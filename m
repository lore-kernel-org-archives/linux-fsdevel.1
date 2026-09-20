Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD873403EE;
	Sun, 20 Sep 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876969; cv=none; b=JkpSuwxfLc4AVGblIpFacc4H6EjPq+AosG46CXFVvmHAvK5WOmg4A5kNJfDKiaKxWyU1/eFmHVkm2UK6eUiZ1ErUm9zxr0UjyKDxHYOiYf0OTSKrAi60ps8uJD/tlvv2fxC45+5HvFdgjKqYPL7hp9SYtitBH4dzUigq4YpTQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876969; c=relaxed/simple;
	bh=62W5ZuCh/4sQIRC782XN1XPCGdVbOLk4wECiWwkOaEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwTRvLk7eDqkyu2rTBZUqAkcz1pHFy/RCFT7uC06K4KoVss/DkHDczWvFPC/L5FVS76Epk5sTEJgyC+P6wAHcuuaC+qedvUAJhJG49n/fMXvV3RP+v1GFg1518xkgg0qURSuoZBO3tfHIjkelcXaJ0oZNJMPxVsU3DZS6TO27CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eftTij0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eftTij0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D691F000FF;
	Sun, 20 Sep 2026 04:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789876967;
	bh=wLKvOVUl3mXTCwAVDSdJDie0+ZuJUX8NTiy+w2yN39c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eftTij0fP06uNK6xpKKnfNI1SvHZxswJHuX8CWLAiUoI/sTKJMM5l5qLZ7I2IG5Yf
	 5IpuBWDks2SlJpy5E4LK3EWECy0NnFNQ0Sy64uoKIYjJBlWa1g76ngeUMpzH5puA8G
	 4TnjxJQPUiN8Spdiy8yCHcXsjniMeMIlyoAsd03sA62AxijvC/hgdDb/1nskskgdKx
	 MMF+bjoaSFWUO9kKYgJX/TxZNxNzh/E8mBKWK7Qze4hY7AbdYtJuhjY/8VdH8K6jH1
	 64/pypRQwDw9NRRxz1fGyvsa7bQvmyBl5mbtSBst4ABtVrp6zWrVjJ+or9DUD620li
	 n2IPTFiZKoegQ==
Message-ID: <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
Date: Sun, 20 Sep 2026 13:02:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qnx6: validate di_filelevels in qnx6_iget() and fix mount
 error handling
To: Hui Peng <benquike@gmail.com>, brauner@kernel.org, jack@suse.cz,
 jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919222556.3792829-1-benquike@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260919222556.3792829-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/26 07:25, Hui Peng wrote:
> Fix two issues in fs/qnx6/:
> 
> 1. In qnx6_iget(), reject raw_inode->di_filelevels > QNX6_PTR_MAX_LEVELS
>    so computing the maximum block count does not trigger shift-out-of-
>    bounds undefined behavior or out-of-bounds block pointer array walks.
> 2. In qnx6_fill_super() and qnx6_mmi_fill_super(), prevent MS_SILENT
>    from bypassing superblock magic validation and ensure sbi->sb_buf is
>    released exactly once on failure.

Please split this into 2 patches, one patch for each problem you fix.

> 
> Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index 6de49333acad..04214b829e10 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -144,8 +144,10 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
>  		levelptr = (no >> bitdelta) & mask;
>  		ptr = ((__fs32 *)bh->b_data)[levelptr];
>  
> -		if (!qnx6_check_blockptr(ptr))
> +		if (!qnx6_check_blockptr(ptr)) {
> +			brelse(bh);
>  			return 0;
> +		}
>  
>  		block = qnx6_get_devblock(s, ptr);
>  		brelse(bh);
> @@ -397,12 +399,14 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
>  		sbi->sb_buf = bh1;
>  		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
>  		brelse(bh2);
> +		bh2 = NULL;
>  		pr_info("superblock #1 active\n");
>  	} else {
>  		/* superblock #2 active */
>  		sbi->sb_buf = bh2;
>  		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
>  		brelse(bh1);
> +		bh1 = NULL;
>  		pr_info("superblock #2 active\n");
>  	}
>  mmi_success:
> @@ -463,6 +467,8 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
>  out1:
>  	iput(sbi->inodes);
>  out:
> +	if (sbi->sb_buf && sbi->sb_buf != bh1 && sbi->sb_buf != bh2)
> +		brelse(sbi->sb_buf);
>  	brelse(bh1);
>  	brelse(bh2);
>  outnobh:
> @@ -560,6 +566,13 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
>  	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
>  				sizeof(raw_inode->di_block_ptr));
>  	ei->di_filelevels = raw_inode->di_filelevels;
> +	if (ei->di_filelevels > QNX6_PTR_MAX_LEVELS) {
> +		pr_err("invalid filelevels (%u) in inode %u\n",
> +		       ei->di_filelevels, ino);
> +		folio_release_kmap(folio, raw_inode);
> +		iget_failed(inode);
> +		return ERR_PTR(-EIO);
> +	}
>  
>  	if (S_ISREG(inode->i_mode)) {
>  		inode->i_fop = &generic_ro_fops;
> diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
> index b8afb6f388b2..28cb9322278e 100644
> --- a/fs/qnx6/super_mmi.c
> +++ b/fs/qnx6/super_mmi.c
> @@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
>  	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
>  	sbi = QNX6_SB(s);
>  	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
> -		if (!silent) {
> +		if (!silent)
>  			pr_err("wrong signature (magic) in superblock #1.\n");
> -			goto out;
> -		}
> +		goto out;
>  	}
>  
>  	/* checksum check - start at byte 8 and end at byte 512 */
> @@ -64,15 +63,16 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
>  		goto out;
>  	}
>  
> -	/* calculate second superblock blocknumber */
> -	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
> -					fs32_to_cpu(sbi, sb1->sb_blocksize);
> -
>  	/* set new blocksize */
>  	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
>  		pr_err("unable to set blocksize\n");
>  		goto out;
>  	}
> +
> +	/* calculate second superblock blocknumber */
> +	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
> +					fs32_to_cpu(sbi, sb1->sb_blocksize);
> +
>  	/* blocksize invalidates bh - pull it back in */
>  	brelse(bh1);
>  	bh1 = sb_bread(s, 0);


-- 
Damien Le Moal
Western Digital Research
