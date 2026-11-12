Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481421;
	b=3k8vV0T8HSgf4n0rVJo2vwa7JqKwnkcDdeqC5OnBzz7U5OPzMsXglnrK276GnM+m0UiK
	 4MLtOuVWiNSzel6eeH+y6hFZH2oiKVWGGvWCFwIWw1HDB4qXr+YUJusbk3DRFMbhQ/MwL
	 lF70Czl2S/nepIJUzhcygAsnQ2Hk1jEibF8oZvGY6Palxz4F3kiD61zq+ON38+1B+WztB
	 yhXL3Rvx7IrQTJezO0mpnUb8GdT4kou66WSdal0wkQrLFh3R04L0EFh7Gd21sCI6JR/s2
	 Ft7qtFjEPXdPPj5D3Dy3xDvzRmVuTt0zmiZIfiSrVlIjO0z6Vvf9JnueuYVQ2lTRSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481421;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NL90eQvmf7oSmDtQxpeoM+o7UAHRN5i93I3Z8Hdt/Y0=;
	b=urV4lHZFit78F9nrAjSZuKV1Er+JXgS9HB7AmUe4g5qq05kVERPhxDRa+Ay1L64JsXpb
	 unBE4Vlq1dCfXdR4MggMXwjf1t7OTQxB5SwzXigoEh114bejl8uLVRh4Nx8lcO4vBF6sC
	 d4xx5qbpYDwx6LOs/aRR8b40KDGO/eKtJurxCoTbqzq9McZy1VdPBh1rsFMuad/BhjbBB
	 /MnV5AghGzExoCa3F9Ge5yOSaEhQleRhO4pv4Z30vVymh3HlDSv+2BvBjCn7S175a+8XY
	 OwQaMBZ+qJYtS4uRmnpsa1nnzahogUM6IwLYde5O8pP7G01VfpD7Ju+/UmDHTP4w/nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiANUSYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A20606A32A;
	Thu, 12 Nov 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiANUSYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5611F00A05;
	Thu, 12 Nov 2026 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481421;
	bh=NL90eQvmf7oSmDtQxpeoM+o7UAHRN5i93I3Z8Hdt/Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XiANUSYq7HUgR/c8fZWcWOwFWGYAsb6pXFnpXvRjnFQxTRcAUMYmq+6ZWOxb9KxVu
	 A+7besaPWCB77jQ2L0tbcs6iRrubXZDh3+KAtwB0fdzJLNTYRIWApVuaQzspqS/arT
	 ZYJosfzUTYA6dEePxBX0urqKahp6brnwUIP07hkQKRMgyykdPtYzhN06uzcQ+9in0H
	 SE8zMyJqBNEusSrkJzGxbHpgMc6JdtC3fo3vhfODgYPm5fSqvvXu2rKjwsFTB4O93W
	 vkniD/z7ulBy94/T9SEIBdXebyfQLf5PhOf7Wst5nwNowc4bDvyNtsoC6cj1sLVARo
	 o9/pSs42AsN4A==
Date: Thu, 12 Nov 2026 11:03:29 +0000
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
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
Message-ID: <avWW5t1BiD7pbzIZ@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
> MADV_GUARD_INSTALL zaps whatever is mapped in the range before
> installing the guard markers. However, unlike MADV_DONTNEED and
> MADV_REMOVE, madvise_guard_install() does not call userfaultfd_remove(),
> so the userfaultfd manager is not told that the pages are gone.
>
> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
> the pages. Writes and accesses to the range after the guard is removed
> are then not reported, and the manager cannot know that it has to
> protect the range again.
>
> To fix it, send UFFD_EVENT_REMOVE before zapping. Guard install on a VMA
> registered with userfaultfd already takes the mmap lock instead of the
> VMA lock, so we can drop the lock for the event and look the VMA up
> again afterwards.
>
> As with MADV_DONTNEED, the call can now return -ENOMEM if the VMA goes
> away while the lock is dropped, or -EINVAL if it is replaced by a VMA
> that does not support guard regions.
>
> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> Closes: https://lore.kernel.org/linux-mm/3f4b0d1b.bbf84.1a1c55cb666.Coremail.18670333770@163.com/

This report was super-synthetic AI slop

> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Sorry I hate this.

Since this was already silently broken, I think the right solution is to simply
disallow guard region installation for uffd-armed VMAs.

I had the AI go look for users, and it seems nobody is relying on this (glibc,
android, CRIU, etc.), and there's really no sensible world in which somebody's
combining the two. So I think fine to do that.

It was simply an oversight (reflex action is to disable new features for hugetlb
+ uffd)

I'll send a patch separate from this, please drop it from the series.

> ---
>  mm/madvise.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e8b05dc899f1..6413f0e65381 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1166,6 +1166,29 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>  		return -EINVAL;
>
> +	/*
> +	 * Installing guards zaps the range, so report it to a userfaultfd
> +	 * manager like MADV_DONTNEED does. The VMA can change while the mmap
> +	 * lock is dropped for the event, so look it up again.
> +	 */
> +	if (!userfaultfd_remove(vma, range->start, range->end)) {
> +		mark_mmap_lock_dropped(madv_behavior);
> +		mmap_read_lock(madv_behavior->mm);
> +		madv_behavior->vma = vma = vma_lookup(madv_behavior->mm,
> +						      range->start);
> +		if (!vma)
> +			return -ENOMEM;
> +		if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> +			return -EINVAL;
> +		/*
> +		 * The VMA may have been split while the lock was dropped.
> +		 * Handle the part in this VMA. The remainder is handled by the
> +		 * next iteration of madvise_walk_vmas().
> +		 */
> +		if (range->end > vma->vm_end)
> +			range->end = vma->vm_end;
> +	}
> +

(separate rant - that we have to a. know to do it and b. write duplicative
open-coded crap like this is a perfect example of why uffd is such an utterly
broken mm feature that should never have been merged...)

>  	/*
>  	 * Set atomically under read lock. All pertinent readers will need to
>  	 * acquire an mmap/VMA write lock to read it. All remaining readers may
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
