Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997794;
	b=itOQQG8WH+zWqp3CO050vRks17p66j0xzJinEQd1XetgNx8P3Dd/GgSVKejWTKcYbDg+
	 THvaT7X92BrCwbbLRAE/dtKPETz/Z6AjC/vHkFSH+25K3tZnpIMpXconXX6D7gWiGAMvm
	 4V+0BRT2HZvHTJGNvtF+IICzaCki1U00iyzOxr4YcK9lPf3RJWWB2D+92njKSevLD3Bkv
	 5Btqk6weu/DvtlHDZPhyr/jdMOs/iwPm0vFrkhQzNjpvofKTBuV9DhpnturHOYD5yBy+e
	 /rqqOuo64azPj/bBFNS8ZSy9AZRPtfFfo69YoFWP6QPC3g+yvLZ4h7SnD8OfQQJKKLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
	b=o6WvE7yecSlLOW9sCz7COgBbJKsN7BP/aGvjYFtcsqKfkPJz0z7L0y2sJosWXH8be24o
	 pLUrXL9jsL6Jk6VjYwpFHHVLB/YHKZgKhHcrPdk8c5lOuYHhb01R4WjnLALynQSy7QayP
	 uluC5FWcyKfPCJUtB9538BlEyNG3oVOB97LB8su8Tuitfieu+d4HBtQrcsnOK35lWgFoZ
	 wK+DtN13NrD7Lgy5juwWYVRxtIkzYKQ8FrB8R2XsKPEMHkmHI1qSBkC5VD+uuctqrzS/1
	 V91j7YHUcR5GOXgQybg//MATyxfj3WRx+Afe1FsJCMUrVXj6zflDFYTaDpR48ZgVbDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED8606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EED8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91befbcad6dso12870036d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997792; x=1794602592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=REFEyl2N/lgmfldAVFpxIWxQa8mjfRZ+rZu+VbJlPELmGLoAMssVZsg4Bw+JPUe95Q
         Y/+7TrhaVb742lX5HOvfYl5c8tdB9czfTvg+/vPAkrj9deCRb9o77jvOHMvRN4NFT+Us
         ybtE7N/j08Yo8TizgspuDg/xp1VtRZGq6sUf6uJV1YrIhg2qFP9g5wF57DH9VkfVQStn
         4ZNBdx9BbGLhMDmmTMxt1/LSgHH4HYRUio31WfKrQQRxXVL0B2mrBDJi7luolVdmYxxx
         r+j1ArDIDr+vUF0me32H7jSKSjODetgV3j9jw0TC5pHi0hn9wyRUYJT4xRQMphXho2hD
         k69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997792; x=1794602592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=LR8fy4jUIg1LGiNvpiU/zwuVm9HSehzimteynYKige6laey5wHAfoGvL4vHz41v+e6
         n53cACXUL7LlbyrQAcxTjyhG+GM0OQG6mI0mxgPG+vBW4N91uXsV0G1dbKluVVnU2lOM
         pD5W9I1HpGHprux+RwVieqPWoCkPj8oSSup5MVg6CLvY4OBghHkJJqDzL6neacI2aw75
         lnGUDFrBS2QLPZjLCRYpyM4yri8PVeHs9E2zBlHHnsPuJcAQwYaYnldqs2hYnhxHERGa
         knuG8gLV8LQiAXh1y5kJDUjrwHiaZBGdWIzm/z2M6EX40FnUA5peh3vS6j+PRYuimFpE
         ptIw==
X-Forwarded-Encrypted: i=1; AL+hErGvmW1QBRWN0shc8SZB85DJJKquEQOalI0cmvC5WP5toG6DyC9XO4WdWjstWB2Xeyzy82tyw+1HvF0SUFQ9@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q9lkM+7evtbvRBspMV2ubqPdGyKhW0kpvuJ3jIy32pJ1g1H5W
	y03Dn8FdE9aFMka7xznozXNc34Zhw/Jo2ra0qBIPmXRhjq0ASL9Mjyf9AOFpLxWdqAM=
