Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4464281503;
	Thu,  6 Aug 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029727; cv=none; b=YEWmnimfcT9J57UPrMHlXaTTGGEoBnT+9dd+jbcqVsAGx4iKdPt422QHvbepZG+PYUDSm/NkAhJrmjPkp8fYHaVthqYhZyTMWzpsvi+qxh5d4OntxErAiGZ7eIIL0QRd+qZsb29Hk+KHtWs8iVJMkutgbj1ginYrKqnLUDZHGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029727; c=relaxed/simple;
	bh=qcKUgd8F28yp7OjRVSjI2jDvagLcw4g3iEu+ICt5+64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knWGV3ELScO0RLipDrpMlviN8u/udQHBWKQmqxTku1bZbg6txiLiM1bUsgT0X597aKqYytatb+W1+/LJXpfHmSVfQiBewQVQKsU6LTyDr8o/7ACTrPaaXUgU4D+dhAHVBm0j6TsOYuyQLi9V+RfsZYjfSSm+betJmM/G8a++aIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qmR+9j3n; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qmR+9j3n"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786029716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uTkx2iadO/NU/2tNtcbK0u9G3jxkVy05Po2bCK9o4ak=;
	b=qmR+9j3nCtncvavOcGEfEqfCv36sZRtav7xvjZIVNVxFp+sKnBU/J2fiJ6y6RACPMSh9l9uLV+FF7CGWNdPA6C77qihPv0CAvdMlrQjDF1QvCr7RHghkcLiitpO8TgLzw4VI8Bb2DNxaE+VIn8fHZ1yMj+42ei+WQH9NZeJdTd0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8UBMCY_1786029694;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X8UBMCY_1786029694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Aug 2026 23:21:55 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH] fuse: check for NULL root inode in fuse_fill_super_submount
Date: Thu,  6 Aug 2026 23:21:34 +0800
Message-ID: <20260806152134.1594639-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_iget() can return NULL when its inode allocation fails, but
fuse_fill_super_submount() passed the result straight to get_fuse_inode()
and decremented fi->nlookup without checking it:

        root = fuse_iget(sb, parent_fi->nodeid, ...);
        fi = get_fuse_inode(root);
        fi->nlookup--;

Inside fuse_iget() the inode allocation can fail and return NULL.  The
submount root takes the iget5_locked() path, whose alloc_inode() can fail
under memory pressure (the auto-submount branch can fail the same way in
new_inode() or fuse_alloc_submount_lookup()):

        inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set,
                             &nodeid);
        if (!inode)
                return NULL;

A NULL root makes get_fuse_inode() a container_of() on NULL and the
nlookup decrement a write to a bogus address, oopsing the mount.  With
CONFIG_KASAN the following null pointer dereference is reported when the
root inode allocation of an auto-submount fails (e.g. under memory
pressure):

==================================================================
BUG: KASAN: null-ptr-deref in fuse_get_tree_submount+0x656/0x8b0
Read of size 8 at addr 00000000000002b0 by task ls/942
CPU: 0 PID: 942 Comm: ls Tainted: G W 6.6 #15
Call Trace:
 <TASK>
 fuse_get_tree_submount+0x656/0x8b0
 vfs_get_tree+0x48/0x140
 fc_mount+0x13/0x50
 fuse_dentry_automount+0x7a/0xb0
 __traverse_mounts+0xca/0x330
 step_into+0x339/0xac0
 path_lookupat+0xc5/0x2f0
 filename_lookup+0x163/0x2a0
 vfs_statx+0xd5/0x200
 do_statx+0x83/0xd0
 __x64_sys_statx+0xa0/0xc0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
 </TASK>
==================================================================

Return -ENOMEM instead; the caller tears down the partially built
superblock on error, matching the other error returns in this
function.

Fixes: c4d361f66ac9 ("fuse: share lookup state between submount and its parent")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d975073c6029..455c7feba057 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1639,6 +1639,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0,
 			 fuse_get_evict_ctr(fm->fc));
+	if (!root)
+		return -ENOMEM;
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
 	 * its nlookup should not be incremented.  fuse_iget() does
-- 
2.43.7

