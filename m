Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF548C3E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585312; cv=none; b=fZ+oxvUSLmtWsl7YNLy6+gl2XNpT55NYO65UvCL7ZdS8Cb6f6siOpSsz6ZP59Ed5Mn4hUGBpjweZ6r42mq0ucnwhNCWJF7AWfle2OpZnAjPQ7q/zMi5YAFKPQ8QLLehXK8ffWK9ObK9ObmLMIF2Q4wmiJkv0lyO+9/wNzi50Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585312; c=relaxed/simple;
	bh=Ey2hy8K/mrzadOeyZYpxv3qyfibND4LeYr26gtOxh+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDK36ZyBCOoHEIGQSkVSLyVkBxUYUyvt/JJ3P3HsXcyUW59XaSBKGZZT1Q2ItWIR+GfbShRyuU+7K3epKmNn21bADhI5niDw2+5Plchr9EaUhTXb3rQqzwsGmZoeCilpIkXCxmE5z5dg5nFVe7QFKxSiNWc8rBzHIXDAs5trflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgB8Ja6d; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgB8Ja6d"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so9216405e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585308; x=1791190108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qfms4UXVhjSqsa81KPLQziFui0MDs7rXtnItEtK8nrE=;
        b=dgB8Ja6dZcDGE3OTgonQFIaLWVP69Eh7kQOrmG7zGLPE5PnzTO/Tyq2v0pkDvr0O6P
         vZWeoNTViydt7ay2KU/09STOA/3GcRbaDBi+qCPB4dEvgL+Gp8z/0ytgt50QONo5/to/
         Ze3rhKc004Fmc9okb/W4IMp3ANbZvjOpjFbX6qLlHMem/Gtk4qP9J2Q1YocAjzwgm484
         5YbpVEP8WRx6Zu4wC/uK3nKRG0MblDi+cGRxDJ4+uGPsW+9suGnX+c8RKR7y73G4GLP1
         YXrVMJgqp4Le+5aFe08ttcIyt7OpXSDMjjifJBa12ic84MAt8FymOx1sLFKW0n+dVkK+
         hQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585308; x=1791190108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qfms4UXVhjSqsa81KPLQziFui0MDs7rXtnItEtK8nrE=;
        b=U72cJf6dVT+7VHrMSkRttDrMtqj7hN+2XQ1MO1gLhAfuHlco164xW3/oAPbWu5qON1
         oUghXQ7ero5NvbVVClPoYFnV0Ua+ADuNA1+eyZLOrHPiPSxzhtM6UWP4hk6vt71UWWCV
         Z6/xqViCScFwr6X17pb+/wdH1AGtUyHwKeZ+9cK5w6LIgBAURK7LUDcfrlX1KX7h3eFR
         Q0hra78SjWJYmFqcLMBtU4cx5xq2VlZf1eLy0NDlOeK3p5rc/eDD0iBJ4edEjSIk67QY
         HidXbzuecbhIxem2UsfY+UuiIpj7og8bIeTJuwlSOND/K3HxDsgM6DXy8UDMMJQE/bmD
         8wtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH/hQ3gjLRzOLcef4WKrirdTatwRIoNwekbDP2d5pnOtmPFA0jzVKi7yZEks1S0VN+Bgqygtba3S2m62F6@vger.kernel.org
X-Gm-Message-State: AFuF++lj9gaIG7f7emcyTJKsfI+x/8o7oQ74BZwJq4WlYflEwVcVz68B
	D9yUp6RA+bYqzjpkVNwi0QHX3WGFyTAupPahv+eBKNFM5uv4Esjbtxst
