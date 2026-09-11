Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475E4582D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142363; cv=none; b=ZhPEguxwt1ovfKMjeeHMcMCwKjxQET3rhro+cv0Q1afpULGDCH3y7eK8uLxss82MkImgglUbZ9GtVOkdJf2tzR2vlzcYHeOPyNyCm0mW6MaOcVRvvq91UP1nE18my941pNarXzAwNbSDYCRv5nrCo8Psiqq7ctgEBeICy/qe5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142363; c=relaxed/simple;
	bh=phqqF0GuntjVdx0I+dWCfys8PnZD+QuitHe86Ey+UtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkWNjkufQLHXNd4aADCQwbE5ItO2WwCn3YbB2IHlty7yaN+Zt/L8cijIRnNKFhZP9SMu6SvYT8xgGhXHZkcUQ82ur0gvaAJ5/vQ41ZSp7hMa64PFLf6caxq6WGaFfXndKUixeouDMuOofbNP0X/xXggisBnIXGKteBlnrpSm+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=W62XeZ1I; arc=none smtp.client-ip=74.125.230.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="W62XeZ1I"
Received: by mail-qk2-f8.google.com with SMTP id d75a77b69052e-530e0062c97so1620221cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789142360; x=1789747160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ql6yDYiCUfB1KtPKnMN8J1mkX0CDVMGXFwFiHiyB4X8=;
        b=W62XeZ1IzQbjIVeFlRiIahT/KXCCj6qRhvJFVvzOOiNswvtQD+4yR4DEEJWVL5x+Xh
         OrENQePslIZsOigGMrD8Jcjb8H+qZp7CmLE2iGIr+5w1snz38v0829SanvsZITVESfom
         YY6Z/qzyy28fEMDE1TqeHNTt75pJ4KQFv30Qi8a2nt4OsI3cbBMta5jcqOKY+uo2Hffx
         mvVSyb4rLwE6aIjzYs7cI2e2QZtEPXG74zsRvhGMjRXdLwkOFAiii96+DatCkokRoW3y
         FePhmv+zC8gN7aG3SKfbVwtTNFUbd0CFvYWYdQe4PgdLRzHvJix3MDN7ruwcL0aFE/NR
         O7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142360; x=1789747160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ql6yDYiCUfB1KtPKnMN8J1mkX0CDVMGXFwFiHiyB4X8=;
        b=Kcbyknksq8pYtpUyIByIrAIqbB3TBivHOrTLl5SiEc+aw1Fzp7MFbtI/fRpNXNcZEQ
         qMDoGJx9jDvV4CAl2aTXvKjQK232HyTefaRR/X4wgurTVN4XbQQGX3THLFDKR4DoF2Zy
         eSEr5YgptbB3DYrQituPHL4ubZYQwCnzXXYZSH1fEGrbwoeBtBGuNeES2UOuEGn7abOH
         eQJbnW6mw9JHchl7b51WKHje/e/7BfrL0pXVX8aCqq7DmgMrajE43stCzkiXXjdSxGSU
         etCaNDRAUvbL7b3sNE/kx1qbM/ndHUX3FD6Z8yyurYSiSLemf2hp/ZUjHojkcGkV+/Tv
         Gheg==
X-Forwarded-Encrypted: i=1; AKwUvBwVKnAJLMgRDLjL8rOokqtAlGm4X2Yr8vfQZiAdiTPyi4pdewUXCV3iyFyoW8fQ5IWCPuu7NN6ILILszck5@vger.kernel.org
X-Gm-Message-State: AFuF++mhxLSGwQ16GqemEa/WPjlJ1XpzHxyGYaygIlVUAHtf/JtvUKcu
	Qr4r4PbwKF+ALCgHPfLlM022pxltruGFYhxUcAWSxDzPxsKpi86aF3D/8duOxCyf99s=
X-Gm-Gg: AYBFou0ODwExAMnyGGO1bR0Mj0FIxrpNoLiA03lQxa+4KnRmnn/0P3iqVn/3jKIuEQe
	Oz1ku3oyJ4msOtEeVyyh8xWU8Z2N102Sa/1eg4FwPpRyV41lDok3nGThD/vkEHWkHYofQuTM0/p
	O8teD75/lK37fmg532OL38W1pOxOzpWA/LBwPFyjdHHzPeTRixm5tkx8kym9VS8TZLH+h4URabq
	+bqcY5DYZ/NGq69Q1vlWnZl1Mfk3sT6pEK8Q3ZPIyzqSzzLUq24bpMj+tqOFOAqKIXDxrnDb92x
	cyPlqIZvBGUpqxSPjqGyssfCif/TQ5QcuXemAB/ZbMYi/YmaevS++cwVeN72umCMToyHDxPgp9U
	CbtX4vC5+RcZud5ptDtOwmEaqrvaKnMKUCOslnxvLUJKm7koffaP3ICVqTovzZtIABVh9gPGeBX
	RScCrOubVZSeLvZg09RVaOXl1dkrS5jKGN8SV4OIa93bPLLbpg47EZqIfnVvZzXobNa9JtWw==
