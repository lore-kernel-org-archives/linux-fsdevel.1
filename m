Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6E2BF3F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896705; cv=none; b=dlQoQnSl/luymwAyCN9nnLb6NVTOXXshQFJnv1gQwIvN8QjVlYumtvbQICzgRe5KmDbxjHM6g9NiDWuAmYnt8No/7Wgso1mREVMwG00OZudy175yi7FPCpJJfq7v3fXL23Ott44nySx92T1MVbOTice+s1c1So47AGEUVKJjSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896705; c=relaxed/simple;
	bh=QANfhdZNuKjex7lxBL+hNMd530bHWIrRVU38ujJ705U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfTJxrGWm2WSL9imobvlG+jJp3KVFWCeTdUMKKOUQ3DRDeH3OGAqXi2TqCybYbLySRtgHD9arIjF1GUyYSmsLyw5t+sa/us68IqSyEmI48wGsYAJQMkVNMaAddCxjDAiFATJj8wYx2wSmxzaWpxCRq5OkrSoFZgurVlLZGyRRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nCyA3CP+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nCyA3CP+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vq7TzUbO5PV2JAWC/OnBXO7UIclCBHAcBwXIj2BzCok=; b=nCyA3CP+KfPkOhjwRLdRTOnXn/
	Uz+MmYw+jRsvtGISfpyETCFyVq9TooziFqrxGTx3Gn3bwkBvYrF0cQNuXtekCpCVx33dXUQ9SzYF8
	BRN8cdOnssriTA6Mfad74AiRuWm+60XnFkz8kVXhH88tImwM/XK46dj8jg3OFpRixWuu/xL0m5EIw
	ih5Dn5npBtGqfo5zFLMWUYp2McfLEvFq7L+QjRQ0T2GI/KWksGzsJ12bFAi9lGCuDNEHzXPw5gR2H
	kCbLntV4SZaTV+uusRuwsTo/XPmjgoVnykiyFavp07A5lyBFsMU2zg9Ul8KueWZZSvV8hsduQQCna
	PxFpvmew==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFAC-00000003T94-2zvZ;
	Fri, 24 Jul 2026 12:38:04 +0000
Date: Fri, 24 Jul 2026 13:38:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v4 04/14] hugetlb: Mark some function arguments as const
Message-ID: <amNcrLJ8QTa-DvDy@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-5-willy@infradead.org>

On Thu, Jul 23, 2026 at 03:30:21PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions do not modify their folio argument, so we can mark them
> as being const which will allow for some minor optimisations and let us
> mark other function arguments as being const in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Sashiko finds no issues with this patch.
