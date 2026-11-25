Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646328;
	b=phwYJsiYPo/e9YTnVn9E6Z2rTHCtY0NocbzUbYQGuZvbZmlNQBSrITfNFWwdciTZsJql
	 84n9m1fAJ5Bx+cENNLcgSBvV0qMMtBZgpiHgejD+FTNyRavDTNHN7pWQesqRv1KsEYGae
	 Ie05aFiic1BkpvnOe28uSRQKoexqa4d210b5Dx53Ir2HbuLboRJwXUTwBKNkEYs9Zvkvp
	 xPY4RNBDCa0U5Nm5tSyEFZCPkC8EwqNttf/27eX9LjQc9spTwDRdgLG4lDFFZtpLWd8aw
	 gQsqLDJuBJmzG2la/NmlQV3gPdDmAPHIoBTPc+U74QgVUNEQanmtiBUucWk/yMQuNgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646328;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZmPaow3aRP/mBzNF7NAqWx/in1rPd5GnDvZIz10/EGU=;
	b=ZPUyj605xHfMpIzd5y3w29qi/D/zf8j7xO2DYatXTid0OVEinNbrqs3gU9ZOEgjbyrxB
	 1lPbXY4fmA9ctcoEupVM8Bz3xBp6+XdRLtjz0f3bQQdKUJBLBd97AsBNsGV5t+KXJwXfP
	 grslVmqd5S4zuZ1uPeRTNPuhLtJkNCYdn8OKhD7Z7QA7Vg9A/P63y/vhuNTxxyoLFGmIP
	 wcD1Wp8pfz4G75J7jLbmZ2ID7EpKAzSY+Jof7oZkbMkUU3/xbIOe5YI8fgbEbXbUY9+w1
	 alzshbWCRGGuHsWxzPo4rZq62Rja9mPhx/cgh1COargDbicdQjvY85EXo8Zk91KRHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kck3KUj7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C606A31E;
	Wed, 25 Nov 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kck3KUj7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E8C1F000D3;
	Wed, 25 Nov 2026 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646327;
	bh=ZmPaow3aRP/mBzNF7NAqWx/in1rPd5GnDvZIz10/EGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kck3KUj7vJS4ZeVNP5dth6KmT6gHDA25j5pi/Mlm4lHVub4QENyWtu123HUcGJWaD
	 Rl6cPbRSDWHJCcycyuMKnF4PaRpPvlsIUUhXGf/Gh90zai+FSgpndNMnhJP2fTLqCV
	 30XnFvrgW6Smdi/oGKIwqz3HFc7kYoNdReVHbuczICq1mspWkfyZTYRfpXxKPB1Ab3
	 gpitjL32298LymauPpHqMHGOH/zRByjab2cGejKPvzWIEsQO5lr0Wk2Oyy4SaVoJoB
	 6h4XMJpK6crskYi7uiSaVNQOctaPhIZt/qfokW4aMQtFSwY+1C8qE0ckCGwkMuUbb4
	 KVOy3psWBLEuw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:18 +0100
Subject: [PATCH 20/21] mm/hugetlb: resolve protnone faults without a uffd
 bit
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
Message-Id: <20261125-hugetlb_fixes_2-v1-20-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=david@kernel.org;
 h=from:subject:message-id; bh=/N0SQCShJZSXpsEEatww5OmscpGwDY5DnTCpFLl2oKQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1QN963jEHB2n7Sa7WjQu0+lOg1aGf3GChsnFpWzW
 ry68OxMRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABN5LMvwh/cbf+TE7e+lM5Mb
 OBaW36+NmLE8cUPd9RlJ2wN+rtdoK2P4ZxqRv/iiWtJuQ5GsuSZnLs51Xmv5o+DE9qJ7C4NPJdn
 M4QYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

hugetlb_fault() only restores the protection of protnone entries that
have the uffd bit set, assuming that accessible VMAs cannot have other
protnone entries. If such an entry existed nevertheless, any access to
it would result in an endless fault loop.

We are not aware of a way to trigger this: paths that drop the uffd bit
(fork(), mremap(), unregistering) restore the protection, and
remove_migration_pte() only drops the uffd bit for writable migration
entries, which cannot be created from protnone entries.

Let's be defensive and make any protnone entry in an accessible VMA
accessible again, unless it is an RWP fault that has to be reported to
user space, like do_numa_page() does for small folios.

Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comments and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 62ed8d9aeeadd..438263c2ba3d9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6355,32 +6355,33 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * Protnone hugetlb PTEs with the uffd bit are used by
-	 * userfaultfd RWP for access tracking. Plain PROT_NONE (without the
-	 * marker) is not an RWP fault and is not expected on hugetlb (no
-	 * NUMA hinting), so let normal hugetlb fault handling proceed.
+	 * Protnone hugetlb PTEs with the uffd bit are used by userfaultfd RWP
+	 * for access tracking. Without the bit there is nothing to report, so
+	 * just make the PTE accessible.
 	 */
-	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
-	    huge_pte_uffd(vmf.orig_pte)) {
+	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma)) {
 		spinlock_t *ptl;
 		pte_t pte;
 
 		/* Sync: drop hugetlb locks before blocking in handle_userfault() */
-		if (userfaultfd_rwp(vma) && !userfaultfd_rwp_async(vma))
+		if (huge_pte_uffd(vmf.orig_pte) && userfaultfd_rwp(vma) &&
+		    !userfaultfd_rwp_async(vma))
 			return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
 
 		ptl = huge_pte_lock(h, mm, vmf.pte);
 		pte = huge_ptep_get(mm, vmf.address, vmf.pte);
-		/*
-		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
-		 * are no longer registered with uffd.
-		 */
-		if (pte_protnone(pte) && huge_pte_uffd(pte)) {
+		if (pte_same(pte, vmf.orig_pte)) {
 			unsigned int shift = huge_page_shift(h);
 
 			pte = huge_pte_modify(pte, vma->vm_page_prot);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
-			/* huge_pte_modify() preserves _PAGE_UFFD; drop it on resolution */
+			/*
+			 * huge_pte_modify() preserves _PAGE_UFFD; drop it on
+			 * resolution.
+			 *
+			 * TODO: fix all cases where uffd PTE bits remain in VMAs
+			 * that are no longer registered with uffd.
+			 */
 			pte = huge_pte_clear_uffd(pte);
 			pte = pte_mkyoung(pte);
 			/*

-- 
2.56.1

