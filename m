Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9783C4161;
	Fri, 17 Jul 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281130; cv=none; b=B7nScAvqVaZWIfB4eoN3VW48Wtz/f/tXOoX+eryoWaCWKdPc8u5dYJBTQtPs5cb1jKU5fQqeSWHJIiNXAtHPGLw4KLUbDQfNGgl+Atweo0hosU4+i4rZYx+UJ6ZopCEtp/gOk4m/QbVzJPhp2yWcneuS1Nay0Ij5GfUXlpV2pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281130; c=relaxed/simple;
	bh=I6Yqo7XUd5D4Y+FLlh/USg7VJcYE7YSmaL+WyReV7YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHDx+hy8wDewHmOtz2yclgbttVowoYZFC5/JE51zSNq5CW1qLL7qXL4OBI7fUpn3fO0WYQNIYeuBoHVdQVqyWCUnLvb5u2wa94k5RXe4McseXqR/kQn3pIrMagtyoW4DinANRK0D4vHcSiWKLbkUulRn6/psFmTqVD536kqkGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4aecae6e81c311f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3df8c8cb-8a08-4804-abe2-de4922c1a674,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:3df8c8cb-8a08-4804-abe2-de4922c1a674,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:95158109941e2196fd15a9c81d77c1e5,BulkI
	D:260717160919RAFY9K9L,BulkQuantity:6,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|101|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,F
	ile:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4aecae6e81c311f1aa26b74ffac11d73-20260717
X-User: liuye@kylinos.cn
Received: from [192.168.111.169] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1571462795; Fri, 17 Jul 2026 17:38:40 +0800
Message-ID: <70294b26-86e1-4de0-832f-d5cb488cdb3e@kylinos.cn>
Date: Fri, 17 Jul 2026 17:38:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
To: Ye Liu <ye.liu@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <alngSdkM6iEGpETe@lucifer> <102bada7-66ae-415d-abc8-12d5939b7ebb@linux.dev>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <102bada7-66ae-415d-abc8-12d5939b7ebb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/7/17 17:24, Ye Liu 写道:
>
> 在 2026/7/17 16:08, Lorenzo Stoakes (ARM) 写道:
>> +cc Johannes
>>
>> On Fri, Jul 17, 2026 at 02:30:22PM +0800, Ye Liu wrote:
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Folios on the deferred split list hold physical memory that is
>>> invisible in meminfo. When a THP becomes partially mapped, the
>>> unmapped pages are removed from AnonPages but remain physically
>>> allocated until the shrinker splits the folio. This creates a
>>> memory accounting gap where used memory cannot be attributed to
>>> any meminfo field.
>> Is this really that much of an issue? You're not giving any use cases here.
>>
>> What real-world use case motivated this?
>>
> I have indeed encountered this situation in a customer environment,                           
> but the environment is complex, and I cannot clearly explain why this memory                  
> black hole occurs in that scenario.                                                           
> However, I will provide an example to reproduce it below.                                     
> Use case: The system has 100GB of memory. A user-space program requests 80GB of memory.       
> For each 2MB block, only one page is retained, and the mapping of all other pages is unmapped,
> while the process continues to run.                                                           
> You'll find that in meminfo, MemFree: only 12GB remains,                                      
> but the process actually uses very little memory.                                             
> This creates a memory black hole situation.                                                   
> Below is the test program I used, from AI.                                                    
>

ps -p $(pgrep -d, test) -o pid,comm,%mem,rss,vsz
    PID COMMAND         %MEM   RSS    VSZ
   9358 test             0.1 165220 166032


MemTotal:       101606276 kB
MemFree:        13172092 kB
MemAvailable:   13569668 kB
Buffers:            5352 kB
Cached:          1169520 kB
SwapCached:            0 kB
Active:         84730404 kB
Inactive:        1129792 kB
Active(anon):   84730404 kB
Inactive(anon):        0 kB
Active(file):          0 kB
Inactive(file):  1129792 kB
Unevictable:        6192 kB
Mlocked:              32 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Zswap:                 0 kB
Zswapped:              0 kB
Dirty:                24 kB
Writeback:             0 kB
AnonPages:        969280 kB
Mapped:           308848 kB
Shmem:             45076 kB
KReclaimable:      96144 kB
Slab:             269540 kB
SReclaimable:      96144 kB
SUnreclaim:       173396 kB
KernelStack:       27584 kB
PageTables:       187408 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    54997436 kB
Committed_AS:    6628776 kB
VmallocTotal:   261087232 kB
VmallocUsed:       38696 kB
VmallocChunk:          0 kB
Percpu:            42800 kB
HardwareCorrupted:     0 kB
AnonHugePages:    413696 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:    172032 kB
FilePmdMapped:     28672 kB
DeferredSplitPages: 83886080 kB
CmaTotal:         131072 kB
CmaFree:          122880 kB
Balloon:               0 kB
GPUActive:             0 kB
GPUReclaim:            0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB



