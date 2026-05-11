Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC33BADAA;
	Mon, 11 May 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506859; cv=none; b=uIJE3Jg+CuEaA3LTcvIEiRrawBbtpxSmIQ2ic2afQU93cqLSQ2PXhWkP0DAeJyKvCidHVB8dV7lNn7q6yIZOY13lpPaWYxQSGqsnKPWd2unUEkJSob+uSgclFg/daVhBqXYc/Tc+88Uv+6qh/cDACaC0g4Qsk6ucxovS+wd8rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506859; c=relaxed/simple;
	bh=B+AN7m88kJs9YDXBiw8UkohIZQJBN3l2DecKV1wB0BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRYeySe/lZfp4UmmfTztsK4s/TAChFT8ipxg2A13att2kWwBvsjVwxa1xgifQEE5U03rayoF2m/apYSC1GkxeXqBFQ+fHsC+guoVokODgEect29qeO2TZoh74ulcnid8V7mauoDpc/tAC5yOlMMGnArH0U1KWdqwb3DJmXBwEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+J8rSmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+J8rSmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2D1C2BCB0;
	Mon, 11 May 2026 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778506859;
	bh=B+AN7m88kJs9YDXBiw8UkohIZQJBN3l2DecKV1wB0BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+J8rSmDaFMyoaAcJL6vXiuB3K27nc4tD9bliH0b+5YGNefGGzS3PeBVGlqs21QUe
	 EBcsb7gkHtO41a0flkUk9l7WyCvHmyfH2rHE9RtwFyGXaFf+VhUApO+Y8w4pkmenaU
	 i5oL0S1/q3CKvwZDNx/LaMZK8fQQEL3bENV/iM1T1CDhn5YeAsweR2Y41Oa45wy6de
	 FQ5iIbfImBT5KTN3RSYwKqnOiz0pgpTulAiKyKYP/xZpfhw4drLa3g/h19fXChueWA
	 kg9WYNFGcJqPvfdUhQTE1BaFcxkRyBbspCKpsAQF2NH0HIdvevRRndoDD1juCejNLT
	 dvZLFCyBnX4DA==
Date: Mon, 11 May 2026 15:40:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Bob Copeland <me@bobcopeland.com>, 
	Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/10] omfs: handle set_blocksize failures
Message-ID: <20260511-angst-essgewohnheiten-253295fac18c@brauner>
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511071701.2456211-11-hch@lst.de>

On Mon, May 11, 2026 at 09:16:55AM +0200, Christoph Hellwig wrote:
> omfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> Without this, mounting we will hit the
> 
>         BUG_ON(offset >= folio_size(folio));
> 
> in folio_set_bh on the first __bread_gfp call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'll drop the double-sign-off.

> ---
>  fs/omfs/inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
> index 834cae1e6223..1d915ef72119 100644
> --- a/fs/omfs/inode.c
> +++ b/fs/omfs/inode.c
> @@ -478,7 +478,8 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_time_min = 0;
>  	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
>  
> -	sb_set_blocksize(sb, 0x200);
> +	if (!sb_set_blocksize(sb, 0x200))
> +		goto end;
>  
>  	bh = sb_bread(sb, 0);
>  	if (!bh)
> @@ -530,7 +531,8 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	 * Use sys_blocksize as the fs block since it is smaller than a
>  	 * page while the fs blocksize can be larger.
>  	 */
> -	sb_set_blocksize(sb, sbi->s_sys_blocksize);
> +	if (!sb_set_blocksize(sb, sbi->s_sys_blocksize))
> +		goto out_brelse_bh;
>  
>  	/*
>  	 * ...and the difference goes into a shift.  sys_blocksize is always
> -- 
> 2.53.0
> 
