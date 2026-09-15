Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5848F84C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461266; cv=none; b=aU+Zm0YsuGIw0XagdbCFoS5qAsH3bY7jjBSo8DAUzu0zlITGA7CcUO0zFFVo1jwH69LDWBV46+P0HXVCC75kcFpKEtpRejP+3CitKM4F/4PtgJiFfXOJvH+s/4q87GgC5RaFqmgDiW3SOGrfV+2GVetWjTlS/4ZaG6ORB0E5/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461266; c=relaxed/simple;
	bh=K1pwdWPABVVogrJVAed4JnUCOEc5sr2rqKIcsFZ8F8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCatrumeZROS7FyQ6WmoFCDgdSCuMRN55mx0OSzD5CggH36Ll/pVGa1dISFk+Ey907RNUwFL4APSl56nF+thBTqmuCKmYGx0Tq2LFmw/mbvy7kETjshhGQIT4oYTiQuF3WwAGkKKtd6ieGNahJe4LpCxAZKgHA83lc7rCws9Gec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zo19yXew; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zo19yXew"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso866801a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789461262; x=1790066062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/yQgHlhdL4OluQwF11kwgzbIv6YOPTPPpwWaUVKRIw=;
        b=Zo19yXewzC+f4k1nugBWTMRR2ey7c4l8sDG0rM0Gxg3lSWEX5lx4AYAfiZ4sOGc6MH
         hIkQ2p6kKScUb7Hbq7dOucFH+7eGKurHZTzk7ofbROjR9a8CPkjI+v9ZrLm+mJyjIA13
         fVHe8DlQbiSyBPnnwv3ZrnP0h3f2CyNNIc+Kjq4H2E5FF8dX7MoNaKXsX4+BX+WtLt0R
         o2xEFFzszghs5u3/HPEwa9hrBbdtrTp1eaDiwC63C9dCei2PbNysRwWPTf9jb/3nrpoD
         KwjB8BUeXklozQTFzEFpT0H4ixFrTzF/IfzE/02CNoSoBEnNSr5qtXevt0yFuPbUcxws
         eMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461262; x=1790066062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/yQgHlhdL4OluQwF11kwgzbIv6YOPTPPpwWaUVKRIw=;
        b=ar8jpFg0QzzkxcSqtLGhdRxZZcFqAs5cid38jcI6jUC2wmnRKdzqqqmOr32CIExcaq
         FO4tv8neIaddc3tRuGaM/aW5naMOO8+ducaazvK2bWohXjPCv2dwfF6JQz774fjt2Z3t
         /1Xl/S6qQcYC5KKT8QETObx9BI32jKBqao1DJjhZB3g9SSI0OUJTH/1JMII8o1JnEBAG
         zA9ErfhXs4VBW7ibpCDgGPU+ZyIxWL5mtRtMrE/Hy5bywANpqoYPbSL7Qk/tL5c6t8oD
         8ieWoXFVMJMNl0kOX46d4ctEMihwnXm7Zz/JhHiwNvuF0C+pot5Ho3Dt7eHIsnWLRkZ1
         SlHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5A2j4kY8y1xL7svGufd6E7msX+oJ0P0Ga9kUCR4YjWzjDlOsIc1bClWNJT8gm1lEfF1QYVkD3J6HYwQny@vger.kernel.org
X-Gm-Message-State: AFuF++khPm/QITc18MvZg+3GZix08Q85hJJlWHX3YsEtMFbhobe10UIS
	10mAYOK/Tyvs98wv7niSYWUUJTgyZzsvIVmldnqVsVfiq3EX4D+u7JrrHPW8kJTdz/c=
X-Gm-Gg: AYBFou09IL5LgjZA6TCuA5Xk9Odqhq0cZF7GmhZyQMkjWvBC7GGwovTCqfePINddQgs
	E/nxN4FlEFXYR4yrpu7cmT6tDeAtvAp0teUe7TGfsxbi+cGHFLZQrAH1I0NpJJerL47Pvk6sjKG
	KGUTwJ9QhRUcX17PWAxwP6NuvglJOlmsRTWPYFmNjuNj8fbLmtiOvZ/OcA0UcKrKVRtEUZrRrsS
	gcTBnH3pdIa1gKbEOnUi9bKrKgEKSwDRBVAPR4cLjDMBK3KkeKjt1cKw43O4AO6RoTJra3n4MXf
	BL4wl6uNq0QMALGRUaQ74le6+iKIc8nkWQdaOPoalNYFebH+kDIS5H6qox/muvcAR1MFp0JGMke
	cAV3QdOytYe2mtrPLRqMEt3U0KLzmiRylq6BdhosBTtMqf0cdQN0PenF0jnebOUZoHkBQLlHVLf
	9pGsxV0DGeJiG39INUOcHVOdnUmDc0JSnN2dgjtjiu5JzxJL46PkSMZuEd1Plru+VV99fEadwYd
	A==
