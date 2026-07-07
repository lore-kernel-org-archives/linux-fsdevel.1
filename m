Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615533AB5BB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407423; cv=none; b=FLcNjELSTOp1MtOtrU/GEVwE+Mv+qMYhf1l/o5+LP0K192ESthZObBjTMy7GsXPrYr9HXPldObajGKQNSjjHtc8gDCiAJp4A1RAAqZd0SYDPLdWXElCIFw+ckNoBI+UBWhn6Ip9JAa/XQCpopjqleyQm+7FY2dCzMnI4Q341S1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407423; c=relaxed/simple;
	bh=Yn6Q+8GnYlNXJzkpUayPJQNdvcW7QhLJ7slDTUH0s5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoZPryAD3bAXPsQ38M23Vi53cKzzOmz2YKVtuaI0cWZI2M2Xq+cUlRAqXnw+hlkOLSr22jw9OrYZV/gR06KjtRZx/Y3F4ZJPZmFsw6jPpWx5Kd53mx6JYy85sFa+JpOMZC++W3cGKlueti3QD0sVAgKw6Ac7Ebtohw7b8BLCjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A47IAmZm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqaJ/riC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A47IAmZm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqaJ/riC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783407421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0FBWE8Jb5+vMlrP70d2roSOjCV4VZTmyKyzdZd5y78=;
	b=A47IAmZm7FeS/wJVPxxVj7fHbJUZOlQ897si8dDMrjWMNFZXfldeznOxqpnO6tESzQSA9U
	AoNy6XEVfCDsRpkaW+g3kaghqdSDosaA9dWIQXlQzJ4wHXfnyTLTHWS19A+iKJDYDhdNqR
	HC3B+R1q3l7PIkaqoRBxJU8XH+tVh40=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-LVTBCR4KPf2MA_YsdnTZzA-1; Tue, 07 Jul 2026 02:57:00 -0400
X-MC-Unique: LVTBCR4KPf2MA_YsdnTZzA-1
X-Mimecast-MFC-AGG-ID: LVTBCR4KPf2MA_YsdnTZzA_1783407419
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472bdd6f529so2214649f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783407419; x=1784012219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0FBWE8Jb5+vMlrP70d2roSOjCV4VZTmyKyzdZd5y78=;
        b=LqaJ/riCRO/ceVIxkCsWnOgcLb4+3lgVyIf5E2cZzvP5D+TRSpkgD9gY+om4ERKLfs
         QIhaCsTW1+LxjOG4V6p6ZPJiPEmuVu5i6u/oBSzzf+TNT0T/SuASE+q+iCAtYQMq8AJA
         KDGWGMpJFBvTYOC7WdWiLQpKwxC8e0E7a/zTqDKVFDCMfFSUwindfdmNHnOAoQC8+1n+
         tdpSzou45uumEfxd3MkjF4JQFHx4yv4YAlB9yuGcx+BFVMXHg8NHwjB8UpVRcc0q99Uf
         rvwlKSv5TAWwXO5QQj1GsAdnPJRMBh7nG1cmg9/805bFVK588PXo2yJ0dfKED0p0JU3a
         lyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407419; x=1784012219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0FBWE8Jb5+vMlrP70d2roSOjCV4VZTmyKyzdZd5y78=;
        b=otPWNk1keTTuBKNxRqx02uyiBl9ss0haaf/OSxwrKGtvuI7sutst8T50rvCBUNqxHM
         cZaKvnUwxSy2+qPZ6sJPdSjF9WXR7lcP/CDzi5soBVodoToJcxXurOfK3b3szsOFmKiy
         Gab5xxnzlwiDFjSQbOKxTk4yPoypmWeE0/ZbVSYQDh5KtQnYCIaBMIPjXKAZN3xv2Gef
         9mIuYPthpX7En/11xbrypIA7nW0OBrwJld+3ukW3yeNwPXaVCN+HGAiwzvjCWJP+oXVF
         EY1da6ZY7cl2UE/uJFOqb5SEPkCtVLdWqubGgzh25JvoOB7bhWYv/BT8h6ph3S2VIxGM
         aXmw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5KwQF0dYINU0mFr4MLn4oIiVWXkesoUghZGaoV/5gMRsJca9iPn5jUpXdKZHomy0NLFN5jTr1oADrkDb7@vger.kernel.org
