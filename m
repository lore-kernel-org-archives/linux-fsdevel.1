Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5A41754
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318702; cv=none; b=J3ObXHHXZrmKOftSkUzlcb2v01xtuM6oa9syHEmRyqyyuGgCt6Cc1LBPj808t2lxn/zLvl+c8T2y/BzqDWsULENK/1gMvYFy83u9asgup7qDI3MMpVoehorDjUOjnqA3P59lmQIMIeWf0zMwlHRmLTp/49nN948R7mWBXeUeCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318702; c=relaxed/simple;
	bh=ZAyGGjTnqx9ID0gAuHigQpj5hlXbi5r1kLVGxRdz49Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6X7Ac7M1ivOSJ5cLdQv4p6Wa6tAZfJQAoRMgeMOJy5hnNo1uK8Yk+k82ghRZGcp7bTSMCqG84SWxe8haaaVUHOJ6FV06fE+Vcw2ZvL1XD8P8yvuotHQwmwn/6s5U0khcBd+l6Lda2HRvc9Ap2Immhj1hmKOqbwmhqqS9L14bsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SWGPynzG; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SWGPynzG"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc79223bcfbso34347a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790318699; x=1790923499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46ObzkJeR9Z1Ibx349d8JNyWVlYaD40DttrTljPNkhM=;
        b=SWGPynzGdy+HdoC0UgwICuz8nqDS5ITbEGXn/YEpJaxx9OTvrDelIyVIzgzOux2BMm
         RFWZ/w+D2DrP7InaVU/maB282Ve4o80AHf6wKWrDn4SIWnDm9g7qaCGvb7+kNLMzwquI
         Afm9ygx71DtijiuW0uJ1PxuM5Fn1t7zUOXGCuQ+1tCdTfF7+CgX7hlptFUkUm0GV0eLm
         Lw+L/QuCm/2pVHxCAord5ZCvr2f8GkATKe9ruDLLk/OSRzb8PIpt/VdJNXeDyIU6UBnR
         Y/O9PG3hQlXmbRlNhn8DSwk+nB3F3qZoVePPaik2gL6OHUoecCZEC9BMkboi3Mxi6xZb
         CJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318699; x=1790923499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=46ObzkJeR9Z1Ibx349d8JNyWVlYaD40DttrTljPNkhM=;
        b=e6nIvinMOSjcYGR3Bh7dq7bL50WOoYD3C5Cnu3QVhVLlbCdPJco+1twtnZGjfOXs6M
         2RpAuKk3Lqya+tbiHYW/rQ5vrTK/2Q9I2lvDCKsk56amIJZn0EHF8XyLeBodjqqkK+gw
         VwxyU44YYtjUVb04pzkzHZYurMaZzE+DQeAsNTXUwjP9b2Jp7K2iTTW8vJykvuoLopg8
         DxLHBFH8AjYD84c3qYLqCcIMzNPg7z2BPVdL8Sld6wBkfYF2qVHxaj+fvYyS3Me9IgAE
         81d5vXZv8lQVQPY3ITRrWX4+9WG61Px6HThLoeVOtUwJfBIJ+l3Nf/jl+CNfF511jMox
         x8UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxk/O4WRr6rYVLu6kMVaTVFM3I5hq7hIsIbYwHlp73jtWLBs6P2XSb0U7Qd4cxFchoacHubjtpyMm8oezXj@vger.kernel.org
X-Gm-Message-State: AFuF++lx8ZFIGTYOA+Bw6rsQ0UDbFfigoVM2K6oGrWRb0Scbjwl0FjF5
	b/p1tLMH3G9uj8/fm79UDYBZXmdCMm4XM0WoK/zSMmCQ7FvInr5oyKK7sLonf4gy/uE=
