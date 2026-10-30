Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376741;
	b=qqWkcMoqD86em/8ul4EU5ce3yLbsOacU9P2r1hZoZjF5ExlwRdVHperS1TiC0ADjjx7V
	 V5XAhDVhKaZ3wa4tvMzB3ABbWkBXpMwFV6efEgwJeRK0CDin+4xth5xf2KBg8TpPzUvGg
	 DN2N0rCyarEMdYVa4VkcDEdbBJGGp09P95yo7HHp/SRTD6yxI7X+iZKOZE+i1wNT/PxQB
	 LvLUcWXEA8SrRVGUzgwc2ClrAujoNYIPCo9hLcSTuUyBsX/OGAycB50061ac8mqZDqSTu
	 U7jD7V1Dy/VvpgCNZU0h71WwRmzaDgN1XVEphOOrvOY4ZHJuJLMYJ+ka9bgSFhdrBYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376741;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q28whdxNmNB8fyAXCA0+4v4O7UXyWsUMAcihevRXn2A=;
	b=1OAQzmhMvrK3Gl9DydSDgVAXCFhbJa9/512m8Ce57MCEL8+ozqc1pPqUAoQ1Wd2kHlkP
	 zU0XjtpoN8E4G50vnk7B7U2Z3gMJJZ06K4UhAHPbAnWbcEGBxAvBYS/v79Z3gCcvkttq2
	 4bXgnllJbMDV4WXh81EKX1DzPuD8OCmQfKIthK2GkLdRihAY9/KC8ytbbhKrs8meyrP5q
	 7PH4xmVsE6ipERU2r6/lmg5/sH5nww3gsmpRpdFmmunRhgt2W+bvSNq3fPcOsjMCP7znz
	 9y+z655Ddtk4MalAtHw+60RDnXQGYBf4Rr8Id33d/snVBPtNQe+ViYIisF/ajzcVUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQe3uzxU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6E606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQe3uzxU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E11D1F000C1;
	Fri, 30 Oct 2026 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376740;
	bh=q28whdxNmNB8fyAXCA0+4v4O7UXyWsUMAcihevRXn2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YQe3uzxUdQKUTMlmcjAw1mtMmm12nmhLzogw8/R4sk2PpmmOoCVaXs1mmUQxBnoDz
	 IXiYA3FJsO34bHCR4QJPLSCLg+2YbLG//hQuI8lm5z3dEp6Xcjbyz2TsWoXhrSWYld
	 BwEc9YIW6Xcvm7Qs7kV4Qobsr9WUNSCXgriJFCeUge8jsW0LmLgHJNhYmnd5n7xJDK
	 czjbKaq/4US+W/k1sS18AaJ6pPCXdL2v57vYtw3B74q6xNQY/B1JUcOMp8FnOhXbI4
	 DR34cW1Y//oWi5A0qeNpDyUn8nBJuGGtXGXjEfnuyAqSK4f+jS6olfC7ctfnrO12Qg
	 fnaCCmrIfHpjA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:54 +0100
Subject: [PATCH 2/7] proc: add helpers for files that outlive an execve()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-procfs-ai-fixes-v1-2-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7046; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nrGpRH5BtVbTdIgasp4kxqXGjtgOYYQ8wlWi+k19L1Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXiXc4G8m//Di9ODfijnrJa157m4p2letqRwSNeWl
 g6PTxZtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5FsjwP4vhpHdaW/K85PvW
 GxRjE+Nunt0+xXd6x0SJ2AX7WPbqnGP4n92W9phh7dFJm0y6crM/VUxTbJsqtqYnaqepndJ3W79
 dXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Some files in /proc/<pid> check access to the task when they are opened
but look at the task whenever they are read. Such a file keeps working
after the task has executed a set-user-ID program and then shows the
state of a program that its opener has no access to.

Checking again with the credentials of the reader on every read would
break readers for which nothing changed, e.g. a reader that dropped its
privileges after it opened the file or that got the file from a more
privileged process. And it turns a privileged reader into a confused
deputy. An unprivileged opener hands the file to a set-user-ID program,
e.g. as stdin, and that program reads what its opener isn't allowed to
see.

So go by the opener and only once the program has changed:

- proc_exec_id_open() remembers the task's ->self_exec_id when the file
  is opened. The permission check of the open may have seen the previous
  program so it's repeated with exec_update_lock held.

- proc_exec_id_lock() takes exec_update_lock for reading and compares.
  If the task executed another program since, the file only keeps
  working if its opener would be allowed to open it now. If so, the file
  is as good as opened again and we remember the new program.

The task's own threads take no lock. de_thread() waits until all threads
but the one that calls execve() are gone before exec_update_lock is
taken so they can't see the program change. That's /proc/self, i.e.
nearly all users.

No user yet.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c     | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/internal.h |   8 ++++
 2 files changed, 145 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2a9ad9e01047..600cdbfdefac 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2036,6 +2036,143 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
 	security_task_to_inode(task, inode);
 }
 
