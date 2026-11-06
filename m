Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987931;
	b=yhA9mPuufNQHj7ZFwuM8hOJvGiQDIiaN9Jnn8Aoa0djdc9MqDIF871IOzxpXItBRrdmN
	 MbkiyWUa7c7W9wUw6tml+n5zQwAB37zXVwIwaEkMX+qm391j/TnDhvRiOg+u/6ROpEL06
	 vT2LCs9tq5RAYD1eViyKBXwGk2YS2xHHrh7lYkARxT6YKizVm2tOTdy+iETSz5TO780VQ
	 yAfJqrhwnwdWLtT8pgoxpz+JUVtdgLAcfn+u2Mldu0kTE+kV+EJqzeaEm66G3rvQtyY+x
	 z7z1X7qstSnUgk5Q07b/IId7UVGmYy2VmyeYYuYOegGgf0BKJsiwfr5VPIkwc8d5v2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
	b=Vbckz9ohcexfgntDO9NdIhCFUIwQrnOhFHZw1Gj25esaT9t8wKgfZf9/NB903GUq44yy
	 XomeqPhXk7H5b2fU5ZtAYPS8Pl2k9Wu29qTn/2pl2fJDDl4r6Vqp9ls0DR79Ox3O82DRu
	 jklOm9r77PPeGszfWHmJ5nWU3GzY4Fj3c/TNkPRPP4MHsCm4gEeTgXn2chsrBjfz1FZF9
	 bye7bRj1vZ9hmlpHGm2+FffQGpi7yS96rya8IhwSJbtqoHMpA2GNL0HPzWJu1QiFcKQTP
	 WO3+eqHxyH3mlBy5DGy4Mv4ZnUYFfUMy5CS6ouEj+oa4Zz8WLnAOBAiR33V3Yu64AGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckldtfAp;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068E606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 17:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C068E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckldtfAp
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53653e30353so11136361cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793987929; x=1794592729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=ckldtfApc2a+8xtbx8tMkucEhxUCvF+Cw+JJDVJ6f2f8qLw6otsyHydoCal9Y8PQVE
         wSqegXOmaHckcVudPQ6CSb2Ruksh9t0YwF/s+5BHasjKno/b/Le3QZHOw9O0Wc9bTYas
         64ujbEgDlUftzzRM+Sn0H/9m6rO6xhL4b6YUYLPi6ml4aKmlxBzTkTsjvjBY/T4aOWRE
         Tt8FwlEUCSShEOsz+aE75gU78VQ7uHBKnzZICLAFdSlDCyXdndFhhzq7QHroTgLCaOhy
         ZDPDzp6HoM1U3pQJpMpalCQZ3F3o6QTXHe2VyZogcz6GpPK/vb29LOX3GA5Sf3zaycH6
         LJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987929; x=1794592729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=bIQj0lKwGst/Ayfo2M9KXrq4+xuK5vqfc2TVpjPmxaMOOzufeQaQtPccT300FGM/Sh
         67Ys/JIXUIgpUau/xJRj1rHdx83S4UeZwOZSONYK4z2zEBrFeFETObvuziGplrXdd/sv
         B6f+++bjEI9ZTIK2iPdRWeWcq46MKfua2AFerGTjHVbZsje3zmPQCtXDfkc8aM7OKqQa
         ruUHfkl8vBVBCxfgpENrFbdujK1uvkcVDkuyEGYWaAh6rfqfxw9ZOSBNShR14MAK1kMa
         +SAqYFXl/Z256jFuaVhyg7DXq9rQEuiF1Fz9514gSlJummh8JAVntKj53gCjHxoxQKAj
         oTIw==
X-Forwarded-Encrypted: i=1; AKwUvBwnhX87+fHl4xmCUs5X6To04T2jK1QXh0Lw3hF+gQkyeV9zmPQNVRJ1GQL2hgkTZAUJnogxWfHwovIM5Tug@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y1t7swYcDLaDBweRSq43zcum2q8//mawAtyfJ9uXagQbK/buD
	MzLVtJMUK0GW/evZwX25rKUf+wyaLDkZ0a77TpEsEQ1F0Ldahwm9BlLqXxEwCVd8Gbs=
X-Gm-Gg: AYBFou3vdt/qCxYvYmOAZ1s7V2kYKeD+QrI9Gkym8TKKzVw63VROJ9GAz/skDesHxvd
	HVYfYccAmD1MQZNErKybj597x6C7Z3yDcHmimgl/2ZdwI4lTuSE4yLAI/AseavsNZ3mp3d4EEYC
	kHGEyVzmiqUTwT4TMOESrUW7B8AlMv+JUVqbgZwN9OJRSEZb94STRkqSHKjEhMuOuFgka0YaRFf
	qwH+VeHa/471CoibUHwACgD2DeBogmcsqNEzgnv4C8GkVRc+IEdudRmvRKS6DEVxaTlyFQ2J1gn
	sqzFU7D0Mz15zOSCLodOzpBdcOAsyP0KU9FcKVdoF/VVdD3bLmZzgmVujcEskuMjoqWDOzWWpV1
	4DZfcYGsedSSBdLOCQ/FzDNLqmrIdw2eQPVz4KP3pDkd2EvaK7b0+2m0xsF1CiTT2YoSYuRQYWm
	qcwkfXba9hqeF6GmIeoZCl5S2jUQX97C5/E6zXiKk64+/zB5UNg2X293kNDW7mOYashLVV5jnZc
	Gl8HOFEqq39oQxIxelumtyoc37GD+05J+2c43mxAPIKd76SHqj6AMVloh5HuNhVeW76m3v814Cz
	/ZpjlIcwhl41Hbgk1dg1EvxBg5WOdjzYmdUHEclEKsMS
X-Received: by 2002:ac8:5d08:0:b0:536:699d:9a22 with SMTP id d75a77b69052e-54e157646f3mr53331201cf.57.1793987929323;
        Fri, 06 Nov 2026 09:58:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e27013e83sm25509581cf.24.2026.11.06.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:58:48 -0800 (PST)
Date: Fri, 6 Nov 2026 17:58:36 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
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
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject splicing
> folios into a pipe if the refcount is at it's limit, similar to how we
> handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe().
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/mm.h | 9 ++++++---
>  mm/filemap.c       | 4 ++++
>  mm/shmem.c         | 4 ++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 79ae8fc0d6bb4..a82cfbce18215 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
>  
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> +	struct folio *folio = page_folio(page);
> +
> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))

Since you're here anyway can you change this to something other than
WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
Thanks,

Josef