/*
 * thp_keep_one_page_per_2mb.c
 *
 * Compile: gcc -O2 -o test thp_keep_one_page_per_2mb.c
 * Run: ./thp_test
 *
 * Description:
 *   Allocate 80GB virtual address space, touch pages and record accessibility.
 *   For each 2MB block (if its first page is accessible), keep only the first
 *   4KB page and unmap all other pages within that block.
 *   The process stays alive for inspection of memory state.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <setjmp.h>
#include <stdbool.h>
#include <time.h>

#define PMD_SIZE        (2 * 1024 * 1024)               /* 2 MB */
#define PAGE_SIZE       4096                           /* 4 KB */
#define TOTAL_SIZE      (80ULL * 1024 * 1024 * 1024)  /* 80 GB */
#define NR_PAGES        (TOTAL_SIZE / PAGE_SIZE)       /* ~20.97 million pages */
#define NR_HUGEPAGES    (TOTAL_SIZE / PMD_SIZE)        /* 40960 THP blocks */

static unsigned char *base_addr;
static unsigned char *page_ok;          /* 1 = accessible, 0 = inaccessible / already unmapped */
static sigjmp_buf jmpbuf;

/* Signal handler to catch page fault errors */
static void segv_handler(int sig, siginfo_t *info, void *context)
{
    (void)sig; (void)info; (void)context;
    siglongjmp(jmpbuf, 1);
}

/* Read total AnonHugePages size (in bytes) from /proc/self/smaps */
static unsigned long read_anon_hugepages(void)
{
    FILE *fp = fopen("/proc/self/smaps", "r");
    if (!fp) return 0;
    char line[256];
    unsigned long total = 0;
    while (fgets(line, sizeof(line), fp)) {
        if (strncmp(line, "AnonHugePages:", 14) == 0) {
            unsigned long val;
            if (sscanf(line + 14, "%lu kB", &val) == 1)
                total += val * 1024;
        }
    }
    fclose(fp);
    return total;
}

