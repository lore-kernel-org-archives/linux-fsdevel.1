Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FC4BC005
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861539; cv=none; b=EPbWvFxFD7OUVwi447etx1SccgNgfoDAnmom/o6IeuJTjN3SDZQnfsYKp6VfQcNJlCMW+aQIK426hsP+fzfwGBuDAsV9UWPDXEkXjjbgIsr4+b61JJyVKSHnRFhLxrIpVJZru9XbEmIhjFQo2w3HYjZOv/rMIFNoGg8hORrcyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861539; c=relaxed/simple;
	bh=90JkhHKBkpgny6QuLx6EFPTSXfiM75N5KkwFKWeOD68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4qJTuIJ2vuMiSJM3/3H4DQ9HaOvow2rsRgaajqA3/CD5Y3karcUuJaK5AeleHCKoInapIEGchCojokSV3uBIv4lTrgmU66gH6ilmg+4cGaEvAXd/oOmwBYjk9Kt9M06fw6pfn71Jb3podJEZeTi6vV0BFJEe7BprHW7OMqAWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REnVVRha; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REnVVRha"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-85c9a79590aso4192431b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788861536; x=1789466336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQGSZC66g+9Yoa6kLt6wXStpLC35PhuHPWRZU7fWt5s=;
        b=REnVVRhahp18X1ozw5D8yPitro5uC6CM//Zn/Mk2v17BvvwRJauiHDiBTu7UIEw+B+
         iBI6GHKfh0cU6vEJrX6DkWhXCk/9s1xhe8MY26q/H4FNMIDU/iTwQwR7+4hllboMGCvO
         C5ERFtxW6XPxTNJullcnBBY2WHsMKNgXp20QcShWFjKB91bZHetps6ND4jkzuZ+3jdzm
         d+a15um9VQLElvQ0kOmiJL1mP2aS9XqaUAEVSwRsUwIv3WWwdYDmT9voootxABSJ+jcj
         9e6ONQ2gZczGGOP+pk2N/MW3z+QX82UhaypdoungeLe819jizYe2Vev5/7Wr+tQc1aO6
         LHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861536; x=1789466336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQGSZC66g+9Yoa6kLt6wXStpLC35PhuHPWRZU7fWt5s=;
        b=DhVqhPSHJ7PlDhqdaaYnMYV7xNM95n6tyIrlkRrP84aR+3V56TFji6HrC34HI/yima
         oGZQL9RCwcJ1DwUcT16f3K2JSW4v/EhszVvau+OhQxPnC76mLiWAtSi2V2H6svblhVh1
         SC3lA/j2X0nKzqzA+fca043tRJrGNKDqGY1dQHGCH1CpgHlWC083WhRxbN5AhHuAGshS
         P8ZhAvZOmpD7BPQQ1Xk5v+hXELGTyji+yulY8oIMKEzA4hC0HW9kwU1QVmkG3cz+baXK
         Aaw7Kr8/jVehCEjMK+yQtci5bOIpiDmm54TLrkf81oNfiB9gm+8gWCwtw/JHXpoIyUOd
         kT1A==
X-Forwarded-Encrypted: i=1; AKwUvBxeiVRfG5jlrDtF6pVo80FO4p5Ckp7CWI7vevPJg9iMdbJ63g9Tfs9zfHFnDp+50n/ErRZD5w+MVChBVHCJ@vger.kernel.org
X-Gm-Message-State: AFuF++meYqvUBdmAZ+MnMz4CmUV9QuqiLmvGec+aD3ZfuVdhETZkNG+I
	s8YidiDkTEVxR22svrCjerUZwvKfFMX81hFQTyuy6Qm8Z7wp0Y+cZbXc
X-Gm-Gg: AYBFou1gz6fESobHM0j0wb1ogwRSOHSwqyNwJsjNSzOz99AiZLB7SPkuDcpu/XSdm8f
	qp4u7Ozn//QZd+jg9BctHAGAxrgUX7Lg+YGCwi+aDr3rW3tnFs5iH81hPrqFLYXma0+Suzo43Bz
	bI4uuu3EVegmt5k9ac7A6uygHn5jVanTlGEpLUE8W+t+7MGRtomfICc+l5SikFvKbvRs7aLjs/U
	bp6lGuWn+qwNlctNSiGF8ncEE+swmoLyfQbtD0Ir/M0JMaX9L3C80fSZD3cZO6dg9z29rSIarpO
	NL2meNHywVnmtiv4uCeoMQKp5jqVhmMLZUOD6FdXEzxYj5IFqFSiqTXyLbDBLTMJ/PB4xZdLMny
	j5gvTbbdfydAVoxyh7deXisHzGreb2dvR88ihjYx085Rp+q0Ycx1SZFCxxsuvKkzdGqakYqy2G6
	T4Y22AgtQpgcJjNGCW1uXG+IXwunu2bOZ2k+y0Tby/FEOVehCal1jTX1+p5RE=
