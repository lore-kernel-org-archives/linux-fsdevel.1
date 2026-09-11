Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004139A80E;
	Fri, 11 Sep 2026 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144101; cv=none; b=Hqdif+9Hy+ioR3HGBmtOAKZin4CHJnzmihyQzbQNnAQGXIMk6fCAmAoBicvanqNtWFv/6K4ZR+Ik2njES+2KyNQhYYUybAawjyhU3uST/j8+cMiEALjPjZlYKTWQuemS6HGSZc9dPaC1U4X5cgeDJW2CrSUneLwZh5lViH7UtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144101; c=relaxed/simple;
	bh=Vm5njPyScXTq8NWAAL2xzyVn+2tw5gM95aeyDFf4jC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXzBz3PwkGJ22rNYMObC9KQiApaE3DwjordAP079jhnJCJO2x7+Cm49725gzIy/0iVVCoNLtqph9vjav4B39evWYWSUTVht6i0YebIfovwm97gZFqHU/y6J9GFNphBSsRsi+cSCF9CrD/s+ocOSKVxbjusztU50UjplQFK+doVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCTJZeai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCTJZeai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAE01F000FF;
	Fri, 11 Sep 2026 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144100;
	bh=FnYVewSH1HCSqZpF/ajuG7xvpdDrzWPlljC0TTqhOrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCTJZeais1k7SJtwRXhrgSSr0A8El3HxjkRjWAgtr2p8twOGvppmDxre4GZu85XWc
	 64pKGLoVJ7KtwjplDqEXOk0qIeM4o1eyIXBbXuYn/jb70gL+UJVK9QwAJEGjVVa5wc
	 oAGLMRSpFkraFQ89d5tLaIjv+tUL7d5OZtZ2sPnk7PPqYzNfVEzujyVqP1kyf61EyM
	 RXL2y8XZecHntb0kXxOgZXWS6kJnHRnnSd7Ft4f941WyOTfEXBAK/JuhP6mignHG9u
	 Rn33iplVFhtcRAhcOTP8Ph580+9li8swYB2LTNJEw60L9BTO2LgVYUArc2H0iQVdc1
	 3AdOc7Z7S7c2g==
Date: Fri, 11 Sep 2026 17:28:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
Message-ID: <aqQoPTTUC9M5HkYb@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234737.1340642-4-surenb@google.com>

On Thu, Sep 10, 2026 at 04:47:33PM -0700, Suren Baghdasaryan wrote:
> smap_gather_stats() optimizes stats gathering by skipping the walk for
> shmem mappings in certain conditions. Update the comment to clarify
> these conditions and use vma_is_cow_mapping() for COW identification
> instead of open-coding it.
> Instead of using (start != 0) condition to identify partial walks, use
> more semantically correct (start > vma->vm_start) check.

I don't agree what you're doing is semantically correct, it's a hack really.

Callers are passing start=0 to indicate that the entire VMA should be
processed and that happens to fulfil your criteria but in a surprising way.

And the start in these cases is corrupted.

>
> No functional change intended.
>
> Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cfc7af1b551d..3c40c9cbb9c9 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1257,6 +1257,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
>  			      struct mem_size_stats *mss, unsigned long start)
>  {
>  	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> +	const bool is_partial = start > vma->vm_start;

Yeah not in love with this, without changing how it's called.

If you're reworking it all already, the actually semantically correct thing
I think would be to do something like:

static void smap_gather_stats_range(struct proc_maps_private *priv,
		struct vm_area_struct *vma, struct mem_size_stats *mss,
		unsigned long start)
{
	...
}

Then to drop a parameter in smap_gather_stats() like:

static void smap_gather_stats_range(struct proc_maps_private *priv,
		struct vm_area_struct *vma, struct mem_size_stats *mss)
{
	smap_gather_stats_range(priv, vma, mss, vma->vm_start);
}

And then you remove the hack and make is_partial not be accidentally true for an
invalid start parameter.

>
>  	/* Invalid start */
>  	if (start >= vma->vm_end)
> @@ -1270,23 +1271,18 @@ static void smap_gather_stats(struct proc_maps_private *priv,
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

Nice to see this helper naturally slot in to new stuff :)

>
> -		if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> -					!(vma->vm_flags & VM_WRITE))) {
> -			mss->swap += shmem_swapped;
> -		} else {
> +		if (is_partial || (shmem_swapped && is_cow))
>  			ops = get_smaps_shmem_walk_ops(priv);
> -		}
> +		else
> +			mss->swap += shmem_swapped;
>  	}
>
>  	if (!start)

Also not absolutely in love with the fact you only use is_partial above and
leave:

	if (!start)
		walk_page_vma(vma, ops, mss);
	else
		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);

As-is.

Should be:

	if (is_partial)
		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
	else
		walk_page_vma(vma, ops, mss);

But I also wonder whether, with start not being corrupted (!) you could
just replace this with:

	walk_page_range_vma(vma, start, vma->vm_end, ops, mss);

Looking at the pagewalk.c implementations I don't know why
walk_page_range_vma() doesn't just forward [vma->vm_start, vma->vm_end) to
walk_page_range_vma()... but that's another thing :)

> --
> 2.55.0.1007.g17ff1f9808-goog
>

--
Cheers, Lorenzo
