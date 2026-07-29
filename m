Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6333B059D;
	Wed, 29 Jul 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343778; cv=none; b=VeazYKNCfb6d4+1wHXdFw3oifSGk1k0RHAjzG7ZyOtFukAn5hy6vuJyJlyeUJJb3WPs4CHsten0sTy5eKhihPExHMpaDH89LfYLrSGwi2eGChtD1FVvRd2JW3kppNYk/UXy+UQoDm4aAMLrlaSmsyOnWu4xf46LeIGbk4dsV+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343778; c=relaxed/simple;
	bh=KY9ZqNIwwoGsLwvvtZ58EeaTav1eJzmFIkOeHGwp7s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQpKifAeRBhdemEJtB+WL5rBrngf54tmYwQtIoOmg4IW7xG82//XYC59GaLXXCtj/wqqK8P0OFhzeapJWzXO6rIZGSonPBw8f3M+C1dhPC4mlvrhd0DOKqCSUXltldt0upCO3ZC52n72sj4xO331eKvFz0F8S0O43ekWLMFYGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU1azaNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU1azaNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808B71F00A3D;
	Wed, 29 Jul 2026 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343776;
	bh=4zuC9MNwDX34SkqJADsn0U6UXEfBdDKnSFkXL39okPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WU1azaNu7E7l4pfUEbRHfyCcGqUiwo1bOq9Bv2xjWe+nrAYCdiZVXzBCT/uOBYO9m
	 gHXvxDSxTFyk8utBxgTseywpnuXCHgvSg1TfR2HpTThSL4Uhj7sVOlYVewkNZJC73t
	 NBLTfZ8Sr7MkGFBGhEuIyDZqOQpZevlBcPsAtzXgSeIDMvYLKwN3V4w3U3tvSiP4Tc
	 R6K3MKi2a+oQJBwtqcrvA1FnL8xkwLV3R/NHH2YKM5hpBaZxqm0yC2Lcw0r9+FKGff
	 2MERa/F+SmegzgfJHKpd6jNkglTY+fm7guhANhEnfR7Ze1EP6v2yEzoFFt06EWLeHt
	 mF5CuT/qnYa+w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 29 Jul 2026 17:48:38 +0100
Subject: [PATCH v3 03/15] mm: abstract vma_address() and introduce
 vma_anon_address()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-b4-scalable-cow-virt-pgoff-v3-3-e8ecfefea812@kernel.org>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=ljs@kernel.org;
 h=from:subject:message-id; bh=KY9ZqNIwwoGsLwvvtZ58EeaTav1eJzmFIkOeHGwp7s8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKy9H5oxc7XV3gebFJ31Ftjgq05g3Fsjua2ieFNJYEb8
 0sKH9t2lLIwiHExyIopsjz/Ir4/SCRsXucFfzeYOaxMIEMYuDgFYCJLKhgZNh2O3iktrR2mtfDl
 sh7m1V8mnuZLv///j9buGVs3/BUWCmf4yZh2WFEkuUbg4IYVak8EZ3a2tZ05n2DdZ3964rEJuXv
 YGAE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Introduce __vma_address() which abstracts the VMA start page offset field
as pgoff_start, then update vma_address() to use it.

Then introduce vma_anon_address() which does the equivalent of
vma_address(), only using the anonymous page offset of the VMA rather than
the file-backed one.

Also add an assert to ensure that the function is not called for mappings
which are file-backed but not MAP_PRIVATE to ensure it is only used in the
correct places.

This will be necessary for determining the address of a folio's index
within a VMA when the folio belongs to a MAP_PRIVATE file-backed VMA but
has been CoW'd, and thus is anonymous, once the anonymous VMA page offset
field is used for the reverse mapping.

No callers are updated, so no functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/internal.h | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f26423de4ca2..0d11eb8e615f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1005,19 +1005,9 @@ void mlock_drain_remote(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
-/**
- * vma_address - Find the virtual address a page range is mapped at
- * @vma: The vma which maps this object.
- * @pgoff: The page offset within its object.
- * @nr_pages: The number of pages to consider.
- *
- * If any page in this range is mapped by this VMA, return the first address
- * where any of these pages appear.  Otherwise, return -EFAULT.
- */
-static inline unsigned long vma_address(const struct vm_area_struct *vma,
-		pgoff_t pgoff, unsigned long nr_pages)
+static inline unsigned long __vma_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff, pgoff_t pgoff_start, unsigned long nr_pages)
 {
-	const pgoff_t pgoff_start = vma_start_pgoff(vma);
 	unsigned long address;
 
 	if (pgoff >= pgoff_start) {
@@ -1035,6 +1025,41 @@ static inline unsigned long vma_address(const struct vm_area_struct *vma,
 	return address;
 }
 
+/**
+ * vma_address - Find the virtual address a page range is mapped at.
+ * @vma: The vma which maps this object.
+ * @pgoff: The page offset within its object.
+ * @nr_pages: The number of pages to consider.
+ *
+ * If any page in this range is mapped by this VMA, return the first address
+ * where any of these pages appear.  Otherwise, return -EFAULT.
+ */
+static inline unsigned long vma_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff, unsigned long nr_pages)
+{
+	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
+}
+
+/**
+ * vma_anon_address - Find the address an anonymous folio with index @pgoff_anon
+ * is mapped at.
+ * @vma: The vma which maps this object.
+ * @pgoff_anon: The anonymous page index belonging to the folio.
+ * @nr_pages: The number of pages to consider.
+ *
+ * This is only valid for anonymous or MAP_PRIVATE-mapped file-backed VMAs.
+ *
+ * Returns: If any page in this range is mapped by this VMA, return the first
+ * address where any of these pages appear. Otherwise, return -EFAULT.
+ */
+static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff_anon, unsigned long nr_pages)
+{
+	VM_WARN_ON_ONCE(!vma_is_anonymous(vma) && vma_test(vma, VMA_SHARED_BIT));
+
+	return __vma_address(vma, pgoff_anon, vma_start_anon_pgoff(vma), nr_pages);
+}
+
 /*
  * Then at what user virtual address will none of the range be found in vma?
  * Assumes that vma_address() already returned a good starting address.

-- 
2.55.0

