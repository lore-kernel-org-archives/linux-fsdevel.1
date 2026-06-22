Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12018399CFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121144; cv=none; b=g7lLaWK75BvnnTeWswNB/BT99WQ6HmsHkA2OS55BoCOsn8JPu59yY2V285PjHqns2kr28Nfhku0mW2zWeanRrD/rBDDsOrYMBMOJa6ixkWHaFQ383WTYGtzVmrJFErTwdgXmWkavn2ouzk7IeTLrF3rtKwr+OnSPREZdRPCtAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121144; c=relaxed/simple;
	bh=trpOyCwmmnK85OhSrqOOtHTC1iIyyRwdIZx05wRi1Qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvnIkJhJBuEy+rS8UAfN5+THHXtVq7Vx4K04/FRt8tOsJon7vf+MgJ7qeDu/cMq7MkrAw8n1fghG6V97Gu7Aib0GlBYF9+OYzgiTZle24slVkD+KZCuqDnPu7uVZRSaKOijTiUfTcxSVyCkJerQTr5+LLac8RznfIO/AVLiC1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pLnmtRWU; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pLnmtRWU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6Rxxvp13V2SH4mlEC0Z4qvpzzqaS2fGtDOQumXfcfk8=;
	b=pLnmtRWU9Ab4gV7e9VdlLIDWpLseDnNPDiEB52zjh1ma2D5Ejk8JNbpbbCYT9W4NmWWXuGLsX
	y4VCwTnvNZvq1Jsp5bFyuj8za2mMNpBP7+OZ9n+MQhag7YT1FwnW2dt5E4HQtJYod1dDjhGNsBV
	b3eySE/P02x235SH2ezylrY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gkNH301CjzKm6k;
	Mon, 22 Jun 2026 17:30:54 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 13D7440539;
	Mon, 22 Jun 2026 17:38:59 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jun
 2026 17:38:58 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH] fs/proc: fix KPF_KSM reported for all anonymous pages
Date: Mon, 22 Jun 2026 17:15:39 +0800
Message-ID: <20260622091539.836531-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
when KSM is not in use. As a result, tools misclassify all anonymous pages
as KSM merged.

In stable_page_flags(), if the page is anonymous, then use (mapping &
FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
(mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.

To fix it, use FOLIO_MAPPING_ANON_KSM instead.

Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/page.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f9b2c2c906cd..cef8ded97610 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
-		if (mapping & FOLIO_MAPPING_KSM)
+		if (mapping & FOLIO_MAPPING_ANON_KSM)
 			u |= 1 << KPF_KSM;
 	}
 
-- 
2.43.0

