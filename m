Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDB2D8385;
	Thu,  4 Jun 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608643; cv=none; b=PbjtwlTEL6MBx3cNhnUH1DtxBdkx2q898Z0pZgoEB1d1wjLB19lo2IERWYHzX/J1gZC50dqa/hE3TVivPdAZWwmx44wq90QCpc4SSZR/34GrckXHPSRk7g+Rz55sL1fIrugi8HlQwcrtgHiIxvAYKjtFK81KIMWv5+9ciuvNfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608643; c=relaxed/simple;
	bh=Fw2+jVIHY9heQDmG3C5mirLLf5h/2sY+2gAuCcYkMdo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uwV0iOUqF4fxvdW0Ow8yTS/9td1OKeCs6Rm3D4br49kWA8SHgAdqudBwlJADlINyAfn92eSJz8R8NvUKVBBFrQvf6wc9vW8r92R7fGq0/3lKIVKihKxMbLQZnDp9bHrxVFDgvc9GQvwoKHNK7YCsktVF50u02vQNhb484unrmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JT/K3gg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JT/K3gg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2E91F00893;
	Thu,  4 Jun 2026 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780608641;
	bh=SpdfBh7B4e0kbyt8CaXA4Nf74EtY5ciFNY11xofjztU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JT/K3gg08Mf96d+tcI46MyvkG8u/IpmR3CQCzYhr4mgPcv4lMwGaE/dx1KveTcq2i
	 uKr67eT12roXFVL2zmHQLJnEVYjeaRiqhMRIGRsXprOf95Ei10coxBXQEzMy+BRK+p
	 t/qvqJQKwHq2ynVlh3OHScboiuPGMKK2h7MoaeIk=
Date: Thu, 4 Jun 2026 14:30:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org (open
 list), linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
Message-Id: <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
In-Reply-To: <20260604202441.65226-1-m32285159@gmail.com>
References: <20260604202441.65226-1-m32285159@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(cc linux-fsdevel)

On Thu,  4 Jun 2026 15:24:40 -0500 Maxwell Doose <m32285159@gmail.com> wrote:

> Firstly, the current code uses formatters that are incompatible with the
> most recent GCC for x86_64. Replace them and explicitly cast the
> formatted variables to their respective forms of long long.

Please quote the compiler output in the changelog.

> Secondly, replace the legacy conditional compilation for DEBUG with the
> more preferred pr_debug() to condense the code, while keeping the final
> output functionally identical.
> 
> Fixes: f403d1dbac6d ("fs/efs: add pr_fmt / use __func__")
>
> ...
>

>  Test compiled only with gcc 16.1.1 for x86_64.

Compiled how?  DEBUG was defined in some fashion?

> --- a/fs/efs/file.c
> +++ b/fs/efs/file.c
> @@ -19,13 +19,12 @@ int efs_get_block(struct inode *inode, sector_t iblock,
>  	if (create)
>  		return error;
>  	if (iblock >= inode->i_blocks) {
> -#ifdef DEBUG
>  		/*
>  		 * i have no idea why this happens as often as it does
>  		 */
> -		pr_warn("%s(): block %d >= %ld (filesize %ld)\n",
> -			__func__, block, inode->i_blocks, inode->i_size);

That wouldn't have compiled anyway - `block' is undefined?

> -#endif
> +		pr_debug("EFS: block %llu >= %llu (filesize %lld)\n",
> +			 (unsigned long long)iblock, (unsigned long long)inode->i_blocks,
> +			 (long long)inode->i_size);

It seems that nowadays sector_t and blkcnt_t are unconditionally u64
and loff_t is unconditionally `long long'.  I think, please check.

If so, no casts are needed.

>  		return 0;
>  	}
>  	phys = efs_map_block(inode, iblock);
> @@ -43,13 +42,12 @@ int efs_bmap(struct inode *inode, efs_block_t block) {
>  
>  	/* are we about to read past the end of a file ? */
>  	if (!(block < inode->i_blocks)) {
> -#ifdef DEBUG
>  		/*
>  		 * i have no idea why this happens as often as it does
>  		 */
> -		pr_warn("%s(): block %d >= %ld (filesize %ld)\n",
> -			__func__, block, inode->i_blocks, inode->i_size);
> -#endif
> +		pr_debug("EFS: block %llu >= %llu (filesize %lld)\n",
> +			 (unsigned long long)block, (unsigned long long)inode->i_blocks,
> +			 (long long)inode->i_size);
>  		return 0;
>  	}

