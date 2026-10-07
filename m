Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD983515E7
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337403; cv=none; b=ZsOTtgfdWDKFh/NAkPCZD+NhhDYR1yTYDPJVUMyJY5uXtIFrEmT61/QSGjCQdrCoFz1Ojh0IhmFmh9sj4vEvMBJ0qUAk+OBKdAsJSshFqSCUUh+orMbo233wH50taTha0MoBjKjUBo2bEvXw3ywaoGychp9zG47dae5kbwiHfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337403; c=relaxed/simple;
	bh=L6TVWpongEDpA7TiLe+SNULpjIEu9UzpPIkgkHUo5Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPtdbtxEB42PE/X5rnvnDtD8sV6SFwrRX1WWEQtecXI/q5ivXwUcX44vHvCwIGAT8jJNrj165dORbHzqMV84uvuuiVHF8ZZyGWWFIdP80jNS/59QkPH/Iuaz0/CENqShPXhmH/Qez1/Q+yBIuS+JoGynMegNOCzxjMZ5FC0SeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHUxMFdB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHUxMFdB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so9192745e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337398; x=1791942198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=PHUxMFdBnl8loPA4gMlZ1Nl0KX3UihE9mLzk+a0dSjbj8L8hiqK2iRPJmJQJfirjjl
         AyACKfhq1XPG8uw8pqgDDQUadYE2SYYr1W5fH+VR1gKQ2dkFTixU3otk+G5PMLofx27J
         avEgNEYmNOavcpoMackgdk1vqCVCHTaSa1jwf+rmnjrW/+lMr1RLXaazNs1/Wy0Y1Dem
         cchGM9TS/6P75TT7BulwCxcUeBiGpVI0ulGWIgUJqG7cS6PsV2hGiAF8jTBZn3etms+W
         2ayi90jkjlH5Re3EgzybDBanHh6nuB0belXcMhG/k9Q2v5Y4JFEGQeTrvs+NPSVr63Sa
         PHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337398; x=1791942198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=cm0H4zd9MSNrqCfVUzoRS7MB6IF2KOgzw8wDlcx3h64Jhe4DBAT7EuaEV3FMrhIeHg
         75TFmZw1L19jgtdhI9IUcYDm0uHlyB9Wxas8ilJXq839RLUYZlgoXeegiboTSeC3vMKX
         46WLonQi0QMXZFF+JvhjLlkuuUxogpTG5R2L8I8U+HjyDKFIyxe4Z5IOIV/RDI07nSzC
         D8VMMCBEWWY3XS5IBsB4K3VWEIyrVyjUkL/CGWvRiPb0BYi+6D4tId8th3ST0ZV/s/v7
         7xuhOngCimyQC404g1xlG8NXZnTj0nvkjZf7CxMpCQwjAIw28D92dPb//B4LJJaENzuQ
         QqJA==
X-Forwarded-Encrypted: i=1; AKwUvBwR/KUfyIUUYQ/WdZ5NTCVFx7q50l1lNB3L16h0BDUI78QlLwWMsTcal+qyBeYVcfzPHC+1bs0upINkeM7H@vger.kernel.org
X-Gm-Message-State: AFuF++lCRoWYCuSEdZ5b9E3Y+SQRCs7c3fZN+yuh53up+ic3XZAWT6uR
	NBPUvpku7FKXUMaFrC7H5J+lVbpFYHhJ+T5HicwcLQjSgfvZMrYnfHf4
X-Gm-Gg: AYBFou3cGpNuLTbXbN2yNyLYb57BDs6gWuokFSlwrJd2gi4uQxLJxp7aH+GNv7A1wKh
	Xbzaly8g6Ega4POgTj/sN0hwf54yRAo0EoZE9DK+oq+RkU4kzWZ4iI+PiQBRn8Foym28faFUrpg
	BGyGrYvoqHSVd+RWPi0f44ARb1r4cOsXzMx/r2kp8HioKCDaeyKqsQxhuRAI4BIJYcaAqJkORdt
	Rfk03jrgVwK/EQ02Us73PHTA8gofX/VXF5lYhj7+KVfYAtqdjxoQmg1MS4jNNY+2Gmg0U2KtNmd
	27/+my+6sLDbE2SwvnMsSEbnKSX4cyGsEwJ/ZeuTzfdDStQSQuc4KezCjQUANkkFDuzZpkB02wJ
	FxV6/xBrcBM09AZuCclkUE8tG+9Jdh859sNNV3E6R0RSFEoB0IzD3JYpq0L/A28Jny/sLsluQWP
	6Kws+oGtGm2VPrLtEzgctN713cjwqc/MtnjOwHiodnTmF9VfhfAYZALim/o4YThBJ3NZaikpuZm
	/2rOUrV9qiZPwQPi46iFIQjjkocNJCNbgkLQwaAsIW+gs2QKJb3+IFledOKYw4iDiETcJ3Bf8yb
X-Received: by 2002:a05:600c:c16f:b0:4a0:2484:2800 with SMTP id 5b1f17b1804b1-4a1800ca1c3mr7313145e9.3.1791337398229;
        Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:16 -0700 (PDT)
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
Subject: [PATCH v9 05/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:42:48 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 22 ++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..e9da48ab73be 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -730,6 +730,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	if (unlikely(iov_iter_is_dmabuf_map(from)))
+		return -EOPNOTSUPP;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
@@ -855,6 +858,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to))) {
+		if (!ret)
+			ret = -EOPNOTSUPP;
+		goto reexpand;
+	}
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -958,6 +966,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -976,6 +997,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..2d5c30823aab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1599,6 +1599,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

