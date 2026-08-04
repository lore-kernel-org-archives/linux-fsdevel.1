Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC740926D;
	Tue,  4 Aug 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842016; cv=none; b=NOM2CS7vwIygHyp1fgV+V0bNiKOQLqMs0K2oZpVRBAGAnmGcE4XKT2r2Er30RUwCfKC15ZFP/mBG28HG4m7MxXLmBOzWB8Q0j+MHv8zSRCTprKWpzOC5CXbGJZcbfmvCwSjLfMI0gKJ74NKOiwiXD788BPhojzyDBPWzV9etqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842016; c=relaxed/simple;
	bh=xFohCNTxqvWPabLPBvgzqs/nhKz2HVSPCnuGpv9+Rv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY28H+d6fBOVz937h62wPaN9P3D5LrjvRfcr/H4Kez07HkFqiE5Rz3RmnltZfx5i+Tpit2J2bqU6nc6crxccZOiRYdRT6Cov+YeemnUFslCP/4CqCsez1Bf3dhjakkgiOH3OwtteObu/kTTw8f16aKpqtsvrvF/Ok0jGf5SpSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3bqKum+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3bqKum+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE311F000E9;
	Tue,  4 Aug 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842014;
	bh=8cqD4Td6cmzUoT3kOqg3vmAusK+bPeDWcDnl9ayoHm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V3bqKum+zDMz1wDVK7/W7/Cpna1axIZ8waZJbfhnPeWsV+7SrDqLU8PWSJUbb+3he
	 M4Ja/j3rIk+CPOSW1G/w+YnERDAPmXk+3AzaT1Sz5HuG9ZnCWZDSLd/bqdFHK5D06a
	 TsufOI4BVEZ5xRT2DqCq4kvbr+jQRDVOYtzymVbxhGAK5wvEuNEJ5/0Nz5YX2pMOHT
	 goPV5EbvfQBEpDb2ziiFBVoHsjypWl7xqNlDJ+SsYzL7n3M7DBvJP+LxEDAdh4CuOV
	 XpjxHXJY+Wb/A1v3WDrBJxb6mVTS1u6Ems+3MMJol5M0Iioj3XhSxbtErG49jJSQwY
	 wJA5izhsuzVzQ==
Date: Tue, 4 Aug 2026 12:13:13 +0100
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
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
Message-ID: <anHI4B-lMu6AJJfA@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803164400.531199-4-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
> There is no need for write access to the PTE.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

With below addressed LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> index e2ea8ba9f8ca..f2bab31040c7 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>
>  #ifdef CONFIG_PPC_16K_PAGES
>  #define ptep_get ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	pte_basic_t val = READ_ONCE(ptep->pte);
>  	pte_t pte = {val, val, val, val};

Worth making these const too (that {val, val, val, val} horrifies me btw :)?

> --
> 2.55.0
>

--
Cheers, Lorenzo
