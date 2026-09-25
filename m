Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629938758C
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318693; cv=none; b=ZnxHAHl8DJe5Tw3c0fqfmKPV0M9HRJzl1lTHgGTnGhheRKxCuPpNIhhWHXLjDq3V74z0LC3Qazbn1hA8ABk1HTXTr52dYchZUp/rEBX7dIrhB+4zpUz9FwtW19ir4pq0/UPa1243nb7sKCuo8acZ0eKp+k/8wpfzgp0UJXwkazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318693; c=relaxed/simple;
	bh=Z8emA6B01W8D0WrC1qFHBBKaSeXCTXQYsVv4X56BHHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ls7bUU6pXD2IelPnVR0diJisOOubyRR1h//Hjlp3JhMsT4rpEdgHu75hgwm4btOE+oGVg1dUf/UcAAZsrAVmkhDvp9nbsL5X+4llDVF4dLKdR4llswRLlzB8y6uZ3xu4j67D8LAu/QLe/KXCjwuwg7BWiD64154bBtNum9LLxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lkEYyepy; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lkEYyepy"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so330054a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790318691; x=1790923491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9E4G3HrBDA8sokqzu1SybUYi7yZEI+oyuX+vXgEAK1M=;
        b=lkEYyepyeNmT4cr0O1G5vFFHDc5fMXSKQkc3+5JP/oZaAiEV4Sc69a8vknbVEGPXJR
         bxeGb9iyBKlQm3ujS28HFMR5Fwrk/OMBNATAHI0D5ugtCkoIsj+Vp4fzyi3It+31yShW
         aHg5HkvV+zrRjhdh4v81su/+AZxhz1uX0QPPMgRGcu+lteFWyhOhaJtjA6haZcMbYKWl
         RtZwO3I0nnV1jPfb7DN+MUKcoPh9y3MoW0SaAWOFLK7SQ2t1IcaDICDGzhmQmR4c9Lzc
         imgQBAtRA5r70TnDWrQIQEyaNSXJRnXH4IaPKnNktrDgQK9/hApwOxviIaRIXMtzZKA6
         RkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318691; x=1790923491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9E4G3HrBDA8sokqzu1SybUYi7yZEI+oyuX+vXgEAK1M=;
        b=Y0QfDI8z/7Brg1GHpgTVkD5cDlNoTWAzKIXeFwtXlbac96FkGOkDJLa2O0PyeJtpKM
         cJvPOdXa8e4rzXhCap1BxV0yk+acWKaZH3qen0Kim0SDrvqvz8OvrB+2oFUKzPUD6hz+
         oMfr1WGmJcSI1FscFlSg214OFeEBCj8uInCO3S9xQJ6zNlyMLqJuA3CrFLnW7+B1Py7e
         HTtoOvCLEvv7uRFnM1ofjsYZ6cxbXj9R6P4wP/Oq9wGB8wVxoGxtbVEr5ungnuRiGsGc
         MiPmqZPJnZkSW4v2a5W6b1b7axMCtkP6WUfEM6WdI9x35VHCyBDvysB5YHHhOutlhV92
         DjDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxysCUJymUiFVEH/c4ngV0640bbcpxcRp7YGtOyqpLNs5XYMseTjnKi+DWZhz3Lj86zjE/TOhqlnKo6lE6j@vger.kernel.org
X-Gm-Message-State: AFuF++kYyYx0zRooOaJ3EiimM27WAjxFoksspuIMjR4/3+YoPp8syrG+
	uwfFbaf+uH8LHFEenGOE70su/Uvrq8TpFUM71/V8P7VeBN69zkC5LiJ+fawYQTUptJk=
X-Gm-Gg: AYBFou2O1uu8net4kVmMoixiC3ZtjUrupfTavboi7jtNPep8OkYHiPZcrcv6QHEw9au
	Df4/vuUCHsfafqOCptYUIMa+mxwRx1zdrOGeAaYOIP3j94yc38jA5V7YwWcs2pMQjSkgsb4DVP+
	9he+m09yxP1gyWnTNS1uI/G75tkOnH+AAocl+1e2l9e/CI305cJdVI1AbxgO7nPRAX5UCu0y/dD
	NISB9HiYTKk7gK8DzxkO4HGsfVaQ2sfnYyqNSq0cuLsgl1TOnrP4YJvf1aWB52ZIQpfBtAhdWf8
	xDSAG+RE5XhjMqUJFnf9jH7VGtOgY/S/yvB4Pc/RkyvMmOcSgF5PjO6h8PvnnbvGNnZA3hGLVOR
	IKLwc5p8lOu3TxUVve2niMFxlRcEQyi47AKTCfoFMsbZjl/O9d9u5VmtABKIvd3jDAqaC4aGAqc
	S4k4otrgyGM30y8wXfhL4aeSYRwYbHMIYYYyunEG4GhMKaOX7wGGjfUegLxd6eBU/RkOIdKMEau
	dg=
X-Received: by 2002:a17:90b:48d0:b0:3a0:bbbc:6857 with SMTP id 98e67ed59e1d1-3a0bbbc6ddfmr1068552a91.13.1790318691065;
        Thu, 24 Sep 2026 23:44:51 -0700 (PDT)
Received: from localhost ([106.38.226.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm2594150a91.7.2026.09.24.23.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:44:50 -0700 (PDT)
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
Subject: [PATCH v9 1/3] block: introduce bdev_flush_by_dev()
Date: Fri, 25 Sep 2026 14:44:42 +0800
Message-Id: <20260925064444.3944820-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260925064444.3944820-1-sunjunchao@bytedance.com>
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
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

Use write_inode_now() with WB_SYNC_NONE to skip inodes already under
writeback, avoiding competing writeback passes from multiple callers.

A subsequent patch will use this helper to flush foreign bdev mappings.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..8925f81f16ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -264,6 +264,25 @@ int sync_blockdev_nowait(struct block_device *bdev)
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
+	/* Use the I_SYNC check to avoid concurrent writeback. */
+	write_inode_now(BD_INODE(bdev), 0);
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

