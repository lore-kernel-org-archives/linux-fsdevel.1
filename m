Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600869;
	b=sI7jp1Xor4nEv91jL8lIgD4Qszb2vnGoUJ0H5Rv8Ntzm466cxcDifZGm0fETlEePQrtO
	 vs2AC4Jqc6NaKGPMr//FAykI0RYdboJZ8U0MfI0gUw1lbpy7LmBfJUfnxt5WOEnDg+ADE
	 j7vm3S8VgQYJTN1RV5bvy8m3aj1L0QZ1WjJnsKPbUisxKHhHCvkyLeEzUPuaXP7fFnvLU
	 zYMmqanMA/3tFmZDMv2NAjkJ/GrDpzsVzGSn2RS45/yM3AsfE2ZMQeAou/9urQSy7oz5j
	 61MFP4C27R/ednYtPux3amxs2tIX/6GE6vYGRfj9Ob0pZ4jVBBcK6Bx6FOSzAG3i3HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SRa7glS2jxBPu47ZJigvnqW/5smKMZXYDTqtBKYDhyg=;
	b=jb7stPbOFjJ79gmThkGfNmJ5WPHdOYAoh6Edy2LDfssLAQvulKQw1zTkzwySWNnDBqoP
	 TYkl1im5m/5yu1lOClpgitjsjP9aAu5BydNdIsUq9kOSLjYDwZnqwUxsrkWoPTQdhK6nl
	 Gnjm9slpCaoyx2EwoVGvJJKi1XevPPKffAOz66avSvAaPj1HqF4CXN0j4chggETuJhY6F
	 3G3KczDkBt2cax8XyyuoLYrbmJBuAodluVu3JfwwjmPJkJvC3ffsDDPEtPgwaOc+f3uVx
	 dU/lxq3VXcXKifpkhc/Z1DwTr6XxJJOiDdGPDMrDb18BfQZEyzRd8KKdQqvUYlfd/8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZrHnMWN;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC8606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EC8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZrHnMWN
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so42645565e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600867; x=1796205667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRa7glS2jxBPu47ZJigvnqW/5smKMZXYDTqtBKYDhyg=;
        b=QZrHnMWNAw4Jki35sV+GgLhJMZaSp9906Jhudz4ZwesHUhOZo0EWbAOEDjHr10repK
         8AYhYqR+F2DXvHWO8QG9LVccoZK1BKOjUWqfIDIeTl7Xtl/EcjtA4IKmmBvdqeINaF4G
         sm8DpFWuLZbaaCwyd2wJUsOQc3u5t1hgJpGlc9KEsCC4PyzYwBzMV+3zKxEzOIWwf7M+
         ADDBkWojojET+EETx3yAdJFn351YIE2Gl4h6VgmDuwBtLuGTZJ0r406GAhpwvrZ4FBNY
         SQfJpuhParlBI1+9H8od1/iu6Qj9IlMkCZHvnmyw+Mp94A5u+ev/0UneXhHv81+kdQJo
         GcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600867; x=1796205667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRa7glS2jxBPu47ZJigvnqW/5smKMZXYDTqtBKYDhyg=;
        b=qTmUIKcWB9BAcTUDbeyYVxfkuwPVC2NHhXkrhKSeS0E5AOI6ou8CySvx9IYiMG2rAk
         du2sJEbAxDJSENF9MCNJxhiRM8cM2dBKlL/rOKmJd++hO/E2h6bryD599eMnuj0kOlmI
         zy9DVjt4rOuOlrxO0LDgMYzvWxt7sr9Aftv8hlv5sEKSsl8+64YswGKhqfj/0rZ5LwxB
         5ahMu+b/WrynAuE+pjy7Dxf3DDCA2uOSygNfCL7yXETin0C3S+xd6eDMMVESB+1DCuW/
         qpvkrVcgd1q0Ei3DLhMmlUXZ8d6u/Tl/k7uUzEYWxzWEXIoGrKI0rHKtYcgAKXvj9Ukk
         +oeg==
X-Forwarded-Encrypted: i=1; AL+hErHNB0/PhViJ2ZyGsVNA/0KmWykrG3BFLT8go3g/akCUiCCp0HPbsX5s7tCUmva/TURY+utfEBx3D/aEtMXT@vger.kernel.org
X-Gm-Message-State: APuU4Z/l48YzG1OxpZUsqg+3bkB0PoMoA48oWQsKCJ/r7Wn+3+S4FGF2
	1pHebT17k8XmHbEKiLqSAD12yhCQUONflBd0CDuYjz9A9vNuKrYsF2DX
X-Gm-Gg: AZFdTZceCLy1yh6tISv/+QBOZgkOPxb7Tg2f+AozP0hv/ezvBoeITSE8a4syMWqhsi9
	DzYHO9N4ZAzqH3c2ZQeY9GA2hNBk6AIt7uN53UnJyfXNSpQPdorNdlFct/Jd+gszc9AuAJH+/8Y
	qDxmgPsuc5xrM3luhEpkSU+vWxUmYMYHdThg1gkwGyXjS0Sh/tZdy8JaAR4zGIGiF5GOpZVBRYr
	orrZU5MBsIeU81Yd3R33ZVhsY4PYlIejlWyNkDMNkaOM6ooJ2M7JtaVyWZpdnfKw2QeEVpoYLjI
	Tci2wDK2M1yidR93ZbNYOYmEi46R1b1QPWv2rEJWEYIbizGAUbud91Nsz8P25fc1XrCo6yPKPiR
	hi8iZAfRjcNGn2sYKTjaII7XF+MwMVdW/RgC5eHCxxa8dqtbXNiIX8h67wav+Ih4ZE+7LrFV2oK
	JgJSEbalmKbsIZapGZ9uF32pK6ccK4JdtCu+R/3z5Op0n9QH9iM9/Qvol0hQcjuCnbHWuc7ntE/
	933GuuepN+TnUwgthpm7zD3GIlfuNf8Wxkp7RiV7EU7xvUH0NrahBtq6dou+1WKnmqujVrTmIYK
	+8EbTwl0VQGn0Q==
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb8881921cmr344499975e9.25.1795600867092;
        Wed, 25 Nov 2026 02:01:07 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:06 -0800 (PST)
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
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] mm/khugepaged: allocate page tables before locking the folio
Date: Wed, 25 Nov 2026 10:59:44 +0100
Message-ID: <20261125100058.15200-2-azpijr@gmail.com>
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

