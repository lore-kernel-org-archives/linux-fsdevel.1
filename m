Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9E46C4BF;
	Fri,  9 Oct 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528394; cv=none; b=IZz13OAT6vjyx6R+qRxFUMDnA30MsbgecK4+g01TQU/yuvINsEWAK4xNHIoHBOj+tsQ3D1y9Ccr0aYcJ4SZPGQlLn7iUPLnT8uPEx+zIqIqkS3yETeUZ2uQZBOip7TXCaIqtNv5JJN9VWEaMWVrEzNSXuSSC6cdvCd7rzKdJMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528394; c=relaxed/simple;
	bh=dlY3yFfM2QAMxT65i2r5NnPCMBMFXG5ZIXM8ycYAewY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bdw/lnq0cfCI/AicQr1lZqJ/dKgqvOOQ7755icZKur5w6bBV+B1jLK1guFLQg1z9E+nENh62z1Whdz9baIDs6+6nmwWlbjozUkLwxDtEmyXfwzPaFjM1qsICI5EGgMZKBUwz4RZfpM3HgMP3YuUgSNILfx3x74cAVKrtYdV6/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AKKN8lST; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AKKN8lST"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791528381; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LoVx2R5PChUvqrXRet/NFBqBIchEhynSZ3ARypBye7Q=;
	b=AKKN8lSTU2LpoNaJKW3gPwn6QEjA2sHAc78IlJRong9dhBDrZ3/5Dg4Kl14eac+YYHNFIImkNm1lNQNe9eLFVUV3E3ESTOJlabX+MftnCuZazLLu1AdqAyJ0MES1wG/M1KSW6W9KmJ1FrKW+AoxEuAr0eFTTxYkvH62NQWYXmAA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XCSZjHs_1791528378;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCSZjHs_1791528378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 14:46:19 +0800
Message-ID: <fbb046b9-be48-42d8-96b3-7e554484b625@linux.alibaba.com>
Date: Fri, 9 Oct 2026 14:46:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
 <20260925053027.1998394-1-ayushr@modal.com>
 <20260925065013.3682431-1-ayushr@modal.com>
 <20261003033107.1488699-1-ayushr@modal.com>
 <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
 <fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 5:24 PM, Jan Kara wrote:
> On Sun 04-10-26 22:28:31, Andrew Morton wrote:
>> On Sat,  3 Oct 2026 03:31:03 +0000 Ayush Ranjan <ayushr@modal.com> wrote:
>>> Gentle ping on this. The reproducer in my previous mail [1] triggers
>>> "Bad page cache ... still mapped when deleted" on 6.18.46 within a
>>> couple of minutes on a 128-CPU bare-metal box, with no fork() and no
>>> gVisor involved.
>>>
>>> We continue to hit this in production at low frequency, so I am happy
>>> to test patches or collect more data if that would help.
>>>
>>
>> fwiw I made gpt and gemini argue about this for a while and ended up
>> with the below.
> 
> Worth a try I guess. Let's see :)
> 
>> From: Andrew Morton <akpm@linux-foundation.org>
>> Subject: mm: shmem: serialize fault-around against hole punching
>> Date: Sun Oct 4 09:05:31 PM PDT 2026
>>
>> shmem uses filemap_map_pages() for fault-around.  Unlike shmem_fault(),
>> filemap_map_pages() does not participate in shmem's fallocate exclusion
>> protocol.
>>
>> During a partial hole punch of a large shmem folio, the folio can be split
>> and the resulting smaller folios can remain temporarily visible in the page
>> cache while shmem_undo_range() restarts its walk.  Fault-around can then map
>> one of those folios again before the hole-punch path removes it.
>>
>> shmem_undo_range() may subsequently delete that folio from the page cache
>> despite the new userspace mapping.  This can trigger "still mapped when
>> deleted" warnings and leave stale mappings or inconsistent RSS/page-table
>> accounting behind.
> 
> So this part of explanation is either incomplete or wrong in my opinion.
> Yes, shmem_undo_range() calls truncate_inode_partial_folio() which can
> split a large folio. Yes, filemap_map_pages() can map those pages back into
> page tables. But how "shmem_undo_range() may subsequently delete that folio
> from the page cache despite the new userspace mapping" happens is unclear
> to me. After splitting a folio, shmem_undo_range() will restart and find the
> newly split (and mapped) folios and calls truncate_inode_folio() to get rid
> of them. Now truncate_inode_folio() calls truncate_cleanup_folio() which
> does:
> 
>          if (folio_mapped(folio))
>                  unmap_mapping_folio(folio);
> 
> so the mapping is reliably removed under folio lock. Can you perhaps push
> your agents further to explain in more detail how this "still mapped when
> deleted" happens in their opinion?

Good point and I think you are right.

Yesterday I quickly reproduced the issue with Ayush's reproducer, and I 
got the following crash info. From the dump message, we can see that 
truncate_inode_folio() is really trying to remove mapped folios, which 
is incorrect.

I also quickly tried Andrew's patch, and the issue no longer reproduces, 
so I initially thought that was the root cause. But after your reminder, 
I now believe Andrew's patch merely workaround the issue rather than 
fixing the actual root cause.