X-Gm-Message-State: AOJu0YxzswZSmll3vAjynXOxUK0/INt0uznmhjSeHV6AROWziQCn64QP
	dTwLCJcRJOabj4Toa9w8Hy4kZ6f6hCh+EpvUWf7qome6V/DXNCGrdUbNi7obCkiC6k/3S4DdUQb
	vUPlq93jqxGvP5ylrv+3dRVVxUkTpjYL+qIVQqXtOk5L4C3YQ6lnhZI8/RYUeILdkR/g=
X-Gm-Gg: AfdE7clI/1O0RcbW4/DB+6D65DACQ69Zx/qzaeAPpgd46gYHyUXC//l1N4QlfIko8fe
	38T0DWcEl3hzQSbm/gJCH5svjm9un5JJ+OAICXolwunot/IoEl7/ILpYLveLEQr/o/jPD71qrfy
	u3BveFluEXy0r63KOK7IBh5zOB+JOWr0NZzx9rOQdbH6nPhqhXdL2pxXGykWnYuo5Hgf/yyovpi
	/Uc+rCCEXRVGUgdq9TuccW8fG/dOMH7oOsFI/nUS7SENe3yhCnVrRrW33kurdVGcJ0CUtSiHNze
	gzg9k84xSgtLiCxevNGDnAzVonQwPaQ/U1V608kD+/cNEBnC7ZqloTEFDYUXd799fJPfGYLrkDy
	ujOADLO/x2L7M6D5TIC+0T2jsSTKOtRwW
X-Received: by 2002:a05:600c:83c9:b0:493:bc31:b2ae with SMTP id 5b1f17b1804b1-493df040597mr40628255e9.10.1783407418836;
        Mon, 06 Jul 2026 23:56:58 -0700 (PDT)
X-Received: by 2002:a05:600c:83c9:b0:493:bc31:b2ae with SMTP id 5b1f17b1804b1-493df040597mr40628075e9.10.1783407418369;
        Mon, 06 Jul 2026 23:56:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fc1348sm30919825e9.14.2026.07.06.23.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:56:57 -0700 (PDT)
Date: Tue, 7 Jul 2026 02:56:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sourav Panda <souravpanda@google.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, mhklinux@outlook.com, fvdl@google.com,
	gthelen@google.com, mike.kravetz@oracle.com,
	pasha.tatashin@soleen.com, rientjes@google.com, riel@surriel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
Message-ID: <20260707024744-mutt-send-email-mst@kernel.org>
References: <20260707064235.1386552-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707064235.1386552-1-souravpanda@google.com>

On Tue, Jul 07, 2026 at 06:42:29AM +0000, Sourav Panda wrote:
> Overview
> This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> backed by a kernel shrinker to safely return memory under pressure, and
> integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> specifically targeting gigantic (1GB) hugepages. The goal is to solve
> the tradeoff between allocation latency and memory
> fungibility in virtualized and heterogeneous cloud environments.
> 
> ---
> 
> The Core Problem: Allocation Latency vs. Memory Fungibility
> 
> With highly heterogeneous workloads, latency-critical applications demand
> gigantic hugepages. However, dynamic runtime allocation of 1GB pages
> from the buddy allocator (via CMA) is slow.
> 
> To bypass this latency, operators often pre-allocate hugepages
> statically. However, this locks up the memory: when the HugeTLB
> workloads are idle, that memory is completely unavailable for other
> buddy-allocator workloads (e.g., page cache, anonymous memory). If buddy
> memory is exhausted, the system will OOM even if gigabytes of HugeTLB
> pages are sitting idle.
> 
> This series resolves this challenge by delivering Dynamic Fungibility:
> 
> 1.  Dynamic Caching: Intercepts freed surplus hugepages and recycles
>     them into a NUMA-aware cache instead of dissolving them immediately.
> 2.  Fast Allocations: Satisfies subsequent dynamic allocations
>     instantly from this warm, local hugepage cache.
> 3.  Kernel Shrinker Integration: Registers a NUMA-aware kernel shrinker
>     to dynamically dissolve cached pages back to the buddy allocator
>     under memory pressure, restoring host/guest memory fungibility.
> 4.  Free Page Reporting Integration: For virtualized environments (Guest
>     VMs),

