Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85254A263C
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438129; cv=none; b=A8fcOVcemtPOnBVvNtsjqxDhvGHjNd5kb5ghnJbnVC+k92EmHEqvuJhoA/WsCHAN5vVqMzv0pJbRXqc6hR/zZl9e3UPq4Q2xomDogmCWmztNffwNu0hmCgsCkMCiPhmp5TXJBYl2l/d5xl0N+CXbffhhH9dfZLO10gpolPjxHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438129; c=relaxed/simple;
	bh=Hr4ffWVPhBSeZxC4Gy1Y+eU1zBxu0o3ECl+FjVnr0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb/PnvBZDVRuozAfOfiCjrVgtlSWkNtBKyuGJVFEVuyEWR6+eEPiNMoJ8ICclY+oT2t8zFtq7ow8Ef2Wrj5wT+inIwB3hIHXqlL29/jaCxgxvYfB2sq78UYMll2Gj1VL8nKuJl3G1E8mzKg7g3ZO84pzS0NRX2UlMnVMyyiVolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RWG+aWal; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RWG+aWal"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso961071b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788438123; x=1789042923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9z1xem6qEcuUVJMDQZaw5sCruZ2xCngKTtcTUgfBOA=;
        b=RWG+aWal//mu0570ElQqXgIyvLoBB4fV/tAp6++naU2L/Qg9JeA2M5OYgvXXNOvA4J
         RZD+GveZDN3y1LXQUkPnGIH9LNzEGDQGnkFbXXqF/O/PsiZ0igp0P/VlhACYROUjUrip
         7dIh9Af/nBtQkcWhqiJrrOJcf5KAn5Bfa0FMihwv8db2+xpzNjsgWiZZ8TGO+6IWT2Lk
         4Cln5SG7SS5DrCQYharZIUz8B+CjFr4UKvcBm8PnmT5JvpXOuEcIXQpFY85k5CdGoCEM
         B0awT7HFaDl9edSZy4H21ugQdnGpebN7CdY3K9K2/heLnARu0Dl6K+n6XbMLcU9xbUCs
         Fglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438123; x=1789042923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9z1xem6qEcuUVJMDQZaw5sCruZ2xCngKTtcTUgfBOA=;
        b=h0UGfJEqSn0UOhq2dhm/Tz0s/R9xuJBrzHwRAVaP41KNsPsfxcZRG4iqdJ8XD00Wmd
         g/zRfMhBG3AU5821pZsNAdUo0B0mINydK0sUZQSbuOPnzkr1XnSBW1qzVdC6G3Z4da4E
         eeptMEKb2w/YMrCZuG3YvGqG6MnUmFrXranwLHGZyqUqx1Ha5aFU/aN39ZWKlkRkyQaz
         IdTyTnMJlpQ/QAp9FtyKwMqJQUsO5lOgypd4iaCCCqFq1s2DeNheCV2GUH0wgQ7u3FqR
         d/xnYMvFt2cHfG+KVTXihA6S3UY9O2ITzdGNHxTeLDVoP0mXRym0mPEMuM3W7nkDbegu
         04dQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGKvubc3aGQ+fgR5zlDw0b+CtZbIAj/yB/9Gl1khojZDYBfq9pEzVa6EF6NbG2pSLr9RwlFkOtcKJIUvW7@vger.kernel.org
X-Gm-Message-State: AFuF++kJz9iLKIRhvzTQeOUVqOLh+TWXbOmadcRNdDW5m9U8ScFJAyTX
	wpmJrUhQZYd34muUQHvrjn3xVLUhy+sz97DZuJTdXL7YX7RAFnsVekHJXpwRZSc35XI=
X-Gm-Gg: AYBFou3Ks7S9ivOiYkSI48fOv1YbzXMDy/cjntdm5Qh1m0aN5yGf6VMGSFaLdCmiZN1
	w/1ZAwiS84p9UURQY3wunMeKsNs45ZQqvCf4HC3qpp2Yq2cv1FRtafY+MPSfl+fvDW4FUjr8eUw
	32PoCI6KffF9fhhctXeppFrkA0AA7loJUKPUqbLMcOSJNYvU11BiD090hf1gDE4P/jq5lgVfAte
	lwTxZVPR61mLA9RA0u7S4OWZAC4WT+WequE4julrfmv0AHqNuj5xvaQZP1LXLFGaO/vlc092X05
	QQXvigZkvCHSO3od/hFv9r45ARuVnMCll3awHGiT22rMttQxeDC1ubKPvFiGc3OMp1V/PmkvILU
	kKAmCnToYwx6EQ+V6N68X79Fgq2dU1fQ/C0peu06tMBvpodWKNgv63QJNKRrXYljR3lDipX2mgU
	X/PKG1jkrR7mglnhkCdFnpzjgXBGDlSiNeGeuvkPhV6aabPW3GQ/bkarGUMCRBxLFv8DMcCymGv
	TtcE85HOt76+pEUPgyU54mGZw==
X-Received: by 2002:a05:6a00:17aa:b0:84e:c851:a058 with SMTP id d2e1a72fcca58-85ffcb616aamr4808528b3a.10.1788438123307;
        Thu, 03 Sep 2026 05:22:03 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm2868126b3a.4.2026.09.03.05.21.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:22:02 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 4/4] fsdax: materialize pmem vmemmap metadata on faults
Date: Thu,  3 Sep 2026 20:21:27 +0800
Message-ID: <20260903122128.12264-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903122128.12264-1-songmuchun@bytedance.com>
References: <20260903122128.12264-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pmem FS-DAX registers the device range as ZONE_DEVICE memory, and the
kernel normally allocates and initializes vmemmap storage for every
advertised PFN up front. Sparse backing storage and workloads that only use
the DAX direct-access path may never need writable per-PFN state for most
of that range, but still pay the memory and initialization cost.

Opt pmem FS-DAX into the shared read-only vmemmap mode and materialize
private metadata before inserting a PFN into a userspace mapping. PMD
faults materialize the whole PMD-sized metadata range. PFNs that are never
faulted continue to use the shared metadata.

This shifts private vmemmap allocation from device registration to the
first DAX fault for each metadata page, so the struct page overhead tracks
the faulted DAX working set instead of the full advertised pmem device
size.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/nvdimm/pmem.c | 1 +
 fs/dax.c              | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b14f75daeda7..5530b32163d3 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -543,6 +543,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
+		pmem->pgmap.flags |= PGMAP_VMEMMAP_OPTIMIZATION;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		bb_range = pmem->pgmap.range;
 	} else {
diff --git a/fs/dax.c b/fs/dax.c
index 1fbba0d21c13..89377301d51b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/memcontrol.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
@@ -1877,6 +1878,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
+	err = vmemmap_materialize_page(pfn_to_page(pfn), pmd ? PMD_ORDER : 0);
+	if (err)
+		return dax_fault_return(err);
+
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
 	if (write && iomap->flags & IOMAP_F_SHARED) {
-- 
2.54.0

