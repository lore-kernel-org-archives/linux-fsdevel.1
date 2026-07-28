Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0674440A03;
	Tue, 28 Jul 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246068; cv=none; b=ZTQPFOLlXmwJEyMrYktNpDT7ImAx85vzfqWY0uSVzkb0DQjl2plU+2WO4gbXDN08grJWGjMKr6+BzFchSf7bVSX1rx52kVj+Z0IWNUN7lM+skaYKScRldArOpFMnZeW0ilbzF51am8MmnTCx3bnY/JOMit5I0z0f0fXVwcz9TZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246068; c=relaxed/simple;
	bh=d519tbNUY1zX6k442JW0TgBR7NVbPaiBhL5Lk+UuOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZuAe9Nc5wjH4GayrZc6m355TY8DMWcD43+gOGxiXFnyZp3AAp4EDutJRpWgFC7+bkLMeFwed+GXjDcZ3Q241Gmqxg7zrUBEB6wFtPvUHWBCrEnkWeUp+dgo1A3YF016puh830n5HZy8qH7mgYDodyaCmcBR3a/4HHvDiBMOkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6rCQrh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6rCQrh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50981F000E9;
	Tue, 28 Jul 2026 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785246066;
	bh=HEMU2TmSwsqrUTy8ZEKYu9Ae0PHGeT+f/ud0LSQJwt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U6rCQrh5cCM83BFeZR9/Qvz6ZbhtwuYWaehIe+rVPnqsrpeoZxZ7B10TBBl8W6i2v
	 bNl8xdz3N7EGPECsNHEUwcq7V6eXM065C3EsgL84YXJLnqzq6/63+lR4ajgwFmWjia
	 JkPs+1kKRodOHGdKHGtsSMAqqnX55EzHnTzrwhr6R+NPj/XCwR1rYWbkoP2dlqZOty
	 fHKBsYlxdrZfaBsgyDoTQfTbzFICpH6JzdT1q8XsyCZQSIbVk30IicsnJBR+9DqOCg
	 GcNUnIcJVMkBfM1LBlYvBh6QQsY2EOWD4OvET/dMUu0/DjKekDYnPntoQpf0AZbORa
	 tMd75YGtaicKw==
Date: Tue, 28 Jul 2026 14:40:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
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
Message-ID: <amiwjyQr5l6O96Hk@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <880981b5-ef79-4c9a-a8bd-7540002fcd15@kernel.org>
 <amd9QR75eLNdgNU7@lucifer>
 <ameAekveMOcP7ffQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ameAekveMOcP7ffQ@casper.infradead.org>

On Mon, Jul 27, 2026 at 04:59:54PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2026 at 04:57:01PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Jul 27, 2026 at 04:44:06PM +0200, David Hildenbrand (Arm) wrote:
> > > On 7/20/26 16:38, Lorenzo Stoakes (ARM) wrote:
> > > > In memory management we've managed to manufacture a great deal of confusion
> > > > around the concept of anonymous memory. We have:
> > > >
> > > > 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
> > > >    swap-backed (thus for reclaim purposes, treated as anonymous). These are
> > > >    simple enough.
> > > >
> > > > 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
> > > >    present in the page cache and mapped by an address_space object, but
> > > >    whose folios are also swap-backed (thus treated as anonymous for reclaim
> > > >    purposes).
> > > >
> > > > 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
> > > >    vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
> > > >    satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
> > > >    referencing a file, but are in every other sense anonymous, including the
> > > >    folios.
> > > >
> > > > 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
> > > >    and have file-backed folios until CoW'd, at which point those CoW'd
> > > >    folios are anonymous.
> > > >
> > > > This series fixes issues 3 and 4.
> > > >
> > > > In order for us to traverse VMAs using the reverse mapping, we require two
> > > > fields - folio->mapping and folio->index. The first tells the rmap code
> > > > where to look for VMAs, and the second tells it at which offset the folio
> > > > starts within the referenced object.
> > > >
> > > > For anonymous folios, folio->mapping points at an anon_vma object. For
> > > > file-backed folios, it points at an address_space. And:
> > > >
> > > > * For file-backed folios folio->index is simply the page offset of the start
> > > >   of the folio within the file.
> > > >
> > > > * For anonymous folios belonging to pure anon mappings, folio->index is
> > > >   equal to the virtual page offset of the folio.
> > > >
> > > > * For anonymous folios belonging to file-backed mappings (i.e. CoW'd folios
> > > >   of a MAP_PRIVATE file-backed mapping), folio->index is equal to the file
> > > >   page offset.
> > > >
> > > > This series establishes a new virtual page offset property of VMAs to
> > > > allow us to map anonymous folios at their virtual page offset, consistent
> > > > with pure anon.
> > >
> > > As raised off-list, I consider the "virtual page offset" concept hard to grasp.
> > >
> > > Maybe it's just me :)
> > >
> > > Skimming over the code, I read "vmg->anon_pgoff", which is pretty intuitive to
> > > me. Similarly vma_start_anon_pgoff() / vmg_end_anon_pgoff().
> > >
> > > Could we similarly just call this "anon_pgoff" /  "(linear) anon page index"
> > > even on the VMA level.
> >
> > Yeah, I had originally done this.
> >
> > I renamed it because I worried that people might be confused by references to
> > anon for file-backed VMA mappings.
> >
> > But I think probably you're right that referring to it as virtual page offset
> > adds even more confusion vs. simply calling it anon. Will respin accordingly.
>
> Would the term "logical page offset" be helpful?
>
> I already use this in my description of folios:
>
>  * A folio is a physically, virtually and logically contiguous set
>  * of bytes.  It is a power-of-two in size, and it is aligned to that
>  * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
>  * in the page cache, it is at a file offset which is a multiple of that
>  * power-of-two.  It may be mapped into userspace at an address which is
>  * at an arbitrary page offset, but its kernel virtual address is aligned
>  * to its size.
>

Thanks, I was kinda getting at this sort of thing, and I did think 'virtual page
offset' was a fairly common term of art, but as often with these things you go
and look to check later and realise that maybe it's not :P

I think overall it's probably easier to go to anon everywhere, I'll eyeball it
when done and make sure it's sane though!

Cheers, Lorenzo
