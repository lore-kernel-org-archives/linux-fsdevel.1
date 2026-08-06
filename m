Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71E329373;
	Thu,  6 Aug 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036744; cv=none; b=fHnnnl55xslg/CPuTGI/C32T2s4RNHq6nVJE62/3H+zmbk6rlNC3hKbHfj+fkGRfRkuwBmnFW2o+hpS2LtjuSMLWqDRNdd6syfqh1Q+v6ZjVWrWf7pID+yNJruo5qWoXGq+Tl44b4MBkiifu5Rar/FAzcKvh0SsZ8pDAurKtBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036744; c=relaxed/simple;
	bh=slq4Bj7jiOMCyV+sJSTo5EMRwhAsp72FaqZDVxgH6mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBi8PEI+o7c93jZd05Qbe4brM3gV3dvIVPE1E3cYVb80v5bgCGQx0jL9DneSGW2nn947aRxTR1xEN7kC+F4pFqk+//wTN0GXOJQK+Wsd7F4uM2SwoGDxOebOqD0udMXdwq79eRH0CvVzvaqQFeKZXNmMKAVyteGibUHSK1jhwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzMqYvoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzMqYvoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC81F000E9;
	Thu,  6 Aug 2026 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036742;
	bh=9DtZb8DjUtisjREwEwWOkrSi6943Av38G03foEcQ5Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzMqYvocxdfGC7/3077EFSOTpCiRyY/S///tKrAxuNSNHDGT7dYqW/ifw8C53hn08
	 bVPveNzCLYASrmi+XIBsRC5dHYyKhvnEgJ7RRYM5UaDV2ShMS3HdHOIYQxzooWczah
	 uJw3asizLGfuGO0yG4jMJvfxju5LTC8IkCj46t6HOZDaVyvG5nQFIzKvISEBW15ZX/
	 XVDkGY27+aumRkGCpa8T3TIyVNkiUEcqPO4IdulUjKtvDy+9OeQO2FwYjVdee+3WqU
	 ZXTOdK03H0E2NO+41f1dG8ICvMjqi5euq978ibaYowC2NC86ibx4uWtEdZmVVaYLX7
	 cxKyb9XkgRFWQ==
Date: Thu, 6 Aug 2026 18:18:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry@gourry.net>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
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
Subject: Re: [PATCH v3 04/15] mm: update print_bad_page_map() to show
 anonymous page index
Message-ID: <anTAk9V9ceYq1jyt@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
 <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
 <fec1be38-406d-4656-95eb-048729afec40@kernel.org>
 <anBqV9z6hVLIqoIn@lucifer>
 <anL0LEhb_bp_uQ1J@gourry-fedora-PF4VCD3F>
 <anL7eZcHnM5mPr_T@lucifer>
 <anS8UbQF1aE70gus@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anS8UbQF1aE70gus@casper.infradead.org>

On Thu, Aug 06, 2026 at 05:54:41PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 05, 2026 at 10:01:43AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Aug 05, 2026 at 04:30:18AM -0400, Gregory Price wrote:
> > > Yeah just an F/A in the print I suppose.  Sorry if that was unclear.
> > >
> > > If it saves someone the head-scratch of whether some bug is because it's
> > > "file" or "true anon", given the ambiguity here, seems like maybe useful
> > > debug information.
> >
> > Yeah will do on respin I think actually!
> >
> > I do think not providing that could result in some confusion like 'hm I
> > thought this was file-backed'.
>
> not sure it would.  Look at the whole thing:
>
>         pr_alert("BUG: Bad page map in process %s  %s:%08llx", current->comm,
>                  pgtable_level_to_str(level), entry);
>         __print_bad_page_map_pgtable(vma->vm_mm, addr);
>         if (page)
>                 dump_page(page, "bad page map");
>         pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>                  (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
>         pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
>                  vma->vm_file,
>                  vma->vm_ops ? vma->vm_ops->fault : NULL,
>                  vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
>                  vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
>                  mapping ? mapping->a_ops->read_folio : NULL);
>
> even if we don't have 'page' and thus dump_page() won't tell us
> anything, we look at mapping (NULL means true-anon, non-NULL means
> file, possibly COW).

Ohhhh ok. But you still can't tell whether what's actually mapped in a
MAP_PRIVATE file-backed mapping.

So I still think giving separate anon and file indexes is useful for debugging
purposes in that case because you might be debugging an rmap thing and the
ranges of linear indexes might be handy.

>
> > (We've made our lives hard with varying definitions of 'anon'
> > also... [shmem being 'anon in page cache' is especially lol] so it's
> > already confusing but there we go :)
>
> Woah, woah, woah.  Do *not* think of shmem as being anon-in-page-cache.
> shmem is a filesystem that happens to use swap to store its backing
> file.  I dislike a number of things about how it's implemented, but
> describing it as anon-in-page-cache is furthering the confusion.

I am not sure 'file system that happens to use swap to back it' is that much
clearer ;)

But that _at least_ uses different terminology and swap-backed is pretty clear.

But :)

Functionally it's PG_swapbacked and !folio_test_anon() and nothing calls
it anon, except... well reclaim! Which gates on folio_test_swapbacked() for the
'anon' LRU and refers to it as anon throughout vmscan.c...

My point here was we made our lives difficult with naming and yeah we do. We so
so do.

--
Cheers, Lorenzo
