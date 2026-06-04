Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F103372EFF;
	Thu,  4 Jun 2026 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552420; cv=none; b=mLCzlOjsTFrDWoVA2X7cICAn91OJGCg8NYZZvvKqWrYWthGLJvPFFpx0bWumvFc6c4aLUo9DgPWUSQkktFTqdWDuS32XOsNuenOHTVrsr4b+1QQ8sVRSWJS9UrcQKwr1503RR/uUfQ0UOTMAitnlUjG+UvHwOkBrb0KiScwY6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552420; c=relaxed/simple;
	bh=4rGQj+ttPYrbAPiFOCuG9APk6p34IFP1qYSW6A86tnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovIjLrLtVwa5l3NjshuLiA59bceALgdq5QqahEE91mWTGKzUyIMmS0SS7WsmbjN99QOXTm8atxAqW5V02Q8CBQCTfKkMq9WsotJAxn20wE7LwcUgPWtda4k8pitA4IECd10h6ASX6lXcywDENpGtyWM7f6oznN5uOxexECPq2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m8xTLEBX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m8xTLEBX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7BD1302F;
	Wed,  3 Jun 2026 22:53:33 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FA273F632;
	Wed,  3 Jun 2026 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780552418; bh=4rGQj+ttPYrbAPiFOCuG9APk6p34IFP1qYSW6A86tnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8xTLEBXa3wzGDuPDeF6Vj8jVWgoOeLm71olZ/hYv2RKOQF8UTzE2+9HroqAVpxCQ
	 y6XTey5VXwD85ArnHU+jKrOAYxECB1XedJLrOhNjCVxOTmqEi2RiXl/uBdoIUg/4GS
	 JQLc5dxE2LZVeA1B+E0awCz+y4P4OtFVX5WCvfN4=
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
	balbirs@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	usama.arif@linux.dev
Subject: [PATCH v3 2/2] selftests/mm/hmm-tests: test pagemap reads of PMD device-private entries
Date: Thu,  4 Jun 2026 05:53:06 +0000
Message-ID: <20260604055308.1947679-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604055308.1947679-1-dev.jain@arm.com>
References: <20260604055308.1947679-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To cover pagemap paths scanning PMD entries, add assertions to check
whether a device-private PMD entry has the correct pagemap information -
the PM_SWAP bit must be on in the pagemap entry. Before that, we must
assert through HMM_DMIRROR_SNAPSHOT snapshot that the leaf entry is
at PMD level and not PTE level.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index e1c8a679a4cf3..46e0c8c921c3d 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -2276,8 +2276,11 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	unsigned long npages;
 	unsigned long size;
 	unsigned long i;
+	unsigned char *m;
+	uint64_t entry;
 	void *old_ptr;
 	void *map;
+	int pagemap_fd;
 	int *ptr;
 	int ret;
 
@@ -2300,8 +2303,6 @@ TEST_F(hmm, migrate_anon_huge_fault)
 
 	npages = size >> self->page_shift;
 	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
-	ret = madvise(map, size, MADV_HUGEPAGE);
-	ASSERT_EQ(ret, 0);
 	old_ptr = buffer->ptr;
 	buffer->ptr = map;
 
@@ -2309,6 +2310,9 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
 		ptr[i] = i;
 
+	ret = madvise(map, size, MADV_COLLAPSE);
+	ASSERT_EQ(ret, 0);
+
 	/* Migrate memory to device. */
 	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
 	ASSERT_EQ(ret, 0);
@@ -2318,6 +2322,32 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
 
+	if (!hmm_is_coherent_type(variant->device_number)) {
+		ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT,
+				      buffer, npages);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, npages);
+
+		m = buffer->mirror;
+		for (i = 0; i < npages; ++i)
+			ASSERT_EQ(m[i], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
+					HMM_DMIRROR_PROT_WRITE |
+					HMM_DMIRROR_PROT_PMD);
+
+		pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+		ASSERT_GE(pagemap_fd, 0);
+
+		for (i = 0; i < npages; ++i) {
+			entry = pagemap_get_entry(pagemap_fd,
+					(char *)buffer->ptr + i * self->page_size);
+
+			ASSERT_NE(entry & PM_SWAP, 0);
+			ASSERT_FALSE(PAGEMAP_PRESENT(entry));
+		}
+
+		close(pagemap_fd);
+	}
+
 	/* Fault pages back to system memory and check them. */
 	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
-- 
2.43.0

