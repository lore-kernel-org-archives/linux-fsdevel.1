Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751571;
	b=PFgxcpMYAYDqo/rEUvjQq+8K2z0V6He9XuQOLUyG9VlEJD2T06141a4GhDpr7k78OQLW
	 e+H877IJKvwlHFj+lp3mZ4vl7DKFAIr+mXyKNi0Sx4wR9k7tQ/Hd+e78b9ZQmGOkVMjJp
	 +nTvxOgjvxJF7zSnTMIdq2X+qIStpM+x36xYKvUG0lEMunsJkujlK0QxBlBqCYdgInvWn
	 tNGFLHi7XmiZmB78RzImoeKUnFlolRt53hAVBj1Fd1RBdUYegY3IzBcDaj3eeqZwbgiFF
	 v7+a2eGwBMMieZmikcs3pIILP66OqtQz0bU8+ys9vkf8pkQG+4Tnc2ZavReDI2MzPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dhpcS3Pos6bUyhlWGcG9OokPKtscuwoJw0ESCtzmpvM=;
	b=mt5Z1mHU0KcFjteHhoIm2X6wXHMXGx1MIr7CNk26xB047NTQDzBFUchwyhfCeRm+K0L7
	 Gw7LXFAzHDcc1VgnNeVROO75ZmiZG5CGAAxdfR0k9/N1EORDXlCyqgeA7wHTcFvnyK9T0
	 Un3Zg6aGkYNhIA16cOxPM1SlNRKihFHWygkuAEmnFoPbvYuriowzfrVAC5EYMdYw8p90G
	 T4ZbNB/1DCu0uev5UdvmwyVixLrLmuhlU332PoFDAVSx1REGTIoguvYAaZmTSaR6Mposy
	 skn5KgffL/RcJceAeT1t9/aUyuGYUlNUH/hF1I9OyEkKj53PR26J8Be0tYcu4Ze21pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q6Nzpwyg;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEB606A32F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FEB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q6Nzpwyg
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4f540ebso56792f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751569; x=1794356369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhpcS3Pos6bUyhlWGcG9OokPKtscuwoJw0ESCtzmpvM=;
        b=Q6NzpwygdE433wwbbo5N2lVV1nDLaE4ey6+emdzBu6O3wovWkCqFPmJ6dfDoAoJF/b
         5LyNOdE3QbbljfJQEI06XAAOfwb9rAsSh+UgxMGAtbC0M9YgIXbr3Hslq8ckS55H80U2
         +jccSBX1o4TC3CnzkFJHJJx5YHTfhoH2w8fGybU0UFBUV2V/biDRg/PcJP/Ex+N5yQ0f
         BS6vR9AA2nDBgqP7bgurufhFz4WV1aN3N8dy2DlkeWHBaZcvSmJEBgsqzw+8a87fBuzG
         /042ZlJ5EJfTxVOtwxpazkhc13m2TajmP1OFtXEPbxdPyKQqijJISNCb1gvu1eiB8hRN
         4sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751569; x=1794356369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhpcS3Pos6bUyhlWGcG9OokPKtscuwoJw0ESCtzmpvM=;
        b=rx96dRPA+D4c7ora9CAj9eDfkJi4r+qfeJ9AF8ESyJPbK8xniMU095yYTE4dJnTHDn
         zqcID10oexghENf4WP0tZOw2/Jja6cF8E6TmWy6/OysXFYh1UX0VOIsT1fmtEKBbDaJY
         SUIrWcN9QRqN+Fc0FGvAZUY7rWb5PaOqArPlhb5c0chhO/r25XEkVv4VFhkC9GrgAPUf
         oBrr5kzYGayPLBgrOC0fao+jOhPbUIDkm5kmiwFdjt1kL0nW/nlWBjK0kMUs1vI99lkS
         wLzoO9jbIW8nxxgAldgDMOqOwLAx9DUGqeYU+jyLGYOsXleaO3QwrQZIBISHtRRctw+l
         6P1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9DXWIAJnmj+PUQfHdU9SIbrLUgO5/VzaDrI+wHlqi2nazSuWPZjyfzijtxILFgDanAbrCuQ96jzQ/TyRQ@vger.kernel.org
X-Gm-Message-State: APuU4Z8zzCeyt3nyM37lwmfQU1I3BLzfc+ogi/gnp6zU2COjDKWnvEtF
	353ZgnnwvU78PekvHFNtgJxpcNRGSAV1DqR50aShshS254cM1kzxdORTVe2IwA==
