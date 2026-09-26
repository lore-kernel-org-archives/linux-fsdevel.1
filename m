Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00E40F750;
	Sat, 26 Sep 2026 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419292; cv=none; b=Ld+7PSRh+VK37JZQReNkuwzTcke0P05cqnGuocCDDg+7YHJozapBErkHfzwds5Sz7ej5CsJrpO9NgEsGKY9XHiUcKzSjJ9QXhK7NdgdOa5kMdKszJDfh3eie0b4vXcH7txRmc81hXpMZCd7azM6AEGQp73deNVNJcJNuYTaT9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419292; c=relaxed/simple;
	bh=QmSOJwju5TfiPg8slA7VLmMjfjzHO2fnrvsHpTcasuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNeeVR92qQo+LgDD3oULHk+kTx4MybYYOf1k0xsr0WKpH7+QLkFFk/0PmI/p18E43rN2NyOT0DNvaFZLc+8sCFdoBx9WWnyz4Cr+xpTMBMQbOJhCXYcWawdgOg2ZdJEj4UK1cMfLu1bzOPEIBCfrQ9jmXyq6KsIsOLMeRQwaotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDlwayMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDlwayMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B241F00893;
	Sat, 26 Sep 2026 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790419286;
	bh=SN9pBsYau6XqA12Xdl8N5Dmjue89SDbE0U+vn84I9OA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SDlwayMniSSzMZ/yLnVoRDTY/aOgPvhOA2LDiF/HlKzgD59VRgg8qfLbmWV7AjCq6
	 KcV2jNVcf1F7ESdYqqNdVr2WdSLVNuqYjM8FKZInbRK6pksEv45OLMbpbPiXYiakAv
	 GzJS+FJWIy3W4WFfo5Ti/kaKJ2vJzLZfe42+vQTxNR8h3N6RwzclBbPRVCG/jNPeY6
	 sUw2rWFuNimrCLiB4hqW0C2nrzcAH9Wh9uh0Mm4I72cvVZR4P9bdx4pR+3TofHvUSS
	 BAxuw0Jqca/FbYdDyfMaLQlNrMTYCBgzl/QDCcLbquBLipWly0Y6peVXaC44g1vd2b
	 tvEK9r4ONorwA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 11:41:06 +0100
Subject: [PATCH v3 1/6] mm: move drivers/char/mem.c to mm/char-mem.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-map-private-dev-zero-v3-1-d4781e84ccfc@kernel.org>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
In-Reply-To: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; i=ljs@kernel.org;
 h=from:subject:message-id; bh=QmSOJwju5TfiPg8slA7VLmMjfjzHO2fnrvsHpTcasuQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2L/Q+/VRBOIGh33GV2KqlxwrmbZjPvVD3V/jBJdNPb
 NX1ezGptaOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATyVvAyHB/cdWRts5T9u3f
 F3OtFtnikhAgN4NTJtCSR8XV/EieSxAjQ9fhBx3mZfcf5SWt3Wt56MQ79hk1mUazDwhltj74mey
 5nBkA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The memory character driver implements several mm-specific features and is
always compiled into the kernel, so move it to mm/ where it belongs.

Among other things the driver implements /dev/mem which provides raw access
to physical memory, and /dev/zero which either allows mapping of a shmem
region (if mapped with MAP_SHARED) or, uniquely, anonymous memory (if
mapped MAP_PRIVATE).

This change lays the foundations to allow MAP_PRIVATE-/dev/zero to be
mapped precisely the same as anonymous memory is mapped as currently it is
an edge case within mm.

Also update a couple of comments that reference 'drivers/char/mem.c' to
reference 'mm/char-mem.c'.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 MAINTAINERS                         | 4 ++--
 drivers/char/Makefile               | 2 +-
 mm/Makefile                         | 3 ++-
 drivers/char/mem.c => mm/char-mem.c | 2 +-
 mm/shmem.c                          | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2133aec4a200..ebadf4cef076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17272,7 +17272,7 @@ F:	Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
 F:	Documentation/ABI/testing/sysfs-kernel-mm-numa
 F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
-F:	drivers/char/mem.c
+F:	mm/char-mem.c
 F:	include/linux/cma.h
 F:	include/linux/dmapool.h
 F:	include/linux/ioremap.h
@@ -17477,7 +17477,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
-F:	drivers/char/mem.c
+F:	mm/char-mem.c
 F:	include/trace/events/mmap.h
 F:	fs/proc/task_mmu.c
 F:	fs/proc/task_nommu.c
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index a46d7bf7c4c8..bb3bf66937b3 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel character device drivers.
 #
 
-obj-y				+= mem.o random.o
+obj-y				+= random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
 obj-$(CONFIG_TEST_MISC_MINOR)	+= misc_minor_kunit.o
diff --git a/mm/Makefile b/mm/Makefile
index e7245cb88c66..2a3ec53d62ee 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -55,7 +55,8 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o show_mem.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o vma_init.o char-mem.o \
+			   $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/drivers/char/mem.c b/mm/char-mem.c
similarity index 99%
rename from drivers/char/mem.c
rename to mm/char-mem.c
index 63253d1de5d7..d2e575545044 100644
--- a/drivers/char/mem.c
+++ b/mm/char-mem.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/drivers/char/mem.c
+ *  mm/char-mem.c
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
diff --git a/mm/shmem.c b/mm/shmem.c
index 255d69ebceba..c92ed17dbc4a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2981,7 +2981,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 			sb = file_inode(file)->i_sb;
 		} else {
 			/*
-			 * Called directly from mm/mmap.c, or drivers/char/mem.c
+			 * Called directly from mm/mmap.c, or mm/char-mem.c
 			 * for "/dev/zero", to create a shared anonymous object.
 			 */
 			if (IS_ERR(shm_mnt))

-- 
2.55.0

