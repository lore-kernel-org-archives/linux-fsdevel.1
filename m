Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420881;
	b=aqzmfNj6fNEqZHUY/s0mR3vlydg9EF52/dtOhm1bhtrNVNZ8c2WC9m30/82DcJpk+yJp
	 wZ6itTFpb05vNeqdaDLhipEP9OukezSXPOeAvqFY1IClGDa3QZP0cLQ9LzFOZJykBSICE
	 KBWVyjKS2RIYv31XL7y1oukIJNudPU7TjZOrCzIZ7Q98qrlID1pS/hTDM6+trvzeIvGlp
	 MHbsRA7uIOGdtNTPIDqnQYV8E9mcR+Wv2WRE/pX8p0hJhQYTEOzIaVDX+RQmaiatRDLUd
	 Pt2nHUhnSjNAoGA/TXHsJYIfvHmWzUhLAoM4m0q7GARrCAz3tcFkyUPrT8kzGqNf+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420881;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CRpJbc3M2/X7AED55vXwUGnGdH/DtKter23k70n7+p8=;
	b=mivP3rBZnH15nzuo+Hmk9bH/nnJ6OZuLM33LCAN6VPIY+KAzX+BYVXVUSUodEkK3XnNj
	 HCIs5zTcCa0UwD+xi4y2p8jHa16XdV9NQQqh7xDX6ss2GNhG3B+w/LeYPwUR4zcLObPI0
	 3JW6a1gTWtkkr5f9G3hnRrXVOwcpQDSZEkLxmHQCaCj1lMZv1AI/gSRdxNc0o8bfD9yQh
	 4IpPGZ59y8FtwppBWlZtRWvnprpQYGY+cc4LQUb+2P47lgArzbyF0qOa8guaNNlxpm0ke
	 jnLMpGb5BRdtclSfyDW79Gj023icQjuADdEVtD8vCQSqenmteZln/lcOrFLloYcCg9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV0siQNe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116A606F39E;
	Wed, 11 Nov 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV0siQNe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE01F00A05;
	Wed, 11 Nov 2026 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420881;
	bh=CRpJbc3M2/X7AED55vXwUGnGdH/DtKter23k70n7+p8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AV0siQNek1dXuFg9Q0e8WoAy6x3wkQwBOG2pXZ2fNQRN/4+5u72bqZtxUBvDeKkzk
	 uTtcMBDdUvxBy2sMqFXHsnrScNJk/CNKuHLSyCy9pEm6IxSJ07zgFgqM1cOw9U8AUy
	 vJIbaTIKxhqi+ZAP/E2dyum2uSWwN5A+48vUThtQK8gm0MmDQPHbjGp++TtAiWxkWD
	 yM5xi396brXVfCZqbRTXn/MVi6fsW6vsf5kyhENFxrbLY4/08t3XnaQ4fTr64pTDMn
	 BmTTG1vDJBbuIwmIcPs3ri4QtqA4LZzGEFNg5uAwoVdLniljxihNYL195c0YlSydTv
	 GtZVqCQ6750Pw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:17 +0000
Subject: [PATCH 03/13] mm: cachestat: restart the walk after each entry
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; i=ljs@kernel.org;
 h=from:subject:message-id; bh=gVfN8ZkTuZTTiGqHsWf8o2QGVhWsCljDV9nO0zvGAfs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMieHfT5w5PqC4dPtG+/ZV7BlRr3oewoj9qzi9y3g
 w6Lbc9g6ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBELicz/K99XlFUO3Vfkpis
 lWO5JIuRS+qfRv65BknSMxn8LB8W1DMyzHB58Wrq4yOm0lEideyS5tqCq5nWzdkw9/g8G8Ej2kc
 vsQMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

cachestat() can leave cached pages out of its counts. This happens if
the entry that the call has just counted is replaced by a larger folio
that starts in the same XArray slot.

The issue is that filemap_cachestat() walks the page cache under the RCU
read lock, so racing concurrent collapse/split is possible.

Thus, an entry can be replaced immediately after the walk has returned
it. When that happens, the next xas_find() skips the sibling entries that
point to the slot of that entry, since ordinarily they belong to that
entry.

However a concurrent collapse_file() or __filemap_add_folio() (when
replacing a shadow entry) can store a larger folio in the slot, in which
case the sibling entries belong to the new folio and the walk still skips
them.

Consider:

    cachestat                         collapse
    =========                         ========
    count a 64-page folio in slot 8
                                      store a 512-page folio in slot 8,
                                      with sibling entries in slots 9-15
    xas_find() starts at slot 8
    and skips slots 9-15
      /* 448 pages are never counted */

Also consider:

    filemap_cachestat()                  __filemap_add_folio()
    ===================                  =====================
    counts the shadow entry in slot 0
                                         slot 0: a folio of 32 pages
                                         slots 1-31: siblings of slot 0
    xas_find() skips slots 1-31
      /* 31 pages are never counted */

Essentially the fact that large folios might be present means we cannot
safely continue the XArray walk, and must reset the iterator each time.

Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/filemap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c05e4fad081..c4e82891767b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4731,10 +4731,11 @@ static void filemap_cachestat(struct address_space *mapping,
 		if (folio_last_index >= last_index)
 			break;
 
-		if (need_resched()) {
-			xas_set(&xas, curr_index);
+		/* Collapse or new folio spanning shadow entries needs reset. */
+		xas_set(&xas, curr_index);
+
+		if (need_resched())
 			cond_resched_rcu();
-		}
 	}
 	rcu_read_unlock();
 }

-- 
2.56.0

