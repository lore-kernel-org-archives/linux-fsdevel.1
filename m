Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794186058;
	b=s7EzXGiuJ3W3KZ9d86OK1PDqMj6Mhq4sf0Slp1bhBJsSJxV+MeCLShfMevhR8PAOrECP
	 oe+kSf7CKxdlPu6QCF5EZF6y2V3k9H7e5X2nEx5IkHNMxvS6jT/zaDHjEUpEbIb/RccZf
	 jetVAUxkR0pJ2XAJV7Jxq7ykd9ulb61EXgiWMxx6pXxCpRAi3z3eARekP/wm0pcp3/Su9
	 E1+nbj3JWK/XRLZfWIcF5Qtj1lnx6dxG/6ir+UGK0VOftMUFHeivgwHo+b0cwGKLq9gn+
	 7TRXLct6UHmOGKrK/+uzZtOrM7wZZxeu3/4g744LRSR4mfqZZOihZ6kyRzOf1uSfU7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186058;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XhmctGYt1NLuOmkkJo8KoaAOSF5MQcdoV7paVt7iNJ8=;
	b=bePdUMo72s4G/yDw0Owl9RKPEKqHxb2HLHONLebxUtgA5UmN6nW3mzJa4GnS33tFj5Qs
	 LEcbGlK1gOXd5qFE352hLBc0TghsAd+tls5J8yCtSVRVqdPeDLAIW2k7f7VkbRWA8wU1v
	 EcFprQeAbG1fP6W5LpgdM5TLhcSNQMR5VUyacy5t2eonov6TE1mE61dI24q7HKKF0s5pT
	 u7z5NdBfY+ROBOnTM0z5NbEW5tgNBDUI/uE9xvt+4olGAxTuoxDocYDWBr+M2fbZYBGdX
	 vjoi2l/O3rTFTcYx2g2PcF7p35rKnZ7qqoRW/3mkZGr9HTveo4OOqZpjvVlxHIIcURg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB1WW2ZF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533A606A31C;
	Mon,  9 Nov 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB1WW2ZF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794186057;
	b=nJDUpUTrr6PveLW4puvohSYpbQ3zKqO5hLw3gpcHN+TnPkLQtwHJiNHVWeAUAPYglIuw
	 6VHW7hZhbXkJzrbGIUiCdzDgBHqwsi01ECTkpwmd0TCGfrd9PBcflHT8tKz7eBkcskk8E
	 PZJkrCesuIGclRFSslTaRPVe+WG1bRPi0vjRQKDXsbDuV7BWVZryN+tzESCunNf8n3Vqg
	 C+wOY0VbQM2Te7hvV4eLXYCbp8xn4XYa2l2iw30hNamoRZKWe2CLKBzT277qHjyLAI6ko
	 io0TnnIJHvZtoL45q7dK456MdYSBcsxmeA7nG6N2SfhRWpOVbBWUXt5EIbSdXAvXYWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794186057;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=XhmctGYt1NLuOmkkJo8KoaAOSF5MQcdoV7paVt7iNJ8=;
	b=LnM+/HzCQ0q1YRz5rvDz/aeZOjy++w2ARzUDaIv0IyC9XiE9xrqjSKWgsWEOByk0Z4cS
	 GhqEevGEc3LDF3+2aIpnA/c35QoauP8jswKqvLKeN0D3HkAjIOnmAFkWlgL4vDPhwSAha
	 suvK2Sx63iKNplnsAtJ/pdSFoxmYfEFXMaqaM+PMUQma7HesUu4E2a/1h0LRBWWni1cwi
	 2VuUohQYaCzfoOskOVF4ui2QZsk2gKJVUZIINQbcOOvlc+DAqxJe7sjWohh58V6oe0EKP
	 xjb9b25aM/BNzZQImEgyi9lrWBcPA0jPG/Xmupwu5vteJ0QJabZriJa5vU33uR9iYWA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A34DF1F0089F;
	Mon,  9 Nov 2026 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186057;
	bh=XhmctGYt1NLuOmkkJo8KoaAOSF5MQcdoV7paVt7iNJ8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PB1WW2ZFBpGVIAphSviNgdlZGQzscS+VBrNvGHlnVxEPn5B/2b6YyoJpl2U91/Y81
	 EeTbaMrBx1b6Df/mhvEJSk+4+GHwtNbKcvMd61MxehrJ7x1tZA2HLot0Xu9QI5Nn9b
	 ajmoKkjh1QGItA/d/RbCobqidVbko3sRKlqreFFdBOsyLso1BpnG3pYuS/AGge0oQ6
	 tGQZ40BXmY2uErQXU9luvhaaMa7OQcA1f0nCDkiW9JiNwqnjFffm0RlKvtauTABxhm
	 wJAUsgCITYpJzxFuSVVnPPLaasNvW27cZal7KCTSjEa/BrOw6HvvEdZasARCfk4cnp
	 mWY+ubBLJeZKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 046CB481D0;
	Mon,  9 Nov 2026 01:00:56 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Mon, 09 Nov 2026 10:00:56 +0900