try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
locked. set_huge_pmd() allocates the missing p4d/pud/pmd tables there,
and on ppc64 with the hash MMU do_set_pmd() also allocates the page
table to deposit.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
that may be waiting for the folio lock we hold.

Allocate these page tables before locking the folio. The mmap lock
keeps the upper levels around, and an unused deposit table is freed
after unlocking the folio.

Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/khugepaged.c | 79 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 93d4a6f159e8..e5adf6960a7b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1822,37 +1822,57 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 	}
 }
 
+/*
+ * Allocate the page tables needed to map a PMD at @haddr. Must be called
+ * before locking the folio: allocating with __GFP_FS while holding a folio
+ * lock can deadlock in reclaim.
+ */
+static enum scan_result alloc_huge_pmd_tables(struct mm_struct *mm,
+		unsigned long haddr, pmd_t *pmd, pgtable_t *prealloc_pte)
+{
+	if (!pmd) {
+		pgd_t *pgd = pgd_offset(mm, haddr);
+		p4d_t *p4d;
+		pud_t *pud;
+
+		p4d = p4d_alloc(mm, pgd, haddr);
+		if (!p4d)
+			return SCAN_FAIL;
+		pud = pud_alloc(mm, p4d, haddr);
+		if (!pud)
+			return SCAN_FAIL;
+		if (!pmd_alloc(mm, pud, haddr))
+			return SCAN_FAIL;
+	}
+
+	/* Archs like ppc64 deposit a page table along with the PMD mapping. */
+	if (arch_needs_pgtable_deposit()) {
+		*prealloc_pte = pte_alloc_one(mm);
+		if (!*prealloc_pte)
+			return SCAN_FAIL;
+	}
+	return SCAN_SUCCEED;
+}
+
 /* folio must be locked, and mmap_lock must be held */
 static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmdp, struct folio *folio, struct page *page)
+		pmd_t *pmdp, struct folio *folio, struct page *page,
+		pgtable_t *prealloc_pte)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	struct vm_fault vmf = {
 		.vma = vma,
 		.address = addr,
 		.flags = 0,
+		.pmd = pmdp,
+		.prealloc_pte = *prealloc_pte,
 	};
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
+	vm_fault_t ret;
 
 	mmap_assert_locked(vma->vm_mm);
 
-	if (!pmdp) {
-		pgdp = pgd_offset(mm, addr);
-		p4dp = p4d_alloc(mm, pgdp, addr);
-		if (!p4dp)
-			return SCAN_FAIL;
-		pudp = pud_alloc(mm, p4dp, addr);
-		if (!pudp)
-			return SCAN_FAIL;
-		pmdp = pmd_alloc(mm, pudp, addr);
-		if (!pmdp)
-			return SCAN_FAIL;
-	}
-
-	vmf.pmd = pmdp;
-	if (do_set_pmd(&vmf, folio, page, /* may_alloc= */ true))
+	ret = do_set_pmd(&vmf, folio, page, /* may_alloc= */ false);
+	*prealloc_pte = vmf.prealloc_pte;
+	if (ret)
 		return SCAN_FAIL;
 
 	folio_get(folio);
@@ -1881,6 +1901,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	unsigned long end = haddr + HPAGE_PMD_SIZE;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
+	pgtable_t prealloc_pte = NULL;
 	struct folio *folio;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, pgt_pmd;
@@ -1916,10 +1937,18 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	if (userfaultfd_protected(vma))
 		return SCAN_PTE_UFFD;
 
+	if (install_pmd) {
+		result = alloc_huge_pmd_tables(mm, haddr, pmd, &prealloc_pte);
+		if (result != SCAN_SUCCEED)
+			goto free_pte;
+	}
+
 	folio = filemap_lock_folio(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
-	if (IS_ERR(folio))
-		return SCAN_PAGE_NULL;
+	if (IS_ERR(folio)) {
+		result = SCAN_PAGE_NULL;
+		goto free_pte;
+	}
 
 	if (!is_pmd_order(folio_order(folio))) {
 		result = SCAN_PAGE_COMPOUND;
@@ -2067,7 +2096,8 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
-			? set_huge_pmd(vma, haddr, pmd, folio, &folio->page)
+			? set_huge_pmd(vma, haddr, pmd, folio, &folio->page,
+				       &prealloc_pte)
 			: SCAN_SUCCEED;
 	goto drop_folio;
 abort:
@@ -2086,6 +2116,9 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 drop_folio:
 	folio_unlock(folio);
 	folio_put(folio);
+free_pte:
+	if (prealloc_pte)
+		pte_free(mm, prealloc_pte);
 	return result;
 }
 
-- 
2.56.1

