Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D03385BE;
	Sat,  1 Aug 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577142; cv=none; b=iR9YNJpjE34rbugcgKsX0R0ro/zX+C301Jx3t61kMH3aem2zW6hSbjg35BEKWSHZFeU3ezJnUgJyhqePGdpdEVEHYwFsUhQhQHE/mTnRVK6WauIa49kfGDH2pl6nemyyFaKrO9vcCmMdDQzu1oQHznFA8Y2ZwUuIZYUaf80ZyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577142; c=relaxed/simple;
	bh=US+tHNfDLDaOOgxmcfBx0ru06BFe045MJ85TLQidPQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSmjYcr9LuxrCt0i4mVtjbBcbm4v1Su+OoQUsVPQhopN1xQ4N5gyqW9GAHILt4rBi9Nf9p3rOo6iuKZ6zDk6CS8x2Ys7a+RwCKLyw71Zq3LaVlhZ5xn9MOtujEPJsG8iwOXuIxEq9ywX4TkSsT3nc2hRw/I5H3BSi3VHh8v0++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY4rkb5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY4rkb5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3737D1F00AC4;
	Sat,  1 Aug 2026 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785577140;
	bh=NxA8VWrunDgS1luoqRhJB3bAyaoBECbm4t0+Dmg1kEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DY4rkb5d8EEpTxyH4OY81TtCvtKiSxqCnP8vJQM+E9mOCrfgxUEGj0pIoJ2rd+8xl
	 FGpETVcJE26MQ3qzJX98cGzMsxfSBBy82qIAjvd34hZeuUuf2DyCODN1bDWi1VkxsQ
	 FiUWBZwdFGI7Tp44jAPLUu/O3tRPDNHnHjKMs8nyAq6YKwY7sXy1goZ2ppHkz5spZd
	 BpvOOtuFX9yJ+wCmadUBzu0vqkRqT9jTI9roOs1bCWIpAyoLYn+w/zvYKwNBXrKEdr
	 qbPyMy8VNC/VFgM+ixhVelOxvZ4ggZVIddLCZQSTcV24F7PjyQ6mn5nREkuhFwGDsI
	 IjV3QWiaDba3Q==
Date: Sat, 1 Aug 2026 10:38:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] xarray: honor XA_FLAGS_ACCOUNT in
 xas_split_alloc()
Message-ID: <am2-HmShC6VXP_-G@lucifer>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com>

On Thu, Jul 30, 2026 at 10:18:01PM -0400, Zi Yan wrote:
> XArray operations that allocate xa_nodes, such as xas_nomem() and
> xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
> This charges the allocated memory and avoids the workingset convergence
> issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
> regression").
>
> xas_split_alloc() does not have that flag. Add it when necessary.

Nit but maybe 'split' rather than 'have'?

>
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")

Cc: stable?

> Signed-off-by: Zi Yan <ziy@nvidia.com>

Makes sense to me so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  lib/xarray.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9a8b4916540cf..bfe7bef80f34e 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1053,6 +1053,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>  	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
>  		return;
>
> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +		gfp |= __GFP_ACCOUNT;
> +

This is some confluence of flags :) I wonder if there are other places we've
missed setting this for?

>  	do {
>  		struct xa_node *node;
>
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
