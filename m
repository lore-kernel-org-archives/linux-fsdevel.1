Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483795;
	b=MVwOx4HfiXgwiPwrl1BgrCu0PmGHFVGOYp3eBKAlPHMcpDz1wKYNR8DkVun2+xycAH8A
	 e8cuv1YCgHVv1vRCEAME3VlEJbhH+unpVlcM721rz9j16bx8kOuwYnzFrcjM1sc+2sryK
	 nKkwrZ1JUhSg7adZaVVZe3PyhJBgyPb9c5O86wLFw12JMq4WP7VIoHYI2mg5LNqureFKf
	 cH4AHYxEW4PB29Hp8kfYbtYBbpNDciKBQpG5Zpkx8Pfgb6i1EVe0f13FFCekU51lTT/Gb
	 iBUQ3qsDhNFvnLp3w9IjVdaoYrZnjnJlidHFRl7+W6CFYdBOsHqIQUoEJJLbvp0s0tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483795;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xC7ztYSbGZgergptZvU86w+F0TCn5s5YYDHUR4p4fC8=;
	b=uHX/dkqmHpNeoq2Ks9kl3tZgLSwdNS/uf4SVxBUJZS39MzH/oe0dqbBLH6iTM1i+xGF6
	 MhTHJIXtwKw8jw+wgRfxzw6ki6kEwo1Rd4bkYI7gIs+JoT9xNyUZ4WeusEeUH+RBdq6qM
	 BKhns8qqU8SiKyl+PYc/Sj3Wpxw91nfOllU1t8fb75/Q6am0Rkcp/rBd3Rl5ESuAErsHL
	 MqxzShkaa33UQX71qv6ECxWeEbEr5RWCJDjjjB2V1LrpugJ/ZECnQXHTPFz9gFrC3IhF9
	 ZP8d4RiRHENovq049u5oCJdPfEO38kj2zT/Q3a0oDR5aF4PrIsaGTRDaTyCfZ85X2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="arkrZnM/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB8606A31C;
	Thu, 12 Nov 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arkrZnM/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE561F00A05;
	Thu, 12 Nov 2026 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483795;
	bh=xC7ztYSbGZgergptZvU86w+F0TCn5s5YYDHUR4p4fC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=arkrZnM/6xv5O9v/rTOhm0EDuiK6x5Nn7O0xAxMc2JgnHsP3UHe3z/Y+skcxP+bHt
	 4q5HxTo9yhupQI7fSEkR4tKMI6KdvxIu7ugqhLhMKSnEulPRovVt2XmfD0R0guyNL2
	 T2a6ZQxEsIitrbxl+cRGEAuonXHlUxgErvzMtvEj+XEUWLlKhtI1p4dl1ywZoZpON4
	 pwfUTeXEWy+Ym6ctCSIvbhG+9O7LJjG2R9l62z08bwlny6HFV1wB8J9fNKps3JalYg
	 cxN6sUz7UkdQ/nhVB2rJjTVFYIVJrEx/xxo5f2cb+mS2UpmdpCXPrLsrkEcsVMGFtr
	 oyADUJeDkJ/2Q==
Date: Thu, 12 Nov 2026 11:43:03 +0000
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
Subject: Re: [PATCH 10/12] mm: set the uffd-wp bit on a guard marker when
 write-protecting
Message-ID: <avWhaJzGbuIM-Bh-@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:18PM -0500, Tal Zussman wrote:
> UFFDIO_WRITEPROTECT and PAGEMAP_SCAN with PM_SCAN_WP_MATCHING do not
> write-protect an entry that holds a guard marker. change_softleaf_pte()
> ignores guard markers, and make_uffd_wp_pte() only sets the swap uffd
> bit on the marker PTE, which guard removal clears along with the marker.

There's no 'swap uffd' bit, softleaf uffd bit :) (I need to rename some stuff
still...)

>
> On a file-backed VMA, the page is still in the page cache once the guard
> is removed. It faults back in writable, and writes to it are not
> reported.
>
> To fix it, set the uffd-wp bit on a guard marker of a file-backed VMA in
> both paths. A guard marker can carry that bit, and guard removal then
> keeps the write protection by leaving a uffd-wp marker in its place.
>
> Move is_guard_pte_marker() to leafops.h as pte_is_guard_marker(), next
> to pte_is_uffd_wp_marker(), so that make_uffd_wp_pte() can use it.
>
> A page that is write-protected while a guard is in place is now still
> write-protected after the guard is removed.
>
> Anonymous memory is left as it is. With UFFD_FEATURE_WP_UNPOPULATED, an
> entry that is write-protected while a guard is in place is still
> unprotected after the guard is removed.
>
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Similarly, please drop this patch.

