Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EE358391;
	Wed, 11 Mar 2026 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266185; cv=none; b=d8dzB/MmKpLrT/5DH5+kkfar9lkMKSnFq5JaAt0vsG/Nm6q844M6p9QhH/Boo2TJEnIG5NeecF7dnnRVt5tFcz26dD3AJcKog4ePRtUVklf78W6KX7wNQD+Hdzx4uXlO/u0COqII4km2eI+iz/K+W0X3DznnosFP2Nli+cvfj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266185; c=relaxed/simple;
	bh=B0NYuzCQAj5Kjb+OWFqH1w8NZrUFILRd9e7nO/6Q1Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcDmE7hElxmSAOTdFzrdvsdNRqAieyriTviW1DGh8EUwEUzi87wDBc8e8A3hO4mtmY7YFuMOAYRkyJRsMnNpx1haNGC3Dg7aE1G69ab+bod/NymSnRt6I5+BJq4/OAO7kv4ZU48yWvRWCanl2RNKs5GJ2SfWRUC3MKD9D8Q71TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQV0omNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQV0omNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6BAC19425;
	Wed, 11 Mar 2026 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266184;
	bh=B0NYuzCQAj5Kjb+OWFqH1w8NZrUFILRd9e7nO/6Q1Ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XQV0omNUuZI1XYykhvNavz2oHXVZADm0YN55T275eVLrWwJqHscPrvzRw/zAmapmT
	 KsEXgSaWptvTSoqTfzoz+MHmXssm3SSfh3ISSLKofhTsaYtdSnfa5TkLXOuOl82VTD
	 vRZXqZ7EnbzfzOzXSvn0jSwJxvIbM0t/f7XkDRpHgma0oYwne0y+MQPSffQ0h4h3Gp
	 hwBfsCQqoSiI9HzANt12w94N428rfesRIFWpu2Nb8l7lHn5yJm4nTB1ZJ67DT7WZwv
	 TDxcLtRO67FO5y91OvvXX7QBqpl27Vz7lGpo1mXR08uWFuD/lD7oyDowN95hd1kL1g
	 vclgK5j+H1tWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:48 +0100
Subject: [PATCH RFC v3 05/26] fs: make userspace_init_fs a
 dynamically-initialized pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-5-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B0NYuzCQAj5Kjb+OWFqH1w8NZrUFILRd9e7nO/6Q1Ts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJj5vnJjG8uvXJXWBnhe+FhyfN5Sve3fmg8rRmuZ
 rjVwe7Zno5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJfElh+CvWpBsjNvfRSqHn
 Pi6mZnX1p9N7laeyPlyr6vMkvXHn6lsMPxltQ4VMPRRjipfNvaHeudY33qW28p1fJbtBpt2dqRd
 eMwEA
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
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
index 1cb395dd94e4..5ccc642a5aa7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,7 @@
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
+#include <linux/fs_struct.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
@@ -1574,6 +1575,8 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	init_userspace_fs();
+
 	/*
 	 * Wait until kthreadd is all set-up.
 	 */

-- 
2.47.3

