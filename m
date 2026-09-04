Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0383C5522
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538215; cv=none; b=Ok41uS8gY7Yy5dhXo4hIP2tlPXMAQPvzWViC/yE40nP4NIJ2vRaKsYJYS+Qfc5QSMjQoC1iZ0tZygXDZ2Ge3YQBPjz0gi+ltkpRfDlEHv9ZZgRVB/Js9Bov1+bmfo9LotjmdtypORbCkl6MzcuPrW1CVHeQjx/1P4Ar3JSgVfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538215; c=relaxed/simple;
	bh=P2rW3hKxGUs4nS+9TbwXfR4YDLmtL/y0lG03tWYudJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJDBkfWO7gFAaqCvWqZzn7v2mpV61d0EELjSkFTX0wHCVTRc+M20qLM5svOh1Dn8sWZM2C9wZYP0AIcQp2RrDKCfDr0SETR2BN8kG0xZmx7mMKKC4HsSrciOimBjHf5DcnQa1CZiOfXg2X5gBmpLngkuvsQrNOE6huA9dmhf48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=tloUJTCp; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="tloUJTCp"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-92ed19f4d60so118571885a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1788538211; x=1789143011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/dj2tdiAd1cTUZz8ylHlEPfPG8XqvRkzCQtnk9erCM=;
        b=tloUJTCpTsWudC7midDUdjsYKW2/JUorRtK+r/eC6ai57Qs3PctppLNFJzn2SKd/eW
         wo5w/sjHj/fXS++vbcRqvmK85zYbNUYB21q7x7OHeMZ3qMspjflFmTfVWO38MuWlEjCD
         Q+pO5GLjfPi1cSKisnAZIy8eLSRUyFKEfehfWbWJ0oDQd8ThJBMk3NiSI+OfVDsK1mub
         dRZFXRIm+Xg8gaNAk5Yuz15QQ7AM4RnYtJbVpfPAZL2Sg0Lqo8Sr3Sry0/Dn5Css3Zai
         aSSinXohraHDJKJ6A1s340y9A3XxKSt9UnKkt47bITSiFZEReAdNsM7T5hWnRdI3z0G2
         e1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538211; x=1789143011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/dj2tdiAd1cTUZz8ylHlEPfPG8XqvRkzCQtnk9erCM=;
        b=NdE9AGjSMo7sUm6od3QPW4B88jc6IdgGRGhmTKzwtxO9/YbxOHaf93mq8oKO4j1OYw
         lNBJerEOkKND3R4Dyp1zUGsPI4j6GRqlLa1Cv+EU/Shw6DxDpWM7Y66fxpMFQTz+FMHu
         3X7h7a/A48ZksCXBysvNmShSh7zEBMjysEfgCr+guKWCQ3E5Q7YySZhHQr3M8QHOQDZm
         mrCLQYCPMF00/teIqxEvjrN2L6a1xzCkBP7GVMNsQIPRCEyuNWVMtomefCwTpEmlXI3e
         z7DvIPfqcjAFJHM6+jH6uRBfDLOWnwJU6sTX7FJ6J/Ou4gyVjWN3n5EEpJgvVM5M87/B
         5Syg==
X-Forwarded-Encrypted: i=1; AKwUvBz5BS8X+vNI7O7LFyEHFTRN0xIMI6YtLpy6a7nvTz81ga9mAl8CjRsyreo0ofT4mFHOWeVtDC/Isd3K+veR@vger.kernel.org
X-Gm-Message-State: AFuF++nbYhXcrOh0Kmc71ztCrKr0jzWOV//1RPhdur+XcLBeCE5HP99M
	Wu0hJInxovi7edAP3ADMFDKPGkrXMKs0M9YJY4E5U1/9uGWRMRYZAWShcpJ47oaTt4A=
