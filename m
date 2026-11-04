Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797339;
	b=WX0qYQ6Tw37t8i3/NXSx1i20zBY2ifrXTfT0qP32XJS+4ShTyV+3U5T/Ok9zOWhEUDQM
	 TFc0aArbb+urp8AcSi1wbeD1bVAPeNZB2rzzzkc+WtV1zBrm1fiwXcmbQiu4fSa1lF7rJ
	 +mOd9SEWO1B7exQfyHG97ODssj72gD6qFFIu2r9Ix78zvLJuolcakZlWwZHqCW58kZel3
	 uMiQ2qbZFK88XkvsR3eugJyn5P45J4ZMvCdxlFMnrnkx3UboPb1w6XcLOIU5vzM6Y2Av1
	 ZJ7hhBt5sJ1yHF142lrTjb8rL/4FiX7kmEvV21Ml4Klj3ZL/Kjy83FX89vrIf6LE0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797339;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MLMUyhdzk/noOyENVlDlfK94lvgbxXguMgh8R60gx84=;
	b=bZ1YAZbDEiHBccRkUV0nDM02ULwjy+79lNN2TTH7yvzcNpyDyz9gfNFcyWOcn/jS5JM2
	 pgH/MVE8+7HbpKnavHJSQQ20l8SjIr2j1TMTN3/9kpEBZjg9PgEB78tE/owRAmz/SkHuq
	 NBRjdaD/llFcmBrBgUkOyqo2cFLbGW9prj5XWdnDyJFvkxwmFKe4jb/7JrvoEjLAjK692
	 T2cYh+VBQ0JstvadeJwfpqT7tHXtHNPOicBvyyR50ug20Ej3yoH1PkCrMCBssKqSZzKVh
	 TgQVdSc9Z5Q/4va6rDg4YtA50DzXD9UsqH5M7sWIpchY2E9w/iNuZXIl3GUlbouKwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgssHzBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F057606A330;
	Wed,  4 Nov 2026 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgssHzBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8FB1F00A16;
	Wed,  4 Nov 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797339;
	bh=MLMUyhdzk/noOyENVlDlfK94lvgbxXguMgh8R60gx84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgssHzBvnR/VcwVExYUL0gmaYL3T1S6TyyOjSLnqZRyPv/9zVzIvysV11Ny1z+gXm
	 C/Z7A47qXvjlU0FywOrdDF8KlNs1RI0NZqIsdWDPI7c7oEoZAv/nYbK353BTncFOV1
	 vHribaKWIYpf4ySj0R0N+WKDh1J4RwXnWs1zci+oNWPyc0+r7XphJV7ivZSQwRNqIt
	 /EnunfcujQ/dWgXktimc63jzMmIhRQJhFBfwY2Cwf9lDeEAH8t4+IbQec2SQSUajeP
	 dymOLECecLeWtmo5LbXNweGj9/CafAnYhnsdCd3jN/pmc9kBWpvK65LsBMvNFEzEsi
	 BmoxKKv+aaVaw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 31E881980052;
	Wed,  4 Nov 2026 08:02:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 08:02:14 -0500
X-ME-Sender: <xms:0izraupDhaEQGFDMq6Iy4t0MnGYC0Rb6eTg4xD05b7PVKLoT9I4nRQ>
    <xme:0izrah46V7-Y8BNqivCCxwaUu5dO7bo5La9Q0hjpFwtKxLzudWEg9uaDxv755YzxU
    uScc1pPKcbtXdFQHa_ljNzputNMDMMLOhsbRu619SVgB6z89PHASYQ>
