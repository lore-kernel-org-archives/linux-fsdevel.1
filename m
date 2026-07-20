Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB414D90B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576168; cv=none; b=SEraJlSgepiqorKdi4I0XVWJrpfMScYgxbrinZZzan15ZHR2Vfix6wA/9rX6TKB5ZvNsZXpes3RxfQHhBDpRLLAZSyVlL+iiDQhqEooIbSCDLKVePMT/aR0tOafbr66yhKTWqzB4xeEExt9Q6OWzXMXPobT6qW9jj5frK5/EoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576168; c=relaxed/simple;
	bh=VIh2CZmLMZ/97T44ZUvXoEPJ4nbdEMs3NtJzTr5SgDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMXcrEXbfrboh2YQbWP2z8Zi/wq5bUgVq3MTE4DG9qqB1XojsKQL+dJkcjoK/noEtNtnu06lFPfO2FTNG2wZUphyL9tKlh+YahEntHNHIlVFbkCL1mpe3MMDm2q1rilKBn9YAsp4R5bnMwEpggqLpwwv/y1KdJynrPOH3jkVglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DOQE+QRL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DOQE+QRL"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so447614985a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576164; x=1785180964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmMfaNN8FH7IwFGvNgQFqVAtbOqtT0oL84O+5IPA/hE=;
        b=DOQE+QRLM3b0Kg5Gf5iEflRFG2oWI7ZdJBhv0Eah+JHWoFxEAu1W/2DX9ScAd37UdD
         biPO0+MxDNidBsTbo4acm90Inzp1JKtompmv7Q9A2aIw2QpDaZBdr0IzEIlVZnBiohdS
         XfCKOkNpw62JO76dQvKkCxcEyY93UgGhrUD5O96NvjxX4d28aocEMQLIMLVWyCbhca0f
         Qldzoo+PSI9UMsnybpwmRj9HxJRwpURP7nTWEBMSahwaeg9nkuoXDY9Dfe1dtljwqBdM
         +m4bV66PM8FYZI6ZLZJyZOy0jssHTTHa/wP7FkPVeG5cx3E3chiVPmSvoaaiMCY10KOs
         ZDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576164; x=1785180964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmMfaNN8FH7IwFGvNgQFqVAtbOqtT0oL84O+5IPA/hE=;
        b=JTutFfVkOpMV5BY73ijjXqKd1UahTlJiTjAGByxhMaQCn8//sH+rc/e5zjLhnAzX/0
         GRQ7FGNc9pynFLydir3dq0ntSfqEccUki1KuuHRuqdr3+I7A7sljBzfSgaz/X1tEhAID
         Pe1xYoWaWsNFyq8PRKg/5AMRN4hVB9VCzV8QhCauBffSKiTmvSgBM2HGaGIjwg2tWWCA
         37wN3+sCgXMnFeqv02CgJNqwUtGSmmnCVvPt4vxxefGvUCSX+huKjEVLiGBF7llrGoa2
         xCBmgfr4uqPZEuPwg13IGwo1YA6l1/zc+UcPiqK5HHgn8Y+Iewh4fJPJHbjsinpil/xw
         dKeg==
X-Forwarded-Encrypted: i=1; AHgh+RpLNx/DyybV6rs9GkkQawRJYImJZCujZcrY51dZLcGKy7TWjEgHzVuwtwAptzc8vfti7tOaG8NIgshJDP5m@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0U13PlfI20S7fWqdF+JyavNdYmc0+Q3hw5z3N+SrmSpNWGev
	Fa5SCr0zEswtEVq97wh8RQYLeqZe/iw0QNbdf0tutKUOYGcMvRMS6MbcY1NiIWlsAc0=
