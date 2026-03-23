Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FE1F5EA;
	Mon, 23 Mar 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774238285; cv=none; b=b9sb8VKx2zUEjibRGxrh3eiGRN0RCEtqGaFu2PTQ9h4untPlu2uUyVcFKgXSF/YAB8PMX8Y5LoI5KmOz/KjtnTrXu0wtDBNN2J44rgY2X/n1U0zg8eJmH5OhiWHSwH8aq3T8lmNEz1BRfihO9TF6YSuOck0st++qgYVzm9iV4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774238285; c=relaxed/simple;
	bh=uyxco4WFrB/+NmodqE/Q5ZJZbMOAmzmcV4zkYc1kzGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU/F9+jAw9lA+CKTYi5g9zAU/cjW3oS2TMEE3Vr2LJTOTKLhrgNkFtnvFvZjBqKoGXrFjYDndodjxqo/K5TV49NRnPgGLWRA9T9ZG+qVxrdzTzObzoW45wVA+bjQpOGpeuZQh4fsbbURIua5Y/H9wrCeaAyX9YewO/rVHsXbtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZVJzS6yq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZVJzS6yq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MyAW0tfdZa2oCYf8MeOfukS6HaEwPDs9Yzvpc6J1bRE=; b=ZVJzS6yqXttNMT8su3VS9i4N6v
	O/gH7tDNEDT7sKZjaq+LIG7oEhJtu833YyLrelCqld+G/pLjKC2ExueDmkBQ+jScgdfN5O3mcYV9T
	qBfrc7IvTvnK5CJZVVjQVTp5+gUGvB9ioMonawZwCPJuAHtdv9IFuPXKKHQaBuIHRDiH5o6IreEVA
	i6zi32mVoS6Snd26lX6t/gLD4mtjr8P5GvPnamWRd0LifBaImqsMXewwVImgwz1f25CLIlIWeHEEu
	BsAWRnJCBe+7Rd0WYyJ18ahvze9ZW37D64cEPhbMe8fTX6BvtOnSfMX2j1uObnQcr3xTk2PXXBMn5
	0A6XNDSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4WQJ-0000000BaLK-1rfD;
	Mon, 23 Mar 2026 03:57:51 +0000
Date: Mon, 23 Mar 2026 03:57:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Abhishek Kumar <abhishek_sts8@yahoo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH] mm: fix data race in __filemap_remove_folio /
 folio_mapping
Message-ID: <acC6P6ULWgxKXFiK@casper.infradead.org>
References: <20260322190319.85301-1-abhishek_sts8.ref@yahoo.com>
 <20260322190319.85301-1-abhishek_sts8@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322190319.85301-1-abhishek_sts8@yahoo.com>

On Mon, Mar 23, 2026 at 12:33:19AM +0530, Abhishek Kumar wrote:
> KCSAN reports a data race between page_cache_delete() and
> folio_mapping():
> 
>   page_cache_delete() performs a plain store to folio->mapping:
>     folio->mapping = NULL;
> 
>   folio_mapping() performs a plain load from folio->mapping:
>     mapping = folio->mapping;
> 
> page_cache_delete() is called from the truncation path under the i_pages
> xarray lock,

That's not relevant.  The important lock for maintaining folio->mapping
is the folio lock (see the VM_BUG_ON_FOLIO line in page_cache_delete()).
At a minimum, this changelog needs to be fixed because there's already
too much confusion around the locking rules.

> while folio_mapping() is called from the reclaim path
> (evict_folios -> folio_evictable -> folio_mapping) under only
> rcu_read_lock() without the xarray lock.

Umm.  First up, this is MGLRU-only code, right?  Adding the so-called
maintainers.

Second ... I'm really unsure how we want to handle this generally.
This could be quite the game of whack-a-mole; we have many, many places
in the kernel which dereference folio->mapping without holding a lock.

Perhaps they are all fine; but 12 of the 455 references to
folio->mapping currently have READ_ONCE attached.  That's a lot of code
to audit.

> The race is benign since the reclaim path tolerates stale values --
> reading a stale non-NULL mapping simply results in a suboptimal eviction
> decision.  However, the plain accesses risk store/load tearing and allow
> the compiler to perform harmful optimizations (merging, elision, or
> fission of the accesses).

I think the bigger problem is reloading.  As I understand it, this code:

	struct address_space *m = folio->mapping;

	if (m && m->flags)

could end up loading 'm' twice, once before the setting to NULL and once
after.  That's more plausible than deciding to load byte-by-byte, or
whatever else these "merging, elision, or fission" words mean.

> Fix this by using WRITE_ONCE() in page_cache_delete() and READ_ONCE()
> in folio_mapping() to prevent compiler misbehavior and silence the KCSAN
> report.

Just to be clear, I don't object to the patch itself, I'm just scared
of the consequences.  And the locking comment above needs to be fixed.
But please wait a few days for discussion to play out.
