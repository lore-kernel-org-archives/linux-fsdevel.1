Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606343;
	b=mlbX1qu8jRypQg/i+N/r4Uyn2vSuoDUs5OgfXhqCtGqLSjwAPC0gcHlac4JjJLf1jj+i
	 AOxBIBeM8mIxAH7JnBT48lemTBeMlK6eKMVuYCACrvWL3YDyAi6UvhzHpcbG0E5P3kzKL
	 1c0vcVzlKKE5pkQEqB1b0GrdF8uNvgFME9HRVo189hIl32YvWb2mXL3CfYMXvpXmQnrYv
	 syPyDLMnAWqMcv5t0xXG1IZt5juEVtnP9SLiWlisQH+/O7LbTHuE1+ZBi2v7vQNZaY7BW
	 LLL34RL9H2dPtdIcENHKLjUMHviIArOiaAhhbVnUFOfq/BNJFM+VcYrnFXQuU5Oz0hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606343;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=+PH9zTDs7qXdIs87sy4Roo89pD6vSPYgRkevIEWEu44=;
	b=EikzgwOBBaClpJgKQNzRXsjH5j1B/dkYS9k8aqVDDupkGaAFIZ5ZZOUro7uTrUKCfFp2
	 DZwrF5oiqLk6YPlJ8AJjvKB+iG3ed/60iHEof0DEglYYUJMZ3AsILUUgN2PfUFVpVdbiK
	 ON+Pg3XL7moGB07LviZi69dHAS2KJneO1WWfrzEkjjsMnhw16gmLgmkXheJdPId1XNXJV
	 oZ8H/0//gFC+Cq/GlohubAd6KcR7K9IgpNLOAxbyF8BGnMtU5LFr6NX+puQaEQ4q7zGN8
	 7xV53z0xkeNXp4DYy+qZ+qQaObxmfdRsNziX19qLt9wml9si4G2R//fJWWhoAiEy0rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=CbZRsVQa;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E55606A31B;
	Wed, 21 Oct 2026 18:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E55606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=CbZRsVQa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792606342; x=1824142342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+PH9zTDs7qXdIs87sy4Roo89pD6vSPYgRkevIEWEu44=;
  b=CbZRsVQaYxyf4mOIhE51F6o96ESnlyt64OfzjuPoANme6YGKcuYN/NHO
   g2P9SttCHVMy8gLhl9wnDf3pGwkaS1e5DQNs0f7p37XBC8+XqdPo0ct5V
   1OBvz7eY1IIJXADqSOKnq1oVUW01/tKSlhK6i5JJGzd/X2xD30slLBH8/
   Ff6MQIxy998Fu8ihZJwUYjT0/obQQyZgoneor1eloiLjotam4s16S3nij
   K2y417kM5jkExbyVpwaUDl9IMqwpFIIo+YVndZb+1r8Haji5BMZoxhQtN
   MttmXR8GkL/Rxkrab9h9iY2W6rlTTtOPokKphKE8df0vf/mZP8p8mWcoP
   w==;
X-CSE-ConnectionGUID: G3TrxJyyTa+g5VQvwbjqcA==
X-CSE-MsgGUID: p6CqAlqYSceCiQKVC25+tA==
X-IronPort-AV: E=Sophos;i="6.27,170,1787011200"; 
   d="scan'208";a="31686578"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 18:12:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:24446]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id f0401e93-fdd5-44e8-9f5b-88715e886dd6; Wed, 21 Oct 2026 18:12:22 +0000 (UTC)
X-Farcaster-Flow-ID: f0401e93-fdd5-44e8-9f5b-88715e886dd6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 21 Oct 2026 18:12:21 +0000
Received: from dev-dsk-youyouyu-2c-7ec217cf.us-west-2.amazon.com
 (10.189.234.25) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Wed, 21 Oct 2026
 18:12:21 +0000
From: YouYou Yu <youyouyu@amazon.com>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Lichen Liu <lichliu@redhat.com>,
	Dylan Johnson <dgj@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v2] quota: initialize dquot cache before mounting rootfs
