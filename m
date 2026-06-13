Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4A314D34;
	Sat, 13 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327399; cv=none; b=M5p3mbVGesiayzfKuMICL5ZrT6FrypgP1GgtxWjOIiNZUWpjv/zbzurrXCRhlzEobkvAq9/z+/ZVsLrs5fTJW7df98slR+jfae9La2OtQgXlDz0xXSwb5+oXconuxoD1/NadKFDVD9pst7IYFT55JGNN1uzfDEnUaymf/iRNwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327399; c=relaxed/simple;
	bh=KZqzhXpLuUiZO+jd6YhFthJurVT4/GGa/2WSPqEKLuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4wAtGgFun94covufV0ANQ+p8mhQP/xz5IvHMWhmvTEdyfuoq8ObWuzfXncbYnjXU8BcaHL4ZuX6Gp6LCfzfD4YVsvfGBwWndD8svd3tl6dCntJXwOvCX5NH5gh7XeuPqNTbGqe0dKCsYa9uhvZallZh43P1U2iN7vkdtt3XRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=is2Egeu6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="is2Egeu6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XQVmtnuRTUVgN+XDKa4kk4jqSyJyiqHHhlvxjk0X6XI=; b=is2Egeu6/E0Y59HwEGUchJIXbu
	vvsTtdmBZVMK9LVkHzW5SRn8tRwn8haNo97Vx6NZxgxFEEPJVVOPdliXHTN9GexiGDWV/mqmXTcA8
	vTfgF1nIfWZKBhfV5HkbwQ6FjA3hvM0e0PDElW34aUCUUTN+ozI8zgzNjOUP6Lb/LqJUxuoc/xZP4
	j5XSX6SpMJjb8qlFtUdEq3mKuQhl7xoBTAm5BV08AzyNvC8aX13uRur90nerQGGkzCCQNHMpk1UTN
	DUgSVtPIJpFiFqEU2bgsuvMk2CEw/NOUHFF5PORb/YmV3ERUzaGFz9D7j+DtVtdMwiNs+xBPPjOuu
	tbCUcFWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYGcy-00000003aTH-3jDL;
	Sat, 13 Jun 2026 05:09:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 07/10] make bh_cachep statically allocated
Date: Sat, 13 Jun 2026 06:09:48 +0100
Message-ID: <20260613050951.855141-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613050951.855141-1-viro@zeniv.linux.org.uk>
References: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
 <20260613050951.855141-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b0b3792b1496..e834f7091f51 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -51,6 +51,7 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
+#include <linux/slab-static.h>
 
 #include "internal.h"
 
@@ -2906,7 +2907,8 @@ EXPORT_SYMBOL(try_to_free_buffers);
 /*
  * Buffer-head allocation
  */
-static struct kmem_cache *bh_cachep __ro_after_init;
+static struct kmem_cache_opaque bh_cache;
+#define bh_cachep to_kmem_cache(&bh_cache)
 
 /*
  * Once the number of bh's in the machine exceeds this level, we start
@@ -3065,7 +3067,7 @@ void __init buffer_init(void)
 	unsigned long nrpages;
 	int ret;
 
-	bh_cachep = KMEM_CACHE(buffer_head,
+	KMEM_CACHE_SETUP(bh_cachep, buffer_head,
 				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
-- 
2.47.3

