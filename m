Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248683BFAFB;
	Mon,  1 Jun 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322252; cv=none; b=ntKndbwdPi8qaID/eK3wltKh96/fYCa2EABmU50iio9zNu2+Kol48ZQiWZOZncY1c90yqRPbuJzpkMSieP0UgmwlqzMyC2vS3X2vazhbqNSG9TZ0SL6iE7A7re/uy7KJPtWXOAD8l2rU5dEPQH1rv228hvOxqc+gXHBnMKvc5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322252; c=relaxed/simple;
	bh=ufJ1YTglO5I2g9L8vVkoH6XMY3QO/wDhk+KA6W0l8mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2B+sYOEyOu8woBdbEW39HpWV1DjbYcUJi9uI1QDYA5EPOCu+XsZ7tM9BunJ4+O1e0e9mX247zMRNYi+/ma1DIz8udJ4HOXPZ/oRzP6LIqCgX3mUNEo5/5k33Fb/d0PQpaPM/YNrMC3SZW4Jx/CcMmiSdhreSQZkCnTwVHUH6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZI62gpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZI62gpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B81F00893;
	Mon,  1 Jun 2026 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322251;
	bh=f7OKwl2EguFkoh7sinqojlFlIm4hSBh/VNQmlGFvRoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hZI62gplzHTHWB5RZScyE+pOk7JvJN1b4Fid19cvJ5SfIbwMjv6kF5nbi8Ian1/Ok
	 9+/X/gPzr5gVOETYcqMysrZozW04UtZt+4IiHyPGrk/Tn7X9+nip3nzbW5GkHkMBaP
	 0XdojFuvegRwhxlZ54Msd67ypkHp3QHsoDI4glmOjMgp/KAniKve596fXiWQMYsijd
	 9fnSLbVCy1p8wZxSVfbx5dZ5S4RRs8ezUopOuJgb4FZ/Tp+eOzfLmbICnlBv7YNmwZ
	 xXz9OjjEfW4Uybjyd20P7OewMHTWQS8s0oWgCzaBFB4SAt081t3Vg9emk1n2JoTNIE
	 WAhF99h7d8f6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:49 +0200
Subject: [PATCH RFC v4 16/25] pnfs/blocklayout: use scoped_with_init_fs()
 for SCSI device lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-16-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3378; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ufJ1YTglO5I2g9L8vVkoH6XMY3QO/wDhk+KA6W0l8mk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i+LCi43szvS4LJNdfbXXUJMzCWrilu3z7iVZWlYc
 naeYNSzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksqGJk+PyVo2HrM1850+NJ
 4pMfpqvpvqr5lHqxcXKc3NsyNsX254wMzyoecHkaM65Nzny9WfRy9MuUKw9Wxq8sF2HqbHnTVF7
 OBwA=
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfs/blocklayout/dev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index bb35f88501ce..368d20daf67b 100644
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
@@ -363,15 +364,22 @@ static struct file *
 bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 {
 	struct file *bdev_file;
-	const char *devname;
+	const char *devname __free(kfree) = NULL;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
 			prefix, v->scsi.designator_len, v->scsi.designator);
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_file = bdev_file_open_by_path(devname,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			bdev_file = bdev_file_open_by_path(devname,
+					BLK_OPEN_READ | BLK_OPEN_WRITE,
+					NULL, NULL);
+	} else {
+		bdev_file = bdev_file_open_by_path(devname,
+				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	}
 	if (IS_ERR(bdev_file)) {
 		dprintk("failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
@@ -380,7 +388,6 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 			file_bdev(bdev_file)->bd_disk->disk_name);
 	}
 
-	kfree(devname);
 	return bdev_file;
 }
 

-- 
2.47.3

