Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511E4A2E32
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997981; cv=none; b=aFdoC9tOF1E3BwPH0i3MIBnRJ7dE2FGdUaSFjeBs9H9ZtgSXe1NOmynVKzah1A+yOrhG7AZHpkGtpz7LNiGRBwl2wxEBp19zLGgQUrXwIC13+TJNBbQcBcW8Dck0QdSjEFXNIYD3SkzqQTQmQvflM+wKTfA1oR4twAQx+d2YOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997981; c=relaxed/simple;
	bh=4botMd0JRxgaa+oDvZMUZvvmXYyk4mBy6faGFHabX+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=embdUTtFRC6FHW1euFfGshcw13DiVwST/Jzv0qAESo9SrtLNn3VYKlteeBvJDVINRuCWS49EzWX9ip1GuSotRRSYNTPenrzYiv/rYkHw4JqJ8cnTftcyIt/pchQCD9a1WWPEqDdwD2S2RiBqckkd4GTDX8mZIKqqFDXeTGtfoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvtWke4Q; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvtWke4Q"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so20554685e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997977; x=1790602777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
        b=AvtWke4QL/CX8yeQjGnGXUT6cnsoMNLqIBwXjteSRY5/9bQPHev7G54OANcwmJx1AB
         4nGDMQSYF0qcecwqD6CnHNlluEYCkX0XRx6/pnrXiOcrmNBO+M0k2I5cNYMDZcCBHJ29
         hTW4MhkrM9St39NWbtNbza7M+MEZnHfoPgqfYT6l8jZzY+4mcFfeWBkkkds+ZC+aqbR6
         zGIAWHsrL/7dgqZoMOZtCRKDerTwe4+VAbavp/NrQvl32oeo5K2Xxq2S+ULOS6S/92Mb
         ajEM+77gXhDuQOD3ol75VXsDZd+oaIslcCtSVxKcguq3mA1FMVlWvVCHuY3BeAZyaDBo
         z5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997977; x=1790602777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
        b=D7UVyWoZjYDLiNl0Y7qcyZ6nGTMI49ogs130PQit/Kjm1mGhc1X7CNmebddyjnnCzc
         vuYQ41eTnDzXgEfaPO+FbOPz83f65GPNZ3+sGqxYU5ZlKoptgGiZzrYfpmnhu39Yz8Um
         KPC6s39eXvK1sklYS4fcv0Nz0UBiwqpv2UNiyt/ngvzF9mIFE0WKWeGjdK3IK8ttaLUx
         jx72B25q5rzwjeGgklnBDLKVN3TfMjQgYJjIdWMVE3aGhpFRt0StzTOKOd/RlpAvEYlS
         wmr0aSumAiwVQWsoEYktx2ukJA7KUk5R94AWDXms2suyTZ+xFpUEXKkqPWtIaGHMpvWw
         q3lg==
X-Forwarded-Encrypted: i=1; AKwUvBz3ZK7fLNyZ2uCOFn6nKbw8NsSNFiR5/3A8aJt7WVbSs6mqKQtuwRLfywXmpdZrH7QmvqD7PoCoi0S0oKuJ@vger.kernel.org
X-Gm-Message-State: AFuF++nRiszS1y8E2bvG8V+fTZ6JI5FgORVXCRg4IX6Zg2yRhoRdsgB3
	C2vAIekvOBhdU9ztWUWwCTYNl1Hx2s97DlJaIEM5mF6JM9YN8Y5VI9kz
X-Gm-Gg: AYBFou1VbKb17tbR10E8hLwuxQsgth2vp+tM7u2gQg+XqjRaIPTIhot8aVR13gqx5+k
	uhpeekdrJ0Isg0/gf/JQEEqg79n5SFa85En7dn2wWjaYWhdyAQsy5Mg5cQ3oLI4okDAcgnhH54i
	LfpEgV2vrhdIRZrAUkB2Uo10539y/L+NJWdalqlmK7AoxniU92UootncTFsk8Bme+clH7ZIfKTi
	wPL3OpkBBhHSWQYyTmv9bgn/Mex8152L1OgZPllagMQeSJABhaz2le24eVgWmTjRPAo/Hs9vsZn
	6k2fVx9YNknya6zjJM/sx6XZ4op3uKAzvmLU4NTzB5M+yqtl3nXF5vUXeTKYuMwo3hAivqTkcAN
	ciV/73gsBa/afQfjGo0WxocBr+D8r9JfutcEhnkJTUBqX2tNutuSE/vNml75Q518isYxvUAC/0I
	pBTU3TlxlqYbcBDCNOhdILjPHySwXSCwvXLie/mzrhd3YhliyiGfrs30g2cMojeEt4JGQJTictL
	gB/dKxzEqsUhi+RH7BvjMOy/VNmbEomqYhQxbIfPqOxJHjJuQtBSRKPO4T573BPz9jGiLybXFzj
	FEEGYxZxi7brPbVVK3NtQRAIAP3wYWybr/ZhKtR+
X-Received: by 2002:a05:600c:c493:b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-49fc573603amr145209165e9.17.1789997977065;
        Mon, 21 Sep 2026 06:39:37 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:35 -0700 (PDT)
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
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 05/13] block: add dma-buf support for raw bdev
Date: Mon, 21 Sep 2026 14:38:49 +0100
Message-ID: <eafcbbf7e75e75e98d0791b843fae0f2423a4ecd.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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
 block/fops.c           | 22 +++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 09fa42f8d8fa..0252d26969a4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,7 +782,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -795,6 +796,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -850,6 +854,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -953,6 +959,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -971,6 +990,7 @@ const struct file_operations def_blk_fops = {
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

