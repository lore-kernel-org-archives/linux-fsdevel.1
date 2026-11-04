Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751568;
	b=rnNvRiEgZMZu3pebpmPd+5Z0cOcimZbmxLwqX/YZtpsag9uss51NHpZZ26itPFCPewAt
	 ymCAetV79vKCkedHlvK8iSdfQlApnt0yNc6RqerSIIaSjAWt/ph/t0KDJx6KYc7w5wt2T
	 OMCs7FzscoGBfJbtNrtuBlN8ORDx72LIDiQCiJGc4OmuBmIPr43ryWiFr8efBfXOg3kpR
	 H9/fA0WWeBAvBrMsHQSok8N+A1i4wDO2tjKRxHsce4uzGOB+BOS0vfr/rmmLzo/O8y1nQ
	 6LAfV6wyddY/eXIC6/DaDhAlXHgfSUlQ1cQbgqop60abKI6MzmcIEJImJoNiAHsUVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
	b=1fPeoeYTD50A1znBf/5qBj7ITSOlhOTLgsh3skUDRIQZP1m5whn0lwBlyArEUHrxWkuy
	 iACoYP+Ow+YSSS1tVWTqtvcVRSicpDTd6O9141uP6d4S/6X8nkv8KIwQqiJ81hIhm/NWz
	 mVrDwsYoKW34Ox+vFnRtxU0YPQnotROKL7KwOzSlpSr2tHLOKkl8XWMl0gn5ToQiVNaON
	 /twfYmtYlWPTkiYC67KhgBE2JxxTqWb/H7x2Catek1ezUwiTl8qB5rALrE1VccMj4UP73
	 svOaieNlzuP3CSLYyehu+tDc3VL+saxJSuDcQajmJsDYZrb2oamGNWMvLl/hCT5glGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aqcmbjj/";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6793606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6793606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aqcmbjj/
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20edd106so90943f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751566; x=1794356366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
        b=aqcmbjj/IWzOkhPn945GltKgVAuWp1ceWZ4PcwlLjSUgP3pgLCeRJUSh0ZCERqiyBX
         BRUEwzA5Z8xgKIav5x8qMnG0g6orgm0+fafeQJR5uALlpITJemgYZ0F1WH87wHcFvnBU
         iOXxLrnLQwkdRO6nlEteWgXYV4Cv8LIP1HVaxL/mqH5vQt8+NxjuAL3gDJaGtaeRBNWb
         e8y0Zv3LmzgJgaHpG2wmrWPuYxkySs/xPswkQ12biHoWXbmGl6Os11AgxGOZb6W563OH
         dl/j7z99E03O0iXUVwWY/60ifcs1WdhHNDnyeOd7gotcaX3uexLytaLZamiZsZMwyWoK
         20SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751566; x=1794356366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
        b=e2qSqyvPJBNijCbfiGyyRxMFDmLiUbxDaQLIGp9r/lqsxxmGJGkvJlCIJ3lzY7zH7P
         T2uOj+q8Dbig4uhvmQuGTTkkC9QD/ZVB4bh5sbbx2erV7kTr1aHO/NZZlx6MeDOA6Q2R
         vbIZ1PYwTDP5V9Q0Xa8A6bwkUiOPWiWdrJoOFYCbPUX8Xx0nFA4aSORRIkfI9l5Y+nQi
         znGTuDQYtfWDxLm833Rz7Vd0oyw/xoro52uwlEM2HPjSHxdAt2QXMCcI1qcj4c4GNvxb
         UiPHkKLQ2rsj45qD9vnLjyC5NLrfvt4d/yLgFoU4PPuQsjFaR41nTSQuVJK7d2rag9sO
         ghXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsDD2IDAvmM3bfie63XrqIXEguhjcHAl1LlbP/wNSIf4NRBk/VYAhVIEMaf7xif6sl0DPmugLaRB7sO4Yy@vger.kernel.org
X-Gm-Message-State: APuU4Z8j45Y7dbyvn4wTMsilGp2gzC/EYL7Ttm51dJRaA3DE3cypgbz3
	DTiCTY3OfWfsNxBhxXrWdv03429JpSSwzSxDVMfy+0t5059ZSg14Baxi
X-Gm-Gg: AYBFou2LPEFV8vWCoFx+sCugzHtjOOdMSl3NVu96NMD4vcB/Zv70oXyG/eWH1Wz57GR
	/Dc4TiEC+HR/f+JkwIYogrqRrKnzWGqtUom9lUSS7Gce8RVfXQaRI6R0vJz7aY1KJz6LuzQ0m9Y
	KUUFB3KC2bDfnoTdRmlThONJSAOQxVkiKi8h1lGM5NoIBTXU9mTbbeIHhkyCY3ymJKiVB57r9rU
	KULnFtDVk0P+f2b9cZoN5r3xxfgy/fssiIwJOuDmNwmChlbXQ6R+iQJ3blcjlCuPfuSU69ZXGDT
	dbFb6msAMCgHizG9AIRcRX35PpBx257xBV+HPTXLGzFsGloA0rg/r5nYxG6yC5zMuo39LYmeRyP
	hHTc9Q26hzawv5KZv37GsOhWJxW4m956Cpbk4xzgzXUcIV564ihMJQ/iddK+UPVYkOdKolNZc6u
	829eF4i8pWYz+Y4PaD8SAzBpJ14Mo5dCqDt85eFNsKLZBddX8X8BcUdx7l7ojrm/Fhikpw/atdV
	/XKN2pgRxKkRFsuJ+5+XI2050Vx5n4LF04YDcIE4Cde3sauV/dC9RK9cO+yPnZnzSYhWUyoEdLL
	MC+5Wad5P2SenYJVRx5O8HB+ACc2qFLQyEZOs//QsRJxdy5YwyEcPttQZ9ST26Ycc21+sZtme4X
	zzprtrAe5hCqPcUWlyGwE7n9gQajZEn0=
X-Received: by 2002:a05:6000:4a13:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-48e6e2b9ce9mr32274342f8f.1.1793751566267;
        Tue, 03 Nov 2026 16:19:26 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:24 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 4/5] io_uring/dma-buf: switch to tag file filtering
Date: Wed,  4 Nov 2026 00:19:00 +0000
Message-ID: <7165ab453cc680276b88f47f9ae89bc4967543cd.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
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

Instead of enforcing that a dma-buf-io ctx is used only with the
registered file, allow sharing using tags.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c | 3 +--
 io_uring/dma-buf.h | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 6f1d21c0f558..f25749f7da22 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -4,7 +4,6 @@ static inline void io_release_dmabuf(void *priv)
 {
 	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
-	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
 	kfree(bd);
 }
@@ -52,13 +51,13 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	bd->target_file = target_file;
 	imu->len = dmabuf->size;
 	imu->release = io_release_dmabuf;
 	imu->priv = bd;
 	imu->flags = IO_REGBUF_F_DMABUF;
 	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
 	dma_buf_put(dmabuf);
+	fput(target_file);
 	return 0;
 err:
 	kfree(bd);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index a97412ebbb3f..9bd7c8c64397 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -9,7 +9,6 @@
 
 struct io_buf_dma {
 	struct dma_buf_io_ctx		*ctx;
-	struct file			*target_file;
 };
 
 static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
@@ -63,11 +62,10 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
-
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	if (req->file != bd->target_file)
+	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
+						 req->file)))
 		return -EBADF;
 	req->flags |= REQ_F_DMABUF;
 	iov_iter_dmabuf_map(iter, ddir, NULL, offset, len);
-- 
2.54.0

