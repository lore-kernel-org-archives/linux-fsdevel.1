Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482496;
	b=AecnSzMQKCje9qVDmv02ykI1Cnub0rbIUCx6Ot6U68f7dMoULWWKiYfWlWiQqfF6mJ5x
	 8rgaVPkWNxD/hyp7pabjKDOO1LMuFes5rpRODOijJ74JWJSITZ3XfPjmCl7XYyHNqHeL4
	 g58h7Szgj2WtyeKhtT61VDU73LFyDyHWcBWNHx8D67sRveSYBLSb1MFSFjoPWHxGrBo/W
	 0hl118ET8li72/YRwfQQmsYTItJDPSlIC/MUemAkRBQvfPAYTEmGOXvHDlsQbCB/rlMzL
	 y4dhgvaJSoRKv5p3XsjOHc1IOHlmwcwYL6X3MFM36qfQ0RWm/y2ugAGoye9cYh4ciEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482496;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k0NaPbrNMApl+0OhCvZtbmHgHjDNgBdnGMkilCDmB9c=;
	b=Z3L90NBQL4t8aFWSGYJp3iA/jqNtJ13Kwhg13Mdxd2joV79/Lm8WMY93x+oiVhPPNgc1
	 I6fmufoFOge0oJhzpn7cRfySmvJ5yVGyOEoPfqE+AxAOpxMJtSEBGG1is0Iv48QCNB8OL
	 kNwYuBGGlWlsxj3vZUbKLluc/J+iTqvOsZ1jIpFvXVTYQRTWsVbFHY3XI5RfKgf/AecR6
	 4Pe0DLug65yVOlqSgB7WVwUdtvVfW5Hy1OxceUD+crGku5LvLYOJYIeEMSK9bzaeNPl9S
	 6SS8rWunE0oWQzcHkOl6CHqSxsjv1dHgfBNR6MbQ8f+DECV9fqORyo4L1flezGEeP6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5UKayYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9460A5BDA;
	Thu, 12 Nov 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5UKayYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AFD1F00A07;
	Thu, 12 Nov 2026 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482495;
	bh=k0NaPbrNMApl+0OhCvZtbmHgHjDNgBdnGMkilCDmB9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b5UKayYnIwJr4nFQ84cbShH/GDU3AKLrS6KouggcNT0KChdHpzhV/o+TxoMI45ALS
	 YFk6VMmmVC3BCLFpncQHyYnM15y+f19drcHGndjbZRIWDdVVqKJDFnr28dECNIw/Rl
	 g6ktlL+g6s8RYyKnh6Kafl1bkBU2Mj9B3Y/n4vWwFuxlLe29iadqVZpUIL4OdIdpgA
	 3/pW4ekBW50oNHtowAkFSQtejR7MTKXESA7FsIUcNimG/Tg1gqdxblZfi0K00VyWSZ
	 4anAwm7q8+0j9VGxNcvRzWJfmU+HsSSDBmnS0XMQ+HReN4K12o3UJOJ1h53djv+Fqk
	 oX7ts/LkjE64w==
Date: Thu, 12 Nov 2026 11:21:24 +0000
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
Subject: Re: [PATCH 09/12] mm/madvise: let a guard marker carry the uffd-wp
 bit
Message-ID: <avWeNRMIU2QPGZ4w@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:17PM -0500, Tal Zussman wrote:
> MADV_GUARD_INSTALL can only install guard markers in a range without
> populated entries. It zaps the range and retries, restarting the syscall
> if the range still isn't clear. On a file-backed VMA registered for
> uffd-wp, the zap keeps uffd-wp markers and converts write-protected PTEs
> into new markers, as the pages are still in the page cache and must stay
> write-protected. The range never becomes clear, and installing a guard
> region in write-protected shmem keeps restarting the madvise() call.
> Signal handlers still run, but the call does not return until the task
> is killed.
>
> An entry that is write-protected must stay write-protected while a guard
> is installed on it and after the guard is removed. PTE markers are a bit
> mask, so a marker can be a guard marker and a uffd-wp marker at the same
> time. To fix it, let a guard marker carry the uffd-wp bit:
>
>  - guard install adds the guard bit to an existing uffd-wp marker
>  - guard removal clears only the guard bit
>  - unprotecting or unregistering clears the uffd-wp bit of a guard
>    marker
>
> The fault path, zap, fork, and pagemap already handle a marker with both
> bits set. However, pte_is_uffd_marker() would let UFFDIO_COPY overwrite
> the guard, so make it ignore guard markers. Anonymous VMAs drop uffd-wp
> markers on zap and never get the combined marker.
>
> MADV_GUARD_INSTALL on a uffd-wp shmem range now succeeds instead of
> hanging. When the guard region is removed again, its pages are still
> write-protected. While the guard is in place, pagemap reports both
> PM_GUARD_REGION and PM_UFFD_WP for them.
>
> There are two simpler alternatives, but neither works. Zapping with
> ZAP_FLAG_DROP_MARKER fixes the hang but drops the write protection: the
> page is still in the page cache once the guard is removed, and writes to
> it are not reported. Refusing guard install on uffd-wp file VMAs in
> is_valid_guard_vma() would break a combination that works on anonymous
> memory, by adding a new -EINVAL for it.
>
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Please drop this patch too.

