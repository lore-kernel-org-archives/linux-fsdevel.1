Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BE3B47DE;
	Fri, 19 Jun 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884080; cv=none; b=Q+8mIXPMo2KCqQdm7lZ9n9in+OrcidXKU4lXukewfVoILUPhABWKZVTWesEde9XoKjLDGhtP5f4Objd8UV4Vj0A63DdL/SHfexda7iwygzBRGFOLknwfqgCR+0wvDNVMCPR4Z3uyQ/isW344UklFJ7Iw6UhJ3aCImz48A6av2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884080; c=relaxed/simple;
	bh=E227lTxq5JSYWdYq25US8IiuZR5IqPbX0vsSl71AmvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWAK9aCsI8XXGqFlLqghdTbRV2GFwgQzZ4wMwdBPU7dTKOp22qykXQ8Up83QYNf0Z7FaXoJVo4zGJIpdhcfJNonZ7IyP0WONQeZp6YEVZh3EJQyGw2Vm/4a2+jEyQ6U/Oxc04fBjWfopNnv7v0CxvFdc2ms9U1uqu9cszD14WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=emnBCoxh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="emnBCoxh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qfKo2wspR7EV2HHC2+9uw3pSPIolUFG6rWkQIpzJlOs=; b=emnBCoxh4LtDZ70xdQKJ8Hlrdk
	Uq0jDdn+bFsf4zJPljL+uLVGPwNuGAPbXL5UKeGvQLWiFugRwCxYcI967LvulUqgFoDvhaKTvwayb
	KlkWEqqc9kx7Hj0B4vr7TW1EUAAtOnsRVQCYTuT8KB3AqzgvssMUAksOv7OzFfTffZoan/OsgnP7m
	hy1QgR0ua1HrxAealyxuHCYaThzdBZ9mKPwoPmBCNa6LvI2lzPvOt1wvAovuYBapdhjbSn0heHSg8
	vQSlzf4DLhFpEkirgOqiJQh0soLOAEIgDvKr5on62VYi8U2w6yx3OphQBY2BJ5HjyHwNzHhgHkz93
	RfKZRlBw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wabRj-0000000GTP5-12YG;
	Fri, 19 Jun 2026 15:47:55 +0000
Date: Fri, 19 Jun 2026 16:47:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Frederick Mayle <fmayle@google.com>,
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajVkq52q4VFsOkmb@casper.infradead.org>
References: <20260619112852.104213-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619112852.104213-1-ljs@kernel.org>

On Fri, Jun 19, 2026 at 12:28:51PM +0100, Lorenzo Stoakes wrote:
> This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> 
> This patch caused a significant performance regression, so revert it, and
> we can determine whether the approach is sensible or not moving forwards,
> and if so how to avoid this.
> 
> There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> PG_readahead on EOF"), care was taken to ensure that the revert retained the
> behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> filemap_fault readahead to VMA boundaries") only.
> 
> Fixes: 7b32f64bc512 ("mm: limit filemap_fault readahead to VMA boundaries")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202606181547.617a6967-lkp@intel.com
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
