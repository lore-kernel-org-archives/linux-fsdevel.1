Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1137C933;
	Mon, 14 Sep 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366553; cv=none; b=HJds6dTSqDMYeteZmcQtiFl5Lon/PWxALFfjJkwsPY+RK766v/ehRHBDOjeK5+uBwVlG5/Duso532j4/b+kD/J6v/nsH93ir1RSvKYTkG70R8LauTeq1YrtEtJ15XK8yDgP56yR2rO7kmKXu1GpEFLZDm0OKcbeWuFUEWE+OArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366553; c=relaxed/simple;
	bh=P7rXGNebSpfRTNesgQtTHCpMRKRDDGiHlz8N5zawpgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVhM++PR4eZXMmC966bzSqG/80CFYNjmQ+tS6EZs8DNDroz1gdvjhiBivdPhztuzysbCwdtmSUG3nQQjIAIIMpT6BThEJIPuxDmNBGaRGKTOzcpH4wwCmkbebfpadFK78SzMhMYsKxQ56yJiyoy2075hF/wvwGNRI1eooaLkZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvyr6rcmz2CZMW;
	Mon, 14 Sep 2026 14:15:32 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hjvyp5s4Fz2CZMW;
	Mon, 14 Sep 2026 14:15:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id D27B0310BECC;
	Mon, 14 Sep 2026 14:11:16 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 14 Sep 2026 14:15:29 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [RFC PATCH 1/3] fs/drop_caches: do not scan procfs in drop_pagecache_sb()
Date: Mon, 14 Sep 2026 14:14:47 +0800
Message-ID: <20260914061449.4024632-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914061449.4024632-1-huangsj@hygon.cn>
References: <20260914061449.4024632-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

There is no page cache for the procfs, so do not scan the
inodes in procfs.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/drop_caches.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..1959090089af 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -5,6 +5,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/kernel.h>
+#include <linux/magic.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/writeback.h>
@@ -20,6 +21,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	if (sb->s_magic == PROC_SUPER_MAGIC)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-- 
2.53.0


