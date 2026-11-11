Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397168;
	b=gTe6dhHZd6/oNRI/Z2P1oXkxjfzg/LRdFgvNk7Hj8ZiSDt/QRKyYIhtZubv/SOphFC7k
	 /9mk8sSYakYxUByPoWY0I3jzTAarqidzuVV0ygCBgxrEx6m+X+gu0m5yru0yit+TqQEUy
	 ehN+0JYRdLpz/AWTrNuSHr9oxjb1g6hWU6f1tu+3C/TG2r48UX9CZnsFRPJ4EYrOzFWn1
	 ZtK/v5rPuKe9e+KbFKmf/qq0yuzzVDz81NYkwlrLXoKxNKOpioPa3qimEL/KqfT+TjVaH
	 bMyOC3F6lWuTOA5N2zTuLUZL0hVufvlwU9OYTZF0PFHhS9m51DpiEPmSDli7aHZjPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ss6GPqajhnLoAGvpkwWgAL30Fbn2tVqWEm0t1Mamd/I=;
	b=0qFaK0ESm6V5kRFEpAHltVGpkxDSDW4H2M27ltAH1uP6rYCK05JzQfMRFUbe+YPMx07s
	 5ggW2LPLAWdUicZ78Ak5VWQJ/SUXTz1BY9rqCLVm0dL6hoVW6LkNMXHbb691h6X2cbhmY
	 LrWafQ7J17KjeruTNituuUAkviEYmy3Z6v6vf/v2QCj5wpdKms8yn04ZU2p/8cgNp3nMS
	 2r643BwZL5v0tnIi0civREg6CoJ9oJlu4Fo8I37ibRNX67sxIc7TsjbEIq9L9BaYossme
	 CY5IOV1R6XH7DucOj7oU9Sy/JNAPsEk7+sSbhsN4AiXbfHlgKBwjEnTH+wCE5ejqWFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FYJ36vzk;
	arc=none smtp.remote-ip=95.215.58.183
Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39C606A334
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE39C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FYJ36vzk
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PxRmG2FWyo+pFqNDGwdneDF6Wr5yBgEA/EARM77L5Wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794397165; v=1; x=1795001965;
 b=FYJ36vzksOCCsexC4Nfc0EjBeGRz02DN2aWs5F+SXhhYb1uihrcW4LnX6Z7s7sylG5IMBCBm
 bHF7fJg2UO01tXG8ZRmWqkalW06PF9jYozU3pm4rIsnaV0yGASbqMBLttquRoIJ+iGyHLzqA8Np
 fG5mN9dypHX+/kIKrEZ8vrgc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 997e08426fbd59bb;
	Wed, 11 Nov 2026 11:39:25 +0000
X-Mizu-Trace-ID: 997e08426fbd59bb
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
Subject: [PATCH 3/3] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Wed, 11 Nov 2026 03:38:31 -0800
Message-ID: <20261111113904.650722-4-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111113904.650722-1-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
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
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c0d391186c2b8..ad97532fc1184 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1032,8 +1032,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
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
2.53.0-Meta

