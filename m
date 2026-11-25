Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600876;
	b=dcULWcHuJCOUBdU8T+SEz8wrZcjKdz28knGMxzo813p7ijzkD3uVVSuVIpndzj02v0ok
	 vnQKvRcUDA4Sechrza1eOxiT+mNsfkG4qj9eH5CoLEPCQatSTq3Uqf1/OYUIDzpf2zZw9
	 7UmH1ZTieSCaHBr9oBuarkmLKIcYviezH61kCSFlcbSy8xgX0bcZcaWBAJOOloWPAqScL
	 FqBsDhKYknuPMRAyNalTOoNZ7oyrzQbsjDXRCA5G+7ano0FyCg11ie6bFfuxYoj1MTi/x
	 ccdh8pnHUbbd1A3MsIyyaXwVotE2ZtuMYgADIaf6QpXMQYsdgZ5HE5McpTP3ZXvYx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7UvC3kLQVk7Jos86IsiNdep9C/zypw0aYvzz+vz5suo=;
	b=QBjqlMGkRMVbULDamMihBhZe1QkqgRe9Mky6NqAJAakEsaGt0+567HjSREd6vNESxWj+
	 ud2bozHu/mmA+WCCHBMBmfIthn9ewaVIUXLaQS99gaoad1Ys5IO4IUg4EGGLzQPcR2JJ3
	 bas+GeqcqkeNJ52R1BZEqYwbdRwrHz9oljXJd8IHrNI9gKGBZYzXhUBk7XNlXQtgFec7v
	 5M9yPpVobDeoZVae46d7BlsifOjxqIMTVNxePd3L7Z4Ck1+VGJHcukq6Kbpr0pmqcbz67
	 dAm4SL97/JUw0SFr4e0+6v7DF+CNbpCIU7xsJXIMRKLxrOdF9p98gxFnWSJ28EYjUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8wqHJ25;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C432606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C432606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8wqHJ25
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso57753175e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600874; x=1796205674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7UvC3kLQVk7Jos86IsiNdep9C/zypw0aYvzz+vz5suo=;
        b=C8wqHJ25wMh8wwwXLtSv5ieNLD16YdiicexhOY5fw6LuQFKG38akfXyHTiY/7/dERe
         sbr3Tpzbnb19t95zQS4fSN8wHbq1AkbPQhXIOI85m0VRFa+cM8qBUK6AnrB4eDd+MMxH
         gKNngffL3cL+IcbZU7Q0ZS1gRNlX4NF0hDC4TLfhQPg8F6Ul8A/sLeW0URAsdJUQFuSX
         rG1Ks562usRI1H1K2/yDvbMq9SB09L6pvdqzuPKJkoD19qJpyJ+eo+V2GU+dCIehm8CJ
         cUhy8ubHw1gIgxh8aXZRvG65x7oLCdIjX0JCJGAGbKtvSanMf6CgApfhD/Q+yZWynFey
         bUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600874; x=1796205674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7UvC3kLQVk7Jos86IsiNdep9C/zypw0aYvzz+vz5suo=;
        b=JW6iIoPD+unNaH8upVYqezhqHYSgx+39MqDBB5TuzXnhQxRqXAXSo7DuzdwtX5F0UU
         xJHUrXWPwOMzvDk1OaaE0kaj/OhzoBNqfSZdX/uCEvh+mTKJvgculHNNy9bBDQrDBIWI
         IoHPJ2qyfySmuz6f+UU96AWCS3p39x/0Ihh4ADj8AZPIG2isS3vFaOGx+HI0llRxxCVt
         ke9++NNm+y7uaiFXhETlmln3VAXo5/V8xPPHCM0c/Wri7jOpkzACo/YWA7ChG8KFjcuY
         KThWDmQRllmZ4V1VaCLLcnffd2TghDxhd88RiHNnrgTqFtAGcjz5Ki3pnB4VAZXoagZa
         blSw==
X-Forwarded-Encrypted: i=1; AL+hErEOvqC38Kp8SE87WYjAtyhTfXMW+Kq4OUNJ8p9e497jBf8/ehZ4uwmMyn/ReT/kwJTYomu0NAUYNe9gCrJA@vger.kernel.org
X-Gm-Message-State: APuU4Z9thU1D2pQd+WUFGcTzodBVXSBz1UIag4Qo/Hr9IjdkwCs9Vk+k
	cQlRbiG98xq67t2l4RSQKNrIUQXvVn0PJBvoe+9b1AQy7/31SxcjEU0M
