Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2B1DF987;
	Fri, 20 Mar 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018520; cv=none; b=AH9nDRlAIqBN8iJOCSk/PefhxTu8cL/H9QqpOg80ox/XHmbbwM2cKTYZ4NhHdY5WQ3Z3s82q+DeWOL37+UNaIeIn+xTHD4zeIzN5r0mmTAGhFF+idL16Tv59jZlJwPeLmB2JrEVlLHBAVUOg1z2eFFQV61wl2Nfal/oEnk2Zk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018520; c=relaxed/simple;
	bh=O3kRy3P5OtBeHmM5/xruXYwzutxlo/f+EkNqcRA/w5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUzYeWK+T/FodU+hJLD8cTh8ROeTtdYTNXHyw8rTCWbBfMwscXgOwDoIRcGzTD4/rxhp+d06WKFikxGG873R7Uu4HlA2WlwNfj6oFyYPyprsibn7LPL9bXODmN3R8+jW/Cp+vH7QoDIBQtNbONV+czWEJvbToPqBITMk5VAS3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVCcVgcK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVCcVgcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E3C4CEF7;
	Fri, 20 Mar 2026 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018519;
	bh=O3kRy3P5OtBeHmM5/xruXYwzutxlo/f+EkNqcRA/w5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVCcVgcKt3ENBDOXfD/60Mu9JraNJ2WvkNnJPLDxcLpHQTLXDNARrOidqFmec0PJE
	 yVX1W72YSY4FPiVwzr/ZZLT3Ks7PMrYQsxJmPxQ9LKlgzKGFbt3Hut/RU5zMcJqMVa
	 vGjXkqa7OVHKziaQ17Ou0ly4kIsD2kZfQFTavyoIDQF6kFCYpWNz4WYlo7JUscgUzI
	 h1uDMO+B46JkBdUu2L43tNR6zmaqUThorJmcbIZrJgrMIakV+wwRzHzJjnqdz9Zd50
	 mzzi/amooHZh68eKX7aADaySN/4Gx0mAiN20/Xg7Lh95emwHaBAPvg5HhWlFVZ5i6A
	 I+9dUNjLZKG4Q==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6FEE1F4008C;
	Fri, 20 Mar 2026 10:55:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 10:55:17 -0400
X-ME-Sender: <xms:1V-9aaSTVTLEJPaFtMfcA9OOQSLk6qtER_2mvgUbfF3fQpIbCDd91w>
    <xme:1V-9abdH345Wj_d1EkOyJYfZtrNL3QOR91X4KS2F-d0a3XE01QeuoYEtJHrRGFmio
    UlstYHdVto1xFUMavPzUq8FilejKFr1oa0HhRdqNVX2yayhuefTV98>
X-ME-Received: <xmr:1V-9aTfYn0Kud8Hgybz5tkAILzW6y7K-6lDlJViE8CHzIInCavWwUHWChV9qRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtvddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1V-9aSLYaO6kt-4n-RVsJqON1ip8AjtaH_Pt27AjXHKRrFN1Pvqa8w>
    <xmx:1V-9aZ0A4xGzllAxFHCPwmld6prMiihpMM3Y0RTtW3tR4Z5viCZseg>
    <xmx:1V-9aYoDjjXvmIC1gpUFWF1PXwx9w_DdKHu1fvkuetZfscplB_4rWQ>
    <xmx:1V-9aRo6hYvorNf3SXqjnpLn9K1cmaKVdAbWqEdB7skdA7USK4-Ypg>
    <xmx:1V-9afx9vU-5uv-9QmNxaLtg9yZTtGG520E3KGSXRr2754fS-0oCwACz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 10:55:16 -0400 (EDT)
Date: Fri, 20 Mar 2026 14:55:14 +0000
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
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Message-ID: <ab1fvJxFYQP-ByQG@thinkstation>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-4-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-4-usama.arif@linux.dev>

On Fri, Mar 20, 2026 at 06:58:53AM -0700, Usama Arif wrote:
> For PIE binaries (ET_DYN), the load address is randomized at PAGE_SIZE
> granularity via arch_mmap_rnd(). On arm64 with 64K base pages, this
> means the binary is 64K-aligned, but contpte mapping requires 2M
> (CONT_PTE_SIZE) alignment.
> 
> Without proper virtual address alignment, readahead patches that
> allocate 2M folios with 2M-aligned file offsets and physical addresses
> cannot benefit from contpte mapping, as the contpte fold check in
> contpte_set_ptes() requires the virtual address to be CONT_PTE_SIZE-
> aligned.
> 
> Fix this by extending maximum_alignment() to consider the maximum folio
> size supported by the page cache (via mapping_max_folio_size()). For
> each PT_LOAD segment, the alignment is bumped to the largest
> power-of-2 that fits within the segment size, capped by the max folio
> size the filesystem will allocate, if:
> 
>   - Both p_vaddr and p_offset are aligned to that size
>   - The segment is large enough (p_filesz >= size)
> 
> This ensures load_bias is folio-aligned so that file-offset-aligned
> folios map to properly aligned virtual addresses, enabling hardware PTE
> coalescing (e.g. arm64 contpte) and PMD mappings for large folios.
> 
> The segment size check avoids reducing ASLR entropy for small binaries
> that cannot benefit from large folio alignment.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