int main(void)
{
    /* Install signal handlers */
    struct sigaction sa = {
        .sa_sigaction = segv_handler,
        .sa_flags = SA_SIGINFO,
    };
    sigaction(SIGSEGV, &sa, NULL);
    sigaction(SIGBUS, &sa, NULL);

    printf("=== Keep only one 4KB page per 2MB THP, unmap the rest ===\n");
    printf("Allocation size: %lu MB (%lu 2MB THP blocks)\n",
           TOTAL_SIZE / (1024 * 1024), NR_HUGEPAGES);

    /* 1. Reserve virtual address space (no physical allocation yet) */
    base_addr = mmap(NULL, TOTAL_SIZE,
                     PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS,
                     -1, 0);
    if (base_addr == MAP_FAILED) {
        perror("mmap failed");
        exit(EXIT_FAILURE);
    }
    printf("Virtual address base: %p\n", base_addr);

    /* 2. Hint kernel to use THP (if system policy is madvise) */
    if (madvise(base_addr, TOTAL_SIZE, MADV_HUGEPAGE) == -1)
        perror("madvise (non-fatal)");

    /* 3. Allocate page status array */
    page_ok = calloc(NR_PAGES, sizeof(unsigned char));
    if (!page_ok) {
        perror("calloc");
        exit(EXIT_FAILURE);
    }

    /* 4. Touch pages one by one, capturing faults */
    printf("Touching pages (write each page, skip on failure)...\n");
    const unsigned long print_interval = (256ULL * 1024 * 1024) / PAGE_SIZE;
    for (unsigned long i = 0; i < NR_PAGES; i++) {
        volatile unsigned char *p = base_addr + i * PAGE_SIZE;

        if (sigsetjmp(jmpbuf, 1) == 0) {
            *p = 0xAA;          /* attempt write */
            page_ok[i] = 1;     /* success */
        } else {
            page_ok[i] = 0;     /* fault – page not accessible */
        }

        if ((i + 1) % print_interval == 0) {
            printf("  Processed %lu MB\n", (i + 1) * PAGE_SIZE / (1024 * 1024));
        }
    }

    /* Count successfully mapped pages */
    unsigned long ok_pages = 0;
    for (unsigned long i = 0; i < NR_PAGES; i++)
        if (page_ok[i]) ok_pages++;
    printf("Touch complete. Successfully mapped %lu pages (%.2f MB)\n",
           ok_pages, ok_pages * PAGE_SIZE / (1024.0 * 1024));

    /* 5. THP usage before the operation */
    unsigned long huge_before = read_anon_hugepages();
    printf("AnonHugePages before operation: %.2f MB\n",
           huge_before / (1024.0 * 1024));

    /* 6. For each 2MB block: keep the first page, unmap all other pages */
    printf("\nProcessing each THP: keep first page, unmap the rest...\n");
    int success = 0, fail = 0, skipped = 0;
    for (unsigned long i = 0; i < NR_HUGEPAGES; i++) {
        unsigned long start_page = i * (PMD_SIZE / PAGE_SIZE); /* 512 pages per block */

        if (page_ok[start_page]) {
            /* First page is accessible – keep it, unmap the rest of the block */
            void *addr = base_addr + i * PMD_SIZE + PAGE_SIZE;
            size_t len = PMD_SIZE - PAGE_SIZE; /* 2MB - 4KB */

            /* Try batch munmap first (requires all pages in range to be mapped) */
            if (munmap(addr, len) == 0) {
                /* Batch succeeded; mark all remaining pages in this block as unmapped */
                for (unsigned long j = start_page + 1; j < start_page + 512; j++) {
                    page_ok[j] = 0;
                }
                success++;
            } else {
                /* Batch failed (some pages were never mapped) – fallback to per‑page unmap */
                int sub_success = 0;
                for (unsigned long j = start_page + 1; j < start_page + 512; j++) {
                    if (page_ok[j]) {
                        if (munmap(base_addr + j * PAGE_SIZE, PAGE_SIZE) == 0) {
                            page_ok[j] = 0;
                            sub_success++;
                        } else {
                            /* ignore errors, keep page_ok[j] as 1 */
                        }
                    }
                }
                if (sub_success > 0) {
                    success++;
                } else {
                    fail++;
                }
            }
        } else {
            skipped++;
        }

        if ((i + 1) % 1000 == 0) {
            printf("  Processed %lu/%lu THP (ok:%d, fail:%d, skip:%d)\n",
                   i + 1, NR_HUGEPAGES, success, fail, skipped);
        }
    }
    printf("Operation complete: success %d, fail %d, skipped %d\n", success, fail, skipped);

    /* 7. THP usage after the operation */
    unsigned long huge_after = read_anon_hugepages();
    printf("AnonHugePages after operation: %.2f MB\n",
           huge_after / (1024.0 * 1024));

    /* 8. Verification: access only the kept first page of each block */
    printf("\nVerifying kept first pages (offset 0 of each block)...\n");
    int verify_ok = 0, verify_fail = 0;
    for (unsigned long i = 0; i < NR_HUGEPAGES; i++) {
        unsigned long first_page = i * (PMD_SIZE / PAGE_SIZE);
        if (page_ok[first_page]) {
            volatile unsigned char *p = base_addr + i * PMD_SIZE;
            (void)*p;   /* read the first byte */
            verify_ok++;
        } else {
            verify_fail++;
        }
        if ((i + 1) % 1000 == 0) {
            printf("  Verified %lu/%lu THP\n", i + 1, NR_HUGEPAGES);
        }
    }
    printf("Verification complete: %d first pages accessible, %d inaccessible (skipped)\n",
           verify_ok, verify_fail);

    /* 9. Keep the process alive – all kept pages remain mapped */
    printf("\nEach THP's first page is kept; all other pages have been unmapped.\n");
    printf("Process PID = %d, staying alive (press Ctrl+C to exit).\n", getpid());
    printf("Use these commands to inspect memory state:\n");
    printf("  cat /proc/%d/smaps | grep -A20 '^7f'  # view mapping details\n", getpid());
    printf("  cat /proc/%d/smaps | grep AnonHugePages\n", getpid());

    free(page_ok);   /* release status array */

    while (1) {
        sleep(60);
        /* Optionally print current THP usage (should be near 0) */
        unsigned long cur = read_anon_hugepages();
        printf("[%ld] Current AnonHugePages: %.2f MB\n", time(NULL), cur / (1024.0 * 1024));
    }

    /* never reached */
    munmap(base_addr, TOTAL_SIZE);
    return 0;
}



