Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3A3BA25B;
	Fri, 20 Mar 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022330; cv=none; b=VPb9D4RtecOewGRUpdty980L6pO9IjYqZfEDHgVIfWZ96oxWKWH9hHExPAEfGTDWXnos4V42XPugFFJopcnBg0MSEfyb/9xHf/tEBVKQQBT4CyR6vkQkAxj6M/GXHV1+XTiJYeF5XU6IbfNLB6DxNnvHm4xM9wdzp2LwlAHoWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022330; c=relaxed/simple;
	bh=Jks4S2s+gYjGzYQlaBdJRF/kTtEgf4zdlhySpwbJSfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy/wAMSM8kIHibzmzDJabasm1ToolPZ7njxr7HiwVYbu4T0AJvnTcdf+qaCqNGScZSdb7wLrIN/+O6IfzDRlIXu52/BOuSyocp0ykdFtD7M1Z8vAyWYmnR+amydUFOedtxxhe9bGKqU6hmR+BkL+Q6ae+JqbK7SfnLjvyM0MubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3L209Em; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3L209Em"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e0ttI541UQY84WArzRfOEWNiNuBFeazGDrQAgFDGq44=; b=M3L209EmfHhmhx8qXXSa3pll7+
	UWQpI0rPR5iUZxltAVuV53KVp8vgAVRpSTE5EYYh5kFJDTe+TiMPaeTD0IAVZO2s6+tz3tpomEkG1
	xNDpU9byINpbXVjau0BeY+o7fIMw7Dt9gO+cp/uY+yZAQXwC/STkijtxRTq5klqUtwGIfeOmrjjvQ
	z4JJ5ud+P6oY4/5472KsnT0vk2Xg1XTwqJ53ybDJAxhYJFlzLCinx/dVDR1QJfAZTYCkWJHozpoFj
	FLkiuEv+Pv4EKGdopZ3E56HXZi9Bn7GKrbgGrkBjnTRU/CS62KWOFDFTOc1UzIKP7CFxLG1q/S+yp
	QYz3oMvA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3cF7-000000080Fh-2VkZ;
	Fri, 20 Mar 2026 15:58:33 +0000
Date: Fri, 20 Mar 2026 15:58:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz,
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, brauner@kernel.org,
	catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
	kevin.brodsky@arm.com, lance.yang@linux.dev,
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, npache@redhat.com,
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
	surenb@google.com, vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@kvack.org,
	ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org,
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Message-ID: <ab1uqdcMBP1cBr7Q@casper.infradead.org>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-4-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-4-usama.arif@linux.dev>

On Fri, Mar 20, 2026 at 06:58:53AM -0700, Usama Arif wrote:
> -static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
> +static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr,
> +				       struct file *filp)
>  {
>  	unsigned long alignment = 0;
> +	unsigned long max_folio_size = PAGE_SIZE;
>  	int i;
>  
> +	if (filp && filp->f_mapping)
> +		max_folio_size = mapping_max_folio_size(filp->f_mapping);

Under what circumstances can bprm->file be NULL?

Also we tend to prefer the name "file" rather than "filp" for new code
(yes, there's a lot of old code out there).

> +
> +			/*
> +			 * Try to align the binary to the largest folio
> +			 * size that the page cache supports, so the
> +			 * hardware can coalesce PTEs (e.g. arm64
> +			 * contpte) or use PMD mappings for large folios.
> +			 *
> +			 * Use the largest power-of-2 that fits within
> +			 * the segment size, capped by what the page
> +			 * cache will allocate. Only align when the
> +			 * segment's virtual address and file offset are
> +			 * already aligned to the folio size, as
> +			 * misalignment would prevent coalescing anyway.
> +			 *
> +			 * The segment size check avoids reducing ASLR
> +			 * entropy for small binaries that cannot
> +			 * benefit.
> +			 */
> +			if (!cmds[i].p_filesz)
> +				continue;
> +			size = rounddown_pow_of_two(cmds[i].p_filesz);
> +			size = min(size, max_folio_size);
> +			if (size > PAGE_SIZE &&
> +			    IS_ALIGNED(cmds[i].p_vaddr, size) &&
> +			    IS_ALIGNED(cmds[i].p_offset, size))
> +				alignment = max(alignment, size);

Can this not all be factored out into a different function?  Also, I
think it was done a bit better here:
https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc/

+	if (!IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, PMD_SIZE))
+		return false;

