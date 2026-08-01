Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCA21A42D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599383; cv=none; b=WAEUTyqcT/jmU9YVym/c2u5Sk3/9aPpg+69jTX8VqBBk5Kr2dGGFDkI8I8pXIXWPZzwIqD4BJtBPHsb+0FU0y6TRFHOvRwxT2KbVTOwAmsv0Q+jFBV71XgvWHAgsOCU35x6qXQuoP1QfGoGbZ4+6Y/n0rSwcQH7AbV4UW+2FFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599383; c=relaxed/simple;
	bh=g0r+cM2oJU8p0aW6ejF1reDF155X4adWxCLLoLHu2uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDeiCOIfXbuxJi9Uz5Pa1kuKX7cXLfME4VjaRPYnu32mQNGXnH/Ko3e5VWBz9eGq+LDTzQUtKE6C/vp7Rmbm3l08EC6jnuiqzGVTLJouI5yqPqE8z1gOpNrS6CLjJi4sVuhmObdELQsID6QtTJbvlEM1n91pItWs7hYSr++5e+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phykw574; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phykw574"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d01663d816so15299865ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599381; x=1786204181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
        b=Phykw574YQXrFOsxNwwUAuKFs97gDWG/x7biAdTYNgmBmxuHcAoz8mYAokHEBqiEQ9
         CDk8ydDMzaSdwlmktajb3Js/dgO6pOjiVb6rCrJLLWnPvQn530GyjGo6bWqXfns7sy4K
         SIy/ncATqOp1kmsB2cpn5bZkIeJSu4/+fMz8JBCr14qSRz6S3a+i/XXknL3WLz2ogeuq
         Jn/br9Op2rMlMvzLg1TZrj+S0mngigDj2OLcKfYHeC1vXPy1i71TBGDL79FWylg/yU18
         BJbtBRhV0oU2RC94desVnsFnNHzKwbyH9k8khD3hojHwuF+4pN1bcRiM4NVhrw8s9piA
         6Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599381; x=1786204181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
        b=Y9/hG31niKdF7vyNhhRnm6ZVZ9BE9FFSazTK6z8VWNKNLtMHyB0Qv77sibypkoccGB
         crn222AxTPpkNmmQZw90T3S/gvDqT/myQsk9CAaBJb6TdsoTNL/yIGVav0R4QMMCbR9V
         HStNvUBhCMU7nChb17aTuMR8bZpnzIRtzPIN8DulUCcKdCuurE8gUjErHzW+vbeXupw9
         +BI5ioCKq46myGgG7FUBNKl2btupbpS9rtcY0CwXmomzfh1B0TKBXltIYoLNDSVzE2SQ
         q9UXuLpKma7grsuVFB4I764OneeOn12pWjNOm53wrcad0/BF6m7rf/oQdnxwQ6ISD0zw
         76qQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxFTHjd7uCpKOw+5lxxHP+esNAroJM69dlerNyvr3Cn549zdEaHzjrf56VKeF7Vp8GHBA3rFS5mTk0PGaU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4dKxWT3kvdtjfz4jcDLYvuNK2TRvq0izeTP2OXFT5+bMmMjy
	jTE97Z/ZTg+uH4shFw6fuXXnty/Bg8RP1E0hQ5EpPWTNkE6y9FHGaW00
X-Gm-Gg: AR+sD133iTiYN61iH6kFKbvcA77oWVb5ykCIH6htcPKi3viMvEDhQuRfoZ0dWGf/qQC
	C5LNp+8Co1dRoDrhCEUWNsJs0DMO2A9CjTRuVqvKNOpxAEmdEJE1v7CefvKky8tyqyftFPU/E9w
	2LXDUw/FnCpD1AxwrxLMn/7LiQvacpU9U6AZC+KjA321Yv29oFsN/uND2rUsDi+v7BRe+mQvlHO
	d2LCRqgbMTpqJyi9EdYWdyvRvu7GINIR1WNo06IDKQa9Imd7ml+TL4PPdxu3wDCveeNU0s0aPda
	MjOUieGakED9pR6cr3qgCR0zVQgetvYpzmhekY/5vHbjIvJLD3Cn0EFhDZjvOC7LqqHoH7UKgS+
	WM9tZ/tVPiIHD1xG8nW2D54Iip/ng5uP121GCIIvkBu5bD4ccIQw8j12Hp9uRNR66v+RLjq5GOv
	aCXsI3j9DJG9qb0IFARKEb3GEDCLSs+4+GPvm+doqL6dU43DE4I2ZuDfk4nDo1l+vOoxZdykEnE
	zCA9LjyKFdw7GCXbYTLVClM8dOU0zF9wHkMd8M9bLhY70g=
X-Received: by 2002:a17:903:2450:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d05219f5c9mr36286255ad.10.1785599381195;
        Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:49:40 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 08/16] block: add dma-buf support for raw bdev
Date: Sat,  1 Aug 2026 16:46:20 +0100
Message-ID: <b32dd786296e1683378c9e037e2b9f26ec24fee8.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
 block/fops.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 56bbacf6e317..3c403afb0f64 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -767,6 +767,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -821,6 +824,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -924,6 +929,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+		return -EINVAL;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -942,6 +960,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..9f4c92e51dc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1682,6 +1682,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

