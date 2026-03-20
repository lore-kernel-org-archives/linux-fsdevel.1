Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB3279DC8;
	Fri, 20 Mar 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017699; cv=none; b=Hr0AL9DvParQh9DLP9YSq1BK+cK64fGdEsuyUzB7hRjW1gvJqdLZuDENTZDjtgx9fFWrHFNi9cwovuZSeN7HHuimhRyVM+M2KWF/ybjXtudxkTJddhqibmul1H2k3JRU8sBO+8VslYDcEe1GCvzCmNEUMJ5Ht60n6cJ2JTpIG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017699; c=relaxed/simple;
	bh=MleXr4rMQyGrNTxmnpL0OE9WPCRqySChIwPXxidm8Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Wx0+SrXvVoDs/W2zPUwjuVtOc8ME7BEQmGwEaBe4bMiEyIHMsTsFoIF+BFjDeA/TUVCMecOsOlOuy6qKdBa9BJC2Bi/eYbVjLYvaKokNczcGK9a3y/CMDNn1a1UcjTNwBJECyRCSHw5rBUw7ilh2GkPVeWb1ebivvvJrneFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq6vlD79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq6vlD79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581A6C19425;
	Fri, 20 Mar 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774017699;
	bh=MleXr4rMQyGrNTxmnpL0OE9WPCRqySChIwPXxidm8Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq6vlD79vHeXVLRrDSlXpFcIaooTe1gQEOS9G+vxKvB2xy/bu2aGuVdke+R9e8cct
	 gLy//h1i4t9ddNZMYOlmc1/4aXgQ8Z7FmHVwn2mdODtHHcYUjBUDbvhC5UARRGm6Xn
	 yMZfTO8i2GcnFL2GQJCnRV8gGdhTSXK9baASFvgiZ8aNpA3QM0TiPaHnDHTdYoyJmq
	 S6qXxWNTAIn1dhkOlXGJ7q/K581rghQ5yEGMnJA/hr4jFldOVfptbcSIX4US+jjLdN
	 OBHD9BbCCiwpMZ4QFY49wHolDjfohcQxZA5uC1Ot6bF5RFRc2esOwDAcl5aOANLhFb
	 yTM9ihfiAVljQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 58B0CF4006A;
	Fri, 20 Mar 2026 10:41:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 10:41:37 -0400
X-ME-Sender: <xms:oVy9aVSEswKdaaR8aGXLwLX9Mrnm1MTZr6GqsIHJQZjvsPwvM2DHSQ>
    <xme:oVy9aRC1LkmFVQAmC4-0l8Aubu1iP6kXsJbODn6SSK7JpWTvPvq51uBxVY95aeKtt
    lYrDg-DyfGiq5DDzQ8FI1sffcI6lwvAPvFYwgrIKNBh54VbK2PZfw0>
X-ME-Received: <xmr:oVy9aYfWs9mAA8ehLGvEZl9-PdQX0bTxs20Hn9jARCmhuwrlwqffoRjCwII-dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehrsehhvghvrd
    gttgdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrjhgusehl
    ihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:oVy9aZ4PfLz1Ly6pHlacfHEwjHAP5YtItZ7H2jIC6jrP07jYH_qfsA>
    <xmx:oVy9afdMIA-OHh05bUUKj1s-fmi2GZwD1EfHX8oIHJ9RTxOriHAjjA>
    <xmx:oVy9aYNrQtOYagLdKvAlD3DnuEvEOtvGa2jmiWvOANLHXkLOix9QzQ>
    <xmx:oVy9abHde3Ce_3zuX6me7rTAicDjXXRpGwtLXbtdiJUGMqLuD6hcQQ>
    <xmx:oVy9abbdy3hceuMozJKr_dvhhLy8WJo_jua5CnWxzHG0f4dc8nfLQK4A>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 10:41:34 -0400 (EDT)
Date: Fri, 20 Mar 2026 14:41:30 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts@infradead.org, ziy@nvidia.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm: replace exec_folio_order() with generic
 preferred_exec_order()
Message-ID: <ab1ZopAY7JCUOYvr@thinkstation>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-3-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-3-usama.arif@linux.dev>

On Fri, Mar 20, 2026 at 06:58:52AM -0700, Usama Arif wrote:
> + *   allocations when memory is tight.
> + */
> +static unsigned int preferred_exec_order(struct vm_area_struct *vma)
> +{
> +	int order;
> +	unsigned long vma_len = vma_pages(vma);
> +	struct zone *zone;
> +	gfp_t gfp;
> +
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +
> +	/* Cap at min(PMD_ORDER, 2M) */
> +	order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT));
> +
> +	/* Don't request folios larger than the VMA */
> +	order = min(order, ilog2(vma_len));
> +
> +	/* Step down under memory pressure */
> +	gfp = mapping_gfp_mask(vma->vm_file->f_mapping);
> +	zone = first_zones_zonelist(node_zonelist(numa_node_id(), gfp),
> +				    gfp_zone(gfp), NULL)->zone;
> +	if (zone) {
> +		while (order > 0 &&
> +		       !zone_watermark_ok(zone, order,
> +					  high_wmark_pages(zone), 0, 0))
> +			order--;
> +	}

Eww. That's overkill and layering violation.

If we need something like this, it has to be do within page allocator:
an allocation interface that takes a range (or mask) of acceptable
order.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
