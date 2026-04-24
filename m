Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B33CCFB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033996; cv=none; b=e+xC8iqKsWdUskUP+hKbkRWGHtKCO4A80r8MV/XTg5/bFx3gJZ/MnL+yDyI+8pXUO2ZNL6hn3dvD1MXSa2Wx+3gINa9yNxdcWPbqSYurybZoM4gpczmePJdbrc5zyED8NWmv8T6Jlbrv8GHoN8o2NaLs/Mda1U8R14JecodPHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033996; c=relaxed/simple;
	bh=sUphD3ERN3DgK3ao4eQ+aHuLLL6WmNwr6g1UJrLlCj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMCLGZwkIojpNDPiOHfmoK+1XXlUQzaYHEuHhzWWnzamyL0OHVSpBSRSTX+CGv1H5cXq3J0pod9xE8+SDuesjH4TF0seoWkqbipDRbeH0Z5pBl+mT6AXBk29FTop3NRzNG5C/ajw9tQQgLnIijvu0mQjKBFETy9Zlpi63M0v3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMmTp+r6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCojgPKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMmTp+r6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCojgPKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777033993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iU5HGQMMAHkFsOD8j+WiLpo76Kie/jMXtxjrTFTeJas=;
	b=NMmTp+r6aQk+IZjY5mBWeiK4FmZmkPNj/Eac+HM6tSywTy/esUBNHkIJ3prjWg3ddaS7Wz
	40cbMlLFXQQkpI9bGuF6JUS7ttNTw+vRiEuWxqEGPse6FSsaWTuRDKJiEBVPuacWi4+sRq
	xSLkG8hRf2/LJZwl0hokA9RHxi5xlM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-3peTYoACN6ikQ3Z7lzZmNA-1; Fri, 24 Apr 2026 08:33:12 -0400
X-MC-Unique: 3peTYoACN6ikQ3Z7lzZmNA-1
X-Mimecast-MFC-AGG-ID: 3peTYoACN6ikQ3Z7lzZmNA_1777033991
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso5623811f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777033991; x=1777638791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iU5HGQMMAHkFsOD8j+WiLpo76Kie/jMXtxjrTFTeJas=;
        b=GCojgPKxQdbhwjGqGux5g5TNkuL35rrFNJl8lgQpqvnaxkPH9oDLi+1HC7u0YrGHry
         KQ3pv6EgRNJ6kysf/gUb7qzJGjGNGo1P5Tf1Q8mqZ9v42hIIkBlew8zszEDGy3d1pR0v
         2yuSL2Lm9i4rl7cNTEgp5fuX33u7yLP79VFVPKTGJCGouRGDvI9ndot2QYdbPBT0XJeV
         /T3YFKGqU40s/+GCmVFVT5E84p3xK2cA4iY7y9r8HiH56P8RU/OHGF1VutKQCSmYhWLx
         33BaWuGm+Q3nnOFuhyyATgcgvSSuOJUDluFf7ZeHgwmEn1cjwbS/ItKxlccC+Wfnb4b2
         jABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033991; x=1777638791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU5HGQMMAHkFsOD8j+WiLpo76Kie/jMXtxjrTFTeJas=;
        b=BRHryYXaXXasCLzAqm/a3V7V0hx7Rqll2ZD4Rp88tTiqwv4o5+JlrjMIl/pEZNdGet
         tBMhrA7zk9kzQHfh8X/Svn4jA4FJGCePDQ+YGK9fxQGLevukkFN2I8iQ5e15JvLVC23n
         cE2CM4mURCwoNtgJvgJqkPWYIWwiYTCS/RJ8CDmZmgbgVaN+x2MQENOjCks81/phQblk
         wkeQ/Uv6BHYs7WXjpJjRvHr6JU1xP4sfAMyj00nY6TTErZtBQDOTmDZRyTaU+6CifhZK
         7R8MkPJrQ7DgHCU7SKL5OLX7CRLAjR4WXiayeZcruLPOPKl1pJMcW34IIT9nAnynb2gZ
         g5FA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xhcx57yvJ9flcMQLraqP7YluOmZeETJA5+Am70NcKicffdDJfJ1IUTz6H3CtmXXfPR1jglzkkyNcs2WQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5By4AABtYAHFaBL5hAWEUs/9GrvrXsOaV208VuV8oolyTUU7
	y3RSaGnYItpPeh8JiuG0h8SezrOXMMr5Cys88p7/PfVnFsJrcJ/T7B+xW6P9x5uTqnLza6zDkaD
	ZAKWmQY+AoCVHfar+r0fKycFXUsQiYXfixt+BpkPiX72lYlT/+D5YMucyRsDU6LQ+m0w=