X-Received: by 2002:a05:622a:2b0b:b0:52f:aa6c:bc7d with SMTP id d75a77b69052e-530c86d54b3mr75558611cf.28.1789142359223;
        Fri, 11 Sep 2026 08:59:19 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm22945531cf.11.2026.09.11.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:59:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: akpm@linux-foundation.org, abuehaze@amazon.com, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org, brendan.jackman@linux.dev,
	david@redhat.com, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, hch@infradead.org, hch@lst.de,
	jackmanb@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, vbabka@suse.cz, willy@infradead.org,
	ziy@nvidia.com
Subject: Re: [PATCH v4] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <aqQlUr-1h07G8JWM@cmpxchg.org>
References: <20260905174239.99e31515fabe220aa7d8e6fa@linux-foundation.org>
 <20260910114602.926944-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910114602.926944-1-dipiets@amazon.it>

On Thu, Sep 10, 2026 at 11:46:02AM +0000, Salvatore Dipietro wrote:
> 
> On Sat, 05 Sep 2026 17:42:39 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Is there anything particularly unusual about this test case?
> 
> It is a stock pgbench simple-update PostgreSQL workload on a large
> instance (96 vCPUs), using standard PostgreSQL settings and with no huge
> pages assigned to the database. We deliberately overprovision the
> pgbench clients: 1024 clients over 96 threads. That keeps enough writers
> in the buffered write path concurrently to hit the costly-order
> allocation failure path continuously. The memory fragmentation comes from 
> page tables: PostgreSQL spawns a new process per client, and those page
> tables consume ~40% of memory, which significantly limits the page cache
> and the free memory available.
> 
> 
> > > Results (average of 3 runs, TPS):
> > >
> > >   Config                   Avg TPS      % vs Baseline
> > >   baseline (no patch)       59,408       -
> > >   With this patch          155,409      +161.6%
> >
> > Is this back to pre-5d8edfb900d5 performance?
> 
> Yes - fully recovered. Here is the summary, same host and workload
> throughout, average of 3 runs:
> 
>   Config                                        Avg TPS   % vs baseline
>   AL2023 stock 6.1 kernel                       136,942            n/a
>   v7.3-rc1 baseline (no patch)                   59,408             -
>   v7.3-rc1, 5d8edfb900d5 behaviour reverted     151,184        +154.5%
>   v7.3-rc1 + v4                                 155,409        +161.6%
> 
> The 6.1 row predates 5d8edfb900d5 entirely. A different kernel version,
> so not directly comparable, but it shows the performance this workload
> used to get on this host.
> 
> A literal "git revert 5d8edfb900d5" does not apply to v7.3-rc1 -
> iomap_write_iter() has been rewritten since - so the reverted row is a
> one-line behavioural revert, forcing the write loop back to copying at
> most PAGE_SIZE per iteration:
> 
>   -	size_t chunk = mapping_max_folio_size(mapping);
>   +	size_t chunk = PAGE_SIZE;
> 
> which is what the pre-5d8edfb900d5 loop computed. That makes
> iomap_get_folio() pass no order hint, so the path issues only order-0
> allocations.
> 
> 
> > AI review asked a few serious-looking questions:
> > 	https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
> 
> Thanks for pointing that out. To address them, we can have something
> like the patch below. Performance results are still similar to v4. Happy
> to submit a formal v5 patch with it if you would like.

The feedback looks misleading to me.

ALLOC_NON_BLOCKING itself is fine, it usually only means something in
conjunction with other flags, like __GFP_HIGH. The access to
MIGRATE_HIGHATOMIC that it points out is in itself too generous. This
seems like a real but separate bug. It will allow GFP_TRANSHUGE_LIGHT
into the highatomic reserves as well, for example.

The rt issue seems made up too. We're talking about costly_order &&
__GFP_NORETRY allocations. Why would they need access to reserves?

>   Config                                        Avg TPS   % vs baseline
>   v7.3-rc1 baseline (no patch)                   59,408             -
>   v7.3-rc1 + v4                                 155,409        +161.6%
>   v7.3-rc1 + proposed patch                     161,994        +172.7%
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..be8b0d72a2db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4784,10 +4784,22 @@ static inline struct page *
>  __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  						struct alloc_context *ac)
>  {
> -	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
> +	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
> +	/*
> +	 * Costly __GFP_NORETRY callers have a cheap fallback to a lower order,
> +	 * so don't stall them in direct reclaim or direct compaction.  Exempt
> +	 * __GFP_THISNODE (the THP attempt from alloc_pages_mpol() needs direct
> +	 * compaction) and __GFP_NOFAIL (must not be made to fail).  Don't
> +	 * clear __GFP_DIRECT_RECLAIM from gfp_mask instead: that would also
> +	 * change the alloc_flags derived by alloc_flags_slowpath().
> +	 */
> +	const bool costly_noretry = costly_order &&
> +		(gfp_mask & __GFP_NORETRY) &&
> +		!(gfp_mask & (__GFP_THISNODE | __GFP_NOFAIL));
> +	bool can_direct_reclaim = !costly_noretry &&
> +		(gfp_mask & __GFP_DIRECT_RECLAIM);

IMO this is worse because now there is a disconnect between these
flags and the gfp mask again. This sets us up for subtle bugs.

I much preferred v4.