X-Received: by 2002:aa7:88d5:0:b0:851:b007:2fe0 with SMTP id d2e1a72fcca58-861677b22b3mr39152287b3a.1.1788861535407;
        Tue, 08 Sep 2026 02:58:55 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152d2ff5bsm5204514b3a.35.2026.09.08.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:58:54 -0700 (PDT)
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
Subject: Re: [PATCH v4 2/3] mm: swap: drop dropbehind swap cache folios on writeback completion
Date: Tue,  8 Sep 2026 17:58:41 +0800
Message-ID: <20260908095843.2365834-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825135209.3135169-3-alex@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 15:52:06 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> A PG_dropbehind folio is dropped from its cache once writeback completes
> rather than left for reclaim to find later; this is implemented for file
> folios in folio_end_dropbehind(). Extend it to swap cache folios.
> 
> The drop takes the folio and swap cluster locks and may sleep, so it
> cannot run in interrupt context. Set BIO_COMPLETE_IN_TASK on the write,
> as the file dropbehind paths do, and drop the folio directly from
> folio_end_writeback().
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  include/linux/swap.h |  5 +++++
>  mm/filemap.c         | 19 ++++++++++++++++++
>  mm/page_io.c         |  7 +++++++
>  mm/swap_state.c      | 41 +++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c          | 48 +++++++++++++++++++++++++++++++++++---------
>  5 files changed, 110 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8f0f68e245ba..29ec60dcae21 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -374,6 +374,8 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
> +long remove_mapping_reclaim(struct address_space *mapping, struct folio *folio,
> +			    struct mem_cgroup *target_memcg);
>  
>  #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
>  extern int reclaim_register_node(struct node *node);
> @@ -465,6 +467,8 @@ void swap_put_entries_direct(swp_entry_t entry, int nr);
>   */
>  bool folio_free_swap(struct folio *folio);
>  
> +void swap_writeback_dropbehind_folio(struct folio *folio);
> +
>  /* Allocate / free (hibernation) exclusive entries */
>  swp_entry_t swap_alloc_hibernation_slot(int type);
>  void swap_free_hibernation_slot(swp_entry_t entry);
> @@ -475,6 +479,7 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  }
>  
>  #else /* CONFIG_SWAP */
> +static inline void swap_writeback_dropbehind_folio(struct folio *folio) {}
>  static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  {
>  	return NULL;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d721986d5f46..040c97a121de 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1686,6 +1686,8 @@ EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehind);
>   */
>  void folio_end_writeback(struct folio *folio)
>  {
> +	bool swap_dropbehind;
> +
>  	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
>  
>  	/*
> @@ -1695,7 +1697,24 @@ void folio_end_writeback(struct folio *folio)
>  	 * reused before the folio_wake_bit().
>  	 */
>  	folio_get(folio);
> +
> +	/*
> +	 * Sample this before folio_end_writeback_no_dropbehind() clears
> +	 * PG_writeback: until then a racing swapin cannot remove the folio from
> +	 * the swap cache. Afterwards it can, and the drop below then finds a
> +	 * non-swapcache folio and puts it back on the LRU instead. The
> +	 * reference taken above keeps the folio alive across that window.
> +	 */
> +	swap_dropbehind = folio_test_swapcache(folio) &&
> +			  folio_test_dropbehind(folio);
> +
>  	folio_end_writeback_no_dropbehind(folio);
> +
> +	if (swap_dropbehind) {
> +		swap_writeback_dropbehind_folio(folio);
> +		return;

I checked the refcount handoff from folio_end_writeback() to
swap_writeback_dropbehind_folio(): the extra reference provides the
expected caller reference for remove_mapping_reclaim(), giving the
expected 1 + folio_nr_pages(folio) count for folio_ref_freeze().

The swapcache/dropbehind state is sampled before clearing PG_writeback,
and the extra reference keeps the folio alive across a racing swapin.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
KunWu

> +	}
> +
>  	folio_end_dropbehind(folio);
>  	folio_put(folio);
>  }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b23f494fcc83..586c79c3bb3d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -456,6 +456,13 @@ static void swap_writepage_bdev_async(struct folio *folio,
>  	bio->bi_end_io = end_swap_bio_write;
>  	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
>  
> +	/*
> +	 * Dropping the folio from the swap cache takes sleeping locks, so the
> +	 * completion must not run in interrupt context.
> +	 */
> +	if (folio_test_dropbehind(folio))
> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
> +
>  	bio_associate_blkg_from_page(bio, folio);
>  	count_swpout_vm_event(folio);
>  	folio_start_writeback(folio);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 07418fc94f00..231fa87cbbe0 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -537,6 +537,47 @@ struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>  	return ret;
>  }
>  
> +/**
> + * swap_writeback_dropbehind_folio - drop a dropbehind swap cache folio
> + * @folio: the off-LRU folio whose writeback has completed
> + *
> + * Context: task context, with the reference taken by folio_end_writeback()
> + * donated to us.
> + */
> +void swap_writeback_dropbehind_folio(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	folio_lock(folio);
> +
> +	/* The folio was allocated off the LRU and nothing re-adds it here. */
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> +
> +	rcu_read_lock();
> +	memcg = folio_memcg(folio);
> +	if (!mem_cgroup_tryget(memcg))
> +		memcg = NULL;
> +	rcu_read_unlock();
> +
> +	/*
> +	 * Gate remove_mapping_reclaim() on folio_test_swapcache(): a racing
> +	 * swapin may have freed the swap slot (folio_free_swap()) and dropped the
> +	 * folio from the cache, and it must not run on a non-swapcache folio (it
> +	 * would trip __remove_mapping()'s mapping == folio_mapping() check).
> +	 */
> +	if (!folio_test_swapcache(folio) || folio_test_writeback(folio) ||
> +	    !remove_mapping_reclaim(swap_address_space(folio->swap), folio, memcg)) {
> +		/* Raced: the folio is now owned by the swapin; put it back. */
> +		folio_clear_dropbehind(folio);
> +		folio_add_lru(folio);
> +	}
> +
> +	mem_cgroup_put(memcg);
> +
> +	folio_unlock(folio);
> +	folio_put(folio);
> +}
> +
>  /*
>   * If we are the only user, then try to free up the swap cache.
>   *
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 848bd3e5eee2..4cc3a3ed6db6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -780,6 +780,22 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
>  	return 0;
>  }
>  
> +static long __remove_mapping_unfreeze(struct address_space *mapping,
> +				      struct folio *folio, bool reclaimed,
> +				      struct mem_cgroup *target_memcg)
> +{
> +	if (__remove_mapping(mapping, folio, reclaimed, target_memcg)) {
> +		/*
> +		 * Unfreezing the refcount with 1 effectively
> +		 * drops the pagecache ref for us without requiring another
> +		 * atomic operation.
> +		 */
> +		folio_ref_unfreeze(folio, 1);
> +		return folio_nr_pages(folio);
> +	}
> +	return 0;
> +}
> +
>  /**
>   * remove_mapping() - Attempt to remove a folio from its mapping.
>   * @mapping: The address space.
> @@ -794,16 +810,28 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
>   */
>  long remove_mapping(struct address_space *mapping, struct folio *folio)
>  {
> -	if (__remove_mapping(mapping, folio, false, NULL)) {
> -		/*
> -		 * Unfreezing the refcount with 1 effectively
> -		 * drops the pagecache ref for us without requiring another
> -		 * atomic operation.
> -		 */
> -		folio_ref_unfreeze(folio, 1);
> -		return folio_nr_pages(folio);
> -	}
> -	return 0;
> +	return __remove_mapping_unfreeze(mapping, folio, false, NULL);
> +}
> +
> +/**
> + * remove_mapping_reclaim() - Remove a folio from its mapping, as reclaim does.
> + * @mapping: The address space.
> + * @folio: The folio to remove.
> + * @target_memcg: The memcg to charge the eviction shadow to; the caller must
> + *                keep it alive across the call.
> + *
> + * Like remove_mapping(), but stores a workingset eviction shadow the way page
> + * reclaim does, so that a later refault can be detected and the folio
> + * re-activated.
> + * Return: The number of pages removed from the mapping.  0 if the folio
> + * could not be removed.
> + * Context: The caller should have a single refcount on the folio and
> + * hold its lock.
> + */
> +long remove_mapping_reclaim(struct address_space *mapping, struct folio *folio,
> +			    struct mem_cgroup *target_memcg)
> +{
> +	return __remove_mapping_unfreeze(mapping, folio, true, target_memcg);
>  }
>  
>  /**
> -- 
> 2.53.0-Meta
> 
> 

