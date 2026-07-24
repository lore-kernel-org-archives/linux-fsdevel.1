Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2E2931DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897543; cv=none; b=SqEHSioWFING4ZKGAXt08StLHHFcMMgVb8Kc/y8CnEpPtgGxYeUIYby3i5wzWs2U8X25k4dZklng5C1SQLC+7/iuFlgqUyseJVISB7uuM65hN9ROF9X4jiRBC/6pi0bqaL20gJIa3brdx/GFYoQfTa7WZ3DdZDOy4wj6HWCBq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897543; c=relaxed/simple;
	bh=sOVvmMi9v63E0Cy86DvWvi9SVE6+rDO8K1xjowWrAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeTL6hX3ejnU8fl5MHMudNV7ADqkRjugDyVG/06OhxfCy9+BhfJMIz/lfYsA8OSa5McumcPTDGtm3QBrA02fO5LTVhK+bmNeyG6sG+A21YCTOqIMhNzgTNoe2TgGl64fmiHCbwuI5OZzm+nRqAyc61+BB6M3GSd0+bm5t4Hvlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIMJeZoV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qYQ+/Q+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIMJeZoV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qYQ+/Q+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784897540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLQ5O+fUlC8SWGd2qEWM0svM8AGuw9DKpa1kqaGNOlc=;
	b=fIMJeZoVWYhun3WlUlSAxGVbiTl+hAbuAGp6qpnU1OQW0Wo4K61PIARx9BfIMxp2gVLggN
	RUyBRB+QjLr70hCysu0C50meRFpzKLZogIcWbGRyvJALFmfdKcNy2JnMJnjIAd39kKJRrr
	vhPSou44yIlCLIWH35+ybqukNVUVj7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-ORmt_9voMoiiGPBvP-g42g-1; Fri, 24 Jul 2026 08:52:19 -0400
X-MC-Unique: ORmt_9voMoiiGPBvP-g42g-1
X-Mimecast-MFC-AGG-ID: ORmt_9voMoiiGPBvP-g42g_1784897538
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492714d002cso3450015e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784897538; x=1785502338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLQ5O+fUlC8SWGd2qEWM0svM8AGuw9DKpa1kqaGNOlc=;
        b=qYQ+/Q+JOeJWfJhtWhgBUwf553gt01unZuzbPI9oKLPISM31LdHnuPLEPx8eQCM34r
         Vg28XVdqPZtlr+fQEwLfCkqU30qpDEqquU6LpaqxjM611uoPdIJ9emc84eWurokRkJ1x
         INYhmMIEMoxoAAoD7ocBweChNsHXrFb+2YCOo4R1zzItlD55EE7tRocbGi+46+76QUT9
         9rL9DOAb0RjSd1OArucrYK9VaBU7J3z42GkeO4pSigDkpGdhrh4AE0vNVYvpmMLjevNX
         lV/Ck2p1DgMbBm2fKEwaDTdzXwju7wM9jN4Ko4qOWtYdQgsgY4ZH4th4OXj9xi1z0gFL
         AhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784897538; x=1785502338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLQ5O+fUlC8SWGd2qEWM0svM8AGuw9DKpa1kqaGNOlc=;
        b=cujPsCg6FRdf+CPLohCXPFJ3S33TGQxY9wS6GSyChW+xXcWUaqD1EGIUrn7rqX+mgM
         TeDLxcYDejkPkvfo4aOK2CjFBP7F/hzAxZXJHGYg1g6AkpHnQIwFdOdGRfetITNDKJnH
         6jTAiVRTHDej32S3gY2UL+5ZEMAV/0qyAkUQRfxfhFLKgXioGezS/dCR8rRxwV90XKyU
         wSAYkmfgc4A8BUAzUFIFyL8119Yqo33X8H7CMYAIbWsQKR/4zduApuYWI0oSOPyxcPsT
         hehEEzu72R5qkDcFzGKf34Zn6rKmgylmwfgUqZn0z/5E64K5pu4C62tR7iyIKH30JlAR
         Ks6g==
