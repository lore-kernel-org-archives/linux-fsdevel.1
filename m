Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0A3B4EA2;
	Mon,  1 Jun 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322229; cv=none; b=OExVovO9Mr+PyrbJmO3wkXEalXM2Y7EPRQd4TIf1inSQvIDoqgrKmU0lWWdQfaTg/YZ6iZ6fw/49Yzg/1WvN0ElWGtx3H3+3KJXbvy8Eh4KIdLKC595NEOV9aKdKbUc/P0n5YjMPrpJx5kkTtyWMK5dQFm2f/BxYKUET+V7wd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322229; c=relaxed/simple;
	bh=GXmZmaDyqvbsZCl8E2dHZtc+jpNESyMGkrgouGyxzIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4mA4pF6NVvNwGHrZB7SvwT/Pl77XedNUdj1BREJZBbPQG3scnyl4j/YxPXuuTGlO5ErCcWu2JNv66zT9mFD2U3aKt5rVTiQTd8Zg9x0M9m68+IHFYrMB1qU8JIxqwmadcYiE4DBgjRqoxkT8zOF3EYrZYVxf6KVmbcwyO1aqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWgXWXHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWgXWXHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA951F00898;
	Mon,  1 Jun 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322227;
	bh=F7kDxB3UIe0bG5dRVUn0Tz7gBFB3O3e9kA0wc1UNjjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AWgXWXHC7mt+iKQBL2fjuDlpV4oPX/DJWSn3udSlgdInBTrCpvxHZ/4NVpm9PDXzJ
	 AM4l5DaVjIM5EYazj5D7XTx+0PcyGA6cDBx2BwL4K/XjkRiISBcVCl9PatLkTu+XZD
	 h5mA79tdvf6G+wBZFHl5mmSqFuFMkUiPQXT1K5IiG5QMJmmssG4IMtTtNpCZY/QIwT
	 IqO68nhPJLg7ZyevJXKpDvxu/3oVyCXPvJjUJzh3FrLKg30C+6BukiSZb+5p43dOgL
	 I3NoZ6zqDouyLTsVE7je4puXzW1HSdtN7ORgO/qse1/iEo0Z+TleZUa5E+n69XTa3/
	 gccLJz8deOLfw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:38 +0200
Subject: [PATCH RFC v4 05/25] fs: make userspace_init_fs a
 dynamically-initialized pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-5-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6011; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GXmZmaDyqvbsZCl8E2dHZtc+jpNESyMGkrgouGyxzIg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8LD0rjuLlMYVp4beYaS93YuJd52xOlln262xF6I
 Nup9uCWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkf2Vk6JvFM+tB8Ba9Xdl7
 y5/s7mmTmSPMxxHVxm2xIO/E7fDdCowMa5Zv7jldc8T/bnvGprQlh+8+4XXcbf7Sr+VUg8NrfbH
 pLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Change userspace_init_fs from a declared-but-unused extern struct to
a dynamically initialized pointer. Add init_userspace_fs() which is
called early in kernel_init() (PID 1) to record PID 1's fs_struct
as the canonical userspace filesystem state.

Wire up __override_init_fs() and __revert_init_fs() to actually swap
current->fs to/from userspace_init_fs. Previously these were no-ops
that stored current->fs back to itself.

Fix nullfs_userspace_init() to compare against userspace_init_fs
instead of &init_fs. When PID 1 unshares its filesystem state, revert
userspace_init_fs to init_fs's root (nullfs) so that stale filesystem
state is not silently inherited by kworkers and usermodehelpers.

At this stage PID 1's fs still points to rootfs (set by
init_mount_tree), so userspace_init_fs points to rootfs and
scoped_with_init_fs() is functionally equivalent to its previous no-op
behavior.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c            | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs_struct.h | 15 ++++++++-------
 include/linux/init_task.h |  1 +
 init/main.c               |  3 +++
 4 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index c03a574ed65a..f44e43ce6d93 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -8,6 +8,7 @@
 #include <linux/fs_struct.h>
 #include <linux/init_task.h>
 #include "internal.h"
+#include "mount.h"
 
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
@@ -163,15 +164,34 @@ EXPORT_SYMBOL_GPL(unshare_fs_struct);
  * fs_struct state. Breaking that contract sucks for both sides.
  * So just don't bother with extra work for this. No sane init
  * system should ever do this.
