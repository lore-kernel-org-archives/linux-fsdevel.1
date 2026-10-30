Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331905;
	b=gDRavRCfxOBIqaUwTm/NnzCiLacRG/j4PVl+qivTpdn7jjGckNi8cjVS53EHht81SmDb
	 6d0o6qlWUd671lRgTgrnRccwOaBKjwAWW5lbPr2SRlARaQHcXtuRsJ50LLhs2r8qzh2F8
	 QCUlSOeXO00MeRN3PP54FOlmxV7mBcoLvO4d1hN9XGkN+0SIMZ0pMZ0p+i40arCTW5poA
	 +dxpM8GQTVOp7kmJc05dsYfT+CpKYqiRCsIqtLTe8t+LGitoCsgD3zu4jvJbHE8yHfXWE
	 4/5Z+Am1Z3qsedJL5bq5Apgbt3YyYv6vY+slcUQWRXAcqlOUZl/KS6YT/hMNClMrRjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=XtTfodCHuVaVxXQYCj+jpdhwMxAv9AL4leDlwu5qJfs=;
	b=E98h/UplKdp0W58rQaekChsvDQgYgkW9qDgy1sxuDhkabTbNPfIbbjRBXCAmJVX+P0FM
	 RXJbI0BBENDpUxjWqPEuUFYjTulWRcvIXBg7NcaDsa4ybcVcvvruyGLxj4yszUxZjhxTE
	 zXg81Fi46ltbd0QqoX3xQgWfOH5RQ/5fSzokyyNTRJ+QltLChOdRGa4URNzyuqRB6l8/6
	 OUnQzeicpiJFvFP1kdPmadqAAyr/OK5sB+yqr3ql4j7KLVB/C5E835rkkyKUXlTgT9deG
	 Z8RowjeCgDDe6MZlCPTAiFhWAJXZHdf41Z0TEEjCaBdpirlh9YCPvwuXQ14LrXzS6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PABT4ghd;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3F606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 03:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PABT4ghd
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso504530eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793331905; x=1793936705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XtTfodCHuVaVxXQYCj+jpdhwMxAv9AL4leDlwu5qJfs=;
        b=PABT4ghdsdEaAbxcck22S9YOkFFbrVGSoysOtNnGZC6p4e7k7dwv+OQSy6q+Y7/ejd
         svT7Y+G4XctRZwkKrKiOlnL0z6qn498DowhfqQpSx3pPIgemwYeenvzjr/UR8UYTIGvg
         yGw7Bb+x7/rAn32XqGuhPBo6wzlnuJ7o9PYuUWBkwU2ZMuK0OdQDrWB6qdvcKI1FjZ/N
         Trx/MBJbben51Spfts0XgjAxjitB/Y10m3JExk141IdJpppfD/C+jEyf/3kHd8pDuVkh
         J+PWZ5Mq8iVOpn0rEzmxuDI0+MP+jCzbqF6wVYaQ4+qHk39AZGNgWE/uRzWj+ZmjGJCf
         ehfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331905; x=1793936705;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XtTfodCHuVaVxXQYCj+jpdhwMxAv9AL4leDlwu5qJfs=;
        b=1jWk6xX0ogsTsEpx2CN1WiMLmyMbTJYxNIuIFpp1m8wheJyG+nZJhTa5Pr3F/dHjwU
         mYfV3g9eju7FF4pzV1DRSb6OZuPFi8pHepQEJg4fEkc69PgQxINWmwLOJimj3pQgHUvw
         uJJS0boEeUq/RXJfv4hOMGw2SHrU2UndptxUAJ+poMjwiC3rkFGLpF3v3FhzxukfI+15
         bykB1krRoXMJ6T4o30BAdqAofewgTd2SZ/GRT50EuYTnB5WQ5iIgjaZsoMkc4HD5d15A
         Wh+8KqZITJeAR87DAa2do145+QXDmNM35aE0PGN2ldhyOm75mw3Zn/EI8ZHsqH2i3hhg
         mX5w==
X-Forwarded-Encrypted: i=1; AKwUvBxbjvmeBv6xWZzPK5HDxTcKAWpdW7hUMZl2zcRznLcBCNMhvSrJIMV3P1cP0REQHnGI7+F0krjKwwzw3plB@vger.kernel.org
X-Gm-Message-State: AFq9FYLsAV7576w8UgDkqyV3b/3tH0prx49BSbomasU5Nb+66+QquNKj
	Vn+qv7dFWTxSOOgvJWD4ZQVQVLgdGcqZegxcLJtopnqxYgXvN8srSEM0
