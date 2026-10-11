Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F739C00F
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718190; cv=none; b=bBX03cAUzR8aFqyaBj4nwDzfrhdQJjwbNBto+6s3r2h9124H9SuJED57ef2PEl8JwzSNEj2/ynFp31mrhG1zyh7e2cK6Na6lVBJ0EcMMVx0bT8s96tI4k/DA8Dd0jijGxHrYKYiXl6aooJ26YLHIb6gJRcm2e26vn2z23zVDzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718190; c=relaxed/simple;
	bh=gAL8T4h+HBYQA5Bvh/Z/nk8McyOoNQ2RxR8PtExl584=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDOdOaU+C43if2g9q2IzJd5JhIr9vrMN1jpdIgDf1slMWx617ar7M3obKiINQcZL26siMK6FKmOY7GGQTzh3tIUx6Jp1Vsk18A2hGbnfU3sjaNpinuZxOhoeYPsfKCMPP92env3aC2dxyTAw21zxRHlgx/chqi/IMWnAerYYNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxPInLPx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxPInLPx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d032846c95so8031525ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791718186; x=1792322986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8upKFc4zwF7GAlleDsmhpQF6jhE16xCYO/bJ2qmSMQ=;
        b=bxPInLPxuCoXqW8OGyPwkSTqBNrLxYZfhEsGfVVCw9TOstR1616Yd3gzwSXnhfjh2S
         EiADYgdJ75re/vQY1tmBCAonr7G1tEMf//HCLL/CcMA0yneLTnvz+MjhSpY6vFr8TKzT
         tbXPOtSUwy56ixzZLH8HaR5I3Vb5XCma53F/fYGkwuTARHlyWrujC4VWRLqWEyheawWg
         80JgGjHFnamyKPnxhgPwRXQrlNiHYYTztiSGGolYQbM76NaEStxXSVnBQ3ezOvvcySEs
         7Rh5F4XIiw8EM/02IgRfLpTIB4YoU7+WrbwKo7a7ZiJmEKEUNCLk5e9XZRor1qpfFdSp
         uCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791718186; x=1792322986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8upKFc4zwF7GAlleDsmhpQF6jhE16xCYO/bJ2qmSMQ=;
        b=ytlMdzr59KP7fqP/RPVv1wKj7Dw+sy8lZgFW1HCazlb4fGqoO826pCGg2Pw7tsvH74
         a4fOxJkAe+lVRGMrnel94nLTDJLqZZ2uQlsieYXrZQi6WKyGaWFwnn6pi2BBmjr+wJ7I
         UJT0avc4ilnmGUDtQ8m9tJOOo8Z8PgJjRsC7JjDGAfO4/wZ2Q+2+sF2jjjjn1mckOePV
         PJvcrkSt/GfZmAz0QS9UNCbhDM4C1L8XJzWOG4zyOWUaaN5wFlCogHJg0REiulf+p2JH
         Og6MO1eT2ANaWBWyUfY1fggSYu5Czl1kcSG3MQWjlbZ1f1kpYuiiYImxtunugUxB8QmI
         HOkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlO5Iaux7G6beCLcM9UsNobdDd5AaT1oC8gnysz4eh+ukUukOzc77KIVxKcHWnIyA9W5fvhDq7YmJVk09s@vger.kernel.org
X-Gm-Message-State: AFq9FYJNEEYs+Kwuo17cG5kVA3QiFXH+m5YpMRtOEOqBEYzpu8Ise4sj
	BoTeSIS1XA5u5XlQkS14ZwxmoMQHqXdw1ndco5cjg8f2W1UFk45DiftO
