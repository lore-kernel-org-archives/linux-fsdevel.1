Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606449;
	b=MqHV46UAlFNg8t+4b2U+74OiTCsMgYi1vnvyKs1UYoigZQKwk84QgDuexRdADdUeM+gf
	 qxXuB2qE8wsJTkTYAEMCu+nQqwyY03YCgoDMV4nm+HMFhq5yccN72KcF9a0463DrwdlVG
	 gme2tJSnnb8FiwQIuL5iMahSKZqGTxlKF/b4Of63tnei3Hh7d3J/l7fUmCzdeCqEvY8l+
	 VL0trgEYR+tWiU3rR7rLKu/qbAj2O/+arRXJL9Sl7XxBQDatZp7NvS6Utd91JAdvm5/RC
	 Wj0lwXP+704Ef6mqAWlx5aYC0WzNqnjbETRHrvuWaOR28kwLvcZUDSJEB+65edHiEqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606449;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HExK7kLwtGYxqqtHxCbELsXf8y47tPfO+BJxdX9pDIQ=;
	b=QJG8UyZ0OBeatq9G8oNbOTNslCVv49mZU8b6LXVtxadTlnL0TvDgsVhRL6jHh/Cee5B2
	 CxkFhIQZPxUGXfSFVXpWjyZAjTwthgaX2xCpErK26s6q8rA07sLPQKuuzeUpqTOQTldpK
	 vayxlYlUpA0X3znbNbEo84KPssUjV8OKM73ZYt9z4gcfw7i0c486hVoApeEn3Z9Oicc26
	 Tku70UQgrq5n9tpg9yCvXAb0jSVcwsWdQ2zVd+w0ec1yCHLmbnl+bA4a/iip23eBcow3a
	 r/oKSR+X4WefdZtdDDafecf5rwWonovp+Cw4eNk6eXC77OsnULEUj18p7e8F601VhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGxeeDnm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49919606A32D;
	Fri, 13 Nov 2026 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGxeeDnm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41BB1F000C7;
	Fri, 13 Nov 2026 21:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606449;
	bh=HExK7kLwtGYxqqtHxCbELsXf8y47tPfO+BJxdX9pDIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GGxeeDnmymBNFEyqfNOYwbzHXLtYqa2OtyXWU1xL0DuWktPQjz29XeofxjK+fTUCY
	 I9hyJPH8hSrWmTR2h7UKvtt+Fk3GUT2N27+78vMItTvhsHKl2cMhyUjAdeoSMQIu90
	 gjlhSVeb1dCkFwrpjlPcrWsDJ05e6fCgfWUu6yZU2ENyl+fh+vPLUw+DJLIsYAUhti
	 JUsyZZoSJQ/1ZVkCtUf1wdNIL3EJ3HxhOwqlhv0k+xkJ9sz5cFGMveAREJRjXtMa8j
	 0bQc+ZP7xN3reWijKGQ7T2J4UGFulxbZ4trpt3eT1yjc4gtTVJ80Z1H/rYN0zmBFnr
	 6mYuCEsX1m4ng==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:29 +0000
Subject: [PATCH v2 11/13] percpu: fix contig hints that are too low
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-11-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6398; i=ljs@kernel.org;
 h=from:subject:message-id; bh=tYXKOKPBvvIW94NkzmeBl1JGwwOkBZ9Xv1fW/VSYwh4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/y88dti70eXyqx/VhOfXV1mePf656k9aZ4SP+f/T
 xdbxGFe1VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJmK1j+Cu/cOr5Xe9cBb6v
 281X+eate5uWolXkx4cXnzu3x6+d97aEkeG4EWv1zIWR0dMau+bbzuqe8fLjoi1Ozh9cPyTN1to
 idIAVAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

pcpu_find_block_fit() skips a chunk or block whose contig_hint is too
small for the request, so a contig_hint must never be smaller than the
largest free area.

If it is, atomic and reserved chunk allocations can fail spuriously, and
others can create a chunk which is not needed.

There are three ways in which this can happen:

Firstly, when an allocation breaks a contig_hint, both
pcpu_block_refresh_hint() and pcpu_chunk_refresh_hint() promote the
scan_hint to contig_hint and scan only what follows it. However a free
can set the scan_hint regardless of what precedes it:

    free areas    A = 10 bits, then C = 50 bits
    hints         contig_hint = C
                  scan_hint = 0, cleared by an earlier allocation
    free B        5 bits between A and C: scan_hint = B
    allocate C    contig_hint = B, the scan starts after B
    result        contig_hint = 5, but A has 10 bits

Secondly, when a free stays within one block,
pcpu_block_update_hint_free() passes the end of the free area to the
chunk hints as a block offset rather than a chunk offset, so in any block
but the first the chunk hints are not updated at all.

Thirdly, that free area stops at the block boundary, even if the free
bits continue into a neighbouring block.

