Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CE3B3896;
	Mon,  1 Jun 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322250; cv=none; b=mxZpSGRYuYrYMO/aEj/Xq3CIGq5J0Gf7WgQclHIdMe6+93OOR39UtLBZKyAu78ElcaPHfBSv50Pa1qmJBq1/bSFF2q/YjXnUyC2XAoDlshrgsw4v3pD4dzajGZhE2/0jqhgvM2ukK680gTSJlDdga5J5BMvhCkp/PnJumAdipFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322250; c=relaxed/simple;
	bh=Grydw4x8Ke//YE15y0WkXMklOEmweeKcNmOt4JFeLK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVLhkaZNuurRF7ZSBZmjUkNtbR4Hvayfgl0La4IG+ANJ2LEo304LdxwTUl9zU4san598VGP3IMT7NCyP9cfcGIefocHavkluiqqimXxRR+qJ9gv5uneyEvxTlt98289pARv8IehmiIVUCk0kPcVVWUKk3B7COt2x7NOsuJBi6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ScqYdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ScqYdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476841F00898;
	Mon,  1 Jun 2026 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322248;
	bh=8O4ZTY/NTjt4fbjh0EfsbH6niG12r7rm1DSpAxfm9TY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g5ScqYdLFcfhazFlX4Kz0zUOWKrVB8ee6J/urHQZvhfOLN/hZaq1p16vPnO6z30rt
	 kP1C7dfBjg70TNCTmN++XmDhqdRJVFrlugil+SHHwSIcnlLCG5Cxr848/RIrfKTdGH
	 q1VjN1/BJVV0dPCis73XTLLXtX3zqA3H9Aze/BES2ukmcSCwbxvC08Yy6vhmLLhMdF
	 2xlhXVwCLiwe730IRsEFMAINMOpe1Mgbl57X45nfCt8QwNbcBhPC2tJmEyg8O7PZNv
	 7nwDmYHy2cLSSXellxvuxj6jcXS0AEXpqRKwaW67Ho8DsEFQArGVSQuDwunYvl1vnu
	 Db17twSkC/bdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:48 +0200
Subject: [PATCH RFC v4 15/25] ksmbd: use scoped_with_init_fs() for VFS path
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-15-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Grydw4x8Ke//YE15y0WkXMklOEmweeKcNmOt4JFeLK4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i+b5pDxk1PndTf39l0rdZiq5Oa8X/h0W/66/Z9v7
 JsUur0guqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAisv6MDH9m/Vauy1Vm1LNc
 XZB0RVk5c+HsyitzNzkeq/nH4SDI1MfIsHHpV2E9Fu63Zw2C0pr9OoPmpF1ZeS0nb/ei9wEMnZd
 EeQE=
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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

