Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7A395D8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852409; cv=none; b=NzFSG9BlA7Nw43HvI7IhFDR7Jhr/54ji8UhwLm3uPnHznTv+vb55Xr6+3W9E9nI6gknhkBq8PIVnx/E6m+pjsIOIsRj1nNDKWlWV3Irg+kmW+u0orv960bFmrAg++xCgTifLIDqWpm+zgXrZg3H1k1+4el7V3sYfJYl6EVo4Gb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852409; c=relaxed/simple;
	bh=8inHo83e75R3hztm968NVIzXEsYToK1ucF3sZsr//qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGWwxSUFSXpV1kNJL/pqvjUfZDudKP4HRqVSJkp4vCIPKtoarrV+dLq1/+0bJg9Zs7R65Eia0YHfnD8OWYKCBs/z2IK93gwqB94pzIQf/iDgDpGlbTS+FkBApBtQIIVGY3bt7F3YYVxg/b9fRUiJlgQoJfiroG6U8xMqjIqaAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF56768B05; Mon, 30 Mar 2026 08:33:21 +0200 (CEST)
Date: Mon, 30 Mar 2026 08:33:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com
Subject: Re: [PATCH 2/5] exfat: add iomap direct I/O support
Message-ID: <20260330063321.GB5897@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-3-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326115045.9525-3-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 26, 2026 at 08:50:42PM +0900, Namjae Jeon wrote:
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		ret = iomap_dio_rw(iocb, iter, &exfat_write_iomap_ops,
> +				&exfat_write_dio_ops, 0, NULL, 0);
> +		if (ret == -ENOTBLK)
> +			ret = 0;

This seems to miss a fallback to __generic_file_write_iter?

> +	inode_lock_shared(inode);
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		size_t count = iov_iter_count(iter);
> +
> +		if ((iocb->ki_pos | count) & (inode->i_sb->s_blocksize - 1)) {
> +			ret = -EINVAL;
> +			goto inode_unlock;
> +		}

iomap_dio_bio_iter() should already take care of the alignment check.

> -	.direct_IO	= exfat_direct_IO,
> +	.direct_IO	= noop_direct_IO,

This should not be needed, setting FMODE_CAN_ODIRECT in ->open should
be all that is needed.

