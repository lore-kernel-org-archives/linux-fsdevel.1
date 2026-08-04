Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E292D780A;
	Tue,  4 Aug 2026 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826546; cv=none; b=fZSEXdkvs13xuYGqdzlSM+PxmJvQMoHwlLi3b3oBmldxX39VX4fS4cxy+714wN/LZL7L19SKRuLR55IU3SLcbe85KdYtszP3EMrVa5KAzpM6RWz1aGnNTalSGsEFK8Bx9zQUdFFuJPQCQ3L3+WrF/1LoTSLD0tYXw+NvNRc9o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826546; c=relaxed/simple;
	bh=GBT+Ex3Jn0pzbU/xWjAbTpCmXVN2j3+08ZLGvHaH1Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siV8aBUsuPBWDD6tKatvCc4UMhei4TxuIGGtEnsTk+Dq5TdVxNakut/W2vziJo6b/OjFiJ8uV8tLDFbDef1fvtKHGebPQoWJEIC1NDC5/eMeA+oaI9d7bZ7tffuw8kRdgzqskN5CiTOfcVSDhQPZDv1IhPbCkNnkbPxUbE/80K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbNtAUP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbNtAUP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F421F000E9;
	Tue,  4 Aug 2026 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826545;
	bh=/inuUUE7PQn5pXqFZbcUUpwxLgwvoHVFospppktrMWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mbNtAUP7NOImB5wZVPLajIJgt4qTJhcRTQR41c7f2f8IbyJ6bfKgDBznp+BZNkAfH
	 +C/lABCLKP88/irz3UbNtfv/pPXh9AjZHY4trB4h6AGmGfEQh+JwOB4NW5DBIJD5tC
	 OI/Sk6b2gqN3cc+YfZfxLjpRh/RW80NbiEAajjiqNXIZcNueCUj4JirZZ4/Rt10bN8
	 M98wQAMK5WdctyKVs4LcJQ44Iv18jQuihXX+1qp1ZlOh8GG31G4+BvBZkhznZUqd59
	 7/hhxUzQ0G7wJQPqlje6p0OBqkYpqeyV2qkT0/7QqK8dGrIJS7VB0cG4F3oXKySaSa
	 AVStjbMOY0Jhg==
Message-ID: <d031d9f5-b248-4251-9214-448b7be5bd3e@kernel.org>
Date: Tue, 4 Aug 2026 08:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] mm: add basic PTE const type-safety
To: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260803164400.531199-1-pfalcato@suse.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260803164400.531199-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/08/2026 à 18:43, Pedro Falcato a écrit :
> Since forever, MM code has thrown pte_t * around with no concern for const
> safety, or typesafety of any kind. This is confusing. Attempt to address it
> by:

What do you mean by "typesafety of any kind" ?

On powerpc64, pte_t is a struct so you can't play-up too much with it.

On powerpc32, pte_t is a long int because having it as a struct is 
counter-performant, but we have it as a struct when __CHECKER__ is 
defined, ie when doing a sparse check with 'make C=2'.


> 1) Making sure pte_get*() helpers can cope with const pte_t * arguments
> 2) Constifying the pte_offset_map_ro_nolock() return type, which by definition
> already pledges that users will not write to it.
> 
> These two simple steps were already able to uncover code smell from
> khugepaged + do_swap_page().
> 
> Separate steps could include introducing pte_offset_map_ro_lock() for more
> widespread usage of this.
> 
> Benefits of this include less confusion and better type-safety. It could also
> futurely aid in efforts such as [0] which may want semantic annotation of these
> accesses.
> 
> Based on mm-unstable and compile-tested on a handful of architectures.
> 
> No functional changes intended.
> 

For the series,

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> [CC list editorially trimmed for brevity reasons; apologies if you're not on it]
> 
> Link: https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-0-eaaacdacc67c@arm.com/#t [0]
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> v2:
>   - Small fixups on the arm64 side
>   - Re-order patches in a way such that bisection is preserved
>   - Pick up Helge's patch dropping parisc ptep_get()
>   - Constify s390's ptep_get() as well
> 
> Helge Deller (1):
>    parisc: Drop own implementations for ptep_get() and
>      ptep_test_and_clear_young()
> 
> Pedro Falcato (5):
>    mm/arm64: constify pte_get*() and contpte get logic
>    mm/powerpc/8xx: constify ptep_get() argument
>    mm/s390: constify ptep_get() argument
>    mm: constify generic pte_get*()
>    mm: constify the pte_offset_map_ro_nolock() return value
> 
>   arch/arm64/include/asm/pgtable.h             | 10 +++++-----
>   arch/arm64/mm/contpte.c                      | 11 ++++++++---
>   arch/parisc/include/asm/pgtable.h            | 20 --------------------
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
>   arch/powerpc/mm/pgtable.c                    |  2 +-
>   arch/s390/include/asm/pgtable.h              |  2 +-
>   include/linux/mm.h                           |  4 ++--
>   include/linux/pgtable.h                      |  8 ++++----
>   mm/filemap.c                                 |  2 +-
>   mm/khugepaged.c                              |  2 +-
>   mm/pgtable-generic.c                         |  4 ++--
>   11 files changed, 26 insertions(+), 41 deletions(-)
> 

