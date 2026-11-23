Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451601;
	b=YGqO9/dKrOiKvx5NrzYKJF2itchgT6OvHuhLPsYSU2zYihDXDzkDnrYxHL8y3OgwDjVo
	 PNTQcJFa7+pIoZN8SV0W9z33GZUYS85GVYBpA34rTW4PHx5ssPGxsIA2gwmy7rMhbUdM5
	 BFVxK/+aCoj3jm9x24+xYVpz0mut2dbYP0L5WfJOGAYUOgFlnwrorPNX3K45l6WF91zZm
	 gidJkmqmChUdrtwOuPi2on1A1ohp1RQnfiv0qyLVDkGK7b0wy6OphRx54ddg/NEORhIMg
	 ZSOvcqqVyC73wnNwm9xCU3y51QP8bNpkEILrFLskXfMjezaXEbw5+m/s0yG7yTIblxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451601;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iHqXIb026uSXJYBJhjPjkt86/V6MV/kI2DuMRyyjh6o=;
	b=ftxwG51cbJ50WObrN367/exg1oCheuL7oTHiXPvJ4RdwAn8h0tfVM3s7RGc0NGTpePYA
	 MeQXDyK6lCXMptN3PRE2pQhr04g/atlLcsqAX9vqxSX+Y6MVKyHxdqhCekg7Z/lWGqNWi
	 Rnh4kwW8oXaozljIQBE3HTL/9kpRBEV4HpzpiGaGPj0ccVyL0LtIVZYOoEHTD036IlCbk
	 ABr7BkgXd6WfTDteRuHoE02+uxALLAB7DtimYR1DFuuDiw6k76kjHAguikeRPTSDqmmGO
	 dnv6p2fyoCWyLrr5BO/x4XpQEQNCrcos6Gl3FuFzhLB/6UIK4FqaY5sRPyNRuUBCiAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HBNjAsOO;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A435606A327
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 16:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A435606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HBNjAsOO
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/0wwfmfO3rHlK4K6Y0qZ9SSTUSTnaQnx867yqHOwqOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451598; v=1; x=1796056398;
 b=HBNjAsOOaPHvdroCzQmNe6NTzDbrPQpVhzQBiXl2pjpCuUueWeUfh3iXjMRP7seoS+zpOfBX
 w6tLFKQoxsSRcZM03lqSsACdSzS3Wiy4H4wZjHNRT/0LubEl444am3rmwfKDBfDxu5d70or3z2m
 lCkOfMPBGODGQW+npAwtbBKE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 82a19ca6e1a70be8;
	Mon, 23 Nov 2026 16:33:18 +0000
X-Mizu-Trace-ID: 82a19ca6e1a70be8
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
Subject: [PATCH v3 3/5] fs/proc/task_mmu: read the PMD once in smaps_pmd_entry()
Date: Mon, 23 Nov 2026 08:32:09 -0800
Message-ID: <20261123163301.1568240-4-usama.arif@linux.dev>
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

smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
into a local with pmdp_get(), the way smaps_pte_entry() already does
with ptep_get(), so that every test sees the same value.

No functional change intended.

Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/proc/task_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 540c936aad4714..105c4998eef48f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *page = NULL;
 	bool present = false;
 	struct folio *folio;
+	pmd_t pmdval = pmdp_get(pmd);
 
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

