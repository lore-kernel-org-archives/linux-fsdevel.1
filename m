Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797351;
	b=jFtgMwVy8fH5tTkpCPqmtW+mXQ30+wKOU2+GyIWfI0PgX9VGUATRBEYtl8s8INhEF7U0
	 beaVfiezUKmaazWuPDoqt4wUbPjYa9TLlixwfqPLbJcgaanFTqmQf1gvTQ1f5lMg6Z+ps
	 tBK5/vx/GGCSUEzGws8pf4b5ThIqJ6/ZmGWJKdeg5foqZWv1i7zivvbeAAOzYHKMESKdp
	 QIydgoWOqbcZ58guzxZV/vJHLiZYv/UdjAqxJl/czMNEcd2dYX/sO8Kzwu0x9RyayUyZO
	 bEw45+GThkvDBa6H8UmYxxgGZEvDlVcZ65NNgYrhdYmFpuVXAsHMpEHmO63hXFrnF/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797351;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZeZeKqOXIg0pdVk38aCcXZjtPawAjmXXTX6c9OEoxb8=;
	b=CW1deRzT/+DpnZArmINPcsn1MG2XnFI3jvIT8ijMOhw+dozuaMH9xblretpcqpmzyCIV
	 3SMbGNiOGO+ICSNFStwP+uZDcfENpfT7nUXB3LEcm+hd8rdWkJPpJZBOPNTuNHeKr48Kb
	 mA2c0wvVlCDwyWxENl5bEVjEDTP3mPOEdDsx165Z6VmYzIHq1327/3VDj22pGYjzv9KzX
	 WhDGK0hu6vUl2SUTY/1k422kkeCokDzoptGOvuW+sYc8fC2M14seSPZBYym75NcgxERB9
	 qXSuaXbU4q3abvhsXk/P1mBaHIWU4hqYAn58Sd8zDiaWdvfNsBZVvoo6gbu9HTn+Npg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihIvKZ+f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198F606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihIvKZ+f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A156A1F00A02;
	Wed,  4 Nov 2026 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797351;
	bh=ZeZeKqOXIg0pdVk38aCcXZjtPawAjmXXTX6c9OEoxb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihIvKZ+faxz+GWcGkPr7VS+TK+j0Q9bv9UwAZ57eXbpmZGfjHyIuqUrcn1bQHz1yP
	 K9DJ4mljISfxegncBinm5OpOR2kFDP1a1HgdJAXaOYzjRamhsCVc9b3pz+Lt4Aejnx
	 pUAZvLVKoQJ85p+9QZNKXjmCmRE8OtgGENQIhUAcW/V+RvHOI1JHFAClOMMpiAe4r1
	 w+69J23em1ovBi11OunrHqLRj5WBkKIDb31Mx72EkeCuVvyikah68DcXt6Ukj6SevZ
	 YKFNVNowntR8cFQEuMY2vV1r7eiKTsz7qwX8NCvp+iLlI9GvKONoRggay1GYRHi5z/
	 e3MElHCM9PxDQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9134B1980052;
	Wed,  4 Nov 2026 08:02:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 08:02:27 -0500
X-ME-Sender: <xms:3yzral760PUag65_UE_5joCN5pnKCtoba4VN2oYma6jiL4zCB6vIjw>
    <xme:3yzrap1d3-Hbj7AzFEvhniiaJBhhyUzyG90C8iEK26hqrofSFUW5EDai0sFVH237U
    1cbnwGp8ceXLqdW-fULz6ZC_UmmU5QfIiz7bzEtKu1avKqMX3lGxvw>
X-ME-Received: <xmr:3yzrahkGuQ5SN0G3yvIPx_DuW7fMInt95XuhJS4COrMdvS-DtxDSoExqm1Q>
X-ME-Proxy-Cause: dmFkZTGhPc1Yg5t9Q8eRQaKCLT0heVoXQqf6h4uqMuRtXQYzheOI1jp47nBw26mcWoxz9A
    DH10HnpPYob7RxaCTf32YkHXSpJmh1hLC1IxxzXB90aJAI2wMnFT+nxhjDMKjWZ9Ablulj
    X6EGhbUdQWvr3vCsmIbyKlTdtYm8QJi2H9b42DzXiIRq27TGzwIAKeq7xgftm17WrW++J+
    RK/ZhBFKi/01LbyIuttpTNhw8T5nzUYT3/gbSIkELTYoQfWYa9TU1xDsUR8Sja7r663Vhq
    dT9Vb6Q8iqTkFCbamg7ObiOCckNJsrzr7UPmHz2jvO2iFJ92ew01ZxP0mcoMzU2JutwOha
    B0jPeJCBnNC4bQZANG5NWvjwjnKyS/uH056P98u4op0L2e4Iord3UfH84RIfYlHaTOGsk7
    srDkEB2m0ia7p890WwKoD1qaoP+JYmRcbTzG/b3f5CggOnhlFwvRLaWQuOvc/eq/J/4EcD
    TIXJwSN0kv4mJ/QTWdHzD5TIm9INfuSWeMq9uVNrdKDjR+ReIFvj6K1gwxJ7CcEzha7YqT
    FdzNyJxYTNQCD2Fz3hszaSWQ6e+HyFZj3b+FE+PZfHXyEgFJJKmAjiLvfj4MpT2MDZzugD
    uWc36bFDX4sCm0d0dGA+kaFWELT0F2X/WBFaC8D82SbM6fvZPJxYAm2qqU9Q
