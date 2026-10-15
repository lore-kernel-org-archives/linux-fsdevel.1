Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473213B6346;
	Thu, 15 Oct 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089388; cv=none; b=Izlal9zRKmkVcaTUIvsI7o2B3EUjnJ0JRZS9IwlkIOF5AG56hkNWEpu440CdYJUwlbkyS/IVg2bVGSrj9Hl5ASMzdudhqRahGAz4wpabtRD7JT6RuwIl1qlYiSyf/lXlMM6Ro5J2LL52MI8Ay7a5+i2zS639/sDnXKLiP85iEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089388; c=relaxed/simple;
	bh=qgx9cAn9+NJmRyjC1t3rpYJirTIvvmEfErWuDybI+/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWgCD9jeC1yAKF0dyOCp3/YCjTFtT4frV54HKSiFTf76oG8mI2jUN7Ag2wO7bIstdHoRCFnQX8/Azd7bIz50MEnuZ+FW+8uXxP5qS8v51iyriOgK8/uZzHxuSTlwP/qnFC5q9C7DOAy1hV15s1ZcC2s0w76igNNjxW4WQ87bkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WHWbG92l; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WHWbG92l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792089373; x=1823625373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyZFIMr3M6dvoG/l+WIqJtSH+WNibTco97yPW7gHyAY=;
  b=WHWbG92lI8R5Frill3ckym2GGT9alELZ6hZN1eGKjJGdcJlxuU7da2en
   TjvoqQuFCO1VFhWIBUdfeUVRNCVwDPJHDHnHf8KHw2ojPVXISuiNFUWtK
   aBjZnuk/QNF+NOxm0YVQVUvRKQuZeZx0awxWYd6Jat6xMNnGBqmCGCULN
   knuLslUHcyLgC2K4uSPFVg5FOmvZFuKNCLW5nMjXwEKBRYFBIAPxsYV9W
   fE0U8fPa8/geYvP9qw0xEXCt+JZaPGlOT6f6q8WrbGcemQTjbeqHbKN+K
   WS/LoBXTwXmrOrA/hnd2IU1kE0VTMSO9cAwTXfpYUG3YsmzpSngINYEsf
   w==;
X-CSE-ConnectionGUID: g9QTmB+fRM63EkRCucPxgw==
X-CSE-MsgGUID: c1nq4B3uQMSJQ9jxJdngEA==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31162916"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 18:36:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:31534]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525] with esmtp (Farcaster)
 id ce4559af-adf3-40d3-b5e5-fec1eb52b07b; Thu, 15 Oct 2026 18:36:12 +0000 (UTC)
X-Farcaster-Flow-ID: ce4559af-adf3-40d3-b5e5-fec1eb52b07b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 18:36:12 +0000
Received: from dev-dsk-youyouyu-2c-7ec217cf.us-west-2.amazon.com
 (10.189.234.25) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 18:36:12 +0000
From: YouYou Yu <youyouyu@amazon.com>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Lichen Liu <lichliu@redhat.com>,
	Dylan Johnson <dgj@amazon.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH] quota: initialize dquot cache before mounting rootfs
Date: Thu, 15 Oct 2026 18:36:08 +0000
Message-ID: <20261015183608.22507-1-youyouyu@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Booting with CONFIG_TMPFS_QUOTA=y, an initramfs, no root= and
"initramfs_options=usrquota" panics at boot:

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

