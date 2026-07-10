Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EB26A1C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660263; cv=none; b=YwbVEw5KbM3aS8a5y06Q93ftnYvRsp+wjawtL8mDhJwohBjaw/7ryxKR8QJwLRlRrSMm7jlJLuxvPP3Hfx/yMfpU4Vmws+9jNI2R5eXZClUgTyz19VLa/vpQZNXPXveovu6yaXaIIyhX1P2C6MsV7e/JYh7X0pPbfj8osZKX+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660263; c=relaxed/simple;
	bh=WrPPwbJndgfQ2SZN2wfPBYAeYdBoy8Xf76Qd7A4y1AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tkci21dkDWJldoiXadjA8JQwaKF1dhWW82cDZ6XhK3XEhW0SuTxxImJasnewdfKISDDd2vQyjU2RksTM0Aq8RaMfQzWyesHZZKS5cX/SEY5VRa0Va/4TDjzcyYFmYNJEsxzzcHMc45ZpmiHIMrQmK2ernYamRHR1o91oRA880FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtLNUOoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtLNUOoZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x6cYJQREA70XRnYA3vwhMXNMbrevQhRKVoGbok7pL7M=; b=TtLNUOoZ2jSBmq/alTerGzz2OU
	NSY+9NUMDoQLFNH4Mb4+LQKX3QZ/lnr7XR5Ar8iHbFzT6TKS4Xmx4SLxpfFPA1InPD9757sgLR+FN
	/tLrx1TQgkLNKwWOy3tgy1sf3H0rLWrkDHLOQbqwIaeguoqz35vZBgB+l971tj7b4xJ7/DE7e7cga
	GN+bHipMGYMHA+e4ugflDH9DVxpGvuSj1XLaAsc7Yc7RoDjNDayq0gkWnIZmny2mY9HMO1hvI72X6
	9mwQTWP6jZTIfIoykvt9yxPkkiU39zACLijitka3bQRgap67WO85lp0jFqLh43PwSmCNJnVGc+Xzf
	jrSBay8Q==;
Received: from [2001:4bb8:2cc:d72d:4dff:292f:a943:a4b9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3Vq-00000004B4R-2IDe;
	Fri, 10 Jul 2026 05:10:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: willy@infradead.org,
	jack@suse.cz
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: remove wb_writeout_inc
Date: Fri, 10 Jul 2026 07:10:52 +0200
Message-ID: <20260710051052.1839523-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove this entirely unused but exported function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/backing-dev.h |  2 --
 mm/page-writeback.c         | 10 ----------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 5b7d12b40d5e..c2284466e7aa 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -76,8 +76,6 @@ static inline s64 wb_stat_sum(struct bdi_writeback *wb, enum wb_stat_item item)
 	return percpu_counter_sum_positive(&wb->stat[item]);
 }
 
-extern void wb_writeout_inc(struct bdi_writeback *wb);
-
 /*
  * maximal error of a stat counter.
  */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e98748112d1e..47495be68598 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -584,16 +584,6 @@ static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 				       wb->bdi->max_prop_frac, nr);
 }
 
-void wb_writeout_inc(struct bdi_writeback *wb)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__wb_writeout_add(wb, 1);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(wb_writeout_inc);
-
 /*
  * On idle system, we can be called long after we scheduled because we use
  * deferred timers so count with missed periods.
-- 
2.53.0

