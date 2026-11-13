Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605198;
	b=e2XRb6G1hCtXrbgHVmo+o0viMCRCmbDtnUgGHN9SnRem0AWXQ9LCPKXmd/eaXBAN1s4U
	 UufWOl3ylctRyu4RqxqL8PHNWOhXOuaSOB//7BqDE0GJzyXm+VaAyWOqbhdA8HgDPo3L3
	 J2fY3eL2AdYKV84svZay23PQWG03CS8kLCSvG1Sl/X5eXmBPAyYOj+HzySpGh2D3XYr80
	 eqkVSd553J5/DtEuEkNy91L89FfxPLMge2KuGAzpYHmQfCDBOIGYCGHg3eYt16MyO9kTx
	 Yv7C1vjJbBW7C/EKIXDaFYjgxTVpT9lXLaJ67bmwXwqT4QMl1fCMdx8fiVliZ6BMYlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605198;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kokV8MS4AjrbJUsUnghTwivEJWo8w3o73pC0J7zlkMY=;
	b=fMQofl7Y79EPsSAZpt7VprlZlFFj1UK5DFuRsjTG9merJMWyED4wy0Z+LiBC3tMgD6FP
	 NMddM3bRlA4ef3QEF42qIJYGaK4+HBZdLGPTzq+5O451InH1gPyvMmNivZCsjRgOJ6MyH
	 HovakgdJn+Cjg1YXkAlEqnEAYN6jVUUQG++5ReXEmmfKjjV0v3GySYhn0g/aPTCoBFII5
	 AwYdFVFHBKKyY0akl54uGaf08ADX1btvGgI+oDtj/+8O2CMJ3Vq90jdXtzebE0OzVKM1k
	 G3rA3kP84RaHuodzlN4AG0eVfOKatkYHEPnDdrDPDdeeUmc+n7Jn3RlWpP72xe9JI4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E415J04L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AB606A33F;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E415J04L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605197;
	b=ZL2sVI7by+7MVTCzsdERDO2ZKkHOv1V2PTur+m0VUIqr05JwdiWkNe8NRXvyayIKt3JH
	 cOA8e9JhDKRkS0TPgPoNy0pN8yQ1IuP4MW8TVZ/qaOK+d5jI6/9KW55KaQUgMvMvC5yYZ
	 Eh8hV9NcRp4nQu0jfKQF1OM9qbVrtUbKqzdpi2aIRt5cFqxVeYcLgsfIRDUcxOLCB+ORp
	 epJwU9iAPEgAt0W1FO9SvsaPWcn7qmG3qtMSettBxsFrMkdbgZpdMJCvqcM74BxmyiRLD
	 LBHac+UfqT3rMeYxMtSXkzLVOtUc7iMvvaPZquiJ1HpihrgcsF0YSs5mTOqFQpeOD/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605197;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kokV8MS4AjrbJUsUnghTwivEJWo8w3o73pC0J7zlkMY=;
	b=mTr7IqNlewzAcfEzuuxxBukH5NoSkw7Y7qaGCt9bIBIYG81RWzmt4XrUtjI9j3GkbFmF
	 BhuxERdIdkRsgtN0ToH2I9EkSFiMzhk/zPp1yMzTjyqwErLonS1FU7OgVjcDx40sfOWjp
	 R6EnGqepqS5xlwF0tDr1x/9kN+NCcagKOiK5tpD2ema7Jx8Oqig0wuYs/70Lrs1wjCerY
	 /4ttaYthdOCVruDRhyxLy3xBHB9TQXXbF+GaG91KXaRyOe0lo7CwgA5vrASAfL0H4tNXV
	 H+qzE6d7BmHfuRZZZdYAeFXGIANC6F3v9MDQHnVYbkrDk3Su9ZDi/MABWr5x4cTiX5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A65C81F000C8;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605197;
	bh=kokV8MS4AjrbJUsUnghTwivEJWo8w3o73pC0J7zlkMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E415J04LlZDvoI6xl5huyQggf0Rv1QEvHLMMszaW6J59t4x67esJQDaqiEP58YQ/x
	 sgYMlz/rVjYdWK3rrphtVcqP4V4I/g5EORG4SEI8YTq0Vm/y5VczUFr5OGHGBBOa50
	 OypNkqhMJMFm9m3zv9csiAlJD+16Wv2y8k2T6hA2YXpiKtimpQsAMu2bgLZoaxtB5F
	 /l1rbP5TRpwK0LdprAGshhscYwC9WbmZVTFTYwwPjAu0Fun71f5heccJ8+Z5wY3UAR
	 LpEKVRMdqbHOIiBWBwHIzCJeA9hvcTzLkvabhdQpTtHPTiu/XIqpuFpWI5rd5X/rh1
	 yiI11LGBh09fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3181449B1E;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:20 +0800
