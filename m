Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376745;
	b=YK8oQAYlBCUeedRQ47jPAQ6gcS9ceZN8NyLITsyMG+oC9sqCSaeLsGmJV47rEQVeFoct
	 uZ1paKkOGG+Y2pucZrfyYR6Lj+Zhvz5JBcEHI4dZFUHy8eijEIxgSpP4NFiy2/PubQrVf
	 Cz89s7D9XGqHIk/2cQVtLXqoouhBfRD4g69a4gGQp3b6PIXMHGihi1VE6404jVYAzKAmG
	 IWTaPh476MsEyx4XmAgGgU+a3WkKuudPITruk5xJgq+3qNg1zdjjj9SZZ/xyUwnqbkrMo
	 jAB1hfiiA0CSld54XQefahxo07t0oM2Qxh5lQU6Di5O35VL7yYW3tai9q4A6HcJVeMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376745;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IzyhwGMXsG71FJnWnQlzO6FM49Libq0F1xZvn/S7G/A=;
	b=zGa+tX+F+YcD0p9gzFUmuPJzoIw41XMUHO3uT5AtDmrKSQ9wQgy+RWzOW7dXoeJU6rNo
	 gwPrlwtJDzcc4h9BgLve3bYRMWizxswm0jiwvyLueGc+EBTDtj/MLPzdkD7YvN3PqHnem
	 2vTWEqIM92GwMJ3w5P20EB4e0u7n4bvf2Pglw2ScViNGsact4nfmPiGC2oLUv10ru7Bc1
	 3GmWH4w1xjfqTc0bdsTyevGhIM5rGlfNLgpZCUN7W4Vnb1ovSckVZh+iA2BfYXoI8HaoE
	 ++5Rxc1lwRw6A8H4zJPuQ+uGFsU2Xf8lzEcnU9HG+YLkL+8PgTssfobsgc5S3nyHCuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULtJ12HB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF934606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULtJ12HB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9BA1F000C1;
	Fri, 30 Oct 2026 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376744;
	bh=IzyhwGMXsG71FJnWnQlzO6FM49Libq0F1xZvn/S7G/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ULtJ12HBq/dMGtR0p4PUxfqiJazPneHJ9F2N0tVm630LPwuS+bmiDGJNDEh40ZQy0
	 g6PQHGQ11mEVMcNBGQZzZA2xwfI/w1MdDV2Mcpou6q2kJZZzs0Cp+xCp/QBSPofbnl
	 G+IHg+/rQxww+vWXwLNGfnIvVphN4/EjyWvizf+a39JsnmO2pYyM75LQPjVMz/V9P2
	 GRFTcqcyq5oFIPIl2iw1Opo8zyozp/tnf6Jrs47XKVXo7kQBoTN8pizdD2dNng+1uP
	 5Q9gLPLIB/KelWMHyNc8W+QFDDfR2zI0XFu6ibD2Th1UhnMfi4jI+fexnmBLsBhq4e
	 s7YoQ5Wdgk9BA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:56 +0100
Subject: [PATCH 4/7] proc: stop the ksm files at a privileged execve()
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
Message-Id: <20261030-work-procfs-ai-fixes-v1-4-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4354; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ciZgIEJNr9PuuGSE7pdNkXe5YKS2i69+/A8ArpWR0Lk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXjX6fAWpblBlS8OLfHyOapw4f6jSexerBVCK8+Ze
 k9d1bSmp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi7sUM/xT/Pj3OzfK24ZNw
 Y88Sl3U8a//8exjwcItT9Z38hmNbYtoYGSY5KRq2eUseYqvZu/jwK2XBX1pWoffPZxvMe6HO0mz
 9jQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

/proc/<pid>/ksm_merging_pages and /proc/<pid>/ksm_stat can only be
opened by the owner of the task but they show the mm the task has at the
time of the read. So a file that was opened while the task ran as its
opener keeps working after it executed a set-user-ID program.

PR_SET_MEMORY_MERGE survives execve(). So the opener can have the
memory of the privileged program merged and find out how many of its
pages were merged with pages of known content, which is what the mode of
these files is supposed to prevent.

Use the exec id helpers and hold exec_update_lock until the mm has been
looked up. The files need their own file operations for that so the
exec id can live in ->private. Reading a file that was opened before an
execve() now fails with -EACCES if its opener has no access to the new
program.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 600cdbfdefac..57748b4ae806 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -182,6 +182,10 @@ struct pid_entry {
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
+#define ONE_EXEC(NAME, MODE, show)			\
+	NOD(NAME, (S_IFREG|(MODE)),			\
+		NULL, &proc_single_exec_file_operations,	\
+		{ .proc_show = show } )
 #define ATTR(LSMID, NAME, MODE)				\
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_pid_attr_operations,	\
@@ -3360,12 +3364,42 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 #endif /* CONFIG_LIVEPATCH */
 
 #ifdef CONFIG_KSM
+/* Like proc_single_file_operations, but the file keeps the exec id. */
+static int proc_single_exec_open(struct inode *inode, struct file *filp)
+{
+	return proc_exec_id_single_open(inode, filp, proc_single_show);
+}
+
+static const struct file_operations proc_single_exec_file_operations = {
+	.open		= proc_single_exec_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_exec_id_single_release,
+};
+
+/* get_task_mm(), unless the task now runs a program the opener can't see */
+static struct mm_struct *proc_single_exec_mm(struct seq_file *m,
+					     struct task_struct *task)
+{
+	struct mm_struct *mm;
+	int err;
+
+	err = proc_exec_id_lock(m->file, task, m->private);
+	if (err)
+		return ERR_PTR(err);
+	mm = get_task_mm(task);
+	proc_exec_id_unlock(task);
+	return mm;
+}
+
 static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
 	struct mm_struct *mm;
 
-	mm = get_task_mm(task);
+	mm = proc_single_exec_mm(m, task);
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
 	if (mm) {
 		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
 		mmput(mm);
@@ -3379,7 +3413,9 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 	struct mm_struct *mm;
 	int ret = 0;
 
-	mm = get_task_mm(task);
+	mm = proc_single_exec_mm(m, task);
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
 		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
@@ -3532,8 +3568,8 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
 #ifdef CONFIG_KSM
-	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
-	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
+	ONE_EXEC("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE_EXEC("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
 
@@ -3877,8 +3913,8 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
 #ifdef CONFIG_KSM
-	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
-	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
+	ONE_EXEC("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE_EXEC("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
 

-- 
2.53.0