X-Received: by 2002:a17:90b:3842:b0:39e:b0d:d274 with SMTP id 98e67ed59e1d1-39e0b0dd4c1mr680798a91.10.1789461261990;
        Tue, 15 Sep 2026 01:34:21 -0700 (PDT)
Received: from localhost ([106.38.226.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm3920243a91.10.2026.09.15.01.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:34:21 -0700 (PDT)
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
Subject: [PATCH v5 3/3] writeback: record bdev targets in foreign writeback tracepoints
Date: Tue, 15 Sep 2026 16:34:06 +0800
Message-Id: <20260915083406.3471036-4-sunjunchao@bytedance.com>
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

Add dev to track_foreign_dirty and flush_foreign so traces can
distinguish foreign-wb tracking from the bdev-only path. Append the
field to each event and print it as major:minor; zero denotes the
normal foreign-wb path.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/trace/events/writeback.h | 22 ++++++++++++++--------
 mm/memcontrol.c                  |  9 ++++++---
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..ffd1b8df4231 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -273,9 +273,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 TRACE_EVENT(track_foreign_dirty,
 
-	TP_PROTO(struct folio *folio, struct bdi_writeback *wb),
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb, dev_t dev),
 
-	TP_ARGS(folio, wb),
+	TP_ARGS(folio, wb, dev),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
@@ -284,6 +284,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__field(u64,		cgroup_ino)
 		__field(u64,		page_cgroup_ino)
 		__field(unsigned int,	memcg_id)
+		__field(dev_t,		dev)
 	),
 
 	TP_fast_assign(
@@ -295,34 +296,37 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
 
 		rcu_read_lock();
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 		rcu_read_unlock();
 	),
 
-	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu",
+	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu dev=%u:%u",
 		__entry->name,
 		__entry->bdi_id,
 		__entry->ino,
 		__entry->memcg_id,
 		__entry->cgroup_ino,
-		__entry->page_cgroup_ino
+		__entry->page_cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
 	)
 );
 
 TRACE_EVENT(flush_foreign,
 
 	TP_PROTO(struct bdi_writeback *wb, unsigned int frn_bdi_id,
-		 unsigned int frn_memcg_id),
+		 unsigned int frn_memcg_id, dev_t dev),
 
-	TP_ARGS(wb, frn_bdi_id, frn_memcg_id),
+	TP_ARGS(wb, frn_bdi_id, frn_memcg_id, dev),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
 		__field(u64,		cgroup_ino)
 		__field(unsigned int,	frn_bdi_id)
 		__field(unsigned int,	frn_memcg_id)
+		__field(dev_t,		dev)
 	),
 
 	TP_fast_assign(
@@ -330,13 +334,15 @@ TRACE_EVENT(flush_foreign,
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 		__entry->frn_bdi_id	= frn_bdi_id;
 		__entry->frn_memcg_id	= frn_memcg_id;
+		__entry->dev		= dev;
 	),
 
-	TP_printk("bdi %s: cgroup_ino=%llu frn_bdi_id=%u frn_memcg_id=%u",
+	TP_printk("bdi %s: cgroup_ino=%llu frn_bdi_id=%u frn_memcg_id=%u dev=%u:%u",
 		__entry->name,
 		__entry->cgroup_ino,
 		__entry->frn_bdi_id,
-		__entry->frn_memcg_id
+		__entry->frn_memcg_id,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
 	)
 );
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61ebe4ab744f..74bc94826392 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3938,14 +3938,15 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct address_space *mapping = folio_mapping(folio);
 	struct inode *bdev_inode = mapping ? mapping->host : NULL;
 
-	trace_track_foreign_dirty(folio, wb);
-
 	if (memcg_bdev_frn_wq && bdev_inode &&
 	    sb_is_blkdev_sb(bdev_inode->i_sb)) {
+		trace_track_foreign_dirty(folio, wb, bdev_inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, bdev_inode->i_rdev);
 		return;
 	}
 
+	trace_track_foreign_dirty(folio, wb, 0);
+
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4020,6 +4021,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		spin_lock_irqsave(&memcg->frn_lock, flags);
 		if (!ctx->inflight && ctx->dev) {
 			ctx->inflight = true;
+			trace_flush_foreign(wb, 0, 0, ctx->dev);
 			queue_work(memcg_bdev_frn_wq, &ctx->work);
 		}
 		spin_unlock_irqrestore(&memcg->frn_lock, flags);
@@ -4037,7 +4039,8 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		if (time_after64(frn->at, now - intv) &&
 		    atomic_read(&frn->done.cnt) == 1) {
 			frn->at = 0;
-			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
+			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id,
+					    0);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
 					       &frn->done);
-- 
2.39.5

