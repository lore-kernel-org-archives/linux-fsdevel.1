Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDE4508EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142428; cv=none; b=R0TOz4jnnMkxqeR+4qNIEHyFbRRtmjbSTow921RQ4fpvVjEki/YThmnJohRB7y3J25ohVfumn4bV5J20uNgqhUcMdybgRNQIRN1aDCqxqX4VDMSXYpRWc/aGx5G0uyE/RRyvrRii3v7wdevGqOXAb679OefkeH40ulcBqLObziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142428; c=relaxed/simple;
	bh=DvMe7S0LO2jpCitCC1OWjDZYhtYnqG+k9QQSRL+brVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN1HwMrK5nfeAquNsYyBTzrpgE4tyR3F1fjhBRnHZuoo1SnNYeKgL49QuYBUOskZJes0/u+qyfxf/Q3204l2mOKB89mRND4iPrYZVlNAebdB/EOV2vaQ82VG+TCj74V67kpEO5NY2UCXNnBLTD93iYRieFAzvaRVNP53N0tcNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsBzGtbb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsBzGtbb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so2533177eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142426; x=1792747226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjKFi3jIeeLHj7gpePynHKygRXFYWBMHOHUD85BoLOI=;
        b=VsBzGtbbe07k2yru73wU0N0JCchzLn3rr1K3yQnnvw9bdfAUfdOyxFzkfun7/90Vo3
         +WSLAyh+VwdqkK5A9ci0L+7RYNow50jfqbbyrdNP8ode+npRXjgptVn0zBut4pjGeCWQ
         MRCuGWr2ZiXUmx+z7rtxbpFG4QYDorDQ+ns7KKPxetbQmZ23TdFU4RkVZPCpppbkb7gE
         gVZShptTcF+OwxFDXBKcLdPbbB4eDv+0uEHkbiq6fYU95yPi5hXQast6b7196oScPJP/
         hAfiTMgzqm8YIoE290Zui1bBbD8v89SoBKCTD/QVdrV3UlHR7PhpPKSxoz94E3lN5ZZw
         X/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142426; x=1792747226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjKFi3jIeeLHj7gpePynHKygRXFYWBMHOHUD85BoLOI=;
        b=Nw7PuzAZbPy/Bts4tpk6cNsi/4tG96cJwEfzHj0Fo1j4j9WFdIhW9cHhHpMDQzWHrl
         fSO+djWhIKUMssEXw/HOCNzQdbKGhxrEERf0KC20KAf5jJ+JWmIN9Hu3IcQ+hAsHuHza
         OdqNb9Z7LTsFsAyHgBlwmbEyjuUNWqh9mDHPOWsjCsmjfgaxhx7bs4WG8EZXSkm7gi6r
         qVtXGmA02rVOzW95TMX9joC0HPSQRj4E9aIjuY423SymsoqX7jVPguzCuTm8YB248QiR
         Hls3cd4ybp9BnXwtEM+qcJc3QcShDUo9IeqnsTOWyDc5Y3W16BegALiWbmZjJjUJWxfN
         f7SQ==
X-Forwarded-Encrypted: i=1; AKwUvByLoceH2ovjKkcJXIYuh5g/LHNAYpv8b6hDnl/Upf5JK9gSqRnL4iqqX/xdLwDABI68SV9CVrbv0n05CqXe@vger.kernel.org
X-Gm-Message-State: AFq9FYLckNk+5fASCKJ2yYAAwBt4K79CS+dFvx4tmBzfC63wceFcFSKB
	FBovvz3YaCUplBefzh0WB9kmTIP5w9E4SXLaAnUY6q3ZEmHIJiEvD3E=
X-Gm-Gg: AYBFou2s7y8v/hL+5N+wbxLUU5gQMNokScESrv0i6JaBfev2wv2VAKRYG3qwhWX8Wox
	9LC7L7i1cOVzfYM2nzHMk7jOq28upkmLb56wyTPSQ/zusZXIjceCuvok8R+6pO/zvil552X4TYB
	JFz6HdvWUFsffwxDiMpSTUrcoK5Qtv1gOfPKK5Aq6LcPZux7Oe18cspNSJBTMfsh0g04Fr/xTV1
	CVjn8Sa7TVl9GFXN0S9qM8t8s+LAlXvcfBlilZJkIslsUyTcXavQ02VHV6nLFH2MxdmZClcb88Z
	TkQS1d/jMk6hlUYJuXMjvpRTq+Dj4jXjfrVAsNlEwhwgBKyxEGpVfYXlrAFv6gIe0YWTD6xUPHF
	rbbZIGTiLReBcjw2z/Ik/qr1GU/pGvD6UNGEgaZ7kyvXiSl2/NyFMbirWxTsqM15f8EUtwp3Ryl
	GtFUaa77XTI638oUQOOgM38WUSEtogxXm51O6DRQ0z0DiczzwhO6oiUDZuH9aR0VqDU8pi0aJhJ
	uiOY9stWHK4zJNVtGsGFAbtF8/fDI83dwn4Zbb1sa07JGjDT5Q=
