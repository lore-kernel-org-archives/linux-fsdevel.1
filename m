Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012924;
	b=akqdXAOVetIzKqlFpd8Ls8sMF2gyVixHXWJ0ir631fWCtxNuFppai8de7AHKr4+3R6C1
	 Utkbv+KZVdJiKHX7jCyToaDUOPjw/su95yC2U2+2KMP6XdKhGFPR9bDfZhRfdpfxTXeoB
	 FQ4r2DwH0c0Bt0aNMTl8vmWpp3A9zfzfCnv7chv0ejfaNLbsM4pAq3l/XYm4KfJP1iQus
	 BODFDYCO3OUUVn8YLo0juXHGBTwWShAd+Y7F5YAZe/AYKhLp1dp6lhRkZQv8NJD88w2JH
	 ENASVfikyuE8wscBZd192Yk7zpt3ifrYG3Z9pezF74rd0vCR9cOG75DbIPZl/+zd6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012924;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QT+a4lJEqwyl0jCFNYDDkazhdWIsc4Kyy0uQnU2xGfA=;
	b=frdseRxPhcof92s/HkoUjJ6idhiGZyM9kWOtXJqElg1Cogd+WGLaTvurzD1EyFhtrnd3
	 7lbBu7b54GdgMxo+55iZF95ff9D6jj8CMFkVNFWal1GsuOIkY8VUHojc0ZAWEw2vG0Ofu
	 2M/95kYgje4xsl1fNfVdcsEyP/7b/VJOQRLDOF0hVvg4Oa1RuVRFAWwd82gWjjU0UCN2A
	 u+MNiPJ6M+T97Afqlzk+Py3RbG9FtSLxFrhx+DTCQYw3nRnoTv/iXYSCrtwO4oNNoPK4Y
	 rzBBvYLkNYtKRCRVF5eaAyYBFHxQ5un/xvajzD2soeA7rB7+otiLwrhECc8IE5gTg0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldFyW8Sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDB606A331;
	Wed, 18 Nov 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldFyW8Sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962D71F000C4;
	Wed, 18 Nov 2026 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012923;
	bh=QT+a4lJEqwyl0jCFNYDDkazhdWIsc4Kyy0uQnU2xGfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ldFyW8SvbFTu9lKav0563xlXtSIQDbuyg1xw2e1nayTCk55kJzo/1oIgWmE26bdOW
	 I8FzmF9aprimQoIkvuWBfuRY1tWhSSga7PfFDuWSQ6p27JjzMI1gpVFv7QncfHIceS
	 Zg39lJed+6fQnfUKqsghD2+ChKDtMGhkscJqAmH6f/MUVEVwDQ8iubpD1Uqgg84icI
	 kqWCa6Fp6kVxQMdfkTTMTddleIftE+RdOCb0XKwdKuTAap/o5R3JPQ1qou/Bm2QEb2
	 G69xSnyim1VrnLrmx+XsOW/vLjQquvVTdfu7545IancepkA4OFfUHYuBPgSrwAt3ax
	 uu7WGXF8ov5zA==
Date: Wed, 18 Nov 2026 16:41:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] mm/huge_memory: build the moved huge zero PMD
 from the destination VMA
Message-ID: <av25LTtBq1hWfEIC@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-6-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-6-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:46PM -0500, Tal Zussman wrote:
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
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/huge_memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.
