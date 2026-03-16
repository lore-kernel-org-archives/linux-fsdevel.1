Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459723E358
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662419; cv=none; b=u0Em9tFWOe+ETsoMvNGlLFAmRfG95uHbM+LBQbOoTTfD0FHujRCv9e8/WflgqU09T50hHSvV5pMqdGF1hdIyPaiiTgd/O3JRbBQEctK/nNcsmN2JB3z8jbGaYCM68JtGj+BGxDWyac+/rQ2eLI1FvnhjWniXp5YfND1CwbBZpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662419; c=relaxed/simple;
	bh=Q0VK/fXpeMFyb4XRBgC/8Fp6njX7ZmKFkwignOs4Znw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Y9T7FHxIj5F7s9YR6TH5H59JRHn5TXGenzkLuclm9VfA8A/jBKPKUs7QGbeJ4zZWQeYSCLd31fTaLNjsDwwhu0+Kdntcs7ItzmctBc7gyVB1gQYV+faTSo4OD2dOuJKLzxbck5ZHwg4hAd4QrOfK/2wmPgffmgzunBLE4GOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOeLt4UM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOeLt4UM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CA9C19424;
	Mon, 16 Mar 2026 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773662418;
	bh=Q0VK/fXpeMFyb4XRBgC/8Fp6njX7ZmKFkwignOs4Znw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOeLt4UMpwys8E0pMYYPYKhwU9wXj9dAQogOmUI6OpY5Z1ONqqK3Mp2uZ9WJnIes7
	 h9Rqyn0gDldDn9Cvv7OkbXkFpxDfb7YTvAqIlyOYFZmbGB8bD+KMqmozxtcpcgrG9e
	 OVW11PwcKtBJo9ccsrICEWU5/EWUs60wpUTKwCVPw3D1r4pV+VYDN4WG4O8UUjQupD
	 dP4J7HrMNP1u/SR1eH/MUwYp/wK/dp+70tdL8KB2zuzP2ej0ruOIhq+PCq3yTFWlw9
	 zlTs0sTS0OQMykXgFW7w/8balyNOB+EdM9nYvxOMiFte4pjdgO7T9NdFinGddD8Trg
	 gWGFIezQGpVhQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33C50F40076;
	Mon, 16 Mar 2026 08:00:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 08:00:17 -0400
X-ME-Sender: <xms:0fC3aUWEeLyG7ImCYzAp_kBnQSprrYvWkFklLJH3rLFgN9BPxlPGXA>
    <xme:0fC3aX3wvqrc-knPVVnZX0SnpPbntISuCJjI99QYSj-fUxyeMf6wWQvkvcfLlbMeW
    6CDferh-RhFJ2g-XK52dr3mrFS4XG9CYkYhMFbDmoL6yZjGG6qFY4U>
X-ME-Received: <xmr:0fC3aUlI-ZYe0tqsu05WA3-Rs7csFBR1sz7geQAGtH0j7_gM2o5kMtngJ8syzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeigfdvtdekveejhfehtdduueeuieekjeekvdfggfdtkeegieevjedvgeetvdeh
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprh
    gtphhtthhopeguvghvrdhjrghinhesrghrmhdrtghomhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomh
    dprhgtphhtthhopehprdhrrghghhgrvhesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
    pehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughhohifvghllhhsse
    hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:0fC3aeGVUszm7BESAbmeVVNYVKxp6mo6I208IJx7MAxToL2bdmy4yg>
    <xmx:0fC3aRmjgnijvlPkGhutJ4UzqRqjSCO-Jh9jwTDJu7yERTBkynC3jw>
    <xmx:0fC3aYMGc9U-aRBmf1Tt0Wqhozcx0PLycHkQHy8m8k4weY0aJxoDsA>
    <xmx:0fC3aRB-SAEdbS81spY6uG-n_j-3tCQFqU1DkE_0wI9OKjlRNLPlxQ>
    <xmx:0fC3aZVUSzfX1SBYye12Hp0Bf15OHXN9J4yioOcWQnY5j4zILG8d_T1N>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 08:00:14 -0400 (EDT)