Today I'm going to re-analyze the race with the reproducer (thanks Ayush).

After analysis, I believe the race exists between truncation and 
MADV_DONTNEED, and shmem's fault_around() merely makes the issue easier 
to reproduce. Since MADV_DONTNEED synchronously releases the pagetable 
page before calling tlb_flush_rmaps(), this could cause another thread's 
truncation to skip zap_pte_range() but still observe the folio's 
mapcount as non-zero. A possible race scenario is as follows:

CPU 0				CPU 1
				madvise_dontneed_single_vma
shmem_fallocate			......
   ......			  zap_pte_range
   truncate_inode_folio		    zap_empty_pte_table(pmd clear)		
     unmap_mapping_folio		
     ......
       zap_pmd_range(saw pmd none)
     filemap_remove_folio
        BUG_ON(folio_mapped)
				    tlb_flush_rmaps

Based on the above race analysis, I made the following fix that uses the 
PMD lock synchronously to prevent this race, and the issue no longer 
reproduces. I will clean it up and send out a formal patch.

diff --git a/mm/memory.c b/mm/memory.c
index 6a8e7772b8d6..2039ada99b64 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2036,6 +2036,15 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
                 }
         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);

+       add_mm_rss_vec(mm, rss);
+       lazy_mmu_mode_disable();
+
+       /* Do the actual TLB flush before dropping ptl */
+       if (force_flush) {
+               tlb_flush_mmu_tlbonly(tlb);
+               tlb_flush_rmaps(tlb, vma);
+       }
+
         /*
          * Fast path: try to hold the pmd lock and unmap the PTE page.
          *
@@ -2046,15 +2055,6 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
          */
         if (can_reclaim_pt && direct_reclaim && addr == end)
                 direct_reclaim = zap_empty_pte_table(mm, pmd, ptl, 
&pmdval);
-
-       add_mm_rss_vec(mm, rss);
-       lazy_mmu_mode_disable();
-
-       /* Do the actual TLB flush before dropping ptl */
-       if (force_flush) {
-               tlb_flush_mmu_tlbonly(tlb);
-               tlb_flush_rmaps(tlb, vma);
-       }
         pte_unmap_unlock(start_pte, ptl);

         /*
@@ -2103,7 +2103,6 @@ static inline unsigned long zap_pmd_range(struct 
mmu_gather *tlb,
                         }
                         /* fall through */
                 } else if (details && details->single_folio &&
-                          folio_test_pmd_mappable(details->single_folio) &&
                            next - addr == HPAGE_PMD_SIZE && 
pmd_none(*pmd)) {
                         sync_with_folio_pmd_zap(tlb->mm, pmd);
                 }


[  189.171977] page: refcount:3 mapcount:1 mapping:00000000fe168ee1 
index:0x3880 pfn:0x191647
[  189.171995] memcg:ffff0000cc073d40
[  189.171997] aops:shmem_aops ino:3c01 dentry name(?):"memfd:runsc-memory"
[  189.172006] flags: 
0x17fffef0002022d(locked|referenced|uptodate|lru|workingset|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
[  189.172013] raw: 017fffef0002022d fffffdffccec85c8 fffffdffc6b8e508 
ffff0000cd2ab6c0
[  189.172015] raw: 0000000000003880 0000000000000000 0000000300000000 
ffff0000cc073d40
[  189.172017] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
[  189.172026] ------------[ cut here ]------------
[  189.172027] kernel BUG at mm/filemap.c:155!
[  189.172057] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
.......
[  189.177721] CPU: 3 UID: 0 PID: 5521 Comm: repro Kdump: loaded 
Tainted: G            E       7.3.0-rc4+ #277 PREEMPT(lazy)
[  189.178320] Tainted: [E]=UNSIGNED_MODULE
.......
[  189.179339] pc : filemap_unaccount_folio+0xf0/0x1e8
[  189.179619] lr : filemap_unaccount_folio+0xf0/0x1e8
.......
[  189.183986] Call trace:
[  189.184124]  filemap_unaccount_folio+0xf0/0x1e8 (P)
[  189.184391]  __filemap_remove_folio+0x34/0x160
[  189.184633]  filemap_remove_folio+0x4c/0xb0
[  189.184859]  truncate_inode_folio+0x34/0x58
[  189.185087]  shmem_undo_range+0x220/0x658
[  189.185308]  shmem_fallocate+0x2f0/0x470
[  189.185527]  vfs_fallocate+0x128/0x328
[  189.185764]  __arm64_sys_fallocate+0x50/0xa0
[  189.185999]  invoke_syscall+0x58/0x118
[  189.186210]  el0_svc_common.constprop.0+0xbc/0xe8
[  189.186470]  do_el0_svc+0x20/0x30
[  189.186653]  el0_svc+0x3c/0x198
[  189.186843]  el0t_64_sync_handler+0x98/0xe0
[  189.187078]  el0t_64_sync+0x184/0x188
[  189.187622] SMP: stopping secondary CPUs
[  189.200152] Starting crashdump kernel...
[  189.200388] Bye!
