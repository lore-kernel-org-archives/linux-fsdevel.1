Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851B233920;
	Mon, 20 Jul 2026 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558357; cv=none; b=D4OkdBArSsaTfEhWULjOj+nI7GD29++26b5SHw8vgewcVsQqRQu09bzDR7/r3wVM4hDDEaHXeOO9qScdOLZ1IyAzzFKY14AAQ/V1Ubh1TYLe2nDiViaaHGoga4CYHuj8nLMurEeoShe/ZsCMq1TnsWMuSwykLLb2l0ASb5Mlgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558357; c=relaxed/simple;
	bh=XmUIXnVj5BvnQMZaGvlFqJYGhJEsEnn8SPAP5N1zKgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFI5iEESA/DqDzkdJH3F6CQhdKTYSUryz1zlM9e2GO2AKDa9WnFA+jrj3TIPjfyOGXr9i+OhiQGIfu5xpiWeM5J8CidJhC0eFbELVOJ7y2tROl2S13WLm5jURCV49gGu0Qm9Bj9aeE6PNn+0djsHa9GzNJfWVqn6dgdAlaOJj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb58OMVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb58OMVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A194A1F00A3D;
	Mon, 20 Jul 2026 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784558356;
	bh=iFP97SMDeM1EuvkMbJb8/u/+y/6Q9ReGgoU9c1P8hOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kb58OMVN45aKYQMIYQk7+XxpHyXqBxUjmblkfpqYSokdZsRbRS2TMPlSw8h6Eu8RL
	 E/nMP3K2HGckSYICbTQON4rwaDSZCllu7H3aYe6IPGBPIUu9HzxJWLaywJT29MZa8C
	 tRsEqA+uMG1cWiuRoErHfFBAyaLTQfml3qBscH2UvSiXV5lbxClz2UodHnD/X8yE0V
	 BOpGJcrPKHcrFpvHLc1WMGqdP0Kop/2dzYQEJkDdHA1DFZOLYzZuzpPcguNSCeX2ew
	 caPDz+ynLReA1Y3SJt+9yHqNUVSB6Mp5azJ5z07gq1JNnDvTYl28TNnJxhsxc4kqpM
	 Hmz1bg/5kytJw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 20 Jul 2026 15:38:28 +0100
Subject: [PATCH v2 02/15] mm: introduce linear_virt_page_index()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-b4-scalable-cow-virt-pgoff-v2-2-2d549757a76f@kernel.org>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006; i=ljs@kernel.org;
 h=from:subject:message-id; bh=XmUIXnVj5BvnQMZaGvlFqJYGhJEsEnn8SPAP5N1zKgU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLijF6rSoV/FWHl51nq6XJ0deCVw8ZRu/x75/g9bkl9d
 PdEmtnzjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEwk7DbD/xCziuWr/gRlzmhY
 1KslcTi8dVHtuptPZ50UtNZk/mc17wjD//y4r3wfOO1/uYUvZkvKWLb2TJNbr0pynfSkabVue6c
 cYAAA
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
 include/linux/pagemap.h         | 42 +++++++++++++++++++++++++++++++++++++++++
 tools/testing/vma/include/dup.h | 25 +++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 2 deletions(-)

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
index c6fc783aaee5..c9c65ba60ab3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1101,6 +1101,48 @@ static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
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
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
+
+	return pgoff;
+}
+
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 00d416d79ec1..0c74899abb33 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1417,7 +1417,7 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
 	mas_set(&vmi->mas, addr);
 }
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
 }
@@ -1610,3 +1610,26 @@ static inline pgprot_t vma_get_page_prot(const struct vm_area_struct *vma)
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
+	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
+	if (vma_is_anonymous(vma) && !vma->vm_file)
+		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
+
+	return pgoff;
+}

-- 
2.55.0

