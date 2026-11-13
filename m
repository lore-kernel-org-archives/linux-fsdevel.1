Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579487;
	b=q0ibGHw+QIJusG+uSjEG4BxDSzs1sIweDF5pkfKujwhBvuW6FJRZsZ9XvpoSjDSFyV2p
	 mDzgwpdXFYAuGcV+puUJv4dtDcF97b2tGe+AwEmIUpEEBPJYJ3g4ni2wWXYVE8Rk5MeVD
	 O40foT28DqK2E+90hOGvu/zBy68LaLsBoKec3D6MH/cgYHeVI6Dap4Ml3dwAmn7EyGCXR
	 uugd9Cv8oetUt2FbqCC9arasZCEy9czn6Bew9d24D5QzWLSR1nyt+iVZ11L1dszDjo1rL
	 13L2YmwajLxeUkzS8dk42lxy7k3x37IW+zFoahXgMh4AmoDKaTHYCTejPFYjkEf3fAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579487;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wmO8NUyn+tw3LA8pc83LOjgpNgEXt2U57dJm4LDr0Qs=;
	b=H58pgcREM5JcEWSyLmrnN4BtxW5B+YZ8jmUV9TwuKNjcXvqWPX4OojRP1HpwPdvv15sr
	 +Qc45s8Fo0SwKCUKqDiyyyuQg2x+KsGPhFvTAlgENQDlDi3PS5tfk/jeoazgF+OXogYcU
	 bOx4BLd1rnH+Ps/zvdifstRfdv+RLTc4v57ETySTnOYfbFDYkxdEdQ7FfXNMGmzHsI6IP
	 DnOO7KmrsH2KNtkUDoexPRPSpR/FlN4GqqsxwuJh3T+F7dwloR8qLgPrJnvLaAD9lJslB
	 3TFdJ0imarvnv+vaMb/xE1zS1TkDya/tbboRzGRuXvpel+X/3jFyU+Eq26jdKmToI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrHQhmW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D75606A323;
	Fri, 13 Nov 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrHQhmW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8681F000C6;
	Fri, 13 Nov 2026 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579487;
	bh=wmO8NUyn+tw3LA8pc83LOjgpNgEXt2U57dJm4LDr0Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MrHQhmW7U2SnQytTeVlfWTXL7eoOSrWfP/jCI0ZiyNbFz9MgIAixP6Pe0IeVXevsT
	 Y/PL/TuRcTHl+fOcTAbu2e0tSAW91omjNPHoxBgaeC7tYrvKgLZrRO9kOL/bYFBVO4
	 uiTm5+uIiyPDru56CyIzess2z6EF/3waaHdzlcH2xusiKAknjCnRPqIbrtlvQwQyJ+
	 tZVueGVfhg8uQtVOVuYbev10oSp/5FZx54f0s2Uj5wmsZixO39M+6WZZMj65EGE/I/
	 2BIY+VQznro93FQX4S2Dc9GC90x/XzFnrL0YLuQiygpNUqna1ss/3NR2P4qmP8040J
	 438IoA+T2qWhg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 23A75198003A;
	Fri, 13 Nov 2026 09:17:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 09:18:02 -0500
X-ME-Sender: <xms:Ehz3ak4aLUgJsblyMmkl8jL1KA_eXJ79yd_-l3z01R2dm_MVMyOqhg>
    <xme:Ehz3avtnK5kQmOn1gm0OocAPY0V157PKv_yjm5OhTDoLc-rX3aiwKV6GjJYDcdauL
    xvWyB781GIDN33g8z_mlsWgCt5g9FiExp3ZlEu_k-Yq-_guSocQP4wb>
