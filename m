Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050590;
	b=TD2vFi9e01XgTrtVE1vFHjRC47s7A0PwXcWwTbJ8u6cKMHBmc3gyCzF/m/nC9sfB6GsS
	 4KJYy6jCpZrB9TLButZXr6TU3xRdGoONh/3L/6d5e6H06Ae6Xsi9eku7feqdIPYlgWgTc
	 3P0DOgfEhLbwrMeKpmbi0RJ+Q4UmaY0wFQ7gCNHjsKdVlRTLqeY6QFB+i5C0pNoim0w+Q
	 w6FPdaW2toTFcLgw4Sncbtw4NRJ6T4qYK0LbZJIzP5ZTRfUQm6gDT4PXwxL+7PxsWRJyp
	 DWqVDQamaLbszGj1Yj4biK2PXAVzmgHTOiCHwNGF8p7gZiML6cq+ON9jd7diynnoijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050590;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dDFWPJ5XjzGS4FuGMJGtbP6vWBRuxVwEHY2kwulZBI8=;
	b=AjsZVuf9NlH0ufhUBGYSTf31j3l8Mr++FUbX/JtX1GBBT2bbL/sz5MspBON2ABlSfQ37
	 JjPpgDt08yM9gFYfJKhnYpikWwvgVtL49fbrrY1zb78KbO7+yvA40vtlO7qARc/CwgR/N
	 rzK39anHrR0Q0LrHJ+vEC16MmL+U11BtM1Ygr/znwKcFfj0YkPLSgtB50cNolKmghKFdo
	 /dA2jBlKNqa8PFkFrFOyZ7xYXWCkFsQQ2iNMqMEAjRUu9Qzd28rZmOuColacA4c4o8cic
	 ZdSUpJyLzCRgNS/PBhtQKYj9YfrcT5WAAiKWeAwFrGSuVwLlFeM6NGVMRQN8Au2z3uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00975606A325
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00975606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a215344409so6098505e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793050588; x=1793655388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDFWPJ5XjzGS4FuGMJGtbP6vWBRuxVwEHY2kwulZBI8=;
        b=IYe9mNxxqik9RbNxFDyXgKo5+LKJepCJIWIIkP5vqBJTOxZy2tWILTk0g7wJ8Dh/2d
         6ufafrZORWcARBTtAshGmzfOtDU0kALfCLcvqLCPzKbHS0ZIywHiHepWD4GAZSA0wF+j
         eBDuqOy96uXGEGFRChIK/ZCqziVStoIQ3j3ziARHQQl3SWkIxav5u0fk4aMWbxb2L8Cn
         GDJ2QNtIZ3T5QXJrEhv5RhXA8No7w6Ku43GXcDUylht4OVTLn4EBPkum0xa/sYs5M5FX
         09mWpnn3MHlfolJD8hxxoT1BWide9c7HJd4M8NEElFAwy/O+t53ry0SsStIJU9YyAlQV
         O+Sg==
X-Forwarded-Encrypted: i=1; AKwUvBzCb3NeEWiZ0K4H+qKQEkdu7WGuZg4bEsQgYtGq4AFpKXGzMBRhcByk2wj04XPDPsb1tT6yGiwj4dB2skhk@vger.kernel.org
X-Gm-Message-State: AFq9FYK86+dES0ehVxTX0yrvMg6HanM6d0Nm/w/daEQ6t02hHbK9RyPt
	OrwK27cv0PgD5w4K47K5otQw/zalndHT95sTM+LKACJXGhdoH/qtAg98cQwZ8AtrAiN/FA==
