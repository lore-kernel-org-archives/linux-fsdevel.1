Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646023;
	b=QpDMSTHLgrBHkK27L6PHg6mj7Vw2G9Mc0a+IvdPux+HWPZRH7TNTZ8H7eBfx7va1rEQc
	 Dd0ABIkZueqsqcY94leCWRpEF7FRlvlOOaPQ4hKBPDYtEdcdL5vwl12gor3dx9mODnxvC
	 sHdfQtHfYbztX8MiS2K2TjIWT9xnJdfOPgu7KMe4Z0eUR4cTv86BH+l0ds7QA4ZGtB/Zw
	 X9JeXgjLPrUzuhTZBdM9cW1SKca4aqjrrL5GalC16Q/x4w7RUxH2BdzNOSnXS95N12YT2
	 KBUEsQl5bK3szGwchsz/cX+2UtgQuq2Ivp43rryqAEKzbHEA7jZ63BUhz4aNZTcJOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646023;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fXzNfGo7RfddoR5dRtUrH7smQbzk3tlvBFxiBJPCKVk=;
	b=X/+HyoAFwZD7IkUWWR2tP0LDizr8hLd2QK9mIdiePlSaYhhMmTQ8XnESo4DfZ9QKJzu4
	 dX65rojUQ9NoWfEq3dW1KwRSMEb/sWJmZ16fw8ye5H9O64ird2Op5cReDMizBo2J+cFn7
	 WxvGloAlPVwhMmrYm7LUsELSFxFReNmcTpAdzXRYSutUfi+brLdNHyia1ldZ2IEEY1/iz
	 kqQ/L44Q9Nn6KSE26jBCOWjC7hIm14xKkLVpHmzqC8Ae/AODt7q5v7JQk0Lq49DqJdi0m
	 Rqwj3JEMpdetK/SyKUkKTwRqtGAzq9J8WWZFsGIVLMir1NUYvSWIEJZn30a3IS19RAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmYEF5Ft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DD606A321;
	Wed, 25 Nov 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmYEF5Ft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5351F000C0;
	Wed, 25 Nov 2026 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646022;
	bh=fXzNfGo7RfddoR5dRtUrH7smQbzk3tlvBFxiBJPCKVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NmYEF5FtX6uDI4qQqeJ26Pi4q7EkUp7H9qXmB+5VFWNUj0H7Lmevbqo+IwECQy0US
	 Gzi27CL25JJNKCkmrMQZH8U1+eeac5ljt2zihFcIjGZH8IA1N1cbOlStAX0wbmBa/q
	 trk736gQ1b2+GcOsSwVSGK9aWe0QBsOEdC5Qipg3JCi1+iYUfH01y4nje16Wz6NEvY
	 esLL13GSFWNe+4ESBtAVcOyX0slwHcGsslTY83n/HNm6RKej8uCOpS8hOo/6ERIEDA
	 KRByR6HZ/krdf8FgVgQ3FOkgN8ZbxY/HJv4RLNv94Ic0noflkaUZcIOmNcMhc2HBfA
	 rBGq+fN9NCX9Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:32:59 +0100
Subject: [PATCH 01/21] mm/hugetlb: charge the copy made at fork to the
 parent
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3025; i=david@kernel.org;
 h=from:subject:message-id; bh=2bk4PJ9Bi2fWpYOfBgjZCtpD6hSW3oRGiP3OyVjpNlM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk5R/n7v2dSOzb41n7rspJSwMBjsiju1PTdvqYWi/s
 /J98N7yjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbC3srIsHpN3uQpJWdPKmml
 mkou3sKd1ZT2+hlHo+vS2Y8Y9rw9m87wz/4V+3ax/zaKxnyGK17pyR7bKHg6ou9GlkPCtppfizJ
 38gAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When copying page tables during fork(), the child is not yet assigned to
the right memcg. When copying possibly pinned anon hugetlb folios, we
must charge them to the parent's memcg, otherwise we can end up
allocating more hugetlb folios than allowed.

Let's fix it by charging the copy to the parent's mm, like we do when
copying small folios in copy_present_page(), introducing a new helper
function alloc_hugetlb_folio_for_fork().

This is a hotfix for v7.4.

Fixes: c2deb1356d82 ("mm/hugetlb: charge folios to the target mm's memcg")
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0e66fb306221..f46c85fc0cd0b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3103,8 +3103,9 @@ typedef enum {
  * allocation).  New call sites should (probably) never set it to true!!
  * When it's set, the allocation will bypass all vma level reservations.
  */
-struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, bool cow_from_owner)
+static struct folio *__alloc_hugetlb_folio(struct vm_area_struct *vma,
+		unsigned long addr, bool cow_from_owner,
+		struct mm_struct *memcg_mm)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
@@ -3187,7 +3188,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		.nodemask = nodemask,
 	};
 
-	folio = hugetlb_alloc_folio(h, &mpoli, vma->vm_mm, alloc_flags);
+	folio = hugetlb_alloc_folio(h, &mpoli, memcg_mm, alloc_flags);
 
 	mpol_cond_put(mpol);
 
@@ -3249,6 +3250,23 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(ret);
 }
 
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
+		unsigned long addr, bool cow_from_owner)
+{
+	return __alloc_hugetlb_folio(vma, addr, cow_from_owner, vma->vm_mm);
+}
+
+/*
+ * Allocate a folio for a copy in the child VMA during fork(), charged to the
+ * parent's mm: the child is not in its memory cgroup yet.
+ */
+static struct folio *alloc_hugetlb_folio_for_fork(struct vm_area_struct *dst_vma,
+		unsigned long addr, struct mm_struct *src_mm)
+{
+	return __alloc_hugetlb_folio(dst_vma, addr, /* cow_from_owner = */ false,
+				     src_mm);
+}
+
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
 	if (hugetlb_early_cma(h))
@@ -5110,7 +5128,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
+				new_folio = alloc_hugetlb_folio_for_fork(dst_vma, addr, src);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);

-- 
2.56.1

