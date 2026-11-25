Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646344;
	b=utdfLrsmX983s59xhnqUnaZ8+nOvgGPl0nFE6ip2/a3oaY3uU3nDPic+mrj9TIY4eUrm
	 lvG2WVDt81FV9A5bnQoJ3Jvtam1ML+bki+FtU1MRRq21IygmJEX+2NU+QCav4pbExCY6d
	 8fz9p84eDGYOdVrrfPhG0T/ZF8IYYcuPFkYlR05Wc7BaNlw1Klg64bT5R2bwRkczByp1N
	 ziYV0hfhca1CUY1dqum3cQ/NrrP0y/r8z+WIQRosGoNqBuLN5PLeC7MpJ4ZfBU0Ybb5Do
	 xxaPQuygHN2D/g81VVtkxIowqd8KuHnYV9MJN2EI7BMdWQPl6CwTEJ6jbWb6WZFEZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646344;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=li/Z73kIBxQSgciTmM8k7ypsdLM7WIF3LC62JW/m68c=;
	b=qJjshp3wosqypQ8a0a2CWXicTjxecKzeqV9XnuTFspADKjIWi8CBcWHXYCfifTGvW+0W
	 trniEHMGISi75y2LV6ZSJdDRN3ysXB38tFAO/kAu1QrE6fynAtBB+5DphG5MzLi51lxEn
	 X8+ZDYqiWZVTxOtNfO2OfWV2BwdKB31QXe1i+J6COydV4+acr17YmkJZahceNj0SCk41m
	 0W0Y0HUoFJXBhdeEx6A8Jzx7kJ5kU+l+/m4DryC1gAFsP73K8gPY9a+baHw54DtMdh1cD
	 IRdEkaddnpk7dKQhvqLlj1nPOcZMMgGfRuE3OSTULQ/MObPjIBNiEcSSWkw4Euhjysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWRSzkxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78502606A326;
	Wed, 25 Nov 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWRSzkxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9E51F000F0;
	Wed, 25 Nov 2026 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646344;
	bh=li/Z73kIBxQSgciTmM8k7ypsdLM7WIF3LC62JW/m68c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WWRSzkxKCDtSTbuZO9OMBcIfWezVK/8KYw9obS2Wic3WfhWYL/H4LAa/9miP/KChS
	 dpbbuZdFJ/ltxFE9X+kRMLux851BA9WBn5vEWTSxqPcse4iCblZq5qba3QO2A/gMe5
	 FQFnJoORZE0KObUJjQ/2Bn4TcNDxTBKvTDj9jhnZCkWthJ/s3wfe+5bhC2uxGMPkZR
	 sR5i2IxpIglwqi4IvRpYtm/PQFY3BV1gU+lIDj+y1pzbS1XxQZF9bJcniYUGYlqTHZ
	 /8dPwpDVl/TeyTGIzPrcVIK7kHt+hwdmavgP9LUtMonJZF687RYVWXeJ1hNhz9QRvJ
	 6G+PuPLFnQ0kQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:19 +0100
Subject: [PATCH 21/21] RFC: mm/hugetlb_cgroup: charge faults to mm->owner
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
Message-Id: <20261125-hugetlb_fixes_2-v1-21-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7801; i=david@kernel.org;
 h=from:subject:message-id; bh=lJ4xfsTmQl063PifoPRspfQkZofQC6q60Ex8KWNPtEc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1TlMoOMzGK3Kgj4P5Zk+ej8QK26jeHLiQ0qKU3c3
 n8Nb3/rKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCKvJjMynF/K8E+uaVfc07Vi
 KzynrTxq+6zQIEH3QH3021A+z7ZznAx/xY4+mfs9YHNA6uvFkR9lQ02+X98cwW7Nsv+VgZTLwxv
 K/AA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

We can bypass hugetlb cgroup limits when a kernel thread faults in
hugetlb pages for a user process: __hugetlb_cgroup_charge_cgroup()
charges the hugetlb cgroup of current, and kernel threads usually live
in the root cgroup, which has no limit.

For example, a KVM's async page fault repeats a fault of a vCPU that
just failed at the limit in a kworker, which then charges the root
cgroup:

    vCPU thread                     kworker
    ===========                     =======
    __kvm_mmu_faultin_pfn()
      hva_to_pfn(), FOLL_NOWAIT
        hugetlb_alloc_folio()
          charge fails
        KVM_PFN_ERR_NEEDS_IO
      kvm_setup_async_pf()
                                    async_pf_execute()
                                      get_user_pages_remote()
                                        hugetlb_alloc_folio()
                                          charges the root

Let's fix it by charging the hugetlb cgroup of mm->owner whenever we
allocate for an mm, like memcg does. Unlike memcg, which falls back to
the root cgroup, we fail the charge if the mm has no owner (anymore), as
we would otherwise bypass the limits again. As mm->owner depends on
CONFIG_MEMCG, nothing changes without it.

