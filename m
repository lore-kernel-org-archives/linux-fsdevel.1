Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177F3AFCE3;
	Mon,  1 Jun 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322267; cv=none; b=BmK+G3gA1rBa35Y4rSLRrOTnvCQWCGQ6R8RGTqKnEBLeLgEQndlVCJNppimekAsIAOHpiV3+PdqatetQFf5nIb9q/6AxGzYnOlP017NR9XVwavAF+V7Z+YhkD0K2F5b17RlgviRJMui9Wj20YKgVy2TrpzzjnnEOOedAnvE0uf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322267; c=relaxed/simple;
	bh=MYNO8igEEy4pRIGZyjYHhL4cRXiZMddZoNch1b2IC5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVXWxR1KHr292+RVJOFQ+cTNpG1bWcw2wq/rONgGTCC1cxqIG5b4Qe8Qutj02QYUdfeSRmHZwZ294YbJ8GK41diX8dmVRBnGKFt0GJumXy5WFpM/svPVrBFP7hZqPPA7TD7aAFC0TEfjYIhXENd6HwBKLsmnKZOhJ4rMznpKZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrFSeIT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrFSeIT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C661F00898;
	Mon,  1 Jun 2026 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322266;
	bh=iD6KyvqK8Yaq4jXyCOL8KAEvMvA4FfnrgOINzDSdd+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BrFSeIT7Qi9EqzIOB5Walg0i7OOZFRjE/YTKklnkV+2L+SpiGWyTRqTwuC8wizqj0
	 wUo5bMw2eXbAD9MNA48XANANp3bZY801LgagoX/R/E0jEovaoouP2zCNaUsBO+NWkd
	 njmCokscYh1tVg59gp7CLWh9PMBQRUojUw4ezdl+6JsEo/+9wc3b9y9nhogUczwkhv
	 oqUuu8hL5IhXIlUUXPmspFHjbq1KelLcKzd3/M++3uqMzH4BOcSXTI9uE6IEZtITjm
	 g2bya+p+kcrOg4oX07h2nPTPClP8HG+MjAlNj4z+Oo7WaqQf/LS8T3qpNqCKMNjFOi
	 /xC3+IbG27ECA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:56 +0200
Subject: [PATCH RFC v4 23/25] fs: start all kthreads in nullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-23-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MYNO8igEEy4pRIGZyjYHhL4cRXiZMddZoNch1b2IC5M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8XbdE3NwqZcfz8rq87jOxP3/QwLHpTv3yze9iBJ
 +zHp+xp7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhItiQjw+WIg2lLTevmrstl
 fXGac028bN4JHibu7YZzTJwbFPes/c7IcME2ftU1+0+7Ni9d/uv1tqV7G3MePZG5bvmZ989cEXG
 eLdwA
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..43ca4838d451 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6173,12 +6173,14 @@ static void __init init_mount_tree(void)
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
@@ -6218,12 +6220,14 @@ static void __init init_mount_tree(void)
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

