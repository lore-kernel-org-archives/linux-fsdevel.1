Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF318BA8
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788090533; cv=none; b=X8U6vQEj89HVMY9wingSUVFydvwcJ1no4jmvRPR3SZm+q5/zvs3koLe7tx8Vvu18WclRIGchEkEOGrk9klB1nDVo6nK2/CTTx2nAG6MW/6FIObSXRSJ8uuRmYwbdIyXosKAbqnhnSakp+aM9G7ihuiCu6S54PuDp2iwY3AANobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788090533; c=relaxed/simple;
	bh=gF1P2TPTeg0X/fs1Hsa7kd6AlUHV704xkybKWIIDC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shiDkNvrMGPTE8H3ZZhXB6IMnCb4ORiALk8q00G9RAW5hzCuS2EaxNYz2YREbESTEw2bqKg2KjcsZdckdvaQKh2MIKev7cPD755/Ixurpx0ZSG+f3m7NemN68V7e1GVxjhVekkG75tahfXXsNO4kJabetMcHkBq3fTsTbZeCzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoCxldkY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoCxldkY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39647184c73so3337000a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788090531; x=1788695331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6dWzVftJmVxxbOmYyIM0bVDs+vsg5QWyjKFPq8DPDo=;
        b=MoCxldkYJf/kqMufIGRjvA9x+uhrcsukHj/p+yfmgDPll7Mj+ZB4cNrU42qFo8kmdc
         VR+qjnByl8RyA1KTa8jIvkcwZTm3Cq4CV7C2APhUNSoFpG1+Zj9aHnUKTkXZ65/1pBf0
         lGz92DwyQRwlcwuo2Steko8U+9OrZPeiji4UfcvfpIZzs4xdtlLdRuvOuT3PJTFwGIhY
         lqV+TvZoaV9ywuTv6u0u6rdBBrfvUIqZftDiyuLSyemPASVyhoHnt1DkhJTBeWYmDOp9
         kkbRZnrB26wDpAtneQWAeuFWnicvqFZX0AMGZbnA0zS77HCk2JfryYcZLRTVi1fq8Ohm
         G4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788090531; x=1788695331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6dWzVftJmVxxbOmYyIM0bVDs+vsg5QWyjKFPq8DPDo=;
        b=G9XQMfBmVk3XQUkCf3MWC7vNalpYxHTcQ4aP4BqQD57SXDlbVPngz9s3fLq00fZzJf
         zZCfK0SH88gy3bk5k7jvIafJqRv11eIn/9Dk91uV4qmh2ii9RILW91sHRPnUgbcMa9of
         34r7HojpA/q4IO4liw0LkS68QEI77KLKGY49evz4Vk2/yp7ZgOennEbRUERm1JUtsZpy
         LAJSEL8mwz7d3ekNTbqz/GHmnrRnSPMz0BTUu4+0sCwM0k4HmGOTbWWkvVoqzQiKDJ5m
         MuOBYPGU7pz56GDpaonZzEOd1OvMXKcPmHUgnQn5Nkzxbln4hNmZp19nTsSNJnXr9MFU
         CqXg==
X-Gm-Message-State: AFuF++no2YoQNW2AwHnjSBTXv0d3zj8R0X3wSNVhkAf5bDiMiYEsnWsV
	p900ojm7wy7l47A5k9PW6pgHnknXjBLH+Vu1zRdzd6UNoA/xZwJPb/Cx
X-Gm-Gg: AYBFou1uSI20ExTKoFXWgQLS6RujftAj1t1CyUitKTnPv8qRqzJ+3jAjVd9P+xjL2Ab
	ULylv8oxMg1QFmKSy/L/JPUMTvt0XXnDc5cXtariGaezYeIL5DQuoFpkaXdrwNpAvWJw+Y1JL2W
	+5F0UhFmC9SMZp61WTDkAcTE411gR1FVWEVlVUofS/EyCweM0/8K0jcDPV+oslwufeevFg4fKIn
	RcjnAIY89xJVJzpwXNER/qC/tAIDupmhKlpH2hAG8mPauoqxkvQzyXdnRpMpjbrFsSTC/h6LpUv
	1BOagY0CxIkWBjwN2tpVYkdRP0gQKByw+9lItCpc1LscpqhabNWcPLOuqGnO/rVQqU4bNu54yvJ
	oO//+/LHMhnsQVdAHHVoR96c+SQGrWMPU8PCWKRuf2yy7a7M7+b/nX2v0/s5Lhw35zb0iGMxySV
	wzZ5KpIA8j+e0KoWglKCkPJmbYLIVqszL5D4F7PsWmfkDFzJVs6PhCtrVSjM6bMKAMwST8vnnOD
	SA89LJzDmhACGvhlIEzvA==
X-Received: by 2002:a17:90b:48cf:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-398da6f3e41mr1421458a91.10.1788090531274;
        Sun, 30 Aug 2026 04:48:51 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea7fa9sm16269311a91.4.2026.08.30.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 04:48:50 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	axboe@kernel.dk,
	trond.myklebust@hammerspace.com,
	tz2294@columbia.edu,
	chao@kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH] mm: filemap: skip dropbehind folios during fault-around
Date: Sun, 30 Aug 2026 19:48:45 +0800
Message-ID: <4a4ac0b4accb50641f504f205663435047c4b26e.1788086386.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qiwenjie@xiaomi.com>

filemap_map_pages() maps uptodate folios speculatively without going
through the normal filemap lookup that clears dropbehind. As a result,
a neighboring dropbehind folio can acquire a PTE and the mapped-folio
completion guard will retain it even if that PTE is never accessed.

Skip still-dropbehind folios in next_uptodate_folio(). If the skipped
folio covers the fault address, do_read_fault() falls back to
filemap_fault(), where the normal lookup clears dropbehind and updates
WB_DONTCACHE_DIRTY accounting before mapping it. Speculative neighbors
remain unmapped and can be discarded when I/O completes. Normal folios
continue to use fault-around.

Dropbehind is folio-wide, so a fault into any subpage retains the whole
large folio through the normal fault path.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Tested on XFS over a 5-second dm-delay target in QEMU:
- neighbor-dontcache: the target remained unmapped and was evicted.
- target-dontcache: the directly faulted target was mapped and retained.
- neighbor-normal: the target was fault-around mapped and retained.
- unmapped-dontcache: the target remained unmapped and was evicted.
All cases completed writeback, validated data, and kept dmesg clean.

 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f550..c123de583b3e1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3769,6 +3769,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			goto unlock;
 		if (!folio_test_uptodate(folio))
 			goto unlock;
+		if (folio_test_dropbehind(folio))
+			goto unlock;
 		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (xas->xa_index >= max_idx)
 			goto unlock;
-- 
2.43.0
