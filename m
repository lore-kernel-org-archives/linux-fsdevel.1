Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A534345EDB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337409; cv=none; b=gs26VaY3JRKURzPOS/Si8RkmcX5BfbZKGlQHTX9Lxi85GyGIuoQppK4kV26my1tR8yjRJ8mqg9qWWWY5fN9KDOdrSpQy6Tvvnb5dOfrSyqTkLvxbhbH+D/6ZsBUXHt92Zv6B/Ompm+C7ndjVywI0rSufM1zecAhFFmg0yxPtMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337409; c=relaxed/simple;
	bh=0a99AkCdYYlGDSLNyvcoHvxyA0h7cLM0HZDY04APdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THh+crNO93QFIY1aCSjWzE4/gXIhq0yeVAGu62GWdpLcd5zyd6QhT0n2JbfkoPodtFpO/wNoPQ5+vT3+TJeWp88OcJrmWBClY1uaicFFezkBaqU8+yCJV+UeOCDpbl4yc4a/ieZaJ0syMQVY6FwzuQNsirat/QA+yMiieN8Wuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f27ty6mO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f27ty6mO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a02718da81so10913355e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337399; x=1791942199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=f27ty6mORd8iV0R/oG+qG8LoZ4ztJUp5V/I6qO/Smujo/cToOggNECPqGLhxNCVjeS
         7is2ZvQ62x70H7sSSPf2IqOvzLiLKTjy4xDzFY+C7mD+zAszqqtJhFzgPOxEdVu0WH49
         GPxmNLP2mq7FJ9Idk8MHBU46Otf0P/B9OplADmA2KnytGpnM6/cULygVJfD5x3cLs5KH
         plSq+YnxUAzbcMKPQYD9pi1lPD2GUOaFqqNpBgeyJG3BZC9kgY+lfpKH/DtpEcHUj1Xd
         i1v3Zl+7hi0ooHz3Appux/AdHcE2PtVdTF6fqfRGWJ5DEK/Zwk8AxlZXFiCWUZVUWGbT
         0Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337399; x=1791942199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=S0ghHHJO+eCFHy7/HfqMQVjpa2YCf2qpzfsKv36e6b+TiIf8/ogPdfDA5e7ruVoCZu
         WtCjphBhRiJL7ypcE36xB7jrtoMUMXmu+6dE5uYcrbKPhhkC5Rpr55KqCzKS3gx+S0er
         DboOzCCQJW15Z3ZKBgVTQYX+8ji5JEv1fFOWC6dalwWH2c2peenVkWZ2049i3Gco+KKv
         FiYCIVMRtEFJZeK4X8iw+wHZBpzf6FuSr237UF/cA5KNPy4izLPb51/EYpdNBecpVSy2
         C8rKyi/+RYQkljr1L9SfmXIb60jGLoGeAndF31Ibcl0Ewl9Le/uHWYTSpGf4auBM8KmL
         tO+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzr5pMhXXHEM0gHHmPAexxcGQ0MeGr+Crh48YyXPti/z1vxDiOKPfcNFgdGom1QcpHSgj+SKAvCaHEgdELe@vger.kernel.org
X-Gm-Message-State: AFuF++lArAu9em+w3CEh4HpsAUVZbyk8G7AZgjPS17boC3faCEIQ4QSw
	4LyLxn4BKBZNMwUfWf5aeHk/NkIa0TbTvaM4I4fUFq0xXHFIzO0LT/2b
X-Gm-Gg: AYBFou1RpmwNKq4gCy1tYvpxgdfAZionKS/abLFxaNosr5/mLDV6RfuVhCGlMxcjrQH
	p7+Aq6XLvo8e/NKo4yfx7h3C0NImnd0C+S84jKITsIu1tdCUESeybQjETp685TMpH3iJNLPzSd9
	JwdE1imlkCSZWLcRnRBaSMjgQRgXUMgFyoGSvwmq0RNfz1Q/nze7iNxPq8HdIqUuV/V3at96GYr
	vshSCp/d0PI6bQZS5f0WNCT8KMOM76ZOsZNzRF3bxKagdqyKUkOVPJZ7iZ6BG1OqH1jhCjx7FbM
	1eiR+P3nGomiOC8DW4apXM6bvnaxqlyDo4xE2Nl/HBMm+4/bnd4hf+6fmdzW0LrIVvSJMEjTg1L
	yPYA+2elLrZ/itdmbd6UJZjuWcZyZDMPPfG8Jindbhmh5TFuaK2LdRiiN2FHXx7JdPgFjHtY3xa
	4iMgs1i7Z8118ALQo9Iwm3tehypoo1Y+rLGJ6ozC7BFnoQNn/FE7GfbOTToUbzipAs9fv6nuqTP
	FU11xOL3PCn7I4HUM6Px+k/d4rhOflHU1kJVR/uEkhu/2CGlNvqhhlXFzGxe/2eJ/EUrHmXpzoJ
X-Received: by 2002:a05:600c:348f:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a18043b38dmr6958715e9.25.1791337399492;
        Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
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
Subject: [PATCH v9 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:42:49 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336930.git.asml.silence@gmail.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..a65b77726e4b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1147,7 +1147,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1177,7 +1177,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1199,7 +1199,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1359,13 +1359,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0

