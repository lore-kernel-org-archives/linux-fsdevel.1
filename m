Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE13AFD0A;
	Thu, 30 Jul 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406609; cv=none; b=jd4wTaoBqTiaJZ6DQgp897Ohm6b51UujIdZwVLL6v42640uBB8OcotFf2OD3JRyl6+ChoCHwOwjjvhWh+mudauSO0DS2Fxt3eRLEDSrns1WNFG64U35zDybCEMCdxUYVOA5s+Wyi9RJtD+YmStylIzX0u8neGzBSNafOK1YtToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406609; c=relaxed/simple;
	bh=PB+uLhBhuVi2eHOCqB5NdYV/HZin1iTUIdENJCq0MnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG1q+0TEjUoXMr7TY5oQgulS/GlpRkJJFMZuhIZYQ/HoMSutIEBHXGSaiFD1i3pt24y8N1DMCaQSoyTC2HQNHU2z3NuYEq1n1wfhNeCcwCYHOCUREvUfCrBar66LNe9rC9xDcB2YjGOtvOVR9arrpreb9lEFVLhPqQF1Vs8zAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gicFi79A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gicFi79A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F2D1F000E9;
	Thu, 30 Jul 2026 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406607;
	bh=jY7VtAKWV/98Ym8QzylyCgqneeBfbLyDYEdBY8MaJjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gicFi79A1plyT5Ti6H4RX8MMHL+IUzcvhaDxk+855KtXagGlz88zpfpsLlMy6qiWp
	 KrMOEXmTZ9YJV8WurjO/RePpEPPCJFTrJYf4zkVCmofvO9P9CYTZZGtQsmkbmkyviF
	 4P3QQ9cB7b3pi9ZzhJ7V+wJasty4ReS8mTQzt2zhu1rim+TbsQVxlDGF+wZ7ZougrS
	 vXPQ+mv6Wb4YXCTWJLRoTOJzjKraalZtYoo0h7uc0Ln8jxlGGUaZTbSsRQumeclcX2
	 aLHXyf2rM3HWXJlUX2XrOB52z8JLwApbZUFOu/q2n4aD283FkJYC0jCY1hRrVWDMD1
	 oM+G+hzJQ9LGg==
Date: Thu, 30 Jul 2026 11:16:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 03/15] mm: abstract vma_address() and introduce
 vma_anon_address()
Message-ID: <amskFlOFd7l-VRpQ@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-3-e8ecfefea812@kernel.org>
 <amrV0Y7ZUtihiB2B@gourry-fedora-PF4VCD3F>
 <amrw2v7TVl_AG5_3@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrw2v7TVl_AG5_3@gourry-fedora-PF4VCD3F>

On Thu, Jul 30, 2026 at 02:39:27AM -0400, Gregory Price wrote:
> On Thu, Jul 30, 2026 at 12:58:22AM -0400, Gregory Price wrote:
> > On Wed, Jul 29, 2026 at 05:48:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >
> > > This will be necessary for determining the address of a folio's index
> > > within a VMA when the folio belongs to a MAP_PRIVATE file-backed VMA but
> > > has been CoW'd, and thus is anonymous, once the anonymous VMA page offset
> > > field is used for the reverse mapping.
> > >
> >
> > This is a doozy of a sentence...
> >
> > ... determines the address of a folio's index within a VMA when
> >   - the folio belongs to a MAP_PRIVATE file-backed VMA, but
> >   - <The VMA> has been cow'd
> >   - thus <The CoW'd VMA> is anonymous (as well)
> >   - The original VMA may or may not also be marked anonymous?
> >     (just clarifying, could be original mapper or a COW that COWs)
> >
> > Ow, my brain.  One question below
> >
>
> After re-reading the cover-letter again - my note here is wrong and
> my brain hurts more.
>
> ... determines the address of a folio's index within a VMA when
>   - the folio belongs to a MAP_PRIVATE file-backed VMA, but
>   - <The Folio> has been CoW'd
>   - thus <The CoW'd Folio> is <now marked> anonymous
>   - The original folio may or may not have been anonymous
>     (depending on whether it, itself, was a CoW copy)

Yeah :) this message is meant to be effectively a placeholder for 'there's a
good reason for doing this' :) I go to greater lengths to explain in the bits
that actually implement it.

>
> Lorenzo you are truly doing Darwin's work untangling all of this.

Thanks :)

This is really painful stuff and trying to get to scalable CoW the 'right way'
(i.e. several series and probably 3 figures of patches) is a slog, but once in
place will be worthwhile (and also save a bunch of memory :)

>
> ~Gregory
