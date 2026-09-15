Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2C48CD4A
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461258; cv=none; b=H9pM/0AVhqjrRC4zkXWcR1eHw91+uTGYKmudwteeyaA3+suukhoG66oLm/GOK193Qw7JJFne4svTXQYnN4gan709iaxRQrAwK7T/3QcW15Y0PpylFGobhzwqncm0OaFsBTxAOf27dP8oLCRVpr03kVafrmeVq/LKWWoPInjF3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461258; c=relaxed/simple;
	bh=mavxj8Ed+X9L0RNO9bApjFiE/TIWG8+FWgXsB+xZV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guAlxSDL1xqmDZfOpqbJOboAqP8o7tCgj5EWKKhtnkd2/phEui1igDMWBALUxqy01c18gb1HeidpITdBj10q/pUmkv4tdR4mmgMzKp9zOS/b624TiZa+kj8VHy11go62aGnM0NyS6YXwV+BsSHsFHj+fmQw4UjkBW51WfLZoiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CJdrqIAl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CJdrqIAl"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so2877722a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789461256; x=1790066056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=CJdrqIAlNo5VQrrc8NxOI6qcCVSZ1DZ9XianXJcC9R04JxAcS7dVTbbyoWlDNJVvp8
         vNuSbTEPbjYgjuk0Wedh/rngo1H7+HIpjAiCkqEcIrilgv8Ve+FPkPJWY57l1Py0HQgy
         4H+jBuO9icM+BVSGCbW1oBE7TNnIsGR6UAvoiFgGV3hPqB6w3BjO9Rde2OHFo1G7IfVz
         0V95GEerVIG8Hjr5jZKM+cA4CAZKNVRcrW/EzUNMpQOdHvPZLesJ61BwkJnpDfh8h9Zc
         y49TPqls8G+cWiEbCMFyVvrdRo5XyVoG8+/PqWc23jG9gk/sLkrDpX2LKmxE59iX+MOx
         Wqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461256; x=1790066056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1V3VqzoDektllB8P7/EET50iFOSf0nM57ENcu/U5Xw=;
        b=kHyGAuK9XaaNqe8nipYWHrtaBHFWQj+kLxzTa3sOVu0yIrDfNmO8kBmdoJEfRhNYoh
         xkq6246TEflIrb0DynCnQippS/GL8JAF3Fhwmd+flYrw8F/kw1FA6yQav7BCPx1JoX5A
         B45n4fDDZvgo+ZfKVPNb4b0PSrbYbuzambLS2O5FuX53E3JAvvHR7Jvjb1kijP3kOSwu
         T36ZlKp5FvKslnNu5bKzNzrjQiupFx5MG7JeBFqPHi8lZF+TO6YfmlaqfKaZOoqcM5pq
         WtfaZ3WBj4yKIyQ25yAzWm+5XbuPOKsLEyfJmaMGyMDMoRrl7pFK55lF+SAz38BfFhlW
         n29Q==
X-Forwarded-Encrypted: i=1; AKwUvBxRPY2rNijvZ0IctoMPHJiavzfGuQLgBsIlQqxNjUX2svQvjCRQ8PkgBvkcnlRXgKw8FU67h1QfuC5wYxkB@vger.kernel.org
X-Gm-Message-State: AFuF++kg69MnSZ5nYYle1+sOdzw238DrjGTyHEXNCXwQCVepWAHDt4ru
	CI/okvKw88y+kLBcy1Ex9Rnbok4g5d00/V/wGsmE9kAKFaGUEAzwKX1DJgES2v+ZrXo=
X-Gm-Gg: AYBFou1IMmK0+1rTYVL7FSClC9YigzXGXN5Ozj2+LvUHJoO7nlMLK85R7y6ym8OCVzG
	wG57WGHlJeniYvpEECj6uuYmncqkexoNfBQJ+3K3888CTCp/WTvQ1Wqy6vXBsOD/zCs0h6vO3PW
	PY/DKQqb9d4dpIN05r3aH+GJxtZpxq21sLzxHqJiQhC3wKuXEXhT/MzY0xrlONCalQLyJE9sCVD
	Iuwwj13s2af4rl16+wL7qGm9kRTPJ8f/h0ytDipr08v23rpAlWlkHIc8+iODfOZqyaUAsjEmzXL
	rnw403DccpKbWy5JSPfyqRvc7FXcpkCRiiSoD1FozBOmx8j0TrINExFEJM/0pqY/epnZYOMUFjH
	jclM8Wj21+Tfi9UPdUW7U1Ag7h9Lvv7pO4y8l3JWk+mp2xfFz8rwnJsCLDDzISmGR0pscZm0QEx
	YDc8fdUwz/21A8kFCF4qICVAKPhKbOhhgkUzm7htlQQw6uraeJRbtNUhjO9ZZpd1uBKMNdPivic
	g==
X-Received: by 2002:a17:90a:1c8f:b0:39d:ec24:5ffe with SMTP id 98e67ed59e1d1-39dec2460a2mr8002056a91.9.1789461255581;
        Tue, 15 Sep 2026 01:34:15 -0700 (PDT)
Received: from localhost ([106.38.226.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm3919641a91.10.2026.09.15.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:34:15 -0700 (PDT)
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
Subject: [PATCH v5 1/3] block: introduce bdev_flush_by_dev()
Date: Tue, 15 Sep 2026 16:34:04 +0800
Message-Id: <20260915083406.3471036-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260915083406.3471036-1-sunjunchao@bytedance.com>
References: <20260915083406.3471036-1-sunjunchao@bytedance.com>
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

