Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921D39184E;
	Wed, 11 Mar 2026 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266230; cv=none; b=nkDkINpdrOAUVfBAISZu9tLujvP76tnOcYKU//VdSc59fl/AsVri9tb66KtErX2w1H9yPa5GRUkrj9Eq89f5aOZeItsL6DqRsu3mH+vIgTgPN5wks5ve4DIcc5PoKJWKUPGLahjZKHYMHfnyU+KHnkU3UEIPBj3UjmemKZY1CEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266230; c=relaxed/simple;
	bh=0vVqDulfALAa2ZKGEfk6GsJGjbD9gDlPR8IXvd/Me5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PltMeyJY+GtBKCkKacuZzbwggr08HRJkdNbh3w3n6/nR7jVmQzUP+WGpHuLm0A9N7WTk6TALgyQyMB/OxLodbhiFJND38dUmDdYmbg6POl7MjW7mdvqGPFAqklW72I7my5GzamATSuqiQWVRYnaYGynQ6BcyRb8gEs0bulu6CFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCPEixEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCPEixEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC42C4CEF7;
	Wed, 11 Mar 2026 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266230;
	bh=0vVqDulfALAa2ZKGEfk6GsJGjbD9gDlPR8IXvd/Me5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rCPEixEajOBtnHExxSSbSuskldE2eHG8P13Rs+3polFfiAkEyPueTqdU4QrixCqHP
	 kXsm6Eb9HHg/lhvxfOKT2X05Ryu0B1/LPrUdt0jro/z3saEXgKQxxpo2Yicjn6RGc9
	 zO/vmSyBF29njl8/ENL1fNOLB+8FpPbU7C4ghrWumVGss6orPe2QtGw6cCwWQTyJXX
	 3odLtmIlPV4IZt0Last6dJv5Y17oEI4/saKoK7Vpgov44lvc5IWYRzFcgMEJDmcBoW
	 mLxN8ovfaCgzenbHjlzlxCWT4U/sREZH9FGdA+dCvedigCxRIw2bOq/EaW3R0U/zmP
	 fw6R3aBzjdA/w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:07 +0100
Subject: [PATCH RFC v3 24/26] fs: start all kthreads in nullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-24-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0vVqDulfALAa2ZKGEfk6GsJGjbD9gDlPR8IXvd/Me5s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPLzqtjj+7+FPgrXTZH41H7wYji7EyPP8/6QwM7kg
 kDVz/45HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpFmD4Z+0kxvLagTHhf/Iz
 YaWct4/fm5jH/F1yhiGG+fqLAFkNG0aGRTHX/zNc7ni3KWahxka+ryZ3L/3/yWmXceralnWC2Zv
 qWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Point init_task's fs_struct (root and pwd) at a private nullfs instance
instead of the mutable rootfs. All kthreads now start isolated in nullfs
and must use scoped_with_init_fs() for any path resolution.

PID 1 is moved from nullfs into the initramfs by init_userspace_fs().
Usermodehelper threads use userspace_init_fs via the umh flag in
copy_fs(). All subsystems that need init's filesystem state for path
resolution already use scoped_with_init_fs() from earlier commits in
this series.

This isolates kthreads from userspace filesystem state and makes it
hard to perform filesystem operations from kthread context.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e23d2fa7e255..5d318e2e1e4a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6143,12 +6143,14 @@ static void __init init_mount_tree(void)
 	struct path root;
 
 	/*
-	 * We create two mounts:
+	 * We create three mounts:
 	 *
 	 * (1) nullfs with mount id 1
 	 * (2) mutable rootfs with mount id 2
+	 * (3) private nullfs for kthreads (SB_KERNMOUNT)
 	 *
-	 * with (2) mounted on top of (1).
+	 * with (2) mounted on top of (1). The init_task's root and pwd
+	 * are pointed at (3) so all kthreads start isolated in nullfs.
 	 */
 	nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
 	if (IS_ERR(nullfs_mnt))
@@ -6188,12 +6190,14 @@ static void __init init_mount_tree(void)
 		init_mnt_ns.nr_mounts++;
 	}
 
+	nullfs_mnt = kern_mount(&nullfs_fs_type);
+	if (IS_ERR(nullfs_mnt))
+		panic("VFS: Failed to create private nullfs instance");
+	root.mnt	= nullfs_mnt;
+	root.dentry	= nullfs_mnt->mnt_root;
+
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);
-
-	/* The root and pwd always point to the mutable rootfs. */
-	root.mnt	= mnt;
-	root.dentry	= mnt->mnt_root;
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 

-- 
2.47.3