This changes the charged hugetlb cgroup in these scenarios:

 (1) Kernel threads that fault on a user mm, such as KVM async page
     faults, kvm_xen_set_evtchn() in the irqfd work item and
     iommu_sva_handle_mm(), now charge the cgroup of mm->owner instead
     of the root cgroup.
 (2) vhost kthread workers, which join the cgroups of the task that
     created them, now charge the cgroup of mm->owner.
 (3) With cgroup v1, threads of a process that are in different hugetlb
     cgroups now all charge the cgroup of mm->owner.
 (4) Processes that fault on the mm of another process, such as a
     userfaultfd monitor (UFFDIO_COPY) or remote GUP through ptrace,
     /proc/pid/mem or process_vm_writev(), now charge the cgroup of the
     target's mm->owner instead of their own cgroup.

... which should just be the right thing to do.

This has low urgency, as it only affects hugetlb cgroup limits. Let's
not CC stable, as this might not be particularly easy to backport.

Fixes: 6d76dcf40405 ("hugetlb/cgroup: add charge/uncharge routines for hugetlb cgroup")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/hugetlb_cgroup.h | 10 +++++-----
 mm/hugetlb.c                   | 11 ++++++-----
 mm/hugetlb_cgroup.c            | 30 +++++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 1c437eb2e1c30..97208bb9d9639 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -139,9 +139,9 @@ static inline void resv_map_put_hugetlb_cgroup_uncharge_info(
 }
 
 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr);
 extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
-					     struct hugetlb_cgroup **ptr);
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
 					 struct folio *folio);
@@ -225,14 +225,14 @@ static inline void resv_map_put_hugetlb_cgroup_uncharge_info(
 }
 
 static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					       struct hugetlb_cgroup **ptr)
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr)
 {
 	return 0;
 }
 
 static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
-						    unsigned long nr_pages,
-						    struct hugetlb_cgroup **ptr)
+		unsigned long nr_pages, struct mm_struct *mm,
+		struct hugetlb_cgroup **ptr)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 438263c2ba3d9..2b0ae201e1e60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2305,7 +2305,7 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 	int idx = hstate_index(h);
 	int ret;
 
-	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg))
+	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, NULL, &h_cg))
 		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
@@ -3000,7 +3000,8 @@ void wait_for_freed_hugetlb_folios(void)
  * hugetlb_alloc_folio - Allocate a hugetlb folio.
  * @h: Hugetlb state control block.
  * @mpoli: Interpreted memory policy to use for allocation.
- * @mm: Memory descriptor of the allocation target.
+ * @mm: Memory descriptor of the allocation target. With CONFIG_MEMCG, the
+ *      hugetlb cgroup of the owner of @mm is charged.
  * @alloc_flags: Flags controlling the allocation behavior.
  *
  * Allocates a hugetlb folio and handles cgroup charging and global hstate
@@ -3026,10 +3027,10 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 	int ret;
 
 	if (charge_hugetlb_cgroup_rsvd &&
-	    hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg_rsvd))
+	    hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, mm, &h_cg_rsvd))
 		return ERR_PTR(-ENOSPC);
 
-	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg)) {
+	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, mm, &h_cg)) {
 		ret = -ENOSPC;
 		goto err_uncharge_hugetlb_cgroup_rsvd;
 	}
@@ -7011,7 +7012,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	}
 
 	err = hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
-				chg * pages_per_huge_page(h), &h_cg);
+						chg * pages_per_huge_page(h), NULL, &h_cg);
 	if (err < 0)
 		goto out_err;
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 6ee771334a3bd..be6a3e0f13209 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -281,9 +281,20 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
 		 !hugetlb_cgroup_is_root(hugetlb));
 }
 
+static struct hugetlb_cgroup *hugetlb_cgroup_from_mm(struct mm_struct *mm)
+{
+	struct task_struct *task = current;
+
+#ifdef CONFIG_MEMCG
+	/* Like memcg, charge the owner of the mm we allocate for. */
+	if (mm)
+		task = rcu_dereference(mm->owner);
+#endif
+	return task ? hugetlb_cgroup_from_task(task) : NULL;
+}
+
 static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					  struct hugetlb_cgroup **ptr,
-					  bool rsvd)
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr, bool rsvd)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -293,7 +304,12 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 		goto done;
 again:
 	rcu_read_lock();
-	h_cg = hugetlb_cgroup_from_task(current);
+	h_cg = hugetlb_cgroup_from_mm(mm);
+	if (!h_cg) {
+		rcu_read_unlock();
+		ret = -ENOMEM;
+		goto done;
+	}
 	if (!css_tryget(&h_cg->css)) {
 		rcu_read_unlock();
 		goto again;
@@ -318,15 +334,15 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 }
 
 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr)
 {
-	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, ptr, false);
+	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, mm, ptr, false);
 }
 
 int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
-				      struct hugetlb_cgroup **ptr)
+		struct mm_struct *mm, struct hugetlb_cgroup **ptr)
 {
-	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, ptr, true);
+	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, mm, ptr, true);
 }
 
 /* Should be called with hugetlb_lock held */

-- 
2.56.1