X-Gm-Gg: AYBFou38ErvTafixhr8zzFCk9Q7H6Nu4Ly2zof09x0cx5sig3E1QJ0udz/LIZCc10dp
	vCh/lkEnMR09mcsKhxROObNi6aKM+asx4BjO66FQVlKvGFIOG1QP7XGFxAcais+Vers1gul9Nnm
	iCioSUgt1EwfA5CHb9lV4tqduet2UqWWR6xn4gcE/TD9lzvkSPNfAd8v6T37v1LRnNwFwWF6Mt2
	Eg1v49Orv0c81zQD52rWiCmmGeJBz96oMERwtx4CmCE35906N3g1Ii4uuU1QY0W3zhGTp7+rOgy
	NEIXfqhsO7N0l2yQQ58xvq4gdCMrq/wYzUcUNulvbzIPRCy3eNngJfqaDRI2CTscrWjLWt4gCK7
	qb2+HPGkep6DipSJ+HLmkyCuPcBgi3pHZF85NK0cfX3FYIc5lQFaugpVitwWMF5SqWoEwRLXEKk
	DNctD6qKf6PxdpFzryDpg8mz73Ded5MEf+1fny0LAyMSGD364EtufSimUSwUfp7BKvVTYv+pVjC
	bx7FlPfmM7BkZnnwAT1jz5TWX+NnTQqyixLe2tv5CEnJHIQtzrLf1QXCbz7810v52ivhenzVgH8
	hUSC3r1Y9OcHj8uSDvV+8Kie
X-Received: by 2002:a05:7300:c8c2:b0:36a:117:522a with SMTP id 5a478bee46e88-36a423bf71cmr1949263eec.22.1793331904245;
        Thu, 29 Oct 2026 20:45:04 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm2836585eec.5.2026.10.29.20.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:45:03 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 29 Oct 2026 23:44:57 -0400
Subject: [PATCH] mm/shmem: remove truncated folios from the page cache in
 batches
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
Message-Id: <20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com>
X-B4-Tracking: v=1; b=H4sIALkS5GoC/x3MQQqAIBBA0avIrBtQF4JdJVqUjjkLLbQiCO+et
 HyL/1+oVJgqjOKFQjdX3nOHGgS4uOSNkH03aKmNktriem2YEtaYKOGV/Y7rcrqInqRU3joTFEG
 vj0KBn/88za19Dg1HF2kAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

truncate_inode_pages_range() takes the folios it finds out of the page
cache with delete_from_page_cache_batch(), which takes the inode's
i_lock and the i_pages lock once for each batch of up to
FOLIO_BATCH_SIZE folios.

shmem_undo_range() calls truncate_inode_folio() on each folio instead,
so filemap_remove_folio() takes and drops both locks once per folio.
Truncating, punching or freeing a tmpfs file or memfd made of small
folios, such as a large /dev/shm segment, pays for that on every page.

Clean each folio up as truncate_inode_folio() does, collect the ones to
remove and take them out with delete_from_page_cache_batch(), which
needs truncate_cleanup_folio() outside mm/truncate.c. Swap entries, and
the folios kept when undoing a failed fallocate(), stay out of the
batch. Dropping an 8 GiB file of 4K folios, median of five runs,
averaged over two boots of each kernel, in a 32 vCPU VM:

                        before    after
  ftruncate() to 0     1163 ms   913 ms
  hole punch           1155 ms   914 ms
  close() of a memfd   1161 ms   914 ms
  unlink()             1162 ms   916 ms

Files of PMD-sized folios take 20-25 ms with or without this change.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
To see it, fill and remove a large /dev/shm file:

  fallocate -l 8G /dev/shm/f && time rm /dev/shm/f
---
 mm/internal.h |  1 +
 mm/shmem.c    | 16 +++++++++++++---
 mm/truncate.c |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

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
index af21a89abb0f6..16b6e38503bc3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1352,6 +1352,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
+		struct folio_batch remove;
+
+		folio_batch_init(&remove);
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
@@ -1363,9 +1366,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				continue;
 			}
 
-			if (!unfalloc || !folio_test_uptodate(folio))
-				truncate_inode_folio(mapping, folio);
-			folio_unlock(folio);
+			if (!unfalloc || !folio_test_uptodate(folio)) {
+				truncate_cleanup_folio(folio);
+				folio_batch_add(&remove, folio);
+			}
+		}
+		delete_from_page_cache_batch(mapping, &remove);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			folio = fbatch.folios[i];
+			if (!xa_is_value(folio))
+				folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
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
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261029-bug-mm-shmem-undo-batch-de001d9c6f1e

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

