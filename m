Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646262;
	b=UyD5PTmBQvbhCbUPdQufQW+OvV9aEWEZJUv1xxt5XVGKJobzKTCQx2i7tMLFDXCc7xrF
	 7WL9nsCf3QoEwdJIyGkB/Jrvs44baq9Ro56KHAJuno/+h8mBsJkNziLk07+NB/de8mUqj
	 hZTCwH+ocVb8ix+z3727cFI0kV2QyseTZpARbn9ivudfwurNuAwHBEat2DbwF6UMS6PQd
	 /WC2wlBNB2opsmyZfTUNjcCUA5zCcBODyP0SyVy0WwyuFOrnSBXohGb90GcocyuIKA2Gp
	 25sfQeQqzEKfrKpkpEf0AhJhJ2kwo5TossaC3Yg0Fz7TZJkrmSWl2E1aV2omw9LT3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646262;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P+6EYpLgAE/mRgNpOZ7Q+hz1peRJcwyxpJJGTowJORQ=;
	b=2mr38NWl6pHijN8/antxaplb3GBbJt9Zd3+KvJz98wU/Nh6LO78ZUecTauinLsy3rSn/
	 ErsxL2CHr+G1RxhowdKWdqPBSFAUI6p2nr/yGmDxvBXheOFchIuJxXVdadtC4t8siJRrD
	 m2GtG0aeWle2wETm7S3z9VjXBaOURlDztC5QO8iuG40SCv4mhpPK5BZVCBp+lgje/WjzI
	 1YlEGlNP22zppJ36QCKmUnKe289NZuozVCOV1XnTb1NQUPdGS3oKi6gFEFaQ6yVYH2LBi
	 M/91+qzv8Ycdy16hS8X/Hios6bIIRTiBN91J1ny9TGr6TRwtrDk7+whUefFWHIUa6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQvinOFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C07606A31E;
	Wed, 25 Nov 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQvinOFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B91F000F2;
	Wed, 25 Nov 2026 22:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646261;
	bh=P+6EYpLgAE/mRgNpOZ7Q+hz1peRJcwyxpJJGTowJORQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oQvinOFN/+eS1gGNlyA1jrdenJLPZtq89iypBXtBD1BQptJqVTX8+7qZpvlAuw+So
	 mvtePvyGjYUzUSP9Dd9Z6JFJEtsSE47C1cECBg4vBmMC6X/HvWMN+a9DgTKUU4vwT4
	 NbOKg9iC2ODpta1AzEMd74Wf5QHE8zXqS1bMsqKBLH9n1/Gu61xk/52CFGisAS0S+7
	 Y8axHVPNj0oaBbSpQcD2ffZCXyELzvSEyF0DGvOg2dYGIJg3kHOOX84fJQBegxe+pQ
	 ofKaZOBjgb1tNK67YWADuwG5m/rDL6he2H1p9LhgD/eJzMlWDkR/n6C9xhRc1HgT8l
	 +jZA56D1JMxHg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:14 +0100
Subject: [PATCH 16/21] mm/hugetlb_cgroup: track in-use folios per cgroup
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
Message-Id: <20261125-hugetlb_fixes_2-v1-16-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7023; i=david@kernel.org;
 h=from:subject:message-id; bh=Un1Xv2jSf94pjywu3PzLRYXUs4bjXbYIlpqIZ6naE1Y=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1SdXkcXzRcvvv/mxMoDJ4R9jYVdLxw990HLKkZV+
 WFdxu5fHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAFzEj+GfrlOwQu95w3Oly51v
 XQ+zduRnj3/PyVlaIRmjb6awtmkuw/9Ih2jjPuuKRWtFrk7dt+tvq065yqQlngdOdEzsXdxyxJ4
 HAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

When offlining a hugetlb cgroup, hugetlb_cgroup_css_offline() walks the
list of all in-use hugetlb folios of each hstate with hugetlb_lock held
and interrupts disabled, to reparent the folios charged to the dying
cgroup. With many in-use hugetlb folios, that can keep interrupts
disabled for a long time on every hugetlb cgroup removal, even for
cgroups that never charged any hugetlb folios.

Let's fix it by keeping in-use folios that are charged to a hugetlb
cgroup on per-cgroup lists, so offlining only has to walk the folios of
the dying cgroup.

Process in batches to not keep interrupts disabled for too long when a
single cgroup has many folios. Use batches of 32, like reclaim does with
SWAP_CLUSTER_MAX.

This has low urgency, as it only matters with a lot of hugetlb folios;
let's not CC stable.

Fixes: da1def55919f ("hugetlb/cgroup: add support for cgroup removal")
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: add lock checks, add HUGETLB_CGROUP_OFFLINE_BATCH, simplify
  comments and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/hugetlb_cgroup.h | 20 ++++++++++++++++++++
 mm/hugetlb.c                   |  4 ++--
 mm/hugetlb_cgroup.c            | 34 ++++++++++++++++------------------
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index b4e0958eabf3b..1c437eb2e1c30 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -54,6 +54,9 @@ struct hugetlb_cgroup {
 	/* Handle for "hugetlb.events.local" */
 	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
 
+	/* In-use folios whose usage is charged here, under hugetlb_lock. */
+	struct list_head activelist[HUGE_MAX_HSTATE];
+
 	struct hugetlb_cgroup_per_node *nodeinfo[];
 };
 
