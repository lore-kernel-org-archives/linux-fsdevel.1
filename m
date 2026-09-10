Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE736A009
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055311; cv=none; b=ARr4a2D6GqgYHIbQY7DDfkUDQfCk4g07jCHRA609aduYSiPgAq0HKa7756G1LROcA6XuHYeZYQXfcRRRoFDuQ7n85yV9M9NKFfiz70Jed1wdBfDiWVjSbDQBVTZWIC440HrxhA529aoPaXrLaaiSB9Hz8GpPxM+/s1jZKPOvg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055311; c=relaxed/simple;
	bh=V5VbIHc0IDsx9vtz7pzYj5fjxUopDXRgMA0V1Qg4sYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLYM9n42SBgUTnpE9lA8/QE7oQlQt3kxkRP4NUcl+So9zmu4NUYHYm7/pQO03sSHkVwvaZ0eJ3L+uF4KTdB7JxgpG1e8bulQIKYOA7LY4kmk4OcVmqjk7YA8+ZG/f6Tp+q+QWmW778zNRPbwyUEP6mpsz0U/rxK1DQVAG+3NeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lquu4hiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lquu4hiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30561F000FF;
	Thu, 10 Sep 2026 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055310;
	bh=UXiKhst5+a0tC9X7oyy4b1hWK+AgwdMlq2XepH/qMaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lquu4hiWYHxyU5BQ8F+QyHy9ewxIIGnzar5//B/rsq5+3sA5Ea5T1JwkDxOyCkmd0
	 cS8i2ipACvfXCfYCr+R6o8kBa+3TlwxxIVG33xM/orbx9nms6z4Cib+fYMQj1dtCEr
	 8GiMFOLm2AtxtlnminmRXU78L+01QuRlz4TGw33rfZytj1fUHE8pKFvaRA/0KTwMS9
	 4aYoySv7eTMwzq8JulD2Ye6ZAJRk0kxpyOa0A23JK+eOQ6lxEpBgAHDVlfsY+CP8v4
	 DmCco+porItGyJtCEhSd4gBgzJB0hkcYc7O3m+Ip9NK8K3QIpatIMvIas9tEQxQCSr
	 g+y7sAr5cAvEg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:02 +0200
Subject: [PATCH RFC v4 04/18] fs: remove unshare_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-4-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V5VbIHc0IDsx9vtz7pzYj5fjxUopDXRgMA0V1Qg4sYs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumj70lRpR8Ie78bIx2k9i9q8n+lyGZevYpqz1GJ9p
 vz92/f1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayUZ2R4cfnXyJG4r3nZzQc
 eXXifcFjredb/m1a46NhUx67b1XnVg6G/zn+7uafmzg/NyVU9P0JPcJ4/8nVm28Z/GoTE9YffyO
 0gAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exec is the only caller left since commit 433967cab51e ("coredump: stop
unsharing the file descriptor table"). All it does is call unshare_fd()
with CLONE_FILES and install the copy. Kill the pointless helper and
open-code it.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               |  5 ++++-
 include/linux/fdtable.h |  1 -
 kernel/fork.c           | 24 ------------------------
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d3081c8f7c10..977778f44cfc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1124,6 +1124,7 @@ static struct file *bprm_identity_file(const struct linux_binprm *bprm)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
+	struct files_struct *files = NULL;
 	int retval;
 
 	/* A pending PT_INTERP substitution this format cannot consume. */
@@ -1160,9 +1161,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	io_uring_task_cancel();
 
 	/* Ensure the files table is not shared. */
-	retval = unshare_files();
+	retval = unshare_fd(CLONE_FILES, &files);
 	if (retval)
 		goto out;
+	if (files)
+		switch_files_struct(me, files);
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 4ee1598848bb..666808a1caf5 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -101,7 +101,6 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 void switch_files_struct(struct task_struct *tsk, struct files_struct *files);
-int unshare_files(void);
 int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 struct fd_range {
 	unsigned int from, to;
diff --git a/kernel/fork.c b/kernel/fork.c
index fddba55bbc14..300cb46bc51e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3336,30 +3336,6 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
 	return ksys_unshare(unshare_flags);
 }
 
-/*
- *	Helper to unshare the files of the current task.
- *	We don't want to expose copy_files internals to
- *	the exec layer of the kernel.
- */
-
-int unshare_files(void)
-{
-	struct task_struct *task = current;
-	struct files_struct *old, *copy = NULL;
-	int error;
-
-	error = unshare_fd(CLONE_FILES, &copy);
-	if (error || !copy)
-		return error;
-
-	old = task->files;
-	task_lock(task);
-	task->files = copy;
-	task_unlock(task);
-	put_files_struct(old);
-	return 0;
-}
-
 static int sysctl_max_threads(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {

-- 
2.53.0

