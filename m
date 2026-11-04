Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751565;
	b=22QrqiJdXh/cbC0DyKtjXGROjj64ifAnyt5V6rA5no6AlQ1dLagvGucPG+66wLXG1HOU
	 4cf0b048wO+7eBpqP04MNtVl7UGfuwhoBnsWCbpPakozSchjS8BbEzs8sj+VrwkDhdgz+
	 hEpaZ1jwnDYJ1+B+BZ78zYbgkZrufOEqbk3XOA+rLQUaFHdvLgKQq+7gpnmYTx3rEeKVR
	 GlAIiRFku2fzudPP88xah+rT/D5EOPA3GsvPQuftoeeMAGZ7HGr1KTC0eaz9LOuf7Pkme
	 +f8mrM0x1QxtwiLlUR5SdymFdqnC2tKlMb89AkiJygjYmnWXrOuJXGnrdkMlu1bIYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
	b=Q2/NAjWUmO11LgSvbPHkfqW8UVn7lx8npsQcFKg62xMooOQSQJRg92HWw2WI2Q9p5JqV
	 tIrH2NuAR6GSeZQ0106hJKsMEwGsZ7fW9qWwqq3cciTsdm6SxiRiXV+i9y20I128r1NLe
	 H0INTf9n0TEvEOSH1U2HgS2bhgzlBUJKf8QIRUl2N57NK9tLDrd008YWJaSZ5WlhVhCKe
	 vVRYxTYgJDUwWB+0yusy3nCZ591TpcameDZ6nPdO/bgnu6CxYhvNqAt3hWnZv/65OEXdr
	 uAWl7QhlKJHvJYqd1gA/OUZ0zwnqJEra/cD1Spi3b5WerfSeDmKjE24mLry2VDMQsug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubHDxxZj;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D86606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubHDxxZj
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df8fe8513so126798f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751563; x=1794356363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
        b=ubHDxxZj7rU5XinezEEZWcKP0nRzW3AwNFt5hy58vHf3T1o4Qx1PHGZgNPVDniG8gJ
         cYrsILGN1FBWy75lXmZUSYF3+AN1Svm3edvlRj2Sxu5EvSyHtoggU6vLH51eJDpSrK5T
         10IoJBC2S484EOwmf/KQCB6+54VFFbrgZ/QOXvI6pNj6dVEo+8UhDLxVI0YHlToXNxFO
         5cHnvS/z+1Nc7tzErbZvOKmbxwNteSUlofkVUMWJClgZQsUpoO59CNT/sTHvpf33zI6e
         ysaZEPYfcdyEJZ5k1dWEusf3nj78SP6JNirFZ7APQYBR6SUmK9u9klK1nv8jERrTOeux
         A3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751563; x=1794356363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
        b=QvifhCAMnnUkQuH1XL/uMtEQ5Qa6kM2oQSUUVt+fYQop7H09lsqhzFdil846PCb8TL
         J+hb80P4ldqeTgbDe9lzrR0hnfQqWIwY8lAM+cU3yvUZConPt6wEcM15ofuXC7rbsVJG
         DBss+W+ZxwXeIbN5N0fDKDFi7+S3DJ5jKCYfzgNSAA7XokRfMxl3uZTjZcT5TQSLObTU
         L02Q23UFCmeZ5JCvXtGABnnXGUOmONuAEZoYA6jtiKcRAfSVn7jlQ2X+7YxD/riRWnxA
         AziNLmK0ruajzj2GaIBZ3bLfBPfmSwWSuLohP6RCXdW12BhyjTX/3BEdHJ1ottGNpigb
         yb8A==
X-Forwarded-Encrypted: i=1; AKwUvBxmAvgLMueSOB0iZal31k3RkBrYKKMqas87jiPB+twXcEjBi4CXL28d2W+GXhEBJqrs4axHGJqrFYYvqBV4@vger.kernel.org
X-Gm-Message-State: APuU4Z9oy0tDH9D11etb1eU2ftVRhE+ibO93v99qz2gICVUj2RcLb/Mb
	vm63BcHpxOKJvhYUsLtEiq0Am0rHkE/vKPZEFpGdPt8M7QO7b8VGxjsV
