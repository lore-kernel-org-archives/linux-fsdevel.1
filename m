Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC14314AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212224; cv=none; b=DTwutv7bCAv79bK2ZlnohpMPSxEcKjfgNcrWMvrvyiNKY4ns5pELYltMtBEHAG5q2RjBHIDY6FfEmSInI89jSsa+KgwZBZsRoWK1WtxEqd4VWAkoBFYmlApCWM3LEpIgiKaIx9lAqMmHN3WQzcfgCmygkG+h/f2jD/dR3MYXthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212224; c=relaxed/simple;
	bh=/FB0/SqBk6YlqdFayoLeOWZJGRngkjOT3cbxJecVoEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncUrboqRdepGaDv87FC7sziROn+oGmn26/jYRRdR6FXnGNyIHUjHEooEgE9IRgOZV9ZvfZReiXWhAXE9vw0gvf1Xvn1M3DMlzyaz4gfdTEXek+/egfaRv9ake0HoHCJnS36VMocE84rP8Vse/fKmyESSRwlftHz9E8GZl+oNqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfWf226p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfWf226p"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-492488f8583so96536525e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784212218; x=1784817018; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXj/ylmXdmqbjEPyQgiWZrVSrCcZeklAgzKFbFtJ76k=;
        b=jfWf226pzepC8/KHA4dKKSD9gI1sPbN3zQMaIUNyW5y/wtaCACNMMOnIT/Q0NQwaON
         ssV5DtEW9+vsu9KVnyXWzhGn1TaeEcajesIvU1BfXqX7B3yuusl50pJEK+YETg5aMl23
         eMiRrHPndDi4h01oTn6jQGlQerxtoDOsr7mLpWKsWVfXmHhmJtn2yds6U77b0bS0/kNF
         lthfcrzeI2nZTH21Od/yXRD6+dXL4SN7mKdCjJ+UWBeEYzg7Ftm4iXfK2WVVQzfByL8O
         DDTdeGhhs5ItutHLZ+qpUs5xPcUXQdZxVLC4z/LJQtQWx3YcktYyUN/ng7PwpPSIeuZj
         3Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212218; x=1784817018;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXj/ylmXdmqbjEPyQgiWZrVSrCcZeklAgzKFbFtJ76k=;
        b=Ubkg3zB6bQ0fG+9ieCJrfqbguy4SLotnIYUSq7SAMQ6vd5WZJk8tONqhWX2Ff8lq0U
         hGy6yCCI5jghW9pb45WSMg9zJxMQQjBXxzAvYU06amkaB7nGTopNNSj3WT7IDV95KLOK
         AoixV3r28stoL6Xm/8PAQnI+6XznlQJ0WxeA0bMb7hBhHagdjTeZK7ehklykywb9Uk/7
         VUlkbFUE7fn+Bt7xP9W/JcyfXE/TBOsCeYujZzWR9vU8sifOS637C5mxphU81htn04aK
         da2nRiEWgcjpXUK1BZiJaL21R2BfMkIgMIstlZ+3jwqU74qjm2y1i+YJhxorZTZIa/kI
         ZiOA==
X-Forwarded-Encrypted: i=1; AHgh+RpCbZk4VjsWW7oGi4MJGzA83qWKf3pxDyaX5ZGPuCjP6rATd2HKimHdYbqaxq8H3bh3rF34Im1p0/nqP/si@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdjxm85jZx+M+sRXRI+oYoPTp9ujHfVdYdtRDmqb9upKW3YVh
	VpjepS1uU7qlzvoJZTNsRcpBN+dA93r3NaynyQ48sBar1yW8BHGr9+U/1M6bmGXECe8bvfFSjGw
	0o0XhWgJJyGfUCg==
X-Received: from wmbdr10.prod.google.com ([2002:a05:600c:608a:b0:495:4728:580])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628f:b0:493:d305:b8f3 with SMTP id 5b1f17b1804b1-49538ff827dmr104868985e9.3.1784212216047;
 Thu, 16 Jul 2026 07:30:16 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:30:10 +0000
In-Reply-To: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260716-folio-alloc-cleanups-v1-1-5363b8e92d33@google.com>
Subject: [PATCH 1/3] mm: move internal mempolicy APIs to new internal header
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

There are no external users for this surface, reduce the scope.

