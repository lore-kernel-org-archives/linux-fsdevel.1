Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512093;
	b=5RhzjbhAUXgzypJRJttklFYXa75ig4kSuOZKod7cr9GMVdGXLlnm8KQh3ZwNi+ATUxUJ
	 i6sKbfzw/LP2I53up7geqHXLCHKKhVYXowDmY3nWIHIIoZhCKyAVgzBG/hBeWJQBiGhhV
	 0a/MKjNL1D/G0N20Vg+jbIetQDyxXS6CIidTQNMAi18TVRA51ccNtbGWnK9Dsm+s8ahCx
	 aRa7hEwJSukgj+ncXXBvAxmgw0Wa3LDw9QgmRlvYGCinhA/EpRg/wwl4FI3QEpCjZmnqD
	 26atV7FHdUJNr6i7cgFsVNN7tlSluN+twoK95gU7vQs2rDpDx/jmanVVqUdvYYzeRTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512093;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fzt2dBpdapix7RUmqVUPHjVh/havNMakXElf23OCC/4=;
	b=HYFSqRHbNrSuaWfvJBAfJfHhw26EYkp8yo3X4LObNyXSN7f0wy9JX/b/0JqoPsEZLRyG
	 vjpGHyFOPZR7aUrb6AUmMBkqiw5YStemyGw8Y7RM5LN6LhzNFPrEQ1Avnwg3zfH9c3G/l
	 JAaOu1YfSAXsPbKhjlI4kr9Ub7mzdRgF+nEsa/sNIaKO0cAEDmyd2/CsLTl0iJ0M+FY3o
	 +sFA+ghW6UqynaRNkAdj7D42VSYSWjOqkSfTm2Cf6ziNGAt/5U8Ka+OBdQXYMnUmEm17Q
	 jNPeI9RdX5mcdlg4p3yTrBcXF49MO9UCzIF+9n45RKiYH1Ep8QxGW7GGtGaVjNTYueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSd4A21L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF2606A31C;
	Thu, 12 Nov 2026 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSd4A21L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610C81F000C4;
	Thu, 12 Nov 2026 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512092;
	bh=Fzt2dBpdapix7RUmqVUPHjVh/havNMakXElf23OCC/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSd4A21LzwNBycHbPA4kAqRX5meE3MjPkelVRq7bVzJnzVClKcn5Rpr/Dz7z7OsGO
	 oZy+xADrRy820imjvS0gZLtsV+heBChFRdXOemxl34mSppcJtkIO4xVrdAmjE3y6bh
	 X07QO41a3RVk7RmEXR774gpusHa7lhyPnOgyVs3TqlD7vJk0eccf42cmu7SnHo+i2w
	 IIwLP9dysThVv1/5Cx0YVQPODydwdMZweFry0TINNiHYUSbBisC2LYqL1eVOP59B2p
	 nYXkYsy7sFwEG04WUPqYH7nHz3Hnmwb3x2pV7QyGbcTSq5PJuZy3TnoHCuWS0TKWHZ
	 Rvu//kCeePTkA==
Date: Thu, 12 Nov 2026 19:34:40 +0000
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
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
Message-ID: <avYQteUm963AKJQ7@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:13PM -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
> make_uffd_wp_pmd(), which handles a present THP and a migration entry

It's crazy to me that we write-protect page tables through a procfs interface
like this. But I guess we have to live with it now.

I suppose that answers my q about this on a previous commit...

> but does nothing for a device-private THP. The PMD never gets the uffd
> bit.

Sigh yeah. Device-private feels like another 'just have to happen to know to
update X million open-coded parts of the code'.

We really need to find a way to abstract this stuff.

>
> pagemap_thp_category() reports a non-present PMD without the uffd bit as
> written. A user tracking writes with async uffd-wp therefore sees every
> page of a device-private THP as written on every scan, whether it was
> written to or not. This requires a driver that migrates THPs to device
> memory.
>
> A device-private PMD must be write-protected like any other huge PMD. To
> fix it, pass it to set_uffd_wp_swp_pmd() as well, which downgrades a
> writable entry and sets the uffd bit. When the THP migrates back,
> set_pmd_migration_entry() carries the uffd bit over to the migration
> entry, so the write protection is kept.
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/proc/task_mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 53780a454432..752f1b13d47a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2524,7 +2524,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
>  		old = pmdp_invalidate_ad(vma, addr, pmdp);
>  		pmd = pmd_mkuffd(old);
>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> -	} else if (pmd_is_migration_entry(pmd)) {
> +	} else if (pmd_is_migration_entry(pmd) ||
> +		   pmd_is_device_private_entry(pmd)) {

Could this not just be !pmd_none() + cover all softleaf entries? Or is that not
valid?

It seems completely insane to have to specifically spell out all the
possibilities, open-coded, everywhere.

>  		pmd = set_uffd_wp_swp_pmd(pmd);
>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>  	}
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
