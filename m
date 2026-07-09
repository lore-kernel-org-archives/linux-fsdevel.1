Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1A3C8C5E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578416; cv=none; b=DZCDtKS6R3Kt6mNeS5/ex2JFWNlGv4Jd9xl3/ZmFkD+0oqm73gzGo/RPuomCZxyWNyK1lQgKwBRL/epcU+ta04Q3tRSK/mRvTxA1oT+2atEn6BIekq25DAIb3B+978ozSuqJtGxYqgRrAhV4onwc+nNfWXsYGb7ahyaqQ8h1yFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578416; c=relaxed/simple;
	bh=f4085wpgeHY2EXKrc97t4Zu5evbO07duIfIpVYHCKmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgfM1xl+oqH++iBI89V8LhwfANJxMxy141gi7wbgbQnr/Hq+wtv9cPubhtzsnrWDrsxFUK6MX8VPLOz6+5ZW2Wr9ciK36DpD+k/lxY5ukGfQzo8IgpNc+FNsC+vl565+Q6ZbYH/d9FnsLN8LJmEyovaG0CXC4CRkS5AjJRJ0t3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLAzleGO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgkZkmni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLAzleGO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgkZkmni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783578407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PuqStaiSbRQsVsWgk7EHZfKWUiW4l5xja6N2MV8cWZ4=;
	b=JLAzleGOJ4d9IyCQ6FUeXOq/CegxmXTRg/Ubg5yjnVTyzBGXuqG34GX0JvnV65htiRui+0
	IZC3iRO4F0a9GRiniih7Mr3PJ/E45X4/+J10PZwfeIWj8Fv8tnrTMJ+PFtA2zRYfpTkga/
	hzA4oI2PYty9/PPXf2GK3I/0Z0BB9OA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-tcd-QTi4PganhjPeJCIAFg-1; Thu, 09 Jul 2026 02:26:46 -0400
X-MC-Unique: tcd-QTi4PganhjPeJCIAFg-1
X-Mimecast-MFC-AGG-ID: tcd-QTi4PganhjPeJCIAFg_1783578406
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e8004d60eso331410785a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783578406; x=1784183206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PuqStaiSbRQsVsWgk7EHZfKWUiW4l5xja6N2MV8cWZ4=;
        b=XgkZkmniJdT49Xvvo2WGu+fQmmUK77kiPhuL2pQ8+hqZ3N1Jm51ohmIw+F568ghf+J
         gfzr8ET9Gyp2ZjxrIGtvAQ5doNZTCa4Y19EYXYp6zk9FSUAxLrPmKrKHy3sUdsAdEib0
         iXVYG3N1Mh4w1cOz5J5dTqTkmgPLlA4V9bWZRPbwPlXplJbDdyvV0dwGbHyO70ccGBxI
         4wUKdRPZ9TEPEK2orjiaXgBaj2kmYFZc9EJKnJwd28vuFJNY/qCgoBUGhQvBD+C0f/eC
         R5MhRUcinonuzOIEA1sN2n3jpCWPPZm18xQmTvoY4TBgWEqGYnOO7IH/9ubxIOQu7giH
         FaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578406; x=1784183206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PuqStaiSbRQsVsWgk7EHZfKWUiW4l5xja6N2MV8cWZ4=;
        b=qybmxY4FbcahUVfpqFgxZY1tqtiWiB7kWsU/iinmOQ61dyiHrJ62n3ojW/3AiPXgke
         cprUQlViBNboceB0zezEXnDotP5wMWRVRWF9o/y5Dwlld01Dm7WigykUc3SHmrKGvcKK
         LEHhHG5ljQabQ+3dnHOgrHi9MrSDgnoBG3fgurxWgwgJuA2GqmDAjXnWmc+kq97cQF6T
         ovy/01PRedJa3U2LBN/zfo6UJjIaVYmoZIZ8Czn/pdmdsOQrAZKP/gLNp8147ky0ToeB
         2nJ8sKFzZoY8/H8TTayC6OPSU7jfj6SWafod2v2QmJfosh/OOu75YNjxIS72CMrvHltl
         JBsw==
X-Forwarded-Encrypted: i=1; AHgh+Rpr6XCLfcTIYqcDVDDEKVjSTvfYYmI1IgGzh/JWmYLIidW6envJ5KM7617pmxqcL/DMZ/XIx+s/TkO/cdz3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TwJmDZBHE1SXtU4H4w0qGOCY633l0oGyDSiJNgJlcklztT+I
	aoHb9BTgFv4SydHfrf6aUHMejOrkv2dWFxAKpOHNwAoVmQvP0ryInynanlA8jgRNAbPQeAeEnwx
	Lv1Lp2vPAcqHmKXKuLLN/s4BUVJpet0x6xAP9V2S6E1slrYav96ikYmW0/W0+LrKi2xc=