X-ME-Received: <xmr:Ehz3anL-BV8TMQQ2Jj8pX6zmttV-3Xr3je6Rm63xmG3uP0bd6oecY5I8dl4>
X-ME-Proxy-Cause: dmFkZTEzMCqVlLYFNyqlxeWBK3QY4hUxX3AkiisQ6Wsz8rpHRtq4ZcMku0cF0La3OlvjnX
    /xfBuVvDa3RHdhPiwhvWLpjLqrjGEGADEqiOHV9/JXSwTz8JdIOh/PEHYmMrRbqOyF2B/s
    5wTS+jpXngPrQ7qt+MCEkT8tOUYG65L/2UMjxT5FV9coWU6S3yGe/kRrXja/Fw4iIzf9HL
    wqHvIk5iIbUxzWZJ1djtF/fN4ey41t+TF9WgvIk/Vj5Lbla0oBToXpnmcTVMy4XJtn3mRc
    8CR2ix91u3bcsoeFp9EhIFd7g7xAw5JjSY1e5qWfOxQybGryE8O5y6QyVEMNM2DqWerEik
    /HYvMVEChadsXI1kuhw+cn+noZvDIArvO8rrybl27CPTT2g/Tp2TxV1iQbVkjEZfztr2gf
    u5PqCUtFGr//dBWYZ5+GwJFSuzuVjNqw1GpGGGwIfQbVnHTEU3e7wOAr4MBMiZPsqsLdhU
    WQTSCyvBE3aUamUav3yX7wDqK32rtzmJOtXH9ci1O91APr1HcwtJTBaQ7wOp/8rl4afBZt
    rjHcExMGuudSGnR3Qflkg2k4sfH/Ici0rFMsifOVe47kiQzvkbIJOc8Ufu5Bndys3rjsB3
    zcij66R3Mj2tZNL+JtX4Pbw64q+UFyW8/eSkIkJINPnxWOc0o+sVZvUCCxjw
X-ME-Proxy: <xmx:Ehz3akHOxfGBIrZOunaR87PIFpLQKJCZAcw2hs1m11noV-eDVPHp6w>
    <xmx:Ehz3akEHe9q8TFlCeUYlVctbdAgYsjvACB7Q71vFSDTazzoUyfH87w>
    <xmx:Ehz3alrWo29Qx76A4G4gj1VMGxUQWDc8AXf63QctGjgB2uO65Dl1Ug>
    <xmx:Ehz3akTEMc0ENh-z2qabklkhHalU22ue1-3bisXZJ3m9O6NaVKa24w>
    <xmx:Ehz3ajPThdxc6lLPh7A7RBToKsfvEBY7-I6iuiWa1pSjlWT1vJLSMIQi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 09:17:53 -0500 (EST)
Date: Fri, 13 Nov 2026 14:17:52 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 01/18] mm: free PG_rcu_free folios only after an
 RCU grace period
Message-ID: <avcbg96XgusgAlfS@thinkstation>
References: <20261104130118.2507513-2-kas@kernel.org>
 <ecad7b3c-7244-425a-9413-04d49f221057@kernel.org>
 <au2lsbDkyWt-To0C@thinkstation>
 <aa2a1e32-9b1d-4545-b2e0-03d213593023@kernel.org>
 <CAHk-=whnH5qLJH3Wd3bOxv--Ei6674Jo4iifGD_MqzyJg2Jm4g@mail.gmail.com>
 <8504e28f-faeb-41e3-842e-0cb74d1a25ad@kernel.org>
 <CAHk-=wihE=ioLKrwzz=WQSJg6HhB-syu4hqZ2QFwgnwYmmLEgg@mail.gmail.com>
 <f39a0ec3-be81-43f0-91e8-145ec139b1bc@kernel.org>
 <avWv-0LafPyo90ln@thinkstation>
 <fa90c536-3b3a-417e-a09f-011a12e73048@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa90c536-3b3a-417e-a09f-011a12e73048@kernel.org>

On Thu, Nov 12, 2026 at 01:32:02PM +0100, David Hildenbrand (Arm) wrote:
> On 11/12/26 13:26, Kiryl Shutsemau wrote:
> > On Wed, Nov 11, 2026 at 11:03:38AM +0100, David Hildenbrand (Arm) wrote:
> >> So I might be completely off, but what I imagine is that the memdescs will get
> >> RCU-freed (these are not pages), and once they are then getting freed, they will
> >> probably take the physical page with them.
> >>
> >> And freeing memdescs through RCU will likely be memdesc specific.
> >>
> >> I really don't know, Willy might know more about these plans.
> > 
> > Right: once the folio is allocated separately, the lockless read
> > dereferences it too, so it has to wait for the grace period along with
> > its pages.  The per-CPU batching and the waits in the allocator later
> > in the series do not depend on where the check sits.
> > 
> > Until then the folio is the struct page, and __free_pages_prepare() is
> > the one place every page cache folio passes, so v3 keeps the check
> > there. 
> 
> If we go that way, don't make it effectively folio-centric in the
> implementation. That's what triggered my response in the first place.

