Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07D4DBD7D;
	Tue, 12 May 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567880; cv=none; b=tm1SolgXTN0fSwy5B2EGcEAvgn4s8dWa+Lf9p0EyAb3K9eNTy7OlFsG5yF3EV5Org+KB2JFAtBA5L5P/tRkC6+KrEtGea6gpZPVwWnuwK2auWN6PkzgXXqJ6sEpZGb5OuKILWhNfxCfculF3m4fXCvar6VECpTmlvCcf6kqc1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567880; c=relaxed/simple;
	bh=dStLL7IMZi+V5YSrLaWUzbLacdRwgSjeyd16dVdcENQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtZuu0DGMFmKC5ByUv+F+uoNwfg6eCVYj0KYcNgGa6cPT3HSwQTFdIw4tyy1a/pGRPZ7gjKfnD2z5v0vigTygvekkXS8PRz7EJ0osabVEUgvsbgnWh7I45S4sNGMif5ghpxapkXlH1ZVylfuuTssDgbo14iCR6/6dXVD3I1OSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 816156732A; Tue, 12 May 2026 08:37:43 +0200 (CEST)
Date: Tue, 12 May 2026 08:37:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] exfat: add iomap direct I/O support
Message-ID: <20260512063743.GA31640@lst.de>
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-9-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507124238.7313-9-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static int exfat_truncate(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> @@ -315,6 +315,8 @@ void exfat_truncate(struct inode *inode)
>  	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >> 9;
>  write_size:
>  	mutex_unlock(&sbi->s_lock);
> +
> +	return err;

Allowing error returns here looks unrelated to iomap usage?

> +	if (iov_iter_count(from)) {
> +		loff_t offset, end;
> +		ssize_t written;
> +		int ret2;


.. splitting this whole code block into a helper would be nice.
And eventually it might be worth to lift it to iomap as we have
a few open coded versions of it.

> +out:
> +	return ret;
> +}

Usuaully just directly returning instead of jumping to a label that
returns is easier to follow.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

