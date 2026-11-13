Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605199;
	b=biHDazRlWi7otFB/D4Lv+Bpq9u38IzYqe9TFjNO7MZ+g2FSqjIzlMHGlQWN4m5mOEptr
	 1T8qa4IboTzSRK2xzyxKKA1PSaKDQZx8AxOyz0sv2RUcrYXylkZp/3ebmX19lTgdNSX8g
	 ZrPMkEH6ZgDWFVi5d/B7eRfN94nKBORNEHOwf4Bn1A1M8PiFbT6RcND2eEEubMhBtiXK0
	 bi2wh+IR/x8rYNJtbKXF94ZobPjCglRUFsRsk4zvMnjCDEkae6T4AwZwhXz4y31oE4SLO
	 X51q/TNC9NHAn8AAC/mvrmNsovyjUyV67vP73vDuQuCwLqcdYCk4HffR8OUay7IhGLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605199;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j7VnaYDyVyfjUDDKNmBe9NRivr1KPLks80ov+VekDsQ=;
	b=P2ZlPbT5EWvYLUDCrlQOexDRaOjGTt0tqAOiGQOafkFKeJyJrSW2kbl+UXJpgD9HKnoA
	 ieK650vPNQOp7OSkeCqH01zIEkFXRjqA+vVQV0EX99om/lQ5X+ncca2XwWUw52os6C8ar
	 JQLR4oJ4zXT+kHq5xEuZ2JOdKn6jDPmMBAvSJfarKgtiBmFjCIKmAcanARScqQwMsz493
	 xaAxSgBK85xX2RAokTkUYA0FRq+axOXBxOJZsa4M8UIOa0oc6olteA31k9R2DYvUFNK1f
	 gyuvch0D01D9OJbl0JfVsNWHoW8AMj7MQo1M9KFPItkXqpQJO2jaOR88eqGRbkbBj9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NASDWh8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CE606A8AA;
	Fri, 13 Nov 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NASDWh8o
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605199;
	b=FfK4aCJ+cbMlLuORujrqcFGf/oaOCsTCUtXrcdSXzhVRqvLwWW9gwYNkbzGtmEcuF+wa
	 M5w/WWVpVTWswC2pcIGA9AYAzoofFix0ZLLT4qBze0GB3bALK7IBBZadvlslo+Cee38zr
	 St4jaoDd0pJ9Q76K33MYuAXCgfbA39kd35+lMuIMtn/TCvP4Y9SwsstLIiV4AgaTMPsg3
	 WKtOUpSJf5Jxhq9U5HcGSWrIerUVvNc2zUR6V8qWUgoMuWYqReooAQ9j1Ok1mNN9ETaUV
	 ox2mtHI5J5YpOeldPdgbhhybBVoYnlMC6iG/fRVxRMm0CRLyodm2L2ok7KEfgwa0viw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j7VnaYDyVyfjUDDKNmBe9NRivr1KPLks80ov+VekDsQ=;
	b=OTAThzmthUlVzLI/LonMq2CYD1dksZ2N3pA+OjHQNu4/H/zpKBJvZDIC0tT+fkXDBKZ3
	 AFXFQAPoA1x5w6goC49olC1oIMiecn7fjV8MR7og3jgcOVKWi+hQsI6BtJ2ke3YbyHkm/
	 CktDPj9vZJEST0pP/iLnTmJ9iCoyCJ0zznlsOhmHXXVyOcn8g36B2inBnY9CSH1B/gjNw
	 wnpCLCNecwDepBgwWe74ehkBLBObkFxq2btFWicy9nsTrbqAl4tI9uMhD02liFG4HJ53r
	 XB9jpy2T3e/FB3YxapkLVUOsYqj5n86xCABSRWg9PrQrLfJ6Gw4y3HCK4X45KIWV3xA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F9C41F000C4;
	Fri, 13 Nov 2026 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605199;
	bh=j7VnaYDyVyfjUDDKNmBe9NRivr1KPLks80ov+VekDsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NASDWh8oFe9rmvb20HrG7NmOizC8zZNin0xYQOCQDbNhxRM+zOeo/tJku3zh+8LKj
	 XkYQlH/SsGY4U+Y6OlQDnPUW87bVfXY4y3P3G3uAvJQQepQu53ibJuCxjhwya00+gF
	 IqAJVwg1FAap/mD+H4egnzXen81wAggJg/jlVeX+by7nChnyUmUYaVm7weIeU87waC
	 uIwy+x+RJ/UqfjhyZaB6Vmo4YPuJLgXN9wu29po6KWEfa7k1JC/jDhrL45zkOSyoNP
	 QzYZOtG0o3950IvOJpOMsMLODPybO5fk8rnu/GduwoA9/R7/aJRtSNNJWqBIpMbURN
	 GtvQX1zXz9nrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4790949B22;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:21 +0800
