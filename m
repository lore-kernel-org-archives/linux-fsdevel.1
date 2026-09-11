Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF455D89F;
	Fri, 11 Sep 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155900; cv=none; b=K6VDTcb3mHzE4oWoDWOsz80Xv0uz8bbIkhs9ybRLDp4gLZfMiZ6sYs7ofUc0C8u+cgNzYBzetQSIIDY3LMaI4vHR3a0zassv4evgsdCNGeXcwuod1FxfplJKQaWr+vSM618cAXpFmXiS9dDk0so8DNyxD9jgF8vbxmnGbOkLiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155900; c=relaxed/simple;
	bh=PVs6X0bJwkKDrly/MDgEs7YSNdLnxUwHKz4OBNSASJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYQ2B7SsCVHT6+ct00GglKcpWzSYRvJSbgL4WGCJtNVgFY5oQ9Q8hZfEPUSSPsJjthDHLppDoSKVQuOXcfnTIdH406MSlIeEyeOpF/3SMfkVkDKp7Mwz9XCNKzvSotJmCcvTo5ZAicr/fQzZNvAQSqntopY4Q2wUI5Er2H0IulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icT4G9Ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icT4G9Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08531F000FF;
	Fri, 11 Sep 2026 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155885;
	bh=5OcUSagNaUBhj4BbAAxcxYgxkiEGrm2ed7kX7n6+jgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=icT4G9AcYaLezGUDQHBa5NegYm9Q04ZyBGRpaB3aGsWpZG6wHHm9v7eVkCBpf9P1D
	 BRIRFQ3nWYw48L0IXBXSfNsWrJC2HWmtReplQb8Bi0GGS6WlXdzP40UtIeJuIbfDV8
	 bp3Q32x0FXWFgUt3qxXONTpNjJCocjchBgQxp+Pg1HizPgWRaRRXSeK/5qs6Qv0khm
	 FWuvjs55cBAl6FXVh/FWfGXF7ZLZL6Ls6/Xf72D/FNbNXCojINU9RH1IjCewhIMPu4
	 41951JspIbSRFYq7lj7mmO1C+q43ZdQjw39QoGAVNSecd0O+X2xQ1FjzhWa7M42hWC
	 a05jWq/SgCdXQ==
Date: Fri, 11 Sep 2026 20:44:39 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
Message-ID: <aqRZ6xPaNLAGgbXk@gremlin>
References: <20260911194145.1781926-1-surenb@google.com>
 <20260911194145.1781926-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911194145.1781926-4-surenb@google.com>

On Fri, Sep 11, 2026 at 12:41:41PM -0700, Suren Baghdasaryan wrote:
> smap_gather_stats() optimizes stats gathering by skipping the walk for
> shmem mappings in certain conditions. Update the comment to clarify
> these conditions and use vma_is_cow_mapping() for CoW identification
> instead of open-coding it.
>
> No functional change intended.
>
> Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cfc7af1b551d..0e53eb065a3e 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1270,23 +1270,18 @@ static void smap_gather_stats(struct proc_maps_private *priv,
>
>  	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
>  		/*
> -		 * For shared or readonly shmem mappings we know that all
> -		 * swapped out pages belong to the shmem object, and we can
> -		 * obtain the swap value much more efficiently. For private
> -		 * writable mappings, we might have COW pages that are
> -		 * not affected by the parent swapped out pages of the shmem
> -		 * object, so we have to distinguish them during the page walk.
> -		 * Unless we know that the shmem object (or the part mapped by
> -		 * our VMA) has no swapped out pages at all.
> +		 * CoW mappings might map anon folios that do not belong to
> +		 * shmem. Perform a less efficient page table walk in this
> +		 * situation, unless we know that the shmem object (or the
> +		 * part mapped by our VMA) has no swapped out pages at all.
>  		 */
> -		unsigned long shmem_swapped = shmem_swap_usage(vma);
> +		const unsigned long shmem_swapped = shmem_swap_usage(vma);
> +		const bool is_cow = vma_is_cow_mapping(vma);
>
> -		if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> -					!(vma->vm_flags & VM_WRITE))) {
> -			mss->swap += shmem_swapped;
> -		} else {
> +		if (start || (shmem_swapped && is_cow))
>  			ops = get_smaps_shmem_walk_ops(priv);
> -		}
> +		else
> +			mss->swap += shmem_swapped;
>  	}
>
>  	if (!start)
> --
> 2.55.0.1007.g17ff1f9808-goog
>

--
Cheers, Lorenzo
