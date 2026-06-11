Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422B3E63B7;
	Thu, 11 Jun 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198071; cv=none; b=sMW4XuKhncC/bdN5Hi7sxcOhB4DMjtn+x/gRE8hzpfs7U6q1nGQCLsKVA6s5iJ1q7Adp3Wb7NTGyU8xij3pX9F47nLVn8Xihi28nGhlMDI7FqB4oQNqI6F3IJx3HQuS+2cAhhtbHNFsWvmdYEeRWUs3Ccb1yX99vLMJpneUVzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198071; c=relaxed/simple;
	bh=aVyrF6GmaUwC6jL/gHBP/nWblMEXQRCN2xDxdwa/YfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7qDcfi22j+h+75tflOX1ksEfiYRy2sv3su2pq6tECXKk0BX0Jn0k9SMAV4PcoBoWJHfl6BLoCnomeSDgxHMkOV3bj7nzB/nVfAlwiMPaWvbH+csa0eEgdba4PHH/QFraqTaP5QDR9tCEvJ4QPcc0g9qP+iG6kdkn2sgVe1HjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IHrrkH4u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IHrrkH4u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6f3OoggzlPIzKQe/th8iqmFArhYwFRFyJgw+Gf2/5vg=; b=IHrrkH4ucrsE/zwv9FmFb5rN8d
	KyDGjDcM3kNIF+bPDv/68AkYO1QJ+g5LmXcANlfAzq6rjbqq6bLzb5+odtbSuNOg26vFDIflJJkgF
	a+RUra/3ewvu8dzDl8J0gsazEfu7bhAa74kt1LU8CezmufSn+iFTiCY7Z5s4CynbaQ8IZCaSfFNii
	XSTSevQIEmHrjRtRb2HDgikC+QRlI8xBcl8U5m6lx+v80icI8p3jQg+GMXB7Y0csuA86SbQmSlvxa
	GnODq4cM7Wg/HHNy97u1Q4DKuviS1iGSTVyCiCzPcLffyHgC09/kLXjwpS2KB10mSgL+a2Wh0qHhC
	iF1L8ytA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070mf-0hpl;
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
Subject: [PATCH v2 4/9] make inode_cache statically allocated
Date: Thu, 11 Jun 2026 18:14:19 +0100
Message-ID: <20260611171425.1671254-5-viro@zeniv.linux.org.uk>
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

