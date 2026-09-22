Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C437F015;
	Tue, 22 Sep 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100148; cv=none; b=fZVwOhAv57RjDuMVEo5GzDksv2FzBaEplrE2idx0rGxrPE6Bmxcgc9ESnb+to4PT1Zyfdpq2LTGyp6Y9VcKvQhxZqHd0ZjONQMr3cQQ8bKFugWHj4xgmhaafH91Dm4Qx+Kgg2xrQ8gh4kq5EzjrfJw8CBJaoFZY5qnN1COhrHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100148; c=relaxed/simple;
	bh=w4grvdMR+k+K87EvpxsUq+S+Y3NGL1PStjTWbUW4DwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T++TUTGWBx5xhE4ka0UuW2RPlJgzwaVQypgecB1Ir9v/pYjWX6ZyWEoDI/KlqxsptYPW8Sb48pP/OSt557hnQL/K28hjo9tgMipt1PXBpsUL4/6Nj9KTAJzAMvEV113RvoNzTdXipq9ktJv3IuSWzHwHCQq77efRLO3L4vssjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=nRDqSg/P; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=nS5n83DF; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="nRDqSg/P";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="nS5n83DF"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id BFAC326F7695;
	Wed, 23 Sep 2026 02:56:48 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1790099809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1vqf+accqYJ6nnoce6kfgYSjfOjlkRuJiYiqwVHPgQ=;
	b=nRDqSg/Py+7yMxToloNweKHIsB0xbQJCyLS7Glj9ZdNC8OK9Y/wU4Kr+Pa2iqFUc0Sk6RC
	zB+ZZ2zZEB11liKOpv6e1DxtfJqK2amvoGVAwILKXeWK2OzDtbyUlFWWYkMahO0jyExIL3
	zCW6FdXGIOZpFTiVflXx5DEAVcuXVX5YwD7bmz1PYEgwgd10SByo5pA1qivHoUn/DxFgv1
	6au8X2wWqRgHA9ECeSjj+PavDvCKPhJMpwyxFJ+1DRMPl2ZeCax59p92FajD7MN0KgrQrm
	wQftmoQptAEZWTy4p0R8fcBMFid8B8jybcm2RU/ZV893+NiY9xCT0CtyjS7EWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1790099809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1vqf+accqYJ6nnoce6kfgYSjfOjlkRuJiYiqwVHPgQ=;
	b=nS5n83DFeUP7Ehz8eYBkJsWofy040lX+CVpFZgzb3NdKnSrqPHNDAj0PCk8T/+1YfoC+Dk
	GcU+pzAia+wlQ0Aw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 3761DE00117;
	Wed, 23 Sep 2026 02:56:48 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 2ED3822000F1; Wed, 23 Sep 2026 02:56:48 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Hui Peng <benquike@gmail.com>
Cc: Jan Kara <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: avoid freeing clusters on failed directory
 validation or read-only mounts
In-Reply-To: <20260919204810.2813594-1-benquike@gmail.com>
References: <20260919204810.2813594-1-benquike@gmail.com>
Date: Wed, 23 Sep 2026 02:56:48 +0900
Message-ID: <877bkdcgpr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hui Peng <benquike@gmail.com> writes:

> In fat_fill_inode(), set_nlink(inode, fat_subdirs(inode)) is called
> before fat_validate_dir(inode). If a directory has zero valid
> subdirectories (so fat_subdirs(inode) returns 0) and fat_validate_dir()
> subsequently returns -EIO (due to a missing or malformed '.'/'..'
> entry), fat_build_inode() calls iput(inode) with inode->i_nlink == 0 and
> inode->i_start still populated.
>
> fat_evict_inode() then checks !inode->i_nlink without checking
> is_bad_inode(inode) or sb_rdonly(inode->i_sb) and calls
> fat_truncate_blocks(inode, 0), freeing the cluster chain on disk even on
> a read-only (MS_RDONLY) mount.
>
> Validate the directory before setting i_nlink in fat_fill_inode(), mark
> the inode bad on error in fat_build_inode(), and guard cluster
> truncation and metadata writeback in fat_evict_inode() with
> !is_bad_inode(inode) && !sb_rdonly(inode->i_sb).
>
> Fixes: a3082d526f2d ("fat: add simple validation for directory inode")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -535,11 +535,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
>  			return error;
>  		MSDOS_I(inode)->mmu_private = inode->i_size;
>  
> -		set_nlink(inode, fat_subdirs(inode));
> -
>  		error = fat_validate_dir(inode);

Without set_nlink(), fat_validate_dir() will always return the error,
isn't it? If so, this patch is not tested?

>  		if (error < 0)
>  			return error;
> +
> +		set_nlink(inode, fat_subdirs(inode));
>  	} else { /* not a directory */
>  		inode->i_generation |= 1;
>  		inode->i_mode = fat_make_mode(sbi, de->attr,
> @@ -610,6 +610,7 @@ struct inode *fat_build_inode(struct super_block *sb,
>  	inode_set_iversion(inode, 1);
>  	err = fat_fill_inode(inode, de);
>  	if (err) {
> +		make_bad_inode(inode);
>  		iput(inode);
>  		inode = ERR_PTR(err);
>  		goto out;
> @@ -688,12 +689,14 @@ static void fat_free_eofblocks(struct inode *inode)
>  static void fat_evict_inode(struct inode *inode)
>  {
>  	truncate_inode_pages_final(&inode->i_data);
> -	if (!inode->i_nlink) {
> -		inode->i_size = 0;
> -		fat_truncate_blocks(inode, 0);
> -	} else {
> -		mmb_sync(&MSDOS_I(inode)->i_metadata_bhs);
> -		fat_free_eofblocks(inode);
> +	if (!is_bad_inode(inode) && !sb_rdonly(inode->i_sb)) {
> +		if (!inode->i_nlink) {
> +			inode->i_size = 0;
> +			fat_truncate_blocks(inode, 0);
> +		} else {
> +			mmb_sync(&MSDOS_I(inode)->i_metadata_bhs);
> +			fat_free_eofblocks(inode);
> +		}
>  	}
>  
>  	mmb_invalidate(&MSDOS_I(inode)->i_metadata_bhs);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
