Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC0471D06
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817064; cv=none; b=TmiD9gUMF4QisHvVCw9FuBFy4ldd7DCDkzssgb41yJW7K1aJejCWnhNsaMWxYXhBjduGqQtFvTHD2UINHzgZ+b3+tQEvPDOfV43mekw27GJCszgcop86IIvSyX68xRuAc3VoqeljAbCqlP05HZ2DGVlzQV9cy8U9bi2CPtTKaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817064; c=relaxed/simple;
	bh=n4+DE0MkcY8xljR1xB9FuYbRinW1ptkaBrNpzG+KTiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fai9J8mIR5Uw2kt10sG/QM4W29civM1x2CHl4jxZp/xNVSNlly0Y/VfQkDsqb+jyyDmCztTJgCKq491EkIC6Uy+mLnjd2iQKKKb8cH8sUDRv3sUwWcFRDY9xK66AjZu+ALZMTujHZRFmQd1jyBy/9HFduaqcybeqr/UgsmR0YF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pwhzavDe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwhzavDe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/n4jiazelLpiTgYJB0ZgYwXnBRq/UdX89CcaDIshP9o=; b=pwhzavDe1yyHZzQJCVdREF8yIt
	6dvKRVzMTPV+l2cjAPuACtx32smDj/C62oBXEd9i+DwYc5E2la2Ldrpp8jiEBkdatDYilBfGOBpuP
	AddBdsAmU4yO4YIqFRL6j+LlmR7vcilPhS3U/X5ebYbA7zl96cvvMP5TnwiOq5O0TbbcxvIUkdPs0
	hg1qHnZlDL5nvjDkGYgKpJX2/oYqRtGB130tL7E9oUU91iTZlRdSC+ygsUEZPbnm18h0G+q8pbGZS
	gs4jdkPs80QwKhjbrplR7QQAorekprvbckspydlVINDaBO8EsHgdq3/FcyPMonB9b/gpXrrrVOxlH
	gNaDbUqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRY-00000000jhr-2If2;
	Thu, 23 Jul 2026 14:30:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v4 02/14] memory-failure: Test the page is hwpoison before taking the mutex
Date: Thu, 23 Jul 2026 15:30:19 +0100
Message-ID: <20260723143034.175661-3-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143034.175661-1-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to synchronize with memory failure to filter out pages
which are not hwpoisoned.  It's inherently racy, so it doesn't matter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 944e6e1d4971..3615ced0a11b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2677,7 +2677,12 @@ int unpoison_memory(unsigned long pfn)
 	p = pfn_to_online_page(pfn);
 	if (!p)
 		return -EIO;
-	folio = page_folio(p);
+
+	if (!is_page_hwpoison(p)) {
+		unpoison_pr_info("%#lx: page is not poisoned\n",
+				 pfn, &unpoison_rs);
+		return -EBUSY;
+	}
 
 	mutex_lock(&mf_mutex);
 
@@ -2688,6 +2693,8 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	folio = page_folio(p);
+
 	if (is_huge_zero_folio(folio)) {
 		unpoison_pr_info("%#lx: huge zero page is not supported\n",
 				 pfn, &unpoison_rs);
@@ -2695,12 +2702,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!is_page_hwpoison(p)) {
-		unpoison_pr_info("%#lx: page is not poisoned\n",
-				 pfn, &unpoison_rs);
-		goto unlock_mutex;
-	}
-
 	if (folio_ref_count(folio) > 1) {
 		unpoison_pr_info("%#lx: someone grabs the hwpoison page\n",
 				 pfn, &unpoison_rs);
-- 
2.47.3

