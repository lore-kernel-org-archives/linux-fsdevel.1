Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E978F3A;
	Mon, 10 Aug 2026 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331604; cv=none; b=peLSOOpfplhbsPkTS0AVpnxHIa8BtMIu/TDkYq5FfBWyCUPV9hTrc19Hw+Hy44XgM4j82wt21fbu8JHVRLP8MPC8909G5UHT3T+v4bgEEMh5zmlRsWDHK76HFXzeg+4cpTURU25FwlC4i+c5983aOj+WmejOrgKguZdb2Gce09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331604; c=relaxed/simple;
	bh=GU1UG8pk/zK+MDuYzvCAXxtNmkgJ4isYrS0xvLiYF0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOmTI5WEJHWs/By/4cVKIXpMmSb3ANjC1sE9aAyxAUnzUIXG2iUgY5oelveT8zR65vz5Po5nlbk8LBZb3cyhqW1nalVz+oTtDLMYshSTfzL7ML5PzoyIZq4Dm2/NdGpTMOjaCdEJzuAspd+RrAbp4Xm5TvGmPYJfrIgpdWCveZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=skIQAoNe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="skIQAoNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2a1dvpSkcRACkkHB2Cu1hgAbZL4dDEVOnuwm526Fne0=; b=skIQAoNe8lRYuzKoEm3eay3Z5V
	iSpC+Oa23X2H4Y8f7fhcOC61bk/biFrMd6Mn3SRkgekSN6U4puQUF8b+5HouSwG09LE+QbF/fKwAe
	Glm+zSCGreKBsYnoKoRK0yCc7kAtcjG+xQViZCFZDjQDLBtYf39YyPPEUXiLXwrwoVsLnm1AMZwv/
	prOHAaHMNswVsmgD7iaWZBlsHXt93DZ1Vtx6as78ol9Cblkn/P4+EclqWQrczH0H0hcRg003dmYWM
	BlLVaaHKn/drAuWYFvdvi++jgZXLmWeeKUtBBQ0fXuykt8+je4+i6IlC4Ie7zXVcZqQmjcCkf3tUj
	dDyznD5w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtGRs-0000000ABKb-1O40;
	Mon, 10 Aug 2026 03:13:12 +0000
Date: Mon, 10 Aug 2026 04:13:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ayhan Aydin <nsd.project.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache
 prefetcher
Message-ID: <anlByPDZmvEhWeXI@casper.infradead.org>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>

On Sat, Aug 08, 2026 at 05:10:42PM -0400, Ayhan Aydin wrote:
> Following up on this RFC submitted on 20260725. I understand
> maintainer bandwidth is limited, so no urgency implied - just
> making sure this didn't fall through the cracks.

It absolutely did.  It would probably help to cc the page cache
maintainers (Jan added) and the fsdevel people.  You can find
this information in the MAINTAINERS file.

> For reference, the series adds an optional observation hook
> (CONFIG_NSD, default off, see PATCH 1/3) that does not bypass
> the existing ra_state / file_ra_struct machinery. All actual
> page insertion is still delegated to page_cache_sync_readahead().
> Benchmarks (interleaved ON/OFF methodology, i.e. same-machine A/B
> with repeated runs, SQLite full-table scans and buffered
> sequential I/O) showed an 18-19% wall-time reduction and
> +22.6% throughput improvement respectively.
> 
> Happy to rework the approach, shrink the footprint, or
> re-parameterize the predictor if that would make review easier -
> just let me know what would help.
> 
> Full series and docs:
> https://github.com/nsdprojectdev/NSD/tree/upstream-prep-v1

Let's call this a good proof of concept rather than a merge request ;-)

Architecturally, we're only hooking into the read path and ignoring the
page fault path.  Was that a deliberate choice?

I haven't spent the time to do any detailed analysis of your code,
but it feels to me like we should be doing something more invasive
and integrated.  It would be nice to replace the existing mechanism of
marking folios with PG_readahead, if that's possible.  It'd be nice to be
able to detect backward access patterns as well as forward access patterns.

Let's have a conversation about what you're trying to do, and see where
we go next.