+/*
+ * For files that check access when they're opened but look at the task whenever
+ * they're used. ->self_exec_id names the program: execve() bumps it under
+ * exec_update_lock and all threads share it, also the two that de_thread()
+ * swaps the pid between, so it doesn't matter which task get_proc_task()
+ * returns.
+ */
+
+/* Would the opener of @file be allowed to open it now? */
+static int proc_exec_id_permission(const struct file *file,
+				   struct task_struct *task)
+{
+	struct inode *inode = file_inode(file);
+	int mask = 0;
+
+	if (file->f_mode & FMODE_READ)
+		mask |= MAY_READ;
+	if (file->f_mode & FMODE_WRITE)
+		mask |= MAY_WRITE;
+
+	pid_update_inode(task, inode);
+	scoped_with_creds(file->f_cred)
+		return inode_permission(&nop_mnt_idmap, inode, mask);
+}
+
+/* For ->open(). ->permission() ran without exec_update_lock, so check again. */
+static u64 *proc_exec_id_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task __free(put_task) = NULL;
+	u64 *exec_id __free(kfree) = NULL;
+	int err;
+
+	exec_id = kzalloc_obj(*exec_id, GFP_KERNEL_ACCOUNT);
+	if (!exec_id)
+		return ERR_PTR(-ENOMEM);
+
+	/* The file won't find the task either, it never comes back. */
+	task = get_proc_task(inode);
+	if (!task)
+		return no_free_ptr(exec_id);
+
+	/* See proc_exec_id_lock(). */
+	if (same_thread_group(task, current)) {
+		*exec_id = task->self_exec_id;
+		return no_free_ptr(exec_id);
+	}
+
+	err = down_read_killable(&task->signal->exec_update_lock);
+	if (err)
+		return ERR_PTR(err);
+	*exec_id = task->self_exec_id;
+	err = proc_exec_id_permission(file, task);
+	up_read(&task->signal->exec_update_lock);
+	if (err)
+		return ERR_PTR(err);
+	return no_free_ptr(exec_id);
+}
+
+int proc_exec_id_single_open(struct inode *inode, struct file *file,
+			     int (*show)(struct seq_file *, void *))
+{
+	u64 *exec_id __free(kfree) = NULL;
+	int err;
+
+	exec_id = proc_exec_id_open(inode, file);
+	if (IS_ERR(exec_id))
+		return PTR_ERR(exec_id);
+
+	err = single_open(file, show, exec_id);
+	if (err)
+		return err;
+
+	retain_and_null_ptr(exec_id);
+	return 0;
+}
+
+int proc_exec_id_single_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+
+	kfree(m->private);
+	return single_release(inode, file);
+}
+
+int proc_exec_id_dir_open(struct inode *inode, struct file *file)
+{
+	u64 *exec_id = proc_exec_id_open(inode, file);
+
+	if (IS_ERR(exec_id))
+		return PTR_ERR(exec_id);
+
+	file->private_data = exec_id;
+	return 0;
+}
+
+int proc_exec_id_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+/*
+ * Pins the task's program until proc_exec_id_unlock(). If it changed since the
+ * open, the file only keeps working if its opener would be allowed to open it
+ * now. Whoever uses the file doesn't count. Our own threads need no lock,
+ * de_thread() waits for them before exec_update_lock is taken.
+ */
+int proc_exec_id_lock(const struct file *file, struct task_struct *task,
+		      u64 *exec_id)
+{
+	int err;
+
+	if (!same_thread_group(task, current)) {
+		err = down_read_killable(&task->signal->exec_update_lock);
+		if (err)
+			return err;
+	}
+
+	if (task->self_exec_id == READ_ONCE(*exec_id))
+		return 0;
+
+	err = proc_exec_id_permission(file, task);
+	if (err) {
+		proc_exec_id_unlock(task);
+		return err;
+	}
+
+	WRITE_ONCE(*exec_id, task->self_exec_id);
+	return 0;
+}
+
+void proc_exec_id_unlock(struct task_struct *task)
+{
+	if (!same_thread_group(task, current))
+		up_read(&task->signal->exec_update_lock);
+}
+
 /*
  * Rewrite the inode's ownerships here because the owning task may have
  * performed a setuid(), etc.
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index df873df9afc5..67d9e965162c 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -265,6 +265,14 @@ int proc_nochmod_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern void pid_update_inode(struct task_struct *, struct inode *);
+int proc_exec_id_single_open(struct inode *inode, struct file *file,
+			     int (*show)(struct seq_file *, void *));
+int proc_exec_id_single_release(struct inode *inode, struct file *file);
+int proc_exec_id_dir_open(struct inode *inode, struct file *file);
+int proc_exec_id_dir_release(struct inode *inode, struct file *file);
+int proc_exec_id_lock(const struct file *file, struct task_struct *task,
+		      u64 *exec_id);
+void proc_exec_id_unlock(struct task_struct *task);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
 struct dentry *proc_pid_lookup(struct dentry *, unsigned int);

-- 
2.53.0

