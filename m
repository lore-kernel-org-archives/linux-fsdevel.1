Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5133688E;
	Fri, 10 Apr 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822287; cv=none; b=GUjGoU6Q8H+7imCbIXoknsfOGkxILZBXNQpcxbVynhzvCamDpACvCSunSuiLVu+a0VcIAu3+sxZDT7rnFLtiBk1/XZPvyhm16TBd94IzkNG7UJHp7jGp2F109R+xggT4xVy2OAA1Wwz+jo5KO21xc744UEgGnZuUnvmZjNXcnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822287; c=relaxed/simple;
	bh=1IlVya3cDWf4jvwWxchg1KQjmwkbJ5Ag/jKFwWp3CvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn38zwJwl4EWcZAET33KDcvTL1okDzdTdQHYN23M91oICDuqp9Au1wS/5iM5yfVCDQWy/eYsslbvuDn0VKe/n15ILplMAVhkfgIhH0hfhDpnBZf6RnJhYczUYWuw127sOkg82zs3TOcpSk1iNsAlH2rrSZhPBdM6KMjRTaGBztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtHphArR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtHphArR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48805C19421;
	Fri, 10 Apr 2026 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822286;
	bh=1IlVya3cDWf4jvwWxchg1KQjmwkbJ5Ag/jKFwWp3CvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtHphArRe3+5ugz15PPQLf6OUxnW5LjX8Uc0gNt4yDfRrnoVH5t/QvmsRE8v8eU/G
	 sRJBY0NdCHSYQbYIZWfu2YxuJDgJoKOz6l60yejqkGC8+Mfk7oBJNHXmQ+Z21ZbNkc
	 04yw91ZIEBNPLKwXcj1PzNAqLrUBNItgu1itsAuNmxJ4ggjgvHYrDYnph59t3oeG5Y
	 tNthufSoSeozDo1o4+7hZqxC94QnPrqhFxjsqdc4Bjqw/01zMPYQrWYnXNDpU30g8e
	 UmR0k+lA0oE3rNHj4yYfHTr9q8EVyi9xhAYeMRYukwGGyalwhuE5brmODVtAu0aDgi
	 LkDH/7lAFYepg==
Date: Fri, 10 Apr 2026 12:57:56 +0100
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
Message-ID: <adjllNan2vgBNBHJ@lucifer>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
 <adjkCOiLgZ_-zovg@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adjkCOiLgZ_-zovg@lucifer>

On Fri, Apr 10, 2026 at 12:55:42PM +0100, Lorenzo Stoakes wrote:
> On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
> >
> >
> > On 02/04/2026 19:08, Usama Arif wrote:
> > > v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
> > > - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
> > >   to HPAGE_PMD_SIZE limited to 2M (Rui)
> > > - Reviewed-by tags for patch 1 from Kiryl and Jan
> > > - Remove preferred_exec_order() (Jan)
> > > - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
> > >   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
> > >   do_sync_mmap_readahead().
> > > - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
> > >   page size for arm64.
> > > - remove bprm->file NULL check (Matthew)
> > > - Change filp to file (Matthew)
> > > - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
> > >
> >
> > Hello!
> >
> > Just wanted to check if there was any feedback/review on the latest
> > revision?
>
> It's -rc7, this is definitely something for next cycle :)
>
> On my part, my upstream bandwidth has drastically reduced, and review is
> probably going to have to be a hobbyist thing at least for now.
>
> Also, not to be mean but:
>
> $ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
> 21
>
> So... :)
>
> Review in mm is very lop-sided, let's try to balance it out a bit!
>
> >
> > Thanks!
> >
>
> Thanks, Lorenzo

(Note that we're in a 'quiet period' from here until -rc1 of next cycle and
won't be taking anything new until then. We plan to do this from around rc5 or
rc6 of each cycle in future).
