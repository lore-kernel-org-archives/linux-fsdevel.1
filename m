Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73018FDBD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864731; cv=none; b=CRjee7FO1Lh1i4VAt8Du2fDPuLlkl4RUgtzhZoI7bO/nAJscFow+/+qNR4336v7Z/lWf6sRbzImf2f3Huy6S0KU4i4YJoAu9guHu75jZ16vw10VfQT2CrzOfVdl/urmMzBIL5GxC1OfQgDroA7s77HvX5KaTwM1pKyE1B6UjTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864731; c=relaxed/simple;
	bh=FNPAmZC9QW0FcXQDJ4HDqkQLOrQ452JWlOTpJCafqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibLg595G0onxUnpQZ+jxEty9BITPCW1CZZcJmfd7MarW58YwROeoLDLbIV5c7iBdf0r7wK5uGXwTyHLhanGqOvYKVJuuD2DOngpROfRWxV0Q0LsPNZBrVDlbWwhkGyewxHbCMZ5U2NuQ1alyNokGZEaFrgKnuBODCTyo75pbdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+7SG63Z; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+7SG63Z"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44ae264a785so17756fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864729; x=1783469529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3CY3QZ2wnue9rhqKHqLfVQqYV670BNtYmleR0mKcr4=;
        b=J+7SG63ZaWb0ISpj20tb9IkMksmNiXD88QE6AuMqKtx0KnnsCcgFdzetGPC2vy+9OI
         3e4jmeiObWDgpGwJKAA9OEaOq+5MG6vXcL48WGlmJd8SltueqRQydFndvqMZHL99oBnA
         GZdntW1EOlBCHrTWfqq2wU8PHHWEvFcTmJjcTwda3zIoigrvARPgF77atz37BtySklrY
         amKHrotHLtxNS9d2T+MX9sVUOFheWuHjOGYPMJrq8EWB/mXnm1MVkavvgoRtH4duwRu2
         Uyc14NSXy3GmCoxQXj0y9JdY2yzuxCkhzzOTyXAYCHIOJHilplda4SnesolhgPLw8UEl
         +Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864729; x=1783469529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3CY3QZ2wnue9rhqKHqLfVQqYV670BNtYmleR0mKcr4=;
        b=YK3sk5iIJsW5kwgJHaY38VoMEChcjVMUnlXxdLoTvkqeBMvuLjdYg5CZT/rIxGCEYs
         vUxUjve6DvIvLLGodzAPWpgxqISbBiWUBCK1U0g4EZjT4emvtcuxrTEQ2NE5JwuQBRA4
         iGTWZoT9md33FmaxS9Y5sp1yDvsArMIIwbfZ9zXz73RjoST8wDgKPmh8J9TxOzAL3L5m
         ekw93sDuf9GRWqAgM0Inux8th4gTTnhfGTFkbZVNf1FlBf3SfmfNvcIfkHzjha/0HDRW
         iIF36OZeI7Xk5KtoKpTUVkgBv4a4oRgZhTR2XCTgPU0VKhOw0HtFC35VHxw2SAEl7leV
         x58w==
X-Forwarded-Encrypted: i=1; AHgh+Rooa4riq/tGI62SzTdsFl6fCtYDxfhfSy+MNVP8JWZ7pt8rrcHCiZOhDE4miIPiEVrq4IUIuTfWoayBfepG@vger.kernel.org
X-Gm-Message-State: AOJu0YxMy2tuU2Iz7Il8YZcTJA/iXWzpHYmbo26AxBgOZKt5HD+GuhMY
	KFeR3d2c/6E/LQEcFUviEjbvTZt5tZh/dDYbNGKlWddz4qGBzYq3KFzV
X-Gm-Gg: AfdE7cna2gKMKX7Z5QImusYSDApeDbIL51hCt6Wc/eHwD7sJFwvj9E8Qi8jeur8loVh
	HvPcGMI0519ms2fVNaq+G7vAO5apTrGv2btdqeybHEjac7oNPxmF9cK+270gZr4ru4dtepeZN5z
	3XiZBqykWqqdmSuQ6hvSV+XEM4adcaHGq/EmmH0SqI9q0GTDB9MWM21iU1Xwh0Hb1o3ZZJQFaeb
	y/Udbhc9Iv3FApIe51IRbJ6jj7YwUofk/JgsJwCXvP2D16SdxzE6yORvaZQNkBQuzPpz1CB8Sjy
	LEQP+sWFH2nrnoRf8bRI7Wp1gzw5b3fTv1iYVfR8+ZAwKg7A0hap9Od2vzDS7ZxcYfhI+Hb40iu
	nKWrzray6Ydc6o9nV0Qqt13SvCDmopYURTELeMXtCd4rCMGwV+H1qFHRHC+iNDvglhYcK9rQdgv
	q6700w9E3GrCrdT46kUuA6xXBNHJQnceFyrgqvN84LKlUBaCJQEvoG/Z9HXIqxfTZU
X-Received: by 2002:a05:6871:7297:b0:448:ca59:a162 with SMTP id 586e51a60fabf-448dc9b8df0mr4555071fac.34.1782864729159;
        Tue, 30 Jun 2026 17:12:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c685ae7a3sm272526fac.16.2026.06.30.17.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev (open list:FUSE FILESYSTEM [CORE]),
	linux-kernel@vger.kernel.org (open list),
	virtualization@lists.linux.dev (open list:VIRTIO FILE SYSTEM)
Subject: [PATCH v2 14/18] fuse: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:29 -0700
Message-ID: <20260701000949.1666714-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert fuse iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dax.c       | 10 ++++++++--
 fs/fuse/file.c      |  8 +++++++-
 fs/fuse/virtio_fs.c |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8b53625ac7ab..e8d8c9f5d728 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -653,9 +653,15 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static int fuse_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, fuse_iomap_begin,
+			     fuse_iomap_end);
+}
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin = fuse_iomap_begin,
-	.iomap_end = fuse_iomap_end,
+	.iomap_next = fuse_iomap_next,
 };
 
 static void fuse_wait_dax_page(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..5c0d400629cc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -890,8 +890,14 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int fuse_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, fuse_iomap_begin, NULL);
+}
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
+	.iomap_next	= fuse_iomap_next,
 };
 
 struct fuse_fill_read_data {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index df25d4faca41..84e699f88574 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1024,7 +1024,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 }
 
 /* Map a window offset to a page frame number.  The window offset will have
- * been produced by .iomap_begin(), which maps a file offset to a window
+ * been produced by .iomap_next(), which maps a file offset to a window
  * offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-- 
2.52.0