Subject: [PATCH RFC 4/8] mm/huge_memory: walk the after-split file folios
 in reverse order
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
Message-Id: <20261114-swap-thp-split-v1-4-dfa8d4fa448d@tencent.com>
References: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
In-Reply-To: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=4209;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=5RcEb+SDUe2Odh3xMkEh76RLv2cvnpFfdB3Sf/OMRkM=;
 b=SpVjGzS1NGVb8J1ELrgC77295ZiYjOgl2efqf5zi8EtFc672KCE7Kk65kpazdOgAQfDUTkuo+
 P6SDBWUz2HcBQrZZvr6HWVIPvnE27x83Wsb5L3gxtYagCMSe9e5cFsA
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

Use the new folio_prev() to walk the after-split range backwards. The
@folio is still unfrozen after the loop, so it remains the last folio to
be unfrozen and stays frozen until every page cache entry that used
to point at it has been repointed to an after-split folio.

This improves the code in two ways: A local variable is saved, and this
is also the order the LRU wants.  lru_add_split_folio() inserts each
sub-folio with list_add_tail(), just before @folio on the LRU, or at
the tail of @list. The LRU is drained from the tail, so with the
reverse walk, @folio goes first, then next to it is the
first sub folio, and the pieces are reclaimed in ascending order, where
the forward walk left them descending which is not the correct order.

And even if the folio is isolated, almost all split callers drain the
list from the tail (lru_to_folio() is head->prev). With s1
.. s4 the four sub-folios in ascending address order and @folio
holding the first pages of the range, we have:

  For a folio on the LRU (list == NULL), reading head to tail:

  Before (forward): [ .. s1 s2 s3 s4 folio ]  reclaimed: folio s4 s3 s2 s1
  After  (reverse): [ .. s4 s3 s2 s1 folio ]  reclaimed: folio s1 s2 s3 s4

  For a folio the caller isolated off the LRU, reading head to tail:

  Before (forward): [ .. s1 s2 s3 s4 ]        consumed: s4 s3 s2 s1
  After  (reverse): [ .. s4 s3 s2 s1 ]        consumed: s1 s2 s3 s4

Migration is the one @list user that walks its list from the head; that
list is only a work queue and the order carries no meaning there. We may
unify that part too if needed.

The effect is not very measurable in real workloads but we can get it
right while reducing stack usage, so let's do that.

This also helps avoid a for loop pitfall mentioned by Zi Yan [1]:
folio_next() needs the folio it is given to stay alive until the
increment, folio_prev() does not.  So the cached next pointer and its
comment can go.

The anon helper still walks forward, and will be converted separately.

Link: https://lore.kernel.org/r/DKJSFCLP967N.YBR4DNK1NM2N@nvidia.com [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b60fd73fe35c..3d3a82a03149 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4187,7 +4187,7 @@ static int __folio_freeze_split_file(struct folio *folio,
 	XA_STATE(xas, &mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	struct mem_cgroup *memcg, *old_memcg;
-	struct folio *new_folio, *next;
+	struct folio *new_folio;
 	int nr_shmem_dropped = 0;
 	unsigned int min_order;
 	struct lruvec *lruvec;
@@ -4273,20 +4273,19 @@ static int __folio_freeze_split_file(struct folio *folio,
 	ret = __split_frozen_folio(folio, new_order, split_at, &xas, split_type);
 
 	/*
-	 * Unfreeze after-split folios and put them back to the right
-	 * list. @folio should be kept frozen until page cache
-	 * entries are updated with all the other after-split folios
-	 * to prevent others seeing stale page cache entries.
-	 * As a result, new_folio starts from the next folio of
-	 * @folio.
+	 * Unfreeze the after-split folios and put them back on the right
+	 * list, walking the range in reverse so @folio is unfrozen last.
+	 * It stays frozen until then, so a parallel lookup cannot
+	 * folio_try_get() @folio and see a stale page cache entry.
+	 *
+	 * Reverse is also the reclaim order: sub-folios are inserted right
+	 * before @folio, or at the end of @list, and the LRU is drained
+	 * from the tail, so the last one added goes first.
 	 */
-	for (new_folio = folio_next(folio); new_folio != end_folio;
-	     new_folio = next) {
+	for (new_folio = folio_prev(end_folio); new_folio != folio;
+	     new_folio = folio_prev(new_folio)) {
 		unsigned long nr_pages = folio_nr_pages(new_folio);
 
-		/* compute next before the folio can be freed below */
-		next = folio_next(new_folio);
-
 		folio_ref_unfreeze(new_folio, nr_pages + 1);
 		lru_add_split_folio(folio, new_folio, lruvec, list);
 

-- 
2.56.1


