Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FC47CA69
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274205; cv=none; b=Cp+ZqnJkqH+KJioVcg2m9FUkapHxJfILq9RjqXdBnJ1cp0eWbNBWciG/OwrTsFsLHzpVz4oXJtCvelpnPZbWCV3T9Ks+38e5RzrXXRpCRB45De69cxgvzosDyGSspT+noRHfAKvo+cCPjuAxgwsGHM4pBhcjExTwR2eFDsBJ4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274205; c=relaxed/simple;
	bh=0mLJmqr4j0NL7x17ECejeQJMzYg/MikUX7RC+P6Slf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MODBYOGDiRq7ZL9cRcbuoR7X8Iu01f6uwFjDLBbux/kltUiKGaSN1V7MEqHIg7mbq4o1i4CcO0ujiFcBIKee0r7qS/uecLzAP9bv0UoZRIwr9t6qAEhlaTuinHF3mTceND0pj7JkXn34n2MxeV4NPcsxAgj5oa97rFdtLBQ+VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/vKddKx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/vKddKx"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f904e80eeso263320f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274200; x=1785879000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIFE0vMpUJ1dmAiCPJaILFb8BXNtIaKcrv79dEKWPKA=;
        b=P/vKddKxUsiva+EXeYvQ7gWGM0nrqxBf4ccKZjnkEYJh7mJVM3TBXqfVJc52cJw/SF
         xOD1q0CQiWf8ILqgbr4jb2T6Zxh+L0j5J1fsngdAlsHHdQwJUPMOSAZJTmB3PgWdQOLn
         cdWoJSvzgu4ZNBoBo/v7M8QmQNLncY+oYHzwP6CD2+gno2dGBwkVk+N6xOc+XQuLPNAO
         xLGkEDv0uRAgLyJBcDfD7SZMaFbeyxh5tuYGeHiY7K4TgpvI7E1nS2yQwJqLJoYpWZbI
         dBVAsIIbzNbYR9Do5N6pdhxxJkB8jq/iV/oE05FB8vZUjmasSIQxog2DDusTdwbhAYw4
         WpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274200; x=1785879000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIFE0vMpUJ1dmAiCPJaILFb8BXNtIaKcrv79dEKWPKA=;
        b=fmFX3X9/nACw01NCiXLpeyKfUPs7qHNPb5WydA6JMMIK5JJr1fH4rDaRCUQd5Q16Vp
         G7WT9UQcVGiGXatBwGqOAU65Pgi9++Jyj6mOxszkTf9+R6d/w6lfpiTwfODFO/npwhyF
         XbZA8NJrKUS98urVr7/NAlG1tS2kQdGi/IiN02xiNXw55skcWQBDbIFGe095isrW0ZEF
         XPSqtNEOoNApthjxFe8J4tSyOuUlqYoWj5T4Vdlc/ZwZ0xUqjB9kKSExb9neXggXsfor
         m8oIJ+7o3Pwct8nnt2ERg95l8INNjdT/DJr5YLZ9+PVpyzQIfcZpK9lBYZ3cMmwBOlJj
         nGuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPTbL1h5CPOPwi03OCGVbwEfYxPV6EDAxZeopF7imbuCMOq6LVxOryxNKyLJJ8tcu0AbFCruYd4htuT5hY@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8llZ7ObHhQpMPo8/Fq6eyXQ6MGWtu/MP9zQ61iMbpCYtZc+X
	pm068RFa3WAa2NhYkUOqVwOwVkwtzH5vhqjE8PwHPcwRnYA7SkckuaCt
X-Gm-Gg: AR+sD11SYNUU+yKvaz7YW4ajsMPUprhUMcVuswh0TF7Hlicx6ARi5wW9YaDiS5mbQvs
	uE1qZBs1QP+oVBTRUCyOoOx9hKaHRan3qxeDb+DjqSYBMNjiUUjPTwJghDbmhJJ0nVxNHRV1DE0
	xlp7WdYCOtur8GBIiWlC3spTEFn05XdyEcWpUw8s84+nfh/AgBt9tZs7HbhRUhBPAkFbyqI3EvI
	OxUEHiIVseof1UkUCqMH/vb8hpunM/l9yOljJHOVnbdtVrcR0l7BIczglf3MTTVExl2+7MN3aO3
	Hs4TnVLr6MQlNRWyZIjqht7WRicBFmlkY4WdQu6UAm+oG6ePwLVL0t2GGHaYi2XZIJ5V1eMhMR2
	8+KWqEJSm0TDAuB7fBmZnniJ8KfNG1pMclbIl3YKr4KLQ+Q9Njkp3JFEaOPsDFisRcTvM2YTDX6
	CYjEO0750CnvrUA18UTZWzcGeXA8ldU+YeX222PouRuFz/V38EOM5/dHA/8YlM/LgGOLeqm8Hkr
	tyLF38D