Date: Wed, 21 Oct 2026 18:12:17 +0000
Message-ID: <20261021181217.20171-1-youyouyu@amazon.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On some systems, a tmpfs backed rootfs is extensively used throughout
system's lifecycle. tmpfs quotas are needed to limit per user rootfs
usage. However, booting with CONFIG_TMPFS_QUOTA=y, an initramfs, no root=
and "initramfs_options=usrquota" panics at boot:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:dqget+0x1ac/0x490
  Call Trace:
   __dquot_initialize
   dquot_initialize
   shmem_get_inode
   shmem_fill_super
   ...
   mnt_init
   vfs_caches_init
   start_kernel

The rootfs is mounted from mnt_init(), but the dquot hash table and
cache are only set up later by dquot_init(), an fs_initcall. Creating
the root inode of a quota enabled rootfs thus dereferences the NULL
dquot_hash in dqget().

Rename dquot_init() to dquot_cache_init() and call it from
vfs_caches_init() before mnt_init(). The slab, percpu and early
workqueue code it relies on is available there, and the workqueue
rescuer and shrinker debugfs entries are set up later by their own
subsystems. Keep the sysctl registration in an fs_initcall, as done
for the dcache, inode and mount sysctls. This only moves existing
allocations earlier in boot.

Fixes: 278033a225e1 ("fs: Add 'initramfs_options' to set initramfs mount options")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Dylan Johnson <dgj@amazon.com>
Signed-off-by: Dylan Johnson <dgj@amazon.com>
Signed-off-by: YouYou Yu <youyouyu@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---

Notes:
    v2:
    - Mention the use case in the changelog (Jan)
    
    v1:
    https://lore.kernel.org/all/20261015183608.22507-1-youyouyu@amazon.com/
    
    Tested on v7.3-rc7, x86_64 QEMU/KVM, booting from an initramfs without root=:
    - without this patch, initramfs_options=usrquota panics in dqget() as above
    - with it, initramfs_options=usrquota,grpquota,usrquota_block_hardlimit=10M
      boots, rootfs is mounted with quotas, and a non-root user is limited to
      10M on rootfs
    - /sys/kernel/slab/dquot, the quota_events_unbound rescuer, the fs/quota
      sysctls and (with CONFIG_SHRINKER_DEBUG) the dquota-cache shrinker
      debugfs entry are all created as expected
    
    An LLM (Claude Opus 5.5) helped drafting this changelog.
    I reviewed the change and ran the tests above.

 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f44c7b39c3b..b208cbdda0f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3525,6 +3526,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1c78c695d0d..cd142c9cc7e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2942,7 +2942,7 @@ static const struct ctl_table fs_dqstats_table[] = {
 	},
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash;
@@ -2950,8 +2950,6 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -2992,7 +2990,11 @@ static int __init dquot_init(void)
 					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
 	if (!quota_unbound_wq)
 		panic("Cannot create quota_unbound_wq\n");
+}
 
+static int __init init_fs_dquot_sysctls(void)
+{
+	register_sysctl_init("fs/quota", fs_dqstats_table);
 	return 0;
 }
-fs_initcall(dquot_init);
+fs_initcall(init_fs_dquot_sysctls);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index f9c0f9d7c9d..bbe22c22439 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -40,6 +40,7 @@ void __quota_error(struct super_block *sb, const char *func,
 /*
  * declaration of quota_function calls in kernel.
  */
+void dquot_cache_init(void);
 int dquot_initialize(struct inode *inode);
 bool dquot_initialize_needed(struct inode *inode);
 void dquot_drop(struct inode *inode);
@@ -206,6 +207,10 @@ static inline int sb_has_quota_active(struct super_block *sb, int type)
 	return 0;
 }
 
+static inline void dquot_cache_init(void)
+{
+}
+
 static inline int dquot_initialize(struct inode *inode)
 {
 	return 0;

base-commit: 7c6f8a2841d4eeeceacf42689cd2717fe76d9f7c
-- 
2.47.3

