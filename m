Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF50556BAA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924934; cv=none; b=iwPKX3jm+Z/pludRSonkxdpTnc6I+F82+ogwe+mXgLQIgRbV8k+Me5kNq1brSVZHVNgLyjmknUri1q1XCQHnEzY0k9sPijG8WklWZ27VGEwHTv1SEbb4uycSco5/ONvt3jqUPGVJj2rgGY4oZ2efVJH/YIMCheSMke3UeMU5XdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924934; c=relaxed/simple;
	bh=0a99AkCdYYlGDSLNyvcoHvxyA0h7cLM0HZDY04APdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0CC6fHW9ttJ4ghIedF97JlGMNiSPCDXynGGsVyj+k9sY7sQDOH6/t3+59fpOT1G7zHKRgY5CHQZkUAVhob5Jl4MwyLuMizGqvQrFjGFylhRDzyi3wTMCyQgyFyLSE07Q5mTzFL89yLsPuxnCFrgYEvUfKMu4XVnJ+F/JBNRWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwcO8KdU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwcO8KdU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2442286f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924928; x=1792529728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=LwcO8KdUHyYrdKQ/8j7tAKiNFwHbDujT8GdFEX2KNcqlHFfG/Na5K5kxM9B1aG/3XM
         UopK6UUi7ijG+DVl0L5VdYAdDQ9I5KVXnl9K4yNUsLrXbjkdYgCeUmeM2orJUZ6wJk49
         V4XRyAyXaQo9AbwQMG55LhvqPfWwjfWLV0rVhmLJSkuS9+HyZWRmeJUcwdQMGRw8KYaN
         zVivHMHc0OobZ548LI1ZHAplQU9CqVRAzggD5J04MEBpto8/6C9n3vYEmdGSXmvc2Z39
         B21/xy+LGe9qvbbIKlqo2VKgw5gmXchSSo40VSvJn/J2OQQYl/waRhyPMtrNBQiMToSh
         FT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924928; x=1792529728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=o1aJu7ZLQD0i0ARoUyBfZbEu5OwG8NkpQVe/7zxQT11yy0DRqSHPJoBe71MwIJwrPp
         A04kqhl4WwA2/hxpHwfbCSqhkt3rRTDns0aNgRg23zrbJML5mQUnFsMe9phoJLoa13Sc
         jfiW8INlRVyhHxDbe2t/7cmZCiEuTjrJAsKAU2yAkPCoUYAWHGVb9N5udDwnA4BotUod
         2hlwX/f2xi838SZtTrUsyWJaFLuZjprk8turckJ9XnVZvDdSn/xHNDSBOteuOJy5Fvqj
         ytuHnMeMB41o8iw/enwdtbk8FDVrDCI2jeuXD5OtRTEu7fxKqp0t6mR5K9zGVdJhtFy1
         Em8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwcncM8pNGMMwuuRaZWSmOABJqnODls3FqwieKHEajCYOJbxHA2DGb1pQYSRxmhqdYc0wfBjXjpS2mZHqsf@vger.kernel.org
X-Gm-Message-State: AFq9FYK0ydwLnnrCEztlUFv7zrfCZgI/8cbgGtZbBcoklN6uaqRQHmvQ
	QlcuUV2LIhzJSJicF9XmOMCOyCq8w72+xminNymuhpmZ+Q5LK3VpH6B4
X-Gm-Gg: AYBFou3Y5Ff29DjJOPPiHZvz71xWSbhcihMSu0z1Z1mzyIM5zjUFgUmMhaJG77vWjBV
	Xy72q98Km5lhLMTg41QaIEUwxvGaGkxjIckp7xO4bYSgx5Zbkl/2fD1iygc48k21bBIYrpIbk9A
	YprJS/My2fRX8RSutGUDA8RSZYl3r6xDFVx/g0hy7/z0KHlLFsCSE0U+14LbTqRy3K6FJaIMzl9
	QsPaF4iH9beHoKrwSpv7BAdA3uFKAmCQ3nLrSK/xy+ewQiZcA5ngAPWFqRLPrlX+ptWpa+oWKWO
	V40OsFno8fw7T8wGi+2JLlvI/d/mfO1d2A4FhIvxLkovlwT6SfvOZXG/Lg7r+u1PIK5N6xppWEq
	0C35mw/TxkzG/La5EOHQ43OiF+belXfoL8ACoGOhdUkBnrbIHx+wk8XFYQaLWUgB0qCKD/YD09R
	CkvyxnkDNxz4q28J3D6TM/D51MpsnkgQOiAjf3DHoDyS/vm+6cwXmH6HpuTBfklmaxU8ii4GIqt
	oCKWtjQXV5h7b3XUr+bEuYfrNJQAhjGafqsXQW8ClSm5q6k74bo+65lYNIO/BDTnbqlEBvjpgtd
X-Received: by 2002:a05:6000:186f:b0:48c:7c69:2dce with SMTP id ffacd0b85a97d-48dbace9dfemr26073729f8f.16.1791924928152;
        Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:27 -0700 (PDT)
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
Subject: [PATCH v10 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Tue, 13 Oct 2026 21:54:50 +0100
Message-ID: <54f1186d20a7c24075dd38eda1dfc7ac3705a13e.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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

