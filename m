Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084275;
	b=0qwDLgx9lJF2PuIBOlNXRL3WoBmxFdtguCpNgRB1RX9TBD8Rrh0KQuFBughQT3mkRB9m
	 mRzp7R4q+IF/qXL8LEmO+p4FStyhXMqUZWTqv9VL94AtZPkBR4EpuCHglZXyg+yxxcj3J
	 6bpJ1fHPB4JKm5oG/pzaFLgSR6f83fwKvpCiuMORLsYjpWYC/0UlXadIT7lVDWvkQY0Bo
	 hnuWKpCR2i5rtR+HKilmftxBNqqltRYz12/8+U3Qvak6nKH1b0lVPAqV71lW+ohL9hp3/
	 7ImVKp2NnShhoXT2ARDP8thfJhxp/0zf5otbczaUxo/LDWJF0eDFRQa5Sfm3O3dcn1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rFHNeMzU6lF6SlEzmc33S/YQH+LNSV+pccbe3Fm4Sbo=;
	b=UDNkYQf4hJeNlAnQ1pqKqPfYGB4hpVRKQIC4u0B84G8C+ttOn2snbXvO9VhJuS4Bcf/U
	 2lltWcYLQUSQmwPhgsPlM3tCrDIdFgjqO+uCoT1qUksybY1TWQmq5ngemhJNf8poZZHyh
	 A/Lk+lrFRAyd2O1ZwUcpunwPL8E0E270V7ua8vfnzbIQyzvizPKQ925RHuaSsdPi9OK/E
	 WnsW3V0hmac72lAexdajGWgsTYO/duXyHPi/Sn8Ex7s+R6fjilmwIthzCHSfYW341IhOE
	 xhZq/iuvLdF/wC+0dTYzxuHw+UzqgSOS6PgyNklUHnVr7azax/NOcTFM/OWvRxdoOVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=osh6DZAt;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE0606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 06:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BE0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=osh6DZAt
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1558496b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084274; x=1793689074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFHNeMzU6lF6SlEzmc33S/YQH+LNSV+pccbe3Fm4Sbo=;
        b=osh6DZAtY5ZPyKVdvOzLRkH7CCEQ1LMa+ylxmfgnQwqjziR3OOm+yHCcP3ccSPZaJz
         MhFZzOBev23Se6ujBpIfJT4J1j+y1bjPZPTZ0L/boEc9JKKt0vN5vEpPq7IkDIo9xJ6c
         jmRyMwXESzgzgj0Y746s0zkGlC4fQS5VGlzcE0pz8mNOU9GibLBadTSHuh9xlfT61olN
         BarqjRyY3RjJVlD8VAiNSGxLJwj5fRrtfBTDrlupnMOAytV4Ea5hpdTgTcTgdZCv5viv
         RXzav5V85yGsqvVaY+pW1ksA9hAXIy+WZbAV3uOy5KNpaGbIItcWKbpt7RH1j7/YX7Yw
         kX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084274; x=1793689074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFHNeMzU6lF6SlEzmc33S/YQH+LNSV+pccbe3Fm4Sbo=;
        b=BO8/568UtCRyom7rHhUnBvPB06FGnRkpQvlGNKAsTrGHUXJ17PyrxpCWhVcVE/Ka5T
         0FOzHi7RUasTQhBR82srkH6P1DfQ/T69AQZAEyx/+UELHD8W5vhI/PGJRfQKpuTHAtJ4
         fwjDKs27rhTY4MlH6Jp4ZzkvwvUFrSeLB/AZMb2f5P3rPoNf6bPlpmdFKQRL9nZkHITJ
         WZxFONeWm5ZmdgUgC4VocBsq5DsFTzwQIvrGaCgvg2qicz2Hk4YKtsaFboB8kHqhwXjz
         6S69R/Usygjz80YW4MrBkkP2vNqu6yKzeTNclu0pLpjJGqkrknmWauACPRj1b0oljFAz
         wR3g==
X-Forwarded-Encrypted: i=1; AKwUvBxp7mdR+CHXkSVRpffzzUGHWV3VGLegbrjc/MheLwDHTeGvpjow/uKOQckdobep06nhuwJCZjvSSiUDpjLS@vger.kernel.org
X-Gm-Message-State: AFq9FYJlE14Uh0Djul+hCaKp/gYxbMbK/DArZHIEa+PRfF3hBZNkQ/cC
	huojnP7QKnQtTquV+VhdP4bFaO7UGV2nEtBwMRorvIONJ3Db/e7vJ9aX
