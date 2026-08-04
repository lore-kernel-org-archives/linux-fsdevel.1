Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B5432305;
	Tue,  4 Aug 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842154; cv=none; b=teOTB/8Pu/Qy0atptGyk2ePAQqIIyKkw8On6wxP9sOnSca86ymUN3csBN5XOkAUGgeiT8swzVlrVqEpml/ZiR4UTe+MgsglkE3c6BlOKd25jwm0I9wigfBAghSrluJlRkV0TA8mLujQylzVisBnfVAH55umYFd1Tv3OVTUd1Qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842154; c=relaxed/simple;
	bh=qFnbsM626ELwdNtL0dbdQBBMgnCwjIHLLiSvzHBQ+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StGWGk+lhpm0ie5A6bxDTokUj/S853PA1zEMS3o+SBLn6IHe5agyUC4DqnEszOHqxWi/vp7jjW4wW7cWH8iZpjBsbclt8U5VtaQqAeHOLFVJlVKRLqw30jJjSMDsfpB4WSXY1CxdgGUO27b2FrRnxaj6KobVCFDUD1Fj4ZsIiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCdqhtW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCdqhtW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046C71F000E9;
	Tue,  4 Aug 2026 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842152;
	bh=1BnYhgvMr/FHPkS0bNJFQoIeIyjuwgqHxPYj6YvNKVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCdqhtW0GuGx813a1jz15OF/gAOcKlGQQMgstOkscJnbZ80cNSpXodL8obchTcvvY
	 KQN/nV7kGqJm+LgZAMxiWln9TvZ9vdXnXKBNn04G5L50+Jtsera2TdakLrWXQPjpRJ
	 x8VVNbIUYTfqBCCHJia88Qyqm/NaABhvVg7mu4+1dGtQVeVDCeexi1Iy6rImYBMNfi
	 yuvK2QUypp85rdG0Cu3jYFHIqsB3PJSA8ZplOmQs5oOP8mjC8gas04Nptnlq3h+Y8s
	 Y9VUnlv4cYWu2FTlz34/ZW1CV/hhjFHJB7a6P2rmFU++gl2FT7ktYhKgMqjMNRVXzR
	 yYKcYv6kfq3MQ==
Date: Tue, 4 Aug 2026 12:15:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: constify generic pte_get*()
Message-ID: <anHJtpEpXWITllqk@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-6-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803164400.531199-6-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:59PM +0100, Pedro Falcato wrote:
> None of the helpers need write access to the PTE. Constifying the param
> allows for const typesafety.

constity?

>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pgtable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a..dc418553e57a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -490,7 +490,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  #endif
>
>  #ifndef ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
>  }
> @@ -739,7 +739,7 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>   * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
>   * operates on present ptes we're safe.
>   */
> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>  {
>  	pte_t pte;
>
> @@ -777,7 +777,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>   * We require that the PTE can be read atomically.
>   */
>  #ifndef ptep_get_lockless
> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>  {
>  	return ptep_get(ptep);
>  }
> --
> 2.55.0
>

--
Cheers, Lorenzo