Fix these by always rescanning when a contig_hint is broken, passing the
correct offset, and refreshing the chunk hints whenever a free area
reaches a block boundary.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: da3afdd5bb54 ("percpu: use block scan_hint to only scan forward")
Fixes: 92c14cab4326 ("percpu: convert chunk hints to be based on pcpu_block_md")
Fixes: d33d9f3dd96b ("percpu: use chunk scan_hint to skip some scanning")
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/percpu.c | 59 +++++++++++++----------------------------------------------
 1 file changed, 13 insertions(+), 46 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index d7883507dc15..dfd3ff0a1ac0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -733,30 +733,16 @@ static void pcpu_block_update_scan(struct pcpu_chunk *chunk, int bit_off,
 /**
  * pcpu_chunk_refresh_hint - updates metadata about a chunk
  * @chunk: chunk of interest
- * @full_scan: if we should scan from the beginning
  *
  * Iterates over the metadata blocks to find the largest contig area.
- * A full scan can be avoided on the allocation path as this is triggered
- * if we broke the contig_hint.  In doing so, the scan_hint will be before
- * the contig_hint or after if the scan_hint == contig_hint.  This cannot
- * be prevented on freeing as we want to find the largest area possibly
- * spanning blocks.
  */
-static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk, bool full_scan)
+static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk)
 {
 	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
-	int bit_off, bits;
+	int bit_off = chunk_md->first_free, bits;
 
-	/* promote scan_hint to contig_hint */
-	if (!full_scan && chunk_md->scan_hint) {
-		bit_off = chunk_md->scan_hint_start + chunk_md->scan_hint;
-		chunk_md->contig_hint_start = chunk_md->scan_hint_start;
-		chunk_md->contig_hint = chunk_md->scan_hint;
-		chunk_md->scan_hint = 0;
-	} else {
-		bit_off = chunk_md->first_free;
-		chunk_md->contig_hint = 0;
-	}
+	chunk_md->contig_hint = 0;
+	chunk_md->scan_hint = 0;
 
 	pcpu_for_each_md_free_region(chunk, bit_off, bits)
 		pcpu_block_update(chunk_md, bit_off, bit_off + bits);
@@ -774,19 +760,10 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 {
 	struct pcpu_block_md *block = chunk->md_blocks + index;
 	unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
-	unsigned int start, end;	/* region start, region end */
-
-	/* promote scan_hint to contig_hint */
-	if (block->scan_hint) {
-		start = block->scan_hint_start + block->scan_hint;
-		block->contig_hint_start = block->scan_hint_start;
-		block->contig_hint = block->scan_hint;
-		block->scan_hint = 0;
-	} else {
-		start = block->first_free;
-		block->contig_hint = 0;
-	}
+	unsigned int start = block->first_free, end;
 
+	block->contig_hint = 0;
+	block->scan_hint = 0;
 	block->right_free = 0;
 
 	/* iterate over free areas and update the contig hints */
@@ -938,7 +915,7 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 				chunk_md->contig_hint,
 				bit_off,
 				bit_off + bits))
-		pcpu_chunk_refresh_hint(chunk, false);
+		pcpu_chunk_refresh_hint(chunk);
 }
 
 /**
@@ -952,12 +929,8 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
  * forward and backward to determine the extent of the free area.  This is
  * capped at the boundary of blocks.
  *
- * A chunk update is triggered if a page becomes free, a block becomes free,
- * or the free spans across blocks.  This tradeoff is to minimize iterating
- * over the block metadata to update chunk_md->contig_hint.
- * chunk_md->contig_hint may be off by up to a page, but it will never be more
- * than the available space.  If the contig hint is contained in one block, it
- * will be accurate.
+ * The chunk metadata is refreshed if the free area reaches a block boundary,
+ * as it may then extend into neighbouring blocks.
  */
 static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 					int bits)
@@ -1042,18 +1015,12 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 	if (nr_empty_pages)
 		pcpu_update_empty_pages(chunk, nr_empty_pages);
 
-	/*
-	 * Refresh chunk metadata when the free makes a block free or spans
-	 * across blocks.  The contig_hint may be off by up to a page, but if
-	 * the contig_hint is contained in a block, it will be accurate with
-	 * the else condition below.
-	 */
-	if (((end - start) >= PCPU_BITMAP_BLOCK_BITS) || s_index != e_index)
-		pcpu_chunk_refresh_hint(chunk, true);
+	if (!start || end == PCPU_BITMAP_BLOCK_BITS || s_index != e_index)
+		pcpu_chunk_refresh_hint(chunk);
 	else
 		pcpu_block_update(&chunk->chunk_md,
 				  pcpu_block_off_to_off(s_index, start),
-				  end);
+				  pcpu_block_off_to_off(s_index, end));
 }
 
 /**

-- 
2.56.0