X-Gm-Gg: AYBFou0aNYFmau4grROJ1TP0KyCC4W6qMxhsdPefiao+D8wPUtzoWdRqL8OTbtoicf6
	Uu3D8boNfVWml3tRQZxNd/1ySQAEGddG5r4sAZJ2+dQUwuWiKiOuRnO4TPUoITW/ZxSqT5uN57y
	2SpCSKrqOSzbplvPYVNs1ZCjsTTskTBYCsStSjWMKsN2uSZwnLVToTAU/5w3kc8P8ASCeWZmZOL
	qHhlB0aucle+qutii8rwNfi0GPffGUTmQ29CktUeC4GeRlRvUOjTQftyPJDUbpztkcApkyVByrb
	MgKfUoz/i4IGQvYhXGVpMH5FgNynxqXxTBQutTDZr46HKK5y/gzs2wPG8elrdZlALnKO0dJDHuC
	YUXnO0v4fB6xDSBbSYoLSJdVInkIjMDwKma8Tszc0dqSYGPymYN0G2qUxFHK7tNrCOuTxbXWrG1
	VNmdNoGf0hMWS7V7As0nQPE2paDLYO6MnNB63pelmrOU6g9ywkXBg9cy+NZld2u66LqLZL8jPiJ
	kmamrHIKaOH2RPqXIs/S+nmJHNST9jVmeQfdwQyhziId301uSJYmHXr9/gM85RLhvPFZhyuVnNk
	QkdZ
X-Received: by 2002:a05:6a20:a110:b0:3de:53c1:b627 with SMTP id adf61e73a8af0-3e7bfa975admr5738301637.43.1793084273864;
        Mon, 26 Oct 2026 23:57:53 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdac68402a1sm1398700a12.1.2026.10.26.23.57.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:57:53 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Tue, 27 Oct 2026 14:57:23 +0800
Message-Id: <20261027065723.66564-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903122128.12264-4-songmuchun@bytedance.com>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Muchun,

I have been testing this series for microVMs that mount a read-only
rootfs over virtio-pmem with FS-DAX. In this setup, most file data is
accessed through read/write rather than mmap, so most PFNs never need
private writable metadata. This optimization is very useful for
reducing guest memory overhead and running more VMs on a host.

While testing, I ran into two issues, both in patch 3, including a
crash when initializing the shared template page during probe, and the
128 MiB alignment check preventing our 2 MiB-aligned rootfs images from
using the optimization, even though the check can be relaxed without
changing the registration or teardown paths. I have included a patch
for both at the end of this email.


First, regarding the shared template initialization in
memmap_init_zone_device():

> @@ -1133,6 +1134,15 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	if (!nr_pages)
>  		return;
>  
> +	if (pgmap_vmemmap_optimizable(pgmap)) {
> +		struct page *page = page_address(pgmap->vmemmap_shared_page);
> +
> +		for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
> +			__init_zone_device_page(page + i, start_pfn + i,
> +						ZONE_DEVICE, nid, pgmap);
> +		goto pageblock_init;
> +	}

pgmap->vmemmap_shared_page is allocated from normal kernel memory
(direct map). It is just a template buffer, not a real struct page
inside the vmemmap space, so passing it to __init_zone_device_page()
causes page_to_pfn(page) to compute an invalid, out-of-bounds PFN.

I first hit this when backporting the series to a 6.6.117 guest kernel,
where set_pageblock_migratetype() uses that invalid PFN and crashes
during device probe.

On your base commit (next-20260902), a normal boot does not crash
because pageblock init was moved to the end of the function. However,
set_page_count() still calls page_to_pfn(page) inside the page_ref_set
tracepoint. Booting with CONFIG_DEBUG_PAGE_REF=y and
trace_event=page_ref:page_ref_set triggers the same NULL pointer
dereference during probe:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Call Trace:
   trace_event_raw_event_page_ref_set+0x4e/0xa0
   __init_zone_device_page+0x98/0xd0
   memmap_init_zone_device+0x1c3/0x2e0

To fix this, I added init_fsdax_page_template() to initialize the
template fields (ZONE_DEVICE links, Reserved flag, pgmap, and refcount/
mapcount via atomic_set()) directly without calling page_to_pfn(). It
also preserves the WANT_PAGE_VIRTUAL handling from __init_single_page(),
since patch 1 enables this optimization on LoongArch where KFENCE
selects WANT_PAGE_VIRTUAL. I only have x86-64 to test on, so please let
me know if that part looks right to you.


Second, regarding the alignment check in
pgmap_vmemmap_shared_page_alloc():

> The initial implementation is deliberately limited to a single
> memory-block-aligned range. That is not a fundamental requirement, but keeps
> the registration and teardown paths simple; support for multiple ranges or
> less strict alignment can be added later.
...
> +	if (pgmap->nr_range != 1 ||
> +	    !IS_ALIGNED(range->start | range_len(range), MIN_MEMORY_BLOCK_SIZE))
> +		return 0;

