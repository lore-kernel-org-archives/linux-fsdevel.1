Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EF3370E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373016; cv=none; b=JSgTGF/d7KbOy/DRRprv5TYq/dJDtYmpYcF5ZJQXC26V+F8gZ5jwyLIKI4Wzqgylp0/chWfTDPpxXaXDWOIGmJqy0WOJlk+bVR5NI9oHGrwPQhyRjxpOxZ7Q1iGCNVIe0ok8VW24qen97BlKqA8v0phHy3MKEu3ddDVwC5lrM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373016; c=relaxed/simple;
	bh=99gaZikVxjCh6G8WrO6H9UMCYijbaPvMTNoWbq67yg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qde6vU9fv7w47KhIUlB3BMaoFEf9VDMDQxZTjenJbaqOeSzX7q0ujoazkBqU6ouTEewZswBfWYlmh4KrQcEF5A9JuhWW0B0WnQPaGMwtBsLOkWx1Z/5Lt119Lnvu7UjqXSZLWFVlYXvnG/4SMqXibwFz/SphI+suslndxaIZjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLJSdLgG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLJSdLgG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2b2c9eccso69335721cf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784373014; x=1784977814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+JTIaYOz+7gcFgWy0FFXbd8WURqImELiBdK9zTFHb5c=;
        b=VLJSdLgGCwrMkIROCbUwqKsjqfXMGjVb2qNdeDMuUi+0/TRv923xry7D3ZFUngGPDx
         Eefho4dkeukx1zr7/BP1YFQl8pZROGt024S+HKiToxw3FQnvZsaTjed0b3c0hRyoisBk
         Ehny7JzgwJoVMwCQeVVRoYBnKa5w8cm5tUE88G9daOixzP5sta1IWBohZJFBOGWqBUSv
         eX+sXfjjqYd5jMp8lq7YJ/UONdxf5d+Uhh3dN8r5FTWuC4z5WY0Xnrgzvn32Qm6T6XyY
         aESoMKIT7Wvj/Bb9gqRW0rt2U/cNiHNoP+UolntmwVm53ZIVwHGQ2KB7kY5Qn6lEe6t5
         oSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784373014; x=1784977814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JTIaYOz+7gcFgWy0FFXbd8WURqImELiBdK9zTFHb5c=;
        b=TmPxmQ1RuBPxPMyRJFxTMGy+QO7KgQe+0i+UBAviO+TzmeHduk+fahygvNgEUdLp41
         iTDXT4tj5Kx0uWtNNGP7FqVzcc8vyJg6IpfCxLLrLxoqlXYY/QTkBiRxZVg0AuLgPcr+
         tv42CIyov/SfP7VyhM4QLvqFj0dJw5kjp1tT2fheQP74Oa3BHzXTFkj0hhv5vZtxq6Kn
         Y7ydFmsXe6gCTSphFw2Y2baQXStIl5cDT3wiJrtQvIZJV61F2gquKExZYqdvVZfO+KjK
         NmEw8C4Ltw+/CmuvqAx5LCd47CgqicYivFxCVHN6qJND80r2WIRH9fvI/kCMo0duCCzP
         AwrA==
X-Forwarded-Encrypted: i=1; AHgh+RrvOKeS7BbbmEd1bvpAcyTgt8wTXGKASlTD8jbfADZCYpGluF7CNZ+G6XoaQq8i3dI4HmllUIn8MEtIaXOj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PKaSfStq/+ULa3tC1D1kH5iZt+pBoYqZV65vXgkPxqwmn6QT
	PJ5iaLfjgAvLf3XPOuC3R+ZGR6NUgPutcVcRDS28i365C05F3rKkueeG
X-Gm-Gg: AfdE7cljLgDCgQbPRDldywJAZYUZ6wcuWBuXehw7P4rDDijrskqlm4bAt3uSEkWJ8aS
	O2ewas1L/qYYeNntMCXOeHEiJil94AFu4ABuIUmsvzKMLggxb4aZzfeoPorD4CnWKc5VnOL0zd5
	Vleb9ktFdYBNod1NszZKepzyjCRu/Yk8qRSK5VgOUeaD+WWgimaPWEQjICBqTs8Chs0HRMTAlq3
	PSaCT1fBxLVV1Yh2ZiLkW8GabS7Hh8gsmOFxel8Xf+i9VxeSkaVf3j3y3IvS9yLE+JXrrhlerPk
	2AoWCiqjLXIF53jn5yJax82/SsSeTsBQ3Gpf1vgoho1I5TXm2hc5L5yUArAwQuFtpst0/nHSDZb
	WqcEylaTa9CQfdOV/8E+emjkFQfIjI268y/1ZVx1c9k0pjmliB51DZelly1GtsG2Zy2Ivyh28AA
	nOZdwUZKEoJYo1UxiE6jfjgPQ8x5rwSgRX6Xe6VdubBYwvsLJ1
