Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274CB3955EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610283; cv=none; b=m5l8GQg/tkVMXtefIU7KS/tt/B/H/jZDQOwpiyd0RKh3cpEqw/Nj3x5U0a840Vr5tPU8EB6DRvuaKn4WtTcgQGZ4gQ5/WD1/YT3nyG1H4AOVIfU+f8hcae1ycMMgntXtkcS8QGroqrDHOX/CwPU5b2M7Kx8Ks4SJhklkNfi2ueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610283; c=relaxed/simple;
	bh=D+w3FELULQkWSOoPUdTpC4leLGXF7OjtbeLQHkoxWZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfEatAjNuoVJ6XqcFygg0vg5TL2/49epEbyhfX3AFlXsb3juuXNfE3q+ytDX+hu1ZGr131uZW/9w0rMaEZosU64UfXPul/iQcMNq851j7cSWxCA1AFwLUJyYEinnGZACD6xnfzAbJog79QzIhdM+k5ktPgQIGiP61r4+emQMasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fwp0GsOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fwp0GsOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E5A1F000E9;
	Thu, 13 Aug 2026 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610281;
	bh=ca01uEIiHk2U7cH1EK6em3TeFeZ9px5SBvC9vsSl3y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fwp0GsOYxOlbvRI+nGNIIPk3oum/0nIYSduBNoxMlNyNeSEhz7h44WLeFKj7ZHe8Q
	 UOA+UTiXu31BN4woz8qpI1JuVzEUPkk6ARXvHjr73+nlRN6xEtpsQQZ+1a3YjO3Xo9
	 7YT5zl6Jds4mefDxogM6fAj955oBPAxxC9baaVeE3p11uq9JhV5g2/AHlxZ3PT4ojT
	 Zgk3RRarwhG12ozFWZ+Vh0gOhZ5RKHgnwrAb5eUdv6AYBwbbcIbfa28MnFvIs9n/sv
	 0UmAkSjjAvMRFfsu2bxJqErLnXoeXVdyfOoJpwFAwgKhwSBAv4uZ05JcJ3lOvqBjSP
	 hPZz9uPuRJAnQ==
Date: Thu, 13 Aug 2026 09:37:41 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 00/15] Use generic_file_read_iter() in hugetlbfs
Message-ID: <an2B3q2apR0qrS_N@lucifer>
References: <20260805210557.1118966-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-1-willy@infradead.org>

On Wed, Aug 05, 2026 at 10:05:40PM +0100, Matthew Wilcox (Oracle) wrote:
> This set of patches are separated out from Jane's earlier series.
> https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/
>
> We need three things to use filemap_read_iter() instead of a hugetlbfs
> specific read_iter: hwpoison handling, treating gaps in the pagecache as
> holes, and having hugetlb set the folio size in the mapping.  hwopison
> handling turned out to need a lot of prep work; the other two things
> are fairly straightforward.
>
> Sashiko complains that the implementation of AS_AUTHORITATIVE is
> incomplete, but hugetlbfs doesn't use any of that functionality.
> We'll add it when we need it, either when hugetlbfs uses it, or when we
> convert shmem to use filemap.
>
> v8 here:
> https://lore.kernel.org/linux-mm/20260731200802.574821-1-willy@infradead.org/
>
> Changes from v7:
>  - Fix the KPF_HWPOISON blooper
>  - Expand HVO in a comment
>  - Collect R-b tags from Gregory & Jane
>
> Jane Chu (2):
>   filemap: Add hwpoison handling to filemap_read()
>   hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()
>
> Matthew Wilcox (Oracle) (13):
>   memory-failure: Fix hardware poison check in unpoison_memory() again
>   memory-failure: Prevent hugetlb freeing during unpoisoning
>   mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
>   hugetlb: Mark some function arguments as const
>   guest_memfd: Use folio_has_hwpoisoned_page()
>   kpageflags: Use is_page_hwpoison() to set KPF_HWPOISON
>   hugetlb: Move poison to pages before clearing hugetlb page type
>   hugetlb: Use the has_hwpoisoned flag
>   mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
>   mm: Check individual hugetlb pages for poison
>   filemap: Remove checks in mapping_set_folio_order_range()
>   hugetlb: Set mapping folio order
>   filemap: Add support for authoritative mappings
>
>  fs/Kconfig                 |   2 +-
>  fs/hugetlbfs/inode.c       | 123 +++--------------------
>  fs/proc/page.c             |   8 +-
>  include/linux/hugetlb.h    |  43 +++++---
>  include/linux/mm_types.h   |   4 +-
>  include/linux/page-flags.h |  64 ++++++++++--
>  include/linux/pagemap.h    |  45 +++++----
>  mm/Kconfig                 |   6 +-
>  mm/filemap.c               |  51 +++++++++-
>  mm/huge_memory.c           |   2 +-
>  mm/hugetlb.c               |  41 ++++----
>  mm/memory-failure.c        | 197 +++++++++++++++++++++++++------------
>  mm/memory_hotplug.c        |   2 +-
>  mm/rmap.c                  |  43 +++++---

Much as I'd like to not look at this, nor think about it, nor even admit that
any of this actually exists, I do co-maintain the rmap with David so please do
cc- me on future revisions :)

>  mm/shmem.c                 |   2 +-
>  mm/vmscan.c                |   2 +-
>  virt/kvm/guest_memfd.c     |   2 +-
>  17 files changed, 368 insertions(+), 269 deletions(-)
>
> --
> 2.47.3
>
>

--
Cheers, Lorenzo
