Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47722F851
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950531; cv=none; b=rvcXSGG69E8O3iv8zNlk4yZNzmGOEJnd5htB5vUA0lImxTpfxPZuCEIXSmgyksrvnW9gEO21UgB0JAP8CVNc6UqnzhcD6YtNcBjjdcHXDcmG9D3JEFMf4s1P4IeL9Ewyg8w2cH623LBT8mDQAs0FYiiJnMpy5oMJmlaBuu5hdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950531; c=relaxed/simple;
	bh=ruCO23X0Y04Ct2EB0/hAz+AaMYPjsZ8eUJROovb9MY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeGxIRTdJsklivTvQg0d1QjGBM53rGkyNNQRJiaYJRk8l+XI/qBrN1p8tMgavhyn1NsZrAoLxiEOxiHKWPDnUxiyxg7JQoBcT3suz7wrggP7nk6qvbRGoR4NVpm9+Rh4sXlS8NXtCIOx/FKZuljNShzeU2QeTWCdmxScoxRo9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S5eY6oBk; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S5eY6oBk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wOIhZpKRNJ9y728+Bht5U042wzaE/0rTgLqCYIaYxkg=;
	b=S5eY6oBkcvl0VVk1N5rDE0g2NxKWbiGIqRFkHNRJM8wLHAfPGRGwdeGbNqJmaMKaqlffyUku6
	IQkuwZ1OCYmaTHdoAUwGBBw38yXnt4VlLBnOp6yMsVM5KdS+7B8jKY6e4XqXGTiQUHSmwlxW0Vi
	XTvd9AfJOuwO0ooxr1/0pA4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fBxCV1F8Jz1T4K2;
	Fri, 13 Feb 2026 10:37:26 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C46D840569;
	Fri, 13 Feb 2026 10:42:00 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Feb
 2026 10:42:00 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>
CC: <djwong@kernel.org>, <lihongbo22@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] iomap: Describle @private in iomap_readahead()
Date: Fri, 13 Feb 2026 02:28:12 +0000
Message-ID: <20260213022812.766187-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

The kernel test rebot reports the kernel-doc warning:

```
Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
 not described in 'iomap_readahead'
```

The former commit in "iomap: stash iomap read ctx in the private
field of iomap_iter" has added a new parameter @private to
iomap_readahead(), so let's describe the parameter.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
Fixes: 8806f279244b ("iomap: stash iomap read ctx in the private field of iomap_iter")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
- Add Fixes and Reviewed-by tags.
- Rebased on the latest.
- Link to v1: https://lore.kernel.org/all/20260126120020.675179-2-lihongbo22@huawei.com/
---
 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1fe19b4ee2f4..58887513b894 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -625,6 +625,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @ops: The operations vector for the filesystem.
  * @ctx: The ctx used for issuing readahead.
+ * @private: The filesystem-specific information for issuing iomap_iter.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
-- 
2.22.0

