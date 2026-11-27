Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808769;
	b=XTCeOGoWO719aWHs2Mj+EwMpcxpIg0XjZKKC1q2hASBXtPtRvbImws63tG842sUJtxKt
	 vVuMReApFGg2m2fr4Skt46gdRGBMrS/ZuWcTJdFLV5bRPvFw03hwy6adnDctpA5VNYpxj
	 Qsfz4cEJP0mkUlToX8zosAIkbI097b+jXSxqDUh+hrYRyPu1K7+sbW8PW0WA72C2y3qCt
	 lvdpXPQYG9bsIbwt+zRw+MNR4tyKkwN6/J2l5kZ6TSlhfAbnkuQJyjcjWUWV3/xrJFzoX
	 +O/RMbVTfbrmonovAZn60A9747yv62zzdeBVNt/zYDk2wxFhk+9sPAV46CGJQ39zFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808769;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3Hwpku+LaQUx6JE9I+VbAYIc8Bnjhvc4+sIsQUi+qxE=;
	b=VTgevS8OLcOk1qF+Pc/V4X0+DaBk3yPDkMJ0qMnE40uiyzFkOOvL/e/GSXmTUSR4wIm9
	 c5DIP9LiJm7i2ct0/it6YGWXIDt7X6auA4ZlXzRWD97vc+bMbRDLHzOm/Gt6kSKOFm+5f
	 rWKyveDr+gapGAgLxhL06BX5AwQWW5IaefJu6Vk4goRF7N8Fc6/VSwBuiWs42+KtjPgiS
	 +AI1bV1qjmVxB8DnCzjy9e8jL1YRkk9xib1Buhi+YIt3CFckHac4+/EMc37jd37302sSm
	 lL9SI/4uoxkY+i3WdCUmD2c/Nwxtqn3UPJnLZAFo35P0npPnj9T/5UDgN2Gt1yh5Dqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEU0kyU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3E606A323;
	Fri, 27 Nov 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEU0kyU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAEB1F0092B;
	Fri, 27 Nov 2026 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795808768;
	bh=3Hwpku+LaQUx6JE9I+VbAYIc8Bnjhvc4+sIsQUi+qxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NEU0kyU8trWrBW/upvnTB8ftnM4V+QLSmk44qqfny0x+HmBIQycOEoHCCScJkm9o8
	 0dYU9BRIKPet10jCO8AlBcRws0tNdzEO+ZtXzzFR3XJYyD0VSd5DCrraS/Twsk9+bI
	 7J2BZmBI19JHNQHLLYA7sd9+MgdGD7qziZC+sc1UICkB+X8zYI2U0IAB61BSGXJ8o9
	 gHzHcykr5voC5QkziAx3FZGYvNVROZgmT53h8I6gOfYi1xgIKEkz44DOdGJG52jUso
	 h91n7RrWkLTU/5Vdd7vS/3qDuu4aCgLLR38qfeSQz3QQZBNLND7E+Ecbl8nMkvmyZ1
	 zvD9eTHcGeMFA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 27 Nov 2026 19:45:41 +0000
Subject: [PATCH 2/4] mm/madvise: don't declare OOM for MADV_WILLNEED swapin
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mlock-madvise-mprotect-ai-fixes-v1-2-e46b2b1eb435@kernel.org>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
 Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
 Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=ljs@kernel.org;
 h=from:subject:message-id; bh=zISF9slmgFgn0hlNBHComrSnoxHsfcZ4I7sJ6aGObbk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5777MnK0etsLl5Pe7T4syZTuvvZJeuKpK6rn/RffPP
 z9lrf6xqqOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATyeBh+GeVyDXl2PWz0/kn
 fxErfXJWcLvIzgDFK8leCk+anjJufujL8D8/UEn2a1l9r+vhz8peBTtZO7OVdK8wh9z/9/Vdae2
 LfUwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

MADV_WILLNEED on memory in swap can OOM kill a task when the memcg that
the swap entries are charged to is at its limit.

The hint is only a prefetch, so it has to give up on a page when memory
is short. But swapin_walk_pmd_entry() and shmem_swapin_range() call
read_swap_cache_async() with GFP_HIGHUSER_MOVABLE and with the gfp mask
of the mapping, so the allocation and the memcg charge can both go as
far as the OOM killer.

The charge goes to the memcg of the swap entry, which need not be the
caller's.

The fix used here is to allocate with the gfp mask of readahead, and to
flush the block plug when a page fails. madvise_do_behavior() plugs the
whole walk, so the swap writes of reclaim can sit in that plug. Their
folios stay under writeback, and with no retries the rest of the range
can fail as well.

The hint can now skip pages when memory is short, whether in a memcg at
its limit or on the system as a whole, since neither the allocation nor
the memcg charge is retried any longer.

This applies in particular where reclaim has to write to swap to make
room. Skipped pages stay in swap until a fault reads them.

Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: commit message tweak ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ebb4ce7daf6c..8b56f7aea935 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -196,6 +196,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
 static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		unsigned long end, struct mm_walk *walk)
 {
+	/* Only a prefetch, as in readahead_gfp_mask() */
+	const gfp_t gfp = GFP_HIGHUSER_MOVABLE | __GFP_NORETRY | __GFP_NOWARN;
 	struct vm_area_struct *vma = walk->private;
 	struct swap_io_ctx ctx = {};
 	pte_t *ptep = NULL;
@@ -221,10 +223,13 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		pte_unmap_unlock(ptep, ptl);
 		ptep = NULL;
 
-		folio = read_swap_cache_async(&ctx, entry, GFP_HIGHUSER_MOVABLE,
-					vma, addr);
-		if (folio)
+		folio = read_swap_cache_async(&ctx, entry, gfp, vma, addr);
+		if (folio) {
 			folio_put(folio);
+		} else {
+			/* Reclaim queues its swap writes in our plug */
+			blk_flush_plug(current->plug, false);
+		}
 	}
 
 	if (ptep)
@@ -267,9 +272,13 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		folio = read_swap_cache_async(&ctx, entry,
-				mapping_gfp_mask(mapping), vma, addr);
-		if (folio)
+				readahead_gfp_mask(mapping), vma, addr);
+		if (folio) {
 			folio_put(folio);
+		} else {
+			/* Reclaim queues its swap writes in our plug */
+			blk_flush_plug(current->plug, false);
+		}
 
 		rcu_read_lock();
 	}

-- 
2.56.1

