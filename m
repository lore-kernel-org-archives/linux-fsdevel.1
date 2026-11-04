Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797333;
	b=FNyjMP063tG3J7p0aFdLr2k1OyG6EtG4m8tT05vzYiZJZ5vpsGSPWUDRP5KzWrabds0a
	 tF83MsU5zUpv6rldPkbJo6AgM4PbObOyqj7VvGeLMhJ1CHhi0fcqKDhnfP/1HjfjP1Po4
	 UjDDjAz/1d/4+lWRC1/rXvky37Px0XusO7k7BhEJ776FGudgtI7p183LkX+1twpKIw8Pd
	 Utu9VwM1QYkrkVscjKWdKRJvXwaM5MK7UEViHXd8v+7aqwJWYibp4E3i/Jg4xi0mlgPRL
	 5aOt6SVvTNvlLd7q3dJZGuZ1rIvbXZ0jVpqcrPCIH7Zmr7rE7Uf7RCchAX9QLo9MShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797333;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wtaEY9fzrvK18OFaBVNKZjtlPWkQZVD0YtOAcEkaXqU=;
	b=N4KW/cpAfwixZgcRIhLJHzd67oOob0Cv1ZWiO8edmnnOOXhhy1ZwyCkvIBdCf6RQKjyv
	 6j/SKuXoou9V8zNG9vCl7SBQE7EF1mKokyCfM5Gwy+EaREsF10u11RfQgDXliN4Gy5BQ7
	 Ju0PEZM86xHs4Y1Kwb8+VaVff02JQIRTHFn+ga8OqSU/OGUwqg0mFEAqCBslnztAGWOoQ
	 cebLBXH3PWtswyY2R+dT25xvFHymfCP2MsXWJnqv4orwYHpaDO7h3UjrOMkeDMQbIGmdl
	 42Cl86bDolQNANrLYkSQR2fMuegmLLa2pkDF+rB53WJ1Bb6TAB4iKTZR7wxR08qo6sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGAMExKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3C606D802;
	Wed,  4 Nov 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGAMExKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A161F00A1A;
	Wed,  4 Nov 2026 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797332;
	bh=wtaEY9fzrvK18OFaBVNKZjtlPWkQZVD0YtOAcEkaXqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGAMExKPh5YGL/8rlEzXtYdafChNV8WMBpZmCpF8FCTFBB+kI4ylKefnpXmJPjAAK
	 Y0fC2gV0fQxEhxArgnLGPJJIcKp9YaQqpc9cnpJ+J86zCPDnkgE9nqrdsX1i9WXtf3
	 wBhQ6IAlsF/gHhQx8OKcMkL1He/UEekxgmA2b7e8FOIU+IcQsRumrXjAzV7LC0rxa1
	 T2FuT5jzSiNCj6EiVIUCfB2HUHPNxB++cJsrkCuT358VRMvw8FFUEntyt5Fw7Or62Z
	 i0C0sGjscvgRVvr2DG/TKBLMGQDuejj4Ic2kzMPiUWLOJgBeszcrvvIj1NIlzlX9Va
	 N2RpPpeTg/T6g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 223F91980054;
	Wed,  4 Nov 2026 08:02:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 08:02:08 -0500
X-ME-Sender: <xms:zCzraoUzuUuUvLSrLoLQGjthj3YhcIDRLIsJ6a-8TW8Xj0kgpSiLdA>
    <xme:zCzrah2BnS0w3ZwXk2G3H2Oqrn1XSrsp3xvYPdLCcaBVgqfN5ZINgFMEOnDUSohxH
    91vZFj7nrSkI29PWXSkrGVfogy3dvAYm1K-rYVsP-ZueuAa60sDIA>
X-ME-Received: <xmr:zCzravBWGD-LvUCp8Ls_bpS2FprfcTAnVaJblNXsvZFzI8VormaGwKnalS8>
X-ME-Proxy-Cause: dmFkZTGcnWxWNdwzviArTqwO8SleswujEAoF3G5cAnzgWuj9VIXYzVn8L/YtSSoCVpDQCx
    AFAjkaMBKJDECegKseyQPi3BoJ2ULdzgEWHQh0kOOdV3qcZ96T5qYw8zvnYBduU6y+7gOl
    ju1hRqdfaUd029Zpq0M1QKVfvNYpVJXA03mIXM/FVYF2n1TVZdGxcwDBil6kVRafbiJtv0
    QuPNDwYksKVrYzT4QGS7HIxmz8ayVgiPQk5G9zoQji1nSBMTr/zV+0QH6w0a9BT4L54N+d
    cRhB7KhKgiZgmWNJc1G8l9d+gvjQ75B75nEIsy2loqzEXGvtqjUcmfJ5UhZu2fDzNX4RUy
    yqjtDl07aOkno7b+BsV25YMs8FGfUFhvSdF5CmrEF+BRAEDNYtPtZEBdr9GzYYz5Ir4xet
    VPeV7zR4ju5b/gbBIrfTW7xlWNbV3ueMqogm/EC+7NxKoY7/sFULyIgJg3hyPDqDWChsuS
    q+CBo44bPpiYd7kiotB279FFCnODiwC/N6vBH59I2o1Kz7jpjpFhNxyQqNyO45Cso9f1hC
    yKmqmPr3GJGD3iUbhSJZeXvBgzfElr2HPXLruTw07ZlkIKHpBQg0gx//7jenADPMGHPZS6
    HsT39bw2z0v2GjfOZgdRWiyEjGKJzyZbL0FFAyn46xMPSueILkJ0xJ07WOGA
