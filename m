Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E031E847;
	Sat, 13 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327402; cv=none; b=t7ZMDV/pvYQBSDDsXpwdCH1TL4yPI4xgm/dcfVWPHrIa0DThtTcvx4fYwWBRhTkLngbfyj6MjqmhqrwmN+4sJiUE2ePMd+GA9qPa/Q9x0p2y95crEXryQUXt0ekT46izYsswuhZZjvVPk3zq8xRqBp0WTvHy7n4aOncOpaP7B00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327402; c=relaxed/simple;
	bh=aVyrF6GmaUwC6jL/gHBP/nWblMEXQRCN2xDxdwa/YfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz4gIaGTB3sKnvIvTmRTh8OuDhhctrfZbYuZlDD458FHOGTbJHrLs6RmFJMyTTD3iAdbc1pWpvBHPFgyID4eoNhwgzTgq9YMXsmn0ZBnNEMJwIrxRD76ZFGthior+YwmmWHa96eKP/HyEbEJ0sLBs12rKbkpjwWJqTssamOxw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gDTlF0Jp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gDTlF0Jp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6f3OoggzlPIzKQe/th8iqmFArhYwFRFyJgw+Gf2/5vg=; b=gDTlF0Jp7OiugKRzAwtDz8Jfwm
	neDfrE+2AytAPJEGebM+9vkv8xGIEzPWzFLqaLdDuS+qGjNBPML5W4bYsKzqZQFruNy6Q2NHb2TQ+
	cUxO+r8m3+1QTQfcSTteMRP5eI3oP4kikzh/m7pvN7NNTH7Q3x+VIR2oVSgGlVHhuakPNwbfeIJzK
	Mg7DxKAChWsErdIaxYK4TGeXWjY5m8mHOw6eD+U6lIw1+rXMScNQ+Y0hbISppLVKdbU1jSfAPYPDR
	4EXK3CI+dIusUiQmPK4CrOD/KDdnbtD59Qf10pLNBVIzvyq74rejZxZhUmSetIlA5zb8bxAUI6slN
	jTboEJ9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYGcy-00000003aT9-2z85;
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
Subject: [RFC PATCH v3 05/10] make inode_cache statically allocated
Date: Sat, 13 Jun 2026 06:09:46 +0100
Message-ID: <20260613050951.855141-6-viro@zeniv.linux.org.uk>
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
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 62c579a0cf7d..1c657ac99084 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/rw_hint.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/slab-static.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -76,7 +77,8 @@ EXPORT_SYMBOL(empty_aops);
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
-static struct kmem_cache *inode_cachep __ro_after_init;
+static struct kmem_cache_opaque inode_cache;
+#define inode_cachep to_kmem_cache(&inode_cache)
 
 static long get_nr_inodes(void)
 {
@@ -2598,7 +2600,7 @@ void __init inode_init_early(void)
 void __init inode_init(void)
 {
 	/* inode slab cache */
-	inode_cachep = kmem_cache_create("inode_cache",
+	kmem_cache_setup(inode_cachep, "inode_cache",
 					 sizeof(struct inode),
 					 0,
 					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
-- 
2.47.3

