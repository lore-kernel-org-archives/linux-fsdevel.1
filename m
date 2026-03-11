Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08138D011;
	Wed, 11 Mar 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266211; cv=none; b=RQ69SMEnTTQeiyDjnLG/S7VuEUDGexgmL9o2H6S4nuVpgzNTjBbVzDZv4V+e0JWEqVwceHVyNLwaASphFzPTXiQbGarpDKtbJ2GyCUP+uxkwgyJBTD1INTPWRFpWnpUGUOW0aBmkChAbhgaai1XMgc2hgTO5uImGTsV0Dqafvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266211; c=relaxed/simple;
	bh=k7fCly/aiwsbj3pgXjTBxZbf7C11W0fJ4pfAC6OMiro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psOQGoDTun0tuOJ8YpIyDh3Lzru0nlRRAMCUdgtIRYfsdOcQlgDQ8ICR0Yfh/v0i6hsU8M0dVPdct/+ICwv1NdOQ2QLsNC3azkUIzTffj8EfbO8S0f9ShH3Y00L2YY7O71F0JsgiwNntHuf9g0JzubMzs0+FhkIMfsPMDYadf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK5ysSza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK5ysSza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD68C2BC86;
	Wed, 11 Mar 2026 21:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266211;
	bh=k7fCly/aiwsbj3pgXjTBxZbf7C11W0fJ4pfAC6OMiro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BK5ysSzaYqOzO5ZFPrZI6QeP/Z0Fs1Eci4fsqA6DMnAaOyNVjvz/G7KY0+lHWLQdW
	 Q2MeG0ndikt6QvzQsoFF9wEH9qU4PBmoLpctJmdWTluxc0tQjd0Q2Ipc1NVNOeFeO/
	 s3j7j1I4C+SOg6VsblfGd0uzt+vZKqC4DUdzagGUK/jqtkyD98Snq2pJvHBH1fe+4t
	 J7PRYuiK6qlzInR/vfGD1aTjWtc8BlOomK9tailMOk1pLXSkWeJUP9SxU0SgRDFCDD
	 eueFddewdQiOwPxfIokMoUyWlb3obgEYQT+afQuskSaVBfud1pO4IcrHAsniQcUSWE
	 eVtEi8pXd+k4w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:59 +0100
Subject: [PATCH RFC v3 16/26] pnfs/blocklayout: use scoped_with_init_fs()
 for SCSI device lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-16-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k7fCly/aiwsbj3pgXjTBxZbf7C11W0fJ4pfAC6OMiro=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJT0650WUwNwxUuruaDs7P6pm5dlPSjP+CJbTeT+
 nfpDRonOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyLZLhf8Ie4T/6Pf/KI2Yr
 Tljt+4n97syQSaxiSQdP+Zw1Pnjn5HeG/znCgh0RiiU7Dvluqm2/uulZU6iZrPhFFe4JiTtd7y2
 4ygoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

bl_open_path() resolves pNFS block device paths under /dev/disk/by-id/
via bdev_file_open_by_path() -> lookup_bdev() -> kern_path(). This
path resolution uses current->fs->root.

With kthreads now starting in nullfs, this fails when the call
originates from writeback kworker context because current->fs->root
points at the empty nullfs. The full callchain from kworker is:

  wb_workfn                              [kworker writeback callback]
    ...
      nfs_writepages                     [address_space_operations.writepages]
        nfs_do_writepage
          nfs_pageio_add_request
            ...
              bl_pg_init_write           [nfs_pageio_ops.pg_init]
                pnfs_generic_pg_init_write
                  pnfs_update_layout
                    nfs4_proc_layoutget  [synchronous RPC]
                      pnfs_layout_process
                        bl_alloc_lseg
                          bl_alloc_extent
                            bl_find_get_deviceid
                              bl_alloc_deviceid_node
                                bl_parse_deviceid
                                  bl_parse_scsi
                                    bl_open_path
                                      bdev_file_open_by_path
                                        lookup_bdev
                                          kern_path  <- current->fs->root

bl_open_path() can also be reached from userspace process context (e.g.
open, read, write syscalls via pnfs_update_layout). In that case
current->fs must not be overridden as the path should resolve against
the calling process's filesystem root.

Add a tsk_is_kthread() conditional in bl_open_path() to only apply
scoped_with_init_fs() in kthread context.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/blocklayout/dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cc6327d97a91..eed960839608 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sunrpc/svc.h>
 #include <linux/blkdev.h>
+#include <linux/fs_struct.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_xdr.h>
@@ -363,21 +364,27 @@ static struct file *
 bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 {
 	struct file *bdev_file;
-	const char *devname;
+	const char *devname __free(kfree) = NULL;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
 			prefix, v->scsi.designator_len, v->scsi.designator);
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			bdev_file = bdev_file_open_by_path(devname,
+					BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
+	} else {
+		bdev_file = bdev_file_open_by_path(devname,
+				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	}
 	if (IS_ERR(bdev_file)) {
 		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
 	}
 
-	kfree(devname);
 	return bdev_file;
 }
 

-- 
2.47.3

