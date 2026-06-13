Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D679368D43;
	Sat, 13 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327400; cv=none; b=T0JtQz7hB5VHGZHK/7XTr08ZTVF3DpC1DijorzM3h1G31BZfzEIiXYC0De4J36C/9sdU0cdI7aYZjxUE2XswpHnRWgKuz+xAIkhHorJvx1uPGNaNMtlusEX+vW+1pdTxoeORw+R4ilL2luThlqzjRZH3iz/ydLVI49gizZuj8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327400; c=relaxed/simple;
	bh=E2HVMIfxxIbjX40EObccnDitdTOl46wVOtsPAveEt+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tep21mv4iecVsd8IVOa5ibU1J1m2p7rliQD27oGh3e7foZO5kGmAW7sZylNjwL/PBMAvstggP68Gk6rPA0P3UK8v0Vkh46N1Lq7deLR/ywWhhCR591RCftNocdtaSqKTw7uuZ5JxYPe3NOZmPyFk+fWrxb0MDe2phdIApXQ4hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oDl2Okc4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oDl2Okc4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C9rJz0S4ZvlUN8tTo22g/3aNhc0livUU3ytI37nwAhU=; b=oDl2Okc42x/lldoIdjfrsalnpk
	Yt7seMej/y4SVeL8gAXIzUuPUpqG6PzZWhIybTn0nMGRQ3Jjk6r3IcQlLLDlwGEdBqFA/RpHvLwAK
	VB2dAqlDPhN/4eLE0OX3GOOJ2tDzbKOdhN+jEfiORhqLfxKkA609cQAsRuVIjjgfdRh036/4xfXGo
	3Uc9sLSV7gc5oRtFMBxfEs/5wZu1BzWFLseKfUoTturCdCuHldP7pwmiFTVC0p6ws6UAS/piS2p8T
	AJ1VbgenroME5//r9+44eoTrsBS83Wr+WXGtp+2TRvOVwev5qBqBDTDu2HSrrPqrQvQkj7U/D+LOO
	7Rpo1/Lg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYGcy-00000003aTF-3TUr;
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
Subject: [RFC PATCH v3 06/10] make mnt_cache statically allocated
Date: Sat, 13 Jun 2026 06:09:47 +0100
Message-ID: <20260613050951.855141-7-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f5905f4ec560..330ac43efb8d 100644
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

