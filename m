Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6D231827
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892839; cv=none; b=iJvSDu7RIBZBRi4m0q2XyMi2gte4djuSLo/c+CK3jB1czmZm1rJbyBCSjV9IMwwioaTtX1Ypayc3z+wvETwMG+EjqdTd3VPBMnnRiwnoS9YWstUcrbJA8try0czzeHUbgJQ6Xax8SM4w1sSa2A2kIS18vFvxtHvQXbmy0+0gwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892839; c=relaxed/simple;
	bh=6SyZvBrbf+USjtmnc7xlaVRQIMYtEt4QvTpWJfC1Iso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwWEKSWQM/V3fuO771i9tvQ6WXmKiEQpwD49ADODuKQP55fGbbMMuarzfw3T0SHs99BDDUjIhp6AfIGXjaNETqwE+4WxJbudGEOvjwINcU6HEN6SfA3zmGw8tKhWShcY8KGbSBtUOn9fO5snnSfn1XaOBxgcCYfDT/yZdRD14eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYN0XV/X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2bw9nzo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYN0XV/X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2bw9nzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776892837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AuBD0WIXDzq4C1LKbO1zkVvixca9JBQuddXhofRNlk=;
	b=KYN0XV/XTzZm0Hh5TSnhnP8v1Rs4rDupMy81RkDMW06+p9tcwkVYsdxVAYZVBUZJf4d5/6
	/hCUOpoUAHtCCbS6iKcJfHR1opNMfra2zYq8XgmVpRgdVsSI0ZrEWi4JLZhorlyQCcQqC7
	U+xUClIjV3tE+oRRuoTaym5ePMCMaqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-if6HHMRmPM6ZouxJ_z7ztQ-1; Wed, 22 Apr 2026 17:20:35 -0400
X-MC-Unique: if6HHMRmPM6ZouxJ_z7ztQ-1
X-Mimecast-MFC-AGG-ID: if6HHMRmPM6ZouxJ_z7ztQ_1776892834
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a36715dso2685111f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776892834; x=1777497634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AuBD0WIXDzq4C1LKbO1zkVvixca9JBQuddXhofRNlk=;
        b=H2bw9nzopWSTl+KkC0ptpyJkyR6Q4yrxdSjWma5E7SETq0P8twd4uvVcEHc88A1zzr
         JWmZmQJdo1LT/V68j3b7k0Aj7QzNFMU4LDXqQz/9q8HyNVJwrGsICskp7iVDGjeGYaeD
         PBjKF8a7sjFUapjmW3dCzeCKJoGX1XwTFicdK2UgBsjxntJ+JeX9v2mUwo17luEjGWxD
         GccY90Y6yty+D+l4cuTckHKY1HkyBWJVaOD+83AmRl81mMla0AbKf4MiO+Ya5XURS/Sq
         IA45ALRAU0rC4mhGZ0/gSGYyD0UIN6T3OB2vvZCzsFzDFp4TqxhttLa8hLhlUo+lT4N7
         hI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892834; x=1777497634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AuBD0WIXDzq4C1LKbO1zkVvixca9JBQuddXhofRNlk=;
        b=Zb2CXQ+Qkw+Z/ZFmDsBDN6/ZC3aOHYQYaUbvCUfjpPjVQbbCP72AxhB/VuIrg5F5IT
         ZA13Vc6P59VWU0y1GNAHvEmoCAIwg+zGVhQ65NTPfJIUG7LNPB805Foeh9lt/uAVwdz4
         3bHtsnY4JYpVbLcrJm46ibUKAYeQo+jY3FiWMgtkfi9oQigrgGD9VRhUdjWURZm2KS3P
         hsxtgvIVZvQBOAMV4kGUU2n/zKHTf4Ki2okjWtNyi1I5qwvv2ABrXg4t73LyhnmctnEw
         sf6f3+vdrWbH6WZyrIAVWwwHbW3Ih0guWlDMSjOh6wJjwVzJLaBk7h99KI97f0YlNlgX
         Z+ig==
X-Forwarded-Encrypted: i=1; AFNElJ8ptYN4iaQJH5khyS2IJ2g10JzUSCVnnAPoBC+cu382hqPYsfN2Te4UQj+U/X/GC6p7R/5o8Pu1NWwUn6gx@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/TYByb00VcQFZFbQpQYL1au2FY6uBYyd8SwoJytsDbruCOWR
	SBcMuRStGB8xakcuUj4rRT1GhCzqUSSW7MIR09loGv01NmXVoYQpLd4olFNLHFTqaXiDe2TDfoe
	MYYOCD8RvQNKdoOA4wxRTuqhUnOxu0aGtapHX6rSuZ1qmAIvfzmXY/VONyH452+xjgKo=
