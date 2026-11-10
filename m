Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294910;
	b=BUI3sBovVdktsaVjP3neJtUeNSQJnmRfiynWJLq7ifI8BVJUkg7fvzUYV2gWWorNMmTq
	 kEpXICEMMrsRCvNzZa1bd+OPYW69daD4oNchOIzQjv9T/J6I3Ak0cqkqgDrEkGI5coQC4
	 DVvvEqpJbW+zsBZTb2kd7+iLE5LvYGgCycXH/r0ETkz/sa2mlU3iGs4uEqfGH8Q6RyGML
	 c+puujrYOLvH1JNgJXpe+cgzDTQnk9IicnzFuwjcwVEF6tG4VUYbg/vg64GBTLrbaXE26
	 wLgE33A6Shcwx7Cc0cFo+H/Den0PB4+yFoes2cBmAnKZIXKnPFuC22s5UzUe6Blc+JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
	b=EcGhwLrxKJ/SB6pIniR8HiWs+P3nkR5Dze5f+JNlg6HlnlLV1qRgSlH8YswumisZ/xtQ
	 qmDILInCkyyZS6s17ilmMeTPCKWjM1Jd6l9sOYX1vrpFXSbz1SDkEoWrg5ZXYigUsgRd+
	 4k5+PtdbaTWZfOW3Peg/F2pSqKr4YV6YDSKYJ6nxYOdK2clsbI2ezAxNuZsFc9eiwkFu7
	 jr6jNaVM57Xh+pzVxgRKcGFm5mUSDa7uV47GgWJMG+yIPecbluOZE9HD9rRPNYmgLJYEq
	 SmRWEFPDZjG/x92l3MvXv1eXNH0U8/BgzoDg6LSum+ngm5SSQa2dcXYFIOgUzFdeWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IC6s7YNj;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D37606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 07:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IC6s7YNj
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2913393eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 23:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794294909; x=1794899709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
        b=IC6s7YNjlZ9PztkV+z7oGAXqHLNbg5AWY68TafBW93FK1CXQrcPpNVR5skIHqL/ZOA
         fhO3AYcgJLmIsI6FcUUKphIsZkb1RKjz3RU/HONs0Y+rhuJZgS0HsMAlQ4s6VlujCYQn
         KyBAz7Ubu8KPdqYMupcB4NsybMOpTAmHDh+a829OJth3ZYv/swcKQAhmDKoQGr9hOL8K
         9LVkhQsTck/UYcj0vaUVZEtJ2T13mqmBD3+Rfq2LsZ8xegCO1lOP91SrOoBKZ4VwcE+f
         5VMBjkUOGWRkxtk2jI6etAKvSs4AHgY85NeD0iRwlRkaZDXvmPegTZMNZWBW72twXWjx
         Lq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794294909; x=1794899709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
        b=Oyilw0fW0C9WmC87Q/PNmFKp+tQJkSISuhN6rVLBmInd9iJKAxCuejChs0os6424gX
         KCilC2p3iHVYc2SqyWWjEnOOj6F4orOO/RiE3fremZSiTYpfQe8LaiEEHVLfBjQQoohH
         N3ZDKrcHwSJcti3UkbyxH1SkOUHk/SaAJjy3gJDOyX3Py9eNgST+Z89vKWxuhlf4cazG
         HFK5y/34TkxnJF0VoPMZoqJhVTCfY/QjiNSQraEordeLlWnII2cwCGHMappef/ozoQxh
         zrV1idsV3PitDfK/dqvvvYPbIkukxFI/5vXlZK1pXuOy4tMpZRfCf7EX7ekIq4MbSJZJ
         H07w==
X-Forwarded-Encrypted: i=1; AL+hErH+QxSxK/PKphxfmwzhp888BpDvkDvnC3cir2Kz2Au+zhfwsePfRQ37+hp7CJhleum9XRsZdoP73YOqEvqa@vger.kernel.org
X-Gm-Message-State: APuU4Z8KOzjZPxTJ+hcECWSHUEUXNMqpD5y/MMW9IeBXojBSF+c4Ztqh
	cdvUYmQMg+WA4De38AcqHjGrVUmPAvn99+rP9XPwsGTd6NotxLFtu7C8
