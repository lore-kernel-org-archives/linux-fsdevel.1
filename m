Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844C314B72
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837879; cv=none; b=hOXjWwdgtUir6y3QfxrW4kkClGJW+0fPrY7jqsnnRKFH0lk2MBZANeYnDUjMB1FW53wZkdC5VLlDgV6nhIlUHtJcfRGPgMmdEbmz9EldnXB3efS1nMCiQukwIFNT8m4Mdakhud1E1ZNMryBf/sAaXUokcFZ1KpFmGee9EsQf9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837879; c=relaxed/simple;
	bh=yT+tSgRjiYfs5SQ3x6TOwrKSbFTMyyzh7O4DrLQxvTA=;
	h=Cc:From:Date:References:Content-Type:Subject:Message-Id:
	 In-Reply-To:To:Mime-Version; b=THx7XXqHyJbn4+Rc7m98T4RXDwbaobBaGmqV8bHZKggcg3NN/hgTxCULFTKMrCyVgQxYImfiNbXFB2TGsKrHcORum9GOopel+L/WXLc5fOiHpuUzTUbORRwSOF6HEqI8cSKRq6gS7dZgHQw+UT/FuVwG0jZ/SG6GZKGCgh59qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j/Ah7/gp; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j/Ah7/gp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788837872; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=MQ8UTCfaUbpeU5nW9CBGIYMP3Op7scW9OCp3arXnRiA=;
 b=j/Ah7/gpXkF/LSCivJwhRZlTT062F1Cd2Z0pxP/YKYSFIf1MWgIUyBF4sXSIZBbyVZLZVr
 cU3Yy8ATZj/fXE2n1InCIaUCK74T4LE6t1kVWTB+E+Ou1jVFizw+eyTcZHTJ71tiUAfzi0
 p/lj1dHMfVdfUnKwvi+1wL45VZdlAcVI8HdtYnSWHHi0Z3uO7Iq2BU1fs+zigGeo3ndvES
 IGZl/o1W0FlcVgUJhdDuC5xApxQP39f19leSJc/ik2JpZuWeHKY/ybsZtnnWNWTniUDNq+
 h4t5ki8Ja3ogwDzsZj9xEAfMo4K8NlEoYty4AEcFrs+KE7SaqXwuteQEFANt4A==
Cc: "Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Xin Yin" <yinxin.x@bytedance.com>
From: "Xin Yin" <yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.20.1
Date: Tue,  8 Sep 2026 11:23:51 +0800
X-Lms-Return-Path: <lba+26a9f7fee+10ca6e+vger.kernel.org+yinxin.x@bytedance.com>
References: <cover.1788836830.git.yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v1 1/2] writeback: size foreign flushes by target wb dirty pages
Message-Id: <a889bf70370d17fec0731b60cf393d8cc7cf145d.1788836830.git.yinxin.x@bytedance.com>
In-Reply-To: <cover.1788836830.git.yinxin.x@bytedance.com>
X-Original-From: Xin Yin <yinxin.x@bytedance.com>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

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
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
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
-- 
2.20.1
