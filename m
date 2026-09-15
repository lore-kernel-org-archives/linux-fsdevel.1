Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1408481661;
	Tue, 15 Sep 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486109; cv=none; b=hn0dWDjiFOCabd3Dake1nND25NGXtAz/Q0ooFMDXnqJAupa/RreZcx996epDDc2oj0eMjIW1GjfvJn1buGuErHk0dDKo5f1gEApej8ABwW7+XR1vsqxY1uOH+3e8oF6qz3v3ZvuQmIiepxXuzpYe6fgeNQSDcMAg4z4jQUDK6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486109; c=relaxed/simple;
	bh=Da+69ad+lHJO0M7ZV8wHDbzIyOjJRsbZ7DtN3XNdzJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMXtl5qvIbyHABiJZXLOFRtDTMxmJ1jqnj0BzMaYephu7tMR7h88eFefejNfW9Ssiruir4zepNvh2Wtld1Ov1FDfdOXblV9yqvghYxDC6G8FGu8/eX1GWaZkhwkKmBiE/bhE8/ZiQPyFocVzzQMDV/UsSfuVvOwq4jlveowTsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=splJMSXx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="splJMSXx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QEW88ZQnSuhZNPj3vkXIV8NZ1wmCRrjqEwOa3KU5UvU=; b=splJMSXxhNub0eAzI8FujE44l6
	r4XyiRYshHMUnl86YfqkEb/+1g/xAqFKnDS7oAtZRCdHl+ol9kwgKqFB+vMzPAwuouJv8NHBQGCRw
	ef2KBchTH6801R2hPBb1AX1QZh8Z8RB2Sd0bKZVDcCy7FXjJhXbuyfSQWFn5T3Cp60+xexWLaChrR
	YL2q1jTyNaoVC852BBCLZGXqr2Pfyqj76IVCbXOf5H0lCDwBq/lyowLowr/y27glmiEEhjSu3WE0l
	b+D1Naua42STbyZlsM3JJ7SlqmHdDAEOU3ArukM5LPYIp61pQ0jNFnCNajqePYwIFrDLMwRajzQl0
	5GnonEZA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6V53-000000079xT-0yw0;
	Tue, 15 Sep 2026 15:28:21 +0000
Date: Tue, 15 Sep 2026 11:28:19 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Eliot Courtney <ecourtney@nvidia.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH] lib: fix lock initialization in region allocation
 benchmark
Message-ID: <tniaziqadej6t3f6herhfzsxu3di7deewfbgfpr57mlsurbbak@mkzuybcvjj24>
References: <20260911155244.1406122-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911155244.1406122-1-ynorov@nvidia.com>

On 26/09/11 11:52AM, Yury Norov wrote:
> The Maple Tree benchmark uses MTREE_INIT() for a stack-allocated tree.
> Its static spinlock initializer leaves lockdep to use the lock address
> as the class key. Since the address is on the stack, the first allocation
> triggers "INFO: trying to register non-static key" and disables lockdep.
> 
> The IDA benchmark has the same problem through IDA_INIT(), but runs after
> Maple Tree and therefore encounters an already disabled lockdep.
> 
> Use mt_init_flags() and ida_init() to initialize the locks with persistent
> lock-class keys. Keep initialization outside the timed allocation paths.
> 
> Fixes: f4806cc63cc6 ("lib: test bitmap vs IDA vs Maple Tree performance for region allocations")
> Closes: https://lore.kernel.org/oe-lkp/202609101106.771b567e-lkp@intel.com
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  lib/region_alloc_benchmark.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
> index e88b4cf55c62..a644f3d5431a 100644
> --- a/lib/region_alloc_benchmark.c
> +++ b/lib/region_alloc_benchmark.c
> @@ -78,11 +78,13 @@ static size_t __init ida_size(unsigned long nr_ids)
>  
>  static unsigned long __init benchmark_ida(unsigned long cap)
>  {
> -	struct ida ida = IDA_INIT(ida);
> +	struct ida ida;
>  	unsigned long cnt, idx, off, nr_ids = 0;
>  	ktime_t alloc_time, free_time;
>  	int id = -ENOSPC;
>  
> +	ida_init(&ida);
> +
>  	alloc_time = ktime_get();
>  	for (cnt = 0; cnt <= cap; cnt++) {
>  		for (off = 0; off < reg_sz[cnt]; off++) {
> @@ -125,12 +127,14 @@ static unsigned long __init benchmark_ida(unsigned long cap)
>  
>  static unsigned long __init benchmark_maple_tree(unsigned long cap)
>  {
> -	struct maple_tree mt = MTREE_INIT(mt, MT_FLAGS_ALLOC_RANGE);
> +	struct maple_tree mt;
>  	unsigned long cnt, idx;
>  	ktime_t alloc_time, free_time;
>  	size_t sz;
>  	int ret;
>  
> +	mt_init_flags(&mt, MT_FLAGS_ALLOC_RANGE);
> +
>  	alloc_time = ktime_get();
>  	for (cnt = 0; cnt <= cap; cnt++) {
>  		ret = mtree_alloc_range(&mt, &idx, xa_mk_value(cnt + 1),
> -- 
> 2.53.0
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
