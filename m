Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482761;
	b=DUVXin7i90qTKw5eRMLThgKYQIzpFKMp4t8Vcc+AwZSxVKzTJKt6GfFyP8nVf+nOMN3i
	 6wUEZPVzBUDxIk4vw+NMfFwjbGHoeYiasu9zbDJxQb8KEFs5A91geLG9mR4Jx3FEL+kW/
	 dmppakZVLQPKRWqXFANAyUP9XDlLzEDvCj1NCvdnk53kRNDLp8VgAN4TF++dpdbyZMYE4
	 vgzokjmEmZ/JBW6ln9zIs6xu05F0S23/UsDaSKjIZbV13codNolldOPczQZc/+VX6/xXp
	 2e9xpUe7vFTBzpgdRNMbs5RaG852Cx/B5oaeHfO4momQpvmTllGHQgOMetTe2uFZGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ahb900BtN45H4B5q25OIDwOBOyq++YAh9gkOLMihQg=;
	b=SOuDxKmgh5NMTX2wSQW7TFioWx0zyy8OoBsw0DB0gBoTSd0RYEi22uY/zYHy/rJwyutH
	 yYdUzTLuvi8dk3AVaklFq6LyrSjG7ha11RIh9372BuwVmruLNXtyp4bYAnX74RsVJC9sw
	 S3j3fljPB3PGKsc2uIlwYP6Yiq32Dbjj2YShnGnnpIrQ6i+ur7VIiT0gMlyl2lXmxL6T6
	 /ewkDZ3cpDjK9UvzW2rIrqteD6ai+Jqb+yK610ZHNBuVD+ZO1NZ5TFV/8YwJK1fOsIs+q
	 SVl8qdjNT1XZYomP/IkwWTD3EIVa0dgBIDlNdAlBBG4/oJdwiWdh11aQF5l3VG8wpyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQ4M66Ff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A74606A880
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQ4M66Ff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EEE1F00A07;
	Thu, 12 Nov 2026 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482761;
	bh=1ahb900BtN45H4B5q25OIDwOBOyq++YAh9gkOLMihQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WQ4M66FfhknQRiwDgcQNx9UTF6dw9I471yvpzzFpUSuIaGtUEIDttLJmvxsZHmCLQ
	 hJX0F1qlMlGDXUOYxTWf7SdVpL7CvzelD5QV/7wcBolWvM85ghWaA+9JhhRWKEqC3r
	 WniKL7pGR1/h0wZfwpTPxeY9yrq0JtLKm6qJS9CAq4M5AQAbwbQPtcvfMNTke5zy86
	 CxstBYAp1AKAptvpHqOlsDaeMJlRSIBRt4KAg8Z1cmGVPcjrm8Oq8RHrUiuj0GsC7p
	 YMtbiBe7/bYpGf43nhfrv078hWGpRSWJwn/m5859ygg8Z1pOoCtVRFawuoaJgLIDPa
	 xmpvfL3jz+yuQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Date: Thu, 12 Nov 2026 12:25:26 +0100
Message-ID: <20261112112528.1116405-5-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112528.1116405-1-arnd@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

With both x86 and arm having dropped CONFIG_HIGHPTE support, no
architecture is left using it, so remove the remnants in common code.

It is likely that further cleanups are possible in the page table
code but those are not obvious from the config options.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hugetlb.h | 5 +----
 include/linux/mm.h      | 1 -
 include/linux/pgtable.h | 9 ---------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 58f755e70e96..7c6d191fdf50 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -178,7 +178,6 @@ void hugetlb_bootmem_set_nodes(void);
 
 /* arch callbacks */
 
-#ifndef CONFIG_HIGHPTE
 /*
  * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
  * which may go down to the lowest PTE level in their huge_pte_offset() and
@@ -193,7 +192,6 @@ static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 {
 	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
 }
-#endif
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
@@ -1047,9 +1045,8 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 	 */
 	if (size >= PUD_SIZE)
 		return pud_lockptr(mm, (pud_t *) pte);
-	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
+	else if (size >= PMD_SIZE)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
 	return ptep_lockptr(mm, pte);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1a..019de55bd796 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4025,7 +4025,6 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 
 static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
 {
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
 	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
 	return ptlock_ptr(virt_to_ptdesc(pte));
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b..1352b4cee7ae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -100,14 +100,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #define pte_offset_kernel pte_offset_kernel
 #endif
 
-#ifdef CONFIG_HIGHPTE
-#define __pte_map(pmd, address) \
-	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
-#define pte_unmap(pte)	do {	\
-	kunmap_local((pte));	\
-	rcu_read_unlock();	\
-} while (0)
-#else
 static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 {
 	return pte_offset_kernel(pmd, address);
@@ -116,7 +108,6 @@ static inline void pte_unmap(pte_t *pte)
 {
 	rcu_read_unlock();
 }
-#endif
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
 
-- 
2.53.0

