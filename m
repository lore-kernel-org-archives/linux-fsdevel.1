Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F73BD659;
	Sat, 10 Oct 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601256; cv=none; b=MjyPm8NZJWaXYaiAt1a5cLKT9ZD3hbZBhwy8xvedmMoJ+ysO8KXebs++JBQ+Jsdi3NSSRpQqH7TFoDYHSHM8hPz1xOI4x/onm1IBiwufjXrapS5R1VNyB/K8Z1RixydeRkReuXfp5ea40OlHOT+IP2GU/wfd/rFjru1uOXR+V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601256; c=relaxed/simple;
	bh=OZnjEeHDlesj7pPV5lPZmTIfi8S2v+KjBymN3O53isE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8D+ae33optISL4lm6xDUPYqQdIg/T7u/vtsusmypVYIDPkVCTgOPKZrlrL9dVsbI3ezJPA3ybcpCJfo3BCMAy5SimNEkO7wHsuKdJqy4cpuZCY/3GpkyrpM0fRxaO9Pfxl5R/CPh8Vr7oa56cddJDLB28IShA8ZGfXwQVSfxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: w+RxoyOnS+uT4AFwvlQEJw==
X-CSE-MsgGUID: rogxv7D+S7q6K7N6t81i4Q==
X-IronPort-AV: E=Sophos;i="6.27,149,1786982400"; 
   d="scan'208";a="165154808"
From: Yifan Li <liyifan21@xiaomi.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yifan Li <liyifan21@xiaomi.com>
Subject: [RFC PATCH 1/1] mm: page_frag: account page_frag pages in vmstat and meminfo
Date: Sat, 10 Oct 2026 10:59:40 +0800
Message-ID: <20261010025941.1253-2-liyifan21@xiaomi.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261010025941.1253-1-liyifan21@xiaomi.com>
References: <20261010025941.1253-1-liyifan21@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To YZ-MBX01.mioffice.cn
 (10.237.88.121)

The page_frag allocator backs sk_buff->head and the frags portion of
skb_shared_info for the network stack and NIC drivers, but pages
obtained from it are not accounted by any memory statistics counter.
Unlike slab (NR_SLAB_*) or page_pool, page_frag pages are invisible
to tools that derive "LostRAM =3D MemTotal - (sum of accounted memory)",
which inflates LostRAM and makes memory diagnosis misleading.

Pages enter the cache through a single entry point,
__page_frag_cache_refill(), so account them there.  Decrement when the
cache page is freed via __page_frag_cache_drain() and page_frag_free().

Expose the counter, in pages, as "nr_page_frag" in /proc/vmstat and
"PageFrag" in /proc/meminfo so that page_frag memory is classified
instead of being counted as LostRAM.

Known limitation: a cache page handed over to an skb frags array is
released via put_page() (kfree_skb -> __skb_frag_unref ->
put_netmem -> put_page), bypassing page_frag_free(), so the counter
can over-count under network load.  Covering that open release path
requires marking the page and accounting at the common free path;
that will be posted separately for discussion.

Verified on an arm64 Android device with 4K pages: at boot, PageFrag
in /proc/meminfo reports 14432 kB, consistent with nr_page_frag
(3608 pages) in /proc/vmstat.

Signed-off-by: Yifan Li <liyifan21@xiaomi.com>
---
 fs/proc/meminfo.c      |  1 +
 include/linux/mmzone.h |  1 +
 mm/page_frag_cache.c   | 14 ++++++++++++--
 mm/vmstat.c            |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b2813ff13..73241c3a3 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -108,6 +108,7 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
        show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
        show_val_kb(m, "SReclaimable:   ", sreclaimable);
        show_val_kb(m, "SUnreclaim:     ", sunreclaim);
+       show_val_kb(m, "PageFrag:       ", global_node_page_state(NR_PAGE_F=
RAG));
        seq_printf(m, "KernelStack:    %8lu kB\n",
                   global_node_page_state(NR_KERNEL_STACK_KB));
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 94f9c3ff5..636f6ecb7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -333,6 +333,7 @@ enum node_stat_item {
        NR_KERNEL_FILE_PAGES,
        NR_GPU_ACTIVE,  /* Pages assigned to GPU objects */
        NR_GPU_RECLAIM, /* Pages in shrinkable GPU pools */
+       NR_PAGE_FRAG,
        NR_VM_NODE_STAT_ITEMS
 };

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index e63efe78b..4f768093c 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/page_frag_cache.h>
+#include <linux/vmstat.h>
 #include "page_alloc.h"

 static unsigned long encoded_page_create(struct page *page, unsigned int o=
rder,
@@ -67,6 +68,9 @@ static struct page *__page_frag_cache_refill(struct page_=
frag_cache *nc,
        nc->encoded_page =3D page ?
                encoded_page_create(page, order, page_is_pfmemalloc(page)) =
: 0;

+       if (page)
+               mod_node_page_state(page_pgdat(page), NR_PAGE_FRAG,
+                                   1L << order);
        return page;
 }

@@ -85,8 +89,11 @@ void __page_frag_cache_drain(struct page *page, unsigned=
 int count)
 {
        VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0, page);

-       if (page_ref_sub_and_test(page, count))
+       if (page_ref_sub_and_test(page, count)) {
+               mod_node_page_state(page_pgdat(page), NR_PAGE_FRAG,
+                                    -(1L << compound_order(page)));
                free_frozen_pages(page, compound_order(page));
+       }
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);

@@ -165,7 +172,10 @@ void page_frag_free(void *addr)
 {
        struct page *page =3D virt_to_head_page(addr);

-       if (unlikely(put_page_testzero(page)))
+       if (unlikely(put_page_testzero(page))) {
+               mod_node_page_state(page_pgdat(page), NR_PAGE_FRAG,
+                                    -(1L << compound_order(page)));
                free_frozen_pages(page, compound_order(page));
+       }
 }
 EXPORT_SYMBOL(page_frag_free);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index cb5771453..883137cb6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1311,6 +1311,7 @@ const char * const vmstat_text[] =3D {
        [I(NR_KERNEL_FILE_PAGES)]               =3D "nr_kernel_file_pages",
        [I(NR_GPU_ACTIVE)]                      =3D "nr_gpu_active",
        [I(NR_GPU_RECLAIM)]                     =3D "nr_gpu_reclaim",
+       [I(NR_PAGE_FRAG)]                       =3D "nr_page_frag",
 #undef I

        /* system-wide enum vm_stat_item counters */
--
2.46.0.windows.1

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
