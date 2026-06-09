Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4053194AE6
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995757; cv=none; b=tf7Z8xrcQ9x42Kc/g7oVD7Uu3GTy7XAHItOcQpSzvfxNBVD0LdBAxOqcD4Tyu0SmiOomiNFfDL/t97Hmz//4Y/tpkFCAw8XdUQRwl3nQH+Ti/j8On/Ga+d6h+A7mPHwWCsxiSStYt47CczZnOM+UaJnPCEaTyIt9phwzOfkRm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995757; c=relaxed/simple;
	bh=xZTvEBLbxtBpXTz0bEuWvNUwElZ8rLMCRoqfdm7dz/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0Xly4hoCg4Fy5jKLj77eVujXYXkm4qKZm+2aW2SyaA/rEMXMn1SqfrZT6aNpIcc00Xpj1elNf6yR5JHiJz7wRLPbLWlWUnmjabu8y0NYyhQVqQeH0+e241eREw32lvdaMszv6uMC15ikg/MF7R6hFipzziCWoDCoK0s2IblkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dsLDsInS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsLDsInS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GC+JFhsCFvp9I/Y1vIdUPY4ekT1XSIP7QJ8l6HwbvF0=; b=dsLDsInS9LgdI49BKcSHqGKzP5
	RUD0cSBudcKScGPIp4griuRcI+vx7ZBC90UCwVLQINp3UPJJeW3UVDvaHup0rAZ+vmozbwhoTt5eN
	WGruOqfXRt4d+GwJYOn7UHj3aoFbnNsz0+bVvqs3HvEEcz/m8IVzAVW+cBuydAP8G7ZGTTawReOtK
	8r+Aoi2Z08gpZM0iRcgKPXA+6mqjRLQKDQLy7hMZSd5akZv2iE6oI1OuAbqAL7w9Za4bdShYVsQx9
	6oRE+UHYhEMD3+o1Q4Y/gU8cpSOA0xusbruF7C2Eksu4GILWR9wG4UuJqcSC7zdyVuhLMoRAXP+fv
	OG3ge6qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWsLw-000000058d3-11W1;
	Tue, 09 Jun 2026 09:02:32 +0000
Date: Tue, 9 Jun 2026 02:02:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Andy Whitcroft <apw@shadowen.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: increasing PAGE_ALLOC_COSTLY_ORDER, was Re: [LSF/MM/BPF TOPIC]
 Memory fragmentation with large block sizes
Message-ID: <aifWqFpSkcMU31UO@infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <aifAm1rRKF75HVeM@infradead.org>
 <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 10:39:14AM +0200, Hannes Reinecke wrote:
> With 32k block sizes the picture changed completely; the 'bump'
> vanished, and there was only pronounces spike with 0-order pages
> (about four times the size of the spike with 4k block sizes).
> 
> This led me to assume that compaction broke down at 32k block sizes;
> this assumption was confirmed by Vlastimil Babka who pointed out that
> there is a maximum order to which page compaction is attempted:
> 
> include/linux/mmzone.h:
> /*
>  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
>  * costly to service.  That is between allocation orders which should
>  * coalesce naturally under reasonable reclaim pressure and those which
>  * will not.
>  */
> #define PAGE_ALLOC_COSTLY_ORDER 3
> 
> and it's main usage is 'order > PAGE_ALLOC_COSTLY_ORDER'.
> Which ties in directly with what we're seeing.

Yes, we've also seen similar issue with memory allocation beyond
PAGE_ALLOC_COSTLY_ORDER.  Right now the maximum block size supported
for XFS is 64k, and there's various workloads for which we'd like to
make use of that.  Increasing PAGE_ALLOC_COSTLY_ORDER to cover 64k
allocations would be extremely helpful to make it perform well.

How has PAGE_ALLOC_COSTLY_ORDER been chosen?  And what would it take
to increase it?

> It will probably make sense to align the maximum block size which we
> currently support (ie 64k) with this value to ensure that compaction
> works with larger block sizes. Or maybe even the other way round;
> tie the maximum block size which we support to PAGE_ALLOC_COSTLY_ORDER.
> But that would mean to restrict the blocksize to 16k, whereas xfs
> works happily with 32k. So we might want to raise PAGE_ALLOC_COSTLY_ORDER.

block sizes larger than PAGE_ALLOC_COSTLY_ORDER work, but it doesn't
perform great.  So I don't think a hard limit would be good.

> Question is, though, how could we measure the impact?
> This particular value has been in since 2007 (commit 5ad333eb66ff1 'lumpy
> reclaim V4'), and it might well be that the original
> reasoning doesn't apply anymore.

I've not even seen much of a reasoning for picking the value in that
commit.  Or did I miss something?