X-Gm-Gg: AYBFou1cFRcy1KVqtGmYx+ZRzR0FDH2SV2LwQANcWf92lE7PhA1xblM7wVsHwkBzEsM
	yQjd9Uo2nDhqGpGeUMrcrQS1tpouR0ECDTZVuJNsq41UgiKMOGNQdQXVLGXETW4JDe1oJn5E6lO
	mLELn/o7r1E6hLjoPnFFtAFi0/AKj9lrTJprbLehRnuQ9NVBRnZmG/Ab3AqudWoJP8makxcq/kK
	pezwZZ9cdp0hga7ApUAJkkyqe1BEzwf+9zCecni7k79lnTf4VKlTOgb0N6jEnclY40mLhYwq4Up
	IGSkCBMqU2fiLppFpztmyWCRgvTjDcBmNNXGzHHNpYdp3ZpqWv0oinLwa6psQ6cAHdGojEJ7M9X
	QV4+VZqyAvUyu1qyQjYadSnIuBBBNKeaggomQx9AF5rKjRXVYjYc8QPNmKCCGvu6/dYnePsuqHP
	G3UerE/Tl/+fbOAPOeF91FayjlFCCLB6N39uLsjD7fG8fwO1eWOR7KgzGANmDdWUNQwP2DeqZkW
	igMMT7CKovzVbyMkfgD6FdsDyC4qxmwn9cBdqnxw47eWPgB2sMg7Q4Yu0E5KADcln/7zUdWIdgj
	A0DEpSGpM0x2LmNVRVOxlq08Mwb7qlbo7wUBG8UekyTPg5nffSBXLLrTu2iVi7J93n1U5Qr3Z7F
	CJnoOfMmNf5qzg5R/9nfpxK0MzC4UTSyz
X-Received: by 2002:a05:6000:616:b0:48f:bdb6:ca0 with SMTP id ffacd0b85a97d-48fbdb60d3dmr3036265f8f.23.1793751569507;
        Tue, 03 Nov 2026 16:19:29 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:27 -0800 (PST)
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
Subject: [PATCH 5/5] io_uring/dma-buf: get rid of struct io_buf_dma
Date: Wed,  4 Nov 2026 00:19:01 +0000
Message-ID: <883cf9fcd8e46569ec237e9e36baf6e2f26db8de.1793751001.git.asml.silence@gmail.com>
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

Now struct io_buf_dma only stores dma_buf_io_ctx, and we can use the
latter directly.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c | 16 ++++------------
 io_uring/dma-buf.h | 16 ++++++----------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index f25749f7da22..a1fc34c0c044 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -2,17 +2,14 @@
 
 static inline void io_release_dmabuf(void *priv)
 {
-	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
-
-	dma_buf_io_ctx_release(bd->ctx);
-	kfree(bd);
+	dma_buf_io_ctx_release(io_priv_to_dmabuf(priv));
 }
 
 int __io_register_dmabuf(struct io_ring_ctx *ctx,
 			struct io_uring_regbuf_desc *desc,
 			struct io_mapped_ubuf *imu)
 {
-	struct io_buf_dma *bd = NULL;
+	struct dma_buf_io_ctx *dmabuf_ctx;
 	struct file *target_file = NULL;
 	struct dma_buf *dmabuf = NULL;
 	int ret;
@@ -27,10 +24,6 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 	if (desc->uaddr || desc->size)
 		return -EINVAL;
 
-	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
-	if (!bd)
-		return -ENOMEM;
-
 	target_file = fget(desc->target_fd);
 	if (!target_file) {
 		ret = -EBADF;
@@ -47,20 +40,19 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 		goto err;
 
 	ret = dma_buf_io_ctx_create(target_file, dmabuf, DMA_BIDIRECTIONAL,
-				    &bd->ctx);
+				    &dmabuf_ctx);
 	if (ret)
 		goto err;
 
 	imu->len = dmabuf->size;
 	imu->release = io_release_dmabuf;
-	imu->priv = bd;
+	imu->priv = dmabuf_ctx;
 	imu->flags = IO_REGBUF_F_DMABUF;
 	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
 	dma_buf_put(dmabuf);
 	fput(target_file);
 	return 0;
 err:
-	kfree(bd);
 	if (target_file)
 		fput(target_file);
 	if (dmabuf)
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index 9bd7c8c64397..c622347fbd76 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -7,16 +7,12 @@
 
 #include "rsrc.h"
 
-struct io_buf_dma {
-	struct dma_buf_io_ctx		*ctx;
-};
-
-static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
+static inline struct dma_buf_io_ctx *io_priv_to_dmabuf(void *data)
 {
 	return data;
 }
 
-static inline struct io_buf_dma *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
+static inline struct dma_buf_io_ctx *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
 {
 	return io_priv_to_dmabuf(imu->priv);
 }
@@ -40,16 +36,16 @@ static inline int io_attach_dmabuf_map(struct io_kiocb *req,
 					unsigned issue_flags)
 {
 	bool nowait = issue_flags & IO_URING_F_NONBLOCK;
+	struct io_mapped_ubuf *imu;
 	struct dma_buf_io_map *map;
-	struct io_buf_dma *bd;
 
 	if (!(req->flags & REQ_F_DMABUF))
 		return 0;
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
 
-	bd = io_buf_to_dmabuf(req->buf_node->buf);
-	map = dma_buf_io_get_map(bd->ctx, nowait);
+	imu = req->buf_node->buf;
+	map = dma_buf_io_get_map(io_buf_to_dmabuf(imu), nowait);
 	if (unlikely(IS_ERR(map)))
 		return PTR_ERR(map);
 	req->dmabuf_map = map;
@@ -64,7 +60,7 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 {
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
+	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu),
 						 req->file)))
 		return -EBADF;
 	req->flags |= REQ_F_DMABUF;
-- 
2.54.0

