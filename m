Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADA3B7B72;
	Fri, 10 Apr 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823231; cv=none; b=XA35EWgt42hCRodm+6XK7LxmMp5oZhnUUloF7C4fCS3MrNmrxvJLQjscOxobZN0V3/dM98dfOuq+dY5mFVQgz/QtMFItTvoxL5nBdEosdxITxRQDNDB2ho825/mkO6pR8Pu0Dj7CLR1EgJf4X1e+XIBN39PoT5nFweEOvkfaxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823231; c=relaxed/simple;
	bh=Mr9yxOrAKcnkKOYz0gBol4ytGWhmvk0ZGMLSGWC88UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShTy9uX6IM5yrgJKh3O829Faeeqprt3sIf/MXLCihcnzw/GQJKiGfC5apc7z/YB8GPAYfHY4+W46cFrhYX5na5l4G+wj2thC2GSheo8cMBORkuo7aOownsMN4H4wC8Uekyz6UNy6VJ2mul+Z1jkg853+OCkjbcV9Wr2kCDaOby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLzPZ7sl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLzPZ7sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945D6C19421;
	Fri, 10 Apr 2026 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823231;
	bh=Mr9yxOrAKcnkKOYz0gBol4ytGWhmvk0ZGMLSGWC88UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLzPZ7sleIRkgRUbRXWJDZwu1lql5NkDTsfvi2l3sWZDBGqnMUC2nUk1cHxoBxMms
	 ULDJrUVTDHlAlvO4n4FTXnygk1oB0t7mC27YH2+j4No4IUzJiDsOhxw/ZGMhp3hMiR
	 Rb8doK3idFBNSpQ4O2TMorkL/hJ4kVEGTS+3/iyOkqsJsKSL9TLtn8ihSbHVjAIBWN
	 lL7SOh7tk79CxmERhjRi2vxcjvOUErXbhEh2C8uiy9umOXz1xoR4jYSL2+psJkS5fo
	 G+pL7nyUzc4fZfkE9V5r6FA45of6iVKUaFTxQRjFjWRxSQ9GinlVMdY0TNMf1f81VN
	 RCSjyXxfG69wA==
Date: Fri, 10 Apr 2026 13:13:40 +0100
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
Message-ID: <adjotZ6nXqDk0GKS@lucifer>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
 <adjkCOiLgZ_-zovg@lucifer>
 <262a41db-a425-4362-bb67-df61119625d5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262a41db-a425-4362-bb67-df61119625d5@linux.dev>

On Fri, Apr 10, 2026 at 01:05:40PM +0100, Usama Arif wrote:
>
>
> On 10/04/2026 12:55, Lorenzo Stoakes wrote:
> > On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
> >>
> >>
> >> On 02/04/2026 19:08, Usama Arif wrote:
> >>> v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
> >>> - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
> >>>   to HPAGE_PMD_SIZE limited to 2M (Rui)
> >>> - Reviewed-by tags for patch 1 from Kiryl and Jan
> >>> - Remove preferred_exec_order() (Jan)
> >>> - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
> >>>   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
> >>>   do_sync_mmap_readahead().
> >>> - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
> >>>   page size for arm64.
> >>> - remove bprm->file NULL check (Matthew)
> >>> - Change filp to file (Matthew)
> >>> - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
> >>>
> >>
> >> Hello!
> >>
> >> Just wanted to check if there was any feedback/review on the latest
> >> revision?
> >
> > It's -rc7, this is definitely something for next cycle :)
> >
>
> Yeah no worries! Just wanted to check what people thought about it!

We'll come back to it! With LSF coming too I think people are fairly distracted
as well.

>
> > On my part, my upstream bandwidth has drastically reduced, and review is
> > probably going to have to be a hobbyist thing at least for now.
> >
> > Also, not to be mean but:
> >
> > $ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
> > 21
> >
> > So... :)
> >
> > Review in mm is very lop-sided, let's try to balance it out a bit!
> >
>
> Ah yeah actually I have been reviewing a lot over the last few months.

Good :)

> I dont ack patches that have already been acked-by/reviewed-by maintainers.

You should do that, it is meaningful. If you think a patch is OK, it's how you
say so!

Maintainers get things wrong too by the way, assume we are wrong and try to find
issues, this is how a healthy technical community operates (as long as everybody
is civil about it :)

> as I am not sure if it adds anything. I never really cared about Reviewed/Acked
> by/patch count but I can start adding tags if it helps in stats.

It's the only metric I can quickly bring up, so sorry that in this case I got it
wrong, but the overall point remains the same - we want to see a balance of
review and contributions, right now the two are really very lopsided!

>
> The reviews I have done over the last week alone:
> https://lore.kernel.org/all/20260408122307.1360475-1-usama.arif@linux.dev/
> https://lore.kernel.org/all/20260408123700.1596800-1-usama.arif@linux.dev/
> https://lore.kernel.org/all/20260409142256.131676-1-usama.arif@linux.dev/
> https://lore.kernel.org/all/20260410114809.3592720-1-usama.arif@linux.dev/
> https://lore.kernel.org/all/20260410112433.3248586-1-usama.arif@linux.dev/
> https://lore.kernel.org/all/20260331103451.1070175-1-usama.arif@linux.dev/T/#t
> https://lore.kernel.org/all/20260401152343.3294686-1-usama.arif@linux.dev/
>
>
>
>
>

Cheers, Lorenzo
