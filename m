Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD05476F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081427; cv=none; b=jcw0hgUQ/liA8wlk5w2n2aZFpSo2yfkmghXVH+BusanhyrtponKm98SeE9akwCgqWqwwcSLyoZMgJD7tAi+l/0Ej7RirRn443SnKgQBO+lAXL0xI6RHOD8MnfIUBrJ7HHgkNvDVbXRIqFUHi+xz/vdXZ/PGUvBuUxudiUF+pVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081427; c=relaxed/simple;
	bh=OVbvIeLOhqJ42EW9bnbliI0g3ZbEXa6dKvfmz4becr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqv/c7udqOZnSm42kwQMuHOjI8twr7yPX3cExM1NGGx8mYN/xrNcN2n0S45gZ+fHfEwauLBtQOeGwolPVAtUKFcQdahmBl4P0Rx6SK9MM1nJmZsgO45kXvIqxQXM3GGm4Cw2BUT65aAh0w8/TLYkGEySJbqdfzubKSXZyM93k48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fNPXUBGf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fNPXUBGf"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso3407554a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790081425; x=1790686225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMP+BFq9ZlWmX2QdHDpHEHKHpmhLYaMmTYZYw81jZH8=;
        b=fNPXUBGfzH0gPOUq37G6KTLE1YJMhY7UxJzDsEM53X+WHTVHZW68mBeC3+nQ0fj/7h
         dF1BcQzEB52Q9B4L1UuVPWENPx7XKVn3cGOQZmW4cH/1/RgSGQiSMZ4EEvaNMw6XuCFg
         F0e6OvgldDdUrVyrB5xZaBEmg3hrb/4yglK42uPr2GWUXndQvPJ5PCUqzZV8ByLKdb41
         dbdFvVJHN24ffHjmLpqOv33wLqHWoQWdbvUgCs1GfzfWaRGQ9XcJIhPQgydzOylvZTGk
         Zg+E1O97hjlZXwa8TwOQhKN3QT1Wf3GSVD8TXjPmEgZOUB+YM9JUWTmEuyIowOvMkrm7
         lm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081425; x=1790686225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QMP+BFq9ZlWmX2QdHDpHEHKHpmhLYaMmTYZYw81jZH8=;
        b=2TjWuk/4gcXDc4i6U9tk/g0qlSwDz9VYjhxtg1JqtUIlzzadvKzyw6o/qez3nHHdux
         3rcaODcVcyafCpPNW3WSTkgH2bVuWz/wi+7T9t+63kzboBjnmF0jQqyQaDzBjHkIQrFK
         TGe4XR9ro7k19SdTSuO5333xjgDNCHnLRhEXDk8sZd7R16eM8SwUNpQwCkfhZ10qhKGj
         KCurDZPYHfgraZFMHqJ4nfM1/DO4BPcmkBOVq6IzUJXsS8gCE1MpF4IAfwnEPJKM9K7G
         dybyPDU9N1zRn7mkUSJiiZKXpvCEPvxfY9Rc+L8DgdcMhnBIeecBi28mybNYqtgBl9kk
         6QiQ==
X-Forwarded-Encrypted: i=1; AKwUvByFrB3wbT15vvz9cKyoPUbm6Ce7+MTXLZr31tiwTv3nS3308IvfyvlPbAx6ng/U4u3LFEepYQSW3aDXWsBw@vger.kernel.org
X-Gm-Message-State: AFuF++n+WhUJIlX7iIuZWDJyOESQOdZjklTewcu2gsMOVbah+11w8JVw
	Fw7d3/BQab+szXx6H63eCqLWB24xLCD3XvE+enex9aomRg6+poGrB8Vst7nz9QZyfV4=
X-Gm-Gg: AYBFou1KvvDyFT2E/NzjjIz3xpjax25Yem8nvedcR2c6CiRS8SgIsJcxHrri5VOVshm
	/i282HKbsJsslUlXMHeEqRVmXRZudAzHTj/jiaMtOyTXcq62IfvHb4nL+7bINFAU2KGvRkhWFhw
	iYDyExzA1ENomRclnkr8nm2G9O7sfzw5A+o5qgD3SZTtiLVa0uA/oZYN0VPdNiCajB4wtIuI2oP
	biJv4FkI8RD0blKwDx83/tbtM8uJTTKucZ4BYqG+iamTa69gckEOb0GG/2u74FSMNLaYXqyCruZ
	m67cJzMJ/AoOFqEpObxKT7nN10nLQ1vcgqvoHIy1GqnybjRyfbuNcyLRnqfYMRZja03VSN3K1ke
	VkXU1fw6Z3gsL77Hljp0nZr7UPQNtbTMtTwqYtcBsYk9jgTcUcW16tsGLQ4H6Y9fQn/4/GPR0yG
	2VVOvBBInfd3v8dAM96UYXuqxMouA4lXM0AiCuG2gYabaKsZ7wpaOJ3EEuM18OU5gB4+925JhQW
	w==
X-Received: by 2002:a17:90b:2e0e:b0:39e:6a7f:eef0 with SMTP id 98e67ed59e1d1-3a0731ef86fmr1186255a91.21.1790081424649;
        Tue, 22 Sep 2026 05:50:24 -0700 (PDT)
Received: from localhost ([106.38.226.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06702167esm4845702a91.1.2026.09.22.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:50:24 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v8 1/3] block: introduce bdev_flush_by_dev()
Date: Tue, 22 Sep 2026 20:50:13 +0800
Message-Id: <20260922125015.3435215-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260922125015.3435215-1-sunjunchao@bytedance.com>
References: <20260922125015.3435215-1-sunjunchao@bytedance.com>
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
 block/bdev.c           | 18 ++++++++++++++++++
 include/linux/blkdev.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..c7c192af6262 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,24 @@ int sync_blockdev_nowait(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
+/**
+ * bdev_flush_by_dev - attempt writeback of a block device's page cache
+ * @dev: target block device number
+ *
+ * May sleep while submitting writeback; does not wait for I/O completion.
+ */
+void bdev_flush_by_dev(dev_t dev)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_no_open(dev, false);
+	if (!bdev)
+		return;
+
+	sync_blockdev_nowait(bdev);
+	blkdev_put_no_open(bdev);
+}
+
 /*
  * Write out and wait upon all the dirty data associated with a block
  * device via its mapping.  Does not take the superblock lock.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..27afe3ff6fb5 100644
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
@@ -1726,6 +1727,9 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 {
 	return 0;
 }
+static inline void bdev_flush_by_dev(dev_t dev)
+{
+}
 static inline void sync_bdevs(bool wait)
 {
 }
-- 
2.39.5

