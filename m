Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474342;
	b=rtZ5sNCVSudpq1LWnNFBhgZTbgDHVGShK7+967Er+GYeYpoY42fLTB/4mCklbYDQJNio
	 heWwmNarCrMOnzYEagLlxkHkRZXK9iO9qg+3rbSkdTjjWe2d7gJ5glGNbE1olpDFUGmoD
	 M+b21S9kEshEjSebAedvMPkbZ2IInaVWxjQfV+H885aSSb9/dUI2LKeF3p8qPpd3VwWKy
	 aYLDPa/i/rQ1Bk/xeJuAy8HbytH+aYef4Ssdru7nx3Muaqqc8RtwYiW7OrtoZtfShQCyN
	 HSFIvs0V9FyWI3SlRoC86a//WF+tOVtZ20Vr7lMu65Z8d7PPFR4Up+mngXitTJVQiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474342;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=zdwRUxVnTZpYGma3zR8iiLeIgpobDvdrNh1nRqXAWMA=;
	b=LTK8M87dBdwRYDiyDLemHDsk6Iu9DAGKLgW0ZuFXs4obgmlo1yfNnF0gieiJvdm2YCIy
	 GNQQRGY3S0/6mlwVOba1Kkei5Bqkrl9AG9Ne+wpnAJnebp85dh+ZvgkI+FRuyv34zsvwR
	 TKYNC4IVriHjEYa/s8WNfuCzLbyYOBP53EzAHtNvEjRYvDTqnrOQ8C7srivqY+y3Uqu8i
	 /pE9fjLsZSPPT9+wIvdAHPR3aqof1WzOh4H60RO2RD6xot0UhVXCM75qJL7CHGqTbWFe2
	 qx8iYn2SctFN3VOd4e2q178vFln1SpPRKt9b/JqMDZS1BDU5KJw/tOMipvxp6q9lk7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DCsQmUyQ;
	arc=none smtp.remote-ip=95.215.58.45
Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5325606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5325606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DCsQmUyQ
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KIBx6J3ONlwSdrSfqJem9k0si8vhTNYH9l6d114wjKA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794474338; v=1; x=1795079138;
 b=DCsQmUyQ79v5wBYgkdsZd8ebSpT4VClpeRJd66dX/56CNzO3uF0SfW4Ta/e/y66fZWzLpKDm
 O10ZENMP0VPHQaI/l+Yiju9S06dT8WsH8EtITnzH3wo6+7Uv5Hz6r0rcGSI/SRjCho0G9cfIhwB
 cVrvXWjk4uCw+4q6jva6EuOM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 60eafffd12fdfb43;
	Thu, 12 Nov 2026 09:05:33 +0000
X-Mizu-Trace-ID: 60eafffd12fdfb43
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 12 Nov 2026 04:05:12 -0500
Subject: [PATCH v3] mm/shmem: remove truncated folios from the page cache
 in batches
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
Message-Id: <20261112-bug-mm-shmem-undo-batch-v3-1-212db8c24058@linux.dev>
X-B4-Tracking: v=1; b=H4sIAEiB9WoC/4XNTQ7CIBCG4as0rB0D9MfWlfcwLigMhUSKgZZom
 t5d2o1ujMv3S+aZhUQMFiM5FwsJmGy0fsxRHgoijRgHBKtyE055wyjvoJ8HcA6icehgHpWHXkz
 SgEJKmepkoxmSfP0IqO1zl6+33MbGyYfX/iixbf1vJgYM6q4vK864xlN7GZyw96P0jmxm4h+H0
 fq3w7MjsNZtJ1HRqvp21nV9A4XaRgoGAQAA
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

truncate_inode_pages_range() takes the folios it finds out of the page
cache with delete_from_page_cache_batch(), which takes the inode's
i_lock and the i_pages lock once for each batch of up to
FOLIO_BATCH_SIZE folios.

shmem_undo_range() calls truncate_inode_folio() on each folio instead,
so filemap_remove_folio() takes and drops both locks once per folio.
Truncating, punching or freeing a tmpfs file or memfd made of small
folios, such as a large /dev/shm segment, pays for that on every page.

Clean each folio up as truncate_inode_folio() does and, once the swap
entries are gone, pass the batch to delete_from_page_cache_batch(),
which needs truncate_cleanup_folio() outside mm/truncate.c. Undoing a
failed fallocate() only removes the folios that are not uptodate, so
keep removing those one at a time.

Dropping an 8 GiB file of 4K folios in a 32 vCPU VM takes (median of
five runs, averaged over two boots of each kernel):

  operation           before (ms)  after (ms)  change
  ftruncate() to 0           1144         901    -21%
  hole punch                 1148         906    -21%
  close() of a memfd         1139         912    -20%
  unlink()                   1142         914    -20%

Files of PMD-sized folios take 18-31 ms with or without this change.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V2 -> V3:
- Delete the folios from fbatch directly instead of collecting them in
  a second folio_batch, which pushed the shmem_undo_range() stack frame
  past 1024 bytes on mips with clang (reported by the kernel test robot)
- Rebase onto bf87d3fe8b35 in core.git shmem-7.5.misc and update the
  numbers from a new run
- Drop the Reviewed-by tags from Jan and Baolin, since the loop changed

V1 -> V2:
- Unlock the folios after folio_batch_remove_exceptionals(), as Jan
  suggested
- Rebase onto v7.4-rc1-132-g05441d697f7f and update the numbers from a
  new run

v2: https://lore.kernel.org/r/20261105-bug-mm-shmem-undo-batch-v2-1-ae5f89ced044@gmail.com
v1: https://lore.kernel.org/r/20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com

To see it, fill and remove a large /dev/shm file:

  fallocate -l 8G /dev/shm/f && time rm /dev/shm/f
---
 mm/internal.h | 1 +
 mm/shmem.c    | 9 +++++++--
 mm/truncate.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 566cbd2dce485..abe64e49a4170 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -628,6 +628,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
+void truncate_cleanup_folio(struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t lstart,
 		loff_t lend, pgoff_t *pstart, pgoff_t *pend);
diff --git a/mm/shmem.c b/mm/shmem.c
index ce92e74baeb75..5bcbdd6078a73 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1363,11 +1363,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				continue;
 			}
 
-			if (!unfalloc || !folio_test_uptodate(folio))
+			if (!unfalloc)
+				truncate_cleanup_folio(folio);
+			else if (!folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
-			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
+		if (!unfalloc)
+			delete_from_page_cache_batch(mapping, &fbatch);
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			folio_unlock(fbatch.folios[i]);
 		folio_batch_release(&fbatch);
 		cond_resched_tasks_rcu_qs();
 	}
diff --git a/mm/truncate.c b/mm/truncate.c
index 733d2713a875a..c6bf4aa0b91e8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -151,7 +151,7 @@ EXPORT_SYMBOL_GPL(folio_invalidate);
  * its lock, b) when a concurrent invalidate_mapping_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
-static void truncate_cleanup_folio(struct folio *folio)
+void truncate_cleanup_folio(struct folio *folio)
 {
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);

---
base-commit: bf87d3fe8b35087c2c043642e76e9f100d61328b
change-id: 20261029-bug-mm-shmem-undo-batch-de001d9c6f1e

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

