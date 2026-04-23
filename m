Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F93E715C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945434; cv=none; b=EWmGxG8fzOqm7jZ1GsI+Zh+tUhBbe3uGEH2RLvUGJn+FJlxbOvAwnvec0lZQaJA4yX7hwXrfO+NuleJcJAm5MA0KRyMAK25V4mS9i4IAnVg/bEoaqWmxMzaRAaI4EwkgIwJCYJftAYH9dTeQbOGO0gZeq87wPAgEjy9T3NAvfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945434; c=relaxed/simple;
	bh=cerLyyGsxZbpGHR7Ohl2x/Kc4s1l02lVCZCqTvZs2Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC20kyLa9JE96CsHQ4OyGAEIY1t75HgnqZT0yJV6XCxSca63Ld4pkV++vfnFHhdtvc0jrhhGWcvWQ7/BrzNDtbIXFaYTWLeI3aEMTNycm+kjyy/al1ZFXt6gMICG3fVbxaL1IO/6Alh5+2cp8LXr+9qPzvr4xMIK1xBJs27TRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lopnv4Fy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bANPhGir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lopnv4Fy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bANPhGir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776945432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMZWtfjIWNO/JysIhn7eMR9XhBiqbQQjvoPhb55A6AY=;
	b=Lopnv4Fy4FBYYtT5uZcHZJM/JxJrRn4AuTZ0uigqu6Jn0U6LC0euWRpWChXirJB8pyVuaZ
	FXa8Lml7XIeb8YGFITDPincfWWgjtQeNEWtbkL5nhoUUR18R2r9/qf/Q9IKSH8yrnoiF15
	DuzCuqOwB92Gbdpz7iYS+LhFx+H+xQE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-HlsYBIT1M-2C5p_m6AV4Xg-1; Thu, 23 Apr 2026 07:57:11 -0400
X-MC-Unique: HlsYBIT1M-2C5p_m6AV4Xg-1
X-Mimecast-MFC-AGG-ID: HlsYBIT1M-2C5p_m6AV4Xg_1776945430
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c768a9a9so46800205e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776945430; x=1777550230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMZWtfjIWNO/JysIhn7eMR9XhBiqbQQjvoPhb55A6AY=;
        b=bANPhGirsmlR4qb66ZEyN5QWn8HN0xQItm0pxR1mWwTuzsiB2jbiV5pSl/ZF2X5dDh
         g2uqVIOCGpqA64/b7soZjiX2wjb8opGxQchvI3Dgzil1GvmeKr7R/Py9e4pNV1yP/vh0
         vq07s2lFJ5hbArij3YJCBj00t19O02R+vy2ofHNn4wNGSC1PhTUN57K3GI6kpvlUSJzJ
         yvv6HSYtdQCDUxtCHeAeXMLPL/XdjjpSkU0Vh42vHH9qX4E2fDGfI/14wTl0FI8YfnE1
         iZnU9X7ckTZGkdPm//jIBbYzhFWyEfCiekDLtpANsToydffHVXdPQNufcZYuOUTeBa+2
         uAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776945430; x=1777550230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMZWtfjIWNO/JysIhn7eMR9XhBiqbQQjvoPhb55A6AY=;
        b=JZVmPPmXk0nzaMFGP4g/44Cki1GI1OYcX7RkbFlCL5txr00zFrPFZpzgb8sn7aKguq
         Xf6bIaOWMRRVGt3PkUfpe9E5LqEwRHjVRN4Sp+sZK3gh5Qp6mSWL7TiBuFdx+J/W5JlI
         EP8T5gZQ/fhMRa3Jd7kPNJP343ub73DVK/1kwS4sNkVBdvwflmIy0tRmj4GJcQXF1khL
         2TMqMyVbaPhmVtdb6WkyOb49u91GLT4JpZjEPr1mMF/mbhOwldnYekukE/2WN67E0Otu
         oC3NPObcPpCDy2TgWpzsZijH9pmKrci4yxXTjAB/dBVENlzrQo8RzpRxMJyx3NJY8Gwq
         8ihg==
X-Forwarded-Encrypted: i=1; AFNElJ+VgMIzikuY4wwIzfSgJuE3xQzB/+8nGzQsTwb7poxnL4/U1C9weyOsGMD2zvgnrmoeLO5SHnm4HEmukBY0@vger.kernel.org
X-Gm-Message-State: AOJu0YwH99d1+AiOhU0pwW/8I5D/W7/1al0ep8ydEBtn0dzl8jFE5G8m
	xZ6RdjpV8nqsNqzJzTJAVloZyZbE0vjXJwOXNB10gSCj3+dkoh1pn589VFYyZLjV8OOr0W/X6UW
	bTXr5Ib+BW8kOVBtVSOnAOf97PctRxJayIpkwGX3fzkIVWFYuwGjF1UgonJfwWgQQSPE=
