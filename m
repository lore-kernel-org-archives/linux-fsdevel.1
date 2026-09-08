Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D380521238
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860247; cv=none; b=arl3iZ004t/sd3Y/ZbEh282jKE/9DR/dtNkchRUos1nxq1g+scvqERFrDc6+LgAD8CLI8MS6vWBljrbc/NSjRsYwI0sjqqNBzVSPq8eC97S5IQTdIpggbIiBDKHOvoQb6mKIy3QpwuUfQOTp/M4FLGMV7tkD/GrazTRImXI/H/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860247; c=relaxed/simple;
	bh=HvxZtc3mr9i12qOLGEDlGRfFFykU81xPzVzA7iGQRMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8LGgbZA6d9W06boldsQuEFW3UJ1ubnvv0QlYBQoax2z5VZ4uCkRIod1GpL+tYB3RsvbTzo9NklZGTsgF9AwTZBU5MiAmXujZoeGzIhDAgzZ32/ii1qJYATHM8E0cGzCVCOHAvtWMY7h31Ymb0JdpEdCRfbInqanbY+vb5Dx2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOVTGmi8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOVTGmi8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85c9a79590aso4177399b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788860246; x=1789465046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jdo8OnRnaSJ+QK5iLvvBRCC1dMO84Sr5WG2RzM3Vkaw=;
        b=YOVTGmi8Lz0PfQvS99ehQWKsOOwtEGHFRwKiGZ1bppImrvR6t66w6JnCSHww2wXkb6
         H7yJ2LajLXhcLPhexpMfZzsL3K5FYwEs+cLCL6HfprKkQqi87KBQn3yG8bIVo83/72ns
         4mYLtV7vTDIMFEoCL/MafzuFCOmaHWFeAYstEqvd6uqhYBFcBkM9MHmZEJ0Y9lWMB4Cq
         r/06HFlNsUNzjfUhk06kg8W4GLkfeD/bkGfqHStDH3ez2h9cnPXVpoH0KT1T5ytiK1GU
         WE9Bl0KhAKlZBPxph4gFB73o/u/y8QeUwbDVt5ws+FXBDT7sR5lUUdJ5uqanfG+X+d+V
         k1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860246; x=1789465046;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jdo8OnRnaSJ+QK5iLvvBRCC1dMO84Sr5WG2RzM3Vkaw=;
        b=VNlIZe9EgHyt1NmDq004yhx2bS43b3/o+7Zx5NqnAwjo1nif8WbJL0W5tYUWDpuOiE
         765yJkHlund3/f/fzuc/jPh2L4XCpgEpME92ZOpi473W5/PKaCedYNIxfTxFNLzuvWWx
         eP8OLPcpf0G7MvX6cZFtZrLkLzM7wXlCBz2ns1VK7kFdcZhVE+xej/8RoSlvX8zDE7l7
         QbML3y/kGfkqx48ArN8SNBQ/C3bKtjfFWbtFrydZAUoBTm4KhO78Y4ERAJTXzhMGSW+T
         aZxnUtVs1aB+Dw/U0YSmmcwiaYsYEtbZyyt05UT7NQu+BYpJNyGCE6/sC4k7s4nCiIkB
         Bz3g==
X-Forwarded-Encrypted: i=1; AKwUvByI6m1QH5DCNVKhJzh/zMMZfkfiPuHVW8JS2LV71JsXqRHzEO708lSPo5LeSVaOdhhei64YUwbeH9jz8qg9@vger.kernel.org
X-Gm-Message-State: AFuF++mZav9JaLiAl5cUcjfq0IFk4QsEmKjAIrngX4N4LeBKPyRtiy5e
	pjIJ6vyAko8OF3In9U1yLvAUqpCRFm0qP8Qfp2iaJTPRFp6b4hxb2IU0
X-Gm-Gg: AYBFou3SayPlhNopMVV6pMRjTwB0yOTVSdr3jJvqIaryIRKxfkh6MWaYsHARpdgr9nt
	2c1A7AyZEloVaMwrhhDizjo2h2+KDuBG+z+qGbIfGqSf49EycnUYq+ylQB4N3YRYdOdRGtTerM0
	AArVKc0gEvGdjJPPhyFMy0V88SETd+GsJVTloQR6uAr8NMbklMcIi1ecybT8XNyyXkPtgcu/9nq
	St+baFzZPPnmt0xxUEX9x+Sqnm54LHSKTDg5Fv605wyNo0NhWSyy4kwhYlvOwB5j9M8iAWEfjBn
	KAW2PkAQL7a/Q/7XHtqS5a9/4Gtiyp6cMUfdjzjyD1CRxeQnvj+uYjIV+5L8ouQH1S1CInuuNWd
	5vBwDMJsel7dTkxYgEJCb3XDAwvGPJ5knh2TbRAsB46VxjspYM2wYEOLnVrDXTDgL/gfzl8FTIc
	Q4SqmF3a6pYjGu83G6q0hoFaFeY5hXq1tHaNuqx4CPgFaWtP48VgqRgSn4j7k=
