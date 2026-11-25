Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646311;
	b=LlrWba2V7CJA9A07lBj7JwH95qAwo2lk7Y/L42UizO6e3lemVMoNJgm+6BmWHlVeLabi
	 9UrtdScqzVDJsfWadLO8oqfifAZRL6erGFQrPeCpo8WgVMHNi6v4TsGN1u6Efo9g7WLuN
	 dkKzStv69gWSeyVGCBmIgXYnU1FRHEgtzvDqq2Ia8CT+UOEzjkoFuHmwf9E3MAGI4HIdH
	 iqVdPbJpyEZOM62OSL5itHoU8kh6Nl2COhKec9ysaQBxjMQZ6YuftH8qUCBZ9/Y1nO3D9
	 jYH7ZD6yewAxefVLcbpOhXA2FqOgKFGfYMMtXwcD7MtyaL4ZyOo94GxhFRbESlkWZjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646311;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xAZnRy4ClkSREhxpzPfANj/gGJeGD+jD2/eNSheQ1pc=;
	b=H5EPCcdaHeE8T2UoKreqS+N/S0MyuZLPqYo8LiLw2T2OylbnelyIF56rh6JaNE28chy6
	 hkLHNldzig2uFdtzw2Uw49G6jDtbRWwqRx/c2MtCtSM3IU4lJ2hKNl/GNLj/feWSoVqeE
	 Drf+QYQEMHh7OqlcX2l8ow2BCDpl2TK9MkFNS8uxmXZcB2Vf7npU88juKoI41fsbm05aN
	 /LAW9q6rxHrbRYdAz+IRqEdx9J8Z0BVTJLwfzIOUiOMhgc5aBmJNV2Va8UjForHOb5D09
	 MQ+IlhcbaoPd15+cGXFr0PpkrZBMym0qQUDsqqNAeUbbhKGU+t2IEa2rjnuDZVua8Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hd2Wiu/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51D606A31E;
	Wed, 25 Nov 2026 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hd2Wiu/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC91F000D0;
	Wed, 25 Nov 2026 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646311;
	bh=xAZnRy4ClkSREhxpzPfANj/gGJeGD+jD2/eNSheQ1pc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hd2Wiu/P8uIxlKTdjUOUTYFoij2bc4AjUep+hFytgDGFz4JyXIiyXD9VW3wDxpNxS
	 +obf+ckENrzeA9vbQqu2NviMHORKBVMsJ6b8Q2lXjNIu9DbkFlA9HaLBF33edWjPGi
	 hckgy6Xe0kuB9i4sqQELrUCO84TtwrwjvLMXIC7NYlalyxmv5BtReOOsdVrdOqQZql
	 QygU+eT9s2nYmFzzl+CPwZbLPHsC3v/CKciZKSw3Qp67i7cXRgz9+APlIbouBE7DG7
	 baFeo5B21tKkkv0WtMffh4PXCv8ZcbXuV2L21g07upLcGqRlswmAoY8Kkak91j23sE
	 1iMeICdwga3XA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:17 +0100
Subject: [PATCH 19/21] mm/hugetlb: use the VMA lock to stabilize flags for
 PMD sharing
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
Message-Id: <20261125-hugetlb_fixes_2-v1-19-db27fd2f71a8@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6785; i=david@kernel.org;
 h=from:subject:message-id; bh=PwP2RLUs3pwQwesqKHMjKcPs2SdsbC0XZtUwTfW/jbY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1T/hT3qEOxbNI3jiYVKS0y/7dL2txxznbbt1PirY
 3bgnOPpjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZyypDhr/yPUyqfzity8EUq
 q7U33lSM9a9qFqmQWF985N/8PRa1KowMX9qi9PY7pn01Ouho8OuZ/jUrtS3+ga4X7kamhEuv7Wl
 nAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

huge_pmd_share() currently only shares the page tables of another VMA if
it can read-lock the mmap lock of the corresponding mm. That refuses
sharing whenever that mm is write-locked or if the mmap lock is
contended.

mprotect() holds the VMA write lock while changing the flags and the
page table entries, so let's read-lock only that VMA instead. As we hold
i_mmap_rwsem, that VMA remains part of its mm and cannot go away.

Add vma_trylock_read(), a variant of vma_start_read(), that does not
require being called with the RCU read lock held, and will also not drop
it itself.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmap_lock.h |  1 +
 mm/hugetlb.c              |  4 +--
 mm/mmap_lock.c            | 78 +++++++++++++++++++++++++++++++----------------
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index bada7a03ddf4b..f42444069e76c 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -278,6 +278,7 @@ static inline bool vma_start_read_locked(struct vm_area_struct *vma)
 
 struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
 					       unsigned long address);