X-Gm-Gg: AfdE7clXUmqLyaXxi87ANOsmphg0DQbn2VszUwXJ2nvQ1AMfumRi13PjDZyyK3NLJ1y
	MpuL4MJoDzfk9mimDWqWd14KNnWXVp1a1Me/AtOjjl2eIHHJgvcYZN7FdniCtrCRxRGvwrYX7W9
	g7JhPCTtvFNSaOJeOGnkvdPrt6zSsxX/Dq4pNIrlp+/BwYWAm8bjYNxXXJVjYvLHI+oZbQg1tsz
	jjieD0eYDMZkjPloyiqvpqbQijKGYzpbba8WGO/7LRjzfHsqaRR0vTXKbdJwVhO69j34Cx/ord2
	Ts9vnIwdDpHmk2oJ4Q6pd+3rTXstUipw/17OeWZE81wLWNAnzUSnMIpZPM1rjGxWudQ6YtSmn+N
	LsV2J9/EER22yWrAvTq+S0VvhUxJByWp+i0Ko+UPoA2ablOIWd7eHqTSDqSj9t3Gex3yIaOyHj+
	dC+2vYu/f3wLazFk4/UfWZA9aXr+ceheHKo/qYCL0i2gAGGYtIgRz7ztxRXgTIh+A=
X-Received: by 2002:a05:620a:4620:b0:92f:279:5953 with SMTP id af79cd13be357-930b3ea8f3emr1530889385a.27.1784576162881;
        Mon, 20 Jul 2026 12:36:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:36:02 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 32/36] mm/khugepaged: base private node collapse eligiblity on actor/cap bits
Date: Mon, 20 Jul 2026 15:34:26 -0400
Message-ID: <20260720193431.3841992-33-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collapse can move base pages across nodes.  The khugepaged daemon does
this transparently, while MADV_COLLAPSE is a userland construct.

Isolate private nodes from khugepaged exactly like ZONE_DEVICE.
Never collapse private node folios silently (the owner may not
support migration).

MADV_COLLAPSE is user-initiated, so it is allowed on a private node
opted into CAP_USER_NUMA, consistent with other userspace interfaces.

folio_allows_collapse() encodes this: false for khugepaged on a private
node, CAP_USER_NUMA for MADV_COLLAPSE.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/internal.h   | 26 ++++++++++++++++++++++++++
 mm/khugepaged.c | 16 +++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9621eb127c28c..9dbc5752cd3fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -136,6 +136,32 @@ static inline bool folio_allows_numa_balance(struct folio *folio)
 	       node_allows_numa_balancing(folio_nid(folio));
 }
 
+/*
+ * folio_allows_collapse() - may collapse fold this folio into a THP?
+ * @is_khugepaged: true for the khugepaged, false for MADV_COLLAPSE.
+ *
+ * Collapse is a residency operation gated by the actor calling it:
+ *   - khugepaged never operates on private-node folios (like ZONE_DEVICE)
+ *   - MADV_COLLAPSE is gated by CAP_USER_NUMA
+ *
+ * Never true for ZONE_DEVICE.
+ */
+static inline bool folio_allows_collapse(struct folio *folio, bool is_khugepaged)
+{
+	int nid = folio_nid(folio);
+
+	if (folio_is_zone_device(folio))
+		return false;
+	if (is_khugepaged)
+		return !node_is_private(nid);
+	return node_allows_user_numa(nid);
+}
+
+static inline bool page_allows_collapse(struct page *page, bool is_khugepaged)
+{
+	return folio_allows_collapse(page_folio(page), is_khugepaged);
+}
+
 /*
  * folio_allows_longterm_pin() - may this folio be long-term GUP-pinned?
  *
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fb4378cc17b10..5f20839857738 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -700,7 +700,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
+		if (unlikely(!page) ||
+		    unlikely(!page_allows_collapse(page, cc->is_khugepaged))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1241,9 +1242,17 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = collapse_find_target_node(cc);
+	unsigned int aflags;
 	struct folio *folio;
+	bool allow;
 
-	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask, ALLOC_DEFAULT);
+	/* Private node access: khugepaged never, madvise with CAP_USER_NUMA */
+	allow = cc->is_khugepaged ? !node_is_private(node)
+				  : node_allows_user_numa(node);
+	aflags = (allow && node_is_private(node)) ?
+		ALLOC_ZONELIST_PRIVATE : ALLOC_DEFAULT;
+
+	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask, aflags);
 	if (!folio) {
 		*foliop = NULL;
 		if (is_pmd_order(order))
@@ -1687,7 +1696,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
+		if (unlikely(!page) ||
+		    unlikely(!page_allows_collapse(page, cc->is_khugepaged))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
-- 
2.53.0-Meta