Subject: [PATCH v3] mm/readahead: align the async window in
 page_cache_ra_order()
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
Message-Id: <20261109-mm-readahead-async-align-v3-1-1567d87b1858@samsung.com>
X-B4-Tracking: v=1; b=H4sIAEcb8WoC/33NTQrCMBAF4KuUrI3kpw3GlfcQF9NJ2gZMKokGS
 +ndTYsgLpSBgfdgvplJstHZRI7VTKLNLrkxlCB3FcEBQm+pMyUTwYTiTGjqPY0WDAxlUUhTQAp
 X1wdqa81baZArUKSc36Lt3HOjz5eSB5fuY5y2T5mv7RuV7DeaOS3DtLGgDg3v8JTAp0fo9zh6s
 rJZfKhi/aFEoVCiZDW2CI3+ppZleQG2u9AdDQEAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794186055; l=6482;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=TvHvnVH31GT9hKp4I2jjZznNd6BXKJMMPl//bejzAgQ=;
 b=vhzld0CvUYOjFuiyUmo53Sq4vh0jPPHbl8KqVFO/yzG4x4ECknVS/IZ9cgypWuOoHMcBLWp7r
 abZeA1MYs/EBimBM2+CCk/xDQNgRZsO3vOqBSnTEHVoicXHBfc2Q3Os
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com
Content-Transfer-Encoding: 7bit

From: Daejun Park <daejun7.park@samsung.com>

page_cache_async_ra() rounds each window end down to a folio boundary
before page_cache_ra_order() picks the folio order. A window that
starts just below a boundary shrinks to a few pages.

Let page_cache_ra_order() end the window instead. 1 MiB reads after a
4 KiB read (read_ahead_kb=128, max_sectors_kb=512) take 0.121 s
instead of 0.237 s.

Windows that start halfway into their largest folio, or are not a
multiple of it, can end shorter. 512 KiB reads from offset 384 KiB
take 0.183 s instead of 0.162 s.

Fixes: 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
Changes in v3:
End the window in the allocation loop of page_cache_ra_order(), as Jan
suggested. Testing his sketch led to three changes:

1. Stop when the rest of the window is no larger than the last folio,
   not only when it is smaller. A window that starts halfway into a
   folio then ends on a folio boundary. 4 KiB reads (read_ahead_kb=128)
   keep 4094 order-5 folios as before, instead of 8190 of order 4, and
   the 1 MiB reads above reach order 7.

2. Test the order before the EOF loop lowers it, which the first
   change needs. With min_order > 0 the loop then also stops before a
   min-order folio past the window end.

3. Do not cut a window that reaches EOF. It has no PG_readahead
   marker, so the cut tail would be read synchronously (92 instead of
   50 sync readaheads over 50 cold files).

Windows of mappings without large folios are no longer trimmed.

Result for the 1 MiB reads above (512 MiB file): 1021 of 1039 folios
are order 7, against none of 9721 before.

Costs, with max_sectors_kb=2048 unless noted:

1. Reads larger than ra_pages that start inside a folio lose I/O size.
   2 MiB reads from 44 KiB (read_ahead_kb=64) take 508 device reads,
   266 before, in the same time.

