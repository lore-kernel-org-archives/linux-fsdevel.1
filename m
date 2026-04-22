Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD332A3E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887233; cv=none; b=P4bhzFzLuVBX0DuMerxjK+f0HcyMs6J6AWT5acInqQVpWBwbFdzllRdau5ij2YVcmzQV6ybL0hKuvuKbcvK3kTzwnJg7A4rp8TI44z4pxT+Cx7WfkEcpUDOZdrhvwvPO8gXAr61yzPG/jjkrXnAqN2GcDfHzMGRQYGP908ZhdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887233; c=relaxed/simple;
	bh=0nf05vma3xhqsy8YbrfdkENQdMmOEcvjpQx6mh+lTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOPN2XFbQxw2TfmYLfDGYFRr1J728BTFTQOohDwjGYsv5wsu2K70fiGMPd3v1wE+mDpFj0l9tDM6xk9q5Rh/z+TNa+AROYTRY8tLMCZS92TuGCDf+tk1GLaxy94uOfn5vR8vhzpu0weCNYsPnthHqt8AMmmJ72yrrfXLtrEfClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CXZ8rDR3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CXZ8rDR3"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a9f445cbso69076606d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776887230; x=1777492030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGdOZjYFd//HiRQ+b4VwV4BRdopXfvmgy3UzEHyg/Zc=;
        b=CXZ8rDR3+jXW8v9JotSsNZYQ/mX3c604ZHOD++w01h3R06J9OhYbRy25HFKWx6WPym
         s/vt8myx7CtJTrUQBQ72taxD6vuciUANMEo0zMRIaB+7gu2idAxotGi084W6R1NeXXCo
         k/uUxahd5odw9PlmlEc035bDd+UaQ0lAVc2O9xcDRan/EFq0SDzDt+0AAdSRQJnk/wCc
         WfJ/H24ST3v/rgukozbuP+EFBzLj8hryPBNaTYhJ0hPFYjjAF+x2j2hdbK+0dSoT3e93
         j2OkQ92kd56sgjFMrMxwNjdtxx0Oz3hBmnXGtTuQv9CQt1sGE4uM9dSfGK0q+sVGLLQy
         5OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776887230; x=1777492030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGdOZjYFd//HiRQ+b4VwV4BRdopXfvmgy3UzEHyg/Zc=;
        b=a2QU7ZxMS7OQY7B/iGCghfHebTfOR+eZVxSBl26ABkzIhGvF4TNCtjXPVvXnjbXade
         ZGngN36IaSmQ7Of3i1iqCmz9JFDIcAvBI38NYE7sQWj+lC/DVrrgLPHPO76LUdHxkFLQ
         ZiDskDrHioPhChR1ut11BXvYjpqZmdOv36B7u3HDJS4KTJPE4TiWG7DoVGPjqOI9Lr2p
         Iqae+dwaJVQ4oIbZ3ypBNuiiZv/MDyI6M7SHadPC2UB9V9f0b7v+/LsX93xMiKkeC/19
         HkQrPgUZTjpYzvarPPcQXo8FL2cRPHOqwxR3b/GRAMY6UQ2Qjt/pd8bMAM5ugAm8cWnP
         bUng==
X-Forwarded-Encrypted: i=1; AFNElJ+cHlJBuRlo7ABbqIqV8/Otqjhew8WrTwiW+d98leSEYrIZ/y6bDk6eYzoBNQPxIgVb5UdRKfQJ4kXLDt4g@vger.kernel.org
X-Gm-Message-State: AOJu0YyCP+0WJPjhhueM0N1KNnz5gYvSrhmInLYZ1UHJNpiMQZR5R4x8
	EkygyBZQecK8YSkHxFHbK6ED6HdKSdkRQCZQfqCrB74w7nNeiGpxLqvbYMGTDc0Hhlc=
X-Gm-Gg: AeBDiesfbHZ4vUCeVaQYAYZpWaqabdxuINv0TC46zlpVt08ssp38aKSD+hmQohr0XP3
	UMlqamlPHCiBpvweTqDOw5REfq6Jeezm/vRsOpa7ysfEPYKf7BJue0tcMCqUXY0nl5Ti9GR6eXd
	hvu14jIvq4AD4FX6b6lVp8J4JJyH8gFmYpJ+RzqG+QVGqqHtJjxn7itt4bZLem7846k5QlFmTMB
	08KEXCRDSQbLCD+sspMWDtJhwjKVPZElOjlpBm683hmxEJMAjKT2zBILhLmw8cwSLmQk86kVxCU
	M8kttE1e9Q36NoAdIbE0rV5UyoxT0ZHDOjifv2sT0NgQxooZQeFB2xxsQW2mGYKwalDU1STfS/r
	6NWYDtF7mXs768y0/MURFCkbt8zVZXBEOfa6UnBLiyalmlaAJ8EtpjZKFA1o7anSio9y1gRTWYe
	WltzlMms3dD4kfvwC4Fa3FlD5k7ID8E186Ppw4SoDxALDXrTa/y7VpZDKnCT1HvQfo9VPYOAHOU
	H/BXojeW8DAOJBLh6Gf
X-Received: by 2002:a05:6214:5e08:b0:89c:6a86:e632 with SMTP id 6a1803df08f44-8b028061bf0mr329097316d6.18.1776887230490;
        Wed, 22 Apr 2026 12:47:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm138295346d6.49.2026.04.22.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:47:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:47:07 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>

On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> Thread a user virtual address from vma_alloc_folio() down through
> the page allocator to post_alloc_hook().  This is plumbing preparation
> for a subsequent patch that will use user_addr to call folio_zero_user()
> for cache-friendly zeroing of user pages.
> 
> The user_addr is stored in struct alloc_context and flows through:
>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>   post_alloc_hook
> 
> Public APIs (__alloc_pages, __folio_alloc, folio_alloc_mpol) gain a
> user_addr parameter directly.  Callers that do not need user_addr
> pass USER_ADDR_NONE ((unsigned long)-1), since
> address 0 is a valid user mapping.
> 

Question: rather than churning the entirety of the existing interfaces,
is there a possibility of adding an explicit interface for this
interaction that amounts to:

__alloc_user_pages(..., gfp_t gfp, user_addr)
{
    BUG_ON(!(gfp & __GFP_ZERO));

    /* post_alloc_hook implements the already-zeroed skip */
    page = alloc_page(..., gfp, ...); /* existing interface */

    /* Do the cacheline stuff here instead of in the core */
    cacheline_nonsense(page, user_addr);

    return page; /* user doesn't need to do explicit zeroing */
}

Then rather than leaking information out of the buddy, we just need to
get the zeroed information *into* the buddy.

the users that want zeroing but need the explicit user_addr step just
defer the zeroing to outside post_alloc_hook().

That's just my immediate gut reaction to all this churn on the existing
interfaces.

Existing users can continue using the buddy as-is, and enlightened users
can optimize for this specific kind of __GFP_ZERO interaction.

~Gregory