Is something like this what you mean?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3862d68a8d9..5b9ac91d25ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1314,7 +1314,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 /*
  * Each CPU has at most one grace period in flight (@queued), covering
- * @batch.  Folios freed meanwhile wait on @pending for the next one.
+ * @batch.  Pages freed meanwhile wait on @pending for the next one.
  */
 struct rcu_free_pcpu {
 	spinlock_t lock;
@@ -1354,28 +1354,26 @@ static void rcu_free_take(struct rcu_free_pcpu *r, struct list_head *list)
 
 static unsigned long rcu_free_pages(struct list_head *list, bool direct)
 {
-	struct folio_batch fbatch;
-	struct folio *folio, *next;
+	struct page *page, *next;
 	unsigned long nr = 0;
 
-	folio_batch_init(&fbatch);
-	list_for_each_entry_safe(folio, next, list, lru) {
-		nr += folio_nr_pages(folio);
-		mod_zone_page_state(folio_zone(folio), NR_FREE_RCU_PAGES,
-				    -folio_nr_pages(folio));
+	list_for_each_entry_safe(page, next, list, lru) {
+		unsigned int order = page_private(page);
+
+		set_page_private(page, 0);
+		nr += 1 << order;
+		mod_zone_page_state(page_zone(page), NR_FREE_RCU_PAGES,
+				    -(1 << order));
 		/* Atomic: memory_failure() may set PG_hwpoison meanwhile */
-		folio_clear_rcu_free(folio);
+		folio_clear_rcu_free(page_folio(page));
 		if (direct) {
-			__free_pages_ok(&folio->page, folio_order(folio),
-					FPI_NONE);
+			__free_pages_ok(page, order, FPI_NONE);
 			cond_resched();
-		} else if (!folio_batch_add(&fbatch, folio)) {
-			free_unref_folios(&fbatch);
+		} else {
+			free_frozen_pages(page, order);
 			cond_resched_tasks_rcu_qs();
 		}
 	}
-	if (folio_batch_count(&fbatch))
-		free_unref_folios(&fbatch);
 	return nr;
 }
 
@@ -1421,17 +1419,20 @@ static void rcu_free_expedite_workfn(struct work_struct *work)
 		count_vm_event(PGFREE_RCU_EXPEDITE);
 }
 
-static void rcu_free_defer(struct folio *folio)
+static void rcu_free_defer(struct page *page, unsigned int order)
 {
 	struct rcu_free_pcpu *r = raw_cpu_ptr(&rcu_free_pcpu);
-	struct zone *zone = folio_zone(folio);
+	struct zone *zone = page_zone(page);
 	unsigned long free, waiting;
 	unsigned long flags;
 
+	/* For rcu_free_pages(): not every high-order page is compound */
+	set_page_private(page, order);
+
 	spin_lock_irqsave(&r->lock, flags);
-	__mod_zone_page_state(zone, NR_FREE_RCU_PAGES, folio_nr_pages(folio));
-	list_add_tail(&folio->lru, &r->pending);
-	r->nr_pending += folio_nr_pages(folio);
+	__mod_zone_page_state(zone, NR_FREE_RCU_PAGES, 1 << order);
+	list_add_tail(&page->lru, &r->pending);
+	r->nr_pending += 1 << order;
 	rcu_free_start(r);
 	spin_unlock_irqrestore(&r->lock, flags);
 
@@ -1452,7 +1453,7 @@ static void rcu_free_defer(struct folio *folio)
 }
 
 /*
- * Free every waiting folio now, straight to the buddy lists, where the
+ * Free every waiting page now, straight to the buddy lists, where the
  * callers look for the pages next.  A concurrent drain holds the lock
  * until it has freed what it took.
  */
@@ -1528,7 +1529,7 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 	    !(PageHWPoison(page) && !order)) {
 		VM_WARN_ON_ONCE(fpi_flags & FPI_NOLOCK);
 		count_vm_events(PGFREE_RCU, 1 << order);
-		rcu_free_defer(folio);
+		rcu_free_defer(page, order);
 		return false;
 	}
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
