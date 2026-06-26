Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CD188CC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438991; cv=none; b=iUPsj9bFvAsks7lPXXMdnBqDodwZwIg30jeBYylevZNsf6AvLcwe7T6/xBt/Wpo+N0peVAVT2l+eaqS0mgDHIQWnnNhVhhOqu1jMdyGC/cWtWdCitDG6uNzSdbMhy+/yy8PM9v4tX3RhYZdh/FalX7y6XDk3MA2J39GmugfXnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438991; c=relaxed/simple;
	bh=MXvNaZfo2jS638JS8/uc1ySx2t5iU6UyQizICkQMc44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDo84iocYKl2A6dCEv/6iCbqlzfTL66YTsmoeZbfVt0zunEHIvpUM0xIkdDJJUOamwSnuHE/RZcpEA5ix6x1pkEIFVaYZOwtcmGI5cgbhBWxdJdd9UHHE1+z/e93laAGJWthUFXc2wQifJat9SenLx2RTpuhWld7bcc1jE9ZIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W5snFvZV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W5snFvZV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T0IN4V44VtZA6IPeMFy0yKV+OBq+WrgvYJ7s1AHVR0A=;
	b=W5snFvZVarCkHUD4nk3tP67lftHb5WG3EEqYfhrYvMRK+NN+icERFLxLfS83lFvFvFon7CE1o
	odU/SjBq/WAH2ctVXgGPfQahKPi0hsE1Ccgm3MVBQh1vDNyhi5XGWE4g6Ax6IekuI90eagnRtmW
	nFE92tb5H8Bn9eXksZEc7ks=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gmdpm2hkRzcZyj;
	Fri, 26 Jun 2026 09:47:44 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 076F94048F;
	Fri, 26 Jun 2026 09:56:25 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jun
 2026 09:56:24 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH v2] fs/proc: fix KPF_KSM reported for all anonymous pages
Date: Fri, 26 Jun 2026 09:32:52 +0800
Message-ID: <20260626013252.2846774-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
Changelog in v2:
 * use FOLIO_MAPPING_KSM to match explictly instead of use FOLIO_MAPPING_ANON_KSM
only.

 fs/proc/page.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f9b2c2c906cd..7d9387143435 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
-		if (mapping & FOLIO_MAPPING_KSM)
+		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
 			u |= 1 << KPF_KSM;
 	}
 
-- 
2.43.0

