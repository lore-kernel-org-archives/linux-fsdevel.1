Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4E330D23
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956235; cv=none; b=WwNaSwsH9HnjCpLvA1Xzslx/eRzq2pJsBe5biYGmydpgHCAt56aTHzeSy7Ixs5kkjJVZajSbJ+tUZdMJmrGZERqSH39Au6/YF+Dcm5bmVhDU7rlvp5Jg1PZO6Ko3c59550rMl6zzoWKw+N2Jmualz5utOCO8yjirdeVDGkIKKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956235; c=relaxed/simple;
	bh=fIawO2hxPLFjqOkLBkMpxy2zyH+AEclGIIHs3EfYteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7ucg1T8DNBQC10qU13O5Hs6uLSKBypUjv/aV8SEen7EEiyRse4k/UHIJZuQ9bXZSPaoZdQyvS1i9JaVrRoX7RRGbnIDfz/yTLqND4Pnh0Ue1qbBVqt+x3rEhrlCUs6Dfgg3kRdLoXbXaOkjy2MT4VgNHOHsJuFt8y9jNuT0etQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GaUTX6F5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GaUTX6F5"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a093c784b0so79316496d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776956233; x=1777561033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAoC6Cd2m8uJEAdJCqdAkQcG7d/SgM3iZ532Fzycwn4=;
        b=GaUTX6F5kvVAf/bHXGs+jm7PcZoP2YyFeJ5IY4tn1Hm7IsjD/vsWwUWFwiVBTbH/Mg
         eeeadq7BLOfhNeuz6fsPSiVIz0YX1FKYN6mr6UPpGr07O5kH+PvYh4m3Dyq9Ds8n8uaW
         18cMtHJGngkJGPat9sIvdcFEdgtmSmIpeqsLQs4+ftQME4bB46qwdsx3QvenSQ5VxMaP
         k0VqC4HOLh4rtHQcli7A1Um6LIECKs47Rsb53wvcM7+nlGseOGMfWjGAGA3eIJUTgtNC
         pTiSZUuWhmSj6NmXBZBvXvKPafadYpiZbTgmHL8ucL1Jc/af8FTUKnPOcRB0KDpg1MJb
         W3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956233; x=1777561033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAoC6Cd2m8uJEAdJCqdAkQcG7d/SgM3iZ532Fzycwn4=;
        b=UQ1HNM3yiNRc5vkcwSoNKl731OAwTSsw3/lNHGOOkmNC8MhQlrBFLnyNe/IS4c81fL
         V6RduO+VpHBZG0QaPDwoaw7Is6iGreNeu8PhU52G1BQryEf2hCi0q/IVCglMHcCETAYr
         H6s6dnWwgWi4SnkqnPOy9EMbnPJH1o1Tpb2jtmLdl3XGAUS6PM4eTMtXuD6lXqXf98P+
         buYgLZGFFNAGPoeMrwsVvYxQIJGTjAA3z0VQsDBSCI6WePXn4QbH8YH8NK0R0pX1rdna
         D7bloqNxpZpF/Iyd0eTtIwamX4AGVfEXuVZ4JE+n9hMiK64JFruno1cz9wdSavz7aj9V
         Zcaw==
X-Forwarded-Encrypted: i=1; AFNElJ88/EnFQd0IeNEeIRiEfkg0ObauSi5+e5ahq/zxSY1okn/Kk/ZZEseO5nU+CrOgc4/cOJJumAZGnTJP7ljh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zyQuBPlzr4A+rCanxjcYouastIUWxcw8Z6tvJIPGpetmGbmh
	HeSNoBCpDR+iWwV9YtZBUUuND5KRFRFEbYs/c2tvc6if9YG0UyGUmUbrxXvVeBl5pe4=
X-Gm-Gg: AeBDieu5ZPz/S6IhbJOUZkpqM+msoZrc/JetQlFkAcVBhh1AeXSYuIxAGpS3F4IMfTy
	pXJjj3k0/RcHj8wnvNEzxp/hEf/7a6E+wi9xAd1oG/Geqj2oM1QvlCARZJHJIbhAyleqER0wK9k
	DRmIPafwYOsIFCr44BsW7m3CowEs3sONS7VrTTZ/eatxU2lAf52UL08VMDvL3uYhBtsi5qZXzyS
	e2sRVJLjUzyfuKwi5d/+bXunrE/2CWRmptZyukZrpRbN56FGYsVlopmp0AnRWjuVZ720p0TyUwG
	aF8b5D9V/Dh0imcmSCXx8LBWcdCexMWMajgG6RhrTnXbyCJp5min4hZhPKW3Mweg9dlznkXRQog
	/MdVHG8DDjoGAqVtzC+hQfvJxm+cedah0Al/Mbs8pVQfWc8+4RleN/vQNJKhWyrn6wgucwMWyyL
	JxEmV3yIE0fxU137ygNQnryyXjrqw308sicEqKyQhz8jO1lbg10zHJESNV6N2FuGkh1H75XyBOj
	GJtK0OO7V8ZIbbR1xAb
X-Received: by 2002:a05:6214:4e03:b0:89c:5289:4be6 with SMTP id 6a1803df08f44-8b02805a894mr389230206d6.13.1776956233021;
        Thu, 23 Apr 2026 07:57:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c26csm164285926d6.31.2026.04.23.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:57:12 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:57:09 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aeozRZ9AvW2jTQkX@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>

On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 15:42, Gregory Price wrote:
> 
> Maybe we could forward the vma+addr here and call a vma_alloc_froze_folio() if
> we have a VMA+addr to have a clean interface.
> 
> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> alone on a v1, and focusing on non-hugetlb first.
> 

If we're ok increasing the buddy surface this way, then I'd vote for
only updating the exact interfaces that MST needs to update for his use
case in a base set of patches, and then have each additional updated
location (or logical set of locations) updated in follow-ups.

My initial go around with this - the patch was hard to read at best.

But I also think we should also seriously consider not increasing the
surface of the buddy.  We already have two patterns (either you need to
call folio_zero_user() or you don't) and adding the wrappers to handle
this internally means we have 3.

It's a nice to have, but i'm not sure it decreases maintenance issues.

Just my 2-cents for what it's worth.

~Gregory
