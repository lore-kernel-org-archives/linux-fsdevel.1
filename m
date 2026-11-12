Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508457;
	b=haWL8BdoQfautMBOId8mXymUL0sQH+kCB50ltp26Tt8xk8P+gMamlHV1MB7R0OBcPrnY
	 IR15pGxbJDjq9B9VbaLmsiqypi8PAL0LenTSqGdcQ3LVBVzWgb1IBJjnWaSRBtvJ/muhA
	 b7SPwrPtgbTjiUO2zcqe4SaycjDIojX/0Pt3dQFOgRU+mkYtwzq5+IaRSVasF0cVLaX6D
	 QMZxBr4VoE8PyJE6DyeIhtS03vgk9CwdB6dBWIhihetwQoYq1xbKH0FCdnGqCKJDCC/N7
	 CxghROejH0sz1j2DZYQF5JLdc9EovVAyQccn1t3JGV0BB0kgerWI3cUaooJeQ1PPyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S83ufdCuikPlcGyicMt7mpw+fBC8MVplA5DoPA/0lZw=;
	b=P4aj9+N/NzEJ6uFM5RcN3il46NY4kkyS+QnLCqeI/fidxglUm9lW9Fa6+uxhMnz3H9TQ
	 kB8CRZF8Oug00H0nluk3+O1xeYU5joRhPjmDVrpf7Hk90gQ8IH0avQoEcuYzsLNr1l8vX
	 Qu0cY45DWc+bP7ykVGDxjXvkzeTNIV2RSXtJNfiEUKT9scwFoheDuonoMgkI19J6HExwp
	 M/o4m+KL4MQHPdPu6ssjVKxGm7wuST9uoLl8wO5NtGy/x124jzXiVGoaCmWKQtE1SuGMA
	 6sIj4gCX2AQEcmnnGIjc+WZyEYHsUf+DBjyJYAaN/Yw8pvYFwiGig5SCjOLvWmiC3FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ijVUa1/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E3606A32A;
	Thu, 12 Nov 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijVUa1/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877AC1F000C4;
	Thu, 12 Nov 2026 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508457;
	bh=S83ufdCuikPlcGyicMt7mpw+fBC8MVplA5DoPA/0lZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ijVUa1/34L3eHye3zw1zN/jAyO3526dLl8D+nYyREiy4hhDzOFJpJrb4r8+nEaUUx
	 JBE0foYCokhvT3BCWxqXX2EMxkzVL6UklJzacnsibjmkOF7aAe6VjVcfSaixmhDat5
	 xSEAZ92rm5t0S9ncbxiexT0z/XgwndpFr92CPMNhSCW5HIlziX+SNQjKmgdSWHicyt
	 brSJvjlB+BP0Lgm8J16kaGtiezulqMucdc69bfguxXhXtWHsfXqv5K7UBRRbGM6JCy
	 ADXCLZ3sWbMHVZuXxhQOivf3FZj+tl7zhkdQ8DHsio+K27kcFvUG64TnK0YU8zKulU
	 y753u/meLtukA==
Date: Thu, 12 Nov 2026 18:34:05 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] fs/proc/task_mmu: downgrade writable migration
 entries in PAGEMAP_SCAN write-protect
