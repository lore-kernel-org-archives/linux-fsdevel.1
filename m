Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2303E95B2
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409680; cv=none; b=CwOu2YvCxr7p6VF4fEyzQLlNq9lDR5PP8ioYPdWSb9beXb9SKYqykh9tHJXoHYcSkM8eQ0H0iGqovcjvFyAjtuQzS6OfJxK6aQtG6aukC3xGG7VIMSFxd9v2pzE3U8W1zr9lp4X3Z/hKHmesdV9kLEGlI22eGq7iDyEIFvqCCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409680; c=relaxed/simple;
	bh=oYXvB8teeg8oXc/k9KnDRAOlku/K25xxHKzwmHoBuOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KbSjkq9PE33SuHpmdWOTqpW0pflOB75jLncj+z5Cly1ReJclgbXpm7VpeFY4e+d+LmzuAlgx8axEFFVsgvpJ+QMW5a9OOSWOWpS9PvTc2BnnHis1jSmfkTUU9+1PtOytv0Kgv0LyxAgrYefZqLkU8mYOaiwfjmn6Xz7FV28VxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iakm7INH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iakm7INH"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260602141435euoutp010a3351c74548406b4dd3b686bd793094~1SSq0vDYh1519415194euoutp01M
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:14:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260602141435euoutp010a3351c74548406b4dd3b686bd793094~1SSq0vDYh1519415194euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780409675;
	bh=cEJXaKoHVG052rosoP3EzDpk3GM9twb5LiOcKSOoRtE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iakm7INHutpfW8w8828S7xDUt8CaWU0diTcb6LHgFdLZOWz1ekmXbWFH+PCJjOjxi
	 lvXaa0LxWx3X/puNbrEtqIj6wY7kVmOargsD60ZNs7wcmauc0jkoiTIxnrXYd6D0dY
	 eDdAmqgtolHWPpLOqLSGOux+Z9ygidEn+VSWE1Yk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260602141434eucas1p15746f013244db658407ada4f3cea7b89~1SSqPEBA62689226892eucas1p1M;
	Tue,  2 Jun 2026 14:14:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260602141434eusmtip1f0c1b2b32c5aa519e2bc971a891e402d~1SSp-rIF50373503735eusmtip1u;
	Tue,  2 Jun 2026 14:14:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-fsdevel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Namjae Jeon
	<linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH] ntfs: fix missing alloc_workqueue() flag
Date: Tue,  2 Jun 2026 16:14:27 +0200
Message-Id: <20260602141427.2301354-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260602141434eucas1p15746f013244db658407ada4f3cea7b89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260602141434eucas1p15746f013244db658407ada4f3cea7b89
X-EPHeader: CA
X-CMS-RootMailID: 20260602141434eucas1p15746f013244db658407ada4f3cea7b89
References: <CGME20260602141434eucas1p15746f013244db658407ada4f3cea7b89@eucas1p1.samsung.com>

Commit 21c05ca88a54 ("workqueue: Add warnings and ensure one among
WQ_PERCPU or WQ_UNBOUND is present") added a check for the proper
workqueue flags (WQ_PERCPU or WQ_UNBOUND). NTFS driver lacks them,
what triggers the following warning:

WARNING: kernel/workqueue.c:5855 at __alloc_workqueue+0x688/0x70c, CPU#0: swapper/0/1
workqueue: ntfs-bg-io is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.

Fix this by explicitely requesting WQ_PERCPU workqueue.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 fs/ntfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 2a5ad7d56bc2..0a7c9d1bc69a 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2526,7 +2526,7 @@ MODULE_ALIAS_FS("ntfs");
 
 static int ntfs_workqueue_init(void)
 {
-	ntfs_wq = alloc_workqueue("ntfs-bg-io", 0, 0);
+	ntfs_wq = alloc_workqueue("ntfs-bg-io", WQ_PERCPU, 0);
 	if (!ntfs_wq)
 		return -ENOMEM;
 	return 0;
-- 
2.34.1

