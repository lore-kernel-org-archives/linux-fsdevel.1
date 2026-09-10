Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3636A009
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055305; cv=none; b=MuAJu0EoLH0fFIPoOm7EhT36Llbvwou+4v+LiEATLA8BSBv0RDX3hTpT7h4Co4xGDXuJWlVh6rFsGxL+y8ImD0s2Cuag12Q0byEVvd8CYm2TZm3E3i53utsMKJwLDsAbHeNduYsW165O/fPi/mFHyMNT91L7D8Q5SWoV5jd6yDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055305; c=relaxed/simple;
	bh=L4uQm3AHaciFi9JMN7GwKy7Gf9A45Rj5z+yX8TFtohY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAYbt8kbXVHU7ATolfoI7fvVVkrMHzCSjiqJQ2hxnMVAZvWblDGQZgiRtqUUcI4TV3IidpH5K70JxXvAYd8s/b75M1PHt/5VUqTrmmD7JrWlRkUkh4MUQSlxjqM2dinVetGW+26XHLnsRl3ZsO5xdaJ1HftVj8eTzipVozvTCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9vLG9gW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9vLG9gW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2E51F000FF;
	Thu, 10 Sep 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055304;
	bh=Kmuji/DP389UdP86YQtoCIbCt9/uDhAEGMzdtV40iJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O9vLG9gWhzOe2F+VD7xqrR2qZj+LJSOVMJh3ae1G4KV46xBOCMaA0q/DCmIFn3qLT
	 jpg/XqM7AF8JldfPMPKcJ9L/kn9Q50FQMlo/ba9ERG++tLjhMC1+2GJGi1BnexgkNn
	 JknnNUAnfIyZ1Bgh/TUx3+oUZmi0wOYNWC5iAvOR9YM0Gt/Z/wTbCmUCj3VFuKT+xn
	 kODkkxFg82+6+9DSgVCgiGEhuoXMZr1TmWJfa2ucHU1ULKUc+goiA7tVcvGWEBIyFM
	 8JkD108MvtMbePC6Q97wdwa6Lk9rdYQKPfIxlrJD3dz2ykHfAJKx5SKDy9EBxp/DtG
	 LuC8Ft7GB6H3A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:00 +0200
Subject: [PATCH RFC v4 02/18] fs: add switch_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-2-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2671; i=brauner@kernel.org;
 h=from:subject:message-id; bh=L4uQm3AHaciFi9JMN7GwKy7Gf9A45Rj5z+yX8TFtohY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumgbH8ajrrnS/MHLS+mGm1cyR6z5cIf3+P60w7tEF
 5ZxVYsqd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEU5bhrxTzc9lTrrMrct+p
 775RrKR+T1ztAP+37clnJ9vMerUq9jjDX5mZgub3mj/Im6RcvPhV8GmVjN3blnVNT8U/vt0zbYL
 hQxYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add switch_files_struct() to install another table on a task. It
consumes the reference to the new table and puts the old one. Convert
every place that switches a descriptor table except unshare_files().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 23 +++++++++++------------
 include/linux/fdtable.h |  1 +
 kernel/fork.c           |  6 ++----
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 59673547de90..345011dad472 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -515,16 +515,18 @@ void put_files_struct(struct files_struct *files)
 	}
 }
 
-void exit_files(struct task_struct *tsk)
+/* Install @files on @tsk, consuming the reference, and put the old table. */
+void switch_files_struct(struct task_struct *tsk, struct files_struct *files)
 {
-	struct files_struct * files = tsk->files;
+	scoped_guard(task_lock, tsk)
+		swap(tsk->files, files);
+	put_files_struct(files);
+}
 
-	if (files) {
-		task_lock(tsk);
-		tsk->files = NULL;
-		task_unlock(tsk);
-		put_files_struct(files);
-	}
+void exit_files(struct task_struct *tsk)
+{
+	if (tsk->files)
+		switch_files_struct(tsk, NULL);
 }
 
 struct files_struct init_files = {
@@ -855,10 +857,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		 * We're done closing the files we were supposed to. Time to install
 		 * the new file descriptor table and drop the old one.
 		 */
-		task_lock(me);
-		me->files = cur_fds;
-		task_unlock(me);
-		put_files_struct(fds);
+		switch_files_struct(me, cur_fds);
 	}
 
 	return 0;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..9614c6ecd477 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -100,6 +100,7 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
+void switch_files_struct(struct task_struct *tsk, struct files_struct *files);
 int unshare_files(void);
 struct fd_range {
 	unsigned int from, to;
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..7c6fe82dbb9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3320,10 +3320,8 @@ int ksys_unshare(unsigned long unshare_flags)
 		if (new_fs)
 			new_fs = switch_fs_struct(new_fs);
 
-		if (new_fd) {
-			guard(task_lock)(current);
-			swap(current->files, new_fd);
-		}
+		if (new_fd)
+			switch_files_struct(current, no_free_ptr(new_fd));
 
 		if (new_cred) {
 			/* Install the new user namespace */

-- 
2.53.0

