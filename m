Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BB439346
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381888; cv=none; b=XfiwUdFSXjDECsfVawNlQYh7J5fls3P5HCY0142zZl7jteB/Z2oSrqHE3tQTC5M/rpzcIqICIxLmK7LG1WtFJZGwysVs+pNP6Etbu8YdYGyfP04+Oag3ignucMBmLimeGiK8euw3xTep1A5m1lCKzUyRmQ579fivG2QhpVfYrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381888; c=relaxed/simple;
	bh=mavxj8Ed+X9L0RNO9bApjFiE/TIWG8+FWgXsB+xZV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPCxqAgt01mmkX2SuJi7NQAme8SlL2uB38AaWfN89KtcY8I3KwPNh0ULQ8n+1XKGuaZOIsSEvlSfWzjoA59B3jp+qajZIaGFz1ov4MBmOUPggaoKcHM5wEjB5pkCbPem1qcHAZZ5fkRF+OvQvlydtbY1a/1jSdajnRRRVI1NxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ph/9MVSI; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ph/9MVSI"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1955139a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381886; x=1789986686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=Ph/9MVSIxqGhy8uuyRpgn4VyEtjFe9N0N0PWlSTsnL/qWviCC/pR/9ueFTZ0xcwiX5
         +zQ2Ye+mRcoNBEItrzbD7yKFhaNaPsRn9QTJvzjuJbDtRTpBQzlO0+utIN3YSHtW3kMH
         fe1S4916k5U4SsGxkstbCrCElXfMNE5HDlOrLh4SCmm0lxs0F4BTms3veqGcxS3E4Hgy
         TUHda9lhF/WJGc5/8b4k86W6Qx9fszgNN76PFUmvzsxeyQDXd2P3uI/aBViCrEfL01sJ
         jhTO8wk0ZxO/73n/8gg9Cf5VDcxB/IXUJI1siPDJ1yhiGsjM/YstDWHqN/WtkIhYIXM8
         TY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381886; x=1789986686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=sm57PQWS8Jtq0PfsRB5KWX1+WdvJAQldmT1jy9eW8LDtOPg5T5WyMybeHlB6kp3zTV
         6HmBCcgZoQZKooUSsYYyHgskYJHloW3AmQZcEeo/Cnjnjd5mlkp6NAEQ00iSX+k+lxvz
         xExjZtKqxc7o41E+V+rWVBMRrJ7md+otn8QdsybSPgs/p8RylxhOyc9JsI+aypbI1TmX
         VITuzfHw6sUZUza62P8K2OSX6BMHAe7cE0wH6p48V7MMkwe8n+yH+E8ZnY+1XdZ49vbA
         AeInpieaTNdiQD8xN/sjaTPWCYDBHY5ZaBHz7o1w0w74VTrFWPq3kqC0BYcAcvdE4Q5m
         JTSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxI780dCxoI4Bo/gYW+Vf+gegfUHK0rBF0aAMEcbodScgvYOJI2t5XHBYx7P6ui8mnuin0TXOpylPfODQSq@vger.kernel.org
X-Gm-Message-State: AFuF++nnJzcIhOmrXBPinZ53HN9h0p2xjisjdmf1zlzZfrXImkAcd9il
	iecAoKmwiakaW+Lt24n/ID8mrymkSsUjtRfyQclsW7uB9NQ0FGK0+82MznlRxQq4Q/o=
X-Gm-Gg: AYBFou3brM2EVpdRHEvmIU2E0C7U0zYx2fBk/VwFSE4Vumkv1XhriR1DY4d9TCAuZPE
	kBZBZ5WhWNIvJcdMz4gxutQYJTEUqwiCdsOyaM6MEO1ljqTnmmEhdKOrE1E2Jze+54uvD01jGVc
	IuKsR+1YCkLZIty+9pmeofF5n0vSXexGfDhroBPzkwYI8DWvdpSxVOUovJJ4Qe1RDmsvqDjG+cR
	Nmc0Wq2qK5eCKCcgkoxeM5RwwxeugsA2HfGidrWwXNIrmko+LVGk6T2mBQnbJnqwsY+M69jfOcZ
	oZIk5fJ5PtGt1ejCd2Jkq+BID7q1E3G5EqRXnmHt2xd5cfXJdMnNxu04B4i2+wXqXyHBa4S+Asc
	Sq8zlF1Q8Q49drA+8/EQrrYU0niJq1/7lgA8UYDru9XTDGN1V5RM+4gAdPbi3TMLOGeqLb6Nt8h
	jHg+PsZW0H88jtagO7TQ0wAWdqxk9fbDXm8lhFD7FGEOnipZOkLT0MiPlDC9lPjSE1+elulwYrS
	g==
X-Received: by 2002:a17:90b:3ec8:b0:39d:e43c:5a0f with SMTP id 98e67ed59e1d1-39dec059046mr4051213a91.14.1789381886134;
        Mon, 14 Sep 2026 03:31:26 -0700 (PDT)
Received: from localhost ([106.38.226.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd6f8ebbdfsm5362385ad.38.2026.09.14.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:25 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	rostedt@goodmis.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 1/3] block: introduce bdev_flush_by_dev()
Date: Mon, 14 Sep 2026 18:31:17 +0800
Message-Id: <20260914103119.1708452-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260914103119.1708452-1-sunjunchao@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bdev_flush_by_dev() to submit page-cache writeback for a device
identified by dev_t without requiring callers to hold a persistent
device reference.

A subsequent patch will use this helper to flush foreign bdev mappings.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..da1fc56926fd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,30 @@ int sync_blockdev_nowait(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
+/**
+ * bdev_flush_by_dev - attempt writeback of a block device's page cache
+ * @dev: target block device number
+ *
+ * Skip closed devices or devices whose open_mutex is busy.
+ * May sleep while submitting writeback; does not wait for all I/O to complete.
+ */
+void bdev_flush_by_dev(dev_t dev)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_no_open(dev, false);
+	if (!bdev)
+		return;
+
+	/* Prevent the device from closing between the check and writeback. */
+	if (mutex_trylock(&bdev->bd_disk->open_mutex)) {
+		if (atomic_read(&bdev->bd_openers))
+			sync_blockdev_nowait(bdev);
+		mutex_unlock(&bdev->bd_disk->open_mutex);
+	}
+	blkdev_put_no_open(bdev);
+}
+
 /*
  * Write out and wait upon all the dirty data associated with a block
  * device via its mapping.  Does not take the superblock lock.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..7a5f3e2f17d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1710,6 +1710,7 @@ void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
+void bdev_flush_by_dev(dev_t dev);
 void sync_bdevs(bool wait);
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
-- 
2.39.5