@@ -100,6 +103,17 @@ static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 	__set_hugetlb_cgroup(folio, h_cg, true);
 }
 
+static inline struct list_head *hugetlb_folio_activelist(struct folio *folio)
+{
+	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_folio(folio);
+	struct hstate *h = folio_hstate(folio);
+
+	lockdep_assert_held(&hugetlb_lock);
+	if (!h_cg)
+		return &h->hugepage_activelist;
+	return &h_cg->activelist[hstate_index(h)];
+}
+
 static inline bool hugetlb_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(hugetlb_cgrp_subsys);
@@ -185,6 +199,12 @@ static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 {
 }
 
+static inline struct list_head *hugetlb_folio_activelist(struct folio *folio)
+{
+	lockdep_assert_held(&hugetlb_lock);
+	return &folio_hstate(folio)->hugepage_activelist;
+}
+
 static inline bool hugetlb_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 796f02a4ded63..5db97f6d15595 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7608,7 +7608,7 @@ void folio_putback_hugetlb(struct folio *folio)
 {
 	spin_lock_irq(&hugetlb_lock);
 	folio_set_hugetlb_migratable(folio);
-	list_move_tail(&folio->lru, &(folio_hstate(folio))->hugepage_activelist);
+	list_move_tail(&folio->lru, hugetlb_folio_activelist(folio));
 	spin_unlock_irq(&hugetlb_lock);
 	folio_put(folio);
 }
@@ -7684,7 +7684,7 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio,
 	 */
 	spin_lock_irq(&hugetlb_lock);
 	folio_set_hugetlb_migratable(new_folio);
-	list_move_tail(&new_folio->lru, &(folio_hstate(new_folio))->hugepage_activelist);
+	list_move_tail(&new_folio->lru, hugetlb_folio_activelist(new_folio));
 	spin_unlock_irq(&hugetlb_lock);
 }
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 6921b18572666..6ee771334a3bd 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -28,6 +28,8 @@
 #define DFL_TMPL_SIZE		ARRAY_SIZE(hugetlb_dfl_tmpl)
 #define LEGACY_TMPL_SIZE	ARRAY_SIZE(hugetlb_legacy_tmpl)
 
+#define HUGETLB_CGROUP_OFFLINE_BATCH	32
+
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
 static struct cftype *dfl_files;
 static struct cftype *legacy_files;
@@ -123,6 +125,8 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 		VM_WARN_ON_ONCE(ret);
 		ret = page_counter_set_max(rsvd, limit);
 		VM_WARN_ON_ONCE(ret);
+
+		INIT_LIST_HEAD(&h_cgroup->activelist[idx]);
 	}
 }
 
@@ -219,18 +223,8 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 {
 	unsigned int nr_pages;
 	struct page_counter *counter;
-	struct hugetlb_cgroup *hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
 
-	hcg = hugetlb_cgroup_from_folio(folio);
-	/*
-	 * We can have pages in active list without any cgroup
-	 * ie, hugepage with less than 3 pages. We can safely
-	 * ignore those pages.
-	 */
-	if (!hcg || hcg != h_cg)
-		goto out;
-
 	nr_pages = folio_nr_pages(folio);
 	if (!parent) {
 		parent = root_h_cgroup;
@@ -244,8 +238,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	hugetlb_cgroup_move_usage(h_cg, parent, folio, folio);
 
 	set_hugetlb_cgroup(folio, parent);
-out:
-	return;
+	list_move(&folio->lru, hugetlb_folio_activelist(folio));
 }
 
 /*
@@ -255,15 +248,20 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
+	struct folio *folio, *next;
 	struct hstate *h;
-	struct folio *folio;
 
 	do {
 		for_each_hstate(h) {
-			spin_lock_irq(&hugetlb_lock);
-			list_for_each_entry(folio, &h->hugepage_activelist, lru)
-				hugetlb_cgroup_move_parent(hstate_index(h), h_cg, folio);
+			int idx = hstate_index(h);
+			unsigned int nr = 0;
 
+			spin_lock_irq(&hugetlb_lock);
+			list_for_each_entry_safe(folio, next, &h_cg->activelist[idx], lru) {
+				hugetlb_cgroup_move_parent(idx, h_cg, folio);
+				if (++nr == HUGETLB_CGROUP_OFFLINE_BATCH)
+					break;
+			}
 			spin_unlock_irq(&hugetlb_lock);
 		}
 		cond_resched();
@@ -367,6 +365,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 		 */
 		WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
 			   usage + nr_pages);
+		list_move(&folio->lru, hugetlb_folio_activelist(folio));
 	}
 out:
 	if (!rsvd && charged_h_cg)
@@ -940,7 +939,6 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 {
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
-	struct hstate *h = folio_hstate(old_folio);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -957,7 +955,7 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 
 	hugetlb_cgroup_move_usage(h_cg, h_cg, old_folio, new_folio);
 
-	list_move(&new_folio->lru, &h->hugepage_activelist);
+	list_move(&new_folio->lru, hugetlb_folio_activelist(new_folio));
 	spin_unlock_irq(&hugetlb_lock);
 }
 

-- 
2.56.1

