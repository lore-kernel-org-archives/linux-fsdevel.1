Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7A44BCB8;
	Tue,  4 Aug 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842107; cv=none; b=uSIzN24M4e3bznFrdGmD2EuQfrvzqzsGSxmQgTChHWBqFXRS5+z6vTyPvfaMSbyg/u0HX6a16TG+nSawWQpfoKHrd57+tZz00RTPKu4SPnqHUKA73fJb6EeYm0x1rcVGXvzpg1sA0BVhdy8EKNF5wkoRvjLXFbsuiAiO0vG0hEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842107; c=relaxed/simple;
	bh=05pQonuWevrWadlqNmDkEI1/kRTldg0ylrGC3tHU3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgBXh7rzaC3INuLbBOLuapbZcR7VjQdfdGjlDjQskM71MS7YwFH6Lu+X0G8reXgJnxJuhbJfOQQhPU3L6dKgBHKDvCtghhS0DYKX0ORc9j82w47go62Fhmk+QfhsPv9qlxsBvev2TLLrYo5ouDMTEr5TkQ3kaP9374supTZzusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHoS2uq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHoS2uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D21F000E9;
	Tue,  4 Aug 2026 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842105;
	bh=NlvQqMPX1ZBZq6vczB6DK1Q1sg9iUABmibDLc459ooE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnHoS2uq+Wpn11Z4etXu+hxwCLOTiTcnmGh7C2+5V3PHkGFMDITE9z6uYgjCeYU/L
	 fC2NEuRAvvmECwZZAk2YEwJi/IwoCe8YsK5WKKXZVKTQd4iez0HYq95u5/tbxm135G
	 BW+tRjPZmgs+NDRQXQS+Z1PArA8qMZ3MY68n34Q2d8TV/awui74P0GXMnIVCuorty7
	 wc+LZ/aDpCuNW+K8lOzK6vW28Jlb7Q6F04ycjuf6wruLgZ+JZ8nOR4jzNd1mJrn889
	 QN98PED33opeHD+Qj9pfIsMlzShSZ8hTwHnXReg/xD7GXlIty0nulMgyNHSoKB2eaN
	 uL1Z8zxWAFNqw==
Date: Tue, 4 Aug 2026 12:14:43 +0100
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
Subject: Re: [PATCH v2 4/6] mm/s390: constify ptep_get() argument
Message-ID: <anHJh7rPomeJgVHc@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-5-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803164400.531199-5-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:58PM +0100, Pedro Falcato wrote:
> It's a simple READ_ONCE() dereference, therefore it can be const.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Even I can't be pedantic about this one... :) so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/s390/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index e882663a58e7..ec331ec92943 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -986,7 +986,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  }
>
>  #define ptep_get ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
>  }
> --
> 2.55.0
>

--
Cheers, Lorenzo
