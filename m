Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1B3EEAD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233081; cv=none; b=YYk+AwfUYPCD//Klu/yqVfbDV/nsiCJs7YWIvuCo6PVjdms7RXw726737Wh2Pr+oeIcV7vviNZuFuzfkvgvpSG+rzR8mG/8+q3Z/PP5dUMoideY5L6MftTof8l60VKMh6o8m65uEgCaNKnYrQw7Veldj81UjV6G0ncaGSOHKKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233081; c=relaxed/simple;
	bh=cEws77B34mezF7Fbb4Epf+Lm/6OxLGSzhrgitn+yT3k=;
	h=Message-Id:To:Subject:Date:From:Cc:Mime-Version:Content-Type; b=hmtQ0GGNWBkgDLd8p2viIv1FeBsEua545wTmSYfM9W1u9pNNeAvoFtkCxqNx3q/HelPLGQuR2o1XL9nlFvONu79CcMSrMnMQTBtAddeMWKRTKgEoF5c/oim9rgBS7bDcHOEwZz/vLBqVPhGbctwa/ZaecNFAVTXsVXpNccDDxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h3rJoYHu; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h3rJoYHu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1790233060; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5l2X4JLLDk5x9GpXbqtkHY3m3lqdL9hdPzSkDQBIzXs=;
 b=h3rJoYHuqOmFSMvAKQ9jHvAW2OrRuFn1W5R6QGKAnF+su8hyO8PPqQ+uVTPzJrYGrcEqpE
 zzIMjRFJ8tIZTSRZnFZfv4vVC+1E43f7NqZ+hLULYT+myGHg3jBdTk1Wi+HdXUsJzTi0n5
 hGgpGmHcsQL7fPCdXOdD+XAxUU7YmuELrnpj22VckAkkcfX4ltCvGqlbgJHQGarQv4WU8X
 38MqhxX2dgNgn4T0S+Xxe+Df+DQGyqaJmeYyD9JRvKojCCGye9bBdRiPulAqIdQIEY9NAw
 P9TDgAm8v4agC8qOMxkPU3w3VJTtE2eY+JUXD0pFKj/ZB4t9OgWHWCh3PyvyBg==
Message-Id: <20260924065443.1650126-1-yinxin.x@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26ab4c9e2+1aacf6+vger.kernel.org+yinxin.x@bytedance.com>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: [PATCH v2] writeback: size foreign flushes by target wb dirty pages
Date: Thu, 24 Sep 2026 14:54:43 +0800
X-Mailer: git-send-email 2.20.1
From: "Xin Yin" <yinxin.x@bytedance.com>
X-Original-From: Xin Yin <yinxin.x@bytedance.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Foreign dirty tracking records the bdi and wb memcg IDs of recently
dirtied foreign inodes. When the source memcg needs foreign writeback,
mem_cgroup_flush_foreign() queues WB_REASON_FOREIGN_FLUSH to the
recorded target bdi_writeback.

cgroup_writeback_by_id() currently sizes this best-effort work from the
target memcg's NR_FILE_DIRTY counter. The work is scoped to one target
wb, so a memcg-wide dirty count can over-size a single-bdi flush when
the target memcg has dirty pages on other devices. It can also under-size
the flush when the target wb has dirty pages charged to other memcgs.

Over-sizing keeps the target wb busy longer and can delay later
writeback work. Under-sizing can finish before enough pages are written
back for the source memcg.

Use the target wb's WB_RECLAIMABLE counter and keep the existing 25%
headroom. This keeps the budget aligned with the writeback object being
queued.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
Changes in v2:
- Submit the budget fix on its own. Drop the snapshot writeback patch
  for now, pending further evidence of its benefit in production.
- Add Jan's Reviewed-by and Tejun's Acked-by.
- No code changes from v1 patch 1.

v1: https://lore.kernel.org/linux-fsdevel/cover.1788836830.git.yinxin.x@bytedance.com/

 fs/fs-writeback.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c75ed7e8979..7c2340a5dead 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1131,7 +1131,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	struct cgroup_subsys_state *memcg_css;
 	struct bdi_writeback *wb;
 	struct wb_writeback_work *work;
-	unsigned long dirty;
+	long dirty;
 	int ret;
 
 	/* lookup bdi and memcg */
@@ -1160,16 +1160,13 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	}
 
 	/*
-	 * The caller is attempting to write out most of
-	 * the currently dirty pages.  Let's take the current dirty page
-	 * count and inflate it by 25% which should be large enough to
-	 * flush out most dirty pages while avoiding getting livelocked by
-	 * concurrent dirtiers.
-	 *
-	 * BTW the memcg stats are flushed periodically and this is best-effort
-	 * estimation, so some potential error is ok.
+	 * The caller is attempting to write out most of the target wb's
+	 * currently dirty pages.  Size the work from the wb's reclaimable pages
+	 * and inflate the count by 25%, which should be large enough to flush
+	 * out most dirty pages while avoiding getting livelocked by concurrent
+	 * dirtiers.
 	 */
-	dirty = memcg_page_state(mem_cgroup_from_css(memcg_css), NR_FILE_DIRTY);
+	dirty = wb_stat_sum(wb, WB_RECLAIMABLE);
 	dirty = dirty * 10 / 8;
 
 	/* issue the writeback work */

base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
-- 
2.20.1