After fixing the crash above, the optimization still did not take
effect for my 130 MiB test rootfs image. Because MIN_MEMORY_BLOCK_SIZE
is 128 MiB on x86-64, the 130 MiB device failed this check and fell
back to allocating all 520 vmemmap pages.

In our microVM setup, rootfs images are sized to fit the filesystem and
aligned to 2 MiB rather than 128 MiB. In fact, 2 MiB (SUBSECTION_SIZE)
is already the native alignment for FS-DAX (via memremap_compat_align())
and for ZONE_DEVICE vmemmap population and teardown. To keep those paths
simple, we only need to make sure a shared vmemmap page never crosses a
pgmap boundary, which 2 MiB alignment already guarantees on 4K-page
kernels.

So I relaxed the check from MIN_MEMORY_BLOCK_SIZE to SUBSECTION_SIZE.
I also added an alignment check on (PAGE_SIZE / sizeof(struct page))
PFNs, so the same boundary guarantee holds on large page kernels,
where one vmemmap page covers more than 2 MiB of device memory (such
as 16K/64K pages on LoongArch).


With both changes applied on next-20260902 (QEMU x86-64), probing with
CONFIG_DEBUG_PAGE_REF=y and trace_event=page_ref:page_ref_set works
cleanly. The 130 MiB test device now uses one shared vmemmap backing
page instead of 520 private pages, and DAX faults materialize private
metadata on demand as expected. Mounting two 2 MiB-aligned virtio-pmem
devices side by side also works properly, and unbinding/rebinding either
device does not affect the other.

If these changes look good to you, could you fold them into patch 3 for
v2? (Note that the patch is against v1 and still uses the
PGMAP_VMEMMAP_OPTIMIZATION flag.)

I also noticed that next-20261023 has refactored
memmap_init_zone_device() to use zone_device_page_init_from_template().
The mm/mm_init.c change will need to be adapted when rebasing the
series, while the mm/memremap.c change should remain applicable. I am
happy to help retest v2.

Signed-off-by: Yilei Zheng <trilith.zheng@gmail.com>
---
 mm/memremap.c |   10 +++++++++-
 mm/mm_init.c  |   29 +++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index a53d09b..34d8d89 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -93,8 +93,16 @@ static int pgmap_vmemmap_shared_page_alloc(struct dev_pagemap *pgmap, int nid)
 	    !(pgmap->flags & PGMAP_VMEMMAP_OPTIMIZATION))
 		return 0;
 
+	/*
+	 * Subsections can be populated and removed independently, but a
+	 * shared vmemmap page must never span across different pgmaps
+	 * (which can exceed a subsection on large-page kernels). Check
+	 * both boundaries instead of requiring a full memory block.
+	 */
 	if (pgmap->nr_range != 1 ||
-	    !IS_ALIGNED(range->start | range_len(range), MIN_MEMORY_BLOCK_SIZE))
+	    !IS_ALIGNED(range->start | range_len(range), SUBSECTION_SIZE) ||
+	    !IS_ALIGNED(PHYS_PFN(range->start | range_len(range)),
+			PAGE_SIZE / sizeof(struct page)))
 		return 0;
 
 	pgmap->vmemmap_shared_page = alloc_pages_node(nid, GFP_KERNEL, 0);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7dd03b8..1c3e269 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1030,6 +1030,31 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 }
 
+/*
+ * Initialize struct page slots in the shared backing page. Because this
+ * page is a direct-map template buffer rather than a real vmemmap entry,
+ * set_page_count() must not be used here as its tracepoint calls
+ * page_to_pfn(). Keep the initialized state in sync with
+ * __init_single_page() and __init_zone_device_page().
+ */
+static void __ref init_fsdax_page_template(struct page *page,
+					   unsigned long pfn, int nid,
+					   struct dev_pagemap *pgmap)
+{
+	mm_zero_struct_page(page);
+	set_page_links(page, ZONE_DEVICE, nid, pfn);
+#ifdef WANT_PAGE_VIRTUAL
+	if (!is_highmem_idx(ZONE_DEVICE))
+		set_page_address(page, __va(pfn << PAGE_SHIFT));
+#endif
+	atomic_set(&page->_refcount, 0);
+	atomic_set(&page->_mapcount, -1);
+	page_cpupid_reset_last(page);
+	page_kasan_tag_reset(page);
+	__SetPageReserved(page);
+	page_folio(page)->pgmap = pgmap;
+}
+
 static void zone_device_page_init_from_template(struct page *page,
 		unsigned long pfn, struct page *template)
 {
@@ -1138,7 +1163,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		struct page *page = page_address(pgmap->vmemmap_shared_page);
 
 		for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-			__init_zone_device_page(page + i, start_pfn + i,
-						ZONE_DEVICE, nid, pgmap);
+			init_fsdax_page_template(page + i, start_pfn + i,
+						 nid, pgmap);
 		goto pageblock_init;
 	}
-- 
2.39.5
