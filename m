Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA64F7CBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975764; cv=none; b=WJ+EyFWab+hjBbyPl3o0USwuL03Xj736hLCawipOZ6+ybQAG5HOhlMAzUvZM9+SLDTC0gkPJEQj8JA4LeV7MAwM2asdql+iB/EcHdzxVkOSkDh1RcVjy6DVnDDoz7rMZLCJlwJChCCwEid+CIT65KitAO3rirIp4KkIz8bpedt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975764; c=relaxed/simple;
	bh=iy9U6gJyxks5ymTnPsPTZg2hiScYxD3ewbuzhpHoVzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC+AFYVr1g+ryTHe507fzFsgaU2ZXog/JFhZMWocVi0vFiejwoS9LF0DWFPVAmeaiZx/REpWRYD3brK3cIh8N+p5aJjRCXe3l379u0v/yDHgVVDCPJAti7YMqnwO8wxa9WGcCquz1w6HTkBhSAJwh+nfDCF9N/foIqPdn3vQe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mbk6OF0g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbk6OF0g"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so8281995e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975754; x=1792580554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSeH33Tp73HrlxrRD40ZRw/kp0xshqtHbX/nV8WDcGA=;
        b=Mbk6OF0gK7+DKGMPYpyHbb0WOqDBuwPId7kiJSuyuugw2TVNLlQgDdp9ISEGBYBg21
         4n+JvfBFwz5XQDe13kYeyamYFLGuYIjL8AT/c1aCRCG/cZaAgYH6K0QNnEzYKha8kEA1
         IfpzpRDFGFrBImE2ubyAMf2UspBXbfR/HUO3IkpSx+LXn0GMuOttMxH+30oPVBtFZ0CT
         WrgnLG5ThL28AR6WmZWJlgtVuZdffNwdKAYH5cVPdP/EkrVhLHUbAy/D30YPNHGdV+N3
         9NwFIkVK1B7hnyXP915ToZjLxrFNdZSust3p8lQ/SyeDACvZXefTnsmAsRa0SO/LOYjC
         BImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975754; x=1792580554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSeH33Tp73HrlxrRD40ZRw/kp0xshqtHbX/nV8WDcGA=;
        b=MYAo8Qs6QGq6ZwwFJXvOwyRXPe8tV9hGpNXa9SZGO76198ScPzkI9/lb8CUSJmBZBI
         Kq8YwI7gTO/13W+Q+0BS/YqrvQQjnjn/8pWVnir4G7yRVo59tnTSA0N+umBMqNK+cqQS
         dEFjei2Bm7kvVkz03+6D6YUIoU+muxp6sqLxUP+IWqSyJgEsliEj9jTc261u9UDisQ1h
         HIxsNLlG6YJ16vW5b8tM71LwN37a6rJviDqYQCtofMpVMc96NmDSgNpQn2z1D/lf7Nsj
         eAT7ESmpI/eDVmYQ/Cm81IyclCWDGHkjxlYx97S+r13KwIVX9hx02jpwHWjp7mbleQHl
         GvnQ==
X-Forwarded-Encrypted: i=1; AKwUvByPGp/rabBjoMTBQ98aO21YMg94asCDkdDznrlp1kZLhUW0hMOMaeMZzmVShkL5c1XE5C7dmQqdbHQMoGpT@vger.kernel.org
X-Gm-Message-State: AFq9FYLtHbULDpXGIfdHTLleCazSMmiVDWdq4BRJm0iMSNYUm6oXCp5i
	3sezKncAQbdzikAAbO7qPwE4zu2shI8Z74C2WY7+Swi9avoPOAx+wgTQ
