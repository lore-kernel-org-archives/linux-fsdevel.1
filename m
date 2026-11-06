Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959999;
	b=dddSBwn0jJ4/YsP74AzsapkR8dgppJ9Y7cGjrUb4cOsIdSSh248ExX3mvdGalhyw7OB1
	 usQjSqXO1NatnNEqeVhe9frH2l7nwQoMChXJqYZj5V6W9PhfbgzJa/YMtmYzIcZEhNYj2
	 LnrFUEhXEmIlShFnW/rOfjOWpumfnqQbUuKN/1qVZaSBLltwq7jer8HoOfaa2BMq8RO5O
	 7OMA+y30oHKDuQt6uT5GMiyr10geVwO52x4lB2o4zfFk+ITWupv7Y6YwuF8TCW/qUQvj0
	 66mht4vlKBRC46xKww3xfR6GglhMlERxQ+gAwBCE9RSZd43JBbGVJlIEpnVKodS2nqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
	b=NdxXMasDBY1dmXarbQ3lyzEe/Aq3IDhIdpIPQ/cyZbBeFECaaZKnshWB7e/kPjq9Mi+V
	 Lhmr657HzQdguwap7QWY2mffaWaW8aZdtSBVi8uXdaOF8cI7/4ZI5PEg0GN1hmSl8q8WX
	 Xxh8P+xuDoF/0J/jObi6NOXKxmNHQq9fA7O9C/e8HABMfRN7+ffwZzVIkTHbmn04/5ud6
	 tD9n86FRFYAnXU4mStTBsYyF2FOuZpv9p2tJupdGexix+6HOrK2Izt54l7mmXq84/zkGp
	 20+bLKm35I/WFKpTlluXOe79cS+t/ScliMRQGXMKTzHy3XomH0DZrZJAvAxRyfHyS3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710F606A334
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4710F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so2864065e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959997; x=1794564797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=lmi5Q0Fv7T71Md66nuBX67PlvPoEFrAFoRKV1Sq9HgiIufOQpo6A5qA4voQ9XVsQnI
         Y5Hj/M5KiCFqmc99z/aMxLeWTTEEj7wwOi2WSlzSWmo/tAk3DTZOxVOHqmd3JGBbyX5p
         MjxD+nIIkXrtlDg79Rto+zQPgz6nVr2WPvpz2LPA0t+/5xqCmE79Ud+YVNwx95IDOpUY
         6gKHohlLzrUuTmWRolrPZjIckPQ9XVpyHmmteUBXc8zNdemlnEFZM9+mZVxPhBgRgSxd
         OK8xZxmBxgiJbDDXxSodZkJXJeAnpIIx2xVIJR2W/+gMaMI2CJhuiL6Zi46Q+a4Dwvd2
         pmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959997; x=1794564797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=Pky9Bil3dQcCw7ly73OrERNWZnF8tac3upwOI3yyCuON7YU1rI9R3X0R6HkDU8GL9D
         7yRj0Lt3ryb4/akGWYgSfc5DVH53Icqi2oKWqlSjbSfqmWpIKBiP+5bzsf1+wHG8EFSL
         IquiZmf3wCn4XCNy3qDHvfXSa3WxuKoW6KE+oUFc4WI1CaIGclPXS7Wi6RCWG52CFaHH
         utlQMeQ9E0gWTCSSf0kfz72C/k2UOWuHjBxoyzOqd4FrETCcII0R87HF2aw68qAFNlTn
         xXYvxH3x4ThiLwWSPDMslGwCtLicrR4FpT6MIiD52rkThkmkEmQIPOAbg+P5r6kNDYuA
         qcLg==
X-Forwarded-Encrypted: i=1; AKwUvBxpwdaGS+lndf7HjUAZ+USNEKjkNKU3UUv+WnBBoOTTDkp9uIgGnURSteX84P+vhdrPJIZRJFRSbiYUkXVD@vger.kernel.org
X-Gm-Message-State: APuU4Z8eIyd7DpMcjHYv38FoYxISzCHxU+VTtO2lCVEaM/vBpgQzEq5o
	0AfQtpEM/TOTlBYKEod0v0/wta2AaVeZcnEsdVu50vWPotKJ9hXdaKu0
X-Gm-Gg: AYBFou341ijsJXc7Ophe8lL++zpfiCqizCqmAX0zaeuwupaKgpq1vSZBfekO587gdPX
	d1c0T1G/m5vCbqazbKJQl1duMvU1Nv40DJUqK/8V1v8ThzIiDo2fRX4dsVaE8Y2ASM5eDTJYSOF
	XcZZS0DHi+jQwRjUg0r+GahLLT0K6hWZzJCHGCFSjYjbUp/6yJDLcWJWNQQnUhOQfGW4gZ4uCLF
	WiZjXnkcU+RC1gLYGbUhHlnAkfIHfnbtK7fxinxAp87bPXWsYpr+ZSWtdlzJhjNSHuW9gFSfVKS
	+vPkaazjpP7LxS/nF3lmIeWCEiLppyTbhsWihccXh+VI9mSN+t1Mv1xVD6cPaW+xyhij87Q4WuV
	U8yD4rJSGJaec7NpCz6Il/PXPwcWM/B4ygvTHg09YuggGCmMzBtqgety6VqSFKZADi01dgCnw2B
	6hn5BCDbFo88AkBNFXdo8u9d5CjKeX5sVjaEE/AUMllOKlTUGBAiujYAZw4bsj6L1qSOJVtD7MP
	b8ZJHrC0UaQB4Wv14gd7pNwezeRV5JEdE7fANK9/tTOIKxV8VUZEvS8mTqeaVxVj2x9qxhRXQ2h
	YDKsYphWQcrX7kull7utOqA=
X-Received: by 2002:a05:600c:310f:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b6ded4a3b0mr30188925e9.29.1793959996617;
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm121341505e9.10.2026.11.06.02.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Message-ID: <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
Date: Fri, 6 Nov 2026 11:13:13 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Let's replace our existing safety check by the new
> folio_ref_count_over_limit() check in fast and slow GUP before acquiring
> additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Drop the WARN_ON_ONCE(), because apparently these things can currently
> happen with large pagecache folios.
> 
> Keep the zero-refcount rejection if the refcount is 0.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2ab42fc6834e5..db9db6b2a4662 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  
>  retry:
>  	folio = page_folio(page);
> -	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
> +	if (unlikely(folio_ref_count_over_limit(folio)))
>  		return NULL;
>  	if (unlikely(!folio_ref_try_add(folio, refs)))
>  		return NULL;
> @@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  int __must_check try_grab_folio(struct folio *folio, int refs,
>  				unsigned int flags)
>  {
> -	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> +	if ((flags & (FOLL_GET | FOLL_PIN)) &&
> +	    unlikely(folio_ref_count_over_limit(folio)))
> +		return -ENOMEM;
> +
> +	if (WARN_ON_ONCE(!folio_ref_count(folio)))
>  		return -ENOMEM;
>  
>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
> @@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
>  				struct folio *folio = page_folio(page);
>  
>  				/*
> -				 * Since we already hold refcount on the
> -				 * large folio, this should never fail.
> +				 * Grabbing more references can fail once we
> +				 * hit folio refcount limits.
>  				 */
>  				if (try_grab_folio(folio, page_increm - 1,
>  						   gup_flags)) {

this can fail now, so shouldn't the error path below return -ENOMEM like
the first page does, instead of -EFAULT?

-- 
cheers,
jose a. p-a
