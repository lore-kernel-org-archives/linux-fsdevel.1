Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA028376483
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310243; cv=none; b=sJMq461FruSPtfqgTC2lDjW5Yy0scHddGDGsXWqjjk97mePoZJI64dzRAbHWovFlUzoqngEj+wtWTatYHXz8/w7pcGjrS83OhvI2QNZN3bvN2QtlDOFmEHpc7nOlk/lm8ycri9dPGt5fbeSHLeCG3PeR8OWmDZY+wJierKESQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310243; c=relaxed/simple;
	bh=aDZzeo5Mi+iWDTXHP87oOV9B/u/ZkW223gf3svvT4DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thFpZ4/CzMT7Njycak6bJ4aIkgiONMGBvZIco5HEmcjr25p1RQYh7eMsf+dNu497S8Ff5ARMSswG3NEs04aN6i1C2M5IdJ2hoI62DwrFMsqGwgLBeGLEqqCrk72W0NKtlGUlwnJaSmEvzuJTVryFP4QlgrmhbG7va4ww19gOndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=D/wYsKnw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="D/wYsKnw"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKNxds2144860
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ODDt
	SnyLEU7DCkKG4fZ6y/+r7g+oLCksOr+Ja3KX/vg=; b=D/wYsKnwKqHAu/G4yEwE
	8v/whTz+u7J7NgdYQLUlE5hyc9ncjQhJd+eQXOKZHnG1LzEj4ykTArcvKLJxRFsG
	z/H5zchIlX2LTAJpm/Xi+/AptxRnQWB+4SOi+Nt+k5TWUsF18zx3lYhTNcuC058u
	f7ZXc7Q7zWVSCkgOiTiHDTh2xRRlKSaYdADvw5BX2qYd+DTtGen+4pB4rgWPOKXE
	H0R38nvO7Mk/FsZhPlRHCIiXTM3RHW9PFpK3CXj/tAmSE4lazH9AnEkX8jwKnzEI
	KrdLVsx3zKFHrc0Ni0MqDTA/oTHN3EWh1r+lmDz7BnBVwGqQzIBf6ptulthHRJe8
	Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e9ccqvatb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:39 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-913dbb7a318so1319443885a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310238; x=1779915038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODDtSnyLEU7DCkKG4fZ6y/+r7g+oLCksOr+Ja3KX/vg=;
        b=b60B0exxkOWSsJyGSNcEc6O1MtIAZI3SK8BDW6AfK1hRpEbsIVFYX2PxMcW26tRlRX
         RwgECluRjeBOPP19ukYKVIkRqfPTFBggPtcaqOFrwOBP1YxR1rsa+nw2bT5BhFDRYr0L
         55+4MwGcxZryf3hyhs6g0fwfFx9Hxf6TrTo8+xOeeimIt4cOVCvgGOD96NJIx/vQndTc
         +sjMkA9XAxmbS+KwvKOdfN1n2Hpz26w/mzTFFe9Ikue5t2uh/0+7HnOapdy+3BKx2MLk
         RUDKTA8gHBpW6xWUKCSvRh9YFAl7U9JTPIW16HWvZo+XIh/wcCyRqx69ytWAZzR/dctx
         B5yw==
X-Gm-Message-State: AOJu0YyeeYJqAhNjtLE1vQVr8zcMZPflDiRPsnMlJSHNsVz1hmZr5cRe
	kxAkns2jh1yKaMVTWBfNnnkC2Zb8huPTqCeOs6i9Qbo1trND59H/1LEY7GvQE2jgYoQhEXRIWUB
	2uCPJ3GO4JJKEUnsymkVl+PsvFGb7woBkzFloaJ0W90PqbVrWDkrxWD1Ea+ZHmS8=
X-Gm-Gg: Acq92OFK9R8FRz8WXKBh1AawGOUDhOhrSDjWGMsBH90CQN/N28qoknZsNzIRZbsd+oy
	3ZT7tjFaiGgO/7HMdZ35ZXYMOZ++s4q7dk2Ag4F2Eff+meeXUhzuG7TlANKztARAQgnwbPkd6iW
	SZhuVP+liZsfSSacJXKkRqsFBW0LB4obGN2rl6K7dNEXo0/wjk4ByUOwV1v/ImSlN/h6QrwRSVD
	iqAXyqv0Sf/4nm29X2Zc4trd/1d7Ueh1oW45zNFNE/5DsCm39IzjN0EujboTqAgmsYfstujoEGb
	9ZIY2y5FTuy9o1isuswGjwYhWQzKiIPyP0En7RqcQrqlLV6j/XLp7SSbUCjEtfrXniiWiRzhr88
	bnl4SEdhWOfekjrQL8W3Br+D6caiuE8Hq5/EfTKQx8xHE89xI547W62hvTAdOcKezH9E=