>>> Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
>>> folios currently on the deferred_split_lru, updated via
>>> mod_node_page_state() at all enqueue/dequeue points. The new field
>>> DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
>>> per-node /sys/devices/system/node/node*/meminfo.
>> Again you're not justifying anything, why do you need a per-node breakdown?
>>
> Initially, the only plan was to add it to /proc/meminfo;
> the others were more of a transitional design.          
>
>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> You're updating these stats in a number of places and you've given zero
>> explanataion or evidence that you're accounting this correctly.
>>
> The counter tracks the current total pages of partially_mapped folios on deferred_split_lru.
> The six hook points:                                                                        
> - Add: deferred_split_folio() when partially_mapped → the only first-enqueue path           
> - Add: deferred_split_scan() requeue → net effect is zero paired with isolate's del         
> - Del: deferred_split_isolate() → temporary removal for shrinker processing                 
> - Del: __folio_unqueue_deferred_split() → permanent removal when folio is freed             
> - Del: split path → permanent removal when folio is split into sub-folios                   
>
>> This is very subtle code and you're a very new contributor to this so I
>> wouldn't want us to take someting like this even if it was justified
>> without a very strong argument.
> True – I’m new to the kernel code, so I’ll definitely benefit from checking in 
> with you guys more regularly.                                                  
>
>> You'd probably want to do some refactoring stuff first also to combine any
>> such updates with moves.
>>
> Indeed, it would be better to integrate it with folio updates.
>>> ---
>>>  drivers/base/node.c    |  4 +++-
>>>  fs/proc/meminfo.c      |  2 ++
>>>  include/linux/mmzone.h |  1 +
>>>  mm/huge_memory.c       | 24 +++++++++++++++++++++---
>>>  mm/vmstat.c            |  1 +
>>>  5 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>> index 3da91929ad4e..69463438300e 100644
>>> --- a/drivers/base/node.c
>>> +++ b/drivers/base/node.c
>>> @@ -519,6 +519,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>  			     "Node %d ShmemPmdMapped: %8lu kB\n"
>>>  			     "Node %d FileHugePages:  %8lu kB\n"
>>>  			     "Node %d FilePmdMapped:  %8lu kB\n"
>>> +			     "Node %d DeferredSplitPages: %8lu kB\n"
>>>  #endif
>>>  #ifdef CONFIG_UNACCEPTED_MEMORY
>>>  			     "Node %d Unaccepted:     %8lu kB\n"
>>> @@ -553,7 +554,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>  			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
>>>  			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
>>>  			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
>>> -			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
>>> +			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED)),
>>> +			     nid, K(node_page_state(pgdat, NR_DEFERRED_SPLIT_PAGES))
>>>  #endif
>>>  #ifdef CONFIG_UNACCEPTED_MEMORY
>>>  			     ,
>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>> index b2813ff13cb2..76dbf51ad1e0 100644
>>> --- a/fs/proc/meminfo.c
>>> +++ b/fs/proc/meminfo.c
>>> @@ -149,6 +149,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>  		    global_node_page_state(NR_FILE_THPS));
>>>  	show_val_kb(m, "FilePmdMapped:  ",
>>>  		    global_node_page_state(NR_FILE_PMDMAPPED));
>>> +	show_val_kb(m, "DeferredSplitPages: ",
>>> +		    global_node_page_state(NR_DEFERRED_SPLIT_PAGES));
>>>  #endif
>>>
>>>  #ifdef CONFIG_CMA
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 0507193b3ae3..1e75adb73d00 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -267,6 +267,7 @@ enum node_stat_item {
>>>  	NR_FILE_THPS,
>>>  	NR_FILE_PMDMAPPED,
>>>  	NR_ANON_THPS,
>>> +	NR_DEFERRED_SPLIT_PAGES, /* THP/mTHP pages pending deferred split */
>>>  	NR_VMSCAN_WRITE,
>>>  	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
>>>  	NR_DIRTIED,		/* page dirtyings since bootup */
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index c642bec967fa..1094b844675c 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -77,6 +77,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>  					 struct shrink_control *sc);
>>>  static bool split_underused_thp = true;
>>>
>>> +#define deferred_split_pages_add(folio) \
>>> +	mod_node_page_state(NODE_DATA(folio_nid(folio)), \
>>> +			    NR_DEFERRED_SPLIT_PAGES, folio_nr_pages(folio))
>>> +
>>> +#define deferred_split_pages_del(folio) \
>>> +	mod_node_page_state(NODE_DATA(folio_nid(folio)), \
>>> +			    NR_DEFERRED_SPLIT_PAGES, -folio_nr_pages(folio))
>> Why are these macros?
>>
>> I really dislike the naming too, these read like they're actually
>> adding/deleting pages.
>>
> Rename the helpers to avoid the "add/del pages" confusion           
> (e.g. mod_deferred_split_stat() or just inline mod_node_page_state).
>
>>> +
>>>  static atomic_t huge_zero_refcount;
>>>  struct folio *huge_zero_folio __read_mostly;
>>>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>>> @@ -3913,8 +3921,10 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
>>>  		struct lruvec *lruvec;
>>>
>>>  		if (dequeue_deferred) {
>>> -			__list_lru_del(&deferred_split_lru, lru,
>>> -				       &folio->_deferred_list, folio_nid(folio));
>>> +			if (__list_lru_del(&deferred_split_lru, lru,
>>> +					  &folio->_deferred_list, folio_nid(folio)) &&
>>> +			    folio_test_partially_mapped(folio))
>>> +				deferred_split_pages_del(folio);
>>>  			if (folio_test_partially_mapped(folio)) {
>>>  				folio_clear_partially_mapped(folio);
>>>  				mod_mthp_stat(old_order,
>>> @@ -4415,6 +4425,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
>>>  	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, &memcg, &flags);
>>>  	if (__list_lru_del(&deferred_split_lru, lru, &folio->_deferred_list, nid)) {
>>>  		if (folio_test_partially_mapped(folio)) {
>>> +			deferred_split_pages_del(folio);
>>>  			folio_clear_partially_mapped(folio);
>>>  			mod_mthp_stat(folio_order(folio),
>>>  				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>> @@ -4473,6 +4484,8 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>  		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
>>>  	}
>>>  	__list_lru_add(&deferred_split_lru, lru, &folio->_deferred_list, nid, memcg);
>>> +	if (partially_mapped)
>>> +		deferred_split_pages_add(folio);
>>>  	list_lru_unlock_irqrestore(lru, &flags);
>>>  	rcu_read_unlock();
>>>  }
>>> @@ -4524,8 +4537,11 @@ static enum lru_status deferred_split_isolate(struct list_head *item,
>>>  {
>>>  	struct folio *folio = container_of(item, struct folio, _deferred_list);
>>>  	struct list_head *freeable = cb_arg;
>>> +	bool partially_mapped = folio_test_partially_mapped(folio);
>>>
>>>  	if (folio_try_get(folio)) {
>>> +		if (partially_mapped)
>>> +			deferred_split_pages_del(folio);
>>>  		list_lru_isolate_move(lru, item, freeable);
>>>  		return LRU_REMOVED;
>>>  	}
>>> @@ -4535,7 +4551,8 @@ static enum lru_status deferred_split_isolate(struct list_head *item,
>>>  	 * isolate: folio_unqueue_deferred_split() checks list_empty()
>>>  	 * locklessly, so once removed the folio can be freed any time.
>>>  	 */
>>> -	if (folio_test_partially_mapped(folio)) {
>>> +	if (partially_mapped) {
>>> +		deferred_split_pages_del(folio);
>>>  		folio_clear_partially_mapped(folio);
>>>  		mod_mthp_stat(folio_order(folio),
>>>  			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>> @@ -4596,6 +4613,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>  					 &folio->_deferred_list,
>>>  					 folio_nid(folio),
>>>  					 folio_memcg(folio));
>>> +			deferred_split_pages_add(folio);
>>>  			rcu_read_unlock();
>>>  		}
>>>  		folio_put(folio);
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 3b5cb1031f72..ba71cc3e4c30 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1248,6 +1248,7 @@ const char * const vmstat_text[] = {
>>>  	[I(NR_FILE_THPS)]			= "nr_file_hugepages",
>>>  	[I(NR_FILE_PMDMAPPED)]			= "nr_file_pmdmapped",
>>>  	[I(NR_ANON_THPS)]			= "nr_anon_transparent_hugepages",
>>> +	[I(NR_DEFERRED_SPLIT_PAGES)]		= "nr_deferred_split_pages",
>>>  	[I(NR_VMSCAN_WRITE)]			= "nr_vmscan_write",
>>>  	[I(NR_VMSCAN_IMMEDIATE)]		= "nr_vmscan_immediate_reclaim",
>>>  	[I(NR_DIRTIED)]				= "nr_dirtied",
>>> --
>>> 2.43.0
>>>
>> Cheers, Lorenzo

-- 
Thanks,
Ye Liu