X-Gm-Gg: AYBFou0WC7Ew6MMIPJLHYQgFhsUyofEP7e0LlF3Qy+2YgaKFh5p8SBotaYpKGLOUOGR
	cNeW2A2p1ifzbY+n3oI8rYOlw9m/Xw9Mmjo5ErlsUUoIEhLRmr2+T1jiT7pIPiqg+zIA9a6eLUV
	6KLVZTVuwrvJTLZRtG4PT3RcI0Aw8K3u/ZPp+dTgsIGVdbYgsrrkHeZ4WrxXJ4p2Ar9IhjIgLM5
	fPRS+NfUEr/BHPLxTRQ0mdt3g6sevj4yQoE5tUIaKQ1gNZFgIBnv0D6PofAS/lrdIBui/hB+oAe
	z39mnGA493UJOCKu4kJvLCzmoNNA23gsZF1Ms1iK5I6UGf8E9Ic8p0Q9sQDkdHfk3V4fsfaAFKD
	NcgBgwRpZGp8LvEjThZV3qnwOesWrhR1BjJi9diOummEZKAtRyJHfbunS5x//TJafkD/vBhtey6
	4Fm6uyhxTa8ghhoeHWXYQujO03z1n34JPCXvvA2tvzgceReJDadn9SnsjPwOIoWuS/mQL10x1/X
	GSeQZ7eV84zAeQ5y5w3gisJ96dM++iMjPPUAK6n9UEK+z2bSPIMl9eMxWc0Xe++FAicXUOKigZI
	vzOhzJ9Sw6rAQqheOYWvnkScXRJBEgrz2OilXSse4w7QgcHgBWMZIiwQhR6MQAAAp8sFZyC1mDs
	jokgqquNXhA==
X-Received: by 2002:ad4:4ee5:0:b0:91e:a5c2:37f7 with SMTP id 6a1803df08f44-91ea97a22b7mr53003846d6.42.1793997792129;
        Fri, 06 Nov 2026 12:43:12 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c742sm29232026d6.11.2026.11.06.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:43:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQmE-00000007ent-3ktJ;
	Fri, 06 Nov 2026 16:43:10 -0400
Date: Fri, 6 Nov 2026 16:43:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <20261106204310.GK663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
 <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
 <23f947e2-ff06-426d-adb7-396871304736@kernel.org>
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
In-Reply-To: <23f947e2-ff06-426d-adb7-396871304736@kernel.org>

On Fri, Nov 06, 2026 at 09:09:10PM +0100, David Hildenbrand (Arm) wrote:
> On 11/6/26 18:58, Josef Bacik wrote:
> > On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> >> Similar to mapping pagecache folios into page tables, let's reject splicing
> >> folios into a pipe if the refcount is at it's limit, similar to how we
> >> handle it during GUP.
> >>
> >> This will prevent more cases of possible folio refcount overflows with
> >> large pagecache folios.
> >>
> >> Let's keep it simple and check in the two callers of
> >> splice_folio_into_pipe().
> >>
> >> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> >> and partial pipe-to-pipe splicing.
> >>
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  include/linux/mm.h | 9 ++++++---
> >>  mm/filemap.c       | 4 ++++
> >>  mm/shmem.c         | 4 ++++
> >>  3 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 79ae8fc0d6bb4..a82cfbce18215 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
> >>  
> >>  static inline __must_check bool try_get_page(struct page *page)
> >>  {
> >> -	page = compound_head(page);
> >> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >> +	struct folio *folio = page_folio(page);
> >> +
> >> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> > 
> > Since you're here anyway can you change this to something other than
> > WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
> > Thanks,
> 
> If it actually turns negative (or 0) with out changes, we had an overflow and
> for sure want to know about it :)

Yeah, didn't you get Docs merged to clarify WARN_ON is fine if
userspace can't trigger it?

If you use panic_on_warn you *WANT* your system to stop if it detects
corruption, that's the whole point. Removing corruption detection so
panic doesn't trigger is pure 100% nonsense.

This keeps coming up and it's frustrating to go over again and again.

Jason