X-Received: by 2002:a05:620a:7007:b0:910:1c85:4adb with SMTP id af79cd13be357-914a23e8b89mr7187085a.37.1779310238381;
        Wed, 20 May 2026 13:50:38 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:910:1c85:4adb with SMTP id af79cd13be357-914a23e8b89mr7178985a.37.1779310237661;
        Wed, 20 May 2026 13:50:37 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:57 -0400
Subject: [PATCH RFC 06/11] folio_wait: rename wait_page_* infrastructure to
 wait_folio_*
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-6-c36ddc2b6cf2@columbia.edu>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
In-Reply-To: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=14769;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=aDZzeo5Mi+iWDTXHP87oOV9B/u/ZkW223gf3svvT4DU=;
 b=K/IvEz0ljqCKFsEXd6/c9iMRpBI68QFsqc4QJ8G5LG1XjBYRvOcrIrxvtfDjj0SmplV8GixLH
 XbNu0wXh//SDtN5tG2fTm2nmdnyfS+p/55kDFbKQu5TtGb6Uia74u6j
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=XJQAjwhE c=1 sm=1 tr=0 ts=6a0e1e9f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=ygHQXE4GxI9NjKAxWSYA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2qKJXbazlwdGD-zUTTgqB09yEkJ3i8H6
X-Proofpoint-GUID: 2qKJXbazlwdGD-zUTTgqB09yEkJ3i8H6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX404qfhTnCUal
 /c1D2zge9Iu9AAx2DLIF8yaKXv5/6OFslYDX15utRJY2F7uAvszLpVo0FHIWFx7nUC925XTG3EW
 y42Ums0HRSC9TXgnz7zKuweXIYD4a7w75cO/Ozwl1XCrGKaOVjU+20KgqkEkFiYYHI3sXgXOqXR
 s+rbl9zKJq7JFFYJnfSbpycJIt8ClQjRxiVoLsuTlHWwzk+uR446/XQbbObgVi7oVbngzPkr2c1
 unVHwg5MWdw4fWBzHV7qs1FM2PeJADZAAlTSUH39bmoUCEdSGvJHShnN5bl/eONQkdx1za9zQGc
 jy87aKOFDejTJXplLL+Rml6u9R/5YzIu1sU93mm3wEQHegV3+IU+8AzUEaq+e1esDuVzVc2CrUE
 +anwHDykqvg3gc7VD6ARglJcI8FUpWcTrXebkraR2WdMZk90Iu8JOQEdFTGvsfuv5JOkqN4wcI9
 exrFOQw3fgql6dVhxMw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=10 suspectscore=0 spamscore=0 priorityscore=1501
 bulkscore=10 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

The folio bit-lock wait infrastructure still refers to "page" in the
names of its core types and helpers, even though it operates on folios.
Rename accordingly:

  struct wait_page_key           -> struct wait_folio_key
  struct wait_page_queue         -> struct wait_folio_queue
  wait_page_key.page_match       -> wait_folio_key.folio_match
  wake_page_match()              -> wake_folio_match()
  wake_page_function()           -> wake_folio_function()
  PAGE_WAIT_TABLE_{BITS,SIZE}    -> FOLIO_WAIT_TABLE_{BITS,SIZE}

Also rename local variables and field names, such as io_uring's wpq ->
wfq. Update relevant comments as well.

While at it, update io_uring/rw.h to include folio_wait.h rather than
pagemap.h.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/folio_wait.h | 16 +++++-----
 include/linux/fs.h         |  2 +-
 io_uring/rw.c              | 14 ++++-----
 io_uring/rw.h              |  6 ++--
 mm/folio_wait.c            | 74 +++++++++++++++++++++++-----------------------
 mm/internal.h              |  2 +-
 6 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/include/linux/folio_wait.h b/include/linux/folio_wait.h
index 57ccf9ffd243..1732df23d952 100644
--- a/include/linux/folio_wait.h
+++ b/include/linux/folio_wait.h
@@ -6,26 +6,26 @@
 #include <linux/page-flags.h>
 #include <linux/wait.h>
 
