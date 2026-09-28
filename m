Received: from mail-wr2-f38.google.com (mail-wr2-f38.google.com [74.125.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575B4CE681
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602382; cv=none; b=Az569ozwmPnmMoH1qgQ0LmwZdVzZb36s7hAx4G/ytIm4POUCxWmX+/AHJkwSLhT8/go+O+/Rjzwgdz4gYicMShVC2j1IuL7aBCtOY6YkAmRPXk9sH4AQmhoqEpr+I69DWQnXrNtIrqI4tkGfbU+CJFaAdAwBY9n4/FFmkdbV/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602382; c=relaxed/simple;
	bh=wiOPOVzZkfrXRxbFz1UgU3+Xbr5CbqnKoLrDHMr2xo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOFesXhrn5Z5wNo6JwSgBY09APSje2FYjuUKzx2sn/yF3gi/8rA3lR0eecALrobpP8qUflAR/bj5jrgF0fncUaIqUk7WWG0nl1Yfmdxhl1gse50zTGk6z64T+8ga4YtJe8xZw7LUx27q4EKsp51oasSczi/1ZWutJmDkjuB9lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A103FaSb; arc=none smtp.client-ip=74.125.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A103FaSb"
Received: by mail-wr2-f38.google.com with SMTP id ffacd0b85a97d-482f6350f89so1924343f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602375; x=1791207175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
        b=A103FaSb31zfTZFdiyeg1rlVNhV/Y0mSzi1pmQMEVhQ8h5MmC+LzF6Loh5BR9R33Nu
         cJa0QpNtbiOq+814q1zyA2vrH/3JT8bXxDuJ0liEcR6uz3vAIPvzV3lKF6t+z+kRYepk
         AxFsfktwN0mRy1zjKsAIsUdKrBraHkOnIdqEokmBv4DzlbM6ctZiGT0tLs8xUp2jcIRq
         Tw4fTzJA9EB6nlXzd80bMpQk44iyuYjdQ2HrqXOQUH3yz85QDVbgMgwL7Z7waULl7lwz
         SFB7QL4L0BB0On9OuWfhYBapzspB5/8MCoMzobna0Wf3GetL1lEtETI5ccEXEybzOjE0
         9ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602375; x=1791207175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
        b=v+L3RyCUx1mvm4gql0/C2ttOI2II5pB4Nij8TQftFS22pEcIJ2RrWC09JYqE6VE+yt
         fqX7+ywL2vkxUUtsIUWNluqepcOjEP7JI6ebTPW/YTt/iAYK1/GDmRrAiZqOTCaCu7C9
         XeZwKBiCm3+Hl4CCOVvnUh/iCDIpg35qzrTFED9wjdx+2ae3Xap8xyuoYexyN5AYux3P
         EScL/NtZo/pIhpghX1B6oAfPuHrhessQBAzo8l+2c8EGxLJZeq47sXMDapvh/xdahxa/
         imIyMjHSBLC0ZnYe8KgcFqxrs0ffPQwA4x4fe5SN9ORF4xqnlFtzcdXzgw/MEd7TW5iV
         qidA==
X-Forwarded-Encrypted: i=1; AKwUvBwN81dtX7NQQYN1OpJtNCD2AdPthx0YLOH+vl1KUM4eVbWjUN1gla1LVOvmTiO7jqfZKr7Azp2bit579crI@vger.kernel.org
X-Gm-Message-State: AFq9FYIGWtgX9vhReywJgdvJECMHkt/r9WMEfI1zppHppli15UwKNiKT
	BJBRBA89qGOwkkAPjWcpWWItMktebrNXWUj7fupzTnjNcDc/hFul89MH
X-Gm-Gg: AYBFou2AQB15wY0CzKS6Z8rAv3HOcMdiw1J5Ym24CI3WSLxP2JfvIMM7iDav1w4w4lw
	RfCi5clKHo0MlXRX72/XAUZjKq0JfV5wH0KRLRbAtk5LBOowC0qAKijbrFEIHCwyHVu9BGdjs7x
	e1lnOASZ6pe4sLtj8EzNXbike2u2ANtgeRNVzOfGunExy3G9KdQYdu79n5ry9ubnDY0J45x2xO8
	SxvCyfeYSQboONjLpu43y5WukLp0HIgvfpvrlD3Jvy7LlO/64Fs1kKmpNV8TtCVjxLouSw+iYo9
	q5Mk453JPgWT6p8GOahyEgmjE6J0UH5+d29NS2xTQqDNznZm2hdugX6DTQYHDWcped3/62AD/gH
	BykGv1TDmL1Zu4lvgcrT2DdEZisKsxkQWc2oWi8pUsjLrVl8equTLNcCKiT4h5nnhPPvp5//KrO
	5KPg1nC0KDkkpOyavx9DkkSexVQopDQl8Jml4op5q1EFkGHZD7OdO7JbqjnA7p5HDmedrXBoBHq
	gQE1nXrts5e0m06nfdi60rmYwWooDRuHd/aaqNCJTlTUENSa5sI7/0A90z7ZaiHiOXPLxyFRIjM
X-Received: by 2002:a5d:5d87:0:b0:487:342:d147 with SMTP id ffacd0b85a97d-4887db39b7fmr20252053f8f.39.1790602374884;
        Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
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
Subject: [PATCH v7 07/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Mon, 28 Sep 2026 14:32:23 +0100
Message-ID: <f950827b5805d13f08f0060df0eebc4ed56814fc.1790602223.git.asml.silence@gmail.com>
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
index e58bdd9a4098..bb8051c62926 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1277,7 +1277,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1307,7 +1307,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1329,7 +1329,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1492,13 +1492,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

