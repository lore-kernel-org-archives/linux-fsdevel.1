Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDC3B3C06;
	Mon,  1 Jun 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322227; cv=none; b=NWFJlT2qtFGuiHF9lUh6kYoJSlp74Hml2DqjSDk1W/iJ4+16nEFhRbviiQ9bUleYRGpTfIwBrn93J4f2TV2hrynmslTlMZazTiwoQ+2SdYzs4F3J/LXYiGxoFWMkegg0dNIMqCpPOMU5DryXwyYbSsDlWmgOtKHs0poo4HfKe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322227; c=relaxed/simple;
	bh=AKYRjOqMRK/wG9j9r/7wmXSlPiTMO8Vc+f+BjxObbm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkJO0gDL7DrlxVgmacdTdvX4CqUvXc6cUPq2txtd0PJoz8QBJ6Z1P86ERxVyXJAJiYBIwn6oSlNlzsN5HAXYns3GfZ2Jn8FwSg3sxcm1vRTMGHi6kkpx+i0wy5FBiZRuPinWzdbYHm69vEhiHhVB6PSJx0LiD9PNwyoOG2Ipp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSp8kMOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSp8kMOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDCB1F00893;
	Mon,  1 Jun 2026 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322225;
	bh=LQJF7BixTWRY2HuYf9e2bI/X2zgv8m+tTTBh7WEfjkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BSp8kMOtfvnNyrAZuJX12OH2rrlpcanCBrhpAXgvTSuiql86nx9EofsgN9it77WfF
	 L6VixZQtZR2y7qpzy4HMkmhlbqfWZEOOdA1+IXc1B3GkmF6G9aDc0qbO2Y4YmCUeRh
	 eeMaB10LYpap/JYsE++xDDzyV+MkeOIg3LGDOCKdaCGWYweZV2JJxEdQMl0ga2X46w
	 /skZlvkNBR6US4JVqie8aA5xlPZGYzavJ+PF2Nu6dzVAvcAW9ukew/Xg0KSLUg6JcD
	 I+2t7Jf36WQvNfMYFSAnPugEs5HhJkAcm1VcCrJJV7zUiUjCpsiz/MSNTYN/S9fyJg
	 UzDlNiEROOQbg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:37 +0200
Subject: [PATCH RFC v4 04/25] fs: add real_fs to track task's actual
 fs_struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-4-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AKYRjOqMRK/wG9j9r/7wmXSlPiTMO8Vc+f+BjxObbm4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i9jeL3eUGO5yJc0y9zSkwku28+8Mb3unqlirVVxR
 jR+yibtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQ3h4hSAiRy9wciw4eCViydcHwmdKA39
 VeB/fIqs+aP+Mx7N1a/LKyVjjgglMPwPKp3lbXZ2vsI3oY7Te4Lso3hv+Fscz/Woufbl5aufYS9
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a real_fs field to task_struct that always mirrors the fs field.
This lays the groundwork for distinguishing between a task's permanent
fs_struct and one that is temporarily overridden via scoped_with_init_fs().

When a kthread temporarily overrides current->fs for path lookup, we
need to know the original fs_struct for operations like exit_fs() and
unshare_fs_struct() that must operate on the real, permanent fs.

For now real_fs is always equal to fs. It is maintained alongside fs in
all the relevant paths: exit_fs(), unshare_fs_struct(),
switch_fs_struct(), and copy_fs().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c        | 11 ++++++++---
 fs/proc/array.c       |  4 ++--
 fs/proc/base.c        |  8 ++++----
 fs/proc_namespace.c   |  4 ++--
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  8 +++++++-
 kernel/kcmp.c         |  2 +-
 8 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index fcecf209f1a9..c03a574ed65a 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,7 +61,7 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
 		task_lock(p);
