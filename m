Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B446239E80;
	Wed, 18 Mar 2026 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796632; cv=none; b=Igj8NJah1y3lWyYs4imkDvyLOqZOAuoIaU1rMzroX4ZfU5CmpAe777Uu5ovV4Ig9UWXETWtkKz/lpCkgUl1dhBaFt9+5Unra3wDb6we7kAy7dJdcX2XSd3dma7j87sSZTbDuqFwR652ikF1SXiCnVQmrbaIvKeDhXHdUM9i+bS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796632; c=relaxed/simple;
	bh=zfiZ6yg/RDm5ORqBTaz3ULaGWHpbcmVS/yUvMdy0OCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+EhotX43G5zPB/dvryNEuRl4T0IanB+SYAIyqpbKTfngk6WALEN4a0CFR5myOt8fHZZAC4RlulZgaWEax8t+rWk5DcydXfWa93OVG0pHkHfEpTpmxPEOdaXGX8eC8TEmk8TmfrfBb7MkbGdAcU7UP+baJRwzNj5ANudiH28oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kQyz6gWc; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kQyz6gWc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773796626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n76Vl/YByYovXpfiSJaIiV6BYs7tkM/M9VUvPvWWK24=;
	b=kQyz6gWc7l7c3ghG63xpjO1EVFSzIw0WaG2cXNpT2nlLpYegR6DD/VxMLs3HdP1JKMEgJpVBcTaVVfmAnfm53vlNoHZuE4jG3SpO09hW7975u3x/rGQ5PzQTuAWIfFTkG15KFZjrVIrJcFtagPIz0GgFHuauI69LfHAkKmShJAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.CWN2v_1773796625;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.CWN2v_1773796625 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 09:17:06 +0800
Message-ID: <dd67c771-8530-40d7-93c3-cd6f405c32dd@linux.alibaba.com>
Date: Wed, 18 Mar 2026 09:17:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: filemap: fix nr_pages calculation overflow in
 filemap_map_pages()
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: lorenzo.stoakes@oracle.com, kas@kernel.org, p.raghav@samsung.com,
 mcgrof@kernel.org, dhowells@redhat.com, djwong@kernel.org, hare@suse.de,
 da.gomez@samsung.com, dchinner@redhat.com, brauner@kernel.org,
 xiangzao@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1cf1ac59018fc647a87b0dad605d4056a71c14e4.1773739704.git.baolin.wang@linux.alibaba.com>
 <9d968181-95a9-477e-9aa0-763117e4d1a0@kernel.org>
 <82019011-023c-4bce-a524-6eab119f0a4a@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <82019011-023c-4bce-a524-6eab119f0a4a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/26 4:49 AM, David Hildenbrand (Arm) wrote:
