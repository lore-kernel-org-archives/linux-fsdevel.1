Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA62391838
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519726; cv=none; b=SqFaKwHg2GjTlfb3Jslq5oBjoINIl+QZO0KjNfrAUa72MeQRNqIeF2q91lHj/2oDoDxd8Urrv5F0YIqlLaqfTCoW0Ox22yhooHmi71mJjnO+amKKCOGyJ6oq7xyehIUDdjLKUmmj435KwHzPg8IwKo8b15pxZZmCzq0KTRtXd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519726; c=relaxed/simple;
	bh=QOcZoCo2h0pnD+vKGU8Dfr/x/Qj9rngtiXH+7NU2njw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dKnwcCF+psHEvQzkXIrcedQO+H3zzVHVK4H5Tkx0ThADRq7EBTyMvCd6RVniZlWxl25/zm53J1Z7JkgvPvgE8+iuHGgtEz47snbjttqS9MGUnnEgOWvxhq4ko/uIcFsFS7IsceE6iewESSObh/mzFX1DvoiCmHLtACG1uxWRnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mEbcGjfe; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mEbcGjfe"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZgzSDGSYwshJBMY2Q9+7FwyqzkGbERSOn9ppxGLEYEk=;
	b=mEbcGjfe+IAXojyBOzEGW70Qc2Ti4Ki0bZ7fK3RlyRMBpRcOvdMHVV8/BntTt2bKudA7yvkFt
	pMXZi4GSCNJGe78ofK/kwLq2FTtIZhpF12VMg1s9EIxWCSC8dYnwmpnn1yZ/HrNOjgkiOFtX7EZ
	+T4MhyrivjCFY00fHO6jh4g=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3RHv3mPYznTbJ;
	Mon, 20 Jul 2026 11:45:47 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C3D24057A;
	Mon, 20 Jul 2026 11:55:20 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Jul
 2026 11:55:19 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH v2 0/3] cleanup for stable_page_flags()
Date: Mon, 20 Jul 2026 11:30:18 +0800
Message-ID: <20260720033021.4091944-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
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

This series cleans up stable_page_flags(), see the details in the commit
message.

Changes since v1:
 * add missing "1 << KPF_*" covertions for patch 1
 * collect Acked-by for patch 1
 * only convert folio-specific flags to folio_test_*() helpers
 * move KPF_IDLE cleanup to a separate patch

Jinjiang Tu (3):
  fs: stable_page_flags(): use BIT_ULL() for KPF flags
  fs: stable_page_flags(): use folio_test_*() helpers
  fs: stable_page_flags(): simplify KPF_IDLE handling

 fs/proc/page.c | 56 +++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

-- 
2.43.0