X-ME-Proxy: <xmx:zCzranDAf8JKcZdHGDXZaSKMq27-My5VExBF_835DWWDKBDUhzQ5tw>
    <xmx:zCzrajMeotNceECQJ708Qj-5xU_U681zY7khqT0Ka9PNTZx20t64zg>
    <xmx:zCzrajzAhRmTgneRpMBdbLtX_UKFAcz7ad0K4O9-UmbSz11o38OWAA>
    <xmx:zCzrann7eI_g9sy_CgHj7HLy8kB1eTh6BEGSmC_PNCHYOinq22_nSg>
    <xmx:zCzraiAO2UyLzrsnocZPShhVaIhKZsLXM57tzqQC-MOeFhbhjfnyOUul>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:03 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH v2 07/18] mm: free the pages waiting for a grace period before isolation fails
Date: Wed,  4 Nov 2026 13:01:03 +0000
Message-ID: <20261104130118.2507513-8-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_contig_range() and offline_pages() migrate the folios out of a
range and then check with test_pages_isolated() that every page is free.
A migrated folio that had PG_rcu_free waits for a grace period after its
free, so the check fails.  alloc_contig_range() returns -EBUSY, and a
CMA or gigantic page allocation can fail; offline_pages() retries until
the grace period ends.

When the check fails and the zone has pages waiting, free them first.
alloc_contig_range() then finds the start of the free range again, as
the freed folio can merge with a free buddy below it.
offline_pages() does so only after a pass that migrated folios: an
offline stuck on a busy page would otherwise start an expedited grace
period on every retry.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory_hotplug.c |  6 ++++++
 mm/page_alloc.c     | 24 +++++++++++++++++++++++-
 mm/page_alloc.h     |  8 ++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 226ab9cb078a..c23fab652957 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1967,6 +1967,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		.nid = NUMA_NO_NODE,
 	};
 	unsigned long flags;
+	bool migrated;
 	char *reason;
 	int ret;
 	unsigned long normal_pages = 0;
@@ -2050,6 +2051,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	do {
 		pfn = start_pfn;
+		migrated = false;
 		do {
 			/*
 			 * Historically we always checked for any signal and
@@ -2071,6 +2073,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 				 * out
 				 */
 				do_migrate_range(pfn, end_pfn);
+				migrated = true;
 			}
 		} while (!ret);
 
@@ -2092,6 +2095,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 		ret = test_pages_isolated(start_pfn, end_pfn,
 					  PB_ISOLATE_MODE_MEM_OFFLINE);
+		/* What this pass migrated can wait for a grace period */
+		if (ret && migrated && zone_rcu_free_waiting(zone))
+			rcu_free_sync();
 
 	} while (ret);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9caaa57bf51d..eea287ab2a01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1479,6 +1479,19 @@ static void rcu_free_drain(void)
 	mutex_unlock(&lock);
 }
 
+/* Free every waiting folio, including those a work took off the lists */
+void rcu_free_sync(void)
+{
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return;
+
+	rcu_free_drain();
+	for_each_possible_cpu(cpu)
+		flush_work(&per_cpu_ptr(&rcu_free_pcpu, cpu)->rwork.work);
+}
+
 static void __init rcu_free_init(void)
 {
 	int cpu;
@@ -7649,7 +7662,16 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	outer_start = find_large_buddy(start);
 
 	/* Make sure the range is really isolated. */
-	if (test_pages_isolated(outer_start, end, mode)) {
+	ret = test_pages_isolated(outer_start, end, mode);
+	if (ret && zone_rcu_free_waiting(cc.zone)) {
+		rcu_free_sync();
+
+		/* A freed folio can merge with a free buddy below start */
+		outer_start = find_large_buddy(start);
+		ret = test_pages_isolated(outer_start, end, mode);
+	}
+
+	if (ret) {
 		ret = -EBUSY;
 		goto done;
 	}
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59..764e3f43b3b9 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -235,6 +235,14 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
+void rcu_free_sync(void);
+
+/* Whether @zone has pages waiting for a grace period */
+static inline bool zone_rcu_free_waiting(struct zone *zone)
+{
+	return IS_ENABLED(CONFIG_PAGE_RCU_FREE) &&
+	       zone_page_state_snapshot(zone, NR_FREE_RCU_PAGES);
+}
 
 #ifdef CONFIG_NUMA
 struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
-- 
2.54.0

