Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F08427FBB;
	Wed, 23 Sep 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199738; cv=none; b=bybFdXyXs+cWODfNdDqlQ8K0EiGadaNl3XHl50zPB65EXgkCzTbdEWOAhTaf6kyH0e2j4KuYIeJ+Y7flqeF+IFxWnGjx86qWwXkpZ35bWOj6t2KIyrgn/MJ8MnbFhbM22zjVCCf7BtkcJXvMv+CJolhcg7SqOYn9pvLHeq1jHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199738; c=relaxed/simple;
	bh=u6pK8WWxgAS5aSXBypjoYgNFtTJptEjH9aEN/q6mC+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyAH2TuCoeVCX2dcCIoY5Qk3J1JMj4u7v+fvZ79AEDFQivIMlOVEuoVY7Uj9QvPqrgRXBRL9+bC1octl2ZqDbc4m1N8V9q7+Q+jkjlZ9G1S2xoE8rFS/AFQbSXRWFjjKGawnrbo7UAj+m1qKSLD+po9EF2QI451SnUDs1irFYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vGkmqUjw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGkmqUjw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u6pK8WWxgAS5aSXBypjoYgNFtTJptEjH9aEN/q6mC+U=; b=vGkmqUjwzn1tF6XDIzZN/SCaT6
	13tYRqeYwss47O2D0jAm9SXWBz0WBlL8Pu4ON8hNHYjXxQulSUsTywTyZ8G+6YD5wzekT3//lV1vy
	4pK4JkokcvY1F9zNtwYI5xT9cVqJxu+h99NVJG6K5bIkB59kV8/rdEe6fNc9Sk54XWZhr5mCIus/r
	LH5vjqEcpBfkrZbCRc1U8LhDlBnm7GPIuGt1vGJ1EU6kjkQEFAoefAf5PCfp16OWA9LZxNkDDY83h
	EpRUBq+/vc2D6KPau2hVWER+dhlrArBbEBCQiLfywuswSfgGMKI+s/5I7E3s1HfjE2BnUCAb4djYc
	t8bJMk2A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9UjA-0000000EXiK-0L1C;
	Wed, 23 Sep 2026 21:42:08 +0000
Date: Wed, 23 Sep 2026 22:42:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, jack@suse.cz,
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
Message-ID: <arRHr05gy_eu4WVA@casper.infradead.org>
References: <20260923211041.3127588-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923211041.3127588-1-gourry@gourry.net>

On Wed, Sep 23, 2026 at 05:10:34PM -0400, Gregory Price wrote:
> The folio, filemap, and bulk allocation interfaces currently hard-code
> ALLOC_DEFAULT before reaching the page allocator. Multiple MM series
> need to select allocator behavior through these paths, so pulling these
> changes out ahead helps both series avoid conflicts.

I really think this 'expose ALLOC flags' idea is wrong.