X-Gm-Gg: AYBFou2CmVWYsxLlGp85wsxA3IMoTp3VFwDDT7l+AWAlUVR0b5TcVh7pk0tGsR7KC0z
	aNhqo0DClbbHKrrXdX15m/xhC8/6LzQ8ffHisaBCnN6Id8hrG1kivsUX/TDQOzOmQ9r/bblKKV1
	W2swb3pIVEacB34uOB+zatvcxZZk47jBuhbtfE6r2d1KxFWvzB88xZemhe9rw3jGB4b29k1ND1r
	NuULtoUB+zsCvebYzUovk1acfGw0q27UQMZJg2C2pqQEOQmvIkktbRWQdEtbBiTulQspViP01Ra
	/qrTHUaUOHwU8iZNgEyBkln6bfAtX1FE9qDW+lU99JhdJmLfkelcEZEyLrQTXXvKU6WbiblsMG4
	ZpegoL9vxlQSO2b8v3YzJupEOCTrCcKujW1Uy7J04y3RZl4p7aYWBmCi/i447NmBO4snsqQUjls
	TaAkzVYgH+tmdwez0iFozFtpT694sEW0H4VdgfPKhZXjN4JRMFeMIaPR9cAWYkY2Vtej8ucUlwd
	5QGG3xspUc1sB0q6wq3W5ROf9nbBKwIWafjHlMHeMjzO1g1Zi2HXxjYzSEfyfZV0AGlwZMHYeiP
	0EQnscLbWShGhP9f6w==
X-Received: by 2002:a05:600c:6206:b0:4a2:6ef:d1dc with SMTP id 5b1f17b1804b1-4a35ac6fe89mr141539865e9.1.1793050588225;
        Mon, 26 Oct 2026 14:36:28 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2c0458sm218806205e9.11.2026.10.26.14.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:36:27 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: jack@suse.cz
Cc: brauner@kernel.org,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aurelien.desbrieres@gmail.com
Subject: [PATCH] buffer: warn when a buffer is attached to a second mmb
Date: Mon, 26 Oct 2026 22:36:26 +0100
Message-ID: <20261026213626.301480-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
References: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
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

mmb_mark_buffer_dirty() tracks a buffer on one mapping_metadata_bhs at
most. The per-mmb lock does not protect a buffer that changes lists,
and mmb_sync() clears b_mmb for a moment under its own lock, so a
filesystem that attaches a buffer shared by several inodes to each
inode's list in turn corrupts b_assoc_buffers eventually. With
CONFIG_DEBUG_LIST the list_del is refused and mmb_sync() spins on a
list that never empties, holding mmb->lock: seen with beamfs under
dbench (xfstests generic/241) as list_del corruption, a soft lockup and
a node lost to the OOM killer, with nothing naming the filesystem.

Warn once when a buffer already tracked by another mmb is marked dirty
through a second one, so that the misuse is named at its first
occurrence rather than at the corruption it leads to. A corrupted
volume in which two inodes claim the same block reaches this as well;
the cmpxchg below keeps the lists sound in that case, and the warning
then says which filesystem believed its block map.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3/
Assisted-by: LLM
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
Tested on vfs.all with beamfs, x86_64 guest, 4 CPUs:

- the module as it was before our fix, attaching the shared bitmap
  block to each allocating inode's list in turn: the warning fires at
  boot, 8.6 s in, on the first truncate that frees blocks of a file
  another inode had allocated, long before the dbench run that used
  to corrupt the list:

    WARNING: fs/buffer.c:639 at mmb_mark_buffer_dirty+0x46/0xd0, CPU#3: S01hostname-cmd/111
     beamfs_write_bitmap_block+0x191/0x1c0
     beamfs_inline_free_blocks_from+0x64/0x390
     beamfs_inline_setattr+0x127/0x4c0
     notify_change+0x33b/0x520
     do_truncate+0xbf/0xf0
     path_openat+0x8c1/0xaa0

- the module with the shared buffers on one superblock list: no
  warning at boot or under the filesystem's own tests.

 fs/buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1dc933ba6925..e503a7ed9c37 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -627,6 +627,16 @@ void write_boundary_block(struct block_device *bdev,
 void mmb_mark_buffer_dirty(struct buffer_head *bh,
 			   struct mapping_metadata_bhs *mmb)
 {
+	struct mapping_metadata_bhs *cur = READ_ONCE(bh->b_mmb);
+
+	/*
+	 * A buffer is tracked by one mmb at most. The per-mmb lock does
+	 * not cover a buffer that changes lists, and mmb_sync() clears
+	 * b_mmb for a moment under its own lock, so a filesystem that
+	 * attaches a buffer to a second mmb corrupts b_assoc_buffers
+	 * sooner or later. Name it here, before the lists do.
+	 */
+	WARN_ON_ONCE(cur && cur != mmb);
 	mark_buffer_dirty(bh);
 	if (!bh->b_mmb) {
 		spin_lock(&mmb->lock);

base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
-- 
2.55.0