-struct wait_page_key {
+struct wait_folio_key {
 	struct folio *folio;
 	int bit_nr;
-	int page_match;
+	int folio_match;
 };
 
-struct wait_page_queue {
+struct wait_folio_queue {
 	struct folio *folio;
 	int bit_nr;
 	wait_queue_entry_t wait;
 };
 
-static inline bool wake_page_match(struct wait_page_queue *wait_page,
-		struct wait_page_key *key)
+static inline bool wake_folio_match(struct wait_folio_queue *wait_folio,
+		struct wait_folio_key *key)
 {
-	if (wait_page->folio != key->folio)
+	if (wait_folio->folio != key->folio)
 		return false;
-	key->page_match = 1;
+	key->folio_match = 1;
 
-	if (wait_page->bit_nr != key->bit_nr)
+	if (wait_folio->bit_nr != key->bit_nr)
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bb9cc4f7207c..cd5088dfe9a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -390,7 +390,7 @@ struct kiocb {
 	 * waitqueue associated with completing the read.
 	 * Valid IFF IOCB_WAITQ is set.
 	 */
-	struct wait_page_queue	*ki_waitq;
+	struct wait_folio_queue	*ki_waitq;
 };
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0c4834645279..fc87baac1911 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -763,14 +763,14 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 static int io_async_buf_func(struct wait_queue_entry *wait, unsigned mode,
 			     int sync, void *arg)
 {
-	struct wait_page_queue *wpq;
+	struct wait_folio_queue *wfq;
 	struct io_kiocb *req = wait->private;
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
-	struct wait_page_key *key = arg;
+	struct wait_folio_key *key = arg;
 
-	wpq = container_of(wait, struct wait_page_queue, wait);
+	wfq = container_of(wait, struct wait_folio_queue, wait);
 
-	if (!wake_page_match(wpq, key))
+	if (!wake_folio_match(wfq, key))
 		return 0;
 
 	rw->kiocb.ki_flags &= ~IOCB_WAITQ;
@@ -783,7 +783,7 @@ static int io_async_buf_func(struct wait_queue_entry *wait, unsigned mode,
  * This controls whether a given IO request should be armed for async page
  * based retry. If we return false here, the request is handed to the async
  * worker threads for retry. If we're doing buffered reads on a regular file,
- * we prepare a private wait_page_queue entry and retry the operation. This
+ * we prepare a private wait_folio_queue entry and retry the operation. This
  * will either succeed because the page is now uptodate and unlocked, or it
  * will register a callback when the page is unlocked at IO completion. Through
  * that callback, io_uring uses task_work to setup a retry of the operation.
@@ -794,7 +794,7 @@ static int io_async_buf_func(struct wait_queue_entry *wait, unsigned mode,
 static bool io_rw_should_retry(struct io_kiocb *req)
 {
 	struct io_async_rw *io = req->async_data;
-	struct wait_page_queue *wait = &io->wpq;
+	struct wait_folio_queue *wait = &io->wfq;
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	struct kiocb *kiocb = &rw->kiocb;
 
@@ -897,7 +897,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 			return -EINVAL;
 
 		/*
-		 * We have a union of meta fields with wpq used for buffered-io
+		 * We have a union of meta fields with wfq used for buffered-io
 		 * in io_async_rw, so fail it here.
 		 */
 		if (!(file->f_flags & O_DIRECT))
diff --git a/io_uring/rw.h b/io_uring/rw.h
index 9bd7fbf70ea9..22e9f77c51d6 100644
--- a/io_uring/rw.h
+++ b/io_uring/rw.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/folio_wait.h>
 #include <linux/io_uring_types.h>
-#include <linux/pagemap.h>
 
 struct io_meta_state {
 	u32			seed;
@@ -19,11 +19,11 @@ struct io_async_rw {
 		unsigned			buf_group;
 
 		/*
-		 * wpq is for buffered io, while meta fields are used with
+		 * wfq is for buffered io, while meta fields are used with
 		 * direct io
 		 */
 		union {
-			struct wait_page_queue		wpq;
+			struct wait_folio_queue		wfq;
 			struct {
 				struct uio_meta			meta;
 				struct io_meta_state		meta_state;
diff --git a/mm/folio_wait.c b/mm/folio_wait.c
index 8d8237cdd73b..70f808729f9c 100644
--- a/mm/folio_wait.c
+++ b/mm/folio_wait.c
@@ -20,20 +20,20 @@
 #include "internal.h"
 
 /*
- * In order to wait for pages to become available there must be waitqueues
- * associated with pages. By using a hash table of waitqueues where the bucket
+ * In order to wait for folios to become available there must be waitqueues
+ * associated with folios. By using a hash table of waitqueues where the bucket
  * discipline is to maintain all waiters on the same queue and wake all when any
- * of the pages become available, and for the woken contexts to check to be
- * sure the appropriate page became available, this saves space at a cost of
+ * of the folios become available, and for the woken contexts to check to be
+ * sure the appropriate folio became available, this saves space at a cost of
  * "thundering herd" phenomena during rare hash collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
-#define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
-static wait_queue_head_t folio_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
+#define FOLIO_WAIT_TABLE_BITS 8
+#define FOLIO_WAIT_TABLE_SIZE (1 << FOLIO_WAIT_TABLE_BITS)
+static wait_queue_head_t folio_wait_table[FOLIO_WAIT_TABLE_SIZE] __cacheline_aligned;
 
 static wait_queue_head_t *folio_waitqueue(struct folio *folio)
 {
-	return &folio_wait_table[hash_ptr(folio, PAGE_WAIT_TABLE_BITS)];
+	return &folio_wait_table[hash_ptr(folio, FOLIO_WAIT_TABLE_BITS)];
 }
 
 /* How many times do we accept lock stealing from under a waiter? */
@@ -53,14 +53,14 @@ void __init folio_wait_init(void)
 {
 	int i;
 
-	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
+	for (i = 0; i < FOLIO_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&folio_wait_table[i]);
 
 	register_sysctl_init("vm", folio_wait_sysctl_table);
 }
 
 /*
- * The page wait code treats the "wait->flags" somewhat unusually, because
+ * The folio wait code treats the "wait->flags" somewhat unusually, because
  * we have multiple different kinds of waits, not just the usual "exclusive"
  * one.
  *
@@ -92,13 +92,13 @@ void __init folio_wait_init(void)
  *	WQ_FLAG_WOKEN, we set WQ_FLAG_DONE to let the waiter easily see that
  *	it now has the lock.
  */
-static int wake_page_function(wait_queue_entry_t *wait, unsigned int mode, int sync, void *arg)
+static int wake_folio_function(wait_queue_entry_t *wait, unsigned int mode, int sync, void *arg)
 {
 	unsigned int flags;
-	struct wait_page_key *key = arg;
-	struct wait_page_queue *wait_page = container_of(wait, struct wait_page_queue, wait);
+	struct wait_folio_key *key = arg;
+	struct wait_folio_queue *wait_folio = container_of(wait, struct wait_folio_queue, wait);
 
-	if (!wake_page_match(wait_page, key))
+	if (!wake_folio_match(wait_folio, key))
 		return 0;
 
 	/*
@@ -143,26 +143,26 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned int mode, int s
 static void folio_wake_bit(struct folio *folio, int bit_nr)
 {
 	wait_queue_head_t *q = folio_waitqueue(folio);
-	struct wait_page_key key;
+	struct wait_folio_key key;
 	unsigned long flags;
 
 	key.folio = folio;
 	key.bit_nr = bit_nr;
-	key.page_match = 0;
+	key.folio_match = 0;
 
 	spin_lock_irqsave(&q->lock, flags);
 	__wake_up_locked_key(q, TASK_NORMAL, &key);
 
 	/*
-	 * It's possible to miss clearing waiters here, when we woke our page
-	 * waiters, but the hashed waitqueue has waiters for other pages on it.
+	 * It's possible to miss clearing waiters here, when we woke our folio
+	 * waiters, but the hashed waitqueue has waiters for other folios on it.
 	 * That's okay, it's a rare case. The next waker will clear it.
 	 *
 	 * Note that, depending on the page pool (buddy, hugetlb, ZONE_DEVICE,
 	 * other), the flag may be cleared in the course of freeing the page;
 	 * but that is not required for correctness.
 	 */
-	if (!waitqueue_active(q) || !key.page_match)
+	if (!waitqueue_active(q) || !key.folio_match)
 		folio_clear_waiters(folio);
 
 	spin_unlock_irqrestore(&q->lock, flags);
@@ -180,13 +180,13 @@ void folio_wake_writeback(struct folio *folio)
  * A choice of three behaviors for folio_wait_bit_common():
  */
 enum behavior {
-	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
+	EXCLUSIVE,	/* Hold ref to folio and take the bit when woken, like
 			 * __folio_lock() waiting on then setting PG_locked.
 			 */
-	SHARED,		/* Hold ref to page and check the bit when woken, like
+	SHARED,		/* Hold ref to folio and check the bit when woken, like
 			 * folio_wait_writeback() waiting on PG_writeback.
 			 */
-	DROP,		/* Drop ref to page before wait, no check when woken,
+	DROP,		/* Drop ref to folio before wait, no check when woken,
 			 * like folio_put_wait_locked() on PG_locked.
 			 */
 };
@@ -212,8 +212,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 {
 	wait_queue_head_t *q = folio_waitqueue(folio);
 	int unfairness = sysctl_page_lock_unfairness;
-	struct wait_page_queue wait_page;
-	wait_queue_entry_t *wait = &wait_page.wait;
+	struct wait_folio_queue wait_folio;
+	wait_queue_entry_t *wait = &wait_folio.wait;
 	bool thrashing = false;
 	unsigned long pflags;
 	bool in_thrashing;
@@ -226,9 +226,9 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	}
 
 	init_wait(wait);
-	wait->func = wake_page_function;
-	wait_page.folio = folio;
-	wait_page.bit_nr = bit_nr;
+	wait->func = wake_folio_function;
+	wait_folio.folio = folio;
+	wait_folio.bit_nr = bit_nr;
 
 repeat:
 	wait->flags = 0;
@@ -239,7 +239,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	}
 
 	/*
-	 * Do one last check whether we can get the page bit synchronously.
+	 * Do one last check whether we can get the folio bit synchronously.
 	 *
 	 * Do the folio_set_waiters() marking before that to let any waker we
 	 * _just_ missed know they need to wake us up (otherwise they'll never
@@ -256,7 +256,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 	/*
 	 * From now on, all the logic will be based on the WQ_FLAG_WOKEN and
-	 * WQ_FLAG_DONE flag, to see whether the page bit testing has already
+	 * WQ_FLAG_DONE flag, to see whether the folio bit testing has already
 	 * been done by the wake function.
 	 *
 	 * We can drop our reference to the folio.
@@ -359,8 +359,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	__releases(ptl)
 {
-	struct wait_page_queue wait_page;
-	wait_queue_entry_t *wait = &wait_page.wait;
+	struct wait_folio_queue wait_folio;
+	wait_queue_entry_t *wait = &wait_folio.wait;
 	bool thrashing = false;
 	unsigned long pflags;
 	bool in_thrashing;
@@ -375,9 +375,9 @@ void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	}
 
 	init_wait(wait);
-	wait->func = wake_page_function;
-	wait_page.folio = folio;
-	wait_page.bit_nr = PG_locked;
+	wait->func = wake_folio_function;
+	wait_folio.folio = folio;
+	wait_folio.bit_nr = PG_locked;
 	wait->flags = 0;
 
 	spin_lock_irq(&q->lock);
@@ -439,7 +439,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
  * @folio: The folio to wait for.
  * @state: The sleep state (TASK_KILLABLE, TASK_UNINTERRUPTIBLE, etc).
  *
- * The caller should hold a reference on @folio. They expect the page to become
+ * The caller should hold a reference on @folio. They expect the folio to become
  * unlocked relatively soon, but do not wish to hold up migration (for example)
  * by holding the reference while waiting for the folio to come unlocked. After
  * this function returns, the caller should not dereference @folio.
@@ -455,7 +455,7 @@ int folio_put_wait_locked(struct folio *folio, int state)
  * folio_unlock - Unlock a locked folio.
  * @folio: The folio.
  *
- * Unlocks the folio and wakes up any thread sleeping on the page lock.
+ * Unlocks the folio and wakes up any thread sleeping on the folio lock.
  *
  * Context: May be called from interrupt or process context. May not be called
  * from NMI context.
@@ -639,7 +639,7 @@ int __folio_lock_killable(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
-int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
+int __folio_lock_async(struct folio *folio, struct wait_folio_queue *wait)
 {
 	struct wait_queue_head *q = folio_waitqueue(folio);
 	int ret;
diff --git a/mm/internal.h b/mm/internal.h
index a121ca07f75c..21b0f4ec2478 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -105,7 +105,7 @@ void page_writeback_init(void);
 void folio_wait_init(void);
 void folio_wake_writeback(struct folio *folio);
 int folio_put_wait_locked(struct folio *folio, int state);
-int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait);
+int __folio_lock_async(struct folio *folio, struct wait_folio_queue *wait);
 
 /*
  * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,

-- 
2.39.5