Ulterior motive: a later patch will add an alloc_flags arg to some parts
of this.

Note it might seem like this could just go in internal.h, since it's
pretty small, but actually it will eventually need to import
page_alloc.h, we don't want to import that from internal.h so best to
proactively created this header now.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 MAINTAINERS         |  1 +
 include/linux/gfp.h |  9 ---------
 mm/filemap.c        |  2 ++
 mm/mempolicy.c      |  1 +
 mm/mempolicy.h      | 31 +++++++++++++++++++++++++++++++
 mm/shmem.c          |  1 +
 mm/swap_state.c     |  1 +
 7 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8813d5d7eb0c1..9cde99c259639 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17068,6 +17068,7 @@ F:	include/uapi/linux/mempolicy.h
 F:	include/linux/migrate.h
 F:	include/linux/migrate_mode.h
 F:	mm/mempolicy.c
+F:	mm/mempolicy.h
 F:	mm/migrate.c
 F:	mm/migrate_device.c
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 872bc53f32ec8..e4e974a6e5f90 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -11,7 +11,6 @@
 #include <linux/sched.h>
 
 struct vm_area_struct;
-struct mempolicy;
 
 /* Helper macro to avoid gfp flags if they are the default one */
 #define __default_gfp(a,b,...) b
@@ -274,8 +273,6 @@ struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order
 #ifdef CONFIG_NUMA
 struct page *alloc_pages_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order);
-struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *mpol, pgoff_t ilx, int nid);
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr);
 #else
@@ -287,11 +284,6 @@ static inline struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
 {
 	return __folio_alloc_node_noprof(gfp, order, numa_node_id());
 }
-static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *mpol, pgoff_t ilx, int nid)
-{
-	return folio_alloc_noprof(gfp, order);
-}
 static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 		struct vm_area_struct *vma, unsigned long addr)
 {
@@ -301,7 +293,6 @@ static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
 #define folio_alloc(...)			alloc_hooks(folio_alloc_noprof(__VA_ARGS__))
-#define folio_alloc_mpol(...)			alloc_hooks(folio_alloc_mpol_noprof(__VA_ARGS__))
 #define vma_alloc_folio(...)			alloc_hooks(vma_alloc_folio_noprof(__VA_ARGS__))
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
diff --git a/mm/filemap.c b/mm/filemap.c
index 1dbb4c6f824e9..0dd8e2a15d746 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -52,6 +52,7 @@
 
 #include <asm/tlbflush.h>
 #include "internal.h"
+#include "mempolicy.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filemap.h>
@@ -63,6 +64,7 @@
 
 #include <asm/mman.h>
 
+#include "mempolicy.h"
 #include "swap.h"
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5720f7f54d942..31c4e9f49b5e9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -119,6 +119,7 @@
 #include <linux/memory.h>
 
 #include "internal.h"
+#include "mempolicy.h"
 #include "page_alloc.h"
 
 /* Internal flags */
diff --git a/mm/mempolicy.h b/mm/mempolicy.h
new file mode 100644
index 0000000000000..d80fe4c559786
--- /dev/null
+++ b/mm/mempolicy.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mm-internal API for mempolicy.c. Public API lives in
+ * include/linux/mempolicy.h.
+ */
+#ifndef __MM_MEMPOLICY_H
+#define __MM_MEMPOLICY_H
+
+#include <linux/gfp.h>
+#include <linux/mempolicy.h>
+
+#ifdef CONFIG_NUMA
+struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx, int nid);
+#else
+static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx, int nid)
+{
+	return folio_alloc_noprof(gfp, order);
+}
+#endif
+
+#define folio_alloc_mpol(...)			alloc_hooks(folio_alloc_mpol_noprof(__VA_ARGS__))
+
+unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
+				unsigned long nr_pages,
+				struct page **page_array);
+#define  alloc_pages_bulk_mempolicy(...)				\
+	alloc_hooks(alloc_pages_bulk_mempolicy_noprof(__VA_ARGS__))
+
+#endif /* __MM_MEMPOLICY_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 5071177059a96..69f561332bb93 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -41,6 +41,7 @@
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include "mempolicy.h"
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 5be825911e645..8ccd03c39a407 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -24,6 +24,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
 #include "internal.h"
+#include "mempolicy.h"
 #include "swap_table.h"
 #include "swap.h"
 

-- 
2.54.0

