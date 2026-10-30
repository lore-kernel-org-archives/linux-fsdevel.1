Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376739;
	b=smXeEIAGq29k/sifRg97YG+gly7tnpktgwee536ggqkCX9EfKxH4lIUpVSRI+QLHWZUg
	 j/uXi/3363Xc2jX990iHe3nN0XnI9RgUjRo4An2XEmnL4CkZLhIfHuts4RggeZ19NKwGc
	 1rVpc6csZvcmi4iOxc9Q3VxnmVTA7RoNU6aVvJyVM+CWFgDBj7FzxEVegjYjJA0p9M72V
	 0hULHn851BrjAFiDkE+J4w7VySFkBOiqDuJgz8nvLcf6QnNnossR4JVpA6z/FqK3mS/Fx
	 FuhWSzqpwwWjdyXbifYxHXa9GRH/QhlwmV2DEESwFWn6QnTksnR58AWM29OUiLHCT9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376739;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2QuGO1Fv/5vUqUzsrgZeOLDOg1WpAWDskuYu88kf6GY=;
	b=nB8ZaTTK0YP0M4KoISMh+FaaOyWZDKD7nR+7WcPQXzhu5Xb4CovzNMMq6m0NRkr2RHtN
	 EHCzUx3F6OsFQLW+gHkByAv8i+lpsPTImhtU+pKiZFe6EYBsSYHIQDI8b/Z87+MtDJ/pQ
	 gIDah5UgSshN4lTU+CpsKCf3LMAfHhOQDF5dEjxe+IwOEzBS5c0yebTbPnWdKdJrjKnet
	 6WaxQVYbyq+Te7pitoORmkPu4iku7wkXLyCQd6aBXmXjB5PBbojFpftyqg2utIvj8O0t9
	 1YWGJqThMHkiCxgOZXXEmxMJUPUdPefBltIIafMdz+kotAFxmOksP2GssPeIQutf8uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chkNiqes;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF9606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chkNiqes
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707511F00A15;
	Fri, 30 Oct 2026 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376738;
	bh=2QuGO1Fv/5vUqUzsrgZeOLDOg1WpAWDskuYu88kf6GY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=chkNiqesfAfhxLd/8Tklt6MjCNk0bRWbxfww0fv08BxP8mLJAeFvmXuFvcXQyuoKt
	 Itd2lqYujX9myFg2liJrilXS7voOFl/RxGu07ZYelA+YdQ8kkuTJ1v9RZn526i6c+X
	 R/XsN/XMG2nQ/kokBPGAWLuaSzLCljbNgcc9de0n6tys44OD3YWAtvxeH0Vv/h/2xV
	 6/LyB5BY5hWrjp5wrw2Q2+laQzZc5Cnb2Av4KONESOpHl81OY3oNI8t4UxU7jXcSGV
	 sMj0O6FGDNU2N0J5nAz2C4TttM0iDyhztjPGptVSgrV1/OdGvbaF/MIdtJPPz2Rec9
	 rad6/XUzBUDwA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:53 +0100
Subject: [PATCH 1/7] proc: get the inode from the file instead of ->private
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
Message-Id: <20261030-work-procfs-ai-fixes-v1-1-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bwgKKUHMZ8YuKPnG2xDn02ssZl9UkRDNe07JmbuAbHA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXiX9ehGuS13JRe/1Ohn+C9b03lhXszOmUtavS+zf
 yie8O2IXEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEpvUxMmyTWO9UyMT2aPeE
 Pclped9d0x9/3r9sZfvWRNkTJb+/fihjZLh3m7l8I39b4U1zJcalcyofzTI6e8OzR7z78s1sB/u
 mQ8wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The fdinfo files and the ONE() files stash their inode in the seq_file's
->private. The seq_file points to the file anyway so get the inode from
there and free up ->private. The following patches need it.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c | 4 ++--
 fs/proc/fd.c   | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c9aebee0a338..2a9ad9e01047 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -781,7 +781,7 @@ static const struct inode_operations proc_def_inode_operations = {
 
 static int proc_single_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct pid *pid = proc_pid(inode);
 	struct task_struct *task;
@@ -799,7 +799,7 @@ static int proc_single_show(struct seq_file *m, void *v)
 
 static int proc_single_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, proc_single_show, inode);
+	return single_open(filp, proc_single_show, NULL);
 }
 
 static const struct file_operations proc_single_file_operations = {
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 7214a7495380..839c984e1699 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -22,19 +22,20 @@
 
 static int seq_show(struct seq_file *m, void *v)
 {
+	struct inode *inode = file_inode(m->file);
 	struct files_struct *files = NULL;
 	int f_flags = 0, ret = -ENOENT;
 	struct file *file = NULL;
 	struct task_struct *task;
 
-	task = get_proc_task(m->private);
+	task = get_proc_task(inode);
 	if (!task)
 		return -ENOENT;
 
 	task_lock(task);
 	files = task->files;
 	if (files) {
-		unsigned int fd = proc_fd(m->private);
+		unsigned int fd = proc_fd(inode);
 
 		spin_lock(&files->file_lock);
 		file = files_lookup_fd_locked(files, fd);
@@ -74,7 +75,7 @@ static int seq_show(struct seq_file *m, void *v)
 
 static int seq_fdinfo_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, seq_show, inode);
+	return single_open(file, seq_show, NULL);
 }
 
 /*

-- 
2.53.0