X-Gm-Gg: AYBFou2iH7FUXTOgCrlKTTYdYdPNzjQ0b9IQEl2O8tOlYicCMybW16qkq4OGIPBQSV9
	s3zio+8Y1qosp7ZGDToD2QW9ahh8/Y8fQN/sWWvbZy6xIk6c9f+65x9jj3amCN+UzWg/hj7SgqH
	KdxM7TklJnL/Vvz6rXhxH/QkUAPg3p+45afc26M/rgntG1RTuyXg5HIoeKscj+85st/RjRr+swY
	EIHUQpJEYUnV2xeJOgbajbQq5Y4iqat10XSBW8RABugpxiLnbg0A228l7uFa26wmnHc30kjaNXH
	SqShnbg/BdYIaFHwvbPxjiU2w3AHMWEUYsdTF34XEOW6wAvvf1evJpHFxSwzFaohuNYGl8Pzzcy
	HuusjXpTLQTpAlMBIbYNlv7Zs3mH8tQKNFc8zTuyHRFxa3GMJ+4NHYpM6Jxb/F+PJQ/2T2TSyay
	OHZkP204K8jd8upSNFyA8SQhx3LJ4uu+8cVknGXILZhozWTYfVqzWpOLCVG4kQQdd1QXkRPsQjT
	T4j9mwSOytvqNGCUApdxGGDGaod3Y9htEGP9sBVbyVMRsxtOyRI1FM1srzLC3b3d8o0LGoQ/PsE
X-Received: by 2002:a05:600c:34cf:b0:4a0:159b:d2a9 with SMTP id 5b1f17b1804b1-4a18e4d68aamr259014055e9.24.1791975754208;
        Wed, 14 Oct 2026 04:02:34 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:32 -0700 (PDT)
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
Subject: [PATCH v11 08/13] nvme-pci: add SGL support for the dmabuf path
Date: Wed, 14 Oct 2026 12:02:06 +0100
Message-ID: <86fb4caeddaa58fafad106548f82950782ea04fd.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anuj Gupta <anuj20.g@samsung.com>

Add SGL support in addition to PRP for dmabuf-backed requests,
building the descriptor list from the mapping's sg_table.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 150 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a0506c93fa16..79b3c1092e4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1223,12 +1223,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+		dma_addr_t addr, u32 len)
+{
+	sge->addr = cpu_to_le64(addr);
+	sge->length = cpu_to_le32(len);
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
 static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(iter->addr);
-	sge->length = cpu_to_le32(iter->len);
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+	nvme_pci_sgl_set_data(sge, iter->addr, iter->len);
 }
 
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
@@ -1239,6 +1245,142 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct scatterlist *sg;
+	unsigned long tmp;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = blk_rq_payload_bytes(req);
+	unsigned int nents = 0;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		sg_len -= offset;
+		offset = 0;
+
+		do {
+			size_t chunk = min(remaining, sg_len);
+
+			nents++;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		return 0;
+
+	return nents;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+		struct nvme_queue *nvmeq, unsigned int entries)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dmabuf_map *map = nvme_req_to_map(req);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	size_t offset = req->bio->bi_iter.bi_offset;
+	bool pooled = entries > 1;
+	dma_addr_t sgl_dma = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t remaining = length;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
+
+	/* entries == 1 fits in the inline descriptor; more needs a pool. */
+	if (pooled) {
+		if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+			iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+		sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+					 &sgl_dma);
+		if (!sg_list)
+			return BLK_STS_RESOURCE;
+		iod->descriptors[iod->nr_descriptors++] = sg_list;
+	}
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
+		do {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (WARN_ON_ONCE(mapped == entries))
+				goto err_free;
+			nvme_pci_sgl_set_data(&sg_list[mapped++], addr, chunk);
+
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		goto err_free;
+
+	if (pooled)
+		nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma,
+				     mapped);
+	return BLK_STS_OK;
+err_free:
+	if (pooled) {
+		iod->nr_descriptors--;
+		dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+	}
+	return BLK_STS_IOERR;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf(struct request *req,
+		struct nvme_queue *nvmeq, enum nvme_use_sgl use_sgl)
+{
+	unsigned int entries;
+	size_t avg_seg;
+
+	if (use_sgl == SGL_UNSUPPORTED)
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
+	entries = nvme_pci_dmabuf_sgl_nents(req);
+
+	if (use_sgl == SGL_FORCED)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	avg_seg = entries ?
+		DIV_ROUND_UP(blk_rq_payload_bytes(req), entries) : 0;
+	if (sgl_threshold && avg_seg >= sgl_threshold)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	return nvme_rq_setup_dmabuf_map(req, nvmeq);
+}
+
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1334,7 +1476,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	blk_status_t ret;
 
 	if (blk_mq_rq_is_dmabuf(req))
-		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+		return nvme_rq_setup_dmabuf(req, nvmeq, use_sgl);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0

