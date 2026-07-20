Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38339936B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519732; cv=none; b=CVhXq4GOZHXDjF3KjGvaEWEYHNR35vDz17SnXhTpXWZLiDGzRr30h/Pw3P5eDQ0TbFF7bqjD7+43Bv6BJIqzVXqlKqUOuq25pa6sFXJIjqdmMQY2KBMT/oOKpj/9fe0ymdmSeD5b80lLJmAUaeXpQqKISeZfcY5vXyE0B9q8YHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519732; c=relaxed/simple;
	bh=mi3S62vdmLqurkCZZj8QU3fBZKaUfIBV7yXUxKpZfI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSOzL57Y+JrDzFwnYbv4faB79FlUB41XclycqSkjNvBeGwLbcwbgQvPCXP5mWOzbcXr/UrzRQMkgBoLg41fA1b9+Z+KOTFU/AfNfwFX2tCefYqMiR91fMH/odIlehYm/W3k2QoaZWjGsZiBXRL1Qhl8YU1ElOwy/SorPHL9FxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FvapgObH; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FvapgObH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=V6BwH4kNzJVEr3y5F7y8FkMUzszljn3fCiBX8k9PF+o=;
	b=FvapgObH4Vi6C/p0Uev2f1C1hOEd3AeGsxtzbb7iZzaXYWEk6HH2f30aoPHL7/JTewIb4ulOV
	TYybA90l9aP6STwX9qYFBi7VrOCfisOawo0aGS64eDXtJ9nSx/rX064dNknZV/B4wS10jJ8qflk
	qW1CTQIfkplfksrmzNgy1ds=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h3RJ93dDnzRhQm;
	Mon, 20 Jul 2026 11:46:01 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F2C440537;
	Mon, 20 Jul 2026 11:55:21 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Jul
 2026 11:55:20 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH v2 3/3] fs: stable_page_flags(): simplify KPF_IDLE handling
Date: Mon, 20 Jul 2026 11:30:21 +0800
Message-ID: <20260720033021.4091944-4-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720033021.4091944-1-tujinjiang@huawei.com>
References: <20260720033021.4091944-1-tujinjiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500001.china.huawei.com (7.202.194.229)

For KPF_IDLE, folio_test_idle() check in set_ps_flags() already handles
all config cases, so remove the duplicate code in stable_page_flags() that
deals with CONFIG_PAGE_IDLE_FLAG for the 64‑bit case.

No functional change is intended.

Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 fs/proc/page.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index b3c1d7a7604d..260772b20bd9 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -196,6 +196,9 @@ u64 stable_page_flags(const struct page *page)
 	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
 		u |= BIT_ULL(KPF_BUDDY);
 
+	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
+		u |= BIT_ULL(KPF_IDLE);
+
 	if (folio_test_offline(folio))
 		u |= BIT_ULL(KPF_OFFLINE);
 	if (folio_test_pgtable(folio))
@@ -203,13 +206,6 @@ u64 stable_page_flags(const struct page *page)
 	if (folio_test_slab(folio))
 		u |= BIT_ULL(KPF_SLAB);
 
-#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
-	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
-#else
-	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
-		u |= BIT_ULL(KPF_IDLE);
-#endif
-
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
-- 
2.43.0