X-Gm-Gg: AYBFou0G0fCrTMeMmM6E43iGt9uuZzfjvVtIG6BJil8fndqM67fIioZVTQaFxPNMLiz
	lb2lWWPZyDHrOquMlNzBMWfzPPp/CLWEtDyf7GcWG21omq9kAX8NKd9YKMkMTw6RIQZ0dj273RJ
	HtyShfHOb4O+dBLviGilcLSHXzI8kiyui+EDImeK3cAdaIMauSqSvpLAC4vToDmp3ty1wUaGCiz
	S5thvRaqr++2qakwa5mevDVwYQdz63gdpQLaXcRVLu1Yv6dT7vyV7Qq3/StKXkZ2FJRAB/IXlo1
	ZzI1czJid+jGT/9NUub+uiIAC3uSUdgzn1qTMc9iW0QyQ7KrtMkg+kuY4Kv0XoXwGgq+M9vtmGU
	4OAbCvIZKA8QUyTb/oe99JPh2ir158jYDPCKG20rRcR6tmxrLGI/TM5jVDpTxljWEiIBLk8urpr
	zzU/TvaE1lYBJ5o6jiKDfbGXPzEZ6EUZ/ISSsh
X-Received: by 2002:a05:620a:6cc6:b0:930:f285:5ee9 with SMTP id af79cd13be357-9396e0b2fc3mr1194176885a.20.1788538206229;
        Fri, 04 Sep 2026 09:10:06 -0700 (PDT)
Received: from localhost ([2603:7001:f100:501::2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067b125sm23869576d6.29.2026.09.04.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:10:05 -0700 (PDT)
Date: Fri, 4 Sep 2026 12:10:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, abuehaze@amazon.com,
	akpm@linux-foundation.org, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, jackmanb@google.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, willy@infradead.org, ziy@nvidia.com,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: Re: [PATCH v4] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <20260904161000.GC6641@cmpxchg.org>
References: <20260904115629.3993331-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904115629.3993331-1-dipiets@amazon.it>

On Fri, Sep 04, 2026 at 11:56:28AM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the iomap buffered write
> path.  When memory is fragmented, each failed costly-order allocation
> enters __alloc_pages_slowpath() which runs direct compaction and
> drain_all_pages(), causing a 0.38x throughput drop on PostgreSQL
> pgbench (simple-update) with 1024 clients on a 96-vCPU arm64 system.
> 
> The root issue is that direct compaction is too expensive for hot
> allocation paths that have fallbacks to smaller allocations.
> __filemap_get_folio_mpol() already marks higher-order allocations with
> __GFP_NORETRY | __GFP_NOWARN, signalling that the caller can handle
> failure.  However, the page allocator still attempts full direct
> compaction for costly orders with __GFP_NORETRY, which is unnecessarily
> aggressive when the caller will simply retry at a lower order.
> 
> For costly-order allocations with __GFP_NORETRY, clear
> __GFP_DIRECT_RECLAIM at the very start of the slowpath, before
> can_direct_reclaim, can_compact and the nofail checks are evaluated.
> This makes the entire slowpath treat the request as non-blocking: no
> direct reclaim, no direct compaction and no drain_all_pages() IPI
> across every CPU. kswapd (and in turn kcompactd) is still woken further
> down for background defragmentation, so compaction keeps working for
> long-term system health while being removed from the latency-critical
> direct allocation path.
> 
> Allocations that also request __GFP_THISNODE are exempted.  That flag
> pairing identifies the local-node-first THP attempt issued by
> alloc_pages_mpol() (mempolicy.c), which relies on direct compaction to
> form transparent huge pages.
> 
> Test environment:
>   Hardware:  AWS EC2 m8g.24xlarge (96 vCPU, arm64)
>              12x 1TB IO2 32000 IOPS RAID0 XFS
>   OS:        AL2023
>   Kernel:    v7.3-rc1
>   Database:  PostgreSQL 18.4
>   Workload:  pgbench simple-update, 1024 clients, 96 threads, 1200s
> 
> Results (average of 3 runs, TPS):
> 
>   Config                   Avg TPS      % vs Baseline
>   baseline (no patch)       59,408       -
>   With this patch          155,409      +161.6%
> 
> Link: https://lore.kernel.org/all/20260403193535.9970-1-dipiets@amazon.it/T/#t [v1]
> Link: https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u [v2]
> Link: https://lore.kernel.org/all/20260710143437.12379-1-dipiets@amazon.it/T/#u [v3]
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <dgc@kernel.org>
> Cc: Ritesh Harjani <ritesh.list@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>

Looks good to me, thanks for keeping at it.

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
