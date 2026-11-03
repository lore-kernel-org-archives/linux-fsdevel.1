Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694864;
	b=mPjIfGZ9rX1lNYo7llu/5pcVIUdLY9az9p+YkZQbcu9p+xcNE/dpkcwX9fcv/Zt3NZKT
	 KdOjQyvyHkKXFSfMLVJKFHbJc61pMwSrCEwBKJSEDjqWrSeAyhFQn0O5Gn8Spe65mctPG
	 sAwU62zhnfxoopRCYVlTbXJmaVwuYwGpqo50Pq/5sHrFrVRt4UNZLgtPydYgLoaTCoKjr
	 Y62RJXkSWdCgev2yG5f4cM022AERXDywA0ExpPIysjrmcDcCRuPtfYeGjJ/qJYO6cdhOF
	 h41vAvhex/7PK8xtfxkOgy5VuTYmtE8gD3K4eRV+9nXpKEGMDSgU3pSYg0Ew6H8svZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694864;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aN23VJMnhewW35EFlasRUP/lg6fg3jZoPm2+MgYcpys=;
	b=jEmBpJeX4O7RmiA2LAJnZKSlr+C/rRDww5jy7le4T5JyQCKQHTQgVmLSzAGpzAVpf1ou
	 kcrYFSWzvjbet+aiURijlRCvoWP2yPzEFW+QWQZ4AYIIadEAWBsY/qRFjygWnOL+pNF2G
	 ZFejZDrKSlAZbUtzNAlY9sdlpxsFRxi+ym4KNhJybTdEMm/vHK0tbZGPWZirCDoZPhOXL
	 Ck3ofVXSJYmHAgIMewW5n1wdbb2EuAWfwxvmH7dYNJr+Xv1GKScmUT3M5izrI5hBwrNX/
	 fB/+kq9zXVPh/IQgwHu8OmE5YC3ICPG2Mb9hEUvWIs7WQ9Kc23Wf2q7GrKaUHN7Tsgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBOLm89A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30884606A33D;
	Tue,  3 Nov 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBOLm89A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF291F00A02;
	Tue,  3 Nov 2026 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694864;
	bh=aN23VJMnhewW35EFlasRUP/lg6fg3jZoPm2+MgYcpys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBOLm89AFwFi8IKVAeRS7jeysXzyogNfn+p+fbL1rf1QBt3Zxg3/CWf/4PwF8AjJ5
	 YwD6VCr9pSdjp3MvVSrREbeBsfgPF3a1RD97c3PzrlJiIzmPvPZL0WjaW3r9AdNHaa
	 qMsQl5xEa5W1LsZfQxkqjaLzYNT8k+fX/Qskx8KMjt4KokItdq9433mvMAK3oo1IMG
	 VfS6LfCspss/z3XnogPK2QMaRXW52/5QJXrxI7J83/zHlASPGusI2dtAjkyktWZjOV
	 IujbpWEanzXE27yWs+vhB3zULLkKkMcVZo4XR6lnjjGAjh4BT1q7Ykt7AF3Gb9NRA2
	 2BABiVeJtVtzw==
Date: Tue, 3 Nov 2026 08:34:15 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm: remove clear_page_dirty_for_io()
Message-ID: <aumcgdzoPhuB6zQc@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:08PM -0500, Tal Zussman wrote:
> There are no callers left. Point the comments that named it at
> folio_clear_dirty_for_io() instead.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h | 1 -
>  mm/folio-compat.c       | 6 ------
>  mm/gup.c                | 6 +++---
>  mm/page-writeback.c     | 2 +-
>  4 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 692ce3867a1d..9adfeae2153c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1315,7 +1315,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
>  		__folio_cancel_dirty(folio);
>  }
>  bool folio_clear_dirty_for_io(struct folio *folio);
> -bool clear_page_dirty_for_io(struct page *page);
>  void folio_invalidate(struct folio *folio, size_t offset, size_t length);
>  bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
>
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 9f2cd0ebfbbd..13d4d39e1896 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -42,12 +42,6 @@ int set_page_dirty_lock(struct page *page)
>  }
>  EXPORT_SYMBOL(set_page_dirty_lock);
>
> -bool clear_page_dirty_for_io(struct page *page)
> -{
> -	return folio_clear_dirty_for_io(page_folio(page));
> -}
> -EXPORT_SYMBOL(clear_page_dirty_for_io);
> -
>  bool redirty_page_for_writepage(struct writeback_control *wbc,
>  		struct page *page)
>  {
> diff --git a/mm/gup.c b/mm/gup.c
> index 7d43ce717b24..335dcb3a5c17 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -298,16 +298,16 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>  		folio = gup_folio_next(pages, npages, i, &nr);
>  		/*
>  		 * Checking PageDirty at this point may race with
> -		 * clear_page_dirty_for_io(), but that's OK. Two key
> +		 * folio_clear_dirty_for_io(), but that's OK. Two key
>  		 * cases:
>  		 *
>  		 * 1) This code sees the page as already dirty, so it
>  		 * skips the call to set_page_dirty(). That could happen
> -		 * because clear_page_dirty_for_io() called
> +		 * because folio_clear_dirty_for_io() called
>  		 * folio_mkclean(), followed by set_page_dirty().
>  		 * However, now the page is going to get written back,
>  		 * which meets the original intention of setting it
> -		 * dirty, so all is well: clear_page_dirty_for_io() goes
> +		 * dirty, so all is well: folio_clear_dirty_for_io() goes
>  		 * on to call TestClearPageDirty(), and write the page
>  		 * back.
>  		 *
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0694ec4098f6..b56f2c91b0f2 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2821,7 +2821,7 @@ EXPORT_SYMBOL(folio_mark_dirty_lock);
>   * This cancels just the dirty bit on the kernel page itself, it does NOT
>   * actually remove dirty bits on any mmap's that may be around. It also
>   * leaves the page tagged dirty, so any sync activity will still find it on
> - * the dirty lists, and in particular, clear_page_dirty_for_io() will still
> + * the dirty lists, and in particular, folio_clear_dirty_for_io() will still
>   * look at the dirty bits in the VM.
>   *
>   * Doing this should *normally* only ever be done when a page is truncated,
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
