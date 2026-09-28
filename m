Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6664D1795
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602392; cv=none; b=r30UehQA1LnacJzshaFxSWn9AXt1e11O9qRTyJYNl7jmflNPpecjxr+/LVAYBqFGTCVAjdTrokW36UsIgdrSBKFabBCTo6gdM5pvrtLRWcufBhbFfoQkw6SMlq1mGmfpSe3qM5f/H2wrRi+eVxxT4T9ca3r6Q0P75WhLQGrw2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602392; c=relaxed/simple;
	bh=IlrTb51Yp7Rjs5yQkZp4t/TrynsY1IZo7uIZ92+N310=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKKNICmfUS0+FKuBbR24DrGdrbyHoKGGo+54HXq+SOiUdaQDwlBdjtvqMcxhiJ48ao+OFqC4PCyiOVBEsWJWDyV+g3FlOBKq4G7fCNOigitnpQl//90fQKgnPCYE4zogXfnw5EmbohmwCmjejJ/I4MRQ5qqnWpf2gNJHQUJ904E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlWcxP56; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlWcxP56"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so2991034f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602383; x=1791207183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
        b=HlWcxP569zau9ROT+qN+SxznnaiYSV9KrVWazV0861xi53VRCILlOmXz5swGHJFDYI
         sr812SmszIoHGeRW93B6BeXrBPpqzJaczA/Num1FJ4xLXKGLFnqPI1Iex3Kld6ebToDb
         CuKRyO3ER+8mTNfkwi5baXDAyaTpSXduiIg0QOcfBPFW75QynblkyNOotCAFRCAcgwFT
         Gfui6bzkuxEattU7HPfagJf/E5ehELiGqP5AXNeaIVRUzy88LptUC3FLt87MaSAvyEHK
         UPL9I4kTU3OiYlKnDLUdwa380sqFPSzL8dd0c5KNuQtRj0fSvIMKhEpKaQi3OSNv0wGZ
         y9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602383; x=1791207183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
        b=LOA2qnJuNlUHDK89SPaiPlM3oCplwwZvQ77XHc2crNZMHdd+Pjti2ldsd9Aqtapl5v
         TCuCfUkOGTis0gZcrS5rtlzKWhy/fIU/lrgYdqaxjAIB46VIBQJbIzX8spwUBIlGnS3e
         +ZjLMpDZkhwOGQk+ELARjnBoU9Q6eknlnSEHwhNCjFJT4QZRDbwNF8cw+vgPdO97U2Nd
         qwdzHfai6fd+2mxyBEDHSzUmRbYOukKXWmUDtmObV+5CtaPRIeHWtpV9iDxefzZ5MrR4
         vifhPw+9t3r1m9MWlIyPEjaZlUeYxYfZ8z/BloGoxcNQeRr8V6uISfxunrMBIFmxdvbL
         F54Q==
X-Forwarded-Encrypted: i=1; AKwUvBzx3CzrIn8Dqdqz8dTVvLsOZl60X41mpSmmNeHAD2gqIzlityBvALZqnw0cuxlV3H679lcw5AUVqGqW4p8C@vger.kernel.org
X-Gm-Message-State: AFq9FYJAS//+8olkYgJUz9EcNoNQRd9Zfjj/y76oQkztb4/+mdZ2vj0e
	rk5aT1Kk4o0O2ITkGpVSVsPAlDRnndpg8fswu9zQQEFfkyl+nozGVeSG
X-Gm-Gg: AYBFou3k8OKHS7CZlEt2jEIff7YuaJnvgze1asytAzqhjvFabU4MAoK8ORtBAHf3W47
	fEXbPFHeGddb8aJl9a1XC+Mnzp8YU+/sbyV1xQRHG8/iOyXzHkJUz1xZvyMpmEI8v5VRRNX4CIc
	TCGyS5+1Fyi3y1ClVDXtB5NnhgYXefyPaTx1cunNYxEwuU2iwkEt+DjASPPPuWH659QTMBlxocj
	1g7Cu1fA3sdb8JX2F9jfa/fBpdwU6TWLaqswtDQopHVqCPWbs+eDoLULAuH53p6a2JlRzsux7x0
	O84pGt0YGTPc4pRX+xPiIuOSgcpgKdZJsx08cXa9y3yZmXGHI6mWr7FV7xNtHC35uIr42hw3dSt
	JcgohomiNwQJ/fYNcNW6/GO4S/2iWWRisrPufKrHK9/goh6mNd72/HC7Q54bWHwKSrvoqlXTdqp
	tM6e0RSKfT0SL/bqQa5mN6vs6ZZDxPRIGo55JkrBny82O4nuiMJad1aL1xaRyOl/7zQI+1uViNu
	5RnOB2G0nf6me3DLzfZyGQtx1JDLprsZ9zSF9CUvsjHetQ0scXTbBtwAr+h9Rd1o8D2lJFf/rOL
X-Received: by 2002:a05:6000:2893:b0:487:10a9:57cb with SMTP id ffacd0b85a97d-488719756c5mr21965332f8f.49.1790602382736;
        Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
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
Subject: [PATCH v7 12/13] io_uring/rsrc: add regbuf import flags
Date: Mon, 28 Sep 2026 14:32:28 +0100
Message-ID: <692972b0ea345774fda580a53e2b1bbe5f771aa3.1790602223.git.asml.silence@gmail.com>
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 65d6cf7201ce..6f6860d6ca03 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,9 +1298,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1709,9 +1709,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0