X-Received: by 2002:a05:693c:8344:b0:35f:d509:7673 with SMTP id 5a478bee46e88-35fd518bb31mr4771762eec.8.1792142426196;
        Fri, 16 Oct 2026 02:20:26 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9840943eec.24.2026.10.16.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:20:25 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: asml.silence@gmail.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	nj.shetty@samsung.com
Subject: [RFC 3/4] iomap: add dma-buf direct I/O guards and registration helper
Date: Fri, 16 Oct 2026 14:49:13 +0530
Message-ID: <20261016091919.971295-4-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016091919.971295-1-anuj1072538@gmail.com>
References: <20261016091919.971295-1-anuj1072538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nitesh Shetty <nj.shetty@samsung.com>

Direct I/O copies data from the CPU in three places, zero-filling
holes, inline data, and bounce pages. A dma-buf iterator has no
CPU-visible pages, so refuse it.

Reads that encounter a hole or unwritten extent therefore return
-EOPNOTSUPP for the entire operation, even if I/O for an earlier mapped
extent was already submitted.

Also add iomap_file_init_dma_buf_io_ctx(), so filesystems can register
without open-coding the DAX check. The filesystem picks the device,
iomap does the rest.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/direct-io.c  | 31 ++++++++++++++++++++++++++++++-
 include/linux/iomap.h |  3 +++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8b4039d16ce8..fc40f4367ee7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -427,6 +427,10 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	unsigned int alignment;
 	ssize_t ret = 0;
 
+	if (iov_iter_is_dmabuf_map(dio->submit.iter) &&
+	    (iomap->flags & IOMAP_F_INTEGRITY))
+		return -EOPNOTSUPP;
+
 	/*
 	 * File systems that write out of place and always allocate new blocks
 	 * need each bio to be block aligned as that's the unit of allocation.
@@ -595,7 +599,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 
 static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
-	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
+	loff_t length;
+
+	/* a device mapping cannot be zeroed from the CPU */
+	if (iov_iter_is_dmabuf_map(dio->submit.iter))
+		return -EOPNOTSUPP;
+
+	length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
 
 	dio->size += length;
 	if (!length)
@@ -612,6 +622,10 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	loff_t pos = iomi->pos;
 	u64 copied;
 
+	/* inline data is copied from the CPU, which a device mapping bypasses */
+	if (iov_iter_is_dmabuf_map(iter))
+		return -EOPNOTSUPP;
+
 	if (WARN_ON_ONCE(!inline_data))
 		return -EIO;
 
@@ -710,6 +724,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return NULL;
 
+	/* bouncing copies the data from the CPU, which a device mapping bypasses */
+	if (iov_iter_is_dmabuf_map(iter) && (dio_flags & IOMAP_DIO_BOUNCE))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	dio = kmalloc_obj(*dio);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
@@ -915,6 +933,17 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
 
+int iomap_file_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
+				   struct dma_buf_io_ctx *ctx)
+{
+	struct inode *inode = file_inode(file);
+
+	if (IS_DAX(inode))
+		return -EOPNOTSUPP;
+	return bdev_init_dma_buf_io_ctx(file, bdev, ctx);
+}
+EXPORT_SYMBOL_GPL(iomap_file_init_dma_buf_io_ctx);
+
 struct iomap_dio_simple {
 	struct kiocb		*iocb;
 	size_t			size;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc7ae6327dbf..ce97df81c644 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -682,6 +682,9 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
+int iomap_file_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
+				   struct dma_buf_io_ctx *ctx);
+
 /*
  * Fast path for small, block-aligned direct I/Os that map to a single
  * contiguous on-disk extent.
-- 
2.43.0

