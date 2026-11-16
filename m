Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811012;
	b=H6B2Qod3ByBhPV63hrsqYaNMHzQeWnFN00g/Bi/32yzf6IGVycY4Cow5I435pSAVIOIy
	 EqYhx7O2t/ie0JNUICw8sWWPk0cvYkZgChHIWxPhXE3ufOZRKm/PCGdzpmDXuVcRxoJ6b
	 SmDXShHv0M0VVdIYYH5suMp8FJ0UCe/EP9cPLspkh22MsneMuJGxUkqr/ALldylRxdD5D
	 +Qv+gv5k2FonNHZFrJtWU/2/mYhrHiC90HZre3g4TaR3tPmgBI9ellCTBAQS/liB0LVvo
	 Em9NSKAvxO56rtBo93eif1N9iF7aFuZd0nL7xmi6pdct8Z/lmfCAsldGze+TR1sZKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811012;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hd4SQF+1L7e8YtGflxA30HMxE4b1cNs0ce33y36EA60=;
	b=XcYAK/hWVikDmhvZD0tB77yH7nCL71pYbvaQJfAyKX7i1s63FogychJI/F9Lc7HLCxQN
	 5tEiqKw4xfDS4O0fBBOi26QeibqMR/vXGo9PkRTvGAo2v8cKX0koOrQZtwpwbCegiD4UT
	 ZIHVOHe7v2l5xb0T7RBYab0ohVcvSqgjTHeRA3s3xSPtajSfAkl91sEvarY9XE3A6u8w4
	 WSSa4b/XO3ZDnswprCGFXMMpyM6Dc1BG2mjf0caFU8jZbyfBvXt8wvJjDspLMJnqh7LsB
	 iFciOseP6lcqQgzJ+P11e3pol8fU4hHDxl1gqOBQtIU2MQ9FB7srbO8ceCS0OIoHQUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Netf0Q8+;
	arc=none smtp.remote-ip=95.215.58.91
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA6606A335
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 06:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6AA6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Netf0Q8+
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o6YMBbWCU4WJ1J5424/7Klz5ro7UDAr7ojCH/NxJ8fU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794811009; v=1; x=1795415809;
 b=Netf0Q8+SQodXHuzRshZ5Kej+ZCmSSpoAPZClyKtqYR258jxeDEkuekybFzuzEqTs/rh38f/
 SsS3MQhoIM/5/ed3SoOpyLjQLgN2mS2BeN5j75GCWh/Lr+RwIsUvV7X5Mu3V6Me4EgVcuRculGF
 Fdahuc67Dz5E93xH7DtwdXCQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 94c6d5c2c26d4ba8;
	Mon, 16 Nov 2026 06:36:49 +0000
X-Mizu-Trace-ID: 94c6d5c2c26d4ba8
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
Subject: [PATCH v2 4/4] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Sun, 15 Nov 2026 22:34:58 -0800
Message-ID: <20261116063624.1382944-5-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261116063624.1382944-1-usama.arif@linux.dev>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
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

Device-private PMDs represent mapped pages, but smaps_pmd_entry()
passes present=false to smaps_account(). That treats them like migration
entries: mapcounts are ignored, PSS is charged in full, and exclusive
mappings are accounted as shared.

Match smaps_pte_entry() and mark device-private PMDs as present so
smaps_account() uses mapcounts for PSS and private/shared accounting.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad9fdcdaa2c40..6345bb143f200 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1042,8 +1042,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(*pmd);
 
-		if (softleaf_has_pfn(entry))
+		if (softleaf_has_pfn(entry)) {
+			if (softleaf_is_device_private(entry))
+				present = true;
 			page = softleaf_to_page(entry);
+		}
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
-- 
2.53.1-Meta

