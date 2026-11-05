Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881943;
	b=JDHkGuDqH3aLuAoDtFDdnQ3YX0gtx07xol725kW/5+Gq72i6dm4QuNVcAci/BrkMC7aj
	 NWBdXO90i7HsLdjjoVVwSmav1cBRCuhzYOGa1PEUSEwZk4WR9GRMbpSCOraFD/ro9xWEE
	 cbjLqsXm9fTaKplNqwF38zYwt0RNT5kuG3v8Z7ZhlP48aV+ZSzk1JeeeNnfbmg3M21krT
	 v+DgshgkLDR6Eu/c6jjy9hjnkJ7ClSqdSENOhP/Ve7EYgpakmDwVE5Z7C8qOnsGmHu25v
	 c/pbiIoZ2LgQYh1MyazsTjieuSn+emIVyfVTP5aj9AfxNXRGNd/bjPBQdXzB54AXdzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=bKGuzAUaHML6wkJsYB/5ryGtpKz03dwMg3XqSc0JR10=;
	b=5tyX4crNPJmyqsDyzE+ILMd9BpcLXLPVb6Ni8jlnsP77fxCW5qndIpMyW14TWNE+MQxx
	 yYnlZPujEIvk0nxxOY1PwyrgMx/bY1zoVeedp6Lg5HMSwJB2EiUsuyJn9fO2GfopklOGN
	 /MmL2E/4q4Ri4s5mYpbG0H06pdigZD9DFIpDawQHoqNCNdcNrx0IbWzWDsWg6rNufEHk/
	 F69m42MY4vf3ZkyLxjJQm27oabYBY88NKYXQIBqK6cFBYer9jviLS8IzY4OMi0CUiPVo/
	 RILHMXiLahMkkydtCs3u7AZrEnQSUu27MYii6lauzOua1agELAYivi12rX/3MPnbz6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsiszkq6;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560A606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 12:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D560A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsiszkq6
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3043286eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 04:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793881942; x=1794486742; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKGuzAUaHML6wkJsYB/5ryGtpKz03dwMg3XqSc0JR10=;
        b=qsiszkq6wgIIY5dymhJ4OwntnzIgN8ILM1ZAEE82nyw6pVYBkmwXLfW/TcMzLKdeCU
         VjnQTl3z0Ke0lsEJoO1TScDJznH3zSPY4btbU/84M7l+VQRH87B4HgDBswDI0RqkcBlH
         +vF4U8R4NScWGa3kgCUUEaGhFH2id7qOTlf3Fa7agxAhg3D0T/eCUFf5E4IWS/aJ39+c
         4HWDap0OM0za/fAKrPsDLgFgpO4OtMjFmHz8siBZK8tpHKygxrM5X1DQVZjGwhwpPoKp
         WbpZZsmJDRztlm1b8qS3z1cvMuOvA8GeQ7s6vKrsxeeR03HvyaI/3m8bI8/RpyYE2uZC
         hGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881942; x=1794486742;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bKGuzAUaHML6wkJsYB/5ryGtpKz03dwMg3XqSc0JR10=;
        b=URALnR+9lmo4XJRmmPeuRiwu5/prvjNdOFZV8aHH8lo5X7SoC9dkkxPD0cBtOg2R0o
         RWqBJXI3ICtjEBjh3ftQL0daapAClqVLPpQOZhz5x1kxMCeNb+qsfEvL03cNLHmbmaqe
         iPus8pOzcRENHif0MMS39s1SEqX8mOglvit5sGANYD2Boigc6fMDKyUBqgF2ma7I/cFL
         hBra1nj0fzd05bqtCLeB2XbcRCicKFKJiL5WHKG+7BWjSRKE73UAIwz7w2adi/QMKdIh
         JEdTF5oxHrxhFROjQDgijnxAg2EdtW9ZxU01oJlb4SlQ2Yx7uqmMSeLjhAjHJRxNdHL6
         I5tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBiiUM73SSAu/YAY88FsipZfSS+KJnIs0QYaF4iBK0fsjseSVucX4LoP/N7YO9UFyetECegyAMtOSQssW9@vger.kernel.org
X-Gm-Message-State: APuU4Z9p2lt9J7hMRoo+1k8BDp+i6+/8o2ucM1oDwDpXh6lLZcG6bcaN
	wJDAxwXt7azaLRzhBYzlXVjO/3aMjxfXIwNRPCn8XE9vNmsTNQ6KTUk7
