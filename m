Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6754334C03
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429650; cv=none; b=uqjoVIP7Sdput1m8nE0ysr1LzFQNWF7RPF05ymMnRPQziReDLr02cnSN/vKOmcKvaJzWKh/JRCziu+6zS9TSpKAdhS8D6NjeDqeZME4USXkdbm1XoE+AUqgbZ/fxhIwHrd1VpJ0KHwrPH8uulBSlCgU3IrPeVnc+mMVOaqjhYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429650; c=relaxed/simple;
	bh=EHWQJgLSniYPufoVD4yO55srs5ErGYjBSa3Xvz1MjaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nybN9eW+nXdU76k6sqCwue9u1VMCyxXKK8C5bGPJ0LgvX1EfS78RtZFUGoRauho2u+siskvIWiQkO6Q1UwCV4vJJlL07g9IKXsauDNYsWBqx1S8EORmj8sM2LCglPA7SnvYQr3HS7a2fTRDSCSFH88dX4/3r98W0Oj4HyqRxIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TBtOYs3f; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TBtOYs3f"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HLNhNkUAy1gp9R6SI4d0XXyRjiGuiGy0YTHYHkYb1FY=;
	b=TBtOYs3ftlT5w9YCI+quh6qTnc3/UWoAKoltlCB56RxRZMjEsxEvRah7VEv0aCHQsTpL9joPd
	Lvjw7wgtpcHabaS7xf7N9587hZJ7p4NqHya/QsRUJLOVhwBWeJ50RPDhvE3AEGXzNlpDlTDq4Y+
	7ZNLEycfeOj2ewk+ckM5Mlk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f06nD0s0vzLlXY;
	Mon, 26 Jan 2026 20:10:40 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5302F4048B;
	Mon, 26 Jan 2026 20:14:06 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 20:14:05 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hsiangkao@linux.alibaba.com>,
	<lihongbo22@huawei.com>
Subject: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
Date: Mon, 26 Jan 2026 12:00:20 +0000
Message-ID: <20260126120020.675179-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260126120020.675179-1-lihongbo22@huawei.com>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
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
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b350cc2a82ab..857b16bb3474 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -609,6 +609,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @ops: The operations vector for the filesystem.
  * @ctx: The ctx used for issuing readahead.
+ * @private: The filesystem-specific information for issuing iomap_iter.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
-- 
2.22.0

