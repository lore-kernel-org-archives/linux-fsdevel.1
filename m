Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607543;
	b=OY6+Ri7QwoBMqRxYV0vUf+9Afoui9lCyZJPpCOPO2xJpzHfTf/IKlSb9R+Gd1g29MHZO
	 igrDAY8ZdDiZc73lD6FFO+bKxnPa3LShmpMgidUW+Mc2QT34CyP4DuM2E/vS1xJFQS2Jj
	 DXenW84pXdYEk6M171glPJo4AHPsPOQtwViWEwDcuaUfQ2CW1Z55+pHoWQ3KbOpx5VgUQ
	 HelNExgvV1mXYErYBu/A6EHUGVzRQQzgVVrdGDwPT7ePXTf53kRdc5QUHQZ/hHIj3Gq6w
	 uM2YAbvlBnOz2uV4rRk9H5YPpRctoPJhlBE6ZQiTPtzFzjWGgkdr7AMKjn0zyAGsReQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607543;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5p0IEx85MBCR2rMVUw/i2xVs3HMBBruqecig4Rl8eII=;
	b=XbE2hG8bEF9Yc0BVa6i+fYemZc0AJZWWGgGqReHLlumqL2IrVbImTiYt3buN2PB5pclk
	 gh4YkZzDJBgZ4+1QctJrScx7+1a1KoXryPmk7WYAquvL75G6WQnKoC9Hqy64fP/X7Z0AW
	 VpxJeQc42KuY4aonKEG9Gg7seusk0x6pmyPQTq0e/az0WnHUT2Z66HUP9R3ghL9WnQzST
	 yaBH/fonk52Vx1wGLtfDrDzQYMMv7AXuUMUpdjU6mtFRSj5PXp288CyUcv8BaIFbw/wX5
	 KD1/WKYzcbMEavjmD/NYILtx8pcI8xyyyUAlPTmAAj0dAiTu35/HxmxAKWat3qZl4gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H9sXzbHp;
	arc=none smtp.remote-ip=91.218.175.59
Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215D606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C215D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H9sXzbHp
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l51AocTvCZiNsdm2yvtVssGtJXg23uBwouU33MbK/tk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607540; v=1; x=1796212340;
 b=H9sXzbHpOrt7N6isZz85TAo1KM1NEpj31DBDMComqrhvVdrPsNIsZqLd3bBqDhuxdF+SJzle
 H8scmjsxXxrwrVpIsGYO5UeJwAaavMzPmnFtWGrwhDaKBEVRLJn37kKVQvRzRrD8ZM6+f5PhgPZ
 5bBXI0rDkJphQhZYqFeQbTjI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 18911eca4fa8caad;
	Wed, 25 Nov 2026 11:52:20 +0000
X-Mizu-Trace-ID: 18911eca4fa8caad
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
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v4 1/3] fs/proc/task_mmu: read the PMD once in smaps_pmd_entry()
Date: Wed, 25 Nov 2026 03:49:57 -0800
Message-ID: <20261125115014.4014507-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261125115014.4014507-1-usama.arif@linux.dev>
References: <20261125115014.4014507-1-usama.arif@linux.dev>
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

smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
into a local with pmdp_get(), the way smaps_pte_entry() already does
with ptep_get(), so that every test sees the same value.

No functional change intended.

Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d2a524c6ad4b93..cb5e335bf05da4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *page = NULL;
 	bool present = false;
 	struct folio *folio;
+	const pmd_t pmdval = pmdp_get(pmd);
 
-	if (pmd_none(*pmd))
+	if (pmd_none(pmdval))
 		return;
-	if (pmd_present(*pmd)) {
-		page = vm_normal_page_pmd(vma, addr, *pmd);
+	if (pmd_present(pmdval)) {
+		page = vm_normal_page_pmd(vma, addr, pmdval);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
-		const softleaf_t entry = softleaf_from_pmd(*pmd);
+		const softleaf_t entry = softleaf_from_pmd(pmdval);
 
 		if (softleaf_has_pfn(entry))
 			page = softleaf_to_page(entry);
@@ -1046,7 +1047,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
+	smaps_account(mss, page, true, pmd_young(pmdval), pmd_dirty(pmdval),
 		      locked, present);
 }
 #else
-- 
2.53.1-Meta