X-Gm-Gg: AYBFou2HQkTCa1fxv3RvhQF3c8EMRre/VMwYTuyl1BHq+eZLDcFJGUWBn0DhFKmlTxW
	TXnlDhyThdMgzWO5bgcocRF6HOy0eAob++JqLnz6IY9Q6VQmLxurnPX2tFguTfiU2SA4XeT7s6M
	FxNwbhNe9RauLmndD2GizuIOXpM9WbxuMakwN4afZN+b24UUyrRV5NtNbWMi30Qaoj4/i+UPpIt
	IML8/L9F8bDGU/2TADcvYYTxr5ekQY5B62o5uiiTti/H75x75SXmt9VIexNt3lGBpVy3Kjxp7on
	I91cCP8zXaRetzt98/GcqO1oJ8COZs4tdWRwqW1jtKCua+6OG5sZxcNsl54G4Shm/ks7SA83tpS
	DkIdyRtTNu0RVUrVWqypC5w9weE1pPJ4nekQ9Xv9sTpulkV+LzW8EK+e6RJeMQcyFkDwRXfl57M
	eHT3wXQqFN5aWoUcI2zHwMemEqUWh3bxJcDyxM9dmeLgqCT1gRbvnrwuZ2+PfHZp9qc5uAaohW0
	H73An0dke5AgvW5cNEKp++3naaFSlxFUioOKPuoMpfFA9GCvQHAf6DB2gEiNK7zWTh+twwHBUnK
	KTM0WRP348kcAL+LJPJnc3XrR0pxYEwj4u6B
X-Received: by 2002:a05:7301:fc10:b0:36c:a084:30a4 with SMTP id 5a478bee46e88-3751ef77c77mr2325949eec.21.1794294909109;
        Mon, 09 Nov 2026 23:15:09 -0800 (PST)
Received: from hanzj-mi.. ([157.185.136.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm5034648eec.24.2026.11.09.23.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:15:08 -0800 (PST)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2cec257b63d85bb983fc@syzkaller.appspotmail.com
Subject: [PATCH] jfs: hold a page reference on log pages while I/O is in flight
Date: Tue, 10 Nov 2026 15:15:05 +0800
Message-ID: <20261110071505.2411506-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a use-after-free read in copy_folio_from_iter_atomic()
that has been reproducing for almost a year:

  BUG: KASAN: use-after-free in copy_folio_from_iter_atomic
  Read of size 4096 by task kworker/u32:9
  Workqueue: loop0 loop_rootcg_workfn
    lo_rw_aio
    shmem_file_write_iter
    generic_perform_write
    copy_folio_from_iter_atomic

I reproduced the same KASAN report with the C reproducer from the
syzbot page: the loop worker reads a log page that jfs has already
freed.

The jfs log code builds one-page bios for its log device in
lbmStartIO()/lbmRead() and adds the page with __bio_add_page() without
taking a reference on it.  The lifetime of the page is instead
guaranteed indirectly: the lbuf that owns the page is kept alive until
lbmIOWait() observes the lbmDONE flag, which lbmIODone() sets when the
bio completes.

That guarantee is not sufficient when the log device is an asynchronous
stacking device such as loop: log writes are pipelined through
lmGroupCommit(), and lbmStartIO() marks the sync-point write REQ_SYNC.
The block layer may complete the REQ_SYNC write before an earlier log
write has been processed by the loop worker, so lmLogShutdown() can
free all log pages while an earlier bio is still queued inside loop
and about to read the page it references.

Fix this by the book: take a page reference before adding the page to
the bio and drop it in the completion path (lbmIODone()), so the page
is guaranteed to stay alive for the whole lifetime of the bio.  This
is the same lifetime rule every other filesystem follows for pages it
submits.

This bug was found and analyzed with the help of LLM tooling; the fix
was authored and verified by the signer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://syzkaller.appspot.com/bug?extid=2cec257b63d85bb983fc
Reported-by: syzbot+2cec257b63d85bb983fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2cec257b63d85bb983fc
Tested-by: Zhijian Han <hanzhijian1991@gmail.com>
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
 fs/jfs/jfs_logmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 306165e61438..ef9ef11ddb1e 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1971,6 +1971,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio = bio_alloc(file_bdev(log->bdev_file), 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
+	get_page(bp->l_page);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
@@ -2117,6 +2118,7 @@ static void lbmStartIO(struct lbuf * bp)
 	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
 			GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
+	get_page(bp->l_page);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
@@ -2184,6 +2186,7 @@ static void lbmIODone(struct bio *bio)
 		jfs_err("lbmIODone: I/O error in JFS log");
 	}
 
+	put_page(bp->l_page);
 	bio_put(bio);
 
 	/*
-- 
2.43.0