X-ME-Received: <xmr:0izral0CT5KMzV2Qk1bzOvpPV53W-6s_Nq-xJMPUsnVZsC2VDYpkd6GjYPU>
X-ME-Proxy-Cause: dmFkZTGhPc1Yg5t9Q8eRQaKCLT0heVoXQqf6h4uqMuRtXQYzheOI1jp47nBw26mcWoxz9A
    DH10HnpPYob7RxaCTf32YkHXSpJmh1hLC1IxxzXB90aJAI2wMnFT+nxhjDMKjWZ9Ablulj
    X6EGhbUdQWvr3vCsmIbyKlTdtYm8QJi2H9b42DzXiIRq27TGzwIAKeq7xgftm17WrW++J+
    RK/ZhBFKi/01LbyIuttpTNhw8T5nzUYT3/gbSIkELTYoQfWYa9TU1xDsUR8Sja7r663Vhq
    dT9Vb6Q8iqTkFCbamg7ObiOCckNJsrzr7UPmHz2jvO2iFJ92ew01ZxP0mcoMzU2JutwOVF
    8u+V40EsbW3Xm19sfo4Oy0BtGYrJ+rDGsmaV/Kus0W8Htiy2bsPuViVsmyIYkLeevGJAtH
    h0iz39M/T+K/qBGGGeXvMu4rBFjQRHTjU1ZK8f1mUPMV1VO2wj+TLFjnw26BYULH/8FfTe
    1w3gQ/UarqXmQmwUTIpb/JUxos5OXhxdIXVlnKTj1rWyePytEvna8Lsl0PJKZXm1hP9Ova
    v39yitZDVVeGHjQ4cJhoaac4oo9Ja1doxwuIxCCh6Xda7rpbXU5w1HAqkhHOo9bKl43cTs
    gLwIs1gHymXAW7aAb2PgnRy+eqAteBWCDRbNyKzAdA/aG+hdRslAIuPTncuA
X-ME-Proxy: <xmx:0izratmrRt0eSJTMfEPusZmPdI5uXn88JaGkJv6MTbsMrBh_xQFfLQ>
    <xmx:0izrauivoASPu0vf94NsePIXppPs14EHLUQcQpobahRMu1POT6Ppdw>
    <xmx:0izrak1orvV1Vrf01IjcsY15Rs-MF9hR_Uq5WSU-1ZgnjMsjTnla9A>
    <xmx:0izrarbQc4GWVyu_ITVwoxLjhwkfGFgwQGkrjCmdowAZS8y4AklCdQ>
    <xmx:0izrahmndiq1ff-toqKwyeg82b3eR7tQ05BOIfOJ8S4eAjzj7InKQcyu>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:10 -0500 (EST)
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
Subject: [RFC PATCH v2 08/18] mm/compaction: free the migrated folios that wait for a grace period
Date: Wed,  4 Nov 2026 13:01:04 +0000
Message-ID: <20261104130118.2507513-9-kas@kernel.org>
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

A block that compaction has migrated every folio out of becomes free
once those folios are back in the buddy lists.  A migrated folio that
had PG_rcu_free comes back only after a grace period, so compaction
finds the block still in use, migrates more blocks than it needs and
fails more often.  defrag_mode relies on compaction making whole free
blocks, and there it shows up as allocation stalls.

When compaction moves past a block it migrated from and the zone has
pages waiting, free them before it drains the per-cpu lists and checks
whether it is done.  The drain costs an expedited grace period, so
async compaction, which must not block, skips it.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/compaction.c | 8 ++++++++
 mm/page_alloc.c | 2 +-
 mm/page_alloc.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c6..2acb87a3446d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2760,6 +2760,14 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				block_start_pfn(cc->migrate_pfn, cc->order);
 
 			if (last_migrated_pfn < current_block_start) {
+				/*
+				 * Folios migrated away from lockless readers
+				 * are freed after a grace period.  Async
+				 * compaction does not wait for it.
+				 */
+				if (cc->mode != MIGRATE_ASYNC &&
+				    zone_rcu_free_waiting(cc->zone))
+					rcu_free_drain();
 				lru_add_drain_cpu_zone(cc->zone);
 				/* No more flushing until we migrate again */
 				last_migrated_pfn = 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eea287ab2a01..afd4343ad572 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1457,7 +1457,7 @@ static void rcu_free_defer(struct folio *folio)
  * callers want to allocate the pages next.  A concurrent drain holds the
  * lock until it has freed what it took.
  */
-static void rcu_free_drain(void)
+void rcu_free_drain(void)
 {
 	static DEFINE_MUTEX(lock);
 	LIST_HEAD(list);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 764e3f43b3b9..4f5f06adbfdc 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -235,6 +235,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
+void rcu_free_drain(void);
 void rcu_free_sync(void);
 
 /* Whether @zone has pages waiting for a grace period */
-- 
2.54.0

