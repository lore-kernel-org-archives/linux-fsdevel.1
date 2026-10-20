Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533832;
	b=4IeILvHAjicqwITHHrztTGKQip53HWxEEhRtQD4vTN+i+PxkH7dOrFHxIQuTrZ5M8w4A
	 rWgCbWWKYml/PlykfbhN3mjU6jIWo+fTM64gY6szu/L+8/ulr6vv4VeL1Eg4wArnTzOI/
	 zrHpS1h6+3gM7DtzE2Y3VpzG/Gzq1GSQRSb6KUUzP1q7iEmUozq9Ouoyvk5t0C1UfBNuO
	 kMXRZyJNpae6bcaqUKunUaYoqmr7NBUWJZavdNLwj8hl6dMqUp0ymK5isBSsRCaqRo549
	 AIsBm8k+0wFv3WHyk5nT/LdIP8+QxbuTNZeajrwXxazwk3KvQRtu98fsJdLAXhXLuTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KYIFZnbJ/tQXvMmHyoqaiwEU9dnEoX51wTobPwpbUYk=;
	b=mUrYwmIRxGrxrrEDuN4IzJCEpqhKNRI10ZNMxg6LFF42C4zUcz80Nt7RKUaLw+0ah3rg
	 qdOZkxKNhKZ8kntFzjnl8Vf87PB9DJDG0fVFPIsjPo7gTjTuMD6FxWW76RRdwHL56XWIz
	 2QoTXtqQL00HWQp2q3wJ2o+2gD4J7K5xvyQWIesEGmiUW1jh+ACqOwy/Uu7+XT2waVlaq
	 uk0Pr+7Zgx8FVLa9+kvMNj5CmGnsdMzMm1Cn8rSfU+E8HPuY76xlOz8avxPadPliBqigb
	 1IHSKmtqGJ8HpmL4kXEYgPrGcwWfkQ229siosBlkVxYMPkeODApofRDuTRcMbepN4tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=gUJJWDUq;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF583606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF583606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=gUJJWDUq
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91befe703c4so1045156d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792533831; x=1793138631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYIFZnbJ/tQXvMmHyoqaiwEU9dnEoX51wTobPwpbUYk=;
        b=gUJJWDUqHGCWDoDo9er//1amH0yAKiu5TjEcW7IY8NYPKPPXAMPVb1+rcWaWvNksQV
         DXI8o89JWj01QK323ShIUu0JyAIHjbipYHn+iWA+d/00MdpZaJKzJ2JyFHTXA9BH6TXd
         6s2gfG1dbcNqprsD3XLZ7CmuoxhSo7Y02thj+RcdytV+FC/6dvULJ8BVLWLmpvRFJslk
         +kKTi0EvnHeRMs/7dKiMD/4acKL7Nh9vdy+KsYfNvDD/fl5v2mmP6jZ103MSnojC3RUt
         S0dmyN5cp9Hqqx5hlddNkAFuYp8Culf8ri/7urKZID9yDwWiMQpSHqrh5i5LUu2SF/vD
         vhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533831; x=1793138631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYIFZnbJ/tQXvMmHyoqaiwEU9dnEoX51wTobPwpbUYk=;
        b=a2h7HNTl28gXbFk5mjA8XuRED1rshsaL8WoG0GYK4T6v8OyoRl3KQNXTbrXLJrC94o
         /gH1JAXiITqbBNtHZB8ZWjpGEWFCUQJePWtPV+JHbs+nPTfwry0dUE5AeiDFSh5PO6fD
         oKhPxkWZDpGbOmCiILtLenuuPhW53cIG93b6l99w+nEty0+f1JuChg5rhcMt9xJCWYmx
         lnF1hbnvmUDeWKO/bLQRF77q49kKgV+hGy3/0BCnoPWIkI78x/mBQjXiO2HBEoSHojJe
         a/fn6bMwr6cII7ID1R/zFZl0aFZZvr3aHKZ9f9b3is6guS/D8SXc3Yj0M+GaOfueLXDj
         9FUA==
X-Forwarded-Encrypted: i=1; AKwUvBzSy1wW6QvhQkHMiDq0pEFGDPRqMnM9A8GBZibVlApDZjCJpkI53Nlq5X9q7hbJBuk0XjBByHJk1ZE+8Ji6@vger.kernel.org
X-Gm-Message-State: AFq9FYJSdkP38ARb5JdqX9ifli7eRuzudlw+W7OYtHuWHQHeh25B5nEo
	zkc2OBNfJ9aHsuBS19m67Fkgk0BbY0MxlUJlrfy4DNBK7mqIpLeym0RRHfcEzO8hSL4=
