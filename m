Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA23515CE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336741; cv=none; b=CWbWVAV+XoYLZYQPhgh3TJWoyhS+3QA0bDHTW9kTk2xQqHcbNPpjGNlnUu7HBHPgI3f3/IdDn4Dk0HLKu9XDO62RmDqSljb1NhkCjNjWx7psCyxLW6BlBbamSgxwOWeIdyscQZmprNaQLGuvg3dfzW7ltfJVcS40RBCwlx+PRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336741; c=relaxed/simple;
	bh=L6TVWpongEDpA7TiLe+SNULpjIEu9UzpPIkgkHUo5Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyoEJMUDZy1y4hTkbSZE+veKOtR8/9Z9DEZjN1fbHqB0VWoVz3wksm5e83e3P0WjDDFKOrMJlx+ngvyYQLhlgd2YrNngB4lD3COsfCU95yyaLKTVzN0D9BCaJvuVfXcbRMjwOvrOUcLJzQC63Z/Eo5h4xiD+Sv6QY0ARhiV0kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feCTuRIZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feCTuRIZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so9155045e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336737; x=1791941537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=feCTuRIZvnkS8I7qUEPadWa0pd9z6YBurrvYRw7ylfWbbKjXjSFxIK73osVo9KK+Pu
         ph3Uz+rRgMFRsK3NqZ0Duj7DqQm50fyYOEoAkGFFuXu1JV+VPZ/XXbA2dSiCu33IzPJR
         ygzziZLiRBd4ST+D0YLJ/QsOxcqysJ1yLXABVqho4a3cEyN987n71/Ig2XDK3R0C5smc
         AQ7e4MZeEBwLHNLWmKdK+FsH//6a/EZoICZb1p3p7Emet9s9GH/A+wtWaeEzeEPTijxD
         uZVS7IpAnfxdy665TtbdURvuV9t3wWcoXb6LDPJLptY9612VqTiytqANhF0cpGjVyQQE
         8E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336737; x=1791941537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=U9TB3VawY+0+U6u/giYujVeZU59zZADEDEdQgBBg8bQuIuCDFG0C9dOPp+BxpqhFgg
         AkIt0/s1VloUUqrIFWJukTzSO1+3Dy1hsFkgOoUXLe1JBDnVc9Fd6SB0jCtF91qk3zWp
         sz29u7qvGgO1PILQ0VmvIPCZkLqsCzqdvkL+ieIhMM3TnPm7eLXAZBLcFEIxhUXlFww/
         LT3oo/PFCDuD3qKiY7vRAkqzIhED3RbARCOAqq+8/DSPYs9zkyAXn/WXO8J0yIQ4wvFU
         RNoiiJDBaIGbYGs5zapNR3tIg14wDA1Wh3eZEgtRDc4ImuedfTqefGMY11A82NVt9gDz
         CkrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ220WW+abY75X8DcZ4L3tshdPcLJHaJGobHW1mFc47qb0L6CblS2ka20PXVgf9sbs5536tU+8EX7gCd2w@vger.kernel.org
X-Gm-Message-State: AFuF++kl89zYJaTjLUZlStC2ofl4qQIRLVq2xv24UhcO7OJI1Amx0KWQ
	sSCrhHtx2a8mnvojaKbJ79HkBmiNGs+A1buCgBBHxP0VE11WrlS3PXyk
X-Gm-Gg: AYBFou03AVFYPZ2xzEdYhLAedhpMan8+VKf+0MyuUZ+GgPBaiIlXlhEeA2XYio0ires
	3vYQ4E2qxdBz7mP9tXgLQ/6hjOO/ZbFQf3u7Jqu5SgcRkLMw+mZc+cPe8Q5zl+gNm8k4Xy/YBta
	6z4qJPZNCYGZA0pqp3wQQ87IbssqYOcbYSBRZQ/TK+ajX6YG+cJv4bK+YhkPXsxaBjRRtCaEBUd
	Ahpk/Gc/SP0puP7guV6gf8sTxSIaUaHmYLtqxyjTSyDxmFYH19sf7AM5WHdGdfWLCqim6UJQUse
	oxMHWRx6UKOTyEXeJF+af3sdFxYFlJovo+++Ha5ZhQ0dp+Deq7tHv9+jD3L4//GOAeqN8AQ1FKA
	TVl4YeMc/BfDEjBY7/tgmlJ4eJV5mlYa/GWV99LBxPaQ0aK1u20kxYFdCB8HYzDO47oQHD226f/
	5bVmjQ5I3Ap2KSlIvwsv+56T67oWld2Z0irrfFLL0A0ydlh9m2+JF7AtVjspGEv20kETpMjAZy6
	GDsDRZZ9PNFLnasYa1o4EyoXdlCpZ76Y45JfCGkHHGunHGNfkKuKs1Gcwxqco1fHnyasIYhvAFo
X-Received: by 2002:a05:600c:820a:b0:49f:f9d1:e618 with SMTP id 5b1f17b1804b1-4a180311281mr8069355e9.17.1791336737511;
        Tue, 06 Oct 2026 18:32:17 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:16 -0700 (PDT)
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
Subject: [PATCH v8 03/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:31:46 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
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

