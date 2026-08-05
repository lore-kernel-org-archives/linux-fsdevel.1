Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CF37F336
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900607; cv=none; b=rN4RyV+jvoJVfZUQ6OSd+94tNdoqH7oPUpkgS8xhH3VVUUieEmLVvmxModlFT40oehnG77Ji3cNlwZcRZUM7nDMqLpuz4SCNgsYQBlQ11U2RtoWPv7gNd65cOOBrHStu/70k7L1tCBATAYdwywSY9+w851bYk9TwW5Yia7nTXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900607; c=relaxed/simple;
	bh=QkSsdRBrL50wmw+gyPwjyqZ1EplzsVx8orFDMgATbX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guvmccF2ULFhbVX1ccqt+q6dagCWKvQ4QInlqVIuWp5fUAycIGI0blhBOxly98AxxeyB9Nj417unXi9sVEGlUUq2bm6aeu1fWo/qWQJDyh05x9rVsxx/nTLAsq/yXFJxwwM+znINx1wkTojOnbdrk0PKrVOaVEx1GrFiROlpWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tU77d7C2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tU77d7C2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hhcN6fw6oAmRl5W71ZCi2rBApMIiJvica+dmVXD0F0=; b=tU77d7C27ycHl1FYQZi4KMTMbM
	dHzDRHojIkVHY1kKyBsuehAAUTSx+WOPekxb6uBus26/BG9RRdGCPwL3UM+DkuEf9z33JNb+vjIzj
	mlbHdunt13yV6EnA4BR4GvOM3lK4y6+n5EpOiZht4rf0Zt4Y4SFrMUfqKlYRGzf+oDbHwSEK5CNpT
	SD4dUaYxIyYOTXEsVHeTJ3o60h1bo4Bgcew8GyjegTngN5tM/OGcyc2G2fp6ajmbB1OjjcThF6k/v
	P8kLmJg/rQLKsyATDK44vJ6aY9Odq7/w/mxRoo66LqAuxzlXKVVbUbIxrhgDA7KQBl3IP7xKOBbW9
	8mD/FW0w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrSJI-00000008QnE-0xZL;
	Wed, 05 Aug 2026 03:29:00 +0000
Date: Wed, 5 Aug 2026 04:28:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 12/15] filemap: Remove checks in
 mapping_set_folio_order_range()
Message-ID: <anKt8joV7HtZ3Tks@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-13-willy@infradead.org>
 <anJYKOiKFoqLSTTo@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anJYKOiKFoqLSTTo@gourry-fedora-PF4VCD3F>

On Tue, Aug 04, 2026 at 05:23:27PM -0400, Gregory Price wrote:
> On Fri, Jul 31, 2026 at 09:07:57PM +0100, Matthew Wilcox (Oracle) wrote:
> >   *
> > + * hugetlb calls this with orders larger than MAX_PAGECACHE_ORDER.
> > + * Normal filesystems should not do this.
> 
> Any static way to enforce this?

Not easily.  We could look at mapping->a_ops and compare them to
hugetlbfs_aops, but this seems like overkill?  For such a low-level
interface with so few callers, I think the level of protection we had
earlier was just too much.

> Otherwise
> 
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
