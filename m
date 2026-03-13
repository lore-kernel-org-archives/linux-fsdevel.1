Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42707201113;
	Fri, 13 Mar 2026 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378716; cv=none; b=A+XoYJBghqrErVYOswygif5PPlvBhonWi1uBeuadACBhski3GfbbeeTuBfzV3BYfAq9MOb5qjFesE/e16zZt3SAJpkFoTtYxPC2O9tM5Klll+dViomJuUWDi3kn3Bm6mX6l820ZgMJZnghCBNGm16tpgwkA0BMSHocKfq9rFKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378716; c=relaxed/simple;
	bh=q+lQQcrFgbLzIQgm9vnEFHsfhIBoC6di6u5RmsM4Vds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBJIxxhNusFdcm9QoK6rN4eHr4jEJjQCOBWcDgya/8Lu8kD3+GHf+Kx3xK+niC1u7uEbJk/ywvutiVPg3/xHcBmN0S4g9Up/r9hUwap+Ed/omnu8DJfMKmrrWFHaMznmqE4t3r7e83reUo1NnuG4yoe7gplhxOyxS8nA34jokq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE36165C;
	Thu, 12 Mar 2026 22:11:46 -0700 (PDT)
Received: from [10.164.19.59] (unknown [10.164.19.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3853F694;
	Thu, 12 Mar 2026 22:11:48 -0700 (PDT)
Message-ID: <0890a207-354e-4da1-80c2-67754354a6a6@arm.com>
Date: Fri, 13 Mar 2026 10:41:45 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: filemap: fix nr_pages calculation overflow in
 filemap_map_pages()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: david@kernel.org, lorenzo.stoakes@oracle.com, kas@kernel.org,
 p.raghav@samsung.com, mcgrof@kernel.org, dhowells@redhat.com,
 djwong@kernel.org, hare@suse.de, da.gomez@samsung.com, dchinner@redhat.com,
 brauner@kernel.org, xiangzao@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <066dd2e947ccc1c304b54e847fbe628dccea1d7c.1773370126.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <066dd2e947ccc1c304b54e847fbe628dccea1d7c.1773370126.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/26 9:15 am, Baolin Wang wrote:
> When running stress-ng on my Arm64 machine with v7.0-rc3 kernel, I encountered
> some very strange crash issues showing up as "Bad page state":
> 
> "
> [  734.496287] BUG: Bad page state in process stress-ng-env  pfn:415735fb
> [  734.496427] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x4cf316 pfn:0x415735fb
> [  734.496434] flags: 0x57fffe000000800(owner_2|node=1|zone=2|lastcpupid=0x3ffff)
> [  734.496439] raw: 057fffe000000800 0000000000000000 dead000000000122 0000000000000000
> [  734.496440] raw: 00000000004cf316 0000000000000000 0000000000000000 0000000000000000
> [  734.496442] page dumped because: nonzero mapcount
> "
> 
> After analyzing this page’s state, it is hard to understand why the mapcount
> is not 0 while the refcount is 0, since this page is not where the issue first
> occurred. By enabling the CONFIG_DEBUG_VM config, I can reproduce the crash as
> well and captured the first warning where the issue appears:
> 
> "
> [  734.469226] page: refcount:33 mapcount:0 mapping:00000000bef2d187 index:0x81a0 pfn:0x415735c0
> [  734.469304] head: order:5 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  734.469315] memcg:ffff000807a8ec00
> [  734.469320] aops:ext4_da_aops ino:100b6f dentry name(?):"stress-ng-mmaptorture-9397-0-2736200540"
> [  734.469335] flags: 0x57fffe400000069(locked|uptodate|lru|head|node=1|zone=2|lastcpupid=0x3ffff)
> ......
> [  734.469364] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1),
> const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *:
> (struct folio *)_compound_head(page + nr_pages - 1))) != folio)
> [  734.469390] ------------[ cut here ]------------
> [  734.469393] WARNING: ./include/linux/rmap.h:351 at folio_add_file_rmap_ptes+0x3b8/0x468,
> CPU#90: stress-ng-mlock/9430
> [  734.469551]  folio_add_file_rmap_ptes+0x3b8/0x468 (P)
> [  734.469555]  set_pte_range+0xd8/0x2f8
> [  734.469566]  filemap_map_folio_range+0x190/0x400
> [  734.469579]  filemap_map_pages+0x348/0x638
> [  734.469583]  do_fault_around+0x140/0x198
> ......
> [  734.469640]  el0t_64_sync+0x184/0x188
> "
> 
> The code that triggers the warning is: "VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio)",
> which indicates that set_pte_range() tried to map beyond the large folio’s
> size.
> 
> By adding more debug information, I found that 'nr_pages' had overflowed in
> filemap_map_pages(), causing set_pte_range() to establish mappings for a range
> exceeding the folio size, potentially corrupting fields of pages that do not
> belong to this folio (e.g., page->_mapcount).
> 
> After above analysis, I think the possible race is as follows:
> 
> CPU 0                                                  CPU 1
> filemap_map_pages()                                   ext4_setattr()
>    //get and lock folio with old inode->i_size
>    next_uptodate_folio()
> 
>                                                           .......
>                                                           //shrink the inode->i_size
>                                                           i_size_write(inode, attr->ia_size);
> 
>    //calculate the end_pgoff with the new inode->i_size
>    file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
>    end_pgoff = min(end_pgoff, file_end);
> 
>    ......
>    //nr_pages can be overflowed, cause xas.xa_index > end_pgoff
>    end = folio_next_index(folio) - 1;
>    nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
> 
>    ......
>    //map large folio
>    filemap_map_folio_range()
>                                                           ......
>                                                           //truncate folios
>                                                           truncate_pagecache(inode, inode->i_size);
> 
> To fix this issue, move the 'end_pgoff' calculation before next_uptodate_folio(),
> so the retrieved folio stays consistent with the file end to avoid 'nr_pages'
> calculation overflow. After this patch, the crash issue is gone.
> 
> Fixes: 743a2753a02e ("filemap: cap PTE range to be created to allowed zero fill in folio_map_range()")
> Reported-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/filemap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bc6775084744..923d28e59642 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3879,14 +3879,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	unsigned int nr_pages = 0, folio_type;
>  	unsigned short mmap_miss = 0, mmap_miss_saved;
>  
> +	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> +	end_pgoff = min(end_pgoff, file_end);
> +
>  	rcu_read_lock();
>  	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
>  	if (!folio)
>  		goto out;
>  
> -	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> -	end_pgoff = min(end_pgoff, file_end);
> -
>  	/*
>  	 * Do not allow to map with PMD across i_size to preserve
>  	 * SIGBUS semantics.

I am wondering whether something similar can happen in the do-while loop
below this code. We can retrieve a folio from next_uptodate_folio, and
then a massive truncate happens and we end up mapping a large folio
into the pagetables beyong i_size, violating SIGBUS semantics. (truncation
may back-off seeing the locked folio/increased refcount in filemap_map_pages)



