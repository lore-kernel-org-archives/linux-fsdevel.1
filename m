Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646230;
	b=p4ua15kQSyviHmz5xHuHIxhenWukzvqELtEwcrBDosFPy0uytAcPXiVwJsr+tySVnm03
	 mgFG3GijBpEyEZA0B9ASY/B4VdbDOPcYMm9YEJM6ps/DqHKm/8RhDMTSq40UwMJ9bBoPz
	 QUJV3KS0Or6qFd1J/f4kgJm/ywE18c3IvtSjmyitSFRwpU8HqWNUXahPzvjrUZhlAcJRG
	 Dk97J15BPo3PUfuHZfzYUXbK7ECf81mrAXLDtb8qP7PRDi0hNzVt7C0c3zMS0HhF7ykXS
	 y6rDHnqA+CrnMmvObvZoHVlU5wRjwmoWDabTcOcpU6ExQ4NkmkdV3wZGEzjtAbzP+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646230;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LPv00HXBHGcnrHwnYYcnQWrnezJpmZjmRwZVDwpJYZs=;
	b=lg9F1tulatxOBv3GJ2nPdrDbX+BkwEBa3Sj0LeJIm4HiTIYsCMiPGrAqUkBeA50d/Kpt
	 aE6aHaL5LGl3fQcVce0Zs/lUmXdSSI8Dr8kIXj6JyzAKVrohKDEeufGVr17CO7gWNQWE8
	 jWnmayzqViif+uB0EjsSjxLnsPl4EGI9TaastAat3q9oGt32g0iHr5IsPv7ZOYclyOktR
	 MdVJRuCHmpOWHdIyrj6nyzoNuZ44ajkipQ+GQQwfYbqT7UwsH3eVcUcWikGFCRDy4GwQl
	 22tViXZtMH+1eq8PtQY2QDOxY97n2lZKIDbfGwDbIDVEOeMvdaCmzXc46DLUaQ8UQPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd9AE7iW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F7606A31E;
	Wed, 25 Nov 2026 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd9AE7iW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D821F000E6;
	Wed, 25 Nov 2026 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646230;
	bh=LPv00HXBHGcnrHwnYYcnQWrnezJpmZjmRwZVDwpJYZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xd9AE7iWYslCbkrOtsacMp9S4QZka9TCU/PTNwIXNqVICw0J/mz8SeELZNUrsWsMT
	 i/3vqUZbMVdkv0i5UiOE913bfUaSAUQrzbUx7YHK3OM+bJdIdQ7pb8HRwU6UdI6bh6
	 6EUZDa6zh9fZYGiDDzM8RsVCOVrKdi5kK8sqsHLD8b9TE7IhDNAUKZsZS/jTCC+4AD
	 cplOKfhFhaAxb6ucOMt8Gj1rzz+Pkf3t1NXhNp4bsAuYXFez+3IQ24oLgM0J6pSfAr
	 i8fkUVtfgvdIjIjTpmhhU4RDqv3dLlNMkJmSN7ELsHi1pWuRZgWvuAWV0v0WYZvKNQ
	 LePKrkoEiP4sQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:12 +0100
Subject: [PATCH 14/21] mm/hugetlb: count migration entries at fork and
 unmap
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
Message-Id: <20261125-hugetlb_fixes_2-v1-14-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=david@kernel.org;
 h=from:subject:message-id; bh=irf5GUIfBQCl4azbFe2lzFg+Z8O8lLWnIpcOG+Ooqq0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1SvdCdnH1Dp2q7waYJMTTen2x+d5O1NyinbLpRf6
 W5U/vGto5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgInYpzMydFg8+TjFoIT7VpSU
 tBrv042ykYeL7ydm+z+7c6d9n+LzNkaGntqIqXvql15JSA76aLPu+95pOXMftDx2bRd4nGM2NX4
 qLwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

HugetlbPages in /proc/<pid>/status can be wrong, and even drop below
zero, if we fork() or unmap while mapped hugetlb folios are being
migrated.

There is an inconsistency: when installing migration entries we don't
adjust the counter, treating them as if they were present. However, when
copying or unmapping a migration entry, we don't adjust the counter like
we would for a present entry.

Let's fix it by adjusting the counter also for migration entries in
these cases. Add pte_is_migration_entry() like we did for other softleaf
types already.

This has low urgency and given that this has been around forever and
likely nobody cares, let's not CC stable.

Fixes: 5d317b2b6536 ("mm: hugetlb: proc: add HugetlbPages field to /proc/PID/status")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/leafops.h | 11 +++++++++++
 mm/hugetlb.c            |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 4c1476ae32343..c315a3531485e 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -587,6 +587,17 @@ static inline bool pte_is_uffd_marker(pte_t pte)
 	return false;
 }
 
+/**
+ * pte_is_migration_entry() - Does this PTE entry encode a migration entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if the PTE encodes a migration entry, otherwise false.
+ */
+static inline bool pte_is_migration_entry(pte_t pte)
+{
+	return softleaf_is_migration(softleaf_from_pte(pte));
+}
+
 #if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_HAS_PMD_SOFTLEAVES)
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2bba0940a40d5..89d71e3dadd77 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5131,6 +5131,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			if (!userfaultfd_protected(dst_vma))
 				entry = pte_swp_clear_uffd(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
+			hugetlb_count_add(npages, dst);
 		} else if (unlikely(pte_is_marker(entry))) {
 			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);
 
@@ -5480,6 +5481,8 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
 				spin_unlock(ptl);
 				continue;
 			}
+			if (pte_is_migration_entry(pte))
+				hugetlb_count_sub(pages_per_huge_page(h), mm);
 			/*
 			 * If the pte was wr-protected by uffd-wp in any of the
 			 * swap forms, meanwhile the caller does not want to

-- 
2.56.1

