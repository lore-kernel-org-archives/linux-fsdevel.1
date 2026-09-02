Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C605383C8D;
	Wed,  2 Sep 2026 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372053; cv=none; b=qMcwAdQDwAJlNjz7VYI10m+Oi58gnJDNdLmMfbLjPZ07enkAPzoyjddG0bUrpS85WYYDh6YPcHlZA3Dq/+9oBgVepwhe+sdbdW0BWur/z5oTRIjjWrhervo2NkDbkHGw484HugSyrA2IZv78+BbZccgWi0WiJPWqakV0b2g4iCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372053; c=relaxed/simple;
	bh=+lQ64M91uOCmTZQebnoxYSvQq7Jfy6kZG9l8lKXW1J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRSPKccaIMs5PesmvD2JKS0lOIjSws/x+GSuzKCzT8fA1S/Wip06uAFhqKa4nhW1ziJmYZfthogd/0Dhrh0hx9efueoLqvYz3Ak279nI5OO/RIIC3MHLLxItlj2vYz/NIc9DspRtdwjd9u4tKTKipOzPrZCT3Mshfvu6MEvYYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGydZTsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGydZTsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90601F00A3A;
	Wed,  2 Sep 2026 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372051;
	bh=FkujdrJ/pdcNwpIbp+sSj6hn+DXxw2Xn58xtJMFlJxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OGydZTsC4RGgesW31RFvGv8NgGNrrRKWaqywQDMxbqsW3Wyx/EAVj4VvJR4KJQbPD
	 hym+9RctbEOEGHMpWGfFbBe3BnGzDbiq24XumBUsaPFDDJaTAoU8HQI+YJHXCFOK5g
	 NgZh6lej/czw/qPob3S7F7vTewedg/mXKnNvl9bdyz8PJayZs4oGeHzKFSk4O92+FK
	 Bvp3bCd6znxQJFZrEFrBVszkU5TEgG6yVESvbT0BrYMJCmt+ZQpPaVkwC+dQ6lRCpl
	 d6OeS478mdWn1liNL+w1RxG1n2/Ml2n+QqX2Qu9+MSrvgcT3P8BLCMCJLKzxNCkmJV
	 /kJ5V4j43Y/xA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 02 Sep 2026 19:00:18 +0100
Subject: [PATCH 1/6] mm: move drivers/char/mem.c to mm/char-mem.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-map-private-dev-zero-v1-1-a578c730cec7@kernel.org>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
In-Reply-To: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3541; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+lQ64M91uOCmTZQebnoxYSvQq7Jfy6kZG9l8lKXW1J4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpHg9UN0a/7/TWUg8x1o8wJEhtUpBeIuz+fbSa8W7/
 zObn2PqKGVhEONikBVTZHn+RXx/kEjYvM4L/m4wc1iZQIYwcHEKwES+nWVkOLx4/glBmX8CS0Ju
 N0R7HdjYZGh3L3mhVNVJ0x2/leXSuxkZvrf0GS0/11DnPH/nmmXZixev8t3nq/U/6vO9NzdmC07
 7zQAA
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

