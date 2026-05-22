Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D123644CB;
	Fri, 22 May 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779477655; cv=none; b=GWjZwNTf7X7M9jjX9FiIPXRyENlF4s7moi1YYbTXsxzQqlEMXAKy3BsyKKOXXf2bGSe9WwQeJGKGGb9DLNgBl42x32MO0RrCgaU/DYkne2fHolp5fIaAHOroA9QXqq3pMbzqVymd3/9Mbglubaq5vROKCqYRKwKINkThzQav9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779477655; c=relaxed/simple;
	bh=t0EwoAB284gGQAoxBmuj5j4Ytn6ePtIyxiRxcYBrzKc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gc6FgQcjHHQuadVf2Sj+ZEbPdVLqECl1WvLYablC0JKZAz6pnLID0gLzibzqg4MJ6/mU2DDbKAGBc7Nh2+apLxVoBuCmDrsJsjVEUL5iVyJ2FLELVVv2PmoifWDv5z3BW3FCZLgask4/VwN5eUskVKMwHr4lw7qYRZK3tDidMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A/Xjgqyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A/Xjgqyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E196D1F000E9;
	Fri, 22 May 2026 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779477654;
	bh=t41QCwdiqyuL/UKBS3u23I5KZlwdlxk/ylC/Jp2AbcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A/Xjgqyk1TMDW6V1BLTgayE9RCsWIE9yAV8Ahj5igvqc76Y0csCoxRzu3JoPPg0lp
	 yZfvgJZZwy96Mlp4rZuIhW+34vQHUx/TiYBJvlzF4SF1yStcC2+jglAgfkotNCoWgg
	 VVERfOMw5o65zBF/g7at8k/EeS+l8Lmn6oI5XxCY=
Date: Fri, 22 May 2026 12:20:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: david@kernel.org, willy@infradead.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, r@hev.cc, jack@suse.cz, Andrew Donnellan
 <andrew+kernel@donnellan.id.au>, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam R.Howlett <liam@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, wilts.infradead.org@hp2.hsd1.ca.comcast.net,
 "linux-fsdevel@vger.kernel.l"@kernel.org, ziy@nvidia.com,
 hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
Subject: Re: [PATCH v5 0/2] mm: improve large folio readahead for exec
 memory
Message-Id: <20260522122052.7b4ad7c482a0e4826296e392@linux-foundation.org>
In-Reply-To: <20260522162422.3856502-1-usama.arif@linux.dev>
References: <20260522162422.3856502-1-usama.arif@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 09:23:46 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> Two checks in do_sync_mmap_readahead() limit large-folio readahead:
> 
>   1. The mmap_miss heuristic is meant to throttle wasteful speculative
>      readahead. It is currently also applied to the VM_EXEC readahead
>      path, which is targeted rather than speculative. Once mmap_miss exceeds
>      MMAP_LOTSAMISS, exec readahead - including the large-folio
>      order requested by exec_folio_order() - is disabled. On
>      configurations where the mmap_miss decrement paths are not
>      active (see patch 1) the counter only grows, so exec readahead
>      is permanently disabled after the first 100 faults.
> 
>   2. The force_thp_readahead path is gated only on
>      HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always drives the
>      readahead at HPAGE_PMD_ORDER. Configurations where
>      HPAGE_PMD_ORDER exceeds MAX_PAGECACHE_ORDER never reach this
>      path, even when the mapping itself supports usefully large
>      folios well below the cap.
> 
> Both issues are most visible on arm64 with a 64K base page size,
> where HPAGE_PMD_ORDER is 13 (512MB) -- above MAX_PAGECACHE_ORDER
> (11) -- and where fault_around_pages collapses to 1 disabling
> should_fault_around() (one of the two mmap_miss decrement sites).
> However the fixes are architecture-agnostic: patch 1 reflects the
> nature of VM_EXEC readahead regardless of base page size, and
> patch 2 generalises the gate so any mapping advertising a usefully
> large maximum folio order can benefit.
> 
> I created a benchmark that mmaps a large executable file and calls
> RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
> fault + readahead cost. "Random" first faults in all pages with a
> sequential sweep (not measured), then measures time for calling random
> offsets, isolating iTLB miss cost for scattered execution.
> 
> The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
> 512MB executable file on ext4, averaged over 3 runs:
> 
>   Phase      | Baseline     | Patched      | Improvement
>   -----------|--------------|--------------|------------------
>   Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
>   Random     | 76.0 ms      | 58.3 ms      | 23% faster

Well that's nice.

AI review might have found a few things:
	https://sashiko.dev/#/patchset/20260522162422.3856502-1-usama.arif@linux.dev