X-Gm-Gg: AYBFou3PJjCtyU9ghPhuu2qGDfV0U/TnWcdXu5wm93/FhfmbYyWJ8FVFQsI8782swrn
	4mUNgZMAeoMU2csy4q6u9dH62/A1epMVt+3mqaGQr3SOaHDAqdOSEVTUrhuHpRPgoeonSTjMFhr
	xZDpe53m80hUl4DtqI8BirloM+npEByh3oxBxEHDnreyPv5FrqT8UPRdhy5gmZclHE16smgkZ2P
	RjZsKAtrAiuvKQk0Kwb4xMy6N7A2sGGCc7ou7af2nqoLKW2Cy80b24gR2Ds6Tn/PV6JD4lm7KU7
	gzcKNcX9Kl2Zdbn+jSRD5uvxWxrFH+GFdnj/BRMkIXLkUwJ4ep6c9gWGsrS2Tzzs26pGKTk2b/S
	OSwYLHE+FCE4tMXQyzdySSfHkF+yzWzKPvLRfgxd8orvTteMHrq6J1gcpwZQglij63qVJsIq5bC
	bQNVgSCc+Us00UXzYJxW7emtz2hX7/RrsOScp06dwZjVzh2iY5Psu1oyC+VKLC1qwMYYrSCuuy
X-Received: by 2002:a17:90a:d2c7:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3ab3a33da74mr5986183a91.1.1791718186275;
        Sun, 11 Oct 2026 04:29:46 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16c8::245:79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab397920b4sm6957832a91.4.2026.10.11.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:29:45 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Subject: [PATCH] mm/filemap: mark lockless accesses to mapping->nrpages
Date: Sun, 11 Oct 2026 18:29:40 +0700
Message-ID: <20261011112940.455497-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mapping->nrpages is updated under the i_pages lock but is read locklessly
as a cheap "anything cached?" hint, e.g. in invalidate_bdev() and
mapping_needs_writeback(). KCSAN reports the race:

  BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev

  read-write to 0xffff8881004c4178 of 8 bytes by task 3600 on cpu 0:
   __filemap_add_folio+0x6b7/0x910 mm/filemap.c:919
   filemap_add_folio+0x1cd/0x380
   page_cache_ra_unbounded+0x1a4/0x3a0
   ...
   blkdev_read_iter+0x21e/0x2d0
  read to 0xffff8881004c4178 of 8 bytes by task 3601 on cpu 1:
   invalidate_bdev+0x25/0x70 block/bdev.c:98
   ext4_fill_super+0x2ccb/0x37b0

The same counter also races with filemap_write_and_wait_range() through
mapping_needs_writeback().

The race is benign: a stale value only makes the caller do or skip a
harmless invalidate/flush pass. Annotate the readers with READ_ONCE() and
the writers in filemap with WRITE_ONCE().

Reported-by: syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0624b5bf72b99131402
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 block/bdev.c | 2 +-
 mm/filemap.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..d97071160e86 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -95,7 +95,7 @@ void invalidate_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_mapping;
 
-	if (mapping->nrpages) {
+	if (READ_ONCE(mapping->nrpages)) {
 		invalidate_bh_lrus();
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..007fe10b2e1d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -144,7 +144,7 @@ static void page_cache_delete(struct address_space *mapping,
 
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation lookup relies upon it */
-	mapping->nrpages -= nr;
+	WRITE_ONCE(mapping->nrpages, mapping->nrpages - nr);
 }
 
 static void filemap_unaccount_folio(struct address_space *mapping,
@@ -314,7 +314,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		xas_store(&xas, NULL);
 		total_pages += folio_nr_pages(folio);
 	}
-	mapping->nrpages -= total_pages;
+	WRITE_ONCE(mapping->nrpages, mapping->nrpages - total_pages);
 }
 
 void delete_from_page_cache_batch(struct address_space *mapping,
@@ -631,7 +631,7 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-	return mapping->nrpages;
+	return READ_ONCE(mapping->nrpages);
 }
 
 bool filemap_range_has_writeback(struct address_space *mapping,
@@ -916,7 +916,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (xas_error(&xas))
 			goto unlock;
 
-		mapping->nrpages += nr;
+		WRITE_ONCE(mapping->nrpages, mapping->nrpages + nr);
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge) {
-- 
2.43.0

