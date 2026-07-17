Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8F37F732;
	Fri, 17 Jul 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312555; cv=none; b=MJ/FaZaXpiyuGfLQUmBfbuF1kHVXUXOb4hoViczXVy4TjqMcXLiL7DB5zrYX8Jhv+2nw5wFIGkZMHFU+wJ5GWE3Itcivgy56jsQmQt7vudEAdlMxdW8leLvmNL2OmiAQy6fYHLW/Dmp1Pn4WfQjqkhWa94aZ0g3rX8q/zllaeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312555; c=relaxed/simple;
	bh=uH5Jc7cUxcyEjswUfjNSH8zXPOA1SoCYNdQzvopkVXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Db9zzJXlMUwrmgOVIbm0IFHFrtqJJj3K7E32XBP2sDspxPP7aK0TSzOIcJLuuB0GUkNzSImKkSLdSsg3KBNFpUHp1GFmIeS7kdR+1QVedLVmCjYOOXpTu3lD325f4PiIFcQ//PNfzjln75Noys0b2FJ8pPY8iU682BT35IyGsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv0O7c/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv0O7c/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1402D1F000E9;
	Fri, 17 Jul 2026 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312548;
	bh=z7hUpZUpGSNT5pTheBg1aLusw4z3n2IV4NIpFOCmsM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iv0O7c/cyThXK+BwGq+t0bqFQIEcSP9JnjGHjL88OjKYam1KO93erpmi6Qqv2i6wj
	 KLVl/KIvIIIXULRFqK6km63WOb1NSMAy19EAtsTqTqQrUOLO+xK1tS67UP5df987od
	 lnvHCnhS+Yd2CkvHYczJb/wUnu6KJN5K+3KY4+jBydAZI5rw8gGhV3u/A5win8Ci/c
	 yNfHr/Pt2aH9GyAchR6StrnHTINBJq534AmnPBZJWBrMMZEyU+oR4g/ORKm3Q2fONq
	 tVgAzQghEMFtZ9J7vKCT9wA3sIYhpRzZRxKFuniOEOb/FVH4yJUGlKtC8hBmwDuxDl
	 +nk6Wlknpcilw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 19:19:40 +0100
Subject: [PATCH 02/15] mm: introduce linear_virt_page_index()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-scalable-cow-virt-pgoff-v1-2-cf24910ef094@kernel.org>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596; i=ljs@kernel.org;
 h=from:subject:message-id; bh=uH5Jc7cUxcyEjswUfjNSH8zXPOA1SoCYNdQzvopkVXQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiivZ+PFhuNm29vdiBi4qBnraTuVSfLl5j+9X4S3Bpm
 nx5ce2DjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzk3zOGf1ZWJUt/GxTc3f00
 5+1L3apjr0y6BTiitCcslJgRJXbryhlGhnnSWxflRaelzcn/cNduHUe7yu2IhJOzJ+ZcfKjm8tp
 VnQsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This function provides the virtual equivalent of linear_page_index(),
instead offsetting based on the virtual page offset of the VMA.

It is valid only for anonymous or MAP_PRIVATE file-backed mappings. It must
not be called for shared file-backed mappings.

For pure anon VMAs, this will be equal to linear_page_index().

We implement the algorithm in __linear_virt_page_index(), which is provided
for internal mm code that might be interacting with shared VMAs.

In linear_virt_page_index() we assert that both of these invariants are
true.

Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
but not fulfill this invariant, so when asserting this we check
vma->vm_file to account for this.

We do not update callsites yet, so no functional change intended.

Also const-ify vma_is_anonymous() to make it compatible with the
const-ified linear_virt_page_index().

VMA userland tests are updated accordingly.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              |  2 +-
 include/linux/pagemap.h         | 41 +++++++++++++++++++++++++++++++++++++++++
 tools/testing/vma/include/dup.h | 22 ++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 59b98cc60402..b6503b5f0010 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1556,7 +1556,7 @@ static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
 	desc->vm_ops = NULL;
 }
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
 }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c6fc783aaee5..81da91e103b3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1101,6 +1101,47 @@ static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
 	return pgoff;
 }
 
+static inline pgoff_t __linear_virt_page_index(const struct vm_area_struct *vma,
+					       const unsigned long address)
+{
+	pgoff_t pgoff;
+
+	pgoff = linear_page_delta(vma, address);
+	pgoff += vma_start_virt_pgoff(vma);
+	return pgoff;
+}
+
+/**
+ * linear_virt_page_index() - Determine the absolute virtual page offset of
+ * @address within @vma.
+ * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address resides.
+ * @address: The address whose absolute page offset is required.
+ *
+ * This returns the virtual page offset of @address, which is the page offset
+ * the address possessed at the time the VMA was first faulted.
+ *
+ * For anonymous mappings, this returns the same value as linear_page_index().
+ *
+ * For MAP_PRIVATE file-backed mappings, this returns the virtual page offset of
+ * @address, which is the page offset the address possessed at the time the VMA
+ * was first faulted.
+ *
+ * It is not valid to call this function for shared file-backed mappings.
+ *
+ * Returns: The absolute virtual page offset of @address within @vma.
+ */
+static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
+					     const unsigned long address)
+{
+	const pgoff_t pgoff = __linear_virt_page_index(vma, address);
+
+	VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
+	if (!vma->vm_file) /* Is anonymous except MAP_PRIVATE-/dev/zero */
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
+
+	return pgoff;
+}
+
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 00d416d79ec1..51605ade06fb 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1610,3 +1610,25 @@ static inline pgprot_t vma_get_page_prot(const struct vm_area_struct *vma)
 {
 	return vma_flags_to_page_prot(vma->flags);
 }
+
+static inline pgoff_t __linear_virt_page_index(const struct vm_area_struct *vma,
+					       const unsigned long address)
+{
+	pgoff_t pgoff;
+
+	pgoff = linear_page_delta(vma, address);
+	pgoff += vma_start_virt_pgoff(vma);
+	return pgoff;
+}
+
+static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
+					     const unsigned long address)
+{
+	const pgoff_t pgoff = __linear_virt_page_index(vma, address);
+
+	VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
+	if (!vma->vm_file) /* Is anonymous except MAP_PRIVATE-/dev/zero */
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
+
+	return pgoff;
+}

-- 
2.55.0

