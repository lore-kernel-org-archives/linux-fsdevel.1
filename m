Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395518;
	b=CEDXumFQZeL/COs8reJxyODJbeoDsWafnCVju12NK382SpPQb98oSortUly9kzQB378+
	 Nj0jmCNenkcP+5uM0z+K7gFllHsQ2IDISS54zTOYgSap7oZIjvfD80jsOlz7f9rZdZUkS
	 yg/X8nfgUN85VUsCBwi4T0mhZqQPzjVjgiBtQmNJA9tUoWlyrSz5j31crP+QOJ0RBatvk
	 jWu839GdaVS97jJ90Zvm3FcMe3K0wJDl1qkxPOHare5x6EryorAR2RU5Jv0G3ntn2NOM7
	 LGW5Y5owUhQNNku2BSuQfUkdCxXFpgfbVONX6viqjGlO8apcKUS73iFNoHHeSEeYMhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395518;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nShDP18JigXMYT5zX1D0CYbMVkXJlUs0aEszqP9AdA0=;
	b=z8bnrh2JzE36KPs8PgZi28DlecVvSwt0N2CEAbUNPlmDSnYHoqgG0943YSX7hSjOsT9s
	 z5Huk8TUvnLv2CdE3BzEvFDvPQ20J/1TO8bWfb2wdBV+4eHBCFGm8pXhGDuDtkuaSRCwq
	 CxWX85g5ytP4hcjjw6TU+x6A1VkUcO16ht1mcRpbxYdqGvY/OCnF2oQxTLgqtd2/dyN78
	 HiEs2EzcjceqEtW6ZC0viQe+hGPMx3LINXkg01kaPFkymoU8pzPlcW1M8G5uc1RaW+XMj
	 kI6ua7jmENhjXgfh6iQlt5jbSOqCoepfZPWWZ1G0EYhvTHB6Kc377aBlANgzO/ykoig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SpUVYtkJ;
	arc=none smtp.remote-ip=95.215.58.113
Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E94606A8A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E94606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SpUVYtkJ
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mWIKGIZPEaOwQ4LZ6Wr/q8Uww1kSWDcn4ugrc7Q+8sk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794395515; v=1; x=1795000315;
 b=SpUVYtkJvcXFpdZVLLZuqwEq1PTuRhxWVJBJ6CunthERTXhZldhojATDbJ3nrtO+O2830eV1
 RwHuKeMa7AT34kJOA1B/dL0v4Vk4xOG6gRynxHoQ81vSMiYKNaP+dYDSkvjXpP/kT65WqzkT9w8
 /xpWR3QuXMJoL6vI7H9hckUI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1226d4e79ea8df7c;
	Wed, 11 Nov 2026 11:11:55 +0000
X-Mizu-Trace-ID: 1226d4e79ea8df7c
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 12:11:51 +0100
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Wilfred Mallawa <wilfred.opensource@gmail.com>
Subject: Re: [PATCH 03/25] xfs: always call xfs_update_stable_writes in
 xfs_ioctl_setattr_xflags
Message-ID: <avRM1f0Lhw-Y1uxf@quentin>
References: <20261104085929.317544-1-hch@lst.de>
 <20261104085929.317544-4-hch@lst.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104085929.317544-4-hch@lst.de>

On Wed, Nov 04, 2026 at 09:57:07AM +0100, Christoph Hellwig wrote:
> Currently xfs_update_stable_writes() is never called when the RT flag is
> flipped because xfs_ioctl_setattr_xflags() updates ip->i_diflags before
> comparing the rtflag variable to XFS_IS_REALTIME_INODE(ip), and thus
> the stable flag can be set incorretly when flipping the realtime bit
> on an existing file.
> 
> Fix this by unconditionally calling xfs_update_stable_writes for regular
> files.
> 
> Fixes: d528a6c1d4b6 ("xfs: data checksums require stable writes")

Shouldn't this patch be folded in to the stable writes patches?

> Reported-by: Wilfred Mallawa <wilfred.opensource@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index f81b6e52ac40..36ba609a2593 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -595,7 +595,7 @@ xfs_ioctl_setattr_xflags(
>  	 * Make the stable writes flag match that of the device the inode
>  	 * resides on when flipping the RT flag.
>  	 */
> -	if (rtflag != XFS_IS_REALTIME_INODE(ip) && S_ISREG(VFS_I(ip)->i_mode))
> +	if (S_ISREG(VFS_I(ip)->i_mode))
>  		xfs_update_stable_writes(ip);
>  
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> -- 
> 2.53.0
> 

-- 
Pankaj