+bool vma_trylock_read(struct vm_area_struct *vma);
 
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5db97f6d15595..62ed8d9aeeadd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7287,7 +7287,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * Stabilize the svma flags, as mprotect() changes flags
 		 * before adjusting page tables.
 		 */
-		if (!mmap_read_trylock(svma->vm_mm))
+		if (!vma_trylock_read(svma))
 			continue;
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
@@ -7297,7 +7297,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (spte)
 				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
 		}
-		mmap_read_unlock(svma->vm_mm);
+		vma_end_read(svma);
 		if (spte)
 			break;
 	}
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index c7261f980cef1..68c16281e52a5 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -212,26 +212,17 @@ static bool vma_seqcount_is_write_locked(unsigned int vma_seq, unsigned int mm_s
 }
 
 /*
- * Try to read-lock a vma. The function is allowed to occasionally yield false
- * locked result to avoid performance overhead, in which case we fall back to
- * using mmap_lock. The function should never yield false unlocked result.
- * False locked result is possible if vma gets reused and attached to a
- * different mm before we lock it.
- * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
- * detached.
- *
- * IMPORTANT: RCU lock must be held upon entering the function, but upon error
- *            IT IS RELEASED. The caller must handle this correctly.
+ * Like vma_start_read(), but without RCU handling: the caller must make sure
+ * that the vma cannot be freed, for example by holding the RCU lock.
  */
-static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
-					     struct vm_area_struct *vma)
+static struct vm_area_struct *__vma_start_read(struct mm_struct *mm,
+		struct vm_area_struct *vma)
 {
 	unsigned int vma_seq;
 	unsigned int mm_seq;
 	struct mm_struct *other_mm;
 	int oldcnt;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
 	/*
 	 * Check before locking. A race might cause false locked result.
 	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
@@ -241,10 +232,8 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 */
 	vma_seq = READ_ONCE(vma->vm_lock_seq);
 	mm_seq = READ_ONCE(mm->mm_lock_seq.sequence);
-	if (vma_seqcount_is_write_locked(vma_seq, mm_seq)) {
-		vma = NULL;
-		goto err;
-	}
+	if (vma_seqcount_is_write_locked(vma_seq, mm_seq))
+		return NULL;
 
 	/*
 	 * If VM_REFCNT_EXCLUDE_READERS_FLAG is set,
@@ -257,8 +246,7 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
 							      VM_REFCNT_LIMIT))) {
 		/* return EAGAIN if vma got detached from under us */
-		vma = oldcnt ? NULL : ERR_PTR(-EAGAIN);
-		goto err;
+		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
 	}
 
 	__vma_lockdep_acquire_read(vma);
@@ -288,14 +276,9 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	mm_seq = raw_read_seqcount(&mm->mm_lock_seq);
 	if (unlikely(vma_seqcount_is_write_locked(vma_seq, mm_seq))) {
 		vma_refcount_put(vma);
-		vma = NULL;
-		goto err;
+		return NULL;
 	}
 
-	return vma;
-err:
-	rcu_read_unlock();
-
 	return vma;
 err_unstable:
 	/*
@@ -309,11 +292,54 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	mmgrab(other_mm);
 	vma_refcount_put(vma);
 	mmdrop_async(other_mm);
-	rcu_read_unlock();
 
 	return NULL;
 }
 
+/**
+ * vma_start_read() - Try to read-lock a vma looked up under RCU.
+ * @mm: The mm the vma is expected to belong to.
+ * @vma: The vma to read-lock.
+ *
+ * The function is allowed to occasionally yield false locked result to avoid
+ * performance overhead, in which case we fall back to using mmap_lock. The
+ * function should never yield false unlocked result. False locked result is
+ * possible if vma gets reused and attached to a different mm before we lock it.
+ *
+ * Context: RCU lock must be held upon entering the function, but upon error
+ * IT IS RELEASED. The caller must handle this correctly.
+ *
+ * Return: The vma on success, NULL on failure to lock and ERR_PTR(-EAGAIN) if
+ * the vma got detached.
+ */
+static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
+		struct vm_area_struct *vma)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
+
+	vma = __vma_start_read(mm, vma);
+	if (IS_ERR_OR_NULL(vma))
+		rcu_read_unlock();
+	return vma;
+}
+
+/**
+ * vma_trylock_read() - Try to read-lock a VMA that belongs to its mm.
+ * @vma: The VMA to read-lock.
+ *
+ * Unlike vma_start_read(), this function does not deal with VMAs that might
+ * get freed and reused in another mm concurrently.
+ *
+ * Context: The caller must make sure that @vma remains part of @vma->vm_mm
+ * and cannot go away.
+ *
+ * Return: true if @vma is read-locked, false otherwise.
+ */
+bool vma_trylock_read(struct vm_area_struct *vma)
+{
+	return !IS_ERR_OR_NULL(__vma_start_read(vma->vm_mm, vma));
+}
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the

-- 
2.56.1

