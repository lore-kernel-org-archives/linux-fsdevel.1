Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD812FE07D;
	Wed, 23 Sep 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146932; cv=none; b=QZwYQE0UxSdAELU1iCSF6IeNTpNpM6qMATDR544Gx3Z3aSbZJSwP8CPKOIB+Vj22O6a+0xYelIUwV0mSSLWN9FPAQ6o/jMMqJSwHb1VK+Cw5VUnt8cU9AlQ7W2ztnm5Hn5GewbbKkTeQYhtcTg4SjuyJWkJiQGELH1UflIjyHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146932; c=relaxed/simple;
	bh=Pkz5iq28FdGajhySrhFAqn9gEq1x1w1GgnxF5EHD47s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZgSVrF5VYkNv872SzxPDesSknCVnRvtM4SdHvEKhHhI8eZQhOt6NN9j+5qnBYydWUx7PGPXYlZquJQeBVbf3UCyFZCurehv+aEmnj9/xALMj0sTwKzAEPDu+9MXi7ZsjhKvhJuZog9M85m5LAfpAJDgQlB+U7/+EW7oQqpI2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqSYw3jPxzTSdh;
	Wed, 23 Sep 2026 15:01:40 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqSYv6Z8XzTSdh;
	Wed, 23 Sep 2026 15:01:39 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id C34DF3027FFB;
	Wed, 23 Sep 2026 14:57:08 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 23 Sep 2026 15:01:38 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yefan@hygon.cn>, Huang Shijie
	<huangsj@hygon.cn>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fs/drop_caches: skip filesystems without fs writeback
Date: Wed, 23 Sep 2026 15:01:16 +0800
Message-ID: <20260923070116.3226846-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Filesystems backed by the noop backing device (procfs, sysfs, kernfs,
tmpfs, ramfs, etc.) have no fs page-cache writeback.  Skip them in
drop_pagecache_sb() instead of walking their inode lists.

This also skips tmpfs/ramfs. tmpfs has clean folios which are
zero-filled pages from reading holes, which are trivially recreatable.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
The RFC mails:
   https://lore.kernel.org/all/arIVBpMZk5-O2AZc@infradead.org/
---
 fs/drop_caches.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..28c5fb9c7357 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/backing-dev.h>
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
@@ -20,6 +21,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	if (sb->s_bdi == &noop_backing_dev_info)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-- 
2.53.0


