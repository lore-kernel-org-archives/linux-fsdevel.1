Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A834968E2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438114; cv=none; b=gHvJoP9f04VizTu4oP2siepFuhn1Tcpmtp/YcXOjRdc9sO41BCA4toT3e7VbVMc2A1g9rUMIN+CEMq3GWwZlCcivozx7RR7EWYY4/cRUwDMG66PmognbsO3YKXusAyvxQt4qfT7dtnQqUPb3me96Kvzl7o6WKN8e02Rz5xdk+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438114; c=relaxed/simple;
	bh=1xK9WvOdopCQR3xT8/KKn1WUP9dISFUQ63DhqRI1yGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAqnWZE3kJ9a1UvdwXCFnqsI4nfhupymdj7RvyvVj3KBBT+6yPZ3P0B1vbk2+zcf+nCL+3mNg9TYQ1IPbKepwJo7YicbFeyHPUsERkHC0pL+1GrE4kz3xYQh5MR5yB0a0KWZ/HKWW1DjK5+B/kTxHvQR6WmPfCtHNWWwe6eRcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZOZMgHT8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZOZMgHT8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-851cbd64814so996612b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788438103; x=1789042903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eoj/Cdya14SPLIE+VKDTIKpgRBY75qMbCQGmPe9FWn8=;
        b=ZOZMgHT8PXtoPkqvhqJR/vendSycyAVYQezQK1nYzDtHrz5L6u2GuOe/qImfnNvSdy
         W1Q8pXZ3iMn4h8T106eim1zOo+gFtjorISeaynxTc3xL4l5S+svlBgEeINunnD9MLL5K
         7GGjKc6oQQkUs7f/IXIifOBSGHS6SE4RuUl4ziJkxmTAt8+QhCK+656bvg+tzfC0pb0D
         C51xbQOUGx/g8eosXJXS2kYyu4Q0Ve4B+r6yo1yafdctL2Zg58E3Zr02p6pcCFL8mJlE
         yaGRSI4ymls4+TN3LF+5+cRE6yMV48xHYhMAP2bzXTW5maKqzkdA5mfFZ4k+SonWMoeg
         QTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438103; x=1789042903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoj/Cdya14SPLIE+VKDTIKpgRBY75qMbCQGmPe9FWn8=;
        b=VPMzOtp19c2bzFjMAjPHPJgk+nzhDyxZeTLNGCa+o61t52kFWbZmr7qHzpgEikQSOx
         FKYFzlI03OT27pGbnHtoOj/4mSd27MPYZCCq7W+qjcEKh99YbyStLZs6BM6uNCGUS6nQ
         drWLsMR5N6MCEzXKH5hVb20SUM8AMtKnOL7TiBFvpSs+te9NAxJkPwAPqNtfTBx4Y5Ho
         4DOxNEerta0u+AfXgh8264Ui2dDYk18fbZErqImB7kY5Uo8C47fWdAzPvX5bjNS73iG9
         1O8/g3zEcAuQH/gGAGpmjs/5m78VXJ/AZnAWVmbsVMbYVYilqUKiq/uQXCNTx3PT4mxO
         awsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDCvz6+qOd0H8MmBTlyRSX4sUhkS/EYlmibnq3XCSdggTBp8blCQXON8cVrgNhRPoYeZHGxH2jxtbO/cDU@vger.kernel.org
X-Gm-Message-State: AFuF++nptSxZiMi2urkGsZeneKcQf91019OsmJPopxYbRgjba3tT6OdJ
	5+9NBdJ01g/M0tVCDOljeu7H6AnJ6AwhMfh0QSVGJSOBsf+p8AZkUdHATWOxIhYzV5c=
X-Gm-Gg: AYBFou0bUw4KKSVmuxck4uVH1/ngfR2Y5pQNRbJhbvVI5Qas4e8qWElUtWGNPiYVERP
	2zaLQcViqHxsXzC6ARFSHUBzDC+/+zD78Ooaz515bIBqWDEZvRt6PSGfrP4CEuKtrDIYxrJWCkV
	ENj6XL+orcMaH/dP65er1WYqziwE61cSjklP/8xx2FUB7YcS+D+2kQ8o2rHbTzKkjeznhYhgvDu
	EMK8iIq2SPEpT6sB11Eb9ZTfC7QaecZ11J9QLf5gdpfSo4s86hiJdCslStPvivHDvxr1ZOKkxDV
	tFL5Cm05EHtuVrntUytA4hUXyJo+NArUJJwfuWJxFR7O46XNlZYEowCC4iii3HyIqosCnAVAPRd
	1LdtfZwwEZm5++K138ByDikjpAM1fpfBr7QkL5I9c+Z11+tGmGx8B8Zbrntzq+BZWO0KHP/IALN
	J3CoPHJ5yOJoOmuzZHDqRBL8i0wasjxZSgM6gcgNw28Ap7b9O8qyqNe1dJdWDpWrGhkhNGvAIwo
	cAJIa0iZEcjym9Kee1f6HpXXw==
