Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451593;
	b=NPcnUzMEUqk+4vcR3jwEKj8Zoex2ECBGcP5nUxXQ+FkPchSvMbUwICArIPgVR6MH1wCc
	 teW/TJ53yGpA2NmfIRXux+Gx8P49qjqjUsakaagV6E4gMXsCwIbh8xd3UVqYq0BcgXhtO
	 J0/ZPcnSsth0Nqo85p+voGTXNP8ae5tCHq9QRUg4Fowss3SYdtk7zcaItSdIQlVg7FFSU
	 XBiObavAVSM2/IdYe7Z7Uh8RDYLF7dc9oj9cup43pyx3vJpWfAST6PshGCA4kEn+37M9d
	 y8ybVgEUWoInzGL0tThkPmoAzxNmyQDWsTmHP5tC+8gQyh2HGz56m+b2DlL2oNtzmDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451593;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fwWiH4TsPLewrmvX2AV6vJSDmcGS5DTBi3bpUFUWZos=;
	b=DFppa+KdrOGll5A9AQZ3hMql2g8Jt80A6o6KRcqb7XMEU3o2Vi9mmLQoIErg+UbG9I+f
	 0/iyEnY+aBD2VF+1SW1F38kwh4x7Z59eS16fxPCyHxqMujFgkLLtIdifqGOsLbF/P1do8
	 7Tk3n1fA1Ykbihl0A9n8sMhHEksPhHOCLk65rSIzdKECEzw16tTOwVqhfVImZXcausfgV
	 U5hZIcTS8IMLB1vrJYn6tvs6Lni0RF1X/lUAKZ8uvtwTCQaIQe7u2WtuBi/CV88MiE0kN
	 E3rX0I+Z0N208+3sk8UALbNoEZ2l/Zq7m9Rn+xAa8UvAAbPVwEAVaShzPfVRX/Ax4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DVoUES+r;
	arc=none smtp.remote-ip=91.218.175.195
Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A9606A330
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DVoUES+r
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jZKaGu0pxutsSN80ekzFiD3bJEXetF6Gf5LZ+jjPkrg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451590; v=1; x=1796056390;
 b=DVoUES+r/i8B52JHyStfl7du2iLFcOUFHmLbKUJuEhCNalaBU1bCmj04h9PneYT6NM5PXYoI
 iWslqbj8qfiZjfROTe3tpUydS6wuTwi9gBPzEtPP8rWvKcMTEEKUEeLTakQ0MNEg0xyZ4sSziLF
 ecfZl2XYvwpFdk/Gkv8pU3EE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 9be87c2e82eba38f;
	Mon, 23 Nov 2026 16:33:10 +0000
X-Mizu-Trace-ID: 9be87c2e82eba38f
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] mm/migrate_device: avoid leaking folio references during THP splitting
Date: Mon, 23 Nov 2026 08:32:07 -0800
Message-ID: <20261123163301.1568240-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
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

migrate_vma_split_unmapped_folio() takes an extra folio reference because
split_huge_pmd_address(..., true) drops one when it splits a PMD.

However, migrate_vma only holds mmap_lock for reading. A concurrent
MADV_DONTNEED can clear the migration PMD, or split it into PTE migration
entries, before the split helper takes the PMD lock. The helper then does
nothing and leaves the extra reference behind. folio_split_unmapped()
fails with -EAGAIN due to the unexpected reference, and the reference is
never dropped, so the source THP is leaked.

If a THP is faulted in at the same address inside that window it is
worse: freeze = true replaces the new folio's mappings with migration
entries that nothing will ever remove, and drops a reference the caller
never took.

An existing migration PMD is expanded into PTE migration entries even
with freeze = false. Use that mode and remove the extra folio_get(). The
reference already held by migration keeps the source folio alive whether
or not its PMD migration entry still exists.

Reported-by: Zi Yan <ziy@nvidia.com>
Closes: https://lore.kernel.org/all/DLZ48KMS7YG8.3BTM0UUU8CTU2@nvidia.com/
Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/migrate_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c67..3286bb8a4b73ee 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -920,12 +920,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	unsigned long flags;
 	int ret = 0;
 
-	/*
-	 * take a reference, since split_huge_pmd_address() with freeze = true
-	 * drops a reference at the end.
-	 */
-	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	split_huge_pmd_address(migrate->vma, addr, false);
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
-- 
2.53.1-Meta

