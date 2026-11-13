Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605199;
	b=ckwUmUze1Q/mQw6Pexa8x2MnU1SGWAOsVM9yY0o/dRI1V0lJprEKjgo14mJJ+qF29oh7
	 nNR7tLIShu/+NH18PNPESnwFrba+3jXwdigBrID7/tZkclvh58s2ajzNg9l/UKNRoIhP2
	 bd5JjZFNKXhENva1mt9P1ihYKoJ+VS62duj52hTRBSQqSnr0ApQQdum8qCDocui7+1/3I
	 aZi3s2ZcyYRgFG5enHefORqLS3kEYCOOqLK3guA6KcBBF6sSLrAGV0qtzry08JDjcbQQm
	 I+qHRsgjbpgyzW0qN1ef7otXDd0zbRvg0nrfDwC9dUYZy3OjKt43zk+ucZSaj/yUBRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605199;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7SXTfTYuGz/k0372PRCBUnT3oCcPkvMRjviGYp1DMZE=;
	b=tSa1w0dR7NwwwsQ0HbK52niPSRUadv6/qJf9b7z3AgEawcCzkiSqs5sr122R9LpmMSPn
	 wYsWhUYaxSgeHvIRUDUzjC+9BbdkMa02yMNhnIzVt/6TY+PmaDvWTBT1THg7CD91d0L02
	 HNwpAW2nzCC6aqxVZNM+KnxhvcOMqcoG9SN1Oqc2oW8siyLcxmKdtPwGze3EeruZX75K/
	 eyyKeiRGb72hKCSo/TL7aHQhG5RYK9T3srA5ZGSm1zflsJ8PSRiydgIAHaz9r12xLSnYz
	 iv36+/3QZNPc5m0HB1N7tfNmVgo4W1agZtunMpKFd+Ilkc4irLDTMCWfaZrcu5U8MfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdHX5lHv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC650606A8A1;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdHX5lHv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605198;
	b=N6UpFfDmghc7dxkZAWR9umdFWCWbhlgYF0HP0XCiRJ/ugGp5RpKuFIyMt7Ehpwug1fPD
	 tHkPo1rfEP7DXjkIRAwiEOlOu2OLgoo//bSa9NY9lUeZBQwh9qGpLaztvWyO808b3b8eC
	 XwlLEJgMmArpWJqCAfqwJxs9ydXJqdPREhbOLaWyPj2Xt5sNOnwqEiYVE2OhHRJLTW9dr
	 Gy4uxyOCXPQONGNNH07Gowh5VhfDMMb3IwfS1j0GmjgwW/vPg30DCo5a3ozQfJyvesKxx
	 u8O1NU1ZtFMscWuDfU561oJYpcwsofZWa6gCPKM1Zpu3OJE6JK4WgU7P3NIA6zH8VTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605198;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7SXTfTYuGz/k0372PRCBUnT3oCcPkvMRjviGYp1DMZE=;
	b=FrDjOBjpQTPMnHm7YTgqUQ+/DFx+UaCJFyhtODekjvha7HlcisdI5Inv+m8/pHfsQRyP
	 CVJrW+1iyd9E3zAE+MEw5nIE3r5OgQNwU4O9NhEYSK3HpMOsnQzuu0y/VOuhhq3wYbP5o
	 6QWI1snt2Qj0/8LjByedKqdmN2nTnSCSgUM3eFyYYkLhgKvcjvjYaphUfp2g2CuWisjNv
	 wJ70Uv6EyRzUbvujunOFXR3IbKSaFWa5K7Fmyyqn/MsP92N2RDfqofDSVXiEN3nEZyw4Q
	 noseg2Hc7ZXS2qFP1yKSrnJQqPRidveGbGs9+2Czjz5zFn+zyZ7jRVE8w1TzdU/jCNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 083061F00925;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605198;
	bh=7SXTfTYuGz/k0372PRCBUnT3oCcPkvMRjviGYp1DMZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JdHX5lHvhJPflC8T6XnF9LEc4FniRm8lc7T44e/uUkmcFXxaC9+Bz4+Hb4OLzhPiL
	 aCK+gr0hoz1IqdYAsioG2a0g0oY04scqTP8Nkrbo5gLdzhNSyxG8/1JcvcE9WWGJgR
	 BoVE5a78WQb4U+L6xToFsjsdX6uQM/IriPB3zLgJ9HkeF4ss45RQi0DBJAEH+/KL57
	 BJiuTKhmF7hkvnGInhBk0JHVhBH9Ob1h7Gf+A/Tjc73u02uug1YbqvlI7qnJ1+8D8h
	 U8Ot9e2lmQYnFg4mcAqFsmaiRTRAWgQRvt/yCfKomHI7KSt7wybx96CtaxlWhplDqX
	 6LwAJofIIGs9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7794D49B2A;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:23 +0800
Subject: [PATCH RFC 7/8] mm/huge_memory: walk the after-split anon folios
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
Message-Id: <20261114-swap-thp-split-v1-7-dfa8d4fa448d@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=2204;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=b73U95HEn/sFMHZHf5dLhjLZSLi/GMxez+2xE4t43Nc=;
 b=70EsV5Uha41PjuPYxhWxWFvxuyMQ0o4A1mtGI917jUBg/etMrn8S6YMm7q+tJXy9XsBoKFNy5
 KgC9YTrm+YIDDLdn2hg/4O0StaQTY/e7i5dpk8foYPEWf6bNteg3Zi7
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

Just like the file folio, walk the after-split range with folio_prev()
so the pieces are queued in ascending reclaim order where the forward
walk left them descending, and the cached "next" goes away. All of its
users either expects an ascending or do not care.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e16b93318613..2ff201a5e5f3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4076,7 +4076,7 @@ static int __folio_freeze_split_anon(struct folio *folio,
 	struct folio *end_folio = folio_next(folio);
 	struct swap_cluster_info *ci = NULL;
 	const int old_order = folio_order(folio);
-	struct folio *new_folio, *next;
+	struct folio *new_folio;
 	struct anon_vma *anon_vma = NULL;
 	enum ttu_flags ttu_flags = 0;
 	struct lruvec *lruvec;
@@ -4137,15 +4137,15 @@ static int __folio_freeze_split_anon(struct folio *folio,
 	ret = __split_frozen_folio(folio, new_order, split_at, NULL, split_type);
 
 	/*
-	 * Unfreeze the after-split folios and put them back to the right
-	 * place. Keep the head @folio frozen until the end: sub entries
-	 * in swap cache must be updated first, so a concurrent
-	 * swap_cache_get_folio() cannot return the head folio for a sub
-	 * entry (folio_try_get() will fail on the head @folio until unfreeze).
+	 * Unfreeze the after-split folios and put them back, keeping @folio
+	 * frozen until every sub entry in the swap cache is repointed, so
+	 * that a racing swap_cache_get_folio() cannot folio_try_get() the
+	 * head.  Backward is also the reclaim order: the pieces queue just
+	 * before @folio on the LRU, or at the tail of @list, both drained
+	 * from the tail.
 	 */
-	for (new_folio = folio_next(folio); new_folio != end_folio;
-	     new_folio = next) {
-		next = folio_next(new_folio);
+	for (new_folio = folio_prev(end_folio); new_folio != folio;
+	     new_folio = folio_prev(new_folio)) {
 		zone_device_private_split_cb(folio, new_folio);
 		folio_ref_unfreeze(new_folio,
 				   folio_swapcache_ref_count(new_folio) + 1);

-- 
2.56.1


