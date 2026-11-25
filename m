Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646150;
	b=FLKFYuQuwgrczCJjtIXHHkE95mYRn6ypxMx8TeyZ5bCOVoRhfNTFmASF6uFGPz8B6mZj
	 B52u5nUdJWbc3MMUnpNvWBAnJptQIGHdOwsi3f5mOBR5ZHO8X1qxLdD6/eAPpkwTxNEa3
	 /+H0Sfgr9yDL4M6ZNhfRCkJcuirMFZxQpp1Ga+L18sl46MD35jaIgoeR66wu27R65HsgQ
	 rJukHa/tc8UhHD0HCcOzlHER8UH5fUE7WgUpdLWeUGOez1e9B/dDMvwHvaDdbaHmmsJqS
	 IL9dJ+Emf7OyaF4kBa8pBRlRnxRxSrophFCzgbTMilj+mkBvthowLwr8iQqCrJxuqBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646150;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YMCbRgDJx8My7FQr8Am7ZyN1elVge2GAU4cJitwdV1I=;
	b=THexBIrQChwBWdxp11y7cke7ug2M1VDZxWTAnPG5/xDdGiXk5InDtHX9UpAAlNGfhptU
	 irMXUgqsVe4Jwh1psk96G+Fh9UgfzMJG89DAS2Aq2ByC3KiMY9dAU9G/n8qxaFs27lJs1
	 IT6RRrHuqJg7rBm71/axE6kFk/bvLqLWIJ1idP0lmZTg7yJGrUpPLbYUMuuBjqowS+E1X
	 fAjqVLUNa2VeXsmh1J2zeWgD6yPVCvgFInK7yfFy3RfQyRHufLq7zLQB+XLeM70LWOa69
	 t3i6aSGEt86s/awVdfQgzYw70Txpcg8yKhLpeAhcvfmTuZSS0KSfF4DV2gNnWQAZLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJXjn1c+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6E606A321;
	Wed, 25 Nov 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJXjn1c+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366811F000C4;
	Wed, 25 Nov 2026 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646150;
	bh=YMCbRgDJx8My7FQr8Am7ZyN1elVge2GAU4cJitwdV1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SJXjn1c+7pIabnj8kPX5lZxyarzkpDWWLusXBCpqjsExrs/MaVwmfO95QUNnTd5Re
	 r27Q2AYBE8B+MyS0tm7Ft1TS/WmNAPOPHKFXH2SPyoz2nIETvKNkU4qz3+gFP6Cozx
	 OTQezEc4bbc17FFzXQfvHMXsarQelHiOVkRJ81ZvGq0QVaBkeuPLeYZAvryL/OlLe8
	 PjAjI1j8B7T2SBg1nFfpd7ZTrXfeKZdsAFbZI1n/JUIX4eIpemDzoAwsx02LClA3bo
	 wSO/OapyRca3JYN2LWkXF5Ep0pv1mQT4bbua2hclzhdeX5VcKC2zaoSbFbw/DPOUJE
	 HLcMD7dRyvNfg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:07 +0100
Subject: [PATCH 09/21] mm/hugetlb: don't zap non-present entries when
 unmapping a folio
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
Message-Id: <20261125-hugetlb_fixes_2-v1-9-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=david@kernel.org;
 h=from:subject:message-id; bh=mlk8Hq0S+1YqGOS8OKXZSom4G0hgd8p+sLBTmZ3zL2Y=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1TkFCb7vtXncJnSciWWZdZr3xr2DvaQ8snSp86Ir
 nPsTJDrKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCKp3Ay/mJ/q7Gvau3DWknWS
 G/XWZ/bUmfPJxTaa2vW5Hzgf7jhDjJHhoe8mazm9wuUZAVom2lkOO7bPVWw/dEbFRsN+97Mjc7b
 xAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

When the owner of a private hugetlb mapping fails to allocate a folio
for COW, unmap_ref_private() unmaps the old folio from the forked
children, and marks them with HPAGE_RESV_UNMAPPED, so they get a SIGBUS
on their next access.

hugetlb_unmap_range() is supposed to only unmap that folio, but it
clears non-present page table entries unconditionally.

A child can silently lose its COWed folio while it is getting migrated,
or a hwpoison entry or uffd poison marker, without HPAGE_RESV_UNMAPPED
getting set. Consequently, it would not SIGBUS on the next access.

Let's fix it by ignoring non-present entries when unmapping a folio. As
the folio is locked, migration entries of that folio do not apply.

This has low urgency, as it requires a failing COW allocation in the
owner racing with migration or memory failure in the child. Let's not CC
stable.

Fixes: 8c4894c6bc79 ("hwpoison, hugetlbfs: fix "bad pmd" warning in unmapping hwpoisoned hugepage")
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index befa2670cb03f..2c13349863bd8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5457,6 +5457,14 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
+			/*
+			 * If we have a folio provided, we only care about
+			 * present page table entries (folio is locked).
+			 */
+			if (folio_provided) {
+				spin_unlock(ptl);
+				continue;
+			}
 			/*
 			 * If the pte was wr-protected by uffd-wp in any of the
 			 * swap forms, meanwhile the caller does not want to

-- 
2.56.1

