Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA037C91E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563104; cv=none; b=YV8v+83qlBbTglC6JjSOzUwR6v/FJZsJlFfj0eWjsfyQdhaKPTtQhnJM7ZIOC2TSksfNt1Mu0S3xm9mOypGJpEa0COF9nu1AyAgjUuhn8NcUUcu1S7tCMuE84tObvPcT/3KpzByAoHBOyCIb9qMZ5e7AR1i+gWYL8VyqqICkIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563104; c=relaxed/simple;
	bh=/GTEXjAO8G07aQ62TimyMku3VnOjLh/C2zIWvY7maY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fab5jMICaA+wgwiQxt08tjVM5Z58xhhUsICsiyFqUhZG+N+nic3J7SPp0C4IPcPGUz2lBPIc7TPfBuFY1o1ckQAPWYJm3YghE0YvgSILj5NXvPyTIQaTsrMq531fuMB0VarE2mInx+PVRUB5lH+lWJzmROkz7xNkbThuBlRdxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qLfThpJn; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qLfThpJn"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/GTEXjAO8G07aQ62TimyMku3VnOjLh/C2zIWvY7maY0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789563099; v=1; x=1790167899;
 b=qLfThpJnuV2qzRJzau+BUNAKZxTbQM+pZ2bPZOLeVdrT0Tj1iAyNvR1J7z7DaYC6vJoSLkbV
 ViHJ7KnN9aka+1FrYZcFJaaSAU86jfcPdfuOEkYVqPDCTE/d6gSw8FxLPoBPIyRBDdtBy2Ohn7L
 3nu48xdYKNXCBxiNmmQYI81w=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 13cff38a12b166cd;
	Wed, 16 Sep 2026 12:51:29 +0000
X-Mizu-Trace-ID: 13cff38a12b166cd
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	david@kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] mm: filemap: move lruvec accounting outside the xarray lock
Date: Wed, 16 Sep 2026 05:51:22 -0700
Message-ID: <20260916125122.2696271-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__filemap_add_folio() inserts a folio and updates mapping->nrpages
while holding mapping->i_pages.xa_lock with interrupts disabled. The
XArray insertion and nrpages update require the lock, but the lruvec
statistic updates do not. With CONFIG_MEMCG, those calls also update
per-CPU memcg and lruvec counters and notify cgroup rstat, extending the
critical section.

Move the lruvec accounting after a successful XArray insertion and
after xas_unlock_irq(). The page-cache references pin the folio, while
the folio lock keeps folio->mapping stable and prevents removal until
accounting is complete. This moves one lruvec update for ordinary folios
and a second for PMD-mappable folios out of the serialized section.

In a 30-second system-wide perf lock contention -ab capture on a
production host, the hottest caller-stack record attributed to
__filemap_add_folio() had 20,867 contentions and 557.930 ms total wait.
That was 14% of the 3.998 seconds of aggregate lock wait in the
capture. Moving lruvec accuting outside of critical section should
help optimize it.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f550..4720bbfc1a663 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -918,14 +918,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 		mapping->nrpages += nr;
 
-		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge) {
-			lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-			if (folio_test_pmd_mappable(folio))
-				lruvec_stat_mod_folio(folio,
-						NR_FILE_THPS, nr);
-		}
-
 unlock:
 		xas_unlock_irq(&xas);
 
@@ -942,6 +934,13 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	if (xas_error(&xas))
 		goto error;
 
+	/* hugetlb pages do not participate in page cache accounting */
+	if (!huge) {
+		lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+		if (folio_test_pmd_mappable(folio))
+			lruvec_stat_mod_folio(folio, NR_FILE_THPS, nr);
+	}
+
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
-- 
2.53.0-Meta

