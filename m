Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA1493D38
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992429; cv=none; b=jJ6y3t9+OGtenTcxUuL+nz+WGy/VBQdBEVjZFKtTfABuSIHZ0bPe9uBGhpWZHKvFxNqsc5sCsnxDOMfBe1wyPTuVOelxVGEaXz24PtPBU+ucOra0LmtonsuKZIkeOlAwDO2ovXsmrwVIhxeFKhzH00y0MStCHdBCA+ouJLlWt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992429; c=relaxed/simple;
	bh=Lc9voE0hgiCsYr7Bd0maJaijHuhYngT7G2qBAu3lQ30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrSBBfmC6BecffQm2C0clc2dxVc8IwQ0nL7EJDWVXpVJXow6buPmrqyg+oNg8qOPpk1fuyYsHiJ7+fRKeeE3OTEb7CLvL3dn/HYVf8/YlqRCyvApem6NArcevhzHIiOl5OSCJDdvw+tU8mF5Wv5gch7NcRZR2WEI0nSrLL8bhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d2Ra8aUm; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d2Ra8aUm"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a3so2491211b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789992427; x=1790597227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYYfPRZ9YElxZosA1zWn6OE24o4j3HFVT3Jg17cOppw=;
        b=d2Ra8aUmesZ/+UvDFdW3tgT9d73JcodTig1oNzz0IQmknOzJMr7qPf7YPfFSHoxTsM
         Za1L+zkRc+WyyLJpyks2bdvUOXgJfScAcDFT7WNaL46UO3gPn0z0TCkF886jYqCxmU3G
         eePok3Pz93YUeZ+LrmvopKkYXWDm1ajufRgYksLetnDOgUdc8B0krJ4HuNTC8ekv3y/c
         /6Qc8OIIi+y2dpq7ntn49g1khz3CJ2pUONB3iToe00HX48KW78ITYUI0ldPRjCX9gUZS
         96KxIvlsWpKc2AiiUgVE0rYfU+IgQU8zQEgoQkEpR9JgQEbbWDeQzw6JB6zsx6Vldz3Y
         71Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992427; x=1790597227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYYfPRZ9YElxZosA1zWn6OE24o4j3HFVT3Jg17cOppw=;
        b=bKfzvVzltGehwq2NUBGsjLk+KvlJM1RzkjnMyDE56zERN6G/ZUyfPJPVVF1c1tk4CC
         /KQKbeA1fv8YKzZ98dv5fqMHsScFz4scpzEF9g2RNnS8yPF916h2HMx/pzOHOZEzoEZE
         LLwnr0azdc2EZklPiYNUVfo3uytsZkrJrxGG3TbqC9BjGav+PP776t7BF0Rtze4e6ivV
         JMc+KWJNG0JJF2aXXzZY17vrsCIZN0w9ETABzdBcPljAu+5Ou64Gw7i85N4B8kOrM12q
         V3nJWwIXviideEhdygS3jRyxvZ373lCNFFmfzSiCL8kQodH+vkZ2BteSrYXU7TykTfjW
         leIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwj1ov2Ha5CYEyA+U3a9MhhyCwAFH77K/JRLBhWyhqTtoIQ3q/Si9KjKUsJxknQQI2grLjR5sVV00FUERA@vger.kernel.org
X-Gm-Message-State: AFuF++l/JinPfRBGZRLgo5qUWpvWLTSCxx2tluptKNufPzAwJHZV+PNI
	y6m9zClrks21Y4wPpLnC+wairuZ9FfHUf/1d+Kz3jPl7udsNTxc1+U1NLlsZPLFUuSZ10HaEMjF
	LkcPYGls=
X-Gm-Gg: AYBFou3hA3N0MotZRieLfqVx/JTnGK8NV+k0rR8LbGS86U86VogiiyPgZ7Y2nItTXj3
	p10Z5KXKdAhlBzIsWUS7MpWoSg9UmMgvo5r2JFffGjNa91+lQVtWC9mtYlZNVmjVt/wTbQHnxYd
	gCoeGMKVm3buCFmN20pjC6oBUwSOsScNl5JYOA811QRULBuvenmOa/Xx62T8PNtIvUkDiOd8pmO
	F2T/v5jwfwChTa1Ihmt/FisghUY8Tr7ouypz8PpdKzzKxB/JGjZCUOkMkKJtn/AYjN+14KYb30F
	GxSo+VIT+PHrRiACcZvfHqxOPWryoGVd7KResR1KnkxkRNr6Tsc9frk1KwND9W3oUAsRmC6kXaU
	fkyJJWJ8QPyCETWOvbCoB80bzNph26sW2Pkgj2BDqA+IjAOVYy3MxSdZah3aQ5hz2HARsoJw8wS
	wiN8qKpYru+xb8aanIZ8m/l4kP8scw/m2I2ghIwD98QcDeh2Wa/V1ocG+sWw3bli5c4BoagCRKw
	lMaIvzBd+Cq
X-Received: by 2002:a05:6a00:44cb:b0:869:2b72:525d with SMTP id d2e1a72fcca58-874db7f1b4bmr15010249b3a.7.1789992426597;
        Mon, 21 Sep 2026 05:07:06 -0700 (PDT)
Received: from localhost ([106.38.226.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa11153dsm3186329b3a.51.2026.09.21.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:07:06 -0700 (PDT)
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
Subject: [PATCH v7 1/3] block: introduce bdev_flush_by_dev()
Date: Mon, 21 Sep 2026 20:06:56 +0800
Message-Id: <20260921120658.1627992-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260921120658.1627992-1-sunjunchao@bytedance.com>
References: <20260921120658.1627992-1-sunjunchao@bytedance.com>
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
index cd8323083740..5cbf01a13a33 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,24 @@ int sync_blockdev_nowait(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
+/**
+ * bdev_flush_by_dev - attempt writeback of a block device's page cache
+ * @dev: target block device number
+ *
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