X-Gm-Gg: AeBDievVhEq21lYH+GEeSokNR5fSrfGO3CKRM/NW+p2SB1kxlMOHkAN/5WVpHXx1RA1
	KEGhE9lzKOkhb/9c0tYDCZW0wrsNRBPHwAVZMo/FcTZS48npAM68jqsCh6KyRYLFXuVj1xXw1tr
	jfKuRKvBKbkc3FEiwoGV5IlDVAOBuKzK6ZlwCObhT9lElFFaPtum6La+kmd4/zaoxgX7UC7oRcP
	h42kGpqR/m8846hfebQL0PHfAF2EwxiMwuuyrTRG6jKq1VO9bjxd9htx9YwW1Pbpu+vkxtcWQuQ
	UPSNBPJjaU9+gA2Moqul2jROr/YAqJ/S41mHaVAalww1ybvbtf+t4f8jfBHaeNslj6gOYLtMMak
	Dfy0EoxvDTyFO+gBBSlaHRbh1UUbhDKtoMS18KRdE8AZE5cX0ECVi/A==
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr296536215e9.21.1776892834255;
        Wed, 22 Apr 2026 14:20:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr296535725e9.21.1776892833712;
        Wed, 22 Apr 2026 14:20:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm537060875e9.8.2026.04.22.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:20:33 -0700 (PDT)
Date: Wed, 22 Apr 2026 17:20:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
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
Message-ID: <20260422171315-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>

On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> > Thread a user virtual address from vma_alloc_folio() down through
> > the page allocator to post_alloc_hook().  This is plumbing preparation
> > for a subsequent patch that will use user_addr to call folio_zero_user()
> > for cache-friendly zeroing of user pages.
> > 
> > The user_addr is stored in struct alloc_context and flows through:
> >   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
> >   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
> >   post_alloc_hook
> > 
> > Public APIs (__alloc_pages, __folio_alloc, folio_alloc_mpol) gain a
> > user_addr parameter directly.  Callers that do not need user_addr
> > pass USER_ADDR_NONE ((unsigned long)-1), since
> > address 0 is a valid user mapping.
> > 
> 
> Question: rather than churning the entirety of the existing interfaces,
> is there a possibility of adding an explicit interface for this
> interaction that amounts to:
> 
> __alloc_user_pages(..., gfp_t gfp, user_addr)
> {
>     BUG_ON(!(gfp & __GFP_ZERO));
> 
>     /* post_alloc_hook implements the already-zeroed skip */
>     page = alloc_page(..., gfp, ...); /* existing interface */
> 
>     /* Do the cacheline stuff here instead of in the core */
>     cacheline_nonsense(page, user_addr);
> 
>     return page; /* user doesn't need to do explicit zeroing */
> }
> 
> Then rather than leaking information out of the buddy, we just need to
> get the zeroed information *into* the buddy.
> 
> the users that want zeroing but need the explicit user_addr step just
> defer the zeroing to outside post_alloc_hook().
> 
> That's just my immediate gut reaction to all this churn on the existing
> interfaces.
> 
> Existing users can continue using the buddy as-is, and enlightened users
> can optimize for this specific kind of __GFP_ZERO interaction.
> 
> ~Gregory


Hmm. Maybe I misunderstand what you propose, but this seems pretty close
to what v2 did - each callsite checked whether the page was pre-zeroed
and called folio_zero_user() itself.  The feedback (both you and David)
was that threading it through the allocator is better.

With a wrapper approach, looks like we'd need something like
__GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
know whether the page was pre-zeroed (PG_zeroed), which is cleared by
post_alloc_hook before return.  So the information doesn't survive to
the wrapper.

We could return the zeroed hint via an output parameter, but that's
what v2's pghint_t was, and it was disliked.

The user_addr threading through the allocator does add API churn,
but it's all mechanical (adding one parameter, callers pass
USER_ADDR_NONE), any mistaked are just build errors.

And it makes the zeroing path closer to being correct by
construction: every allocation either explicitly
says no address or has a user_addr - and then gets
cache-friendly zeroing or skip-if-prezeroed, with no possibility
of a callsite forgetting to handle it.

Fundamentally, David told me I need to move folio_zero_user into
post_alloc_hook as a prerequisite to the optimization, so I did that -
let's stick to it then, shall we?


This approach also fixes a pre-existing double-zeroing on architectures with
aliasing data caches + init_on_alloc, where current code zeros once
via kernel_init_pages() then again via clear_user_highpage() at
the callsite. I don't see how that would be possible with the wrapper.

-- 
MST