X-Gm-Gg: AYBFou1K+57psiCx3Mm5TbjkNNq6+yd9Rq4O2dq6I7PuiAqQS7NFTJkmTzjtDX6VVvt
	ho5pFg+UeQgOXzZcFefvPt9qR6nrtYcRIzmu6tYgoM8ogNuVwZGBGVKJiv8hfDFDNxDvwO48Jqa
	9qg3BE+tiRuS9GqkpTzxCUAbLoiVeXgXNj9JRqkHD6YvaEWQ7FNsOi0YfVq6WoAic5QYv0LfqTC
	MSBMIUtX+7mtHRRwyVUGgeuHj9ei7D14GyUOCPbuiI5/RWZg4DjH2ut5MAPzA+Rhdjs2u/w3+oO
	+EG0YqMHY7TBfhObCmlkuUKuIhJYLGjsYFHcN1p6s5bQhtQ9YamS5MbTeK65eZJ7jeQ+1TTzgGe
	tB+xocWdStee5DWVFx1cN382xYJsmj1SwTD2kqLY8KjiqAr4ZCFCcOOzSu/RA1eXLVBIkV3prO0
	nbgbIPspi9yTwLaAZweYaY54IFNrBeUrzFKZ45qVYYJ+uoUL2mlI3NtHM+IZXxcnBVf+dv51wov
	m3KqKiGCIdkACecHu1NM2rKsESCB6rdDTr3fi+A5ot2x64mKjKXke1KQZJwzjoEQoARLMEjD1Fv
	DarHg5mRanqE7uDLdO/C8Vzpu3vZiKSCb+saOONWhWZHG/s=
X-Received: by 2002:a05:7300:de06:b0:36d:2b02:86a6 with SMTP id 5a478bee46e88-36d2b028b7bmr5063810eec.4.1793881941559;
        Thu, 05 Nov 2026 04:32:21 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm21742977eec.23.2026.11.05.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:32:21 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 05 Nov 2026 07:32:11 -0500
Subject: [PATCH v2] mm/shmem: remove truncated folios from the page cache
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
Message-Id: <20261105-bug-mm-shmem-undo-batch-v2-1-ae5f89ced044@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEp37GoC/4WNQQ6CMBBFr0Jm7ZhOVRRX3sOwgHagk1hKWiAaw
 t2tXMDle8l/f4XEUTjBvVgh8iJJwpBBHwowrhl6RrGZQStdktIVtnOP3mNynj3Ogw3YNpNxaFk
 pspUpO2LI6zFyJ++9/KwzO0lTiJ/9aKGf/d9cCAkvVXs6a9IdX2+P3jfyOprgod627QtJLB9xv
 gAAAA==
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
  ftruncate() to 0     1150 ms   917 ms
  hole punch           1165 ms   919 ms
  close() of a memfd   1153 ms   921 ms
  unlink()             1152 ms   921 ms

Files of PMD-sized folios take 18-27 ms with or without this change.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
V1 -> V2:
- Unlock the folios after folio_batch_remove_exceptionals(), as Jan
  suggested
- Rebase onto v7.4-rc1-132-g05441d697f7f and update the numbers from a
  new run

v1: https://lore.kernel.org/r/20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com

To see it, fill and remove a large /dev/shm file:

  fallocate -l 8G /dev/shm/f && time rm /dev/shm/f
---
 mm/internal.h |  1 +
 mm/shmem.c    | 13 ++++++++++---
 mm/truncate.c |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index af21a89abb0f6..2e51cc9c4c24e 100644
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
 
@@ -1363,11 +1366,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				continue;
 			}
 
-			if (!unfalloc || !folio_test_uptodate(folio))
-				truncate_inode_folio(mapping, folio);
-			folio_unlock(folio);
+			if (!unfalloc || !folio_test_uptodate(folio)) {
+				truncate_cleanup_folio(folio);
+				folio_batch_add(&remove, folio);
+			}
 		}
+		delete_from_page_cache_batch(mapping, &remove);
 		folio_batch_remove_exceptionals(&fbatch);
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
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261029-bug-mm-shmem-undo-batch-de001d9c6f1e

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

