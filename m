Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599561;
	b=DCRaC0Ry0yqvMMd91qUMnK3fMrzEqghelIl+uZ78PxyV8dm+awMvMOr6IYAX1tuTH3RY
	 flfIzZ0I6e8M5Wl6LQCLoJY9+XXgIHtAc8B9jpvqaNjAIFxStCCaK94lUdLZV8hmT4BF1
	 0AEcnuyAv0kL+fkgtC4j/j7orEIFXqgLrkVSRyyqnzuCFz3dYh0vK4sHsnh2rm7yMZMHW
	 QfvZPtRSElJAPgUd9blOPcnmaYEKqxD5RoHe+vP7w+7KpcMK+QV71vjTNoyWEA9tlU/YD
	 SGvPHYyCG/nyCh4bUTtE8ZIhlJDEYusQ4GE7YZgC2tRcWxs/uErPk1dKgIOJX2JRkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599561;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+yuFDhrhf3kM/PO/AnTTpZJjMtV5tAkK8200L66uGl8=;
	b=XJbz8P+i2DG8xZzD5YmZHHK7hRMSpjSZT2YzziRQ02NeHBEZb5xEWy2hLTa+FHW/vO23
	 iRmKXwx688Lrg/JGBRJwRvYBrZrDw/2svVTiNQhmR6cfuZs5GqS/FtQF3FHkpKHFxdWL8
	 +48Td6hGppFA4A9JE+iRdu1XsJehC7ZMpaWdEKatso8cg8Drlcsfz2OUDsKmzoRTtJ1di
	 p2CQVHDhwR86UT+MBZp+kGLC13r5GxEnU+wDdPUvk1cqK9wAIn3lDj1AVN5saaIMGnRBk
	 CyvI74YPfDmfIEYttCTw/v/9GyBVm9ONgwsrK52XAS39TrNuytaBgjtDD2MFk6YRWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mnLeKo3J;
	arc=none smtp.remote-ip=91.218.175.85
Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AE606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 06:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mnLeKo3J
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ex0bR+wqY48y7Ys0l1lS/C4xyqfg/lqStx93s8K9wXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793599557; v=1; x=1794204357;
 b=mnLeKo3JIlrjZ0v8csYIXQvs0MqjNYBAaha6FI+GsXgzsTBscKhu47xfdxei1GstkYX55TtU
 s7+ijDrBsSQikbWr4RhQIABec//XfnZQfXcLKbZqgwK2XEUTDJ36HqPkKEIRh6O+ifRMQgl5bW3
 ABiUUGhU4PsBaXEJa27dL80Y=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 85932c5ab249e449;
	Mon, 02 Nov 2026 06:05:56 +0000
X-Mizu-Trace-ID: 85932c5ab249e449
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 17/47] mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
Date: Mon,  2 Nov 2026 14:05:47 +0800
Message-ID: <20261102060547.39942-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:39:46AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
>bits to the folio. A shmem read fault can map a clean folio writable, so
>a later store only dirties the PTE. Losing that dirty bit allows reclaim
>to discard modified data.
>
>The assumption that regular files are read-only is also obsolete since
>commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
>for writable files"). In any case, transferring PTE dirty bits to the folio
>when removing mappings (and while the folio is still mapped) is the right
>thing to do.
>
>Use get_and_clear_ptes() to collect the dirty bits and mark the folio
>dirty before unmapping it. Update the comment.
>
>This was reproduced with shmem using MADV_COLLAPSE followed by
>MADV_PAGEOUT.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
>Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: adjust comment; simplify description; cover file-thp as well ]
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/khugepaged.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 34ebb37c862c0..ce794d9760a87 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
> 		/*
> 		 * Must clear entry, or a racing truncate may re-remove it.
> 		 * TLB flush can be left until pmdp_collapse_flush() does it.
>-		 * PTE dirty? Shmem page is already dirty; file is read-only.
> 		 */
>-		clear_ptes(mm, addr, pte, nr_batch_ptes);
>+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);

I went through get_and_clear_ptes() as well. It merges dirty bits across
the batch, so we're covered even when the first PTE is clean and a later
one is dirty.

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>+		if (pte_dirty(ptent))
>+			folio_mark_dirty(folio);
> 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
> 		nr_mapped_ptes += nr_batch_ptes;
> 	}
>
>-- 
>2.43.0
>
>