X-Received: by 2002:a05:6000:430c:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-47fb1ec8030mr4347905f8f.8.1785274200459;
        Tue, 28 Jul 2026 14:30:00 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:59 -0700 (PDT)
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
Subject: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
Date: Tue, 28 Jul 2026 22:29:21 +0100
Message-ID: <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anuj Gupta <anuj20.g@samsung.com>

Add SGL support in addition to PRP for dmabuf-backed requests,
coalescing the mapping's sg_table into NVMe SGL data descriptors.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
[pavel: rebased]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 191 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f1b67c191892..cbb321fb7c50 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,12 +1287,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data_addr(struct nvme_sgl_desc *sge,
+				       dma_addr_t addr, u32 len)
+{
+	sge->addr = cpu_to_le64(addr);
+	sge->length = cpu_to_le32(len);
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
 static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(iter->addr);
-	sge->length = cpu_to_le32(iter->len);
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+	nvme_pci_sgl_set_data_addr(sge, iter->addr, iter->len);
 }
 
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
@@ -1303,6 +1309,158 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req,
+					      dma_addr_t *first_dma,
+					      u32 *first_len)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct scatterlist *sg;
+	unsigned long tmp;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = blk_rq_payload_bytes(req);
+	dma_addr_t last_end = 0;
+	unsigned int nents = 0;
+	dma_addr_t dma = 0;
+	u32 len = 0;
+	bool have = false;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		addr += offset;
+		sg_len -= offset;
+		offset = 0;
+
+		while (sg_len && remaining) {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (!have || last_end != addr) {
+				nents++;
+				if (nents == 1) {
+					dma = addr;
+					len = chunk;
+				}
+			} else if (nents == 1) {
+				len += chunk;
+			}
+
+			have = true;
+			last_end = addr + chunk;
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		}
+	}
+
+	if (unlikely(remaining))
+	       return 0;
+
+	*first_dma = dma;
+	*first_len = len;
+	return nents;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+					     struct nvme_queue *nvmeq,
+					     unsigned int entries,
+					     dma_addr_t first_dma, u32 first_len)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = NULL;
+	dma_addr_t sgl_dma = 0, last_end = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t offset, remaining;
+	bool have = false;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+	if (entries > NVME_MAX_SEGS)
+		return BLK_STS_AGAIN;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
+	if (entries == 1) {
+		nvme_pci_sgl_set_data_addr(&iod->cmd.common.dptr.sgl, first_dma,
+					   first_len);
+		return BLK_STS_OK;
+	}
+
+	if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+				 &sgl_dma);
+	if (!sg_list)
+		return BLK_STS_RESOURCE;
+	iod->descriptors[iod->nr_descriptors++] = sg_list;
+
+	offset = bio->bi_iter.bi_offset;
+	remaining = length;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		addr += offset;
+		sg_len -= offset;
+		offset = 0;
+
+		while (sg_len && remaining) {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (have && last_end == addr) {
+				u32 old = le32_to_cpu(sg_list[mapped - 1].length);
+
+				sg_list[mapped - 1].length = cpu_to_le32(old + chunk);
+			} else {
+				if (WARN_ON_ONCE(mapped == entries))
+					goto err_free;
+				nvme_pci_sgl_set_data_addr(&sg_list[mapped++],
+							   addr, chunk);
+			}
+			have = true;
+			last_end = addr + chunk;
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		}
+	}
+
+	if (unlikely(remaining))
+		goto err_free;
+
+	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
+	return BLK_STS_OK;
+err_free:
+	iod->nr_descriptors--;
+	dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+	return BLK_STS_IOERR;
+}
+
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1397,8 +1555,33 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
-	if (blk_mq_rq_is_dmabuf(req))
+	if (blk_mq_rq_is_dmabuf(req)) {
+		if (use_sgl != SGL_UNSUPPORTED) {
+			dma_addr_t first_dma;
+			u32 first_len;
+			unsigned int entries;
+
+			entries = nvme_pci_dmabuf_sgl_nents(req, &first_dma,
+							    &first_len);
+
+			if (use_sgl == SGL_FORCED) {
+				ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq,
+								entries, first_dma, first_len);
+				return ret == BLK_STS_AGAIN ? BLK_STS_IOERR : ret;
+			}
+
+			if (sgl_threshold && entries &&
+			    DIV_ROUND_UP(blk_rq_payload_bytes(req), entries) >=
+			    sgl_threshold) {
+				ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq,
+								entries, first_dma, first_len);
+				if (ret != BLK_STS_AGAIN)
+					return ret;
+			}
+		}
+
 		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+	}
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0

