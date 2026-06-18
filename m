Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71140D58F;
	Thu, 18 Jun 2026 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752666; cv=none; b=utvAnJYBAywwIpGe+wh707gSK8gVK32k8qbFZSuvHuhBFSb2zv6TYGSmU9xp7jrW92WZu+T03t/JF9/qyhcJE7Kf7lmOTAezGEvE3Eqmi2LaYRSrQtKNgJsvzoDi82nymhxQodKrDTfHSTvJYbFFmrCrV6W5RojmXZu0HX/7xzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752666; c=relaxed/simple;
	bh=sMXFaKzUyenltIoT8ArJjM2uETAE3ZMFKGkNcCf5SaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrBnb2d1K7r0HdlJAJeUAZR8FU+gPv82IwyTV3wyOOBgtohHY1VjR0aOGQ4CPxkNcFDYqDTvPfT+e+jvO9tUTbcruIjQYaLbB3pZ5ls/h7ZhN+hHhVcSTUFWauNGIv6aJWrtzUObux7SmXtV+1qLA6LrF5ouD1QctSr5H/s0VFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSTOXZBP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSTOXZBP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZMErdMn4fM5ebZdMPM1RRaXcObZkMc91TS7uIUs86cY=; b=pSTOXZBPNn47f5sa0hrU86rnZZ
	dhO0ExGNZNCcgFdmDVYq1xaXOcGno63AyHMYTRIN3XEMcbZwfgYmE9SUBZgi+Q/yljvqAqe+PMU9X
	+1amRFqyojYA6GUe1unKeDjAZSXt3sfLs510o66SCVYAMdZ8IAqGY39lqSaqOOVnN2qvw+xTe3cs6
	5bhdQ2TNoKKIgV+hLGWccWF9JMfr5As7bCjSDmOiFb9xq/6TLOjNEFfv9sPiFGSxonUrLMTwvofqm
	5Yw9dHPf3IZZhPOvEAa0pEgALjLo0+FiWvJn3hXYC4Ne07j5KZaOvMRP5qWNz10EV5yBm9MjbU47X
	EjjmDasA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3Fl-0000000DjIP-2orJ;
	Thu, 18 Jun 2026 03:17:17 +0000
Date: Thu, 18 Jun 2026 04:17:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
	david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
	rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] hugetlb: make hugetlb_fault_mutex_hash() to
 take PAGE_SIZE index
Message-ID: <ajNjPblkO9Ka_4FT@casper.infradead.org>
References: <20260617172534.1740152-1-jane.chu@oracle.com>
 <20260617172534.1740152-7-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617172534.1740152-7-jane.chu@oracle.com>

On Wed, Jun 17, 2026 at 11:25:27AM -0600, Jane Chu wrote:
> Make hugetlb_fault_mutex_hash() to take a PAGE_SIZE-based index.
> This makes the helper interface consistent with filemap_get_folio(),
> and linear_page_index(), while preserving the same lock selection for
> a given hugetlb file offset.

Oh, hah.

I don't know that there's a better way to do this than the way you've
done it.  Unless we can just remove the fault mutex hash and use the
invalidate_lock instead.
