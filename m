Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7F312803;
	Mon, 27 Apr 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293683; cv=none; b=FrchsUHUQutPwxM4IdeMdxoq40vO5tYhm2qkEpex0PTO1yd25uCyIPPjBjgH9WiEB/iqPofFMndmdAsfv1kk3zBjPdNDcU44m+BtM+RdeXnMClaU54Al6l2t9Xe+XMTTFc8QUL9djirLGLDmy6bahblkg28PXY3AKahuQHSoMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293683; c=relaxed/simple;
	bh=JSNA+AhXaEfEI0gzCAqHvexyCIAgBK6DaskqKasRfg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAMtThnZJ1jdUbe/HrR7cKcr2rfDHvKQm0kVubMYEyrXu50lC5+ptV8+GEQauewvWMBdjrMnaWnxQvaY6SYifsKei24JyfDYZ5M3Tim577gw+YuWGBJeN06dJ9f553n70BBlSvC2YewGCuIjCcJek99Zl4k8LGrSItrjRqKnwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2h86xCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2h86xCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9FFC19425;
	Mon, 27 Apr 2026 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777293683;
	bh=JSNA+AhXaEfEI0gzCAqHvexyCIAgBK6DaskqKasRfg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C2h86xCI6WB9WS8eJDG7bGUNJHrpHlXBvwrjYQDUuSkI6ngoTSajL+YaByI985DRD
	 3NaSgOwhJsZQSYo4JrjknnEQCitTSKIcQ67RYTHsxnKnFjoNSjKIFNlt0yZGRjOz4Q
	 2C+VDm5XRHrAs0k8Z1QN+2Q1Msu8e2V7O0w9ixkIZvlcIJ3071d/um9dhFArk0JZg/
	 lUeZaFKEfFsChSXeOfwjEGgR31+oFSV1M2/Dcts8tSuTAyH0cx2gjKgCGTT/bL1hun
	 zB1vCEFm0YltGw4bXB7j3gCV+rVIkBLYXjLcEVZZ4WAiltyRwzByYjRA9B1eYt+kGv
	 afdu21bT2PSug==
Message-ID: <c7f94ce6-1dfb-420a-b073-d86abeff1f76@kernel.org>
Date: Mon, 27 Apr 2026 14:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: limit filemap_fault readahead to VMA boundaries
To: Frederick Mayle <fmayle@google.com>, Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pfalcato@suse.de>
Cc: Kalesh Singh <kaleshsingh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, android-mm@google.com,
 kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260427030148.653228-1-fmayle@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260427030148.653228-1-fmayle@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 05:01, Frederick Mayle wrote:
> When a file mapping covers a strict subset of a file, an access to the
> mapping can trigger readahead of file pages outside the mapped region.
> Readahead is meant to prefetch pages likely to be accessed soon, but
> these pages aren't accessible via the same means, so it fair to say we
> don't have a good indicator they'll be accessed soon. Take an ELF file
> for example: An access to the end of a program's read-only segment isn't
> a sign that nearby file contents will be accessed next (they are likely
> to be mapped discontiguously, or not at all). The pressure from loading
> these pages into the cache can evict more useful pages.
> 
> To improve the behavior, make three changes:
> 
> * Introduce a new readahead_control field, max_index, as a hard limit on
>   the readahead. The existing file_ra_state->size can't be used as a
>   limit, it is more of a hint and can be increased by various
>   heuristics.
> * Set readahead_control->max_index to the end of the VMA in all of the
>   readahead paths that can be triggered from a fault on a file mapping
>   (both "sync" and "async" readahead).
> * Limit the read-around range start to the VMA's start.
> 
> Note that these changes only affect readahead triggered in the context
> of a fault, they do not affect readahead triggered by read syscalls. If
> a user mixes the two types of accesses, the behavior is expected to be
> the following: if a fault causes readahead and places a PG_readahead
> marker and then a read(2) syscall hits the PG_readahead marker, the
> resulting async readahead *will not* be limited to the VMA end.
> Conversely, if a read(2) syscall places a PG_readahead marker and then a
> fault hits the marker, the async readahead *will* be limited to the VMA
> end.
> 
> There is an edge case that the above motivation glosses over: A single
> file mapping might be backed by multiple VMAs. For example, a whole file
> could be mapped RW, then part of the mapping made RO using mprotect.
> This patch would hurt performance of a sequential faulted read of such a
> mapping, the degree depending on how fragmented the VMAs are. A usage
> pattern like that is likely rare and already suffering from sub-optimal
> performance because, e.g., the fragmented VMAs limit the fault-around,
> so each VMA boundary in a sequential faulted read would cause a minor
> fault. Still, this patch would make it worse. See a previous discussion
> of this topic at [1].

I agree that workloads that do a lot of mprotect() magic likely do not depend on
readahead optimizations.

But I'm sure we'll learn quickly if that is not the case :)

-- 
Cheers,

David