X-Gm-Gg: AfdE7ckkoUXSlU0a0i+ibyMCvKsCCCgged3mJrJDBDXu3OPtzIUatei7+em1XWTUdSq
	10IzPgIEA0I3zSXg+Ki7pGLWFxdUB+1eHPQ/detqSlZAdAgTPDMdPZNwbT7Y3dbLUxKa4UxXNVR
	F99s8SmXRo1xXgfPUosiAuQvvqbRKqXf9EAkvR2wVu0YaErMgEJpRmBJ8tcrwm2bOp14UIb5IKD
	EAgt5CrxKAmo54940YzfbcWZnhHdrr7DJF6TnjpyNwNBk+xYrFW/GBG5ZYsUD/fR+Z31GS15K1t
	wTLx4mEG+ioLvcuEojUDxgLGBReMZu2zXwTgVFU7ZBGcrk7+A3Ta/doLq0rAHryzZrc9GCE2L5F
	Kq48dOxW539TGYrHW8TkRodWQQoRPPuHv+rk9FiIL+U4RaHi3/S0EuSh9Ox+QFrLPobqYwyWCub
	Kf
X-Received: by 2002:a05:620a:1d05:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92ecf6c7189mr534434385a.56.1783578406095;
        Wed, 08 Jul 2026 23:26:46 -0700 (PDT)
X-Received: by 2002:a05:620a:1d05:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92ecf6c7189mr534431985a.56.1783578405621;
        Wed, 08 Jul 2026 23:26:45 -0700 (PDT)
Received: from upstream-xfs-test ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c92634sm1601832985a.27.2026.07.08.23.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:45 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org
Cc: dchinner@redhat.com,
	bfoster@redhat.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs: punch COW fork delalloc on COW writeback failure
Date: Thu,  9 Jul 2026 06:26:22 +0000
Message-ID: <20260709062622.2939412-1-ravising@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a COW writeback I/O fails, xfs_end_ioend_write() cancels the COW
fork extents and punches out any overlapping delalloc blocks.  Currently
the delalloc punch targets XFS_DATA_FORK, but on the error path
xfs_reflink_end_cow() is never called, so the COW fork extents have not
been moved to the data fork yet.  Any overlapping delalloc that needs to
be cleaned up is therefore still in the COW fork.

Punching the data fork is incorrect because it can remove delalloc
reservations that belong to a concurrent buffered write.  In particular,
the convert_delay path in xfs_buffered_write_iomap_begin() drops the
ILOCK before calling xfs_bmapi_convert_delalloc(), and a concurrent COW
writeback failure punching data fork delalloc during this window causes
xfs_bmapi_convert_one_delalloc() to find the extent missing and trigger
a WARN_ON_ONCE(whichfork != XFS_COW_FORK).

This is the same class of wrong-fork issue fixed by commit f6f91d290c8b
("xfs: punch delalloc extents from the COW fork for COW writes") for the
xfs_buffered_write_iomap_end() path.

Fix xfs_end_ioend_write() to punch delalloc from XFS_COW_FORK instead
of XFS_DATA_FORK for IOMAP_IOEND_SHARED ioends.

Fixes: 5ca5916b6bc9 ("xfs: punch out data fork delalloc blocks on COW writeback failure")
Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 fs/xfs/xfs_aops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 51293b6f331f..8268a3f80398 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -131,11 +131,11 @@ xfs_end_ioend_write(
 	}

 	/*
-	 * Clean up all COW blocks and underlying data fork delalloc blocks on
-	 * I/O error. The delalloc punch is required because this ioend was
-	 * mapped to blocks in the COW fork and the associated pages are no
-	 * longer dirty. If we don't remove delalloc blocks here, they become
-	 * stale and can corrupt free space accounting on unmount.
+	 * Clean up COW blocks and COW fork delalloc blocks on I/O error.
+	 * On the error path xfs_reflink_end_cow() is never called, so the
+	 * COW fork extents have not been moved to the data fork yet.  Any
+	 * overlapping delalloc that needs to be cleaned up is therefore
+	 * still in the COW fork.
 	 */
 	error = blk_status_to_errno(ioend->io_bio.bi_status);
 	if (unlikely(error)) {
@@ -153,7 +153,7 @@ xfs_end_ioend_write(
 		if (ioend->io_flags & IOMAP_IOEND_SHARED) {
 			ASSERT(!is_zoned);
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
-			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, offset,
+			xfs_bmap_punch_delalloc_range(ip, XFS_COW_FORK, offset,
 					offset + size, NULL);
 		}
 		goto done;
--
2.39.3

