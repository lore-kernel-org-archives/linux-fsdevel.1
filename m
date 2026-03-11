Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F62FFF8F;
	Wed, 11 Mar 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266209; cv=none; b=GF3oUFS6k/yKHHGQDOnuSCv8Wr6dCnupwI7EQ5slZtyPPcednJJQYJHlD5CUmEG9H4DzeFMG84ORsUQTKwcTHvNV0pYq/ScIh3uRdmz82nDPAGU706m9xYS8HPku5nMRYRV+IguRXW1o6ft1lhDEsGB9FgxqCj8VBYGc50ZQ+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266209; c=relaxed/simple;
	bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3vyA/RWlF+7nagkZZUzeaOdhlyiGH8fyL0ulVlppagSEenEyWtdDFx716PLQTSNhSGyhzMAnjlr1Bc8mdytI/HNMut2ZBY7r2p030MU1Gyp9TP8SOxJohi0qtUAFErpOPhrxLytnX1k62yR3AoyBg10M+9S+q4G5dvIDEynBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBqUNdbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBqUNdbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFC1C19425;
	Wed, 11 Mar 2026 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266209;
	bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WBqUNdbUP+eSSqeWnUJG7pVi6qXE+L1hb4RuJfr51ki9y6HCUJay9eOtfkWxnsG9f
	 9iNXLq4JnudTFxxFhuTYdRvspnIRVEmvR/im6ZsUGmRteOiQ7SCZB+vKEq5+BOFBlk
	 fHYu4s7U4DsiikhE5cX4rfRJCkjKpjAvN8iIDINRf9MJMpcJb/OtI9ohPxw7+JBhlN
	 dGsIWtyNV7gbgk1wOTnj95+QGx3Wf+FDcai4yTfZXlw3xfchlVtrkJ1/O9yN8g+NRG
	 aBRzwtlLptxKN+hkUBljHWNrdDFe8siAubdmFU5q+zy/LwFwEbMhU9JHAzWA5/cLMQ
	 tjYbLCnM1+avw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:58 +0100
Subject: [PATCH RFC v3 15/26] ksmbd: use scoped_with_init_fs() for VFS path
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-15-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wU9SxeJzZju+/xFBYvuJFjoOiP1dhPkfgSD6zYZdtUQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPKz6aLnT91nu7/sjDmxlclxfYfg/GNFrv6N2X7B0
 afzLr7711HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRuB2MDNuSpj9srPtb7JGy
 45jq7JR7YS+qimdv3XQ3Raslu5Tjvwsjw9ScNG+Gkqq7v55OVfP6rBsh8/mYm97pvhnyGQsYqjc
 c4gQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
path lookups in ksmbd VFS helpers:
- ksmbd_vfs_path_lookup(): wrap vfs_path_parent_lookup()
- ksmbd_vfs_link(): wrap kern_path() for old path resolution
- ksmbd_vfs_kern_path_create(): wrap start_creating_path()

This ensures path lookups happen in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/vfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d08973b288e5..4b537e169160 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -7,6 +7,7 @@
 #include <crypto/sha2.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
@@ -67,9 +68,10 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	}
 
 	CLASS(filename_kernel, filename)(pathname);
-	err = vfs_path_parent_lookup(filename, flags,
-				     path, &last, &type,
-				     root_share_path);
+	scoped_with_init_fs()
+		err = vfs_path_parent_lookup(filename, flags,
+					     path, &last, &type,
+					     root_share_path);
 	if (err)
 		return err;
 
@@ -622,7 +624,8 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
+	scoped_with_init_fs()
+		err = kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
 	if (err) {
 		pr_err("cannot get linux path for %s, err = %d\n",
 		       oldname, err);
@@ -1258,7 +1261,8 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 	if (!abs_name)
 		return ERR_PTR(-ENOMEM);
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
+	scoped_with_init_fs()
+		dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
 	kfree(abs_name);
 	return dent;
 }

-- 
2.47.3

