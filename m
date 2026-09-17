Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9D4E1C88;
	Thu, 17 Sep 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646864; cv=none; b=A17KEeE8EtZbFFmXV4yVdbFHgc2Swqyiq303J0quBDuJM6pkuYlw2opoNn/QXjE0b1bc+MjlXKc4zyQ0qmOGMnZnoZQqV6f448PylwhQnwrM7Y8zdvdkQM8dWIJVrajCC20T2upMo5NHqnOGKMFvRSyc5N4rVGz5S2VAKwBYd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646864; c=relaxed/simple;
	bh=c8tD0lS9s775XHUm8X8GiBymBT1XGdd+cjg+vokAayE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJBKwUAsEVm7HKRjy3JY1sVOYhOAobLtY1V61bTOFys7TmgT4jyvT/ADLvIm76y97FSm7jnBPL6FwrqVndZR3K/sARndzIBL71WE0Saw5ySEaT508FleF5uzCcciMWu10/sgUTv7MIlvH4orncCaIfYm9Ek2i/GRdtiLaWNr5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K58NCglN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K58NCglN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556061F00893;
	Thu, 17 Sep 2026 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646847;
	bh=iMer4Wj/tXsJyZhOk2Q/evNupOvB9rMxehBb5u+wCF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K58NCglN8CbhU0YFU/xGV5wF/HIlHlNiyeYVNTFK33M5Fs4s3vzwQ08I4ZNLA6PVr
	 4cbjY96BXua8KKYTAZtCmWseSTHYGSEQfBY8JR4YN1rxQcVPVlfuJq4k9rXSZNzKB6
	 UTlBP9gkl8bAixKFD4EXN9jeGfVVFc+KkSZtZuU7qpi4MhfsncHNzmfNNhiXemc5T2
	 hHjhcKrel70KJyudXWN7q31VeARLc8gwn1GsxlQ/19tvo8BDYIrWHVrkWJ7LZMFcTu
	 KAlF/8t2dQCAaf/pUcyuPlzrEvKkoqf3/vtCaaoWnp+F5EuE9dNjxfpTp7+/FLw68X
	 U2MJJ6Aym8Tng==
Date: Thu, 17 Sep 2026 14:07:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v4 23/25] fs: start all kthreads in nullfs
Message-ID: <20260917-atemtechnik-bleichen-befassen-9a57db01baf0@brauner>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
 <20260601-work-kthread-nullfs-v4-23-77ee053060e0@kernel.org>
 <15174353-3f4a-a1ca-5bd1-ea2a4c77828e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m5zqlu75hgmbkw4c"
Content-Disposition: inline
In-Reply-To: <15174353-3f4a-a1ca-5bd1-ea2a4c77828e@huawei.com>


--m5zqlu75hgmbkw4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> The following lockdep splat can be triggered on mainline, which is built
> with arm64's defconfig plus
> 
> 	CONFIG_SHRINKER_DEBUG
> 	CONFIG_PROVE_LOCKING
> 	CONFIG_FTRACE
> 
> .  Reverting this patch (as pointed out by AI) makes this warn disappear.

This is benign and caused by holding LOCK_MOUNT_EXACT() for longer than
necessary. I'm adding the appended fix to vfs.fixes.

--m5zqlu75hgmbkw4c
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-don-t-create-the-private-nullfs-mount-under-names.patch"

From a6bd269dceeb76f92d5e8d378fed2482dd208085 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 13:20:25 +0200
Subject: [PATCH] fs: don't create the private nullfs mount under namespace_sem

init_mount_tree() mounts the mutable rootfs on top of nullfs via
LOCK_MOUNT_EXACT(). That declares a pinned mountpoint with a cleanup
attribute in the scope of the whole function so the nullfs root inode
lock and namespace_sem are only dropped when init_mount_tree() returns.

This became a problem when the private nullfs instance for kthreads was
added. kern_mount() allocates a new superblock and alloc_super() takes
the new s_umount with SINGLE_DEPTH_NESTING and then shrinker_mutex via
shrinker_alloc(). Doing that with namespace_sem held teaches lockdep the
dependency

    namespace_sem -> s_umount/1 -> shrinker_mutex

With CONFIG_SHRINKER_DEBUG shrinker_debugfs_rename() takes the debugfs
directory inode lock under shrinker_mutex every time a block device is
mounted and lock_mount_exact() takes namespace_sem under the inode lock
of the mountpoint for every mount. So mounting anything on debugfs,
e.g. the tracefs automount on /sys/kernel/debug/tracing, closes the
cycle:

    WARNING: possible circular locking dependency detected
    7.3.0-rc3+ #17 Not tainted
    ------------------------------------------------------
    rasdaemon/4449 is trying to acquire lock:
    (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x4c/0x308

    but task is already holding lock:
    (&sb->s_type->i_mutex_key#17){++++}-{4:4}, at: lock_mount_exact+0x3c/0x308

    which lock already depends on the new lock.
    ...
    Chain exists of:
      namespace_sem --> shrinker_mutex --> &sb->s_type->i_mutex_key#17

This can't actually deadlock. init_mount_tree() runs single-threaded
during early boot before any other task exists and nothing allocates a
superblock under namespace_sem after that. But lockdep can't know that
and disables itself for the rest of the boot.

Move mounting the rootfs on top of nullfs into a helper so the locks
are dropped when it returns.

Fixes: 32750c77e811 ("fs: start all kthreads in nullfs")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Closes: https://lore.kernel.org/15174353-3f4a-a1ca-5bd1-ea2a4c77828e@huawei.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ae5dc64f8b45..5e41021eaa63 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6184,6 +6184,21 @@ struct mnt_namespace init_mnt_ns = {
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
 };
 
+static void __init mount_rootfs_on_nullfs(struct vfsmount *mnt,
+					  struct vfsmount *nullfs_mnt)
+{
+	struct path root = {
+		.mnt	= nullfs_mnt,
+		.dentry	= nullfs_mnt->mnt_root,
+	};
+
+	LOCK_MOUNT_EXACT(mp, &root);
+	if (unlikely(IS_ERR(mp.parent)))
+		panic("VFS: Failed to mount rootfs on nullfs");
+	scoped_guard(mount_writer)
+		attach_mnt(real_mount(mnt), mp.parent, mp.mp);
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt, *nullfs_mnt;
@@ -6215,15 +6230,7 @@ static void __init init_mount_tree(void)
 	mnt_root		= real_mount(nullfs_mnt);
 	init_mnt_ns.root	= mnt_root;
 
-	/* Mount mutable rootfs on top of nullfs. */
-	root.mnt		= nullfs_mnt;
-	root.dentry		= nullfs_mnt->mnt_root;
-
-	LOCK_MOUNT_EXACT(mp, &root);
-	if (unlikely(IS_ERR(mp.parent)))
-		panic("VFS: Failed to mount rootfs on nullfs");
-	scoped_guard(mount_writer)
-		attach_mnt(real_mount(mnt), mp.parent, mp.mp);
+	mount_rootfs_on_nullfs(mnt, nullfs_mnt);
 
 	pr_info("VFS: Finished mounting rootfs on nullfs\n");
 
-- 
2.53.0


--m5zqlu75hgmbkw4c--