-		fs = p->fs;
+		fs = p->real_fs;
 		if (fs) {
 			int hits = 0;
 			write_seqlock(&fs->seq);
@@ -89,12 +89,13 @@ void free_fs_struct(struct fs_struct *fs)
 
 void exit_fs(struct task_struct *tsk)
 {
-	struct fs_struct *fs = tsk->fs;
+	struct fs_struct *fs = tsk->real_fs;
 
 	if (fs) {
 		int kill;
 		task_lock(tsk);
 		read_seqlock_excl(&fs->seq);
+		tsk->real_fs = NULL;
 		tsk->fs = NULL;
 		kill = !--fs->users;
 		read_sequnlock_excl(&fs->seq);
@@ -126,7 +127,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 
 int unshare_fs_struct(void)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs = current->real_fs;
 	struct fs_struct *new_fs = copy_fs_struct(fs);
 	int kill;
 
@@ -135,8 +136,10 @@ int unshare_fs_struct(void)
 
 	task_lock(current);
 	read_seqlock_excl(&fs->seq);
+	VFS_WARN_ON_ONCE(fs != current->fs);
 	kill = !--fs->users;
 	current->fs = new_fs;
+	current->real_fs = new_fs;
 	read_sequnlock_excl(&fs->seq);
 	task_unlock(current);
 
@@ -177,8 +180,10 @@ struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
 
 	scoped_guard(task_lock, current) {
 		fs = current->fs;
+		VFS_WARN_ON_ONCE(fs != current->real_fs);
 		read_seqlock_excl(&fs->seq);
 		current->fs = new_fs;
+		current->real_fs = new_fs;
 		if (--fs->users)
 			new_fs = NULL;
 		else
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 90fb0c6b5f99..109bc49f0a80 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -168,8 +168,8 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	cred = get_task_cred(p);
 
 	task_lock(p);
-	if (p->fs)
-		umask = p->fs->umask;
+	if (p->real_fs)
+		umask = p->real_fs->umask;
 	if (p->files)
 		max_fds = files_fdtable(p->files)->max_fds;
 	task_unlock(p);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..d756f977cb89 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -210,8 +210,8 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	int result = -ENOENT;
 
 	task_lock(task);
-	if (task->fs) {
-		get_fs_root(task->fs, root);
+	if (task->real_fs) {
+		get_fs_root(task->real_fs, root);
 		result = 0;
 	}
 	task_unlock(task);
@@ -225,8 +225,8 @@ static int proc_cwd_link(struct dentry *dentry, struct path *path)
 
 	if (task) {
 		task_lock(task);
-		if (task->fs) {
-			get_fs_pwd(task->fs, path);
+		if (task->real_fs) {
+			get_fs_pwd(task->real_fs, path);
 			result = 0;
 		}
 		task_unlock(task);
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 5c555db68aa2..036356c0a55b 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -254,13 +254,13 @@ static int mounts_open_common(struct inode *inode, struct file *file,
 	}
 	ns = nsp->mnt_ns;
 	get_mnt_ns(ns);
-	if (!task->fs) {
+	if (!task->real_fs) {
 		task_unlock(task);
 		put_task_struct(task);
 		ret = -ENOENT;
 		goto err_put_ns;
 	}
-	get_fs_root(task->fs, &root);
+	get_fs_root(task->real_fs, &root);
 	task_unlock(task);
 	put_task_struct(task);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 368c7b4d7cb5..c82b3b47121b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,7 @@ struct task_struct {
 	unsigned long			last_switch_time;
 #endif
 	/* Filesystem information: */
+	struct fs_struct		*real_fs;
 	struct fs_struct		*fs;
 
 	/* Open file information: */
diff --git a/init/init_task.c b/init/init_task.c
index b5f48ebdc2b6..2a7789dc2464 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -152,6 +152,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	RCU_POINTER_INITIALIZER(cred, &init_cred),
 	.comm		= INIT_TASK_COMM,
 	.thread		= INIT_THREAD,
+	.real_fs	= &init_fs,
 	.fs		= &init_fs,
 	.files		= &init_files,
 #ifdef CONFIG_IO_URING
diff --git a/kernel/fork.c b/kernel/fork.c
index 846a49088fae..bf153b2929d4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1596,6 +1596,8 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
+
+	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
@@ -1608,7 +1610,7 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 		read_sequnlock_excl(&fs->seq);
 		return 0;
 	}
-	tsk->fs = copy_fs_struct(fs);
+	tsk->real_fs = tsk->fs = copy_fs_struct(fs);
 	if (!tsk->fs)
 		return -ENOMEM;
 	return 0;
@@ -3223,6 +3225,10 @@ int ksys_unshare(unsigned long unshare_flags)
 	if (unshare_flags & CLONE_NEWNS)
 		unshare_flags |= CLONE_FS;
 
+	/* No unsharing with overriden fs state */
+	VFS_WARN_ON_ONCE(unshare_flags & (CLONE_NEWNS | CLONE_FS) &&
+			 current->fs != current->real_fs);
+
 	err = check_unshare_flags(unshare_flags);
 	if (err)
 		goto bad_unshare_out;
diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 7c1a65bd5f8d..76476aeee067 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -186,7 +186,7 @@ SYSCALL_DEFINE5(kcmp, pid_t, pid1, pid_t, pid2, int, type,
 		ret = kcmp_ptr(task1->files, task2->files, KCMP_FILES);
 		break;
 	case KCMP_FS:
-		ret = kcmp_ptr(task1->fs, task2->fs, KCMP_FS);
+		ret = kcmp_ptr(task1->real_fs, task2->real_fs, KCMP_FS);
 		break;
 	case KCMP_SIGHAND:
 		ret = kcmp_ptr(task1->sighand, task2->sighand, KCMP_SIGHAND);

-- 
2.47.3

