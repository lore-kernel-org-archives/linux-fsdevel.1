Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FF57D20B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969191; cv=none; b=fwk8kCx0IjkTb8IvyRXySWe5XOmKQaHG9DKEvbonNGdKbVSMbnRpkXTeKwWR/Til2MSapVNwDqkselAw2NqmZ31hZKTQCEg1lJdUkyYiUrK6xtqRnNXuVav+TVZLaZN1XUB94+FiPxu4neB+/BxlXmaOldGq6dtdC3jbSVPq7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969191; c=relaxed/simple;
	bh=yFQmHNZa2bcrlnLLif8ue9QY3y73DR3xpqoZUCZsfEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMT40ojGD+fbJEj9gW4xG/6zcMNJ+N0SswiSSgKjcd1qmn9JblfPeB3gjWFJN5xoGJvb4DyGL7mM+lnnfcBtGO/G14y+cvFi5h2IUaUyuNmQFExF7bFTSfzA9yZPWVDbH/nKf+sjtNW9X4oAXVIAT59pv1YZcLfzj+1dVcTEp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK3f0Ch9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK3f0Ch9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3764F1F00A3D;
	Wed,  9 Sep 2026 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969189;
	bh=DEkQFumPAsgoIhX1BfyQIT9KIKRJGyXr66vFqmpOyuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eK3f0Ch9jgV0xaXLSL8ku32G0VOUEL7qLQ5CS+cpJI7pPKlNPzhMxrGhN36sZlyB9
	 InM1MNQjGXrGctVYuXinNx1kZUQsQSwVHHri4W3eVHqYmMl9YGxTk83OIEDRTpmk7H
	 Vys54hnt+9Lr+wmbQH7Y2yo9jAjHozs+qX4plP3if36wJ5iVgWefBjkv3D8V9w168W
	 IRw/9ATjCI3C2+vZqhNKXQrwUegZak93Nt9Fufv6jRQtkDiFeK+1GkdnCYNil78+nR
	 Bkkglt0NqX0UgNrJA6Uo06RjBXSkxCw9dFiBLMd+kbCKW5lrgnJWvtJAJOMtCmYJzw
	 Stbb/rOY7A7fA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:47 +0200
Subject: [PATCH RFC v3 04/15] fs: remove unshare_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-4-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yFQmHNZa2bcrlnLLif8ue9QY3y73DR3xpqoZUCZsfEw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLi67PfeyNvvM1YebOo23K1yfXpLpapMUduyUCPf+
 cvu765c3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARfRVGhsd86e5ataq+G49u
 r7gv69wucnxPQc72b+bu0nyO3LZeYQx/pa4syHZvm5Kwa+3UST1SsiGKrjPFf98urft+YHtO7Nk
 oXgA=
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
index d3081c8f7c10..ae4702d7ae5f 100644
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
+		put_files_struct(switch_files_struct(me, files));
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 25af1386abbe..acd59e40b76b 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -102,7 +102,6 @@ struct task_struct;
 void put_files_struct(struct files_struct *fs);
 struct files_struct *switch_files_struct(struct task_struct *tsk,
 					 struct files_struct *files);
-int unshare_files(void);
 int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 struct fd_range {
 	unsigned int from, to;
diff --git a/kernel/fork.c b/kernel/fork.c
index c456958c51f4..ba74705ca191 100644
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