X-Forwarded-Encrypted: i=1; AHgh+RqENxJmitnlgy2QQ6oFyMqq3Cdsin+aj/CDeFpHK6DbM9e5tsFNcDjTlUgiDye0XurIZPXjXUgPQBsZwIeq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CeUErGNB/lqe35rdV7c1xrXr50M+w038xLZICrVz7WetCRSX
	LPIu99CRwHwPlMTW9GHmdfpcttwcmr4eGnw9uqPMi7tSVrZ7d4yLZW+yiFMjTLF/mlea9wD+++V
	JHwDS8UywXIbDjLSVUnFw7Ygi+ULh6WTc35Nz8Tbw73vIlI0TG8dleUrjQjgEs1jCvDU=
X-Gm-Gg: AR+sD1185KNx2B4biDyfWrRxK9woiJbAfNB+UOgdHSNKWadW/h3/qBWMd1y3FMkBxof
	x2blR51r2ZzdrMDghnfNXTLUH6qnHk+RhSqSIlvMrao10oxjxQz+Vo7aYbCInyein0OIJbI5Aqb
	fcQXaKSWbphAN2b4VrthOPJRSPijKkRnXb8Romk4tppCbLMqZf2pfq0VfIfEbkj1aH2vwLve3pB
	IB+3Ey0O0MBEZ2DPqD32S5j/yZIjoAipcTEQ6XIFlc/wAVMeZQR0wbQXuSMeIUjXCE4GfqfbDXl
	+/wg5/E9OkB221c33pPDSf9k6FMyehnIlZFQ99lrrti/mgX5npvZ3+QQ1t6hLpaL09udiSO5ICH
	PqO8Wum1rbot7qdQSVNuPSw==
X-Received: by 2002:a05:600c:63d1:b0:493:e79e:da98 with SMTP id 5b1f17b1804b1-49573cf1b3cmr56863745e9.39.1784897537729;
        Fri, 24 Jul 2026 05:52:17 -0700 (PDT)
X-Received: by 2002:a05:600c:63d1:b0:493:e79e:da98 with SMTP id 5b1f17b1804b1-49573cf1b3cmr56863385e9.39.1784897537206;
        Fri, 24 Jul 2026 05:52:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfc2ff2sm44919945e9.4.2026.07.24.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:52:16 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v4 03/14] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
Message-ID: <20260724085124-mutt-send-email-mst@kernel.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-4-willy@infradead.org>

On Thu, Jul 23, 2026 at 03:30:20PM +0100, Matthew Wilcox (Oracle) wrote:
> This is a better name for this predicate.  Also make the argument const
> to allow other callers to be made const.  No functional change.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> ---
>  include/linux/page-flags.h | 4 ++--
>  mm/huge_memory.c           | 2 +-
>  mm/memory_hotplug.c        | 2 +-
>  mm/shmem.c                 | 2 +-
>  mm/vmscan.c                | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7223f6f4e2b4..4185a03a45cf 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1083,10 +1083,10 @@ static inline bool is_page_hwpoison(const struct page *page)
>  	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
>  }
>  
> -static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
> +static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
>  {
>  	return folio_test_hwpoison(folio) ||
> -	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> +	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
>  }
>

It probably makes sense to document when this should be used
in preference to folio_test_hwpoison, given a lot of people
got this wrong?

  
>  bool is_free_buddy_page(const struct page *page);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..353340309107 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4413,7 +4413,7 @@ static bool thp_underused(struct folio *folio)
>  	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>  		return false;
>  
> -	if (folio_contain_hwpoisoned_page(folio))
> +	if (folio_has_hwpoisoned_page(folio))
>  		return false;
>  
>  	for (i = 0; i < folio_nr_pages(folio); i++) {
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7ac19fab2263..33007e8e546a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1813,7 +1813,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		if (folio_test_large(folio))
>  			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
>  
> -		if (folio_contain_hwpoisoned_page(folio)) {
> +		if (folio_has_hwpoisoned_page(folio)) {
>  			/*
>  			 * unmap_poisoned_folio() cannot handle large folios
>  			 * in all cases yet.
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b51f83c970bb..492c9bef3620 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3240,7 +3240,7 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  	if (ret)
>  		return ret;
>  
> -	if (folio_contain_hwpoisoned_page(folio)) {
> +	if (folio_has_hwpoisoned_page(folio)) {
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return -EIO;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..70e54ace0e74 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1086,7 +1086,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
> -		if (folio_contain_hwpoisoned_page(folio)) {
> +		if (folio_has_hwpoisoned_page(folio)) {
>  			/*
>  			 * unmap_poisoned_folio() can't handle large
>  			 * folio, just skip it. memory_failure() will
> -- 
> 2.47.3
> 

