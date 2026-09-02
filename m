Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AE4AA022
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364739; cv=none; b=lHhdUc6rIHMxGR6kCyOT1EtVT7twI8WWkft8y17t/cJ8GBL0d0hFqZHg4K1sD5isAOD0RBIuI0IpWj/J5tjPGtu1EwBx9nEw4B10TWfFmuhbCweTmMLKCZdMu1W2w+sFXVaJWWwnfDqz5oTJpkfuEA1av/4fXR7Njcm828NQ05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364739; c=relaxed/simple;
	bh=jIHv4DI33pD5ShjZSS1o09aTWJbvrwk7CRx+nNcm++o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiARYBdcUyZCpJGu3fVww2fkbbDi7XaHyHdwjn6KrwYDlOZ8Ind0XUQpJfCk+J31SPWeuDNU4I00Sl49e22QRWPplIKEr383+yJU6qWciaRo/kPYQI3KgIepgvdFYNRI2xzOItpHF8/IqeJMT8m6L7gJTF6724jG75x8sOzkkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNNCgF+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNNCgF+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F11F00A3A;
	Wed,  2 Sep 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364737;
	bh=UPt6bxc8RU2Yba6Udlto8X8tTD8pplxYXTtvNYv+CtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RNNCgF+PSViWaJ+jbot7UbUkBxr7za5Cru9MJp28cEzpw3gRmX2EDOuElBMu5D9Dg
	 cHg0Gb+RLUTCQzPBSTWz1oT2X5l3AWZqX3lOi+L23Uzn/LE7uOzII89HeKoidZrNKB
	 f5qsYz+pdR/VNEG3aVB9b3k0q8ZA8yUgrE/8O6Lk+fNCGR+OJ7+T0vAl3iPIgoEJ16
	 c2vp96y68kalgaioEHvU0T8LXrkNfp4EjOl1kxt1zI2s9SjMkfjnh7at7/4sh9DLPp
	 97OqrI+P4j9s7hhlHtwDsKh8SW2K5HPZqrSYlXKagrSmKA8zTRVYifxCjFJOe1y5aX
	 q0w9U1u2s5tng==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:25 +0200
Subject: [PATCH RFC v2 07/16] fs: remove unshare_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-7-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jIHv4DI33pD5ShjZSS1o09aTWJbvrwk7CRx+nNcm++o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/Bv1rhj4nU5TKzUol3c6ZvZfP+4TPZe05zjt2cq
 2IelfkMHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJ/87wT2uF/9qG+df/C8fK
 XDFOMLU+7PZaP8pLrHrjjZQ/m35+lmP4pynMVTax27j5ttzqkJoJsxWa865zHdzxZXZjC8fLtWy
 L+AA=
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
index b1f449dba258..713819244d23 100644
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
 	 * Must be called _before_ exec_mmap() as bprm->mm is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 102fe4c20b7d..15ee6292e0e3 100644
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