X-Gm-Gg: AYBFou3A23D+6yzXUAk2VzthCCRPZyXvlYGRedsa+FRYPn7qL1mr10sWEhoByI3hFQR
	rNMTMosgmY6jsEnBjMxfg8Z2KqpIV9Yq4rQ2CA3e5zIcAKSyfoQ3DVMg/K2SCZZNpjPDFxmmPXt
	i0RX6zG1q9tW1HzyhyCkfvS9JzjGv0T++2YxI/2ST0/n1rhfUrRMoJbhRU1YZmxOC5MngX9O/8G
	aamJarLL8BMibdGrlWPF5tLG2zG4DvEEwjmhNMYz/H4qv/o9PY0bGB8I2MXdg8SR/fcyipIWdiV
	cKLzTeCptLwzPoN4t0/YYmMDZKLmx38iT42kXRMzG6ZPMt4IJmkFgpXnhr4Rpdo6t7xQ8Erns/C
	itSVDoxfmOPn+JXkaNVljlcigixH+BgExu698N4BCT/FS5gMOipWDHJO5cZq7lPsZ5qk27JgXwH
	Vd0gPjl/mM2ZWkVG08jiX51IZHr1ng9WN3JEMgkzafwTmy+cyGno3IAefaeisDai/5iuLa2SgsG
	zE=
X-Received: by 2002:a17:90a:c08:b0:3a0:b3f3:a2df with SMTP id 98e67ed59e1d1-3a0b3f3a396mr1192901a91.13.1790318699459;
        Thu, 24 Sep 2026 23:44:59 -0700 (PDT)
Received: from localhost ([106.38.226.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm2776224a91.1.2026.09.24.23.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:44:59 -0700 (PDT)
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
Subject: [PATCH v9 3/3] writeback: add tracepoints for foreign bdev writeback
Date: Fri, 25 Sep 2026 14:44:44 +0800
Message-Id: <20260925064444.3944820-4-sunjunchao@bytedance.com>
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

Add track_foreign_bdev_dirty and flush_foreign_bdev to trace foreign
bdev dirty tracking and flush requests separately from the existing
foreign-wb path. Record the target device number as major:minor while
leaving the existing tracepoint interfaces unchanged.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/trace/events/writeback.h | 67 ++++++++++++++++++++++++++++++++
 mm/memcontrol.c                  |  3 +-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..4a85883fb8a0 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -339,6 +339,73 @@ TRACE_EVENT(flush_foreign,
 		__entry->frn_memcg_id
 	)
 );
+
+TRACE_EVENT(track_foreign_bdev_dirty,
+
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb, dev_t dev),
+
+	TP_ARGS(folio, wb, dev),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(u64,		bdi_id)
+		__field(u64,		ino)
+		__field(u64,		cgroup_ino)
+		__field(u64,		page_cgroup_ino)
+		__field(unsigned int,	memcg_id)
+		__field(dev_t,		dev)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = folio_mapping(folio)->host;
+
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		__entry->bdi_id		= wb->bdi->id;
+		__entry->ino		= inode->i_ino;
+		__entry->memcg_id	= wb->memcg_css->id;
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
+
+		rcu_read_lock();
+		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
+		rcu_read_unlock();
+	),
+
+	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu dev=%u:%u",
+		__entry->name,
+		__entry->bdi_id,
+		__entry->ino,
+		__entry->memcg_id,
+		__entry->cgroup_ino,
+		__entry->page_cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
+	)
+);
+
+TRACE_EVENT(flush_foreign_bdev,
+
+	TP_PROTO(struct bdi_writeback *wb, dev_t dev),
+
+	TP_ARGS(wb, dev),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(u64,		cgroup_ino)
+		__field(dev_t,		dev)
+	),
+
+	TP_fast_assign(
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
+	),
+
+	TP_printk("bdi %s: cgroup_ino=%llu dev=%u:%u",
+		__entry->name,
+		__entry->cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
+	)
+);
 #endif
 
 DECLARE_EVENT_CLASS(writeback_write_inode_template,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 74677078f9b4..0108b4177833 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3965,7 +3965,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct inode *inode = mapping->host;
 
 	if (memcg_bdev_frn_wq && sb_is_blkdev_sb(inode->i_sb)) {
-		trace_track_foreign_dirty(folio, wb);
+		trace_track_foreign_bdev_dirty(folio, wb, inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, inode->i_rdev);
 		return;
 	}
@@ -4041,6 +4041,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 			 * the timestamp for a later flush.
 			 */
 			frn->at = 0;
+			trace_flush_foreign_bdev(wb, frn->dev);
 			queue_work(memcg_bdev_frn_wq, &frn->work);
 		}
 	}
-- 
2.39.5

