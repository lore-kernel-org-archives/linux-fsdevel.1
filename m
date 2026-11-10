Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303527;
	b=rUwpkZ9OHqPm7RP0GWNmlbvg6E+LG4d1ZQnSfj+UR2rJdA3JxfEbXQ5baPbDRIKNqKv5
	 a99/OIs1zrNW2UcySPlphmiyuycPY/5RfW3P88QCx8d+4Jhlg0dXpZngJOM5zBVa2/kVz
	 0L6iwsUn+3v1CZ8NTjK3JPVxKcDBzU7TxpNYsrncdwunGFbwSO3qWoBt9/7MXM1gCGITj
	 9kK5/DWVqr2WNZxe8YIuAU1wkTanta2QmVVGSH+PMT9AI7tmsuC5tJBKr0I8zsPNCTsqh
	 eHt21gtksLPqLNYAZQ1PZAzw9jM1FnClZXIKtWeJt/NbjLQtWXXwdD/x9KF1SyrjgqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
	b=kGZcuf9veytXLCG+iDSTwIGqvyHGRMoAds5/CnDbpCX1ub6zCnJwykjUZzVnm3a6/7wC
	 VVXyKFFDzH8YF9dF6hsty19iZBRG9mzCz2PKmt23lVF0dtZoVrVcyeYWqgV5jBrgOLb/P
	 +Sb+d2EXsjZdv0aLRrU1p09jOuHW1aMzAfm+CC5AjS6HMEZL7bHDihe+y7xxES89SWxr9
	 neYRqjTqCzbdDROAin5w8EZLgb8rTNBaYEkRQCmyfV/sIfmyajbeiuunpHhHYvLLSuDSd
	 uh1vnPrjNH33oM1cD0LEEvd9wpooOk/TDPgq7PN15qAmpvhlC04bNj269k3M2v7ABCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aeiS47eX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E56606A99A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 09:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E56606A99A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aeiS47eX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so2664527eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794303526; x=1794908326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
        b=aeiS47eX2RAlloEV5TbLKxN8HadOSwzbwZxfrumaatbz9mTX8YhdUMlIVqyh2SZ9zN
         gHNzBBrJSYM/5iQ8UCoJ1Myhq+WTgi/3nM5+dBl33le91DIY6ChPiene272uJNyGcULt
         6aaEWz4ScHNiqT4CRS6OW3zUhmZhw5WBrmt5geSwk45+LMRdExhjHo5t8OhQjg/xbjLf
         YZkwzwvSRfEoDjVyD2uY814yAwBusqCi3tSPBmXY7FCZmnucSgXBCV+1wiXHqUjdB71h
         4ZJw7EE5VFbTTCpf0/jig1sCt7yEPG2I2fwZsWatIOXFMTXMQDD5hHlVOKntpel8S2Zo
         8x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303526; x=1794908326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h+J3J0epLuUim0gFkWCnrvjgBBaMOJi50a7zUOpsEaI=;
        b=BP6FWRmktmFkAHo3tApxu0vE9Hf01Swd76xydnPQvQxIEZq5cN5lijg1sp89ldkxG3
         apHUpx0acD79ni6yYDRC5tqd4mjiQYq9y4Yd2oxjrAnc2LrRKYsouA3U3LvL9BvLa8lf
         aNPqvlCARe0R2wzY/FgeUz7P6kxzM1LBesuaBz/z0624jgl4jGj9hPtLscbq7crJm1EQ
         T2UQzQgmJHAwAHJwdjLMw8LydJPzNFc1FLRjd1r0rzyWXFT0whnjRVerrU6NGn09g9mq
         spuotL0XhaKn10xOxzsDTP2IHkKd6d85036K6pSbsZujGADdq1hOd2RJCNA6WZV5JvtP
         o7RQ==
X-Forwarded-Encrypted: i=1; AL+hErGSmk7VKkAjYMcuSvqexfHhqNax4JuwlrudyRTIUkq2JTNIeNwmpDHvaQh2o4bNL17UkchsgC+NeYVOMSQY@vger.kernel.org
X-Gm-Message-State: APuU4Z/eQkE8Glz/mpwJw3fD/cGutosi75wBAtivQ3fA68zw9ir/HYbf
	yP5oluy0GqSaFJfYFFARGnJ8M5tL37iFsAa6Js06qv7wuwy7UuFJLern
X-Gm-Gg: AYBFou13nduC+KaGd6cbwal6yPU+SsY/VXcsb/ws00bpaM+0Cfd+l491f3/jWuB9Y6Y
	JuGGxIWAoIudWUEx9YU3HvK0VOs0TqSbk8CwpUq3b/Ut98Vi66KXMX4Z+rQjkmjQf71TFqwGIQQ
	kMN2fbucZmP2IOk485O919pNq2fs51SJQiSCVmmI4TnjaZ2Rx4tHeA4sjhe9c7vISrhKifncLiV
	2AMHCUZVLrTvPDZ3tBlrLiS33kSt85wd31efR+r+6BZauKLXIj+LUhZzaxY067+UqVqIAOAeG6+
	4DVW74a5fZnHjXEi/0aBI58/KvRihwBO2v5rBiVf5i7BWNebgE+oaiHxzSO0knY6aTE3hkQ8G4D
	QcEF7o9BAFVjRN0Fw7X/qOZzvON3t6r2B43GYNtxyLrVQudtu3vWa/viIO0wWwmx5319lDk8bau
	stN+7j2LHcLQs0nTc2L3nbhxt82skUbwwaY1Hwy2x+t4Za03W8UIfPNJWJ+wFoYInilpm8NWLC/
	9SvfI2us4fV7NxoEqjr9p+4sovik1bTtpwgVg/9zYswfv9EkbdvensBfI/X4mAtTDnbYrhHFLBl
	LTgBRCoxMECDmDS42WUaVENFVOnWXJ4eJjAa
X-Received: by 2002:a05:7301:488c:b0:369:ff7d:840 with SMTP id 5a478bee46e88-3751ef7bbefmr3078034eec.21.1794303526196;
        Tue, 10 Nov 2026 01:38:46 -0800 (PST)
Received: from hanzj-mi.. ([157.185.136.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm4996931eec.0.2026.11.10.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:38:45 -0800 (PST)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6cc93ec9a4035badb85f@syzkaller.appspotmail.com
Subject: [PATCH] jfs: hold a page reference on log pages while I/O is in flight
Date: Tue, 10 Nov 2026 17:38:41 +0800
Message-ID: <20261110093841.2470586-1-hanzhijian1991@gmail.com>
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

