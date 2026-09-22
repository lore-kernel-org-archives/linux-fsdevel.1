Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7F54857B
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081435; cv=none; b=puLTqdMMLVc+EhH0aTej3ylLZSuG0Ci2sA+5yw0VWhMXhOzRBSHsd8zaWAnYUL7qQZcnHnj8XAnn3ugY9WZo3A6pCKJOxvA139YdOswYORCa2PoWgmbr/tNfRuaibN+tfflDzMg7XvAkLmDklt7NNdDN9InWU6Op+nj3BUzYvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081435; c=relaxed/simple;
	bh=SI3Qwx8gHmHgetJUzIPJ++C7VjKAFpkXf6OzpxqmoBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWW2eJXfQoz+QYWQMsiaEpMmgBLRmA1zb8hYMbXLWMjEAklqj5CQj0QHCpcPnjzuCnLDD6d/ac/6iH1mkXaI6pBkDvq0bb9oannQVCNSjESX0Ox7fDcIihq3G/MRlSuDUwB2U/RVbUj2uqUdHObBU7PvCTW1A/+a1GK6N08Ij1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ejbEwdyo; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ejbEwdyo"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c6so3544987b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790081433; x=1790686233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juILZvA/W9TMtNBQ/eIZx9CWcsdMz7oCJkpEETYimaY=;
        b=ejbEwdyo+VsleXu/AfJGzQEXA/CdrFE3XdBo6tcdMRFrA4KnkJFujtW+hfiCBzxBh4
         1o3QJjCT/t0um9nPXHuK4zAmIgzZWd9SGHIKQv0jTxYX6QLz6y5L6PAALneOu7vKE+lE
         GH5YtLhLlfEsVDpaacz/zgPGjBlRDSnYSrlkMfq4Z6fdoJJgYzsroGsyaPrdF6B2uG1r
         M3JdASrHWPrsgvQ/xa8w+V51AdtvW4CMNDgpvu6snMlR/Q4acPX+yXfLYnsJ1jMwiNRG
         XTjL32wP2gPsdRzGkxUbkwNI3GoVDIAToIYrudAVpU5wJPmMBrcpCSJ9i6ljzxJuAnan
         SUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081433; x=1790686233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=juILZvA/W9TMtNBQ/eIZx9CWcsdMz7oCJkpEETYimaY=;
        b=T2Oa96+F2jjxynuTrCpraM8qJWTZTeW6TzxHmXSiHgOCu7vf8dlm58rwMsOoVaMnlR
         Nx/+3j92mFHjr69hd56QKoPyl7kGGh2gRWtakPv/Z8sWP3+VdZDEoqSoZ04IpyYiOvr0
         iIWJYBENseMgiiQb8pTXZV/88GmyjTMTdm8Y87AAUG0doNYK+VdOmvBxmDJS9p5g6/6m
         NiTBdnpurxMHbSgUyqfwca4CY33oGFDDlApSSX6ounU/cDfxPvBM0yezZd2Vsw2HPwLy
         L0Cs9prsTZM8BV/gJaQwiril6JoD6jORFmZWD5gOTd7ww3MSDcDWcZONEV5tnsfqmrBQ
         B/9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwHdDQed+4ZHvLlSX/TVjuhMFmqaPWFQeorAry5RShoyGwIOnJ45lN5s1u2M2NNm8mSpBRwaeHQq5YFNtcK@vger.kernel.org
X-Gm-Message-State: AFuF++lCH4Id9sUkfs3+ScXzTrErsJSOIkTV7KvrH5gBVQSsgtEHP1n5
	fNk+uw6++bk43PIpVjNsbxXbx5RuBh0xeF5KgO1jGXg/sJG1IOuraN0Ti1ojrBMYqso=
X-Gm-Gg: AYBFou1ahKS9uZ6MH4ZoSwD2BoCMUOgBAZAfm0Ca7UmTDscgO2XRK1T8N8wCk5QCjKx
	HqiVNMeLzXEC/GuY3Hjjw7EO1ldxItI3SBKa/XDmObkGTYKmF6D3WqI8ug808hN48D355KjB1CP
	cd8JZ3AvPE13nDVbagAMa8yRgi9jmDxdidcRWoFoCOUefpeS6i6GMB1nW1svJMt+ESHvx5EnyD3
	dKU3di6LTaHiu1lrp9kqChWPSRIUNsAksy0jwzQkJi9CMta3h8v0GwWREawtwUGJnNQ2M7sv9nA
	tXBb+XMx/sr+rtGnaUZst1kpkeZVX5OT2XVkCUCWR1fO2Xt5mVbFsRPzgsFVlfwDyK79+e6VywB
	6G7Kv8v7AeSeCUtgd9ORiAsm/VFjMsCxALpESAFjwL1rKJWOf/BEA9dPmaJV+gKAlf7SqNyx6JA
	W2EvcwVjBSaZ8+pYhQ+ZGNfSY6ls7n/gFtt3tYPXx8EVL5U0+Sssf3ZY8s4tHthywGnK7jHABka
	gI=
X-Received: by 2002:a05:6a00:3c95:b0:879:531d:199 with SMTP id d2e1a72fcca58-87c84043665mr1114410b3a.39.1790081433323;
        Tue, 22 Sep 2026 05:50:33 -0700 (PDT)
Received: from localhost ([106.38.226.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c331b0629sm774868b3a.51.2026.09.22.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:50:33 -0700 (PDT)
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
Subject: [PATCH v8 3/3] writeback: record bdev targets in foreign writeback tracepoints
Date: Tue, 22 Sep 2026 20:50:15 +0800
Message-Id: <20260922125015.3435215-4-sunjunchao@bytedance.com>
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

Add dev to track_foreign_dirty and flush_foreign so traces can
distinguish foreign-wb tracking from the bdev-only path. Append the
field to each event and print it as major:minor; zero denotes the
normal foreign-wb path.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/trace/events/writeback.h | 22 ++++++++++++++--------
 mm/memcontrol.c                  |  8 +++++---
 2 files changed, 19 insertions(+), 11 deletions(-)

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
index 6042c694d56c..534b0d537a09 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3956,12 +3956,12 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct inode *inode = mapping->host;
 
 	if (memcg_bdev_frn_wq && sb_is_blkdev_sb(inode->i_sb)) {
-		trace_track_foreign_dirty(folio, wb);
+		trace_track_foreign_dirty(folio, wb, inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, inode->i_rdev);
 		return;
 	}
 
-	trace_track_foreign_dirty(folio, wb);
+	trace_track_foreign_dirty(folio, wb, 0);
 
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
@@ -4032,6 +4032,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 			 * the timestamp for a later flush.
 			 */
 			frn->at = 0;
+			trace_flush_foreign(wb, 0, 0, frn->dev);
 			queue_work(memcg_bdev_frn_wq, &frn->work);
 		}
 	}
@@ -4048,7 +4049,8 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
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

