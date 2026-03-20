Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33153148A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019168; cv=none; b=b83eg6dkH+KMWnwYoGm7HDTiZgFrjkhRa/OlXXG7IAw4k4gj9zFaXjJ6DSBG3PVf2sQoCUZVObshrtkAZdOyBGzg6bjzU5C80OAF5uLWRA7g//2STqSWnl/34zRTbPLpk3ac5duuYMfdfBoRHulFAhGzohnOMMKBVh2pDiJbAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019168; c=relaxed/simple;
	bh=a5V6KVj/p5ln89F2tRrdVmVw8oemreTmSe3BZkx0iwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QegxqixiMZ2j3ci2+GsXsVcVuF8ZFIdWq8YQqhHYgkueLOGNX0f7946/wQkm5VlY6TmxbcDvy+VoqezOKe8H0vU+a1Orz+xfXfV5a2PEqCw8W/fYc+pgYBy+7E3JZAQJTvKUQKiks4f7lKO95wPDugGIgGJ5R2GO9+ChCAk42jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvpIdq/9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvpIdq/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE725C4AF09;
	Fri, 20 Mar 2026 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019167;
	bh=a5V6KVj/p5ln89F2tRrdVmVw8oemreTmSe3BZkx0iwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvpIdq/9d72DivkgvVtymQHXH7jVuQuYKi3+LQHQ0f58tkUJ728fEqgRkKtSJZoaN
	 pbFtnOrAxJ13dAXGYHacB7GiWq/px7693hwN8squYYUeIxksnEMb2cQRWnyaBSSDAs
	 N3nR1vFYOOw53CMX9KGCjVkVS7tmkdKy/w1SjtNibjIDdexgi4vYDL8QvZT+6WWD7Y
	 nPIxAOAO/qfHwUNAe16FCr7yOJHR4cgua67djnjnxCltxrKPlawhJIrcceYIc6/NMK
	 69I+FE4vf7u/FEX4iR3I6J/6gTnnfOkzzEw1+ndDtVN8galvJvxQkL4Z3vdTlfZV3X
	 g8h9ZDpMBnBAw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id AC0A5F4008E;
	Fri, 20 Mar 2026 11:06:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 11:06:05 -0400
X-ME-Sender: <xms:XWK9aTGlply8P2WXI5gm8LsWpf-879owa-bTH6wLNhi64OO78QpseQ>
    <xme:XWK9aRNwzVEYWSPIrFLkSRWV1eYcxOPkaFglgErNL5Hq1VEWEFSkArU0LVf868x5l
    v5oz_JiyfRBHk1IPGxcrKeOWlHNSYuB1Dwxt0xsL8LWC_0vOhkpqMQ>
X-ME-Received: <xmr:XWK9aZV1NiWo7gWZ2mD2LbYCd5FQZmE6XFW1_gLdhU1H1QTOkpiSmTitptlNNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepjedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehrsehhvghvrd
    gttgdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrjhgusehl
    ihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:XWK9aT5phdrM6ht8yfHkhZBNhAzK9KUFu6FOhax-DnoPBFUcjC6aww>
    <xmx:XWK9adn8Y_lXfNumOHQpTIL9_rLsQujlxGnsQghmxrGCBuJ9VIGMhw>
    <xmx:XWK9aXS6uRaLVti6KPA7cuKQ0pbnBlVtwgXLXnkyeRO89ddfZs_IBA>
    <xmx:XWK9aRAPA0NVurwyZxYFvL52QXGXbxBnomFHt93naPmm37U8CWTLlg>
    <xmx:XWK9aQxPNsDm5BWvL-57J_trms6Vcwlrv9Y7bSLdb8vohBx3nERv2mlo>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 11:06:04 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:06:03 +0000
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
	Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 4/4] mm: align file-backed mmap to max folio order in
 thp_get_unmapped_area
Message-ID: <ab1gW5tR6LhX0fQ0@thinkstation>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-5-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-5-usama.arif@linux.dev>

On Fri, Mar 20, 2026 at 06:58:54AM -0700, Usama Arif wrote:
> thp_get_unmapped_area() is the get_unmapped_area callback for
> filesystems like ext4, xfs, and btrfs. It attempts to align the virtual
> address for PMD_SIZE THP mappings, but on arm64 with 64K base pages
> PMD_SIZE is 512M, which is too large for typical shared library mappings,
> so the alignment always fails and falls back to PAGE_SIZE.
> 
> This means shared libraries loaded by ld.so via mmap() get 64K-aligned
> virtual addresses, preventing contpte mapping even when 2M folios are
> allocated with properly aligned file offsets and physical addresses.
> 
> Add a fallback in thp_get_unmapped_area_vmflags() that uses the
> filesystem's mapping_max_folio_size() to determine alignment, capped to
> the mapping length via rounddown_pow_of_two(len). This aligns mappings
> to the largest folio the page cache will actually allocate, without
> over-aligning small mappings.
> 
> The fallback is naturally a no-op for filesystems that don't support
> large folios and skips the retry when the alignment would equal PMD_SIZE
> (already attempted above).
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/huge_memory.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8e2746ea74adf..4005084c9c65b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1242,6 +1242,20 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  	if (ret)
>  		return ret;
>  
> +	if (filp && filp->f_mapping) {
> +		unsigned long max_folio_size =
> +			mapping_max_folio_size(filp->f_mapping);
> +		unsigned long size = rounddown_pow_of_two(len);
> +
> +		size = min(size, max_folio_size);
> +		if (size > PAGE_SIZE && size != PMD_SIZE) {
> +			ret = __thp_get_unmapped_area(filp, addr, len, off,
> +						      flags, size, vm_flags);

Have you considered to integrate inside __thp_get_unmapped_area?

Like, start with PMD_SIZE alignment, then lower to
mapping_max_folio_size if needed and then lower further based on mapping
size.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
