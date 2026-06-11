Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11922481641;
	Thu, 11 Jun 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198071; cv=none; b=oUaHglGHfy1L8+3ZrDW4YCqA0tyGVvRkodu6MY6SNxojmtqU3sMN1SJfGJMNHgJd68TdFyxWUa9g8x0RtoD8/V7Qg2Uvb6NnLebrCpZKzQOFn+uqnPXyKKjibNiUlGLCZcrlfpHO3kJYbz2cGwuiHqsxmXCHSjw3j5E+9/j+ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198071; c=relaxed/simple;
	bh=vYLNc0iNyCOPgeFSRI8ex0zzZkLRQiJs7nWQlVpsJSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cftyzWCEe6llPMvYLmYN4Xieabv+EEx5IDJ5+ZHxE7A5gJt4uvR/ynxEqZhSBhegMk3pZSfnlMAiMyKaiV8evN3mbRcTQNC/ixi+7Cq4o+oYsuN9UPUZGPApRi/qhg1a6v4IH9oeuHy1h52rkW8+EA3sqeoKb7Sn1Rcpm4TVv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UhBkNafF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UhBkNafF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=s1gNw/K1WJ91+vN2vqA2s83/uYPgBvrrPGXNO3wV5Yg=; b=UhBkNafFMz1IkBc1qFG9mPtybm
	QbH0maKdnXLXjeYkHN2VKG3Dcin8im3z94hjM+YNRUpZfznr1elwinDzKGDGGFjPJJlfdkG6Qcfpe
	3LrYMuXI4CmMijayuBA83jVNurL4ijlqiw1rUKDFo10QyC5a6F4BPSPWxJYm2wS/BXD1vbAUBTuDt
	1UQwZJpSPtmyO6XZyuLSCGuReE5zCV/kCP4K1wDUjwVJAc8VGviL3GyC1nD13GTQN3MJ5w+wbeQna
	2JS9J3DosOH76pVdq4E5KKiiqlhoysLDpXp60TmkZoJTm0ll8VbKXcPLodQiqqyLZSmx2oDnzkjUw
	3XTur6PA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070mt-1c5q;
	Thu, 11 Jun 2026 17:14:26 +0000
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
Subject: [PATCH v2 5/9] make mnt_cache statically allocated
Date: Thu, 11 Jun 2026 18:14:20 +0100
Message-ID: <20260611171425.1671254-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
References: <20260611171309.GN2636677@ZenIV>
 <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..e03c3e7e0a36 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
 #include <linux/nstree.h>
+#include <linux/slab-static.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -79,7 +80,8 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
-static struct kmem_cache *mnt_cache __ro_after_init;
+static struct kmem_cache_opaque __mnt_cache;
+#define mnt_cache to_kmem_cache(&__mnt_cache)
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -6234,7 +6236,7 @@ void __init mnt_init(void)
 {
 	int err;
 
-	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
+	kmem_cache_setup(mnt_cache, "mnt_cache", sizeof(struct mount),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
-- 
2.47.3

