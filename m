Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5D33F37A;
	Wed, 15 Apr 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253619; cv=none; b=VjAPPwjsa/FW2Qr1gg4m+fBW8YYKTa+MoofJSgU5EH4W+Nz/g/KgRuFkoma+ZdR8k6ML5CNB8Wei1uQb1IcDlo7bYk71KIXlLavX2TPqCTCggNNF/kLoHsPXKxdKK0sozh36Tkyiwunma8zv3UA3MnPogA+oIro8+afnIz8x7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253619; c=relaxed/simple;
	bh=4D2X8yOU8rGtrp3V4NAtTQ83/GooCriEzsAB5KmaFjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1ucGACaz6CM/T1M45BXzP36lHUmFZS9S3HiSioRfoU9R72ish20Gyad6xrZxrKmF+y9sCg6dDqDSMrRQb8R4ztWsuKs0Yk7meyj3Cs3qh30GeUiB1VMJ4/Ot13/+zMhZcGnOH33qyQ2Bwl8ZGygu0hXQ46mfOMuFOcH2oIMdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwfVW1cM4zJ46cZ;
	Wed, 15 Apr 2026 19:46:11 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 480A640575;
	Wed, 15 Apr 2026 19:46:54 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 14:46:53 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<ljs@kernel.org>, <Liam.Howlett@oracle.com>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<artem.kuzin@huawei.com>, <gutierrez.asier@huawei-partners.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Anatoly Stepanov
	<stepanov.anatoly@huawei.com>
Subject: [RFC PATCH 0/2] Use high-order folios in mmap sync RA
Date: Thu, 16 Apr 2026 03:28:51 +0800
Message-ID: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

When "fault around" is enabled, 0-order folios might significantly
slowdown filemap_map_pages().

For example when async RA won't be able to start,
we might end up with a large mmap'ed file with 0-orders.

Imagine an access pattern, when we
just access file chunk-by-chunk, where each chunk size equals to RA window,
until every chunk of the file gets loaded into the page cache.

In this case, we never touch RA-marked page, thus async RA wouldn't kick
in, ending with 0-orders covering all the file.

Let's resolve this by starting sync RA with high-order.

(procfs smaps patch is just for showing contpte coverage improvement for arm64)

Based on linux-7.0-rc5

Anatoly Stepanov (2):
  procfs: add contpte info into smaps
  filemap: use high-order folios in filemap sync RA

 fs/proc/task_mmu.c      | 20 +++++++++++++++++---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            |  1 +
 mm/internal.h           |  1 +
 mm/memory.c             |  2 +-
 mm/readahead.c          |  5 +++--
 6 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.34.1

