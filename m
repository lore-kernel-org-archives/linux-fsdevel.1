Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425025;
	b=wfRtYf1y39WiRVuQKvP0GNJiRR9LB6FeRQZqcSeigvkDR146XlIPBCqWUVuJpG/aecyh
	 Q13SxhgMFPZ8F3hCU4hxkW4yV9ladL0AV2Wbf+uFmASrJo7ynIa6EsjBF0DUeaMMQ6Moa
	 CRzBJlmb1dwIv6//SxcE1lMgTr0s6xuy2xG/fztYS5xOjLb/iCwuRtlvpWs/aF22EbMof
	 ppTZKzql2PSlrDTTXmYJH31YONc7l6imJSWJdOVwGa3AoSX+BvN8xowUxn/IIBkED65vN
	 jeOFZZLZWIM9INw+W1qIJfvaCGJk6hGziigUPnFTXv9Dlxv8GJBH2TyioDyf+egx1jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425025;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+5Nfzrde1GD9FfRh74qOmGM0CUmDocdXRs1qdcRag3k=;
	b=BbxBZcMkOgPRx9VHshswaKB6c/GT40ozqsMBah5in74vqGseUQWp7IEUS3COlpAHqi/t
	 Kh6a3iCVdp6CU8OUL/ULG1zp81t5D+RSDXG+kHI4yTRMAAAsMA25ZIKy2edH+QWeZR1hT
	 8v5j+o8nd8diD77Q6+qXFuwYA+imq0w2lasEPGD8aO9A0SsZJiCT+qQ9WhFz1tz0FQhX0
	 my/tInCvbxWyeLhOIEkpPGtnKFwMkSfLJtOZu7s4jqm8BQmm3VU6JorSpj9UjFiG8u5Ov
	 KPhyyAMLJwwikhnhSyLJ3mvaUZFCuE/BiPDG2V7PoK2M/a8zMjN1BxaHi1IDE121izA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljvEE+u3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDF609A551
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljvEE+u3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4721F000C4;
	Mon, 19 Oct 2026 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425025;
	bh=+5Nfzrde1GD9FfRh74qOmGM0CUmDocdXRs1qdcRag3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljvEE+u3oeDjYDCjGhqAkTws6/4QJfEktpl7VIAzkm1wbv/mLvVPT7PJyAWLDq5Gt
	 Dx8v1Zw9QfsqO7syFOlR4E6YWIoNdoSWU0CEKKtHX4PPP55zLI04atrDRCVajHT+CL
	 U0tJRg4MDCiT9DcKIT5hlRuTHsgHPMa0pqQwpU+1ieemLEpvbjGXkbCBJOcquo+RKj
	 M1G4CbV319nSBW1W/1kGoRI19m1eGKJlY09uVX5xEgZejFwiN3BOoyLHr6DfkdGrIn
	 XvWXI1/CNypi4ePfPPquLRjRyIpeqEG4vTh1CMZE0hu6JLrzZL7dJJkvNsKD1AFPgK
	 icz1lv5eA/kIw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2DA0E1980047;
	Mon, 19 Oct 2026 11:50:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 11:50:20 -0400
X-ME-Sender: <xms:ODzWarhAx1EZd734HWV_D-5du2ufehE7IkT2B9kzO2URJOyZU57qcg>
    <xme:ODzWau8t6DMj1RgdVgr3vMJYTlvBG1sSWzg7ZyfT6dzkhmFg8AghocxF8LnDYBkjm
    fDp1EHZgcL3bumC2MfY-LNr8AlXgN4uwf0B9QYpFQkVYepGBznejj4e>
X-ME-Received: <xmr:ODzWagNlOw_d9RBfofrUS6MPeq73ZO0O4YBnNvNOYXe3MZsCQ2f7MB7aQsg>
X-ME-Proxy-Cause: dmFkZTE+kjgISKw/D5xbtovMvE/5+MXw9OAGtDBfqR9Zk5dZNOqhNWGTcEGO5Lmn7qsaMJ
    P+2+K5eT4SfShSSEvxMo9+0NhMtUrbV4W6Uy0A3XpuEB672w8089GbqFaxEF0wWgdpl5Mt
    ZGUplA1E9XDXzNgkO2MrFgMfcNS4u61SieDRP0v46gjH0l2eZ2DL9zme+jYfCIiYlLA1YJ
    nvbn1HssXPAJFHKdL+OCiEp78jaTWZC2fJHjA4vCnfghQrymIXyUGAHupLMJJEm2bjt0nv
    kEsuBoXYnW/I4u0Q3SZjAxl07Y4ERxrcHOAeD/N6wYko4+jO11wXgs98kOmjLgJ2rMOJIZ
    dfeJ0xQ74xoR6DfShFlSEAqdM3aQWhYGU9iaTUYTePGvrkWjscCqx8LuiCBIrLxzWO5esr
    XIWYeR8T4YsFXzTV8r5ByFLLce3aWQVDs/AH8HBc2svQkWdXOwpi0Xzyr1iXxxy3YDQxuu
    d+vqpBfcAJrom7RgY/UM1LcB98A5Ic6xZOKqm1cV0yUmWcjUHVykTDmFvPPPI9Ab4nRoMb
    UX70np05MwHA6FfDOUprjmrpo5WFE5+GZaMR+0EHllstbAYlSw/gD9O0Orj1fDNJWYImOg
    jGxc6OHbvGHcn3reOVmwkwpuisL9nJUWe/8+U8Oz7SBLCzpL0Si1/Pkv3cNQ
X-ME-Proxy: <xmx:ODzWaspC50ZUmwCmz_PMx1tPkl-98bkCPw3DjMiF4XjC74GU9Gj7lA>
    <xmx:ODzWaof-CfprAISdkVF0pO_7PcKRofuyMvTeTz3pqBaqkZn0UzScDA>
    <xmx:ODzWamjj4m5jZjVLqwEb1yllh9cj6pOIGhHgBfjRLaVeJeqN-If0tw>
    <xmx:ODzWauOIpaUAMvtzp8j0uqxHvK_Amg04xLFU5ouA1-rd1tFHwYsAZA>
    <xmx:ODzWaicxGvQaWMLeADH3d6m-A1_QPdb-7VqBnz3Q4woIukWcoLt88aBn>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:15 -0400 (EDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>,
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH 09/18] mm: have folio_mark_accessed() return whether the folio is hot
Date: Mon, 19 Oct 2026 16:49:02 +0100
Message-ID: <20261019154913.1765974-10-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019154913.1765974-1-kas@kernel.org>
References: <20261019154913.1765974-1-kas@kernel.org>
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

Assisted-by: LLM
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

