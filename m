Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E0347BDC;
	Wed, 11 Mar 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266182; cv=none; b=IYN+F0Hv9AZD1+AWWdsxPYHcB6ntH+k0n1d6fe8AwNdzJKdumW26yCZfz8lTXkNQovJdMFb6Af2aSr/xqvSRuUwiUQ8DD8jE2GfxuByzmtOnSTwPXX/y61h7X3R6qVeNWftBN9nNIIq8IKYXoN5Q7Oc3qk6iXIylx6POkMoCzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266182; c=relaxed/simple;
	bh=j7e3iXOLmmu7kPvsU/SibJ+EPIB2J0TPHCvmtCZW1QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+tahGKyHWLWBh881maFy/coEd5v12MacxAmeD2TUkw8kEy9iZIoIs3QMTtVdLjFv8WFlMltNPev1cgehBfh3iENFOA2Fhh9d44VzyUI6B40ondWWrzmPvDlYOv4pcUbVxtDw8AQY/k55mR0VUhFTZvfKTd+T8AG3B+dX9bZ0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgqBDjn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgqBDjn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C21AC4CEF7;
	Wed, 11 Mar 2026 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266182;
	bh=j7e3iXOLmmu7kPvsU/SibJ+EPIB2J0TPHCvmtCZW1QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NgqBDjn+aBwucRwPLJiRR29A6ln0vdYesKJezje574G7EMzS29hAtqSn9aaFRAlhE
	 AyEc8UGm8C2k0b+d1Xgt5q8Es6yZqdu/FSlYL8IvaUkqQ4vE9q0kxfoQNGPHvnumR7
	 loJU1MOpcD7sZYYkoBvtaZ8bqxRtCA5UTYmxMMaAU4Et+ozDYIMHVo54QZZkpDF9FQ
	 78Vrg1y+4+kdH8ZPqOAq3e+0VXXuXKF9+/MZ9Q9fGmlQcYBNjgolXqB9DXuZRizj5A
	 rDBwb24C3fnOT/qYg3P7cfRqh5p4oZurzJVSK+W04mQDfNc8uGFtcQ1s9QUYA0Sycr
	 jm+1SJrPrrDOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:47 +0100
Subject: [PATCH RFC v3 04/26] fs: add real_fs to track task's actual
 fs_struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-4-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6818; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j7e3iXOLmmu7kPvsU/SibJ+EPIB2J0TPHCvmtCZW1QE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPKDWeMqQ2BztaOMGv8Ch6BD/YU5qvMT9xVNedpQz
 stxt6O1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ8axgZXuj8Vwzli2cv+Hs0
 +vpDtyXBtkF3ovQCopd0xZz0PXxvHsM/9bKs0r3X5v3bI2d5ZeXjHKH0trkP5n2+Gxz+gEFJ4+V
 yNgA=
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
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
index f447e734612a..10d792b8f170 100644
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
index 4c863d17dfb4..28067e77b820 100644
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
index a7b4a980eb2f..5c7b9df92ebb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1179,6 +1179,7 @@ struct task_struct {
 	unsigned long			last_switch_time;
 #endif
 	/* Filesystem information: */
+	struct fs_struct		*real_fs;
 	struct fs_struct		*fs;
 
 	/* Open file information: */
diff --git a/init/init_task.c b/init/init_task.c
index 5c838757fc10..7d0b4a5927eb 100644
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
index 67e57ee44548..154703cf7d3d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1593,6 +1593,8 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
+
+	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
@@ -1605,7 +1607,7 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 		read_sequnlock_excl(&fs->seq);
 		return 0;
 	}
-	tsk->fs = copy_fs_struct(fs);
+	tsk->real_fs = tsk->fs = copy_fs_struct(fs);
 	if (!tsk->fs)
 		return -ENOMEM;
 	return 0;
@@ -3152,6 +3154,10 @@ int ksys_unshare(unsigned long unshare_flags)
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