I was going to look into this part, thanks for working on this.

> cached pages trigger background Free Page Reporting via
>     virtio-balloon. This allows the host to reclaim the physical memory
>     while the guest retains its Vmemmap Optimization (HVO) metadata
>     savings (~14GB saved per 1TB VM)!

Why "!" - that's 1.5%, seems surprisingly modest.
Are you sure it's working as intended?

>   +---------------+   Slow Allocate  +---------------------+
>   | Buddy         | ---------------> | Active HugeTLB Page |
>   | Allocator     |                  +---------------------+
>   +---------------+                    |                ^
>     ^                                  | (1) Free to    | (2) Fast
>     | (3) Under                        v     Cache      |     Allocate
>     | Pressure                       +---------------------+
>     | Shrink()  <------------------- | HugeTLB Cache       |
>                                      +---------------------+
>                                        |
>                                        v (4) Free Page Reporting
>                                          (Host Reclaim in the case
>                                           of virtualization)
> 
> ---
> 
> Patch Series Structure
> 
> Patch 1/6: mm/hugetlb: add Kconfig and basic cache infrastructure
>   - Introduces the CONFIG_HUGETLB_CACHE option, hstate tracking fields,
>     and the HPG_cached page flag.
>   - Establishes the clean helper API (hugetlb_folio_is_cached(),
>     hugetlb_cache_remove(), hugetlb_cache_add()) and updates
>     remove_hugetlb_folio() to be cache-aware, eliminating inline #ifdef
>     blocks.
> Patch 2/6: mm/hugetlb: implement cache recycling and allocation
>   - Hooks up recycling in free_huge_folio() (up to the cache limit) and
>     allocation in alloc_surplus_hugetlb_folio().
>   - Implements MRU allocation policy for maximum warmth, poison safety
>     checks, and MTE/dcache cleaning.
> Patch 3/6: mm/hugetlb: add sysfs interfaces for cache
>   - Exposes global and per-node sysfs attributes (max_cached_huge_pages,
>     nr_cached_hugepages) for dynamic userspace control, including NUMA
>     memory policy scaling.
>   - Supports dynamic delta adjustments (+1/-1) to safely scale cache
>     sizes alongside concurrent background reclaim operations.
> Patch 4/6: mm/hugetlb: add memory shrinker for cache
>   - Registers a NUMA-aware kernel shrinker to evict and dissolve cached
>     gigantic pages back to buddy under memory pressure.
> Patch 5/6: Documentation/admin-guide/mm/hugetlbpage.rst: document cache
>     interfaces
>   - Documents the Kconfig option, sysfs attributes, and shrinker
>     behavior in the admin guide.
> Patch 6/6: mm/hugetlb: support free page reporting for cached hugepages
>   - Integrates the cache with the Free Page Reporting framework (virtio-
>     balloon), introducing the HPG_reported flag and the
>     reporting/isolation/draining lifecycle.
> Sourav Panda (6):
>   mm/hugetlb: add Kconfig and basic cache infrastructure
>   mm/hugetlb: implement cache recycling and allocation
>   mm/hugetlb: add sysfs interfaces for cache
>   mm/hugetlb: add memory shrinker for cache
>   Documentation/admin-guide/mm/hugetlbpage.rst: document cache
>     interfaces
>   mm/hugetlb: support free page reporting for cached hugepages
> 
>  Documentation/admin-guide/mm/hugetlbpage.rst |  34 +-
>  fs/Kconfig                                   |   9 +
>  include/linux/hugetlb.h                      |  45 ++
>  include/linux/page_reporting.h               |   1 +
>  mm/hugetlb.c                                 | 590 ++++++++++++++++++-
>  mm/hugetlb_internal.h                        |   9 +
>  mm/hugetlb_sysfs.c                           | 158 +++++
>  mm/page_reporting.c                          |  10 +-
>  mm/page_reporting.h                          |   6 +
>  9 files changed, 844 insertions(+), 18 deletions(-)
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog

