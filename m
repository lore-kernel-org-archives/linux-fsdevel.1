Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424358;
	b=VCpYVXDG+xkj5XT823Hi6+lZmaFZ0RJAZWYva4rU4+N6RaSp8me2r7HfhZl3GszoQqC3
	 OMfxHSvAz/P+NVt0tTtgnq5AK8C5aqGsyzd8XUBKNuRl8ZIO4D6Zazmm+NKv1jNlbMfK1
	 0l40TygQqppJxDVPXIfGv6053Sb+wEXWqMIonHkH1EOXtEJ3yln8XNcW3y1DN1MLnsbnx
	 WlUVElTiJ5BJlXgxR1o4Iq0dEMu5Yqrc34lzG8RuD+1yZFb0HYokoMmJ5TgjbarMwtGMf
	 2figMRcXljh6KcGdxePJNw5XxSoKDJGY16tPgGJ9XNOU21mIQ3mlCDZJgAFz9hnRTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424358;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9rzvnRWJjWzbxf1CdqOdngD5YMGoOzjDwN76qmbiuFc=;
	b=rRF4puneUnvCIFz1vmNgs4zepY+mDj+BbZgqpIoiHPVULHU3mj6Au+a1x+S630ZAFkva
	 4FGfgBF5wQy6Relbdgq+XSvAWbBQAdJw7jC5jDDdKo/i8nbw2lSxrvM/v7cUOPP3fGeIq
	 XAv7hxkQyh52tOLRA7feK8BevMX73isToek0JaR0fEu9ULZr4VGHaLhCPwE2aDyLObWb8
	 pZUnqq48Svs2jYqGq+aCje48EDosD5lHkygUGAp6gOT1Y9DU5nuVD4Cx/SH4mPJ7UvoED
	 bN++3WB+m7QPpqhLBPllNEeltCvWXXbSXZTaE8JCbfo3SmLEdAF+bJMjsDqEeW+rqfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzfu4WAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21389606A8BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzfu4WAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BA01F00A06;
	Wed, 11 Nov 2026 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424358;
	bh=9rzvnRWJjWzbxf1CdqOdngD5YMGoOzjDwN76qmbiuFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jzfu4WAA6ElJ02kn/Kow/ZSu0s0IB0QJ2OsvUpsYACJnXnbWmm539erPelJDDOfOe
	 aw6+cCZQJJqvUwITWwqeUpUsZd/9qAmO8xWtxYPAh4ibTOCRkVHUc4/WC0mLkcI2zy
	 XDdtfmZEI/5RrpshDsKQsdXJ4xKRLav0prmxY1A0DU+X7K4hgSXVGXvSLisdoU20yu
	 kUvz9iHFP9GrF6KjqI16Hy8aT0y9fkL179uWyhqMnF/PP4hiKaoaqPM8NAE8Py/aP1
	 To5D9e2/M2EdcYoM0Gq597Ns7nEpZq8VXxsmHf8cebTfYQJEJrkSVRGXReYwJulZ4Y
	 62sajGVCqmEUg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 287B8198004A;
	Wed, 11 Nov 2026 14:12:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 14:12:34 -0500
X-ME-Sender: <xms:G770amrD8gScgbw-DSZ-GwPtQMbuwsm61xQ8YBBu2eoq0KGiheKFRw>
    <xme:G770ao09YRvTBtfn3GfjXfli5cV6QN9WCTmWj2TH4EcetMGd2iwrSYv49iuOxdHzR
    8YyB6uIfvK-gwomx5LpDQ3Dxkyp6FZbmjxG6Lht-0xHe6bUhBLoDBI>
X-ME-Received: <xmr:G770av1ZHzAJZuikg6gcG-sMShynkY8UC2ojXveCFDNWNZFpMlp6oSoC-8I>
X-ME-Proxy-Cause: dmFkZTES/6cX0KaFoJYJ4MHvoyZOb6MXDU0/tO2FG3RhJxxbVEfD8pjHEIxsQzk0Al2yPN
    SEhfIex5SKtz3lQPun/UByqNcs/KxTT5GXvxxYylZ4FlJU2QVRNetXmrPMM9RL9Vt+vqmI
    GbyZH9mdeKdScR+BW8cX/HcTaYp4E9mis5e5ATXCP8qD2KZAL6IPA3zSlQRZ2QhQQpw7o1
    2U27Sm7SGvcB8wymQGlny6KDRlL+gv07ozEKC+ckkFNc2fIPs5sPEN/TFM8t+MtO0rkq+H
    8pt3TP4ChsV/1DQckczcrs8gXCDvRLQDfJzvJxquUNHH9cvUj99Q01NMCnsHpJGK1Le+kZ
    4+pDo4bpQyKl62ZpWv7iXTTVuBsu5f+usqWAKQ3eRZbhK9VQt0rRvbUqMjcLfCd6iWOi67
    TZx6wJtmbqeDb5YKJQTg8mVMsB2ssGUxwc0+DrORZGZtNURNi5f84iuKnV5uP1YDAZd3V+
    /EL10zfWdPyT3ztdXn6fHlQ/cOeHFz3MuPej6yOli5FkSC6OHMJJsyQady8n+FGpjxh4tH
    BJZKq251ZhN9/vc588/+ysP2jaAh1lsok4VTfRVbn8wSDQoKxSs6p9H3m+/8e05fRJTfYx
    pcw0WN8tvBrhB49hWK5zJ5q2V3eDoF79C3BirccEq4Qbj72ChN/eTWjQZqrg
X-ME-Proxy: <xmx:G770asc5h1oAcOmCwwQDl1xkUUD7GcZFf0F8wGqNjgRK2NQTMbHu7A>
    <xmx:G770an9vADJNurzo60r-_MXTBWMPFVVEFoEyR-hHdg0kZoOPyWhgmA>
    <xmx:G770aqATUZEpHnmjI6bkXjYRWSkbJ1ffzCUVHhxT5oQ88s_huNJ6dw>
    <xmx:G770alwwSaqIvQ91pyca7EXxdzjnEq1Kz4NZNEpM_httAxmVu2BOpQ>
    <xmx:G770asRAUD0hqvGvbgHVi5Vi85oSX1cF5ovSk-myQbewSgmSaVjrKVd_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:12:26 -0500 (EST)
Date: Wed, 11 Nov 2026 19:12:25 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] mm/huge_memory: build the moved huge zero PMD from
 the destination VMA
Message-ID: <avS-BWznThxIQ1H0@thinkstation>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-6-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-6-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:14PM -0500, Tal Zussman wrote:
> move_pages_huge_pmd() builds the destination PMD for the huge zero page
> by copying the source PMD and clearing its uffd bit, so the destination
> keeps the protection of the source.
> 
> A source VMA registered for RWP can map the huge zero page with a
> PAGE_NONE PMD, and UFFDIO_MOVE does not check how the source is
> registered. The destination then gets a PAGE_NONE PMD without the uffd
> bit, although nothing asked for that in the destination VMA.
> 
> The next access fixes it up through the NUMA hinting fault path. Until
> then, the first access to the destination takes a spurious fault and GUP
> has to take the fault path. The impact on userspace is small.
> 
> The moved entry must have the protection of the destination VMA. To fix
> it, build the entry from the vm_page_prot of the destination VMA, as
> move_zeropage_pte() does for the small zero page, and keep marking it
> soft-dirty. A destination VMA registered for RWP still gets its PMD
> re-armed afterwards.
> 
> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