X-Received: by 2002:a05:622a:614:b0:517:8e65:68ea with SMTP id d75a77b69052e-5213e28f73emr58880021cf.54.1784373014252;
        Sat, 18 Jul 2026 04:10:14 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f01654fsm31899181cf.19.2026.07.18.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 04:10:12 -0700 (PDT)
Date: Sat, 18 Jul 2026 19:10:03 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios
 directly
Message-ID: <altSA1zXhzvHPJYe@KASONG-MC4>
References: <20260718093723.153324-1-alex@ghiti.fr>
 <20260718093723.153324-2-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718093723.153324-2-alex@ghiti.fr>

On Sat, Jul 18, 2026 at 11:36:39AM +0800, Alexandre Ghiti wrote:
> When zswap writes an entry back, it allocates a swap cache folio,
> decompresses the entry into it and writes it out. That folio is cold by
> construction, but it is currently left on the LRU for page reclaim to find
> and free later. This wastes a reclaim scan and keeps cold memory resident
> longer than necessary.
> 
> For synchronous-IO swap devices writeback completes in the calling context,
> so the folio can be freed right after the write rather than left behind; do
> that. Because it is freed directly rather than through reclaim, it is
> allocated off the LRU: dropping the last reference on a folio still on the
> LRU would trip the free-time page-flag checks. A folio that a concurrent
> swapin has meanwhile claimed is left in place and reclaimed as usual.
> 
> Asynchronous and filesystem-backed swap complete writeback in interrupt
> context, where the folio cannot be freed; they are handled in a later
> change.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/swap.h       |  3 ++-
>  mm/swap_state.c | 17 +++++++++++------
>  mm/zswap.c      | 36 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/swap.h b/mm/swap.h
> index 77d2d14eda42..c617e5a0257f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -306,7 +306,8 @@ void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
>  struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
>  				     unsigned long orders, struct vm_fault *vmf,
> -				     struct mempolicy *mpol, pgoff_t ilx);
> +				     struct mempolicy *mpol, pgoff_t ilx,
> +				     bool skip_lru);
>  /* Below helpers require the caller to lock and pass in the swap cluster. */
>  void __swap_cache_add_folio(struct swap_cluster_info *ci,
>  			    struct folio *folio, swp_entry_t entry);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 9c3a5cf99778..048efc7ca612 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -403,7 +403,8 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
>  static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>  					swp_entry_t targ_entry, gfp_t gfp,
>  					unsigned int order, struct vm_fault *vmf,
> -					struct mempolicy *mpol, pgoff_t ilx)
> +					struct mempolicy *mpol, pgoff_t ilx,
> +					bool skip_lru)
>  {
>  	int err;
>  	swp_entry_t entry;
> @@ -484,7 +485,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>  	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
>  
>  	/* Caller will initiate read into locked new_folio */
> -	folio_add_lru(folio);
> +	if (!skip_lru)
> +		folio_add_lru(folio);
>  	return folio;
>  }
>  
> @@ -507,7 +509,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>   */
>  struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>  				     unsigned long orders, struct vm_fault *vmf,
> -				     struct mempolicy *mpol, pgoff_t ilx)
> +				     struct mempolicy *mpol, pgoff_t ilx,
> +				     bool skip_lru)

Compared to the bool skip_lru here, will this work better? (not tested)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8afd0b2d7c27..7ff5254b6ff8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -487,9 +487,6 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 
        node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
        lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
-
-       /* Caller will initiate read into locked new_folio */
-       folio_add_lru(folio);
        return folio;
 }
 
@@ -651,6 +648,8 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
                if (folio)
                        return folio;
                folio = swap_cache_alloc_folio(entry, gfp, orders, NULL, mpol, ilx);
+               if (!IS_ERR(folio))
+                       folio_add_lru(folio);
        } while (PTR_ERR(folio) == -EEXIST);
 
        if (IS_ERR_OR_NULL(folio))
@@ -692,6 +691,8 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
                if (folio)
                        return folio;
                folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
+               if (!IS_ERR(folio))
+                       folio_add_lru(folio);
        } while (PTR_ERR(folio) == -EEXIST);

It's identical code wise, just fewer arguments and changes.

Prehaps also rename swap_cache_alloc_folio to __swap_cache_alloc_folio
and update kdoc that caller need to ensure the folio won't be leaked off-LRU
and unreclaimable now.