> On 3/17/26 10:37, David Hildenbrand (Arm) wrote:
>> On 3/17/26 10:29, Baolin Wang wrote:
>>> When running stress-ng on my Arm64 machine with v7.0-rc3 kernel, I encountered
>>> some very strange crash issues showing up as "Bad page state":
>>>
>>> "
>>> [  734.496287] BUG: Bad page state in process stress-ng-env  pfn:415735fb
>>> [  734.496427] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x4cf316 pfn:0x415735fb
>>> [  734.496434] flags: 0x57fffe000000800(owner_2|node=1|zone=2|lastcpupid=0x3ffff)
>>> [  734.496439] raw: 057fffe000000800 0000000000000000 dead000000000122 0000000000000000
>>> [  734.496440] raw: 00000000004cf316 0000000000000000 0000000000000000 0000000000000000
>>> [  734.496442] page dumped because: nonzero mapcount
>>> "
>>>
>>> After analyzing this page’s state, it is hard to understand why the mapcount
>>> is not 0 while the refcount is 0, since this page is not where the issue first
>>> occurred. By enabling the CONFIG_DEBUG_VM config, I can reproduce the crash as
>>> well and captured the first warning where the issue appears:
>>>
>>> "
>>> [  734.469226] page: refcount:33 mapcount:0 mapping:00000000bef2d187 index:0x81a0 pfn:0x415735c0
>>> [  734.469304] head: order:5 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> [  734.469315] memcg:ffff000807a8ec00
>>> [  734.469320] aops:ext4_da_aops ino:100b6f dentry name(?):"stress-ng-mmaptorture-9397-0-2736200540"
>>> [  734.469335] flags: 0x57fffe400000069(locked|uptodate|lru|head|node=1|zone=2|lastcpupid=0x3ffff)
>>> ......
>>> [  734.469364] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1),
>>> const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *:
>>> (struct folio *)_compound_head(page + nr_pages - 1))) != folio)
>>> [  734.469390] ------------[ cut here ]------------
>>> [  734.469393] WARNING: ./include/linux/rmap.h:351 at folio_add_file_rmap_ptes+0x3b8/0x468,
>>> CPU#90: stress-ng-mlock/9430
>>> [  734.469551]  folio_add_file_rmap_ptes+0x3b8/0x468 (P)
>>> [  734.469555]  set_pte_range+0xd8/0x2f8
>>> [  734.469566]  filemap_map_folio_range+0x190/0x400
>>> [  734.469579]  filemap_map_pages+0x348/0x638
>>> [  734.469583]  do_fault_around+0x140/0x198
>>> ......
>>> [  734.469640]  el0t_64_sync+0x184/0x188
>>> "
>>>
>>> The code that triggers the warning is: "VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio)",
>>> which indicates that set_pte_range() tried to map beyond the large folio’s
>>> size.
>>>
>>> By adding more debug information, I found that 'nr_pages' had overflowed in
>>> filemap_map_pages(), causing set_pte_range() to establish mappings for a range
>>> exceeding the folio size, potentially corrupting fields of pages that do not
>>> belong to this folio (e.g., page->_mapcount).
>>>
>>> After above analysis, I think the possible race is as follows:
>>>
>>> CPU 0                                                  CPU 1
>>> filemap_map_pages()                                   ext4_setattr()
>>>     //get and lock folio with old inode->i_size
>>>     next_uptodate_folio()
>>>
>>>                                                            .......
>>>                                                            //shrink the inode->i_size
>>>                                                            i_size_write(inode, attr->ia_size);
>>>
>>>     //calculate the end_pgoff with the new inode->i_size
>>>     file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
>>>     end_pgoff = min(end_pgoff, file_end);
>>>
>>>     ......
>>>     //nr_pages can be overflowed, cause xas.xa_index > end_pgoff
>>>     end = folio_next_index(folio) - 1;
>>>     nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
>>>
>>>     ......
>>>     //map large folio
>>>     filemap_map_folio_range()
>>>                                                            ......
>>>                                                            //truncate folios
>>>                                                            truncate_pagecache(inode, inode->i_size);
>>>
>>> To fix this issue, move the 'end_pgoff' calculation before next_uptodate_folio(),
>>> so the retrieved folio stays consistent with the file end to avoid 'nr_pages'
>>> calculation overflow. After this patch, the crash issue is gone.
>>>
>>
>> Thanks!
>>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for reviewing.

> I just skimmed over the AI review:
> 
> https://sashiko.dev/#/patchset/1cf1ac59018fc647a87b0dad605d4056a71c14e4.1773739704.git.baolin.wang%40linux.alibaba.com

Thanks. Zi Yan also sent me the AI-generated comments, and I don’t think 
this is an issue.

> And I'm not sure if it has a point, in particular whether
> i_size_read(mapping->host) could return 0 and underflow file_end.
> 
> I'd assume, in that case (truncation succeeded), also the
> next_uptodate_folio() would fail.

Yes. If truncation has succeeded, next_uptodate_folio() cannot find a 
folio. If called before truncation, next_uptodate_folio() also checks 
i_size_read(mapping->host) and returns NULL:

max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
if (xas->xa_index >= max_idx)
	goto unlock;

So I don't think this will cause a real issue if 
i_size_read(mapping->host) returns 0.