X-Received: by 2002:a05:6a00:c4c6:b0:85f:b00b:8760 with SMTP id d2e1a72fcca58-85fb00b8844mr9445221b3a.5.1788438103076;
        Thu, 03 Sep 2026 05:21:43 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm2868126b3a.4.2026.09.03.05.21.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:21:42 -0700 (PDT)
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
Subject: [PATCH 0/4] mm: Reduce struct page overhead for FS-DAX pmem
Date: Thu,  3 Sep 2026 20:21:23 +0800
Message-ID: <20260903122128.12264-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AI and code-execution services increasingly run user workloads in
short-lived sandbox VMs. These VMs are usually small, densely packed, and
backed by sparse disk images, so both memory footprint and VM startup time
matter directly for consolidation density.

Using virtio-pmem with FS-DAX for the guest filesystem is one way to
reduce that footprint. It avoids keeping a second copy of file data in the
guest page cache, and turns that cache into host-side file cache that can
be accounted and reclaimed with the host's global memory view. Host-side
page-cache reclaim is also more direct than asking the guest to drop its
page cache, waiting for the freed pages to be reported back, and then
reclaiming the memory from the host side. This makes higher overcommit
more practical for dense sandbox deployments.

The remaining problem is that virtio-pmem with FS-DAX still pays the
guest-side ZONE_DEVICE metadata cost up front. The guest registers the
whole pmem aperture and allocates and initializes struct page metadata for
every advertised PFN. The vmemmap overhead is about 1.56% of the pmem
device size, and initializing all of those struct pages can noticeably
slow down startup for lightweight VMs.

Much of that private metadata is unnecessary in common sandbox setups.
Holes in a sparse rootfs image have no host storage allocated, but the
guest still allocates struct page metadata for the corresponding pmem PFNs.
Also, many filesystem workloads access files through read(2) and write(2)
rather than mmap(2); those DAX blocks are copied through the kernel and do
not need to be inserted into userspace page tables, so they do not need
private per-PFN struct page state either.

The key observation is that when sizeof(struct page) is a power of two,
each PAGE_SIZE vmemmap page contains a naturally aligned, repeatable group
of struct page slots. For an FS-DAX pmem range at device registration time,
those slots only need the same ZONE_DEVICE and dev_pagemap state before a
PFN is exposed to userspace. The kernel mainly needs the vmemmap to resolve
the PFN back to a valid device page and its dev_pagemap. It does not need
independent writable per-PFN state for ranges that are only accessed
through the DAX direct-access path, or for ranges that are never accessed
at all.

This series takes advantage of that split by separating vmemmap population
from private metadata allocation. Device registration still gives every
advertised PFN a valid struct page representation, but the vmemmap mappings
initially point at a shared read-only vmemmap page containing the common
ZONE_DEVICE state. This avoids allocating and initializing private metadata
for PFNs that may never need it.

Private writable metadata is materialized only when it becomes necessary:
before a DAX fault inserts the PFN into a userspace mapping. At that point
the PFN can participate in the normal page-based MM paths, so the shared
vmemmap page is replaced with a private writable copy. PTE faults
materialize the corresponding vmemmap page, and PMD faults materialize the
whole PMD-sized metadata range. PFNs that are never faulted continue to use
the shared vmemmap page, avoiding both the memory cost and the struct page
initialization work.

A natural follow-up is to make this optimization reversible. Once a DAX
entry is removed from the address_space, and after all mappings, references
and pins that require private metadata are gone, the corresponding vmemmap
page could be remapped back to the shared read-only vmemmap page and the
private metadata page could be freed. With that, the guest-side struct page
overhead would track the live DAX working set rather than the full advertised
pmem device size.

Patch 1 renames the architecture opt-in for runtime vmemmap remapping so
it describes the generic capability instead of the HugeTLB user.

Patch 2 avoids touching PG_hwpoison state for clean pmem pages. This keeps
the normal clean-I/O path compatible with read-only shared metadata.

Patch 3 adds the shared read-only FS-DAX vmemmap infrastructure and the
helper that materializes a private metadata page on demand.

Patch 4 opts pmem FS-DAX mappings into the new mode and materializes the
metadata before DAX inserts a PFN into a userspace mapping.

This does not change FS-DAX data path semantics. It only changes when
private struct page metadata is allocated for pmem FS-DAX PFNs.

Muchun Song (4):
  mm: generalize vmemmap remap architecture support
  nvdimm/pmem: avoid HWPoison flag updates for clean pages
  mm: add shared read-only vmemmap support for FS-DAX
  fsdax: materialize pmem vmemmap metadata on faults

 arch/loongarch/Kconfig   |  2 +-
 arch/riscv/Kconfig       |  2 +-
 arch/x86/Kconfig         |  2 +-
 drivers/nvdimm/pmem.c    |  3 +-
 fs/Kconfig               |  2 +-
 fs/dax.c                 |  5 ++++
 include/linux/memremap.h | 11 ++++++-
 mm/Kconfig               |  6 ++--
 mm/memremap.c            | 38 ++++++++++++++++++++++--
 mm/mm_init.c             | 11 +++++++
 mm/sparse-vmemmap.c      | 64 +++++++++++++++++++++++++++++++++++++---
 11 files changed, 131 insertions(+), 15 deletions(-)


base-commit: 32b6ef9a5d0eca44f9cd91f52f4faa89f145a0de
-- 
2.54.0

