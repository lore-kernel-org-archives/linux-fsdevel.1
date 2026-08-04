Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDB43849B;
	Tue,  4 Aug 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841891; cv=none; b=dEoAdRi8gS9fsX0Y3n5Vic4Mw6lsOrKiSdNhSn61Oo6df/aEpRXBAtszpFx3jrjRr7nAZZpiehLGMLjVyLmsIHwFzd+H+DKtyihF6kVLn0ZvUbRS9cWA/cbwDChdp1mKhVnjnsNeuHvXHNCBZW8fy20tl2PA2G4O9WVOXqiwrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841891; c=relaxed/simple;
	bh=uZ4TjfAkUZ3+zh+YnIm7kEuHNm1VmunsPOFSCylr8DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlXJ8nqixQIJqGW2S8ElsBTALKbgysvuPae+cczngwvVxc+aL1xqF3nh4S7JJURyz9cIjsIXRzV7U53A6nLhb/Y+fl5GbBq176yUCBLrQgnUsTRvSYTzbmCK3PVkciO+ranIUzYASex46uIIMwdv9ra1Ev5KWbVp665QO4sIdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR2VBNRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR2VBNRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189511F00A3D;
	Tue,  4 Aug 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785841889;
	bh=lPlMqpw1IDLRtYVeniRNxYTVPDHrNiexqffQCORp34g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nR2VBNRV0pk1/OgzMczs6p6psKwdhUOyZldMBZXdygQAo/uvz9Wm+fZryWyxvHs1N
	 tugMO3FuAf8iTrlmndYjOm/Bb/N2rPZdKEmFl846PR+iMA0btzcbh2c3EJcd8mHuuN
	 fdGFsBi04TbQFLPu9RVEjd22d+D6Cay6M2i7vOJMy6U9VB1zlCfalZJjnNA8BRXlsZ
	 cbAldKjKURmWlZZvTpkRiXIqqL4UOmUjNeH/t+yvRz0qMxgWP69xU+r6rms3nYh3Ei
	 EHdYt4bqTsBxaFdvBxzCK1DLNkVJdNj41y96psFb8DllhxnbvJ6lbCR59BEPua/jAx
	 QNUZ57jLN53YQ==
Date: Tue, 4 Aug 2026 12:11:08 +0100
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
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHHyiHqYf3yLf2K@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803164400.531199-3-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> From: Helge Deller <deller@gmx.de>
>
> Switch to the generic implementations, which are identical.

You sure do like succinct commit messages :)

Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
ptep_get defines you get the generic versions from include/pgtable.h which are
functionally identical.

(Being pedantic, they're not quite strictly identical as the
ptep_test_and_clear_young() generic function does some weird unnecessary
indirection with a local variable and the single {} is dropped etc.)

>
> Suggested-by: Usama Arif <usama.arif@linux.dev>
> Suggested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Nits above notwithstanding, LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/parisc/include/asm/pgtable.h | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index 467b8547ac8b..d92dee9fef3f 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -432,25 +432,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  	return pte;
>  }
>
> -static inline pte_t ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}
> -#define ptep_get ptep_get
> -
> -static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *ptep)
> -{
> -	pte_t pte;
> -
> -	pte = ptep_get(ptep);
> -	if (!pte_young(pte)) {
> -		return false;
> -	}
> -	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
> -	return true;
> -}
> -
>  bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>  pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>
> @@ -491,7 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  #define HAVE_ARCH_UNMAPPED_AREA
>  #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>
> -#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>  #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
> --
> 2.55.0
>

--
Cheers, Lorenzo