Subject: [PATCH RFC 5/8] mm/huge_memory: publish split folios by walking
 backwards
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
Message-Id: <20261114-swap-thp-split-v1-5-dfa8d4fa448d@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=3261;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Sf46vfrRt4G+zN3kqE3m/RvfsaIDpCNGdcr6uA236Go=;
 b=oZpzJU5a8EodGaJbZWszLOQkq/lIyaXCT4mGPjnh7iWciUzCCPnau5+TY4vnCCA3ZEQ7q2saI
 QN63NVcxFDxAQpo/yZQxb1IZv7CrMRCkJKZphU1t2ITr1F+czqKW4HB
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

__xa_store() builds a fresh XA_STATE per after-split folio, so a uniform
order-9 to order-0 split does 511 root walks, which is slow and on the
hot path for file folio splitting.

So instead, just use one XA_STATE iterator, and step back folio by folio
using the new xas_prev_canonical() helper: each iteration is much
cheaper, and publishing costs only one full descent walk.

Also simplify the code by unifying the post-processing of past EOF
folios.  We may store a few more folios than necessary, but the store is
much cheaper now, the truncate path is unlikely, and it makes the folio
removal convention in a mapping more consistent: the folio being removed
always matches the content in the mapping now.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3a82a03149..7270baa20d80 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4187,7 +4187,7 @@ static int __folio_freeze_split_file(struct folio *folio,
 	XA_STATE(xas, &mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	struct mem_cgroup *memcg, *old_memcg;
-	struct folio *new_folio;
+	struct folio *new_folio, *old_folio;
 	int nr_shmem_dropped = 0;
 	unsigned int min_order;
 	struct lruvec *lruvec;
@@ -4282,28 +4282,31 @@ static int __folio_freeze_split_file(struct folio *folio,
 	 * before @folio, or at the end of @list, and the LRU is drained
 	 * from the tail, so the last one added goes first.
 	 */
+	xas_set_order(&xas, folio->index + old_nr_pages - 1, 0);
+	old_folio = xas_prev_canonical(&xas);
 	for (new_folio = folio_prev(end_folio); new_folio != folio;
 	     new_folio = folio_prev(new_folio)) {
 		unsigned long nr_pages = folio_nr_pages(new_folio);
 
 		folio_ref_unfreeze(new_folio, nr_pages + 1);
 		lru_add_split_folio(folio, new_folio, lruvec, list);
-
-		/* Add the new folio to the page cache. */
-		if (new_folio->index < end) {
-			__xa_store(&mapping->i_pages, new_folio->index,
-				   new_folio, 0);
-			continue;
+		/* Mapping is split, but content is still old folio */
+		WARN_ON_ONCE(xas_get_order(&xas) != folio_order(new_folio));
+		WARN_ON_ONCE(old_folio != folio);
+		/* order 0 store: siblings keep resolving to this slot */
+		xas_store(&xas, new_folio);
+		/* Step off now as the unlink below can free the xa_node */
+		old_folio = xas_prev_canonical(&xas);
+		if (new_folio->index >= end) {
+			/* Drop folio beyond EOF: ->index >= end */
+			if (shmem_mapping(mapping))
+				nr_shmem_dropped += nr_pages;
+			else if (folio_test_clear_dirty(new_folio))
+				folio_account_cleaned(new_folio,
+						      inode_to_wb(mapping->host));
+			__filemap_remove_folio(new_folio, NULL);
+			folio_put_refs(new_folio, nr_pages);
 		}
-
-		/* Drop folio beyond EOF: ->index >= end */
-		if (shmem_mapping(mapping))
-			nr_shmem_dropped += nr_pages;
-		else if (folio_test_clear_dirty(new_folio))
-			folio_account_cleaned(
-				new_folio, inode_to_wb(mapping->host));
-		__filemap_remove_folio(new_folio, NULL);
-		folio_put_refs(new_folio, nr_pages);
 	}
 
 	/*

-- 
2.56.1