Date: Mon, 16 Mar 2026 12:00:09 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, 
	willy@infradead.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	p.raghav@samsung.com, mcgrof@kernel.org, dhowells@redhat.com, djwong@kernel.org, 
	hare@suse.de, da.gomez@samsung.com, dchinner@redhat.com, brauner@kernel.org, 
	xiangzao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: filemap: fix nr_pages calculation overflow in
 filemap_map_pages()
Message-ID: <abfwUro4rJw7u5d5@thinkstation>
References: <066dd2e947ccc1c304b54e847fbe628dccea1d7c.1773370126.git.baolin.wang@linux.alibaba.com>
 <0890a207-354e-4da1-80c2-67754354a6a6@arm.com>
 <c7e8ac1c-0486-4e41-a62c-0917054b2fa1@arm.com>
 <726ee101-6978-49f6-8f2b-edc7f8d99074@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <726ee101-6978-49f6-8f2b-edc7f8d99074@linux.alibaba.com>

On Fri, Mar 13, 2026 at 01:54:31PM +0800, Baolin Wang wrote:
> 
> 
> On 3/13/26 1:14 PM, Dev Jain wrote:
> > 
> > 
> > On 13/03/26 10:41 am, Dev Jain wrote:
> > > 
> > > 
> > > On 13/03/26 9:15 am, Baolin Wang wrote:
> > > > When running stress-ng on my Arm64 machine with v7.0-rc3 kernel, I encountered
> > > > some very strange crash issues showing up as "Bad page state":
> > > > 
> > > > "
> > > > [  734.496287] BUG: Bad page state in process stress-ng-env  pfn:415735fb
> > > > [  734.496427] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x4cf316 pfn:0x415735fb
> > > > [  734.496434] flags: 0x57fffe000000800(owner_2|node=1|zone=2|lastcpupid=0x3ffff)
> > > > [  734.496439] raw: 057fffe000000800 0000000000000000 dead000000000122 0000000000000000
> > > > [  734.496440] raw: 00000000004cf316 0000000000000000 0000000000000000 0000000000000000
> > > > [  734.496442] page dumped because: nonzero mapcount
> > > > "
> > > > 
> > > > After analyzing this page’s state, it is hard to understand why the mapcount
> > > > is not 0 while the refcount is 0, since this page is not where the issue first
> > > > occurred. By enabling the CONFIG_DEBUG_VM config, I can reproduce the crash as
> > > > well and captured the first warning where the issue appears:
> > > > 
> > > > "
> > > > [  734.469226] page: refcount:33 mapcount:0 mapping:00000000bef2d187 index:0x81a0 pfn:0x415735c0
> > > > [  734.469304] head: order:5 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > > > [  734.469315] memcg:ffff000807a8ec00
> > > > [  734.469320] aops:ext4_da_aops ino:100b6f dentry name(?):"stress-ng-mmaptorture-9397-0-2736200540"
> > > > [  734.469335] flags: 0x57fffe400000069(locked|uptodate|lru|head|node=1|zone=2|lastcpupid=0x3ffff)
> > > > ......
> > > > [  734.469364] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1),
> > > > const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *:
> > > > (struct folio *)_compound_head(page + nr_pages - 1))) != folio)
> > > > [  734.469390] ------------[ cut here ]------------
> > > > [  734.469393] WARNING: ./include/linux/rmap.h:351 at folio_add_file_rmap_ptes+0x3b8/0x468,
> > > > CPU#90: stress-ng-mlock/9430
> > > > [  734.469551]  folio_add_file_rmap_ptes+0x3b8/0x468 (P)
> > > > [  734.469555]  set_pte_range+0xd8/0x2f8
> > > > [  734.469566]  filemap_map_folio_range+0x190/0x400
> > > > [  734.469579]  filemap_map_pages+0x348/0x638
> > > > [  734.469583]  do_fault_around+0x140/0x198
> > > > ......
> > > > [  734.469640]  el0t_64_sync+0x184/0x188
> > > > "
> > > > 
> > > > The code that triggers the warning is: "VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio)",
> > > > which indicates that set_pte_range() tried to map beyond the large folio’s
> > > > size.
> > > > 
> > > > By adding more debug information, I found that 'nr_pages' had overflowed in
> > > > filemap_map_pages(), causing set_pte_range() to establish mappings for a range
> > > > exceeding the folio size, potentially corrupting fields of pages that do not
> > > > belong to this folio (e.g., page->_mapcount).
> > > > 
> > > > After above analysis, I think the possible race is as follows:
> > > > 
> > > > CPU 0                                                  CPU 1
> > > > filemap_map_pages()                                   ext4_setattr()
> > > >     //get and lock folio with old inode->i_size
> > > >     next_uptodate_folio()
> > > > 
> > > >                                                            .......
> > > >                                                            //shrink the inode->i_size
> > > >                                                            i_size_write(inode, attr->ia_size);
> > > > 
> > > >     //calculate the end_pgoff with the new inode->i_size
> > > >     file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> > > >     end_pgoff = min(end_pgoff, file_end);
> > > > 
> > > >     ......
> > > >     //nr_pages can be overflowed, cause xas.xa_index > end_pgoff
> > > >     end = folio_next_index(folio) - 1;
> > > >     nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
> > > > 
> > > >     ......
> > > >     //map large folio
> > > >     filemap_map_folio_range()
> > > >                                                            ......
> > > >                                                            //truncate folios
> > > >                                                            truncate_pagecache(inode, inode->i_size);
> > > > 
> > > > To fix this issue, move the 'end_pgoff' calculation before next_uptodate_folio(),
> > > > so the retrieved folio stays consistent with the file end to avoid 'nr_pages'
> > > > calculation overflow. After this patch, the crash issue is gone.
> > > > 
> > > > Fixes: 743a2753a02e ("filemap: cap PTE range to be created to allowed zero fill in folio_map_range()")
> > > > Reported-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> > > > Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > ---
> > > >   mm/filemap.c | 6 +++---
> > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index bc6775084744..923d28e59642 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -3879,14 +3879,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> > > >   	unsigned int nr_pages = 0, folio_type;
> > > >   	unsigned short mmap_miss = 0, mmap_miss_saved;
> > > > +	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> > > > +	end_pgoff = min(end_pgoff, file_end);
> > > > +
> > > >   	rcu_read_lock();
> > > >   	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> > > >   	if (!folio)
> > > >   		goto out;
> > > > -	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> > > > -	end_pgoff = min(end_pgoff, file_end);
> > > > -
> > > >   	/*
> > > >   	 * Do not allow to map with PMD across i_size to preserve
> > > >   	 * SIGBUS semantics.
> > > 
> > > I am wondering whether something similar can happen in the do-while loop
> > > below this code. We can retrieve a folio from next_uptodate_folio, and
> > > then a massive truncate happens and we end up mapping a large folio
> > > into the pagetables beyong i_size, violating SIGBUS semantics. (truncation
> > > may back-off seeing the locked folio/increased refcount in filemap_map_pages)
> > 
> > Read the bracket text as - (truncation may fail to unmap this folio seeing
> > it locked or with elevated refcount, therefore the illegal mapping stays
> > permanent)
> 
> IMHO, the truncate_pagecache() will call unmap_mapping_range() twice, and
> the folio lock and refcount will not block unmap_mapping_range() to unmap
> the folio's mapping (only hold ptl lock).
> 
> So the truncate_pagecache() can still truncate large folios beyond i_size.

Yeah, we serialize here on the folio lock. It should be safe.

The fix looks sane to me:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