X-Gm-Gg: AeBDieujEPSMmuJgW9KOIaNM/h6WxFtQ/xezzVxDKc92YFT7TO3uWEr2N0iVuLsBR6R
	1i0n4p4o4d2sFERC+1mpI4sD35LKWjuPuLcFz3pl5ynN87iKSb1Bm95kscA7PGqfu5c0dEb9rVb
	0EA37P7ZCugNPdv7QtBL5vKwEVrwT5WxMDjMUaQxMMGSSN2LLwzOgAb5g+bBFD56uyGmXeY/1YJ
	NXU5zwZP4+GQP3lColOYeePxd0jRDafYYTUnVeROcnkOikB0od4gi0mIFaKEG+AJ1MLH973vnD1
	A5K2cgGFOLphEMa7n9ZR9ha7EtEpgbB78qCbOMyideUJJcKmFhcFdoD4BGq+WZeQqsrnFYOGlav
	zQOiBFhOOgu5CZqSXPmbfN+ZYHPFIs8l6uOuaKHbFCHGAWqS/iZj3qA==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr307985735e9.11.1777033991127;
        Fri, 24 Apr 2026 05:33:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr307984885e9.11.1777033990672;
        Fri, 24 Apr 2026 05:33:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5a579bd3sm226459065e9.6.2026.04.24.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:33:10 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:33:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20260424083228-mutt-send-email-mst@kernel.org>
References: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <aeozRZ9AvW2jTQkX@gourry-fedora-PF4VCD3F>
 <016cc5e5-044c-46c6-a668-200f90a64d85@kernel.org>
 <aeticBh5XlAlD1vn@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeticBh5XlAlD1vn@gourry-fedora-PF4VCD3F>

On Fri, Apr 24, 2026 at 08:30:40AM -0400, Gregory Price wrote:
> On Fri, Apr 24, 2026 at 09:28:36AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/23/26 16:57, Gregory Price wrote:
> > > On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> > >> On 4/23/26 15:42, Gregory Price wrote:
> > >>
> > >> Maybe we could forward the vma+addr here and call a vma_alloc_froze_folio() if
> > >> we have a VMA+addr to have a clean interface.
> > >>
> > >> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> > >> alone on a v1, and focusing on non-hugetlb first.
> > >>
> > > 
> > > If we're ok increasing the buddy surface this way, then I'd vote for
> > > only updating the exact interfaces that MST needs to update for his use
> > > case in a base set of patches, and then have each additional updated
> > > location (or logical set of locations) updated in follow-ups.
> > > 
> > > My initial go around with this - the patch was hard to read at best.
> > > 
> > > But I also think we should also seriously consider not increasing the
> > > surface of the buddy. 
> > 
> > Exactly, that's why I am saying that vma_alloc_folio() is the only external
> > interface people should be using with a user address. all other _noprof helpers
> > are supposed to be internal.
> > 
> > For hugetlb, we might need another interface for frozen folios later, which is
> > why I suggest to defer that.
> > 
> 
> Yeah I follow now - we're of the same mind on all this then.
> 
> ~Gregory


OK v4 incoming, thanks.

