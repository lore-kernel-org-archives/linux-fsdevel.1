Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD340F73E;
	Mon,  3 Aug 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765112; cv=none; b=SpcSsz+SKJwHODMgY977+e2Ki0FbMI8CC5B/z+mwwqVmRJRnfUT/Gznpv78KpO1CC4OdXEGSPGrBaJAEKay4AXVagRrP2UVSIChvhaKbWzmSmpdwbd6IDn/vxKOLKXpaanDpWrVzqC5t7LXIcuRPD6OrVaMGZ7triw4S9TkhzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765112; c=relaxed/simple;
	bh=4lxDkEOj1RR7qf34CNRlnZwE1Q+oxk4pOof48/ZrePQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2kVYISHwGVjkbXz/DsDEgqMR0O5dp0MATaB1QNmENO/jkfT++3BfMxsNVSAyKqetf5+N+44GXJ7NTf7Yb6t3EEvDbTnj6wm+7dpO0ipYSIiO6QXCyW3KqIjd0dJE2ErePxXHibi+7Uyad/K7AfkIErOPGlP+OvRwQ54xJi1Hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUXQqDSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUXQqDSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FC91F000E9;
	Mon,  3 Aug 2026 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765110;
	bh=wYWtREcCitn9VzwK20Ul7JwMvS/AiBKt/jNqS56Ugik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUXQqDSwQRNCmkLD5cemnbTUAjHE/irGyvzgbHLxPc0i1jBlBQTukK5HA+aSIvnBC
	 R0SzlslWfUByqQyQLjFv2VKbBHYAmHOj9EWiRF3DvEyZodM3CLzCGvNK/M5dInlK4+
	 U9wzqk6EU/OphCdVnGMO3Czmba3DqbykfibI9bvc3yGFgXNsUJ38xhXuRdsYEfwVdZ
	 7o4p/kjve+UU+zLDVez4Qe7mmlF1YZMvbdm3762IvRErJDJH70Sft4ErX88/PAtZYd
	 cDhgsG0sy69Q3FQZ1KH8SAU/9DRtAzOgrkS2ASxz1hjVS6rI4+uMaAJcrhu06pFGXk
	 q/JRoSBb92K3w==
Date: Mon, 3 Aug 2026 14:51:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 07/15] mm/rmap: track whether the page VMA mapped
 pgoff is anonymous
Message-ID: <anCcMvnsux22LaWU@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-7-e8ecfefea812@kernel.org>
 <1b48cf7d-8906-43d4-a85d-5cfad10a12ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b48cf7d-8906-43d4-a85d-5cfad10a12ac@kernel.org>

On Mon, Aug 03, 2026 at 12:57:44PM +0200, David Hildenbrand (Arm) wrote:
> >  /*
> > - * Then at what user virtual address will none of the range be found in vma?
> > + * At what user virtual address will none of the range be found in vma?
> >   * Assumes that vma_address() already returned a good starting address.
> >   */
> >  static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
> >  {
> > -	struct vm_area_struct *vma = pvmw->vma;
> > -	pgoff_t pgoff;
> > +	const struct vm_area_struct *vma = pvmw->vma;
> > +	const pgoff_t pgoff = pvmw->pgoff;
> > +	pgoff_t pgoff_vma_start;
> >  	unsigned long address;
> > +	pgoff_t pgoff_end;
> >
> >  	/* Common case, plus ->pgoff is invalid for KSM */
> >  	if (pvmw->nr_pages == 1)
> >  		return pvmw->address + PAGE_SIZE;
> >
> > -	pgoff = pvmw->pgoff + pvmw->nr_pages;
> > +	pgoff_vma_start = vma_start_pgoff(vma);
> > +	pgoff_end = pgoff + pvmw->nr_pages;
> >  	address = vma->vm_start +
> > -		((pgoff - vma_start_pgoff(vma)) << PAGE_SHIFT);
> > +		((pgoff_end - pgoff_vma_start) << PAGE_SHIFT);
> >  	/* Check for address beyond vma (or wrapped through 0?) */
> >  	if (address < vma->vm_start || address > vma->vm_end)
> >  		address = vma->vm_end;
>
> Am I wrong or are all all changes here completely irrelevant for this patch?
>
> You mention
>
> "This is necessary in order to determine the correct VMA page
> offset in vma_address_end() when pvmw->nr_pages > 1."
>
> But I don't spot an effective change here.

As per commit message:

	This is laying the groundwork for eventually using anonymous page offsets
	as the index for all anonymous folios.

	No functional change intended.

I cannot enable an effective change here, because if I did I'd break the kernel
and introduce a bisection hazard.

The point is to have a reasonably broken out series that lays the foundations so
the actual patch that enables this functionality is as small as possible for
debuggability, reviewability, etc.

The tracking introduced here is critical for the actual change.

The trivial layout changes in vma_address_end() are done here so there's less
delta in the 'switch on' patch. I can add something to the commit message saying
that if you like?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
