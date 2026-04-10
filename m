Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D039E17A;
	Fri, 10 Apr 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822142; cv=none; b=r3Xqo/yp16ZQF4UUXCX6A7yx/iloNVW8WEnS+hR39WlLyYSHy9AXNti8MeH1lOJ4cLRSX12VvghFtAaiVlxmBiNwNL4mck4xHVjv0ky4AXf6jo+WHcUfpfCy7HsTnZ+Qjk9p4BARmSOEXKq0MgLx/kvBXxxPurefnADLfveU7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822142; c=relaxed/simple;
	bh=HFVNSZ9NdLshs/GF0kF4F3nn6TItzP93pKQuOnmZi4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7eNng18lVUiJ5caxhekt2MV46zmljQLYj+h2jb6a1IlcP3t3J6QfdTH+JFMoljgHf0U9dBgDHtnvsDbis20Fjvigrab6lquQ2LyihD4hZaqS4WPjaNOfQnH4RpZnMdtcX5CepN4bXE++sNQ0bnf2hb3WkmozqLEQs5vBvB7ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOZIcHOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOZIcHOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D0DC19421;
	Fri, 10 Apr 2026 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822141;
	bh=HFVNSZ9NdLshs/GF0kF4F3nn6TItzP93pKQuOnmZi4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOZIcHOx8RMyGXKW+908tLqShReyx8UHYG4egkJqVAZkly0v7p33q4UAay3LeO2Li
	 909+KGhspCpoLhKu/yYX4lgd1bQD8j7huO7QANJEMGOMwOID5qf6JimIdEMuVtAFjW
	 +GhHAia+VOlJjk1lkx7+BsR28wl1z47Ab6wp84ECDq4Ne2+EnT+emA7hhb4J+2rLry
	 YlaUbwErfT9kQccM/Jz2U8uBuxnxtjdRSVkHLVeVUEjGqnHrocrFlrDSa/ozdtHXtC
	 EO3nFkJuqdofrp1T2VseMnr7Gmf0zpuJ+5ds4RjmrJ4HjFgZMtXk4qr1svT4RRSevK
	 SKvQh+S8cISDQ==
Date: Fri, 10 Apr 2026 12:55:31 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com, 
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, 
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev, leitao@debian.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Message-ID: <adjkCOiLgZ_-zovg@lucifer>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>

On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
>
>
> On 02/04/2026 19:08, Usama Arif wrote:
> > v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
> > - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
> >   to HPAGE_PMD_SIZE limited to 2M (Rui)
> > - Reviewed-by tags for patch 1 from Kiryl and Jan
> > - Remove preferred_exec_order() (Jan)
> > - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
> >   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
> >   do_sync_mmap_readahead().
> > - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
> >   page size for arm64.
> > - remove bprm->file NULL check (Matthew)
> > - Change filp to file (Matthew)
> > - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
> >
>
> Hello!
>
> Just wanted to check if there was any feedback/review on the latest
> revision?

It's -rc7, this is definitely something for next cycle :)

On my part, my upstream bandwidth has drastically reduced, and review is
probably going to have to be a hobbyist thing at least for now.

Also, not to be mean but:

$ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
21

So... :)

Review in mm is very lop-sided, let's try to balance it out a bit!

>
> Thanks!
>

Thanks, Lorenzo
