Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4E42A791
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992867; cv=none; b=juZ/gUWGCd0rHX34NXsQRTecm7j6WeZo90/h7ZSoheadQdINlwXEnHCCCSVz8+2VdNzIiiMRMdq/WvhnZ3AJFGQCNWjQgyrnsq/oZV6h4qoCN7xv9+4RFNP3WJXYtHWis9hf9sypZHrzev390AcS74eQHT+NQBFdATNDH0opkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992867; c=relaxed/simple;
	bh=IBs370aE8JYqxfGWK1ILQZ5zKJpQO8cMEzpFUWRk4E0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lN9313aqRZl2iA6mzf1oTD8z2cHk1SUOb6ZtEbee3lCMZHxgWA5WGdRqhAQFzBmkz+wI/3zTp7D89o5NEc+yHL/A3il1d9tCl7hU+EcP2dAwdjp0Eml7EBdgytnffs+hFnMkyiNqFoDtKvwGHCVL5NOuTTO8uT5XiACDg6a/sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BGvwrgrM; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BGvwrgrM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PGc3zRf1zoDa9l5gecI4KZf4Y8Gc6iBYEHK0yoaFmbo=;
	b=BGvwrgrMmCwLJlKTmEYvNKxZk5CIs1HatwIojXO+5LSMEkawM3TlwK4cJ9jofY/+1tFb61xon
	8/a7mHrqLdHJxfDn+97qBLuRK7ndf4EEReyGtd+IZ7bEcu02mbJ7fxaHff99Q55TrqhW+IjTOdp
	untHYEM4NOr2Gm3P5rwEFOE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4grZFR633GzLlyw;
	Thu,  2 Jul 2026 19:20:59 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 376974058E;
	Thu,  2 Jul 2026 19:30:10 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Jul
 2026 19:30:09 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<tujinjiang@huawei.com>
Subject: [PATCH 0/2] fs: stable_page_flags(): use folio_test_*() helpers
Date: Thu, 2 Jul 2026 19:06:12 +0800
Message-ID: <20260702110614.2176986-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)

This series cleans up stable_page_flags(), removing the remaining direct
flag manipulation and replacing with folio helpers.

Patch 1 replaces the "1 << KPF_*" expressions with BIT_ULL() marco, to
avoid -Wshift-count-overflow warning for KPF_* values larger than 32.

Patch 2 replaces direct accesses to folio->flags.f with the standard
folio_test_*() helper functions, which cleans up stable_page_flags() and
hides internal implementation details.

This series is based on [1].

[1] https://lore.kernel.org/all/20260629033122.774318-1-tujinjiang@huawei.com/

Jinjiang Tu (2):
  fs: stable_page_flags(): use BIT_ULL() for KPF flags
  fs: stable_page_flags(): use folio_test_*() helpers

 fs/proc/page.c | 124 +++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 60 deletions(-)

-- 
2.43.0

