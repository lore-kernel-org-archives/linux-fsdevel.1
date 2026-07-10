Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2495348C5C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693541; cv=none; b=KJftIlcshNgr5C+oUlFGQbx1UzkPxwqAu2VBN15dDX1mx0EHtWE8HqSdmwdA6RfomtZ7cdZsDe05JZDXkRFcRDRIyLYPtAg2vzvNUSgorWzpF0pwzcfkv4zvXoWxhu/vn7EXR96C0g00f/WjaLk+iqAVuRi+fPqplSGEJCd85Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693541; c=relaxed/simple;
	bh=XVflM+LNGOYBHFZueoklJtgP4+Olztt+5YzszSrFYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a26muVxQ23Ch6XhxYtC3iUy20MwtObi3Gn7cKi60aQ0On3j13pl53J3eBT38f9ks3JJNMlpcpowru6iHIUkWgE4f9czZjiUG+SeeiQKqCEU7XXIB+khGq2Xi6EDaKdl2ia/ToKcXv92PS4t1YyadjzJ5/aw1jwDvuff+6Zjne6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HrOLXIlJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HrOLXIlJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783693535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VlKCpo+tnRr2SOFJ9r1et+U9+XWbDNAx+XfTXQ4ZpM=;
	b=HrOLXIlJK5byvxMRl92Xt9Qe8BH9aa97sbTEINkk6Tl1g3pRas93d3bcKawXhxT4wPQSH2
	pUVy4GlMnPr0RDwlU+9UJT9dIuS7ZGqUPO7aQcEEzvGXQBanYYA0jXc9PaBax+GsITsfCw
	JKZWwia7gUFzCW5BmNzi7XeiOzZU9LU=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 00/10] Use generic_file_read_iter() in hugetlbfs
Date: Fri, 10 Jul 2026 07:25:16 -0700
Message-ID: <20260710142517.1022940-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-1-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:28 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This set of patches are separated out from Jane's earlier series.
> https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/
> 
> There's enough potentially controversial things in here that I think
> it's worth considering them by themselves.  First, handling hwpoison
> in filemap_read().  I want this for shmem as well as for hugetlbfs (a
> later patchset, maybe).  Second, handling misses in the pagecache as
> holes rather than opportunities to populate the pagecache.
> 
> v1 here: https://lore.kernel.org/linux-mm/20260707181713.208282-1-willy@infradead.org/
> Sashiko had a lot of valuable feedback on that, and that's all addressed
> here except for the things that I don't think are relevant.
> 
> Jane Chu (2):
>   filemap: Add hwpoison handling to filemap_read()
>   hugetlb: replace hugetlbfs_read_iter() with generic_file_read_iter()
> 
> Matthew Wilcox (Oracle) (8):
>   mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
>   hugetlb: Mark some function arguments as const
>   filemap: Remove checks in mapping_set_folio_order_range()
>   hugetlb: Set mapping folio order
>   memory-failure: Remove raw_hwp_list_head()
>   memory-failure: Prevent UAF in raw_hwp_page list
>   mm: Handle hugetlb correctly in is_page_hwpoison()
>   filemap: Add support for authoritative mappings
> 
>  fs/hugetlbfs/inode.c       | 122 ++++---------------------------------

I really like the deletions here in hugetlbfs :)

>  include/linux/hugetlb.h    |  24 +++-----
>  include/linux/mm_types.h   |   4 +-
>  include/linux/page-flags.h |  28 ++++++---
>  include/linux/pagemap.h    |  32 +++++-----
>  mm/filemap.c               |  46 +++++++++++++-
>  mm/huge_memory.c           |   2 +-
>  mm/hugetlb.c               |   2 +-
>  mm/memory-failure.c        |  39 ++++++------
>  mm/memory_hotplug.c        |   2 +-
>  mm/shmem.c                 |   2 +-
>  mm/vmscan.c                |   2 +-
>  12 files changed, 128 insertions(+), 177 deletions(-)
> 
> -- 
> 2.47.3
> 
> 