X-Gm-Gg: AYBFou3hHAVKqf1jlg+soWAvPIzzIjOh396do1ajqpnw6fwelYsqSnNPizhj+igK7FF
	hlXyLlWOB3KLbxvXI0Mz5Ilgl5bGYAxoWGHAy6gXWW5C4UGRatJIXVSCcjjF65zvFnifqTi9D/Y
	YLuzbBEalqkmjBbSLA6Ifz2PvtH+FYeB4GtuRLMkGmXX6HpmXtLyNy6ib6pfrrxHyH/TfI46iXj
	TNem7f8rJGq0ytdaB6JAdG/3+ueaaOgfSHxUL0uwhmHg30UkQFIpI+/UpONaOquYBc8yVvf7s2h
	qsuGvkLdCkUZNCHpuIYw28nTNe2XRZzuWlttW0i/+CWPIX++gITnRyiQUtpw1ib3lH5XtLxTdHr
	9/eDAuCd1AfE3rRNywY3copCamDbWiSMCtIYl6/ardZ8hkVhGmCYRkjOoHhBYxUFnIYMTji1ln0
	rEkKcDZI8zBLJOizQ9oj2a3vcYdj6eTng8eV58aEIXe/G5YLc8NQNLaZ67I2+T4khEKFy5YYa1x
	2o3FBu74MFEIuwit/Bq4cfhPJgFYF8MPNtx3ROP58oETnAlCXKKOGcHOWgVoyZ+W2UFt2Dt7qUm
	uHtdvuf39A==
X-Received: by 2002:a05:6214:8623:b0:91c:1061:f005 with SMTP id 6a1803df08f44-91c12eddb7emr2552846d6.20.1792533830405;
        Tue, 20 Oct 2026 15:03:50 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c116fa63bsm6647676d6.36.2026.10.20.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:03:49 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 1/5] mm: expose WB_DONTCACHE_DIRTY in bdi debugfs stats
Date: Tue, 20 Oct 2026 18:03:42 -0400
Message-ID: <20261020220346.28020-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20261020220346.28020-1-snitzer@kernel.org>
References: <20261020220346.28020-1-snitzer@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-bdi_writeback WB_DONTCACHE_DIRTY counter drives how much the
flusher writes back in response to an IOCB_DONTCACHE kick, but it is
not reported anywhere, so the DONTCACHE dirty backlog can only be
inferred from MemFree/Cached movement.

Report it as BdiDontcacheDirty in /sys/kernel/debug/bdi/<dev>/stats
and as WbDontcacheDirty in the per-wb stats, next to the
Reclaimable line.  Use wb_stat_sum() rather than wb_stat() to fold in
the per-cpu batches: the flusher targets the summed value and small
backlogs would otherwise read as zero.

Fixes: 88d6f128d06d ("mm: track DONTCACHE dirty pages per bdi_writeback")
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-mm@kvack.org
Assisted-by: LLM
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 mm/backing-dev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 18e999053bae..b8a2c27e07fa 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -46,6 +46,7 @@ struct wb_stats {
 	unsigned long nr_dirty_time;
 	unsigned long nr_writeback;
 	unsigned long nr_reclaimable;
+	unsigned long nr_dontcache_dirty;
 	unsigned long nr_dirtied;
 	unsigned long nr_written;
 	unsigned long dirty_thresh;
@@ -78,6 +79,12 @@ static void collect_wb_stats(struct wb_stats *stats,
 
 	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
 	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
+	/*
+	 * Sum the per-cpu batches: the dontcache flusher targets this
+	 * counter via wb_stat_sum() and small backlogs would otherwise
+	 * read as zero here.
+	 */
+	stats->nr_dontcache_dirty += wb_stat_sum(wb, WB_DONTCACHE_DIRTY);
 	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
 	stats->nr_written += wb_stat(wb, WB_WRITTEN);
 	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
@@ -125,6 +132,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m,
 		   "BdiWriteback:       %10lu kB\n"
 		   "BdiReclaimable:     %10lu kB\n"
+		   "BdiDontcacheDirty:  %10lu kB\n"
 		   "BdiDirtyThresh:     %10lu kB\n"
 		   "DirtyThresh:        %10lu kB\n"
 		   "BackgroundThresh:   %10lu kB\n"
@@ -139,6 +147,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   "state:              %10lx\n",
 		   K(stats.nr_writeback),
 		   K(stats.nr_reclaimable),
+		   K(stats.nr_dontcache_dirty),
 		   K(stats.wb_thresh),
 		   K(dirty_thresh),
 		   K(background_thresh),
@@ -163,6 +172,7 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 		   "WbCgIno:           %10lu\n"
 		   "WbWriteback:       %10lu kB\n"
 		   "WbReclaimable:     %10lu kB\n"
+		   "WbDontcacheDirty:  %10lu kB\n"
 		   "WbDirtyThresh:     %10lu kB\n"
 		   "WbDirtied:         %10lu kB\n"
 		   "WbWritten:         %10lu kB\n"
@@ -179,6 +189,7 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 #endif
 		   K(stats->nr_writeback),
 		   K(stats->nr_reclaimable),
+		   K(stats->nr_dontcache_dirty),
 		   K(stats->wb_thresh),
 		   K(stats->nr_dirtied),
 		   K(stats->nr_written),
-- 
2.52.0

