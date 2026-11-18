Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013145;
	b=a+Ha173eNiiNbFV5PBUjZMdjDfAJQ/bbqJch336LSVUhU8pSl4hHco6iROXNL+gNKkGA
	 DYBNDpsYxpvq77TpvjsDjgwZ+jQKZ8xojYD78wGGyc3VdeuN6SOFvXKsTRREalIzxMK6F
	 EJ6v1qJ8mtBKO9p6vGlqSRngUS/YXv5SJHfst/cy9WxX4mql+noYT+5vik8jWqe7+dmlw
	 Aa20AELi+IJoHl1ZsRs2jUqA/ebH3nC02QLgnZbxaT68WX2TZdbM0hSdTNXpq/T0LxaNq
	 8pcuC5Y4pJxI6Yw4pZs07UDkk81OD09iWR1iFE0nhuKGAjOdEcu5CwGMuOhler4JloQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H+t6Gd5bomKS909lh+zZ1F3vPRIjFwGS1W/nocK0gok=;
	b=yv5HdTCDbIZD0qVyCDXq4plU+nVPY3kfiw8np+De6V24reMXhtxrTTh/1Wm5a1nuk2gg
	 YoQsudSn/kfBstdAgOTnH6ihGyKXhtVC1Wzk7pMboupdTB5SDivTOoTpfYc7wK0X83gHa
	 qe/39dqErZHp/fK8FmmkdRHBVv6x3g8sZbYPB8Alkby4hXDA59H8v0eHvQxwE8udrwfoe
	 sLu+sf+GKC9XfJr4fE3bLY5caNFW3KvdFhPaatBW3J5tzRKzYxqEOwJq0vyAMxgzXEuI0
	 NWKPizPG4WPiQyZkUgr72yK6ntDzztCNDeM30soWmDYThZ53WyhFBvuPLHV3jlGGVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMPDfHgm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26B606A31C;
	Wed, 18 Nov 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMPDfHgm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50511F000C4;
	Wed, 18 Nov 2026 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013145;
	bh=H+t6Gd5bomKS909lh+zZ1F3vPRIjFwGS1W/nocK0gok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NMPDfHgmY+uSMczQKD1BE6YA9AbocjbU4ogaeEvRQE6W55j2x45eDUe8jrDaoo8+7
	 RIf4F88dsxmKoRbaCzGAFRnxzWBPyCO2cHg9x9UwglLfqJmmAh3dN//zbCTUeGo432
	 W3eT9rO5d71EVoBuqstHISg9lhxD3Q/OFW+sDGiGn8rMZbdEvIasuz6IKnhJ1/CgEe
	 QujN7uCwwbD4CJXkhO8WtDK7taVJQmtltCXvZ8rQ5xE5germZg4iGTJ6tjum8f3TW1
	 k8lPrZmefm+/OwW/UujjlV8d7FdhQKtP8f7vkaaQp/ieEqUIvneL3FpjBnBuoSFPab
	 L7ex+YoAV2hnA==
Date: Wed, 18 Nov 2026 16:45:29 +0200
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
Subject: Re: [PATCH v3 7/9] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
Message-ID: <av26CdCIWuexSi90@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-7-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-7-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:47PM -0500, Tal Zussman wrote:
> Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
> registered with userfaultfd, so the uffd state of its entries is cleared
> while they are moved. If the move fails halfway, the entries are moved
> back into the old VMA, which is still registered, without their uffd
> state. Writes and accesses to them are then no longer reported.
> 
> To fix it, leave the entries alone during the move and clear the uffd
> state of the new VMA in mremap_userfaultfd_prep(), right before dropping
> the context, like unregistering does. This walks the page tables of the
> new VMA a second time.
> 
> This is done with userfaultfd_clear_ptes(), which also makes the PTEs
> writable again where that is safe. That removes a spurious write fault
> per protected page on private anonymous memory, but adds spurious write
> faults on shmem and hugetlb, as change_protection() makes writable pages
> that were never protected read-only. UFFDIO_UNREGISTER and
> UFFDIO_WRITEPROTECT already behave this way. This will be fixed in
> change_protection() separately.
> 
> The entries no longer need per-entry handling during the move, so drop
> uffd_supports_page_table_move() and clear_uffd_wp_pmd(). Whole page
> tables of these VMAs can be moved again.
> 
> Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/huge_memory.c | 25 -------------------------
>  mm/hugetlb.c     | 27 +--------------------------
>  mm/mremap.c      | 46 +---------------------------------------------
>  mm/userfaultfd.c |  1 +
>  4 files changed, 3 insertions(+), 96 deletions(-)

-- 
Sincerely yours,
Mike.
