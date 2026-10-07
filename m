Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D883515F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337411; cv=none; b=Flky7g4UhCixU7ut9UT2CX+OMaiM5F3U/L3sNYoXSHY9HP31vUOzN5tEZOGfbIS4SOLMoZRCjOmR/FO78gLLiBa6VTt9Rreq3ZZHmusOfUAfBZmBV8OUf3w4jzxL7dfXFjKu4MSRNgxgNGKDRH5dVkdr/4M4owKZxxMVrQ2VKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337411; c=relaxed/simple;
	bh=3Fg4fgarhp43AXGD3uCEPBH0DKGK1BrLFUwZDank6PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+I6GaUzqnaTY27uLD6HL1uP2zxw15KRFjc312k+NtkhM4aT7/Nh3iIvwlnvtW3y4ECtSi9kJ2Z3UcnVoLOJHDLJoHZL1OntFIkLmC843ueoLA4cil5ERnNDsTkzBlyvC4RtEv5JJgzHchkactFv5wnEHSkCO16vX5oiezQn35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqSNZ5qk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqSNZ5qk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so9628735e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337405; x=1791942205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=YqSNZ5qkQcLj7Z/Am/VKzas78A+ifCaj44BgioYiK2/agpBkcouIRBePNtNuuPZCnO
         SPX0WoBTcP4T5vRu2atIbH1kppyR2/hje50UeqECH3gq3YzEpjtADOdDF/8oHjMpbShb
         vnuwgf7nQv+ymslEEKkSjrplhWlGhG+oAcIHyoBRv8k/gosVtrqYY0l/OrEeCeyXJpYM
         /zJ/9TpRMSCfB6r0O+0mzfD8LU53GAdX8w0N22wQ8UZAC34D7xC0o6DFOlFOL7CN7P2+
         3EHVOz+UflKKNAAO6dd1RNfBKAGO1IVVZ7uefQVUlX0USAjSiLY6ffy1P0Cwfn0zAzAV
         k94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337405; x=1791942205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
        b=z49BkSWR8NG+UkL/F5Mm3Sok7h16yCha/QGPxxaWN9h5zfgpFqxiB5PXy9HSphYBQT
         A8lgSFLBKpaWUKyF8YxD3SVmBHUID0aE4rv7pdYELm40pIyRHJ7hhZu4M1BV6NarGUq5
         QWeRrY3EzBkufIy+Tbz48O3hu7jveTIXI5ETVAyqu6J2hDIXTSb4pC5hABrz1slhyt35
         Ms+5hbk+QXj2VKbQIh6qxAEZALvlY94mBWixeCyYsrlLVewGk3zVU+x3drkoL7DQz58Z
         FuZ0nW5uYUs9eU7PBKGitiltc2420g7L1rCV231QmyhwZrb8Lx6JTn4gQgEBnCk0SfrD
         w32w==
X-Forwarded-Encrypted: i=1; AKwUvBwqSrdMTkOxlm2cK8eTIw5GClQywsE9oEj237QnghoI0WDcFQqq63LZ14FwfvpymbNIQA40S12CN4WBwsQw@vger.kernel.org
X-Gm-Message-State: AFuF++lvs8SULpWjgTX+zA5DuS4YFE/iYaEnor2hro8LCxNlP1bv6UX9
	sC7XTrnbdxzSfAEzfQA53kgAZP8uRHk/B5AulUqOyme6WPzJTXBmtFja
X-Gm-Gg: AYBFou2m4h3u6BCf1VV5Kkw/7VYfS+YmmOSC7vVBfw8zvX5I16zDPVYzOilKmLwakLw
	Cq2dcu/oq4vCUt/N0yUzxyw29o8tl2H3Mf3WaprEraRkLzLyWDufKNnxSLD1Fn1DrdREwVmWrYc
	zvF/RUCb29gALMorey4F7zsJ7D6oN7dGxIIcItkrcDbCz9SrOXo7e0m3PHTyAW5w9KdN3lXWtG9
	tbi5XVhffyEjWPfoS3uaSIx9RCMHe3s/xWTwYLtdq+b2afmXr+Xm1RooMG3iiktGa543FVbGS/P
	xksREj3lZqzhi4uzXyejNC8M6k/9VIWOj0d8fTw+Wg+umdT8DQQ7n5DAk5kqOO8I2HHbb5vq9m7
	F2DTMp/UX9UxDkPESlAXI6QOJtJ0kG+Ii6h8zn4LyHk3kSiGUX5T+rlFKfHu42FmpXjA/Z+9Ni4
	N+ZGqz15TZ+PFZbhMJEEqSMrMtXqqlpimeSZtsCNL5kYIgO/0aGeAiSx3XgpN6IfIsMSSx46b5c
	2PuExv27EyySz1Eb4feMWsVsUknHlrDBLJ36TcEgfT8Q9ZszWRGGn3WKAjjDegOnOCT4rDJIe7T
X-Received: by 2002:a05:600c:3e16:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a1806649afmr7712265e9.30.1791337405094;
        Tue, 06 Oct 2026 18:43:25 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v9 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed,  7 Oct 2026 02:42:52 +0100
Message-ID: <82a5ed8b6de7015b9ec3c6aac51ec2597749a1df.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7e58e9d96055 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,13 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov);
+						   struct io_uring_regbuf_desc *desc);
 
 static int hpage_acct_ref(struct io_ring_ctx *ctx, struct page *hpage,
 			  bool *acct_new)
@@ -81,6 +86,15 @@ static bool hpage_acct_unref(struct io_ring_ctx *ctx, struct page *hpage)
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)(uintptr_t)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -398,6 +412,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -411,7 +426,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -870,26 +887,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov)
+						   struct io_uring_regbuf_desc *desc)
 {
+	unsigned long uaddr = (unsigned long)desc->uaddr;
+	size_t size = desc->size;
 	struct io_mapped_ubuf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
-	size_t size;
 	int ret, nr_pages, i;
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base) {
-		if (iov->iov_len)
+	if (!uaddr) {
+		if (size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
 	}
 
-	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
-					 iov->iov_len);
+	ret = io_validate_user_buf_range(uaddr, size);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -898,8 +915,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +937,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret)
 		goto done;
 
-	size = iov->iov_len;
 	/* store original address for later verification */
-	imu->ubuf = (unsigned long) iov->iov_base;
-	imu->len = iov->iov_len;
+	imu->ubuf = uaddr;
+	imu->len = size;
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
@@ -934,7 +949,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1001,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1025,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.54.0

