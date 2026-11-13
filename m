Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605198;
	b=2ZgHI/REc6n9aAL8o+haV6IYXRFqry4+PLD9MJSXbaKL1ASS4kfWxNb7kJlcsJDpI3Dw
	 VCO3fNKVkKuYE8abVipd8asSITGZfkH19Mo90RocExh8nsA+eJ7DqQoO/vDKOp/VkTaH0
	 qDRVXgkTnWzULOfuBXdL2qbHmJXIt9YS/I5khHKqFPqq3mrf8NFh1aa4BB4xvD1ccQGzR
	 SeHis3UIPxOQzcBqfDIa4XcJw4btrWc73n5jazxawLOq3F6xvRgGuEbSZjU9v7yABVwAq
	 6g725MvGTCtJOsqemM3B6oDvGJNoci5RuV6WshUOuLC6Blf8Y7K3d0G+vNJxzYnSCwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605198;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9DiCXAhwU5zMrLZsoH9A3i98+K1TnqCojamIQPcq9Kg=;
	b=ML3ycl8CbqUctj9ibbmj0rKVGe8bBEKypSqk8quczPTncLRMQqjWxITy3i1lvQ6jS0s6
	 J0JCKjfDf7bAFH7aVuIFGnVA3KpnROQotEX9F1EKQjnPrOSUxYib+97wnZnd9kR9KxnJ4
	 cGxgRCHSmP279wGuAyyhiLYsQma75aTIpME2RPTj0KstwLclOA40OUIKqmSWQHA9mAVev
	 WsAv5T5T9xfSG5hHhhl5UEMUHAt25BWyhXBYLg5+08epTPM/b3kJgcEhYCGRAuyBcD1Bf
	 g9xnjcwry3JPruQ8x0uiJr6i4LVQWpEg6YIV4ljGOmcRYsvhnEXTQT/2PabqZg6x/oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO2diBwj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A84606A895;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO2diBwj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605198;
	b=JHRAqnajon92xEtJlNkhs1K/+f8vO4BGd7tJ9bS+OY/4fD1VeuOfy963xgDSWtK0Uvss
	 y7lHplSpDdYZVAf6wFMLjnKSAnxVIErTd2J32XgRnLS6rojSGavmAZiE5WOP4KBFrSAEg
	 XBIg5rB6yXm863Naab3TIe+3O7f5TkX/PfXYqVjUwtMM3ltCFfYeM8qA40B6Ys920WwCu
	 ceMHmRj6GurH0UnpwCjRbSpp+FCrw2GQz+ZQsgdeVRUZG25OpD2f6mYnJEzSYJR77PaKP
	 0DhCz8TFqcL80He5OsQ2wmL+yI8tmdzdEsYOuM2FBq/VuOv7MtkmgcZCQXPSTt518rQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605198;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9DiCXAhwU5zMrLZsoH9A3i98+K1TnqCojamIQPcq9Kg=;
	b=Cb78srZ0QcKtL3+c0+/CxkKnIs57tZNnbEZuGMPRioI2njfo+Hf5cLyR6BpWksftTLnw
	 m/MewjzONKy2pclLTEccMWPjMOI1coEXTGnJljvLIL9cc+BnsBkpYZ9+mwp5mM1SBppFt
	 RVtmkDrR0tPm8063lqc+kg8HIKwXHptE6dNQBhUYB3sBgetdrOT9NCoZnkEypcnYQ6BOi
	 t5X98dZsgl2hKUYgptRgzTyFkXEsbVjOd278C2tUrNiLr9V5XDLy6Rlu0kqLjg2pjP/e+
	 jV02IEMdkh4DLg/To/QyPx4gQzruiWQWJgg5kzlybTPMWlv2ItURi6CxuI9CJJNQnRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0A7F61F00926;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605198;
	bh=9DiCXAhwU5zMrLZsoH9A3i98+K1TnqCojamIQPcq9Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FO2diBwjSFziwF7xHlpHVCMOhf0t1B9cbBpp8kQAtNnxCC86/ZDOczGhbWdnuOTHl
	 lW52jsVBcWDs+bIJ1WOZZfeyNuIuLBqbpa+taPyNQvPzU6rTmTlksxA6puoaAabTFl
	 J+fqXECyBom+Gcpei9i1wZQ4x/K1gzCbWld7Y7L1I+7le4Edyp8ZuCz8vKgIHM8hpN
	 4n77GtE6UpSulY8viPMrPv5SyFdRUzFO5hpXMD9CadhsbThg9c63fMKy9mpjGYmoO8
	 ZMHrNsNjdS3WncAN1oXe7++kGXEYh9eLm6/Ef4M9l7ozZ8IU0Xh0yWwYN15ltDeOM6
	 TMT5WpvRhxurA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8D42B49B2E;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:24 +0800
Subject: [PATCH RFC 8/8] mm/huge_memory: walk the folios reversely for the
 release loop
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
Message-Id: <20261114-swap-thp-split-v1-8-dfa8d4fa448d@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=1841;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=dZXSI3LM1sOQiwV6KeB6SU17Z87R/eSYehou1jdR5o4=;
 b=IzWZ890bKlfCzLTPrilcnJxROgDWfSBsVhqWNDPvxfGm52kTpVgfbT0g1oAWYBw9TmLkGlYET
 sEISPvezQAnDtnWjHKzRTfNJFLFL1pk8WFV+NU3RVhV8SiCnyBW6syP
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

The release loop unlocks and puts every after-split folio except the one
holding @lock_at.  Walk it backwards with folio_prev() instead of
forwards with folio_next().

This also helps avoid a for loop pitfall mentioned by Zi Yan [1]:
folio_next() needs the folio it is given to stay alive until the
increment, folio_prev() does not.  So the cached next pointer can go, and
the folio that was just put is never read again.

Same folios visited, same work on each, only the direction changes.

Link: https://lore.kernel.org/r/DKJSFCLP967N.YBR4DNK1NM2N@nvidia.com [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ff201a5e5f3..bb09465a3948 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4366,7 +4366,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	const bool is_anon = folio_test_anon(folio);
 	const bool is_swapcache = folio_test_swapcache(folio);
 	int old_order = folio_order(folio);
-	struct folio *new_folio, *next;
+	struct folio *new_folio, *lock_folio;
 	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
@@ -4399,9 +4399,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	 * Unlock all after-split folios except the one containing
 	 * @lock_at page. If @folio is not split, it will be kept locked.
 	 */
-	for (new_folio = folio; new_folio != end_folio; new_folio = next) {
-		next = folio_next(new_folio);
-		if (new_folio == page_folio(lock_at))
+	lock_folio = page_folio(lock_at);
+	for (new_folio = folio_prev(end_folio); new_folio != folio;
+	     new_folio = folio_prev(new_folio)) {
+		if (new_folio == lock_folio)
 			continue;
 
 		/*

-- 
2.56.1