This does leave the opposite order (guard region _then_ uffd register etc.)
unaddressed, but guard regions behave as if the range were unmapped, and
uffd-wp state does not survive an unmap/remap either, so I think it's
reasonable for WP not to propagate there.

> ---
>  fs/proc/task_mmu.c      |  7 +++++++
>  include/linux/leafops.h | 14 ++++++++++++++
>  mm/madvise.c            | 11 ++---------
>  mm/mprotect.c           |  5 ++++-
>  4 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 752f1b13d47a..7b1c843a4fd0 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2439,6 +2439,13 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
>  	} else if (pte_none(ptent)) {
>  		set_pte_at(vma->vm_mm, addr, pte,
>  			   make_pte_marker(PTE_MARKER_UFFD_WP));
> +	} else if (!vma_is_anonymous(vma) && pte_is_guard_marker(ptent)) {
> +		/* Keep the protection in the marker, as mprotect does. */
> +		const softleaf_t entry = softleaf_from_pte(ptent);
> +
> +		set_pte_at(vma->vm_mm, addr, pte,
> +			   make_pte_marker(softleaf_to_marker(entry) |
> +					   PTE_MARKER_UFFD_WP));
>  	} else {
>  		ptent = set_uffd_wp_swp_pte(ptent);
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> index add4968ded44..831b85a184c4 100644
> --- a/include/linux/leafops.h
> +++ b/include/linux/leafops.h
> @@ -547,6 +547,20 @@ static inline bool pte_is_marker(pte_t pte)
>  	return softleaf_is_marker(softleaf_from_pte(pte));
>  }
>
> +/**
> + * pte_is_guard_marker() - Does this PTE entry encode a guard region marker
> + * leaf entry?
> + * @pte: PTE entry.
> + *
> + * Returns: true if this PTE is a guard marker leaf entry, otherwise false.
> + */
> +static inline bool pte_is_guard_marker(pte_t pte)
> +{
> +	const softleaf_t entry = softleaf_from_pte(pte);
> +
> +	return softleaf_is_guard_marker(entry);
> +}
> +
>  /**
>   * pte_is_uffd_wp_marker() - Does this PTE entry encode a userfaultfd write
>   * protect marker leaf entry?
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e2c6b0f26672..e8b05dc899f1 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1085,13 +1085,6 @@ static bool is_valid_guard_vma(const struct vm_area_struct *vma,
>  	return true;
>  }
>
> -static bool is_guard_pte_marker(pte_t ptent)
> -{
> -	const softleaf_t entry = softleaf_from_pte(ptent);
> -
> -	return softleaf_is_guard_marker(entry);
> -}
> -
>  static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
>  				   unsigned long next, struct mm_walk *walk)
>  {
> @@ -1117,7 +1110,7 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>
>  	/* If there is already a guard page marker, we have nothing to do. */
> -	if (is_guard_pte_marker(pteval)) {
> +	if (pte_is_guard_marker(pteval)) {
>  		(*nr_pages)++;
>
>  		return 0;
> @@ -1275,7 +1268,7 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
>  {
>  	pte_t ptent = ptep_get(pte);
>
> -	if (is_guard_pte_marker(ptent)) {
> +	if (pte_is_guard_marker(ptent)) {
>  		const softleaf_t entry = softleaf_from_pte(ptent);
>  		const pte_marker marker = softleaf_to_marker(entry) &
>  					  ~PTE_MARKER_GUARD;
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6cc5b99b4185..3f2d6e3aca93 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -261,7 +261,10 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>  			const pte_marker old = softleaf_to_marker(entry);
>  			pte_marker marker = old;
>
> -			if (uffd_prot_resolve)
> +			if ((cp_flags & MM_CP_UFFD_WP) &&
> +			    !vma_is_anonymous(vma))
> +				marker |= PTE_MARKER_UFFD_WP;
> +			else if (uffd_prot_resolve)
>  				marker &= ~PTE_MARKER_UFFD_WP;
>
>  			if (marker == old)
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