X-Gm-Gg: AeBDietoCaK6AaDkdFH3IfJN/Dq/Q20OD0U+FV8jGwedDfB8/YXRFo7zIatc7pK+3jh
	FtbQ86FbxLBSjEYaAtuqQnXumUyVOekpvdDCHltQhVXzHp4BPg1pfDtfjz7xB8g+yALwyPGZkrd
	V/OJPdjJNtRtmfxF3+32I9Rtz+/c61vF2OIkni2jm/OAEOedkIuq4Dot55oJsXt+xMlGOw6AM03
	TAEY8MO3ggJY0I4DvZZrYZoEs6LtG5yObF3wmNfg1u25WlEFfj0ylQAOLFoa4M/MCJ+tGXvq1F/
	L9rMW/1FjWbieamrSxIVOjoKQ70pLqBLI6gUJDLaSdBAUNVxoZC3busgsxmZ2Ug4Y0t8Cf74FnK
	H4Kym6Qau8Z7TOIt+wRX/ZnFhmkn3XakCtLDxlNqN1d3rLTKEWP8jHA==
X-Received: by 2002:a05:600c:8b4b:b0:489:1ff1:74f4 with SMTP id 5b1f17b1804b1-4891ff17707mr203280225e9.4.1776945429760;
        Thu, 23 Apr 2026 04:57:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:489:1ff1:74f4 with SMTP id 5b1f17b1804b1-4891ff17707mr203279475e9.4.1776945429042;
        Thu, 23 Apr 2026 04:57:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm184344495e9.34.2026.04.23.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:57:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 07:57:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260423074433-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>

On Thu, Apr 23, 2026 at 11:46:56AM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 06:31, Gregory Price wrote:
> > On Wed, Apr 22, 2026 at 05:20:27PM -0400, Michael S. Tsirkin wrote:
> >> On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> >>>
> >>> __alloc_user_pages(..., gfp_t gfp, user_addr)
> >>
> >> With a wrapper approach, looks like we'd need something like
> >> __GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
> >> wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
> >> know whether the page was pre-zeroed (PG_zeroed), which is cleared by
> >> post_alloc_hook before return.  So the information doesn't survive to
> >> the wrapper.
> >>
> > 
> > I was thinking more that internally you already have that information
> > you need to know to skip the zeroing - and so the wrapper can just pass
> > __GFP_ZERO and post_alloc_hook() would do the right thing regardless
> > 
> > Then on the way out, the new wrapper would take care of cacheline piece.
> > 
> > However, i explored this a bit - and while it saves some churn on the
> > interface, it adds two paths into the buddy - and that increase in
> > surface might not be worth it.
> > 
> > So I see the tradeoff here.  The churn is probably worth it.
> 
> In v2 I commented [1]
> 
> "
> For example, instead of changing all callers of post_alloc_hook() to
> pass USER_ADDR_NONE, can we make post_alloc_hook() a simple wrapper
> around a variant that consumes an address.
> 
> So isn't there a way we can just keep the changes mostly to mm/page_alloc.c?
> "
> 
> That should avoid most of the churn outside of page_alloc, no?
> 
> [1] https://lore.kernel.org/r/4bdc66f2-1469-4b91-9935-74c3d3ca0ed9@kernel.org
> 
> -- 
> Cheers,
> 
> David

Yes I'm sorry I missed that one and didn't answer it. My bad.

To answer the question, no, definitely not *most*. Here are some numbers:

What we save: 11 one-line changes adding , USER_ADDR_NONE in callers
that don't care about user_addr (compaction, filemap, khugepaged,
migrate, page_frag_cache, shmem, slub, swap_state).

Changes we have to add: 8 changes
Rename 4 existing APIs adding _user: __alloc_pages,
__folio_alloc, folio_alloc_mpol, __alloc_frozen_pages + add
4 wrapper macros/inlines in gfp.h that forward to the _user variants with
USER_ADDR_NONE. Roughly 6-8 lines of boilerplate per API.

 
What stays the same, but now has to call the new APIs:

all internal plumbing (page_alloc.c, mempolicy.c, internal.h, hugetlb.c,
the actual user-page callers in memory.c/huge_memory.c/highmem.h):
38 calls, of these 21 in page_alloc.c, 17 outside it.


The changes would be less trivial to review, too. And I would not call
the resulting very long names "elegant".

More importantly, it makes it harder to review: instead of
compiler checking we did not forget a parameter, it compiles fine,
but we get a subtle slowdown or corruption on non x86.

And I thought you agreed with this sentiment when you said
"yea something that is harder to mess up would be nice":
https://lore.kernel.org/all/20260414062524-mutt-send-email-mst@kernel.org/




From where I stand, we would adding technical debt by piling up new
wrapper APIs, for no benefit.

But then, I'm not the maintainer here. And adding extra wrappers
is easy for me. So, let me know. Thanks!


-- 
MST

