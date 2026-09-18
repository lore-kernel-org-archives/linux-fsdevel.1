Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB50384CD5;
	Fri, 18 Sep 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738232; cv=none; b=frx3BpLDDP7WuzflyCQ38+H7pnbKlF7XsP4DTIg6kZ8Zdz8lWgjzAFoPykbq3bDkdQSzyF28pz7HnCUJW8a2FOtQSUHE8n5Yv6+41Oz2CQi86JC4UXvHBtUjv+Ql+r6MItZC0FMY4sk4+36IfaBYlIV8E7CQP4NTl6Av2NJgvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738232; c=relaxed/simple;
	bh=w3lReXcXwzXgLGHHpkm0oa3fL+PEqvfsttWns67kq6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWUPt+MRHNfDdE9SxLIvk3NOZuDboAJmm8Nb16kIltkSr0tPemyk7a4c/IjjUTc+qXpoAWIoYEKdU0K7rMCCVF8xyKlTK8kMZtHy5hacTy2rWfiUDnmmx1nwM7oK0N9s5nkyW2S0rRykSmZzdqVZOKPtGd7/Fz5UQBw1bRVAZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA66E68BEB; Fri, 18 Sep 2026 15:30:26 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:30:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 3/7] hfsplus: take the bitmap page lock for
 allocate/free
Message-ID: <20260918133026.GC18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-4-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-4-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 04:39:37PM -0700, Viacheslav Dubeyko wrote:
> The hfsplus_block_allocate() and hfsplus_block_free() kmap
> the allocation bitmap's pages and modify their bits in place
> under sbi->alloc_mutex, but without holding the page lock.
> That leaves the read-modify-write of the bitmap bits
> unprotected against a concurrent writeback of the same page,
> which can read a partially-updated bitmap word or race with
> the dirty-bit update.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> +	lock_page(page);
> +	folio_wait_writeback(page_folio(page));
>  	pptr = kmap_local_page(page);

Although this really begs for a folio conversion rather sooner than
later.

