Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350542BC44
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187505; cv=none; b=VnkYY1SM5eUcQdJkXpxE/Ezb5+fvRsho+q38wSsjx08L0c3Ecf2Mwz/3Un+ITnfYebwUOmR9Yu3L/XHjsMJTeO1qWWpPQerB7DVBlubboVm5ic20ZOZs5rq+uSyI3YRrDuN6qMvUygB3P/pXNrP5FiJ1f1XDoDFH3rqydPuEic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187505; c=relaxed/simple;
	bh=2UyWaEZMu+4JOZjsadUpJV4QsMl/vanPQVWy4b/+7s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIYJDyc4KTnJirXBL2W3Pfd9LRTragLEJaUXSEcqTeTjau+XTKRxdgvAZyRSk0KcBdb3pNVTfV9U9RYWrunHO394c+ETu30lVTxcqphZaSxHBWFqYMtsHDAaKp08NnZMQEfbvzcy1o3Rzw+mWmczy8O5HLX9cByXC1NTqL3PTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXp0AOEe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXp0AOEe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so47208265ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187503; x=1785792303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VX4eRtECNtngpeRNy7/vdvjlvGkPSiIhLvkw8E1S3w=;
        b=EXp0AOEe9/K6CK+K1MRAr7giNPsulRs55P9JarEUEm3V+2yfuX1Jp6/nbn2Sw3ytvz
         gAcbkFDjqtcwROwj5BgLYqXjVDqPV+WQZyvjwF/rDjJsPFoJYMR/W0rUTXClx4DZHIbn
         9qke4BTwVRNoZwiKXVEcbQA+o1E6SjEpYpqGITpvcEVCjnM1rkFagmYGwecyFNJCmSPu
         x+yyJYMEcBT73qMsneB/9dICmoKqeL/90HOQvbpr2phyYLvJNeksDNU16iJXRCJCCOKe
         YLadKpFR1SuAVr6ecwZz8HXxB71MOzknDffZORwhEgSAChY0p/oDmt6uetG5M8ZUq9N4
         26VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187503; x=1785792303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9VX4eRtECNtngpeRNy7/vdvjlvGkPSiIhLvkw8E1S3w=;
        b=pIM8q78V+ymWaWInGdtZD3YzRJnEsjnymmP6FXbbWTPI87zQMV+tCa3rnsOLYlRPXc
         kjJ87is9jFE5cuMIsUoQuwNJHS/4AeVFqQMeD3Gk/24KV8HRKoGBMkOOtvGAwVQ14ma6
         j2S1oAXtToNwKfEFZRz+fbyom3oWrz3FALwoQWCaovhg20+Co4kf3ytyCe2ChQJa7IUz
         bCGiQFoF0EP1uZfa+PitS1vbkd2cBO+pCBAzh1nG34UcwXCL2eM+AcB5h6W1Y64KODGc
         5i60/wN/rO3y/wBncPS9O4va7rRyzaXp6FFyg5vJyomQdZf8enVekOMImcEyKVYLYun+
         ebCg==
X-Forwarded-Encrypted: i=1; AHgh+RrJg1Rnmb1wh06fzUdUigFWiVw0achli3pX1RLMjKETHTzQzw5gBRZv3BkV60p7tehAfempL71n3HV0QRMP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpi5YfoxjaW1rz0zuNfHWr84kpHOG6DEWjWXeJ0Ts73v0i2zPe
	qZ/ddZM3URb07sRyB+y2c5Z9JMS2ijaTanX8dFscN+NrX+wQG1hTCHdj
X-Gm-Gg: AR+sD11vF2lCM79Mzh9NhlJU737l8Yx8epcQMRoePZ4Lh0vjJFvOZ0TiEFvqFO8guWs
	1gzmotapm5e67mRHm4h6oN5C4Ax1CCgYRAh9ZKKNB7XoYYcxr+cM1cUrgAY5Xh4QU15qmGWOs1l
	clLbHNj6hRU3gN63n0LkD+G7kCQv505Ck2ykOP5CiMMbNybtmjDIbnf74mCu1PA/Fj0SppKMuFx
	ikBs0yzpaEG8pzOXRIE0KITu+H81V4aGXHgKHGAKHQQZK/PCjoyP7Gcp8mwAgeUAWoYDallFB5k
	Ss/yycYyhDUgLJugyH/aa3XZmAdMburKVriVlRf34EpCSQnhYBxOtPQGC9Wif85vpxQ6qCC09pt
	1L5QJYD1zamW6i2BPb3jZ2sCQAo+o5zxSxle9IQnPuAWHiEBRqdo8X3q5xNsura214YWtqLLKkz
	xqPrzBcBh/OLl2j9orDKkMTXFE3E56gsOW7y3+EvZtqX3IYoJ1bC6Z8A==
X-Received: by 2002:a17:902:d4d0:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2cfde851c5cmr95616575ad.30.1785187502981;
        Mon, 27 Jul 2026 14:25:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e28easm40897225ad.24.2026.07.27.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:25:02 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 17/21] fuse: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:54 -0700
Message-ID: <20260727211758.1116539-18-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert fuse iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dax.c       | 6 ++++--
 fs/fuse/file.c      | 4 +++-
 fs/fuse/virtio_fs.c | 3 +--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8b53625ac7ab..85cdf0199bc0 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -653,9 +653,11 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(fuse_iomap_next, fuse_iomap_begin,
+				  fuse_iomap_end);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin = fuse_iomap_begin,
-	.iomap_end = fuse_iomap_end,
+	.iomap_next = fuse_iomap_next,
 };
 
 static void fuse_wait_dax_page(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ea4a15a7635a..1c346802f877 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -890,8 +890,10 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(fuse_iomap_next, fuse_iomap_begin);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
+	.iomap_next	= fuse_iomap_next,
 };
 
 struct fuse_fill_read_data {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index df25d4faca41..f15e516ebcb5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1024,8 +1024,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 }
 
 /* Map a window offset to a page frame number.  The window offset will have
- * been produced by .iomap_begin(), which maps a file offset to a window
- * offset.
+ * been produced by .iomap_next(), which maps a file offset to a window offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-- 
2.52.0

