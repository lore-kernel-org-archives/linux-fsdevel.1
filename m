Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607552;
	b=JrbHiWoAv3G9yXv/zojGEwf8vXfv57CfxAMVgWeE9Qj054SZtbrRqGOvdG8H+fDIIYX0
	 3wa8p7deJsdpS2GJq8hU+0KSd3TSs/WBVgqeU+xBmDwoq88/BuUiPFybM/JmG+m/EcAOE
	 GYixQ5Pt21PN63CfAJWMGYJ2Od/xbWLbUnjZlScUw2wtZ5csd7HGSnSfCNVwbn8+wznqG
	 hRX31A1zU+OhwDFfhW4mwCa5IZKNdFJbbMBlhTtF1FOe1OBXD8tGODeTx24KD1J3UuWf1
	 b60tTUxYmu08kdcrDGmnEfHFcWe9A+OJgKyy5qqydsI8LgYaNjxyvOvRrhTErBqKPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YrUqEMm9z5J4jaNe8INgEE9sMz1REWYf5p9yYZc/oOM=;
	b=g7juXBmbbN0zPydbTNmF4Cw9nyduUcgsxo5eoowo3wyp7iFGA3jpTlXr9pj0HsBt6R2Z
	 6lodtM2GY067odGeJNMA9NdTy9hXwuVYPJoBllWg1jkvnZewa47Fbp1c5PcXO419bQjnn
	 Rf/priG2dGmPQaCCAVgAKRhIpcphE85IIYdRbY5iopj5hdsMKMPa/gsqvYVvGNZ3nM0ZK
	 Ehr6SEnC6BgpU7A9KMAsymEwe9cUo5RA0Mwi5+fs7FwtNCHB8zE+AP0Vv+ylpzh5R4bgY
	 b7+kavTzFF+RcXUVJWAmIwUnDIe54zKJP+7lpi378zEN8dN2kTHgjLZ35BpyYQ5M37w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NK6wMFG2;
	arc=none smtp.remote-ip=95.215.58.86
Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1294606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1294606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NK6wMFG2
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5O5gPTvKN1uioPmvTeSAALfxSrjKERJLwEwvEZL/R/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607549; v=1; x=1796212349;
 b=NK6wMFG2CnowpCQWyha/PYUOCGpTb9mBxbTOdErQJ5+gnbIwAW+gX7KgP+CudrRkxCH07DxJ
 j2AIyLjusTqpEK8L0TW8MtQ5FYCdBi7A+AAXZyatznj0Bkr2SYva30drueldBwo5opy5kEvPjfM
 Cc4RvsR83++wdnmvKsCx+ZBQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id dab8a477befd0327;
	Wed, 25 Nov 2026 11:52:29 +0000
X-Mizu-Trace-ID: dab8a477befd0327
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
Subject: [PATCH v4 3/3] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Wed, 25 Nov 2026 03:49:59 -0800
Message-ID: <20261125115014.4014507-4-usama.arif@linux.dev>
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
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf1732935c73df..9017b312f404ef 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1034,8 +1034,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(pmdval);
 
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

