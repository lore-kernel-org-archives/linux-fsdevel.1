Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454682;
	b=0jPbfnDVYO5XPjwZoFLKUCv7spbHG4w6lowSu4m8Nk1jvcu35HYdSzNtj0zRHbwVKAcO
	 yu//DjoCJCmyqS1a38Cfw1C0xXGnQwqITy0DSmjHZUikfBBTA8KpBQz2fBgAyNpCOVKkp
	 A7E7Zzneqn/uhCwg0ewPcrLHz9uWaZUe8xwLYdlyH5DsoX0lI1Mp8iFqaih+pyPGDWhRH
	 1T7RBILseJZgn+U9ps7ztJQiY5QaR7P2h9Yndq5K26SwOaadRmTZAPujEu2ZYgFZcFi0H
	 GgQidx2JUXpZCvamLzGNwBfZVFQE5+dycmISHh8Gh5x/aBQ/XEbdxZkyp6jwVIGnNkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454682;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JOBTC/Bts81uYSw4jWTx0KjcitZ5QkeYRyFe+0Yns5g=;
	b=NAU782hbz//o0GowHmh74dinWf5/5mjb7+sQYD7NXGX4XQB/+61f/92zmop2mkKMtFE4
	 wAECtdoDFE0UozduHDxQkpgqW9t6MOAKxX46OkpZvvXAB/1WxgXuAGyKbuS3/DFII+9Aq
	 MjurNTZ9diRYSNJABqsRxBPOCr3r8bRyD8bm4y1BJ/Km7jIMgkuV2PFlFbNJR+W5U3XkH
	 6c4l1kMtZlxR1hd5FSK1512+WB2Ge8XFySzuWVUsL9WU55Ok/SSJtfGswEjXAh13EacMq
	 sGKrQO730g01EsLHEp6+PeO+EeuY4CNjEt+b/nz/0w4OL4nAXU7YmYNEVK5yPGYtoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9US0Gnl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95395606A31A;
	Mon, 23 Nov 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9US0Gnl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE41F000C0;
	Mon, 23 Nov 2026 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454681;
	bh=JOBTC/Bts81uYSw4jWTx0KjcitZ5QkeYRyFe+0Yns5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9US0Gnlbg5OPz1RjYiRKycFC5TTNqCsgbAp3Qx2QF9f1zsa32qirjMEenlHMPzg0
	 EAMc1MdUPxrrol/WFNQr+iCqYyjMDwJGoTviuRo11m7S7vYv8BNIIW3A4fTju31Ngv
	 c2Xiqq7tBwE6MV+wtHqQ2ao8FAG+nXsaycT+4TPCnkmTnYo2dBcrBRYKwuRz13Eayn
	 sYmLAzxr22Y0VNMcTc4fWjX6KHu2QP7goCb3z+aFA7q64Mrd4oIqkwxsI8QOWBgca5
	 QXAzGpRhE9Qqn+f+d9wFLD2EchacbFQKjINAD8OJQ0MJT92Y/zzAqaD/+uZPxuT9vS
	 cUZ5VjTAdvnAg==
Date: Mon, 23 Nov 2026 17:24:31 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev
Subject: Re: [PATCH v3 3/5] fs/proc/task_mmu: read the PMD once in
 smaps_pmd_entry()
Message-ID: <awR2bZl4CvSuInmk@gremlin>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
 <20261123163301.1568240-4-usama.arif@linux.dev>
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
In-Reply-To: <20261123163301.1568240-4-usama.arif@linux.dev>

On Mon, Nov 23, 2026 at 08:32:09AM -0800, Usama Arif wrote:
> smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
> into a local with pmdp_get(), the way smaps_pte_entry() already does
> with ptep_get(), so that every test sees the same value.
>
> No functional change intended.
>
> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 540c936aad4714..105c4998eef48f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct page *page = NULL;
>  	bool present = false;
>  	struct folio *folio;
> +	pmd_t pmdval = pmdp_get(pmd);

NIT: Can this be const or are the helpers not safe for it?

>
> -	if (pmd_none(*pmd))
> +	if (pmd_none(pmdval))
>  		return;
> -	if (pmd_present(*pmd)) {
> -		page = vm_normal_page_pmd(vma, addr, *pmd);
> +	if (pmd_present(pmdval)) {
> +		page = vm_normal_page_pmd(vma, addr, pmdval);
>  		present = true;
>  	} else if (unlikely(thp_migration_supported())) {
> -		const softleaf_t entry = softleaf_from_pmd(*pmd);
> +		const softleaf_t entry = softleaf_from_pmd(pmdval);
>
>  		if (softleaf_has_pfn(entry))
>  			page = softleaf_to_page(entry);
> @@ -1046,7 +1047,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	else
>  		mss->file_thp += HPAGE_PMD_SIZE;
>
> -	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
> +	smaps_account(mss, page, true, pmd_young(pmdval), pmd_dirty(pmdval),
>  		      locked, present);
>  }
>  #else
> --
> 2.53.1-Meta
>

--
Cheers, Lorenzo