X-ME-Proxy: <xmx:3yzraiidZoKKrBGI6E7L6qynhl0Em-AezKc0MX-Tt33cE9_Iygr1QA>
    <xmx:3yzrao3sG404ab0J5a7u8oEgC95P-wUMiKhkpSJhLmhtxzwlS5r5Rg>
    <xmx:3yzravaf5srwmm0HropDcBxDZj19nUcmU9PIsrtixYFGWbSE3UfF0A>
    <xmx:3yzrallljCUcEVIwimi3JoASouOX7P5PfKKRxE-5uI2nNE_MuQY9vw>
    <xmx:3yzramUTQGT6xyYYlzoDriz2u-q_n1CNobPIdvkYJSPyer84Kxebhs7W>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:22 -0500 (EST)
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
Cc: Miklos Szeredi <miklos@szeredi.hu>,
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
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH v2 10/18] mm: have folio_mark_accessed() return whether the folio is hot
Date: Wed,  4 Nov 2026 13:01:06 +0000
Message-ID: <20261104130118.2507513-11-kas@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Each call of folio_mark_accessed() moves a folio one step up what the
LRU records of its accesses.  Once the folio is at the top, the call
leaves it as it was: the folio is as hot as the LRU can tell.

Return whether the call found the folio there.  On the classic LRU
that is active, referenced and not idle.  On the multi-gen LRU it is
PG_referenced, all the refs bits and PG_workingset, which
lru_gen_inc_refs() now reports.

An unevictable folio counts as hot once it is referenced, and on the
multi-gen LRU from the first call: it stays in memory in any case.  A
dropbehind folio is not hot: it is dropped after the read.

No caller uses the value yet.  Preparation for reading the folios that
it calls hot without a folio reference.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: shorter changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/swap.h |  2 +-
 mm/folio.c           | 46 ++++++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5658a1634b85..67aa5271ae6c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -295,7 +295,7 @@ extern unsigned long totalreserve_pages;
 
 /* linux/mm/folio.c */
 void folio_add_lru(struct folio *folio);
-void folio_mark_accessed(struct folio *folio);
+bool folio_mark_accessed(struct folio *folio);
 void lru_add_drain_all(void);
 
 enum lru_cache_drained {
diff --git a/mm/folio.c b/mm/folio.c
index 50a6dbe55998..6144b9cf301b 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -352,28 +352,34 @@ static void __lru_cache_activate_folio(struct folio *folio)
 
 #ifdef CONFIG_LRU_GEN
 
-static void lru_gen_inc_refs(struct folio *folio)
+/*
+ * Return true if @folio is hot: unevictable, or its flags already held as
+ * many accesses as they can.
+ */
+static bool lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags.f);
 
 	if (folio_test_unevictable(folio))
-		return;
+		return true;
 
 	/* see the comment on LRU_REFS_FLAGS */
 	if (!folio_test_referenced(folio)) {
 		set_mask_bits(&folio->flags.f, LRU_REFS_MASK, BIT(PG_referenced));
-		return;
+		return false;
 	}
 
 	do {
 		if ((old_flags & LRU_REFS_MASK) == LRU_REFS_MASK) {
-			if (!folio_test_workingset(folio))
-				folio_set_workingset(folio);
-			return;
+			if (folio_test_workingset(folio))
+				return true;
+			folio_set_workingset(folio);
+			return false;
 		}
 
 		new_flags = old_flags + BIT(LRU_REFS_PGOFF);
 	} while (!try_cmpxchg(&folio->flags.f, &old_flags, new_flags));
+	return false;
 }
 
 static bool lru_gen_clear_refs(struct folio *folio)
@@ -396,8 +402,9 @@ static bool lru_gen_clear_refs(struct folio *folio)
 
 #else /* !CONFIG_LRU_GEN */
 
-static void lru_gen_inc_refs(struct folio *folio)
+static bool lru_gen_inc_refs(struct folio *folio)
 {
+	return false;
 }
 
 static bool lru_gen_clear_refs(struct folio *folio)
@@ -419,15 +426,20 @@ static bool lru_gen_clear_refs(struct folio *folio)
  *
  * When a newly allocated folio is not yet visible, so safe for non-atomic ops,
  * __folio_set_referenced() may be substituted for folio_mark_accessed().
+ *
+ * Return: true if @folio is hot: it was already as accessed as the LRU
+ * records.  On the classic LRU that is active or unevictable, referenced
+ * and not idle; on the multi-gen LRU, unevictable, or PG_referenced, all
+ * the refs bits and PG_workingset set.  False for a dropbehind folio.
  */
-void folio_mark_accessed(struct folio *folio)
+bool folio_mark_accessed(struct folio *folio)
 {
+	bool hot = false;
+
 	if (folio_test_dropbehind(folio))
-		return;
-	if (lru_gen_enabled()) {
-		lru_gen_inc_refs(folio);
-		return;
-	}
+		return false;
+	if (lru_gen_enabled())
+		return lru_gen_inc_refs(folio);
 
 	if (!folio_test_referenced(folio)) {
 		folio_set_referenced(folio);
@@ -437,6 +449,7 @@ void folio_mark_accessed(struct folio *folio)
 		 * this list is never rotated or maintained, so marking an
 		 * unevictable page accessed has no effect.
 		 */
+		hot = true;
 	} else if (!folio_test_active(folio)) {
 		/*
 		 * If the folio is on the LRU, queue it for activation via
@@ -450,9 +463,14 @@ void folio_mark_accessed(struct folio *folio)
 			__lru_cache_activate_folio(folio);
 		folio_clear_referenced(folio);
 		workingset_activation(folio);
+	} else {
+		hot = true;
 	}
-	if (folio_test_idle(folio))
+	if (folio_test_idle(folio)) {
 		folio_clear_idle(folio);
+		hot = false;
+	}
+	return hot;
 }
 EXPORT_SYMBOL(folio_mark_accessed);
 
-- 
2.54.0

