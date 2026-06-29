Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2D224B15
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782705318; cv=none; b=g0QJtC0Kj1EdKb9PTmOIGCDWOo7qZcWFBav2rnVuDcJyURULRp4yiiudnEgG0Boe7ysQcUHhUi9d/lplZ9dkSvij9Yn/+ltUiIMun+dnjcKFS+EpxWs6ZVC+xQEExWP36RzuH/FdQwoEI97TOZXzlYaefcwLKRfF8Jr68KTq9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782705318; c=relaxed/simple;
	bh=dSgbMtfe4yxiHwoY44BgJjTPkuLPSXGl9+8FQyq7ybc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dv0W10HofEzkPwIVEYjUJsYCTPKsjY43mVM3o/Ozuj6Zsajnh/fYpmGrTZMYTtnRV1rX9TXp/hw8lRnhAPdBnVq+RNJcrugbgISlAQgjL3ACDtUhHsxp9Hr8IlXRWrDXOY1+oEa5sp78pC9n+lvJ0Z3HhqfLf6KeEochMMR3bRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FeA0ZAt9; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FeA0ZAt9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2HEXuekBWlP8PRlh41ZFtpJLOZNwbYwKT+VJcXRzJeQ=;
	b=FeA0ZAt9WRFs8sSQkP/cXZfSRVHWFmKR8rNCuzUv2fK0Fh1bf0wVespxmM/Vbkl9r2CD6s9IO
	aRsvb0A7fwUid/04M3GnW85jNSEISjomFpYKmUTu6Mo0TzLREW+Bsk8QjlqyogDmVEh63/OuxIL
	GwrYBUk/VqpPz/cWc4vVWIk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gpXHq413yzRhS7;
	Mon, 29 Jun 2026 11:45:59 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D5F540538;
	Mon, 29 Jun 2026 11:55:06 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 11:55:05 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH v3] fs/proc: fix KPF_KSM reported for all anonymous pages
Date: Mon, 29 Jun 2026 11:31:22 +0800
Message-ID: <20260629033122.774318-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
when KSM is not in use. As a result, tools misclassify all anonymous pages
as KSM merged.

In stable_page_flags(), if the page is anonymous, then use (mapping &
FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
(mapping & FOLIO_MAPPING_KSM) check returns true for all anonymous pages.

To fix it, use FOLIO_MAPPING_ANON_KSM instead.

Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
Changes in v3:                                                             
 * fix typo.                                                               
 * add CC stable                                                           
 * collect Acked-by.

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

