Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD44A43E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997988; cv=none; b=i3n8OXfJylTDeSKyOLiXThIydYX5Vu3uThOceeyob129d+T/gwxsMCe4RUKMuGEpLstOFhciMHcjJPswSblElH3J4Sq/YGJaXElf2cFWUFNNSYTxmRlJN+eNAgrjzU2f5kGyt4NDRVDwMdsH/pm700WvE1sx24VjJQnazT2E5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997988; c=relaxed/simple;
	bh=smDKQevZZNHOYCALAT7ddU35ycdlQd+jI7KY7MHT/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tqewlx4uJwHQSuV6C+e9Y5T4sWcjXZkBQgoIzpl/qHC0jo+ljeScpe1RDI9diWRGGRAnpo0lS/jKUT8A4j+U5xi29JRGbr723wCgs+LuaskXH8cqMI+zjmSpa+Uxa+8se9OTU7DrjAd7c1TBis8Elh7TGOlRzEuC7ekuzuyHucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjBxfpz+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjBxfpz+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso14457815e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997984; x=1790602784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
        b=WjBxfpz+Z59BT444gfGRH3Mtq36vASFYOARX3FT6YjCghKwWC/pXcTF9wK+Ub3vqBC
         Sc4dhztOy6cixWLJTdmnW6aAAdKy6TPhMsPXXeutJhvrLzPjLqgtQiZ/zqfnBxCoUEeo
         EgLHekMf8Whef56EqGaYHtNlXeHKNnxM3wA1LbUHwyWakaZ++biQR//LT7RcYO3npvW9
         SrP/iKtyrib9w9UzVAEsPN7zVMbNF6NcA+QrrmokozaB0DMuC94DsYPRf/Krt0l6+z9r
         nvOpE25tQCq/X/7/Tg+hp4Ccl3nkS9CWkMQgEOeLKAo4Eh3RG9wpVUSStGcSORqd1XWa
         YPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997984; x=1790602784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
        b=Neyjqemn4U9JQ2Uzry28ps4j/Kdlx5I+73nVQunNP9Pwdc5dyUyEuLvjTxQYccXdid
         mkru8NLe9Y9uXT4uwMNXE8mrDNvkoZJ0Grf5iNC4/xJ5iwX+kuSHs4YpqwssgwZWH0Vq
         Gh4oHi1nAYlIhrI64Ap0HkUBAtEEcFxAcbRiSRi4oONVlCUfQMGY/YNPLAoJigh42yBb
         VLjfdRDfXheqTnVkS34P1gsJprMRmvwHpG0LLL5xIyr10Sa3zRaXaDIHQundeQRIMg0J
         Js/Glkqipx3ZhNCKV/WjLA0B1nRg3yZHcfnvaFw0RfbcETkV6zgoao8eKhOTtP85zYiL
         9+1w==
X-Forwarded-Encrypted: i=1; AKwUvBz4iBcLt45wrtoSIowtEI6D2Ni9/NuUIBkn+0TJGNFVBs4vDxYtcmcar/bg6x9574TGBz6QzaAzJzcsRqVN@vger.kernel.org
X-Gm-Message-State: AFuF++nJioXZ/9PnrRK/XoycOqaaFYrjee8Te/RwSGfGvT80yB0y+N+y
	WOdwsr6y6GWecW71/KgojiHlFSCsrVtqNikKAebypDRugTyIgTMzdpow
X-Gm-Gg: AYBFou2nnW236uRj12oHh+/N/IgJ0LAK4y0QzqBl6qlqIgpjsn1uPGmHTJCfdjrosCp
	mc27zUZGHMiJBwDLsoBLwJ8mdi3TPSqSG5BntGYAgEDvsFoOEEVyJAonLk+/Ol+1t7N+SLfOZJF
	ZRuOpemuyaZqbwp18lutwSPCOEKA0rL7bInPfnK5i1vqgEK2TmfzS5eTbfh2zvwaoYOjdL7eJMw
	jzh8UyebgosbbdC33Agt5GVuI5B0TGzR4KCRUK0McRfwb/WdUDSnMPhtCBtEZVoBeM4WY3b14j5
	WCUP6GyTDK84zRLrop5neJg/Kt2ztW8HEzZc+E+Yz7m4L/RxyVivykhcqeLsp0pnFeCEwwUDYp5
	9AowLJx0h8IxrOgWkNo6SNzdMZ8yejGYwK5QjDOSwnDB/JcmNBoCvU0R6ABiSuX6+Uo8KPAazEM
	E81MOmkon7XwaGGXiGCJwwPUsvQ9Yn8gT83fwkPG5lVwcXNjzvH5b3u0Nw+4eWLRz/jC+l+c+jP
	dx6WDNoZnDFLYwaeQ/NaVnGhmOpdkH7084hqQYrK9/LcdiTFSp2bJGP82/0+PnAAfcIIyfPrYmw
	D17VQOEKnOmGIjATUt0eXRwNfq+fhQ==
X-Received: by 2002:a05:600c:4505:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49fc56db92fmr154368075e9.7.1789997983642;
        Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
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
Subject: [PATCH v6 07/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Mon, 21 Sep 2026 14:38:51 +0100
Message-ID: <114bc2087c7811c849fafbf1392abd7edfb24471.1789997898.git.asml.silence@gmail.com>
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
index 3d645324f04e..8dc4002fa696 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1297,7 +1297,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1327,7 +1327,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1349,7 +1349,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1512,13 +1512,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

