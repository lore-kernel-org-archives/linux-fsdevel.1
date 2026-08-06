Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016E3812DB;
	Thu,  6 Aug 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035408; cv=none; b=LRK9IUxe+PH0cgWBT4vfdSEa7pUcaYgwL/6CmSWwlLl95ikDKOF47BuCj/KF/cd+BgHVII6SUcbAtNtgmwMS1WR2JKvOY40WL2nnOAc8u+QgPGK5xNS6Uma2Gy0Wbv+HBqfyQdjaqjWtYeuF+y5T39ZaJ+Gi718I7riALw3SAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035408; c=relaxed/simple;
	bh=fs4OZSjxUz8gopfydd/fM3JYYKMAVuAHsrqd0PZgDG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+8gKdL/g6Z+7kGIMLRiS4VglXSOS6koNcPuQPgE2duACrrwsgKCJIMf3XPOiJA7XQyuemtrDcUCvmKTRe1J+2PsDXjgXrtzqHx2wX9o1eBRTAGUr8I0YEyVBTsSVM3SSSkbaxiFTs2RW0272LDxAZj4EPwnQ8JeNzWK2yEFTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NOHtkX6M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOHtkX6M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6oRZ7bVSXyuafN/Una/b4mH0BdxkEb9tpDXSUb5X6ns=; b=NOHtkX6MmsJFk0WyudbePHVb+Z
	ifpcELU49/bxvCXnPyti3zMDsf3vrEU1uxAk5TYIm/D1FmsoElU2FUYaQQhQ4LoovHo3rp7Vne63J
	YaH62vM9cItZaSIxWJvPMTb1bbL31lHBb0Cf1CDgA8fCz7g0C5l3D9Iv+z7K/HEZOk3iw5NNU2Q5w
	XWkjd05TJgdOjBOzSepKpZBB9dAo9D9Tq9Btj3KmOmB3/bcy+aFEvpv1v4RfKmy2Y8w71xUI4dBbm
	aLBAQDqgpuzc2KJRh2DXEL8L92qWHYySh/ECP6u6w7N7KhG1J+RoXQcK8AMm7hkIB1Cn6XNWew/k9
	8Zw2AsQg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws1Mg-0000000CA8T-02wp;
	Thu, 06 Aug 2026 16:54:42 +0000
Date: Thu, 6 Aug 2026 17:54:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/15] mm: update print_bad_page_map() to show
 anonymous page index
Message-ID: <anS8UbQF1aE70gus@casper.infradead.org>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
 <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
 <fec1be38-406d-4656-95eb-048729afec40@kernel.org>
 <anBqV9z6hVLIqoIn@lucifer>
 <anL0LEhb_bp_uQ1J@gourry-fedora-PF4VCD3F>
 <anL7eZcHnM5mPr_T@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anL7eZcHnM5mPr_T@lucifer>

On Wed, Aug 05, 2026 at 10:01:43AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 05, 2026 at 04:30:18AM -0400, Gregory Price wrote:
> > Yeah just an F/A in the print I suppose.  Sorry if that was unclear.
> >
> > If it saves someone the head-scratch of whether some bug is because it's
> > "file" or "true anon", given the ambiguity here, seems like maybe useful
> > debug information.
> 
> Yeah will do on respin I think actually!
> 
> I do think not providing that could result in some confusion like 'hm I
> thought this was file-backed'.

not sure it would.  Look at the whole thing:

        pr_alert("BUG: Bad page map in process %s  %s:%08llx", current->comm,
                 pgtable_level_to_str(level), entry);
        __print_bad_page_map_pgtable(vma->vm_mm, addr);
        if (page)
                dump_page(page, "bad page map");
        pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
                 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
        pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
                 vma->vm_file,
                 vma->vm_ops ? vma->vm_ops->fault : NULL,
                 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
                 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
                 mapping ? mapping->a_ops->read_folio : NULL);

even if we don't have 'page' and thus dump_page() won't tell us
anything, we look at mapping (NULL means true-anon, non-NULL means
file, possibly COW).

> (We've made our lives hard with varying definitions of 'anon'
> also... [shmem being 'anon in page cache' is especially lol] so it's
> already confusing but there we go :)

Woah, woah, woah.  Do *not* think of shmem as being anon-in-page-cache.
shmem is a filesystem that happens to use swap to store its backing
file.  I dislike a number of things about how it's implemented, but
describing it as anon-in-page-cache is furthering the confusion.