X-Gm-Gg: AZFdTZdJaa+uI/kL8elGElWAHzjFW+FTDgaTeUgjz5f2mpdAqsCAb7V6Riq28WHokql
	aamFssDWpY6FgRpMmHWIrzmNBTJLMjOQhr4iuGdcIvRHN6/GfZ5ObWMoshNWLC9qHHF+NeEMhHb
	B2LcaoXz+HU6Y7ptuExesAf0PDUUAoQnRAFxBWpOe9Uz3KPXt/cb+c29vaU6kPFp/YC2cFGwlV/
	eUr4KAHSwcMKf8N4gpNavFvInQspxNGBuQ9mHUY9yR/BaS+8kLYfcfSZygVzOHjIzwYkJqAYmd/
	IMrerf1N8qcPnvoWkh+EqG8du1PaqthQ/NPnwCkxb54QKVL+Ge7b7fEUUniyEqsMmDxO+ddekuC
	C37mxepxRizXyizCUfaqDKUa1MQrvTvuck76yUml0SeNj8AKu/1EvOf/kmzDs7ARlGSviG7fZfd
	2Fn9f4GxxroG7fhM2u1L3DHJidZfSSU2VZZ4ZsG94FBM/9FVQNoTngsRJzI9jO7uzrltbbXEuoj
	yHPDsL3rPLE0gxQK59fpdddzhLvV5O1MvKI0NYmXa+S+ug21zX1leW4jryKTt403BryNstwFcw3
	tzJS2lW3CfdINw==
X-Received: by 2002:a05:600c:5901:b0:4bb:5e8a:7c9c with SMTP id 5b1f17b1804b1-4bb861467c8mr304008495e9.7.1795600874476;
        Wed, 25 Nov 2026 02:01:14 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:14 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH 3/4] mm/memory: never allocate a page table in do_set_pmd()
Date: Wed, 25 Nov 2026 10:59:46 +0100
Message-ID: <20261125100058.15200-4-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125100058.15200-1-azpijr@gmail.com>
References: <20261125100058.15200-1-azpijr@gmail.com>
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

do_set_pmd() is always called with the folio locked, so it should not
allocate the page table to deposit. finish_fault() and khugepaged now
always pass one, and filemap_map_pmd() already passes may_alloc=false.

Drop may_alloc and fall back when no page table was preallocated.

No functional change intended.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 include/linux/mm.h |  3 +--
 mm/filemap.c       |  2 +-
 mm/khugepaged.c    |  2 +-
 mm/memory.c        | 26 +++++++-------------------
 4 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d09173a94e9c..5e7044b6ff87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2160,8 +2160,7 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
-		bool may_alloc);
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page);
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d730b0ea4667..b47c25808814 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3751,7 +3751,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 
 	if (pmd_none(*vmf->pmd) && folio_test_pmd_mappable(folio)) {
 		struct page *page = folio_file_page(folio, start);
-		vm_fault_t ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ false);
+		vm_fault_t ret = do_set_pmd(vmf, folio, page);
 		if (!ret) {
 			/* The page is mapped successfully, reference consumed. */
 			folio_unlock(folio);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e5adf6960a7b..6d2431a20bc9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1870,7 +1870,7 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 
 	mmap_assert_locked(vma->vm_mm);
 
-	ret = do_set_pmd(&vmf, folio, page, /* may_alloc= */ false);
+	ret = do_set_pmd(&vmf, folio, page);
 	*prealloc_pte = vmf.prealloc_pte;
 	if (ret)
 		return SCAN_FAIL;
diff --git a/mm/memory.c b/mm/memory.c
index b7e53d7cf6e5..8c7c6be5495a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5758,13 +5758,11 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 	vmf->prealloc_pte = NULL;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
-		bool may_alloc)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	bool pgtable_allocated = false;
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
@@ -5803,16 +5801,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 
 	/*
 	 * Archs like ppc64 need additional space to store information
-	 * related to pte entry. Use the preallocated table for that.
+	 * related to pte entry. Use the table the caller preallocated
+	 * before locking the folio for that.
 	 */
-	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
-		if (!may_alloc)
-			return VM_FAULT_FALLBACK;
-		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
-		if (!vmf->prealloc_pte)
-			return VM_FAULT_OOM;
-		pgtable_allocated = true;
-	}
+	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte)
+		return ret;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_none(*vmf->pmd)))
@@ -5842,15 +5835,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	count_vm_event(THP_FILE_MAPPED);
 out:
 	spin_unlock(vmf->ptl);
-	if (pgtable_allocated && vmf->prealloc_pte) {
-		pte_free(vma->vm_mm, vmf->prealloc_pte);
-		vmf->prealloc_pte = NULL;
-	}
 	return ret;
 }
 #else
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page,
-		bool may_alloc)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -5995,7 +5983,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_NOPAGE;
 
 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
-			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
+			ret = do_set_pmd(vmf, folio, page);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}
-- 
2.56.1

