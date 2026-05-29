Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE473BB9E0;
	Fri, 29 May 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053440; cv=none; b=Ox0sP5vmOKjmfOIaDi6vEPdza0il+2C9MgtK5fz7PGqGjsts1/PUxoBqfC7RibwCZv9Zx2ZWCEx83lU6k5k70DH3z6dR7bAUVaW3eV2pZ8+ItSaeNqZHm3qF31eYx5F1idHVU/ZvNVJVBOi1MAupZgAgC8W0pcTrZEC/SWV2RSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053440; c=relaxed/simple;
	bh=cx9bkGJ2eDRyMtzNNbeuK1dl0e/7tAqg3VyKX3JjrwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgD4Byx5vPAUnZMrxoXLDhTXGlJvcyQ/dEKUaCNMpZCyGLPX/iEp4mUJirs+jAg60WdqTfh99MKq1yUHrQzR5QHZyvBq3ZREdkz/o+YkrwYRUJDhR3pbfUA9m/3vuRZ9Up2zdybatxyTJ7FsGvy5aYBYW1lHK+2Cbf9cKmQFnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cmig+QQR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cmig+QQR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40F072247;
	Fri, 29 May 2026 04:17:13 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30ED13F905;
	Fri, 29 May 2026 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780053438; bh=cx9bkGJ2eDRyMtzNNbeuK1dl0e/7tAqg3VyKX3JjrwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cmig+QQRNEziskriXoC4pzo9VhXrb3OFQb0apJK+kRtxnbwjtcgcZktmT193CNieV
	 233HUHFvMNrJwFG/lOUU41/ZbqMDIhECIBUhNb4/7jDeCbDbnGLyA22ih+GePPa+Eg
	 Ycwv0YyxmHAIdnPjbSWPowjJt+L/O73CN84pDsuM=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	david@kernel.org,
	shuah@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	balbirs@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
Date: Fri, 29 May 2026 11:17:03 +0000
Message-ID: <20260529111704.1078346-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
entry. This became false once device-private entries at the PMD level were
added.

One can hit the warning by patching hmm-tests.c with the following:

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index e1c8a679a4cf3..7f0a3384f3c5f 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -209,6 +209,37 @@ static int hmm_dmirror_cmd(int fd,
 	return 0;
 }

+static int hmm_read_self_pagemap(void *addr, unsigned long npages,
+				 unsigned long page_size)
+{
+	const size_t entry_size = sizeof(uint64_t);
+	const off_t offset = ((uintptr_t)addr / page_size) * entry_size;
+	uint64_t *entries;
+	ssize_t nread;
+	int fd;
+
+	entries = malloc(npages * entry_size);
+	if (!entries)
+		return -ENOMEM;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0) {
+		free(entries);
+		return -errno;
+	}
+
+	nread = pread(fd, entries, npages * entry_size, offset);
+	close(fd);
+	free(entries);
+
+	if (nread < 0)
+		return -errno;
+	if ((size_t)nread != npages * entry_size)
+		return -EIO;
+
+	return 0;
+}
+
 static void hmm_buffer_free(struct hmm_buffer *buffer)
 {
 	if (buffer == NULL)
@@ -2314,6 +2345,10 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(buffer->cpages, npages);

+	/* Exercise pagemap on a PMD device-private entry. */
+	ret = hmm_read_self_pagemap(buffer->ptr, npages, self->page_size);
+	ASSERT_EQ(ret, 0);
+
 	/* Check what the device read. */
 	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);


Therefore, remove the stale migration-only assertion.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Applies on mm-unstable (404fb4f38e8f).

 fs/proc/task_mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e3a15bf46f4e..58938e62154d9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = softleaf_to_page(entry);
 	}
 
-- 
2.43.0

