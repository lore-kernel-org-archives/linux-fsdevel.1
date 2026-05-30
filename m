Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD45397E89;
	Sat, 30 May 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131288; cv=none; b=IS7+WTekr10FH1/liuH+/SBnO8dyTJ5JLq8RBc4/keTX4+jxioIb/dV92nBImJgbbdzsx9ybtXEi4ALQ/WFM0wFPVLLZEepbq4Bh07g5o5GMUgRjqKSS4eY9E8uDhuEEq5Fz1FLsKsvW+XfrlqqaJWQqYalcfj9Yhv1fesQ3kFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131288; c=relaxed/simple;
	bh=4cZov+A3y+NozKLYxMCn9IIRmUK0h0TSROhccA5wsa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/ZisUFNXoiqrCL8b246cxL1wM9uMKdRP+iWmmrRaSxbzB5G8mGBVfZodFKjoTOPGVHhkJcjzEOV3ZxtM/hOQ4N18TKhGzFZh/CjYBnV0E4sO2QiU/6RelmViwP7YKOyOF/EczKQ7d/a1d33dw/es6GT4WrMlGSbQFHIXzx2tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J7vXrRCj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J7vXrRCj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A27CF3515;
	Sat, 30 May 2026 01:54:38 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443803F632;
	Sat, 30 May 2026 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780131283; bh=4cZov+A3y+NozKLYxMCn9IIRmUK0h0TSROhccA5wsa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7vXrRCjeTz2K4K0t8Fb3OQAuJPDHX31KDGsmxXofYv0yvYJf/qvZ2wnpRROnnaYP
	 e04nFWjsRPDSwCg1cDKvzlSgwdatl7o2A8PHdvJc0b/SICzm4S0K6Wp56KYICONENR
	 zMn57gcJqiGle9dAxIDEtfCYkzdGByEtp95V17l0=
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
	usama.arif@linux.dev,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH v2 2/2] selftests/mm/hmm-tests: test pagemap reads of PMD device-private entries
Date: Sat, 30 May 2026 08:54:12 +0000
Message-ID: <20260530085413.1270139-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530085413.1270139-1-dev.jain@arm.com>
References: <20260530085413.1270139-1-dev.jain@arm.com>
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
 tools/testing/selftests/mm/hmm-tests.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index e1c8a679a4cf3..d09d4a9081de1 100644
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
 
@@ -2318,6 +2321,32 @@ TEST_F(hmm, migrate_anon_huge_fault)
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
+			ASSERT_EQ(entry & PM_PRESENT, 0);
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