X-Received: by 2002:a05:6a00:f94:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8616ac58363mr41402529b3a.21.1788860245006;
        Tue, 08 Sep 2026 02:37:25 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615292d875sm5324180b3a.25.2026.09.08.02.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:37:24 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: swap: move LRU insertion out of the swap cache allocator
Date: Tue,  8 Sep 2026 17:37:00 +0800
Message-ID: <20260908093711.2364516-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825135209.3135169-2-alex@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 15:52:05 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> zswap writeback wants a swap cache folio it can free directly once
> writeback completes, i.e. one that is not on the LRU (folio_add_lru()
> stages the folio in a per-CPU batch that holds a reference until it is
> drained, which keeps remove_mapping() from freeing the folio on
> synchronous devices, and likely on asynchronous ones too).
> 
> So defer the LRU addition to the callers of __swap_cache_alloc_folio(),
> no functional change intended.
> 
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/swap.h       |  6 +++---
>  mm/swap_state.c | 20 ++++++++++++--------
>  mm/zswap.c      |  5 +++--
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/swap.h b/mm/swap.h
> index 77d2d14eda42..fc44daae1de1 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -304,9 +304,9 @@ bool swap_cache_has_folio(swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
> -struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
> -				     unsigned long orders, struct vm_fault *vmf,
> -				     struct mempolicy *mpol, pgoff_t ilx);
> +struct folio *__swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
> +				       unsigned long orders, struct vm_fault *vmf,
> +				       struct mempolicy *mpol, pgoff_t ilx);
>  /* Below helpers require the caller to lock and pass in the swap cluster. */
>  void __swap_cache_add_folio(struct swap_cluster_info *ci,
>  			    struct folio *folio, swp_entry_t entry);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 727a17ee7821..07418fc94f00 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -483,13 +483,11 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>  	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
>  	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
>  
> -	/* Caller will initiate read into locked new_folio */
> -	folio_add_lru(folio);
>  	return folio;
>  }
>  
>  /**
> - * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
> + * __swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
>   * @targ_entry: swap entry indicating the target slot
>   * @gfp: memory allocation flags
>   * @orders: allocation orders, must be non zero
> @@ -501,13 +499,17 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>   * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
>   * @targ_entry must have a non-zero swap count (swapped out).
>   *
> + * The returned folio is locked and is NOT on the LRU. The caller must either
> + * add it to the LRU with folio_add_lru() so page reclaim can find it, or free
> + * it directly once done; a folio left off the LRU is unreclaimable and leaks.
> + *
>   * Context: Caller must protect the swap device with reference count or locks.
>   * Return: Returns the folio if allocation succeeded and folio is in the swap
>   * cache. Returns error code if failed due to race, OOM or invalid arguments.
>   */
> -struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> -				     unsigned long orders, struct vm_fault *vmf,
> -				     struct mempolicy *mpol, pgoff_t ilx)
> +struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> +				       unsigned long orders, struct vm_fault *vmf,
> +				       struct mempolicy *mpol, pgoff_t ilx)
>  {
>  	int order, err;
>  	struct folio *ret;
> @@ -643,12 +645,13 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
>  		folio = swap_cache_get_folio(entry);
>  		if (folio)
>  			return folio;
> -		folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
> +		folio = __swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
>  	} while (PTR_ERR(folio) == -EEXIST);
>  
>  	if (IS_ERR_OR_NULL(folio))
>  		return NULL;
>  
> +	folio_add_lru(folio);
>  	swap_read_folio(folio, plug);
>  	if (readahead) {
>  		folio_set_readahead(folio);
> @@ -683,12 +686,13 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
>  		folio = swap_cache_get_folio(entry);
>  		if (folio)
>  			return folio;
> -		folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
> +		folio = __swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
>  	} while (PTR_ERR(folio) == -EEXIST);
>  
>  	if (IS_ERR(folio))
>  		return folio;
>  
> +	folio_add_lru(folio);
>  	swap_read_folio(folio, NULL);
>  	return folio;
>  }
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 761cd699e0a3..8163e6c5f76c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1000,8 +1000,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  		return -EEXIST;
>  
>  	mpol = get_task_policy(current);
> -	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
> -				       NO_INTERLEAVE_INDEX);
> +	folio = __swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
> +					 NO_INTERLEAVE_INDEX);
>  	put_swap_device(si);
>  
>  	/*
> @@ -1013,6 +1013,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 */
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> +	folio_add_lru(folio);
>  
>  	/*
>  	 * folio is locked, and the swapcache is now secured against
> -- 
> 2.53.0-Meta
> 
> 

I checked the callers of __swap_cache_alloc_folio(). The regular 
swap-in paths add the folio to the LRU after allocation, while 
the zswap writeback path keeps it off-LRU for the dropbehind 
handling in patch 3. 
The new allocator contract is preserved by all callers.

swapfile.c still references the old name in a comment — minor 
consistency nit.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
KunWu

