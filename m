Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240707;
	b=G4UFwqCla7LQ7NygFdQuwQWE1Cxa9bkGKYedj1gPwXqGIoR5hkGe+IjV+Nh5pE6uQY1I
	 iMuUY4ZCldNp4x+yULe+uV2GvQg/be8xbbgOCdtrcJBYey0nuJqRn/XSuYPD+UUIiWdx2
	 5A9/lEVCzXM+XjCJn/7P1lTPTCwMEzP0qTE1wwPYT+5+/QzUkyYRtbNqBQ0fuY51XIBhf
	 uDk7OFfABgDARlJZ0PQqfoCM5wWFHUY6tiXPNiihXIO7nVCZe4yab0Bu9ezzl71cptaXa
	 PXUI9hvGAAwFPAUhvzZwWZAQrJEU6b0Jk6X340awsZAtfT+d3tnySRN9QBfS6ag6yhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240707;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=apKKuKLeW7fYkH3re1fsKWBUmMYFNZXZBCBlzYMpJB4=;
	b=CcIXUi3Ho1S1TiSQgGhQ4xEunVNn1fXjM9DnWOO36QynwrdRWCWRcJ14X3M21k9P/m89
	 k/jCoxZ3yfSaUsgaltYSKCUYHrHRZugevYdobrR0zCnbbgOt+tDyhUx+ADk8AaO1qA9xt
	 +ZNhJhcKp5kjXZSEtva6p4Pj/o18++6fVchanNfx6FdLuo0MLgHN0QuLo6+xz482uG6T4
	 SdvHTi9dZufJaSN/30L5iMCVfvDGRonGGsyoa9JVPH/QLbRmoTv7GEL0KyMOvGZmJ+5Dq
	 lw/Vtb8fcsvHxxsQFleqdRGGymC3nSIbfN4LRwr3sah/2Y5ATuOaorVIgENtbXPy4Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYTWaPyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB11606A31C;
	Mon,  9 Nov 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYTWaPyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE31F0089F;
	Mon,  9 Nov 2026 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240706;
	bh=apKKuKLeW7fYkH3re1fsKWBUmMYFNZXZBCBlzYMpJB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DYTWaPykIpx6JkYTBw++lHZOecG26/qX/H5ir7r9wPn+ghcrQc51mpO5nyJBjswdE
	 2CfWBYOijg97eQqEQ9UUErtUun8nYwhrrTi4/rdAWiqVFqED9q4yjqnLSFs8g9lbpJ
	 XcOHjYSmqOVZxHRjLFVcsosDR2AJWhHkG8BReGvtnbErXGteX4+B2+z3n7z0Q4crq1
	 sd4dtejnQqbwIWQC36hk1dmXJMFw5J9ksIvgmwogTeIqqWlRaVybtENmL3qlUyRGzc
	 sx4IJJEx5i9cu0LI2yjNaF0Qv95aR08j8raojJJsjFQBdmOy0oYNyi11QeqpGh7UVr
	 22E6X5TErFvgQ==
Date: Mon, 9 Nov 2026 16:11:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avHWhZzXE-ge6nU6@gremlin>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
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
In-Reply-To: <20261109120403.82361-2-kas@kernel.org>

On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> can lock it in that window, fail, and clear PG_uptodate with the folio
> left in the page cache. ecryptfs_writepages() does this when encryption
> fails. filemap_page_mkwrite() relocks the folio and checks only
> ->mapping, so the fault maps a folio that is not uptodate:
>
>     CPU0                            CPU1
>     do_shared_fault()
>       folio_unlock()
>                                     ecryptfs_writepages()
>                                       folio_clear_uptodate()
>       filemap_page_mkwrite()
>         folio_lock()
>       finish_fault()
>
> The next read(2) or fault on the folio reads it in again from the file,
> over anything stored through the mapping in the meantime. Those stores
> are lost.
>
> Recheck PG_uptodate once ->page_mkwrite() returns with the folio locked,
> and retry the fault if it is clear, the same way filemap_fault() retries
> on a cached folio that lost PG_uptodate. Skip folios outside the page
> cache: driver pages from ->fault() never get PG_uptodate and would
> retry forever.
>
> The check stays out of do_page_mkwrite(): wp_page_shared() calls it on
> a folio that is still mapped, and a retry there would fault on the same
> PTE forever.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-202966@kernel.org/

No Fixes? Sorry I may have missed context from v1 here :)

> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  mm/memory.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index fe72e66c9c2e..cc1d0b7d15c7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5613,6 +5613,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	return VM_FAULT_OOM;
>  }
>
> +/*
> + * A page cache folio that is not uptodate holds data that was never read in
> + * or cleared, and mapping it leaks stale memory to userspace.
> + */
> +static bool file_folio_not_uptodate(struct folio *folio)
> +{
> +	if (likely(folio_test_uptodate(folio)))
> +		return false;
> +	/* Driver pages from ->fault() never get PG_uptodate */

I guess you mean drivers that return non-page cache folios from ->fault()?
Because the driver could return page cache folios there (e.g. shmem), in
which case folio->mapping would be set (set on being added to the page
cache).

But also things are complicated by DAX (of course) which _does_ set
folio->mapping but installs the folio itself so won't reach the test
anyway.

So I think 'rmappable' is the better thing to say given DAX and, given this
is fiddly, maybe worth explicitly pointing out that ->fault might return
non-rmappable folios, e.g.:

	/*
	 * Drivers which specify ->fault() might return non-rmappable folios
	 * (in which case no PG_uptodate).
	 */

> +	return !folio_test_anon(folio) && folio->mapping;

Technically folio_test_anon() can never return true based on where this is
called from right? Could this just be a:

	VM_WARN_ON_ONCE(folio_test_anon(folio));
	/* ... comment */
	return folio->mapping;

Instead?

(Note that __folio_add_file_rmap() asserts on folio_test_anon(folio)).

> +}
> +
>  /*
>   * Either the VMA lock or the mmap_lock must have been held on entry
>   * (see FAULT_FLAG_VMA_LOCK) and may have been released depending on
> @@ -6163,6 +6175,16 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  			folio_put(folio);
>  			return tmp;
>  		}
> +
> +		/*
> +		 * The folio was unlocked for ->page_mkwrite(). If it lost
> +		 * PG_uptodate meanwhile, retry the fault to read it in again.
> +		 */
> +		if (unlikely(file_folio_not_uptodate(folio))) {

As Pedro said, I think this unlikely() is probably unnecessary given the true
return case is implicitly unlikely.

> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return VM_FAULT_NOPAGE;
> +		}
>  	}
>
>  	ret |= finish_fault(vmf);
> --
> 2.54.0
>

--
Cheers, Lorenzo
