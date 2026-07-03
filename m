Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EC29D265
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048533; cv=none; b=svkk9G2G14fi6vj/MXBJS0nTsiFV8goQmbUL0vp2EBOxGoHWCIzpIGgp0ojsc8Dp+pZiEHzZtsW1a8Rb4KBxxLGBuIFPeNYmc+Ml5lzllUZo0FATc7sYm9Z6hQz2vWifDrzwAZDcgcJhvBj7ZZvD6/5Iugdct2PRflRyrv/ZAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048533; c=relaxed/simple;
	bh=w7pHXPxe9GWZYt4ua8IS7f/4OyXOtIG9kiHA52yse6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDlJarYFRXWdSuvpnPJ3oxJAW+0PBDc93D8U0CAKqdrgrf8sdDfMajaKqL+59e5Xo7NKwbmcoEUYsyvPcD9yho+a9fEb/lxT7avh7HSpDcRXcg/jGzu1plftdD2Mg41cZThNIeEkVm28OEmaWoMy6PHfeMyyyRMZBSsqiTvOX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xy76dg7Y; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xy76dg7Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783048519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/i5UabH/z5TDJpi5vIu5zBGX7hYzPOStSLEinAkorgU=;
	b=Xy76dg7Yd6fw6OcBvIGF1PcXa1sRCC9zSpaK4TqkLvZe+F3xx/EAltE/PKoehMHCVmkigJ
	sdYtKfeHVSjM9DtnCOVoyb3XdqfIn0zpxgJzkx3jLBmrJ5JfkfrLCS5gw9ycvt3ooovls8
	VIdOxxloNUhfLrXNTdOzbAyriDVJiyA=
From: xuanqiang.luo@linux.dev
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Joanne Koong <repnop@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH] fanotify: initialize permission event watchdog state
Date: Fri,  3 Jul 2026 11:13:45 +0800
Message-ID: <20260703031345.9354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

fanotify permission events are allocated with kmem_cache_alloc(), but
fanotify_alloc_perm_event() does not initialize watchdog_cnt.

The watchdog reads watchdog_cnt after the event is moved to access_list.
A stale value can make it warn too early or skip the warning.

Initialize watchdog_cnt when allocating a permission event.

Fixes: b8cf8fda522d ("fanotify: add watchdog for permission events")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 fs/notify/fanotify/fanotify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a3555bebad63e..b59f0aa43c4be 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -599,6 +599,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 	pevent->hdr.pad = 0;
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
+	pevent->watchdog_cnt = 0;
 	pevent->path = *path;
 	/* NULL ppos means no range info */
 	pevent->ppos = range ? &range->pos : NULL;
-- 
2.43.0