X-Gm-Gg: AYBFou2tnvYWE0gxMx+1YL6oE0fDqcxxp1Kqdmkj6NpmuW1fQOROBxoZMrLamIlZIs3
	IdjnxC8cZIFD4b3Yxl+1GZXN7TjK2h8tpcNvIrjpH3vEw96Xs5xZc1eLmNwPn29iVhOAwiMmoEH
	fpaF0FcKamkon+ooJDJWH9UtoAV/5eacQsDB8U7ZbON4gcAPjhLknzbOy0KxarPX6CcyTDhUHYc
	s2nsQB7yIcdDg4g7U5UHz58Nr3+JmrrtE4iS6jMXk4asGKgLqW44mBaIzODCtEVk9FfV954lvrq
	bQuYw5waqDgo/SccfIx01DBWaCDCi2yHBg0JXbGxNchrpz+ZDJgRSz+eBlMEPrz3UzKjSBxnm0B
	3epVKOWadCX9x1ph9McSAp3sWMam1HwxmsoKz0lUn9I/CqJ4QOa37t5WWHAmRpd/avhN4tjzWBX
	Mb7g774A+npJZqQJz2l9vo9gXkyUsNIfwpnd8nMKty0w5GfTeNPps6vT5ai72Jm/bALkfBw9gUw
	m+vA2Ymji6cCXP3VVOmppk4JtjREa7MqhtrGyRoWAZo0IKDQFPiAGkNODqOVh1LPGCekEZlRBQ5
	O0YG
X-Received: by 2002:a05:600c:8b28:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-49ffbad2d56mr92693445e9.17.1790585307816;
        Mon, 28 Sep 2026 01:48:27 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm182584705e9.5.2026.09.28.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:48:27 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/4] xfs: add an error tag to inject a ->writeback_submit() failure
Date: Mon, 28 Sep 2026 10:48:07 +0200
Message-ID: <6c05aee81af9264ce6c19a436bc3503ecdab1e45.1790342457.git.parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790342457.git.parri.andrea@gmail.com>
References: <cover.1790342457.git.parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only in-tree way for xfs_writeback_submit() to fail is a failing
xfs_reflink_convert_cow(), which requires a shared (reflinked) CoW
extent.  There was previously no way to exercise that failure path
from userspace, which made it hard to write an xfstest for it, e.g.
for "iomap: don't resubmit an ioend after ->writeback_submit()
failed".

Add XFS_ERRTAG_WB_COW_CONVERT_ERROR to force xfs_reflink_convert_cow()
to fail with -EIO, so that ->writeback_submit() failure and its
callers' error handling can be exercised with error injection alone,
without needing a corrupted or racy COW fork.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/xfs/libxfs/xfs_errortag.h | 6 ++++--
 fs/xfs/xfs_reflink.c         | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 6de207fed2d89..a1955b7773e1f 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -75,7 +75,8 @@
 #define XFS_ERRTAG_METAFILE_RESV_CRITICAL		45
 #define XFS_ERRTAG_FORCE_ZERO_RANGE			46
 #define XFS_ERRTAG_ZONE_RESET				47
-#define XFS_ERRTAG_MAX					48
+#define XFS_ERRTAG_WB_COW_CONVERT_ERROR			48
+#define XFS_ERRTAG_MAX					49
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -137,7 +138,8 @@ XFS_ERRTAG(WRITE_DELAY_MS,	write_delay_ms,		3000) \
 XFS_ERRTAG(EXCHMAPS_FINISH_ONE,	exchmaps_finish_one,	1) \
 XFS_ERRTAG(METAFILE_RESV_CRITICAL, metafile_resv_crit,	4) \
 XFS_ERRTAG(FORCE_ZERO_RANGE,	force_zero_range,	4) \
-XFS_ERRTAG(ZONE_RESET,		zone_reset,		1)
+XFS_ERRTAG(ZONE_RESET,		zone_reset,		1) \
+XFS_ERRTAG(WB_COW_CONVERT_ERROR, wb_cow_convert_error,	1)
 #endif /* XFS_ERRTAG */
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 4801361366359..104542b10d9e0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -34,6 +34,8 @@
 #include "xfs_rtalloc.h"
 #include "xfs_rtgroup.h"
 #include "xfs_metafile.h"
+#include "xfs_errortag.h"
+#include "xfs_error.h"
 
 /*
  * Copy on Write of Shared Blocks
@@ -346,6 +348,9 @@ xfs_reflink_convert_cow(
 
 	ASSERT(count != 0);
 
+	if (XFS_TEST_ERROR(mp, XFS_ERRTAG_WB_COW_CONVERT_ERROR))
+		return -EIO;
+
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-- 
2.53.0

