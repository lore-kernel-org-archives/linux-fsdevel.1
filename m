Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B417BA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504241; cv=none; b=FTFDMMJaHVPfojWByznjkAmPxMm9dx5KKKqYjN3Ivsskc650jKQ9n3wNiQW+n+oTg3qbvEW8xDmLoImeccntMsw1sjGQ8cJn1u63GsokWSzRrwThXRG5zFuiKEiZgAJWQvSI8K96d75Y9n7BiHIJkVaSTc0J5CxnhtUkCxUdxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504241; c=relaxed/simple;
	bh=bCuKlm3VeKiLaUNXvNVTWcyvcuR3kiNNLGQKB6jFkJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVOXuY6SLdmIgii3lpGpx93q50MBpa4uyNzoLfBgBHbZyOICIuglDXsDXOQv8r/8DJ3v4hPp+a8qIjie3zvjKeTRTelA3BuEGnEdW1de2U0rDubGI+dKC+tijVbuEolTmLaavItevQgQwUkB5f/IAjVt+AWWlsDdZHzAZH0iQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jESuCKXI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jESuCKXI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vCYIMgw31hZoV2qq5ERN/QG4vp4AeM8BHPz7QOX0MIE=; b=jESuCKXIRU6xrbGqN1bg5HqDQF
	Yg5KSrNdxFdu+X4fDizUM7Tax4NAtCqgpjaa5PdGsIhHfQsanwnAt0OxMbZC6ygGk0CTcSYAI2dgH
	gGYLslMyzOaPXI7L3Y+AF1/hREquoQYcs+Eo9XqfqLP8HQ8ToLDe2ceK4KI/Ml57+Q6UG4lkc5HJa
	zwqeORvDraz9EdQEPrvzJmhyGpsvJZiEPXSiGmR2H9ZBdyNycLWKwMvgFCWKO42GZRbjcv3vWJTqA
	UM4x39vSdZQr0DFls4F/kJyvSc/2EuzUXoQKZc4JQbKA3KD+XrEgLNbrzQqMNEAfwkt7TT3UmVPUR
	k0igtWXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5dc4-00000004lF2-07Px;
	Thu, 26 Mar 2026 05:50:36 +0000
Date: Wed, 25 Mar 2026 22:50:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jack@suse.cz,
	willy@infradead.org, miklos@szeredi.hu, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: fix writeback regression for strictlimit BDIs
Message-ID: <acTJLJdrd_T-cOAu@infradead.org>
References: <20260326001337.828947-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326001337.828947-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 25, 2026 at 05:13:37PM -0700, Joanne Koong wrote:
> Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> unconditional writeback kick from balance_dirty_pages():
> 
>        if (unlikely(!writeback_in_progress(wb)))
> 	       wb_start_background_writeback(wb);

Yes, that looks like a bug.

> This fixes the issue by kicking off the flusher if wb_dirty exceeds
> wb_bg_thresh for strictlimit BDIs. This restores performance back to its
> original baseline.

What speaks against just reinstating the old-code as-is minus the
misleading latop_mode comment?

