Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CED41E6AD;
	Mon, 27 Jul 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168030; cv=none; b=EjKtdz3tADFpcfBp5BEAVXTAUkT2YTwVpryR/C+gX8pxWaL843Iv/lgSU5rqm1HoXP+TFAi/k10h3x06QpUtCigeCkZREC+fzZNqSsmXtBFJYyUTfAFlFz9qpKqbGRgxhK6Lv4cCncJRd1boeiLtJbB+Kv7VVT99OwX3Gpobl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168030; c=relaxed/simple;
	bh=7eWvigEn5QtaMp2zZKyDLgT5M8OcwN29A5IrpSxGBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4zypeJP77PygbOpBDGWhsTslqayrgRfiHs9t13KhS5gg1g7OZBgA4K1UeQtp2PhzM2AocJSMGlZJxOa2if0VJgvN+AbUwJV+T3inM25eyTZzV11jaFBWil3DkURKpNFYUwZwO6yiVppx1eA0XvUg4hIHBTzMcyAeCPOve9ZcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nCMJxn0c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nCMJxn0c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jB30wN8yjdXgq6NYs2kUjzKRcyWTmpmx3GjdzFD9/WE=; b=nCMJxn0cSZC7nJ47yk+Tys45BS
	XjZkO8CDf8Pn1DcEDz3p2HE4Rm3d7OBKfKKEd8ZnDJ4MGf6OtIGkjAtJxDY7zaDOTSu3mt6eB+nD7
	U1ifAgA5iSYkFzjtg0fpmuHkyxgdYThwBu8Q3OIXA3v0ukbFKfiBjLzrL6C71Sl1/cpvDq7ILyMtG
	AwSTkFCwFUtuc5DYtegdIbkRU6G/ybzswTJcUbNarGqvDxTQfuiajtHYURdr6h2hJWN6SPOwGMyWR
	u0HmsfjwnYAEOCiD/wj+VYPeuObhiX99FYbvclygFxO2rIUWAAQVo+j5z6TJZbHPr52oBFMDK167e
	W2RI3k6g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNkA-0000000AzfK-3C7g;
	Mon, 27 Jul 2026 15:59:54 +0000
Date: Mon, 27 Jul 2026 16:59:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Jan Kara <jack@suse.cz>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/15] mm/rmap: index MAP_PRIVATE file-backed folios
 by virt pgoff
Message-ID: <ameAekveMOcP7ffQ@casper.infradead.org>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <880981b5-ef79-4c9a-a8bd-7540002fcd15@kernel.org>
 <amd9QR75eLNdgNU7@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amd9QR75eLNdgNU7@lucifer>

On Mon, Jul 27, 2026 at 04:57:01PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Jul 27, 2026 at 04:44:06PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/20/26 16:38, Lorenzo Stoakes (ARM) wrote:
> > > In memory management we've managed to manufacture a great deal of confusion
> > > around the concept of anonymous memory. We have:
> > >
> > > 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
> > >    swap-backed (thus for reclaim purposes, treated as anonymous). These are
> > >    simple enough.
> > >
> > > 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
> > >    present in the page cache and mapped by an address_space object, but
> > >    whose folios are also swap-backed (thus treated as anonymous for reclaim
> > >    purposes).
> > >
> > > 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
> > >    vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
> > >    satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
> > >    referencing a file, but are in every other sense anonymous, including the
> > >    folios.
> > >
> > > 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
> > >    and have file-backed folios until CoW'd, at which point those CoW'd
> > >    folios are anonymous.
> > >
> > > This series fixes issues 3 and 4.
> > >
> > > In order for us to traverse VMAs using the reverse mapping, we require two
> > > fields - folio->mapping and folio->index. The first tells the rmap code
> > > where to look for VMAs, and the second tells it at which offset the folio
> > > starts within the referenced object.
> > >
> > > For anonymous folios, folio->mapping points at an anon_vma object. For
> > > file-backed folios, it points at an address_space. And:
> > >
> > > * For file-backed folios folio->index is simply the page offset of the start
> > >   of the folio within the file.
> > >
> > > * For anonymous folios belonging to pure anon mappings, folio->index is
> > >   equal to the virtual page offset of the folio.
> > >
> > > * For anonymous folios belonging to file-backed mappings (i.e. CoW'd folios
> > >   of a MAP_PRIVATE file-backed mapping), folio->index is equal to the file
> > >   page offset.
> > >
> > > This series establishes a new virtual page offset property of VMAs to
> > > allow us to map anonymous folios at their virtual page offset, consistent
> > > with pure anon.
> >
> > As raised off-list, I consider the "virtual page offset" concept hard to grasp.
> >
> > Maybe it's just me :)
> >
> > Skimming over the code, I read "vmg->anon_pgoff", which is pretty intuitive to
> > me. Similarly vma_start_anon_pgoff() / vmg_end_anon_pgoff().
> >
> > Could we similarly just call this "anon_pgoff" /  "(linear) anon page index"
> > even on the VMA level.
> 
> Yeah, I had originally done this.
> 
> I renamed it because I worried that people might be confused by references to
> anon for file-backed VMA mappings.
> 
> But I think probably you're right that referring to it as virtual page offset
> adds even more confusion vs. simply calling it anon. Will respin accordingly.

Would the term "logical page offset" be helpful?

I already use this in my description of folios:

 * A folio is a physically, virtually and logically contiguous set
 * of bytes.  It is a power-of-two in size, and it is aligned to that
 * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
 * in the page cache, it is at a file offset which is a multiple of that
 * power-of-two.  It may be mapped into userspace at an address which is
 * at an arbitrary page offset, but its kernel virtual address is aligned
 * to its size.

