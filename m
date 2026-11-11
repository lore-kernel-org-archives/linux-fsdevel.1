Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397158;
	b=ZaxsG5WSJdr2a9VkD1PYWqWYy4K7Bsc9v0eCooEIknFDtHI7LcvgxxACyK+nDA45XTgA
	 eZxz3/fsfJhMIt1bK+zVYMfQA0CrQiLbkQBl0L9Ch8FqLf9jvIIxiB08hWuYy0e9fA0CC
	 IPrjM77s0lt2dG4asjqFKywTyfSkfdRUROU94DFpjhDd0555noii6P36w7qoDFIMB4P8a
	 cA49tD48CqxMSlUUXKq+u6a2SXXuHuXjs5paX2ZOVlDiimDw7+f6rxfBx6cJ7x92c7muZ
	 vp8JDFh8COlP0aSSapQXdMvLF+3IoSQFFY7dm8Y0v28B0ozNDmf0nt0Ua8wnd/1VtBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397158;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JsSfYSFniRGmuPRfq48u5DDdTpeJF4QuAl3fe5dik5M=;
	b=03Vgy6Y1GPSBRAhM62n0zu3hUBNIO259ndCBLsjfg9EB7JzTYlHCe+yQ/DTI021HbyFs
	 pagBiLQEfZS6HQhGkY9y3/CGcN2nKGEjA8C1IUp1dzsEMJ2/6cj4LTULUbxZGkqGjU4tg
	 CRwi3amhbHpeCYDMKbnatGWMHLTx8Y/88oBgqs4jmxZl14JZctTZSp00Cu3gAmKg9bhcC
	 5QcuPr7JPhDwFBbkhoc/v3gZvzhOaR/Ev1hNn7M/FpfuiQjlolsOxuvlIYR2wJecA0Kuc
	 rqy47VssCch5n5ljlCp8ZFlCTBoRikAPBzZSTLXC9MCmKd4W9tQ+CSkgz+7sA02cHXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ag3zwCYS;
	arc=none smtp.remote-ip=95.215.58.151
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA2606A880
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ADA2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ag3zwCYS
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zdZjBwRCrc/bJJQOamLttRr417Z2hw8mLNGL8JIUru8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794397155; v=1; x=1795001955;
 b=ag3zwCYSpzqYUYA54fdErOhJI5ZfvsIqZlLhFTR1lN2npGQBNhVAXh6oxEb6plsz/R/fgyCU
 V+qWgWJFemeb0IuQrEJ88ypX1XdKx5B74yIqkTzMdNehMo4ZhvIUBUaprRDrs1rOmFFyiM19fPu
 PlounxJCpV3EDB8RajRn5Nnw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 780683f44d9afa50;
	Wed, 11 Nov 2026 11:39:15 +0000
X-Mizu-Trace-ID: 780683f44d9afa50
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
Subject: [PATCH 1/3] mm: don't PTE-batch a swap-in over a hardware-poisoned subpage
Date: Wed, 11 Nov 2026 03:38:29 -0800
Message-ID: <20261111113904.650722-2-usama.arif@linux.dev>
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

do_swap_page() checks PageHWPoison() on the faulting page, but the
large-folio batching path then maps the rest of the folio without looking
at the other subpages. A poisoned subpage that is not the one being
faulted gets mapped anyway, and the fault that would have reported it
never happens.

Skip batching for such a folio and let each page take its own fault,
where the existing check catches it.

Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
memory_failure() sets PageHWPoison() on the subpage first and only sets
the folio flag much later, and the bail-outs in between - for example
get_hwpoison_page() losing a page lifecycle race - return with the
subpage marked and the folio flag never set.

Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/internal.h | 15 +++++++++++++++
 mm/memory.c   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index cd3675c044e0a..e61c02f4019b0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -28,6 +28,21 @@ struct folio_batch;
 int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
+/*
+ * Check every page of the folio for HWPoison, rather than relying on the
+ * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
+ */
+static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
+{
+	long nr = folio_nr_pages(folio);
+	long i;
+
+	for (i = 0; i < nr; i++)
+		if (PageHWPoison(folio_page(folio, i)))
+			return true;
+	return false;
+}
+
 /* mm/workingset.c */
 bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 			    bool flush);
diff --git a/mm/memory.c b/mm/memory.c
index d477a4f986bc8..4b7d456332200 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
 			goto check_folio;
 
+		/* Let a poisoned subpage take its own fault. */
+		if (folio_has_any_hwpoisoned_page(folio))
+			goto check_folio;
+
 		page_idx = idx;
 		address = folio_start;
 		ptep = folio_ptep;
-- 
2.53.0-Meta