+ *
+ * On older kernels if PID 1 unshared its filesystem state with us the
+ * kernel simply used the stale fs_struct state implicitly pinning
+ * anything that PID 1 had last used. Even if PID 1 might've moved on to
+ * some completely different fs_struct state and might've even unmounted
+ * the old root.
+ *
+ * This has hilarious consequences: Think continuing to dump coredump
+ * state into an implicitly pinned directory somewhere. Calling random
+ * binaries in the old rootfs via usermodehelpers.
+ *
+ * Be aggressive about this: We simply reject operating on stale
+ * fs_struct state by reverting to nullfs. Every kworker that does
+ * lookups after this point will fail. Every usermodehelper call will
+ * fail. Tough luck but let's be kind and emit a warning to userspace.
  */
 static inline void validate_fs_switch(struct fs_struct *old_fs)
 {
+	might_sleep();
+
 	if (likely(current->pid != 1))
 		return;
 	/* @old_fs may be dangling but for comparison it's fine */
-	if (old_fs != &init_fs)
+	if (old_fs != userspace_init_fs)
 		return;
 	pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
+	set_fs_root(userspace_init_fs, &init_fs.root);
+	set_fs_pwd(userspace_init_fs, &init_fs.root);
 }
 
 struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
@@ -201,3 +221,29 @@ struct fs_struct init_fs = {
 	.seq		= __SEQLOCK_UNLOCKED(init_fs.seq),
 	.umask		= 0022,
 };
+
+struct fs_struct *userspace_init_fs __ro_after_init;
+EXPORT_SYMBOL_GPL(userspace_init_fs);
+
+void __init init_userspace_fs(void)
+{
+	struct mount *m;
+	struct path root;
+
+	/* Move PID 1 from nullfs into the initramfs. */
+	m = topmost_overmount(current->nsproxy->mnt_ns->root);
+	root.mnt = &m->mnt;
+	root.dentry = root.mnt->mnt_root;
+
+	VFS_WARN_ON_ONCE(current->pid != 1);
+
+	set_fs_root(current->fs, &root);
+	set_fs_pwd(current->fs, &root);
+
+	/* Hold a reference for the global pointer. */
+	read_seqlock_excl(&current->fs->seq);
+	current->fs->users++;
+	read_sequnlock_excl(&current->fs->seq);
+
+	userspace_init_fs = current->fs;
+}
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index e11d0e57168f..97eef8d3863d 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -17,6 +17,7 @@ struct fs_struct {
 } __randomize_layout;
 
 extern struct kmem_cache *fs_cachep;
+extern struct fs_struct *userspace_init_fs;
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_root(struct fs_struct *, const struct path *);
@@ -57,17 +58,17 @@ static inline int current_umask(void)
  */
 static inline struct fs_struct *__override_init_fs(void)
 {
-	struct fs_struct *fs;
+	struct fs_struct *old_fs;
 
-	fs = current->fs;
-	WRITE_ONCE(current->fs, fs);
-	return fs;
+	old_fs = current->fs;
+	WRITE_ONCE(current->fs, userspace_init_fs);
+	return old_fs;
 }
 
-static inline void __revert_init_fs(struct fs_struct *revert_fs)
+static inline void __revert_init_fs(struct fs_struct *old_fs)
 {
-	VFS_WARN_ON_ONCE(current->fs != revert_fs);
-	WRITE_ONCE(current->fs, revert_fs);
+	VFS_WARN_ON_ONCE(current->fs != userspace_init_fs);
+	WRITE_ONCE(current->fs, old_fs);
 }
 
 DEFINE_CLASS(__override_init_fs,
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a6cb241ea00c..61536be773f5 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -24,6 +24,7 @@
 
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
+extern struct fs_struct *userspace_init_fs;
 extern struct nsproxy init_nsproxy;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/init/main.c b/init/main.c
index 96f93bb06c49..decfb0e03663 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,7 @@
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
+#include <linux/fs_struct.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
@@ -1585,6 +1586,8 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	init_userspace_fs();
+
 	/*
 	 * Wait until kthreadd is all set-up.
 	 */

-- 
2.47.3