Message-ID: <avYApSoRMz7IZSox@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-3-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-3-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:11PM -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects pages in a VMA
> registered for async uffd-wp, and sets the uffd bit on non-present
> entries as they are. An entry with the uffd bit set must not be
> writable, so that the page is write-protected once it is mapped again.
> change_protection() therefore downgrades writable migration and
> device-private entries to readable ones first, but PAGEMAP_SCAN does
> not.
>
> For a writable migration entry at the PTE level,
> remove_migration_pte() restores a writable PTE without the uffd bit. So
> if a page is under migration while PAGEMAP_SCAN write-protects it, the
> write protection is lost. A user tracking writes with async uffd-wp
> sees the page reported as written on the next scan although nothing
> wrote to it.
>
> With CONFIG_PAGE_TABLE_CHECK, setting the uffd bit on a writable
> non-present PTE or PMD also triggers a warning.
>
> To fix it, downgrade writable migration and device-private entries
> before setting the uffd bit, as change_protection() does, at the PTE,
> PMD, and hugetlb levels.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/proc/task_mmu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d..53780a454432 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2395,6 +2395,38 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  	return categories;
>  }
>
> +/* Downgrade a writable migration or device-private entry to a readable one. */
> +static softleaf_t make_readable_softleaf(softleaf_t entry)
> +{
> +	if (softleaf_is_device_private_write(entry))
> +		return make_readable_device_private_entry(swp_offset(entry));
> +	if (!softleaf_is_migration_write(entry))
> +		return entry;
> +	if (folio_test_anon(softleaf_to_folio(entry)))

Hmm _seems_ a bit dubious. You identify a readable exclusive migration entry by
checking whether its folio is anon?

But I guess because a writable migration entry can only come from a writable
PTE, that implies anonexclusive. But you do need to explicitly say that.

Also we really do have to break this out as a helper. I see it's open coded in
change_softleaf_pte(), change_non_present_huge_pmd() and
hugetlb_change_protection().

But maybe that can be a follow up...



> +		return make_readable_exclusive_migration_entry(swp_offset(entry));
> +	return make_readable_migration_entry(swp_offset(entry));

This is all super compressed.

I'd say add to leafops.h but break it up:

	static inline softleaf_t softleaf_migration_mkreadable(softleaf_t entry)
	{
		const pgoff_t offset = swp_offset(entry);

		VM_WARN_ON_ONCE(!softleaf_is_migration_write(entry));

		/* A writable anon migration entry implies AnonExclusive. */
		if (folio_test_anon(softleaf_to_folio(entry)))
			return make_readable_exclusive_migration_entry(offset);
		return make_readable_migration_entry(offset);
	}

	static inline softleaf_t softleaf_mkreadable(softleaf_t entry)
	{
		switch (softleaf_type(entry)) {
		case SOFTLEAF_DEVICE_PRIVATE_WRITE:
			return make_readable_device_private_entry(swp_offset(entry));
		case SOFTLEAF_MIGRATION_WRITE:
			return softleaf_migration_mkreadable(entry);
		default:
			return entry;
		}
	}

> +}
> +
> +/*
> + * An armed entry must not come back writable, so downgrade a writable
> + * migration or device-private entry before giving it the bit, as
> + * change_softleaf_pte() does.
> + */
> +static pte_t set_uffd_wp_swp_pte(pte_t pte)

This is a contradictory name, you're interacting with softleaves, there's no such
thing as a uffd swap entry :)

I/we obviously have to go and fixup the naming (I didn't _quite_ finish the
softleaf conversions I guess) but let's not propagate it.

> +{
> +	softleaf_t entry = softleaf_from_pte(pte);
> +	pte_t newpte;
> +
> +	if (!softleaf_is_migration_write(entry) &&
> +	    !softleaf_is_device_private_write(entry))
> +		return pte_swp_mkuffd(pte);
> +
> +	newpte = softleaf_to_pte(make_readable_softleaf(entry));
> +	if (pte_swp_soft_dirty(pte))
> +		newpte = pte_swp_mksoft_dirty(newpte);
> +	return pte_swp_mkuffd(newpte);
> +}
> +
>  static void make_uffd_wp_pte(struct vm_area_struct *vma,
>  			     unsigned long addr, pte_t *pte, pte_t ptent)
>  {
> @@ -2408,7 +2440,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
>  		set_pte_at(vma->vm_mm, addr, pte,
>  			   make_pte_marker(PTE_MARKER_UFFD_WP));
>  	} else {
> -		ptent = pte_swp_mkuffd(ptent);
> +		ptent = set_uffd_wp_swp_pte(ptent);
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
>  	}
>  }
> @@ -2467,6 +2499,22 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  	return categories;
>  }
>
> +/* Same as set_uffd_wp_swp_pte(), for a non-present PMD. */

No need to say non-present. Naming it with 'softleaf' somewhere in there implies
that. E.g. set_u

> +static pmd_t set_uffd_wp_swp_pmd(pmd_t pmd)

Same comment here, this is just hugely confusing.

> +{
> +	softleaf_t entry = softleaf_from_pmd(pmd);
> +	pmd_t newpmd;
> +
> +	if (!softleaf_is_migration_write(entry) &&
> +	    !softleaf_is_device_private_write(entry))
> +		return pmd_swp_mkuffd(pmd);
> +
> +	newpmd = softleaf_to_pmd(make_readable_softleaf(entry));
> +	if (pmd_swp_soft_dirty(pmd))
> +		newpmd = pmd_swp_mksoft_dirty(newpmd);
> +	return pmd_swp_mkuffd(newpmd);
> +}
> +
>  static void make_uffd_wp_pmd(struct vm_area_struct *vma,
>  			     unsigned long addr, pmd_t *pmdp)
>  {
> @@ -2477,7 +2525,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
>  		pmd = pmd_mkuffd(old);
>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>  	} else if (pmd_is_migration_entry(pmd)) {
> -		pmd = pmd_swp_mkuffd(pmd);
> +		pmd = set_uffd_wp_swp_pmd(pmd);
>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>  	}
>  }
> @@ -2547,7 +2595,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>
>  	if (softleaf_is_migration(entry)) {
>  		set_huge_pte_at(vma->vm_mm, addr, ptep,
> -				pte_swp_mkuffd(ptent), psize);
> +				set_uffd_wp_swp_pte(ptent), psize);
>  	} else {
>  		pte_t old_pte, new_pte;
>
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