2. Change 1 adds to this when a window starts halfway into a folio.
   In these cases it does not raise the folio order, and the window
   stays at the cut size until EOF.
   - 512 KiB reads from 384 KiB: 0.183 s, 0.162 s before (0.126 s
     with Jan's sketch).
   - 64 KiB-block XFS on a buffered loop file (max_sectors_kb=1280;
     the backing file's readahead runs this code too), 256 KiB reads
     after a 4 KiB read: 0.304 s, 0.19-0.25 s before (0.186 s with
     Jan's sketch).

3. A window that is not a multiple of its largest folio loses its tail
   on every trigger.
   - read_ahead_kb=768, 128 KiB reads: 0.130 s instead of 0.115 s.
   - 768 KiB reads (max_sectors_kb=1024): 0.125 s instead of 0.117 s.
   - USB 2.0 storage (read_ahead_kb=240), in simulation: 87% more
     device reads.
   - md RAID with 3 data disks (read_ahead_kb=3072): 506 instead of
     342 device reads with max_sectors_kb=1536 (simulation), 260
     instead of 342 with 2048 (measured).

No stable backport is requested. QEMU guest, XFS on emulated NVMe,
cold cache, 4 KiB pages, medians of 10 to 45 runs. Also run with
KASAN, lockdep and DEBUG_VM.
---
 include/linux/pagemap.h |  1 +
 mm/readahead.c          | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 73af18a373..669d296edd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1413,6 +1413,7 @@ struct readahead_control {
 	bool _workingset;
 	unsigned long _pflags;
 	bool _forward;
+	bool _align_end;
 };
 
 #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
diff --git a/mm/readahead.c b/mm/readahead.c
index 6e55632902..46bee515aa 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -491,6 +491,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 	unsigned int new_order = ra->order;
+	bool align_end = false;
+	unsigned long last_nr = 0;
 
 	trace_page_cache_ra_order(mapping->host, start, ra);
 	if (!mapping_large_folio_support(mapping)) {
@@ -501,6 +503,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	if (limit > index + ra->size - 1) {
 		limit = index + ra->size - 1;
 		mark = index + ra->size - ra->async_size;
+		/* Only a window that ends before EOF may be cut short */
+		align_end = ractl->_align_end;
 	} else {
 		/* We've reached the end, so don't set a readahead marker. */
 		mark = ULONG_MAX;
@@ -529,6 +533,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Align with smaller pages if needed */
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
+		/*
+		 * The caller lets us cut the window short. Stop at the
+		 * first folio that does not fit before the window end,
+		 * once the rest of the window is no larger than the folio
+		 * added last. The next window then starts on a boundary
+		 * of that folio.
+		 */
+		if (align_end && index + (1UL << order) - 1 > limit &&
+		    limit - index < last_nr) {
+			ra->size = index - start;
+			ra->async_size = min(ra->async_size, ra->size);
+			break;
+		}
 		/* Don't allocate pages past EOF */
 		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
@@ -536,6 +553,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (err)
 			break;
 		index += 1UL << order;
+		last_nr = 1UL << order;
 	}
 
 	read_pages(ractl);
@@ -656,7 +674,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	unsigned long max_pages;
 	struct file_ra_state *ra = ractl->ra;
 	pgoff_t index = readahead_index(ractl);
-	pgoff_t expected, start, end, aligned_end, align;
+	pgoff_t expected, start;
 
 	/* no readahead */
 	if (!ra->ra_pages)
@@ -710,13 +728,9 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	ra->size = get_next_ra_size(ra, max_pages);
 readit:
 	ra->order += 2;
-	align = 1UL << min(ra->order, ffs(max_pages) - 1);
-	end = ra->start + ra->size;
-	aligned_end = round_down(end, align);
-	if (aligned_end > ra->start)
-		ra->size -= end - aligned_end;
 	ra->async_size = ra->size;
 	ractl->_index = ra->start;
+	ractl->_align_end = true;
 	page_cache_ra_order(ractl, ra);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);

---
base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f
change-id: 20261029-mm-readahead-async-align-e491b3dc16a6

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