With my patch disallowing guard marker install on uffd-armed VMAs this goes
away (and doesn't make sense anyway.)

I really feel these guard region ones should have been sent separately, btw.

You're establishing a bunch of interlocking dependencies of different changes in
this series that makes life hard for reviewers, especially given backports etc.

And now I'm having to essentially inverse cherry pick stuff :)

> ---
>  include/linux/leafops.h |  4 ++++
>  mm/madvise.c            | 28 ++++++++++++++++++++++++++--
>  mm/mprotect.c           | 23 +++++++++++++++++++++--
>  3 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> index 4c1476ae3234..add4968ded44 100644
> --- a/include/linux/leafops.h
> +++ b/include/linux/leafops.h
> @@ -578,6 +578,10 @@ static inline bool pte_is_uffd_marker(pte_t pte)
>  	if (!softleaf_is_marker(entry))
>  		return false;
>
> +	/* A guard marker stays a guard, even with the uffd-wp bit set. */
> +	if (softleaf_is_guard_marker(entry))
> +		return false;
> +
>  	/* UFFD WP, poisoned swap entries are UFFD-handled. */
>  	if (softleaf_is_uffd_wp_marker(entry))
>  		return true;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0214efd2a014..e2c6b0f26672 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1123,6 +1123,23 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
>  		return 0;
>  	}
>
> +	/*
> +	 * Zapping keeps uffd-wp markers on file-backed VMAs, so add the guard
> +	 * to the marker instead. The slot stays write-protected once the guard
> +	 * is removed.
> +	 */
> +	if (!vma_is_anonymous(walk->vma) && pte_is_uffd_wp_marker(pteval)) {
> +		const softleaf_t entry = softleaf_from_pte(pteval);
> +
> +		set_pte_at(walk->mm, addr, pte,
> +			   make_pte_marker(softleaf_to_marker(entry) |
> +					   PTE_MARKER_GUARD));
> +		update_mmu_cache(walk->vma, addr, pte);
> +		(*nr_pages)++;
> +
> +		return 0;
> +	}
> +
>  	/* If populated return >0 so we abort the operation + zap. */
>  	return 1;
>  }
> @@ -1259,8 +1276,15 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
>  	pte_t ptent = ptep_get(pte);
>
>  	if (is_guard_pte_marker(ptent)) {
> -		/* Simply clear the PTE marker. */
> -		pte_clear(walk->mm, addr, pte);
> +		const softleaf_t entry = softleaf_from_pte(ptent);
> +		const pte_marker marker = softleaf_to_marker(entry) &
> +					  ~PTE_MARKER_GUARD;
> +
> +		/* Clear the guard bit and keep the uffd-wp bit, if set. */
> +		if (marker)
> +			set_pte_at(walk->mm, addr, pte, make_pte_marker(marker));
> +		else
> +			pte_clear(walk->mm, addr, pte);
>  		update_mmu_cache(walk->vma, addr, pte);
>  	}
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ef4e7188e24d..6cc5b99b4185 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -249,9 +249,28 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>  		 * because any access should sigbus/sigsegv
>  		 * anyway.
>  		 */
> -		if (softleaf_is_poison_marker(entry) ||
> -		    softleaf_is_guard_marker(entry))
> +		if (softleaf_is_poison_marker(entry))
>  			return 0;
> +
> +		/*
> +		 * A guard marker on a file-backed VMA carries the
> +		 * uffd-wp state of the slot for when the guard is
> +		 * removed.
> +		 */
> +		if (softleaf_is_guard_marker(entry)) {
> +			const pte_marker old = softleaf_to_marker(entry);
> +			pte_marker marker = old;
> +
> +			if (uffd_prot_resolve)
> +				marker &= ~PTE_MARKER_UFFD_WP;
> +
> +			if (marker == old)
> +				return 0;
> +			set_pte_at(vma->vm_mm, addr, pte,
> +				   make_pte_marker(marker));
> +			return 1;
> +		}
> +
>  		/*
>  		 * If this is uffd-wp pte marker and we'd like
>  		 * to unprotect it, drop it; the next page
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