X-Gm-Gg: AYBFou3UNCPUKmmobMe43uWhqID7cBkKNlZ8PeSZWA4YWMk3P0ZL2uHAOCmjLZ4IMrD
	C+h6TMhzypTlsXwHxFCLBomOvg+LCrxTegOAl9v6mnzf29fTbrRV54/FHStNsPrkt6keKbv68cS
	LG2V4ds4TPnTzO27OPaVMQYBo67lQtCGCjJ256Sf1XcxJqdMx6zkOYgZSVy1QMRNKcs+szfxEHA
	aPxVh3Q5KHjdmzZNgJcx15xoVXz7SiHMkLDv8OxCGMfwHqvUqPDG4iy+Yt/FJYxmaBDPOuKfjoV
	7HIGU5oyZOMJkt6a1iFQmu1Ben/O950LtY3/tu5M+Pb12IZVzS/zwnhULHFrw7D9y2UAMGbYq6n
	Z/NU6ORf66P8lhCAcNRYfJaYDraR3HJVP/cNvtLxtEf5jBHkGFP+tuCpBre1Ak+8HfEmxXFSPX9
	DYoVOPy/oTDWvVS87RBpOrhzeWeQQADb+wWjCy4m66lTZupXX8VyUhdaeAVgbTEb5vd7dxxAG+q
	Gier4kRjkVDsbHjk3n/Zl5uJK47Xm8g4ZY2rBl8qpNjrP4iRlEP3N2G2Ju4GkD476CgGzZnUYtR
	RDsFVQasOIi9CWpbk2la5T48a9a4yUmaBJ1cEgvHDwvqNq/ErBLP7QS8Qmfw8SjqqfKb0i6zr17
	h8Gm5HfgByeeRtuAFuGxLC2Zj2E1GBQ8=
X-Received: by 2002:a5d:59c4:0:b0:48e:3085:425f with SMTP id ffacd0b85a97d-48e6e2dbbdamr34641010f8f.2.1793751563267;
        Tue, 03 Nov 2026 16:19:23 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:21 -0800 (PST)
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
Subject: [PATCH 3/5] io_uring: add data to dma-buf convertion helpers
Date: Wed,  4 Nov 2026 00:18:59 +0000
Message-ID: <e9e74cb1d6e46f62e29b0934fa9c1e7f2d2c1e3b.1793751001.git.asml.silence@gmail.com>
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

struct io_buf_dma is stored as void * in registered buffers, and it's
casted in multiple places. It's inconvenient as void* casts can't be
type checked, so wrap all of them into helpers and keep casting
centralised. No functional changes.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c |  2 +-
 io_uring/dma-buf.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 132e3d0d7023..6f1d21c0f558 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -2,7 +2,7 @@
 
 static inline void io_release_dmabuf(void *priv)
 {
-	struct io_buf_dma *bd = priv;
+	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
 	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index 534c06b6879f..a97412ebbb3f 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -12,6 +12,16 @@ struct io_buf_dma {
 	struct file			*target_file;
 };
 
+static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
+{
+	return data;
+}
+
+static inline struct io_buf_dma *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
+{
+	return io_priv_to_dmabuf(imu->priv);
+}
+
 int __io_register_dmabuf(struct io_ring_ctx *ctx,
 			struct io_uring_regbuf_desc *desc,
 			struct io_mapped_ubuf *imu);
@@ -39,7 +49,7 @@ static inline int io_attach_dmabuf_map(struct io_kiocb *req,
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
 
-	bd = req->buf_node->buf->priv;
+	bd = io_buf_to_dmabuf(req->buf_node->buf);
 	map = dma_buf_io_get_map(bd->ctx, nowait);
 	if (unlikely(IS_ERR(map)))
 		return PTR_ERR(map);
@@ -53,7 +63,7 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = imu->priv;
+	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
 
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-- 
2.54.0

