Received: from mail-wr2-f26.google.com (mail-wr2-f26.google.com [74.125.225.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820A4CCDF8
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602379; cv=none; b=Aj5Ex1htPxVAKYFRMybT/QPwcNoHnUtxFgIRDRyptHZJU+d/Gn2NcYfUdKf6l4aJN04eehcR2JGQnlqFNRczx21VciccYo9fH8sDx8pEaCbqvvrakxaK367SuqRBXm+Y1CugOoqnhhysFTOnt4pjRgdVIB89win2WIyCmk0qGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602379; c=relaxed/simple;
	bh=s/pMlWhML39X7WPnWJGpXvJM/zWMeJLTmEHcD+dWxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Msqj+0E+Tst+6jhIknylO+AeSHnnqk3haGmqkawMFL18kH0j1x+awtKrQkt13L2nHEE1ecrPp2rwk7BlltmQegHAFzcYtH2M7o3KO4aFbjfyHny00OgtIgyYKGCcMnclAIu4ORqlbQ3R+8wuCZAXAL32ofok3ToXGX0t2wpjB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfkaR0Pm; arc=none smtp.client-ip=74.125.225.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfkaR0Pm"
Received: by mail-wr2-f26.google.com with SMTP id ffacd0b85a97d-4843f22dc83so2575360f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602372; x=1791207172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=RfkaR0PmmRqpWxFhMtgRZdKnj7xeumGmGfDTxzfQ6oWWJsLbke7bhO4MBPzg+BSoLo
         4hggbNPW70ddSMca21lxO/l0oyAi2RycEF0NAV5bQm80Z3aBiU7Vb8WA0ccxK5dE8Z6L
         ZXjzu6TBl38tpDGG0EQy5wyV/7F+kmOce+ZVUtW/gl5o+ZsDXVzrTSk2hNKcDR9jDeG+
         HwgOkSN3yzuJ956pHO9pqRl7KZ77zPaGcoNzWgtpX6FZ+oiyCqVBYWn1mmGyUKi4bKr4
         U5O3ppeWrwrCB2Z+3wRCBpCsGZTy4Mk1L1AiK4C8w4XRdpi4avlhnDngcWkm3ypM3gJR
         JFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602372; x=1791207172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=CtGmP+Hr6pwifE4lOQ2kEM7J1x8mv72T23POX/uX/0ElId8qxVcr/GpeiBYbnI5a7L
         RR8TCTNubrX+jAT4/kSRWP/D/X6sC4zCJGpBxrJd1d2EUWUNfOxLMopWjAR0jKZkhORY
         UsoWnIViR4x4tR4YzWpOYQWBUcxIJZmk1zJVD2RS13R4MewsawyPWX+GEqI4FOQ4Lx0j
         qvMjzxMFDGwGD9eTRc4mCFPsGhHSHs/lKQDgtevnG53ayEge+1QcJrbzCC0kmuGcWvx0
         sJxBXm+p+eyaQJMH73spyW5S+180fEufl8qaKhMIvXJJhgMPwp+wTNc+qybScBiCSgVP
         XIPA==
X-Forwarded-Encrypted: i=1; AKwUvBy9UmERjweASRzCfwMBccp2BHvpBBdgVgU8xIcKpYXi5OzSHyD9ueBVenuGOAJgHkXwyYxVmR+X3Rz6/Dz3@vger.kernel.org
X-Gm-Message-State: AFq9FYJjfRiJJdGEbFH0GKs7lLZTdvu6Dz5yhHCOrj0MyCniwS6CpFpF
	/tKQdSp3dhW1ZSf5Q87m9IWiOnxiAEOk+AbesODDRt701teN0EMcc43m
X-Gm-Gg: AYBFou0EoBoEbHjcMgXWWnI1VwDMrvepeUtTgnsJqH8rwTMbXzKCFRw9toIOIQqYUpv
	/E+lBOkZAAa8s5xVsTnaCSBcpKLtpVCUtKyu4tZm4zzXh4bB0MOwfG98UdwYNHHKwyCbUCxQ3mE
	g1hCrG41io5H2RwjcgaoEu1/tK5joxDdOTthseYh3yGt1LAeYbMabSrVT2WXhDDoNLPa+3uWZwx
	fZsRpN+5YYfNh2IPXNqlO8PF5AHW7ncve0Kf28WBmt0Dwdt22B4AGIcQ6aBx7HfpR7RjiRBuifg
	v4SQ5spRoIDUimUpW8EBShd/IgIGUFD0shuJ2VQvc5bHRRm1tTbslBetEe8hJAWhKS4aNVtzLjs
	HzM7f1riVGN4QjqzKILybJNkdD2CRI+mDF1ndXtxJcJuaOc3WTaFWzt0y4IBCGPhKitZsOU/ukD
	9y2L8akOdmAufvPPOg3TSgvqES6c789XQPO+eODsQCPTH0yySoZ7nsDGMTbRHBDd3huKZNSA7gM
	4uodv/7WI1v5JG9IKHDyhgJ1lSDSUbp2y8ALN3OXrRN+9jHlZPvK3xe0GKxIqmJV/8Dle5XF0aO
X-Received: by 2002:a05:6000:4911:b0:486:f99f:8236 with SMTP id ffacd0b85a97d-48872ac74e0mr24072487f8f.44.1790602371877;
        Mon, 28 Sep 2026 06:32:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:50 -0700 (PDT)
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
Subject: [PATCH v7 05/13] block: add dma-buf support for raw bdev
Date: Mon, 28 Sep 2026 14:32:21 +0100
Message-ID: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
 block/fops.c           | 25 ++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 641621db700f..d05a78d0919a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -783,7 +783,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -796,6 +797,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -851,6 +855,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -954,6 +963,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -972,6 +994,7 @@ const struct file_operations def_blk_fops = {
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

