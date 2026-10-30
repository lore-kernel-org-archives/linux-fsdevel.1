Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376747;
	b=JtOISg4j+0Rx7lMeNBrhFOZiZfXMkr6SkamJtHkaOeLemp3KXvqjlmwUAnffwheRXy4v
	 iR2GuzFOZoNU4rjSd+CdRtN8moFK7z1sbpSp626Rn+qpshAKLAR80mMA24jrzcL9zTiq/
	 /dMdt0q+WlJSFS0HwzV4ZCEEch4nLb0b0NwgYqVIFZzxJfnl77p0ibPf+J7pzmLZsx5mO
	 8HSvXyA9vC1THOCqW+FxR5Y9+KxhoC1pRmmMssH0SVtynWUMZejSn7Sw0S2MuBEhTHa7a
	 bN5X8Tko81Bh0MItX57cLeDfmHZkvlivJBstRJfJ/wlxzstKo0ubRs+uQLdTAwpRu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376747;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dWgVwP7MDJPGLWG9lp6I+wfLhLo9grh2atvO9wRf1yE=;
	b=mgG1gtgrvfqA0wHGm7UMdN8BKhXObs6X/rZFPXrT5+GsYIc/k6TGKfuYNJIOBEBjs9Tv
	 xrcWb0TP70xVMLrRxCkRHR6dodttJ7iw6MOTaiyFkCn7yepcSe4AJfuH3IZsxXy1kMO6p
	 oPVWWVYaZLY7zgfmNRW/z4VOCttGAxAnq8vHjBct+bv4biyT2XvCKdyBVD+fNZlZwSrH1
	 MW3tuv+M6zbuVAiUXkADwiju9ABSPIy+s7K5+tVDtb2biJ0eHUW49ia45L5U8WSRyE9fF
	 rkPAk5Ws8ZLQfPL5CK1prq6A+NnOofr6SVlY23o0nLVH3IgkItg2+OqOHy+jWGMy8SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3upVNSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57E606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3upVNSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C6F1F0093A;
	Fri, 30 Oct 2026 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376746;
	bh=dWgVwP7MDJPGLWG9lp6I+wfLhLo9grh2atvO9wRf1yE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l3upVNSjKpLX4T8PRsiTe8hEu57AmxD+Ipex5+3giEGwsfyWVPVo0CwmMm13P4bhJ
	 L8JogxuNtaI83N1bTWJ89RtmSz1/MwGcItHscKrroHDJpvsb0lx9M67h46GqWLuDQs
	 QKsUhCYNctlPYQAa0u5ViJZvU0/mprGaRFsMM0sKxgeJbmdcIQvtEysFLyq6vpuMBz
	 oTtQlnBvFr9yNwHOXbIfxbs73nd2AQs0GnypCW3D4HIwnoc646mtrUlspgOt2ZG7Sa
	 HuzjUm/vmZARAsJaoXIUylqA7n3IBYEEGDik00QPq61vi8iHrSIkkRrjDGBQ89n0dq
	 pCvqHKm4+P+NA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:57 +0100
Subject: [PATCH 5/7] proc: stop fd directories at a privileged execve()
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
Message-Id: <20261030-work-procfs-ai-fixes-v1-5-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SXqGYp4p9I1NWgJ+HuSJY+wYFIHKTsI2/B7+wraarHQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXj33K4VNzrnppnNu/2FwX6vyu2Pgephu899zXl/z
 MPxt8DLjo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3DnK8M+6YWadnlbm2bUW
 lZdm5T49XnXpi/wHT2+J+C0XQ0tuiEszMiyXUFBqPsRYnHCpXuDSSw2Pq2+Tlre+u74pY/3546k
 cq/kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

/proc/<pid>/fd can only be opened by the owner of the task and
/proc/<pid>/fdinfo only with PTRACE_MODE_READ. But once open the
directory lists the task's descriptors for as long as it lives, also
after it executed a set-user-ID program.

Use the exec id helpers. A single check at the start of getdents() isn't
enough. The entries are copied to userspace while the file table is
walked and the caller decides how long that takes. With a buffer backed
by userfaultfd he can sleep in the first copy until the task has
executed the other program and then read its file table. Holding
exec_update_lock across the copies isn't an option either because then
the reader blocks the execve(). So take it around every
fget_task_next() instead.

All this tells is which descriptors a set-user-ID program has open and
how, so there's not much at stake. But there's no reason to allow it
either.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Jann Horn <jannh@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/fd.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index e13015a17898..2d51344267ee 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -249,17 +249,33 @@ static struct dentry *proc_lookupfd_common(struct inode *dir,
 	return result;
 }
 
+/* fget_task_next(), unless the task now runs a program the opener can't see */
+static struct file *proc_fd_next(struct file *file, struct task_struct *task,
+				 unsigned int *fd)
+{
+	struct file *f;
+	int err;
+
+	err = proc_exec_id_lock(file, task, file->private_data);
+	if (err)
+		return ERR_PTR(err);
+	f = fget_task_next(task, fd);
+	proc_exec_id_unlock(task);
+	return f;
+}
+
 static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			      instantiate_t instantiate)
 {
-	struct task_struct *p = get_proc_task(file_inode(file));
+	struct task_struct *p __free(put_task) = NULL;
 	unsigned int fd;
 
+	p = get_proc_task(file_inode(file));
 	if (!p)
 		return -ENOENT;
 
 	if (!dir_emit_dots(file, ctx))
-		goto out;
+		return 0;
 
 	for (fd = ctx->pos - 2;; fd++) {
 		struct file *f;
@@ -267,10 +283,13 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		char name[10 + 1];
 		unsigned int len;
 
-		f = fget_task_next(p, &fd);
+		/* Don't hold off execve() across the copy to userspace. */
+		f = proc_fd_next(file, p, &fd);
+		if (IS_ERR(f))
+			return PTR_ERR(f);
 		ctx->pos = fd + 2LL;
 		if (!f)
-			break;
+			return 0;
 		data.mode = f->f_mode;
 		fput(f);
 		data.fd = fd;
@@ -279,12 +298,9 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		if (!proc_fill_cache(file, ctx,
 				     name, len, instantiate, p,
 				     &data))
-			break;
+			return 0;
 		cond_resched();
 	}
-out:
-	put_task_struct(p);
-	return 0;
 }
 
 static int proc_readfd_count(struct inode *inode, loff_t *count)
@@ -317,6 +333,8 @@ static int proc_fd_iterate(struct file *file, struct dir_context *ctx)
 }
 
 const struct file_operations proc_fd_operations = {
+	.open		= proc_exec_id_dir_open,
+	.release	= proc_exec_id_dir_release,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_fd_iterate,
 	.llseek		= generic_file_llseek,
@@ -410,6 +428,8 @@ const struct inode_operations proc_fdinfo_inode_operations = {
 };
 
 const struct file_operations proc_fdinfo_operations = {
+	.open		= proc_exec_id_dir_open,
+	.release	= proc_exec_id_dir_release,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_fdinfo_iterate,
 	.llseek		= generic_file_llseek,

-- 
2.53.0

