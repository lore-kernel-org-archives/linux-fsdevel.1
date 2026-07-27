Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D003FB067;
	Mon, 27 Jul 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167843; cv=none; b=SwUpCZuTBY5kxmJzaaxUP9RnGEfyTPWcod0cPC/ixWW9jC1HoRqeQgfMa64qFXqCcDRSR2OibcJcwWUPCjVG2HXqdoQ7YJ1DB7F+q23opr/hh/xMW6Lq+8HnO3uXgNUMIoSJrRGA4qOC3/mxHpCN5DfG9mZpMUmq2vxeQvMkVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167843; c=relaxed/simple;
	bh=lrs1wWLpaJK6eWPjL/KCSd3E0ddkjJ1+NsCq+5dynfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE9/r9OjoqvhSH86zAaTNiiS8Bqb6kyPOQYdSDQ7CUkrQ6zRQXle27qoS714j84R4HrrU3Mi7ijmRg6mF3v9ZSLRgNLv8RyRoO0ZXUbad2DXhQqC1/FFEDH3bDrC9tF3+5utxZKt0IF1iAvrOkp1SLCUZfjzK3RTuNlv7nnr7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS3LgLoe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS3LgLoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610571F00A3A;
	Mon, 27 Jul 2026 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167842;
	bh=TxIwg3k/QeB5YpM8mpnKKHWqe4ae+QJvkXRnO46mmqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aS3LgLoemsT7sttTQz1bFcjtnuSJmD82qShxfwVkKEIVhwyCRQzFYrZ1BGt+oX2Ad
	 Zf/cPw46qAZ1uENRq/ddMbAK89LecqDJ3Nd4sMeOUAJ/n9cCYEr7gF8uvY/wmGkqEi
	 PmuSEGwiQlipw0ThXrzYwa+jDqQoj+bcbOCcTcwcmHibSGq1zid3nrfThmk2upJTjh
	 G1Hetwq6wII0F3cwpJrvE1YwRvjRhA/4Gg8q9NTwPKYsXDBqFCTCLb2FSEAN96lqE1
	 rq3yR6XbderfGQLXvgkBaS7Z51i7zc6vDGwxsSYeXh2GlmRQefluWQuJ1X+Kq2YG9U
	 wmDqydDlG77aA==
Date: Mon, 27 Jul 2026 16:57:01 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/15] mm/rmap: index MAP_PRIVATE file-backed folios
 by virt pgoff
Message-ID: <amd9QR75eLNdgNU7@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <880981b5-ef79-4c9a-a8bd-7540002fcd15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880981b5-ef79-4c9a-a8bd-7540002fcd15@kernel.org>

On Mon, Jul 27, 2026 at 04:44:06PM +0200, David Hildenbrand (Arm) wrote:
> On 7/20/26 16:38, Lorenzo Stoakes (ARM) wrote:
> > In memory management we've managed to manufacture a great deal of confusion
> > around the concept of anonymous memory. We have:
> >
> > 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
> >    swap-backed (thus for reclaim purposes, treated as anonymous). These are
> >    simple enough.
> >
> > 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
> >    present in the page cache and mapped by an address_space object, but
> >    whose folios are also swap-backed (thus treated as anonymous for reclaim
> >    purposes).
> >
> > 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
> >    vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
> >    satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
> >    referencing a file, but are in every other sense anonymous, including the
> >    folios.
> >
> > 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
> >    and have file-backed folios until CoW'd, at which point those CoW'd
> >    folios are anonymous.
> >
> > This series fixes issues 3 and 4.
> >
> > In order for us to traverse VMAs using the reverse mapping, we require two
> > fields - folio->mapping and folio->index. The first tells the rmap code
> > where to look for VMAs, and the second tells it at which offset the folio
> > starts within the referenced object.
> >
> > For anonymous folios, folio->mapping points at an anon_vma object. For
> > file-backed folios, it points at an address_space. And:
> >
> > * For file-backed folios folio->index is simply the page offset of the start
> >   of the folio within the file.
> >
> > * For anonymous folios belonging to pure anon mappings, folio->index is
> >   equal to the virtual page offset of the folio.
> >
> > * For anonymous folios belonging to file-backed mappings (i.e. CoW'd folios
> >   of a MAP_PRIVATE file-backed mapping), folio->index is equal to the file
> >   page offset.
> >
> > This series establishes a new virtual page offset property of VMAs to
> > allow us to map anonymous folios at their virtual page offset, consistent
> > with pure anon.
>
> As raised off-list, I consider the "virtual page offset" concept hard to grasp.
>
> Maybe it's just me :)
>
> Skimming over the code, I read "vmg->anon_pgoff", which is pretty intuitive to
> me. Similarly vma_start_anon_pgoff() / vmg_end_anon_pgoff().
>
> Could we similarly just call this "anon_pgoff" /  "(linear) anon page index"
> even on the VMA level.

Yeah, I had originally done this.

I renamed it because I worried that people might be confused by references to
anon for file-backed VMA mappings.

But I think probably you're right that referring to it as virtual page offset
adds even more confusion vs. simply calling it anon. Will respin accordingly.


>
> IOW, in patch #9 for example:
>
> static inline pgoff_t linear_folio_page_index(const struct folio *folio,
>  					      const struct vm_area_struct *vma,
>  					      const unsigned long address)
>  {
> 	if (folio_test_anon(folio))
> +		return linear_anon_page_index(vma, address);
> +
>  	return linear_page_index(vma, address);
>  }

Ack yeah.

>
>
> Or is there another user for the the "virtual page offset" concept? I'd assume
> it's only used for anon folios (including KSM), but maybe I am missing some
> corner case.

No it was just fear of adding more confusion but seems by doing so I've done the
reverse of what I wanted :P

When I rework it if I notice anything that promotes this as a better solution
will ping otherwise will just rename on respin.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
